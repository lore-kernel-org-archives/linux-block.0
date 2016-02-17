Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Feb 2016 12:45:36 -0500
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling
 and cgroups support
Message-ID: <20160217171525.GX3741@mtj.duckdns.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
 <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
 <20160211222824.GD3741@mtj.duckdns.org>
 <87934440-FAA0-4B2D-897F-AD78EAF5F54E@linaro.org>
 <20160217171404.GW3741@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="H+4ONPRPur6+Ovig"
In-Reply-To: <20160217171404.GW3741@mtj.duckdns.org>
List-ID: <linux-block@vger.kernel.org>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, again.

I forgot to cc the source code for the following.

> A-2. test-rawio.c $DEV 8 16

It's a simple program which issues random IOs to the raw device.  The
above will issue 16 concurrent 4k IOs.

Thanks.

-- 
tejun

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test-rawio.c"

#define _GNU_SOURCE
#define _FILE_OFFSET_BITS 64

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <ctype.h>
#include <unistd.h>
#include <inttypes.h>
#include <sys/ioctl.h>
#include <signal.h>
#include <pthread.h>
#include <time.h>
#include <string.h>
#include <sys/time.h>

#include <sys/user.h>
#include <linux/fs.h>

static int dev_fd, blocks_per_rq, concurrency, do_write;
static int block_size;
static uint64_t device_size, nr_blocks;

static int exiting, nr_exited;

static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
static uint64_t *dispenser_ar;
static unsigned nr_succeeded, nr_failed;

static void sigexit_handler(int dummy)
{
	exiting = 1;
}

static uint64_t dispense_block(int idx)
{
	while (1) {
		uint64_t block;
		int i;
		block = ((uint64_t)random() << 31 | random())
			% (nr_blocks - blocks_per_rq + 1);
		for (i = 0; i < concurrency; i++) {
			if (block + blocks_per_rq > dispenser_ar[i] &&
			    block < dispenser_ar[i] + blocks_per_rq)
				break;
		}
		if (i == concurrency) {
			dispenser_ar[idx] = block;
			return block;
		}
	}
}

static void * do_rawio(void *arg)
{
	int idx = (int)(unsigned long)arg, my_exiting = 0, i;
	size_t bufsz = blocks_per_rq * block_size;
	char *rbuf, *wbuf;
	uint64_t block;
	ssize_t ret;

	if ((rbuf = malloc(bufsz + PAGE_SIZE)) == NULL ||
	    (do_write && (wbuf = malloc(bufsz + PAGE_SIZE)) == NULL)) {
		perror("malloc");
		exit(1);
	}

	rbuf = (void *)((unsigned long)(rbuf + PAGE_SIZE-1) & ~(PAGE_SIZE-1));
	wbuf = (void *)((unsigned long)(wbuf + PAGE_SIZE-1) & ~(PAGE_SIZE-1));

	if (do_write)
		for (i = 0; i < bufsz / sizeof(int); i++)
			wbuf[i] = idx + i;

	pthread_mutex_lock(&mutex);
 again:
	if (exiting || my_exiting) {
		nr_exited++;
		pthread_mutex_unlock(&mutex);
		return NULL;
	}
	block = dispense_block(idx);
	pthread_mutex_unlock(&mutex);

	if (do_write) {
		ret = pwrite(dev_fd, wbuf, bufsz, block * block_size);
		if (ret != bufsz) {
			fprintf(stderr, "\rThread %02d: write failed on "
				"block %"PRIu64" ret=%zd errno=%d wbuf=%p\n",
				idx, block, ret, errno, wbuf);
			goto failed;
		}
	}

	ret = pread(dev_fd, rbuf, bufsz, block * block_size);
	if (ret != bufsz) {
		fprintf(stderr, "\rThread %02d: read failed on block "
			"%"PRIu64" ret=%zd errno=%d rbuf=%p\n",
			idx, block, ret, errno, rbuf);
		goto failed;
	}

	if (do_write && memcmp(wbuf, rbuf, bufsz) != 0) {
		fprintf(stderr, "\rThread %02d: data mismatch on block "
			"%"PRIu64" ret=%zd errno=%d\n", idx, block, ret, errno);
		goto failed;
	}

	nr_succeeded++;
	pthread_mutex_lock(&mutex);
	goto again;

 failed:
	nr_failed++;
	my_exiting = 1;
	pthread_mutex_lock(&mutex);
	goto again;
}

static uint64_t now_in_usec(void)
{
	struct timeval tv;

	gettimeofday(&tv, NULL);
	return (uint64_t)tv.tv_sec * 1000000 + tv.tv_usec;
}

int main(int argc, char **argv)
{
	struct stat sbuf;
	int i, summary_only;
	pthread_t *thrs;
	uint64_t started_at, last_tstmp;
	unsigned last_succeeded = 0;
	double iops = 0;

	if (argc < 5) {
		fprintf(stderr,
		"Usage: test_rawio BLOCKDEV BLOCKS_PER_RQ CONCURRENCY (r|w) [s(ummary)|w(ait)]\n");
		return 1;
	}

	blocks_per_rq = atoi(argv[2]);
	concurrency = atoi(argv[3]);

	if (blocks_per_rq <= 0 || concurrency <= 0) {
		fprintf(stderr, "invalid parameters\n");
		return 1;
	}

	if (!(dispenser_ar = malloc(sizeof(dispenser_ar[0]) * concurrency)) ||
	    !(thrs = malloc(sizeof(thrs[0]) * concurrency))) {
		perror("malloc");
		return 1;
	}
	memset(dispenser_ar, 0, sizeof(dispenser_ar[0]) * concurrency);

	do_write = tolower(argv[4][0]) == 'w';

	summary_only = 0;
	if (argc >= 6 && strchr(argv[5], 's'))
		summary_only = 1;

	if (argc >= 6 && strchr(argv[5], 'w')) {
		char buf[64];
		printf("press enter to continue\n");
		fgets(buf, sizeof(buf), stdin);
	}

	dev_fd = open(argv[1], (do_write ? O_RDWR : O_RDONLY) | O_DIRECT);
	if (dev_fd < 0) {
		perror("open");
		return 1;
	}

	if (fstat(dev_fd, &sbuf) < 0) {
		perror("fstat");
		return 1;
	}

	if (!S_ISBLK(sbuf.st_mode)) {
		fprintf(stderr, "not a block device\n");
		return 1;
	}

	if (ioctl(dev_fd, BLKSSZGET, &block_size) < 0 ||
	    ioctl(dev_fd, BLKGETSIZE64, &device_size) < 0) {
		perror("ioctl");
		return 1;
	}
	nr_blocks = device_size / block_size;

	if (!summary_only)
		printf("%s block_size=%d nr_blocks=%"PRIu64" (%.2lfGiB)\n",
		       argv[1], block_size, nr_blocks,
		       (double)device_size / (1 << 30));

	if (signal(SIGINT, sigexit_handler) == SIG_ERR) {
		perror("signal");
		return 1;
	}

	srandom(getpid());

	for (i = 0; i < concurrency; i++)
		if ((errno = pthread_create(&thrs[i], NULL, do_rawio,
					    (void *)(unsigned long)i))) {
			perror("pthread_create");
			return 1;
		}

	started_at = last_tstmp = now_in_usec();

	while (nr_exited < concurrency) {
		struct timespec ts_200ms = { 0, 200 * 1000 * 1000 };
		const char pgstr[] = "|/-\\";

		if (!summary_only) {
			uint64_t now = now_in_usec();
			double time_delta = ((double)now - last_tstmp) / 1000000;
			double io_delta = nr_succeeded - last_succeeded;

			if (last_tstmp - started_at < 1000000)
				iops = io_delta / time_delta;
			else
				iops = iops * 0.9 + io_delta / time_delta * 0.1;

			printf("\rnr_succeeded=%-8u nr_failed=%-8u iops=%7.03lf %s%c",
			       nr_succeeded, nr_failed, iops,
			       exiting ? "exiting..." : "",
			       pgstr[i++%(sizeof(pgstr)-1)]);

			last_tstmp = now;
			last_succeeded += io_delta;
		}

		fflush(stdout);
		nanosleep(&ts_200ms, NULL);
	}

	if (!summary_only)
		printf("\n");
	else
		printf("nr_succeeded=%u nr_failed=%8u iops=%03.03lf\n",
		       nr_succeeded, nr_failed,
		       (double)nr_succeeded /
		       (((double)now_in_usec() - started_at) / 1000000));

	return 0;
}

--H+4ONPRPur6+Ovig--
