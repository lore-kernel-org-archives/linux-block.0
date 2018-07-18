Return-Path: <jack@suse.cz>
Date: Wed, 18 Jul 2018 13:57:52 +0200
From: Jan Kara <jack@suse.cz>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
	Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	jack@suse.com, kent.overstreet@gmail.com
Subject: Re: Silent data corruption in blkdev_direct_IO()
Message-ID: <20180718115752.zowmgk7yndk6l73y@quack2.suse.cz>
References: <CACVXFVPVb_8pUkGXPt5joDE4JRu0b4kgTQy7Pd0sL+kXDwys+A@mail.gmail.com>
 <c5073ab4-6b06-16bd-f358-d4c18e18b3e0@kernel.dk>
 <f6f3f16b66622a9b16acd0d8be7ef311e4da807a.camel@suse.com>
 <CACVXFVPV1ckFvvh3m61QSPCtEY19ussRsMtKoptUbY3LLHKz8A@mail.gmail.com>
 <ff0fc8c44f205453a203e88676942507339f6829.camel@suse.com>
 <20180718024758.GB11151@ming.t460p>
 <54436062eee1e10644b536ae3c8c40f94da3ccbd.camel@suse.com>
 <20180718075440.GA15254@ming.t460p>
 <20180718092014.65k4dvg2ezrpbnzn@linux-x5ow.site>
 <20180718114007.huwriszokmcksqs6@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="axdivdrb2ifsubo5"
In-Reply-To: <20180718114007.huwriszokmcksqs6@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>


--axdivdrb2ifsubo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 18-07-18 13:40:07, Jan Kara wrote:
> On Wed 18-07-18 11:20:15, Johannes Thumshirn wrote:
> > On Wed, Jul 18, 2018 at 03:54:46PM +0800, Ming Lei wrote:
> > > Please go ahead and take care of it since you have the test cases.
> > 
> > Speaking of which, do we already know how it is triggered and can we
> > cook up a blktests testcase for it? This would be more than helpful
> > for all parties.
> 
> Using multiple iovecs with writev / readv trivially triggers the case of IO
> that is done partly as direct and partly as buffered. Neither me nor Martin
> were able to trigger the data corruption the customer is seeing with KVM
> though (since the generic code tries to maintain data integrity even if the
> IO is mixed). It should be possible to trigger the corruption by having two
> processes doing write to the same PAGE_SIZE region of a block device, just at
> different offsets. And if the first process happens to use direct IO while
> the second ends up doing read-modify-write cycle through page cache, the
> first write could end up being lost. I'll try whether something like this
> is able to see the corruption...

OK, when I run attached test program like:

blkdev-dio-test /dev/loop0 0 &
blkdev-dio-test /dev/loop0 2048 &

One of them reports lost write almost immediately. On kernel with my fix
the test program runs for quite a while without problems.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--axdivdrb2ifsubo5
Content-Type: text/x-c; charset=us-ascii
Content-Disposition: attachment; filename="blkdev-dio-test.c"

#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <sys/uio.h>

#define PAGE_SIZE 4096
#define SECT_SIZE 512
#define BUF_OFF (2*SECT_SIZE)

int main(int argc, char **argv)
{
	int fd = open(argv[1], O_RDWR | O_DIRECT);
	int ret;
	char *buf;
	loff_t off;
	struct iovec iov[2];
	unsigned int seq;

	if (fd < 0) {
		perror("open");
		return 1;
	}

	off = strtol(argv[2], NULL, 10);

	buf = aligned_alloc(PAGE_SIZE, PAGE_SIZE);

	iov[0].iov_base = buf;
	iov[0].iov_len = SECT_SIZE;
	iov[1].iov_base = buf + BUF_OFF;
	iov[1].iov_len = SECT_SIZE;

	seq = 0;
	memset(buf, 0, PAGE_SIZE);
	while (1) {
		*(unsigned int *)buf = seq;
		*(unsigned int *)(buf + BUF_OFF) = seq;
		ret = pwritev(fd, iov, 2, off);
		if (ret < 0) {
			perror("pwritev");
			return 1;
		}
		if (ret != 2*SECT_SIZE) {
			fprintf(stderr, "Short pwritev: %d\n", ret);
			return 1;
		}
		ret = pread(fd, buf, PAGE_SIZE, off);
		if (ret < 0) {
			perror("pread");
			return 1;
		}
		if (ret != PAGE_SIZE) {
			fprintf(stderr, "Short read: %d\n", ret);
			return 1;
		}
		if (*(unsigned int *)buf != seq ||
		    *(unsigned int *)(buf + SECT_SIZE) != seq) {
			printf("Lost write %u: %u %u\n", seq, *(unsigned int *)buf, *(unsigned int *)(buf + SECT_SIZE));
			return 1;
		}
		seq++;
	}

	return 0;
}

--axdivdrb2ifsubo5--
