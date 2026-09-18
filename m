Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31024AEBCF;
	Fri, 18 Sep 2026 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727369; cv=none; b=EUkM0Zm29hSaxhwMrmNjvoewJ57lvw6l2QZd51xy+HwZa/0teEoQTBP2KnXcRf/rmty/1zLnxfCeo8k0+oUo5LgtACc9rwAkI/PqTqBAV8sI/6OVL6QwpFfJJTLSBMuhbV+qqo6h7IJPuZPT78QfkR6fnhTHoC06r2Rtk9xfwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727369; c=relaxed/simple;
	bh=eykf8ZG4PzSl3OAVLy3ubWE95bOKvXuCf3c1qnqtHjs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A/e35oR8ew9jlNGhM8UyN+aC+4Sor4kg+tlKz324pmDwfu31AGBIqzAGDGZ/9yprGMDVKHaN9rlxJHeLt5PXq50SlNHVuJIyo4eC3S7GTSRngn6MgFK4bWuag9xemcRT72yLHMGPYkVuMpH+e8CThaRpbbjWZGbhgoQFa8Zirik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP1qx4R1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP1qx4R1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859401F000FF;
	Fri, 18 Sep 2026 10:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727366;
	bh=zapYxt+DFcrIaqNif2aYZEGtynzcxVuFtovpnLAog8A=;
	h=Date:From:To:Cc:Subject;
	b=mP1qx4R1YhX3xpq2P9ee6QxCOrOdcnjQdsDcaQ0K97DvgzZj8G7IloK/tjb9JnuiK
	 c6qyAWbSWd/VsqsI1UjppXoYIo4NxHcNIsO5NXWAi4XLaExjQ88pAGc4KPKgfNsU01
	 eb3k5vxIV8mDS8Eu0e3BmxVU0T2dmVuMnmTsZ9Wi3x9y+wesmGup83SQGcl5XjvpsH
	 6R0d2Qj/afo5nA9tWBUmVePywSj0MdgiXFi9a553+lhoXjS9ZNb8uEwKE6Ro1Fe4hY
	 i2uSfWi8tUqExhvuUH+kXdMmz/eJeEDBf+NuzLk/NjW3KOb91IxoFaG2JshZ+tPMDv
	 M3Val4LCBESqQ==
Date: Fri, 18 Sep 2026 12:29:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Subject: ublk: consequences of a dead server are only failing on the last
 /dev/ublkcN release
Message-ID: <20260918-eisbrecher-toilette-worum-eb11f777c563@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5pdgwqct6uuqapc3"
Content-Disposition: inline


--5pdgwqct6uuqapc3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Chris scanned a new series of mine for me and he reported some
interesting behavior that I dug into.

A ublk request that was handed to the server is only failed once the
last reference to /dev/ublkcN is dropped. So holding the file open keeps
the request alive.

This causes any waiter to be stuck in D state and blocks STOP_DEV.

I'm attaching two reproducers:

(1) ublk_inherited_fd_test.c   the general case, no vfork involved
(2) vfork_ublk_test.c          the holder of the reference is the waiter itself

Re (1):

A single-threaded ublk server fork()s a helper. The helper inherits the
fdtable including /dev/ublkcN. Now another process opens /dev/ublkbN and
writes 4 kb then fsync()s. The servers gets a WRITE and _exit()s without
completing it - say it crashes:

  - The writer sleeps in folio_wait_writeback() in D state.
  - STOP_DEV issued from another process never returns.

    The control command runs on an io-wq worker of that process, which
    calls ublk_stop_dev() -> del_gendisk() -> bdev_mark_dead() ->
    filemap_write_and_wait_range() and ends up waiting on the page that
    won't be written back.

    Said process can't exit and io_wq_put_and_exit() waits for the
    worker.

This can only be undone if the helper is SIGKILLed:

  # ublk0 up, server 119
  # helper 123 forked by the server, holds the inherited fds
  # WRITER fsync
  # server 119 died with the WRITE in hand
  # 2s after the server died:
  # writer pid 124, state D:
  #   folio_wait_bit_common
  #   folio_wait_writeback
  #   __filemap_fdatawait_range
  #   file_write_and_wait_range
  #   blkdev_fsync
  #   do_fsync
  # STOP_DEV from pid 125 has not returned after 5s:
  # STOP_DEV issuer thread 126:
  #   folio_wait_bit_common
  #   folio_wait_writeback
  #   __filemap_fdatawait_range
  #   filemap_write_and_wait_range
  #   bdev_mark_dead
  #   blk_report_disk_dead
  #   __del_gendisk
  #   del_gendisk
  #   ublk_stop_dev_unlocked.part.0
  #   ublk_ctrl_uring_cmd
  #   io_uring_cmd
  #   io_wq_submit_work
  #   io_worker_handle_work
  #   io_wq_worker
  # killing helper 123
  # WRITER fsync returned -1 errno 5
  # STOP_DEV returned after the helper died

What happens to a device after a server crash depends on whoever else
holds /dev/ublkcN open: A forked helper, a process that got the fd via
SCM_RIGHTS, or a vfork child.

I'm not sure whether that's intended semantics but it surely has
confusion potential and should probably be at least documented.

I suppose failing outstanding requests on server crash is intentionally
not done for recover reasons or whatever. But maybe STOP_DEV should be
made to work.

Re (2):

vfork() makes it really ugly. Say a single-threaded ublk server vfork()s
a child. The child opens /dev/ublkbN, writes some stuff and closes the
fd. Since close(2) runs bdev_release() -> sync_blockdev() it waits for
the write.

The write gets dispatched to the server's task work. But the server
sleeps in wait_for_vfork_done() until the child execs or exits.

But the child cannot exec or exit because close(2) doesn't return.

ublk makes this more hairy though. Even a SIGKILL sent to the server aka
the parent won't help. The vfork()ed child hangs on the close(2).

So that stays in D state forever with an undeletable device:

    server, after SIGKILL: gone
    child:
      State:  D (disk sleep)
      folio_wait_bit_common
      folio_wait_writeback
      __filemap_fdatawait_range
      filemap_write_and_wait_range
      bdev_release
      blkdev_release
      __fput
      fput_close_sync
      __x64_sys_close

Unrelated, but also a potential issue:

The commit 7fc4da6a304b ("ublk: scan partition in async way") made
partition scans run from a workqueue that holds disk->open_mutex while
the server serves its reads and START_DEV returns before it's finished.

Any server that treats START_DEV's return as a signal that the disk is
ready and doesn't serve requests hangs every open() of /dev/ublkbN on
uninterruptible on open_mutex. You can combine that with (1) and (2).

Thanks,
Christian


-- 

--5pdgwqct6uuqapc3
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename="ublk_inherited_fd_test.c"

// SPDX-License-Identifier: GPL-2.0
/*
 * A ublk server hands a request to userspace and dies while a plain
 * fork()ed helper still holds the inherited /dev/ublkcN descriptor.
 *
 * ublk only fails a request that was handed to the server from
 * ublk_ch_release_work_fn(), i.e. when the last reference to the char
 * device is dropped. As long as the helper lives:
 *
 *   - the writer whose page is in that request sleeps in
 *     folio_wait_writeback() in D state,
 *   - STOP_DEV from another process wedges its io-wq worker in
 *     ublk_stop_dev() -> del_gendisk() behind the same request.
 *
 * Killing the helper releases the char device, the request fails with
 * -EIO and both waiters continue. No request timeout applies to a
 * privileged device (ublk_timeout() only acts on UBLK_F_UNPRIVILEGED_DEV).
 *
 * Steps, all reported on stdout:
 *   1. server: ADD_DEV, SET_PARAMS, open /dev/ublkcN, FETCH_REQ x depth
 *   2. monitor: START_DEV, wait for the partition scan, open the disk
 *   3. server: fork() a helper that sleeps (inherits every fd)
 *   4. writer: open /dev/ublkbN, write 4 KiB, fsync()
 *   5. server: receives the WRITE and _exit()s without completing it
 *   6. monitor: writer is in D state; STOP_DEV wedges
 *   7. monitor: SIGKILL the helper; fsync() returns -EIO, STOP_DEV returns
 */
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <liburing.h>
#include <linux/ublk_cmd.h>
#include <poll.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#define QD		4
#define DEV_SIZE	(4UL << 20)
#define IO_BUF_BYTES	(64U << 10)
#define UD_GO		1000

struct ctrl {
	struct io_uring ring;
	int fd;
};

static double now(void)
{
	struct timespec ts;

	clock_gettime(CLOCK_MONOTONIC, &ts);
	return ts.tv_sec + ts.tv_nsec / 1e9;
}

static int ctrl_open(struct ctrl *c)
{
	c->fd = open("/dev/ublk-control", O_RDWR);
	if (c->fd < 0)
		return -errno;
	return io_uring_queue_init(8, &c->ring, IORING_SETUP_SQE128);
}

static int ctrl_cmd(struct ctrl *c, __u32 cmd_op, int dev_id, void *addr,
		    __u16 len, __u64 data0)
{
	struct io_uring_sqe *sqe = io_uring_get_sqe(&c->ring);
	struct ublksrv_ctrl_cmd *cmd;
	struct io_uring_cqe *cqe;
	int ret;

	memset(sqe, 0, 128);
	sqe->opcode = IORING_OP_URING_CMD;
	sqe->fd = c->fd;
	sqe->cmd_op = cmd_op;
	cmd = (struct ublksrv_ctrl_cmd *)sqe->cmd;
	cmd->dev_id = dev_id;
	cmd->queue_id = -1;
	cmd->addr = (__u64)(uintptr_t)addr;
	cmd->len = len;
	cmd->data[0] = data0;
	ret = io_uring_submit(&c->ring);
	if (ret < 0)
		return ret;
	ret = io_uring_wait_cqe(&c->ring, &cqe);
	if (ret < 0)
		return ret;
	ret = cqe->res;
	io_uring_cqe_seen(&c->ring, cqe);
	return ret;
}

static void queue_io_cmd(struct io_uring *ring, int cfd, __u32 cmd_op, int tag,
			 void *buf, int result)
{
	struct io_uring_sqe *sqe = io_uring_get_sqe(ring);
	struct ublksrv_io_cmd *cmd;

	memset(sqe, 0, 128);
	sqe->opcode = IORING_OP_URING_CMD;
	sqe->fd = cfd;
	sqe->cmd_op = cmd_op;
	cmd = (struct ublksrv_io_cmd *)sqe->cmd;
	cmd->q_id = 0;
	cmd->tag = tag;
	cmd->addr = (__u64)(uintptr_t)buf;
	cmd->result = result;
	sqe->user_data = tag;
}

static int server(int to_mon, int from_mon)
{
	struct ublksrv_ctrl_dev_info info = {
		.nr_hw_queues = 1,
		.queue_depth = QD,
		.max_io_buf_bytes = IO_BUF_BYTES,
		.dev_id = -1,
	};
	struct ublk_params params = {
		.types = UBLK_PARAM_TYPE_BASIC,
		.basic = {
			.logical_bs_shift = 9,
			.physical_bs_shift = 12,
			.io_opt_shift = 12,
			.io_min_shift = 9,
			.max_sectors = IO_BUF_BYTES >> 9,
			.dev_sectors = DEV_SIZE >> 9,
		},
	};
	struct io_uring ring;
	struct ctrl c;
	void *bufs[QD], *desc;
	char *ram, cpath[64], go;
	size_t desc_size, cmd_buf_size;
	int ret, dev_id, cfd = -1, i, armed = 0;

	ret = ctrl_open(&c);
	if (ret < 0) {
		dprintf(to_mon, "FAIL ctrl_open %d\n", ret);
		return 1;
	}
	ret = ctrl_cmd(&c, UBLK_U_CMD_ADD_DEV, -1, &info, sizeof(info), 0);
	if (ret < 0) {
		dprintf(to_mon, "FAIL ADD_DEV %d\n", ret);
		return 1;
	}
	dev_id = info.dev_id;
	desc_size = info.io_desc_size ?: sizeof(struct ublksrv_io_desc);
	params.len = sizeof(params);
	ret = ctrl_cmd(&c, UBLK_U_CMD_SET_PARAMS, dev_id, &params, sizeof(params), 0);
	if (ret < 0) {
		dprintf(to_mon, "FAIL SET_PARAMS %d\n", ret);
		return 1;
	}
	snprintf(cpath, sizeof(cpath), "/dev/ublkc%d", dev_id);
	for (i = 0; i < 200 && cfd < 0; i++) {
		cfd = open(cpath, O_RDWR);
		if (cfd < 0)
			usleep(10000);
	}
	if (cfd < 0) {
		dprintf(to_mon, "FAIL open %s %d\n", cpath, -errno);
		return 1;
	}
	cmd_buf_size = (QD * desc_size + 4095) & ~4095UL;
	desc = mmap(NULL, cmd_buf_size, PROT_READ, MAP_SHARED | MAP_POPULATE,
		    cfd, UBLKSRV_CMD_BUF_OFFSET);
	if (desc == MAP_FAILED) {
		dprintf(to_mon, "FAIL mmap desc %d\n", -errno);
		return 1;
	}
	for (i = 0; i < QD; i++) {
		if (posix_memalign(&bufs[i], 4096, IO_BUF_BYTES)) {
			dprintf(to_mon, "FAIL memalign\n");
			return 1;
		}
	}
	ram = calloc(1, DEV_SIZE);
	if (!ram) {
		dprintf(to_mon, "FAIL alloc\n");
		return 1;
	}
	ret = io_uring_queue_init(32, &ring, IORING_SETUP_SQE128);
	if (ret < 0) {
		dprintf(to_mon, "FAIL io ring %d\n", ret);
		return 1;
	}
	for (i = 0; i < QD; i++)
		queue_io_cmd(&ring, cfd, UBLK_U_IO_FETCH_REQ, i, bufs[i], 0);
	ret = io_uring_submit(&ring);
	if (ret != QD) {
		dprintf(to_mon, "FAIL FETCH submit %d\n", ret);
		return 1;
	}
	{
		struct io_uring_sqe *sqe = io_uring_get_sqe(&ring);

		io_uring_prep_read(sqe, from_mon, &go, 1, 0);
		sqe->user_data = UD_GO;
	}
	dprintf(to_mon, "READY %d\n", dev_id);

	for (;;) {
		struct __kernel_timespec ts = { .tv_nsec = 100 * 1000 * 1000 };
		struct io_uring_cqe *cqe;

		io_uring_submit(&ring);
		ret = io_uring_wait_cqe_timeout(&ring, &cqe, &ts);
		while (ret == 0) {
			__u64 ud = cqe->user_data;
			int res = cqe->res;

			io_uring_cqe_seen(&ring, cqe);
			if (ud == UD_GO) {
				pid_t helper = fork();

				if (helper == 0) {
					/* An ordinary helper: inherits every fd, idles. */
					for (;;)
						pause();
				}
				dprintf(to_mon, "HELPER %d\n", helper);
				armed = 1;
			} else if (res == UBLK_IO_RES_OK) {
				const struct ublksrv_io_desc *iod = desc + ud * desc_size;
				__u8 op = iod->op_flags & 0xff;
				__u64 off = iod->start_sector << 9;
				__u32 len = iod->nr_sectors << 9;
				int result = len;

				dprintf(to_mon, "IO op=%u sector=%llu n=%u\n", op,
					(unsigned long long)iod->start_sector,
					iod->nr_sectors);
				if (armed && op == UBLK_IO_OP_WRITE) {
					/* The crash: die with the request in hand. */
					dprintf(to_mon, "DYING with the write in hand\n");
					_exit(1);
				}
				if (off + len > DEV_SIZE) {
					result = -EIO;
				} else if (op == UBLK_IO_OP_READ) {
					memcpy(bufs[ud], ram + off, len);
				} else if (op == UBLK_IO_OP_WRITE) {
					memcpy(ram + off, bufs[ud], len);
				} else if (op == UBLK_IO_OP_FLUSH) {
					result = 0;
				} else if (op == UBLK_IO_OP_DISCARD ||
					   op == UBLK_IO_OP_WRITE_ZEROES) {
					memset(ram + off, 0, len);
				} else {
					result = -EOPNOTSUPP;
				}
				queue_io_cmd(&ring, cfd, UBLK_U_IO_COMMIT_AND_FETCH_REQ,
					     ud, bufs[ud], result);
			} else {
				dprintf(to_mon, "DEAD %d\n", res);
				return 1;
			}
			ret = io_uring_peek_cqe(&ring, &cqe);
		}
	}
	return 0;
}

static int writer(int to_mon, const char *bpath)
{
	static char buf[4096] __attribute__((aligned(4096)));
	int fd, ret, err;

	fd = open(bpath, O_RDWR);
	if (fd < 0) {
		dprintf(to_mon, "WRITER open failed %d\n", -errno);
		return 1;
	}
	memset(buf, 'u', sizeof(buf));
	if (write(fd, buf, sizeof(buf)) != sizeof(buf)) {
		dprintf(to_mon, "WRITER write failed %d\n", -errno);
		return 1;
	}
	dprintf(to_mon, "WRITER fsync\n");
	ret = fsync(fd);
	err = errno;
	dprintf(to_mon, "WRITER fsync returned %d errno %d\n", ret, ret ? err : 0);
	close(fd);
	return 0;
}

/* Read one line from @fd with a deadline. Returns 0 on EOF, -1 on timeout. */
static int read_line(int fd, char *buf, size_t len, double deadline)
{
	size_t n = 0;

	while (n + 1 < len) {
		struct pollfd pfd = { .fd = fd, .events = POLLIN };
		int ms = (int)((deadline - now()) * 1000);
		ssize_t r;

		if (ms <= 0 || poll(&pfd, 1, ms) <= 0)
			return -1;
		r = read(fd, buf + n, 1);
		if (r <= 0)
			return 0;
		if (buf[n++] == '\n')
			break;
	}
	buf[n] = 0;
	return 1;
}

static void cat(const char *path, const char *prefix)
{
	char buf[4096];
	ssize_t n;
	int fd = open(path, O_RDONLY);

	if (fd < 0)
		return;
	n = read(fd, buf, sizeof(buf) - 1);
	close(fd);
	if (n <= 0)
		return;
	buf[n] = 0;
	for (char *p = buf, *e; p && *p; p = e) {
		e = strchr(p, '\n');
		if (e)
			*e++ = 0;
		printf("#   %s%s\n", prefix, p);
	}
}

static int task_state(pid_t pid)
{
	char path[64], line[256];
	int st = 0;
	FILE *f;

	snprintf(path, sizeof(path), "/proc/%d/status", pid);
	f = fopen(path, "r");
	if (!f)
		return 0;
	while (fgets(line, sizeof(line), f)) {
		if (!strncmp(line, "State:", 6)) {
			st = line[7];
			break;
		}
	}
	fclose(f);
	return st;
}

static void dump_task(pid_t pid, const char *what)
{
	char path[64];

	printf("# %s pid %d, state %c:\n", what, pid, task_state(pid) ?: '?');
	snprintf(path, sizeof(path), "/proc/%d/wchan", pid);
	cat(path, "wchan: ");
	snprintf(path, sizeof(path), "/proc/%d/stack", pid);
	cat(path, "");
}

static void dump_threads(pid_t pid, const char *what)
{
	char path[64];
	int tid;

	/* io-wq workers are threads of the issuing task. */
	for (tid = pid + 1; tid < pid + 64; tid++) {
		snprintf(path, sizeof(path), "/proc/%d/task/%d/stack", pid, tid);
		if (!access(path, F_OK)) {
			printf("# %s thread %d:\n", what, tid);
			cat(path, "");
		}
	}
}

int main(int argc, char **argv)
{
	int a[2], b[2], dev_id = -1, status, ret, i, fd, scan_reads = 0;
	int reproduced = 0, err = -1;
	char line[128], bpath[64];
	pid_t srv, helper = 0, wr = 0, stopper = 0;
	double deadline;
	struct ctrl mc;

	setvbuf(stdout, NULL, _IONBF, 0);
	if (access("/dev/ublk-control", F_OK)) {
		printf("not ok 1 # no /dev/ublk-control\n");
		return 1;
	}
	if (pipe(a) || pipe(b)) {
		printf("not ok 1 # pipe: %m\n");
		return 1;
	}
	srv = fork();
	if (srv == 0) {
		close(a[0]);
		close(b[1]);
		_exit(server(a[1], b[0]));
	}
	close(b[0]);

	deadline = now() + 10;
	if (read_line(a[0], line, sizeof(line), deadline) <= 0 ||
	    sscanf(line, "READY %d", &dev_id) != 1) {
		printf("not ok 1 # server setup: %s", line);
		goto out;
	}
	if (ctrl_open(&mc) < 0) {
		printf("not ok 1 # ctrl_open: %m\n");
		goto out;
	}
	ret = ctrl_cmd(&mc, UBLK_U_CMD_START_DEV, dev_id, NULL, 0, srv);
	if (ret < 0) {
		printf("not ok 1 # START_DEV %d\n", ret);
		goto out;
	}
	snprintf(bpath, sizeof(bpath), "/dev/ublkb%d", dev_id);
	for (i = 0; i < 200 && access(bpath, F_OK); i++)
		usleep(10000);
	/* Let the asynchronous partition scan finish before anything else. */
	deadline = now() + 10;
	while (!scan_reads) {
		unsigned op;

		if (read_line(a[0], line, sizeof(line), deadline) <= 0) {
			printf("not ok 1 # no partition scan read: %s", line);
			goto out;
		}
		if (sscanf(line, "IO op=%u", &op) == 1 && op == UBLK_IO_OP_READ)
			scan_reads++;
	}
	for (i = 0; i < 100; i++) {
		fd = open(bpath, O_RDONLY);
		if (fd >= 0 || errno != ENXIO)
			break;
		usleep(100000);
	}
	if (fd < 0) {
		printf("not ok 1 # open %s: %m\n", bpath);
		goto out;
	}
	close(fd);
	printf("# ublk%d up, server %d\n", dev_id, srv);

	/* 3. the server forks its helper */
	if (write(b[1], "g", 1) != 1)
		goto out;
	deadline = now() + 10;
	for (;;) {
		if (read_line(a[0], line, sizeof(line), deadline) <= 0) {
			printf("not ok 1 # no helper: %s", line);
			goto out;
		}
		if (sscanf(line, "HELPER %d", &helper) == 1)
			break;
	}
	printf("# helper %d forked by the server, holds the inherited fds\n", helper);

	/* 4. + 5. the writer and the crash */
	wr = fork();
	if (wr == 0) {
		close(b[1]);
		_exit(writer(a[1], bpath));
	}
	close(a[1]);
	deadline = now() + 10;
	for (;;) {
		if (read_line(a[0], line, sizeof(line), deadline) <= 0) {
			printf("not ok 1 # waiting for the crash: %s", line);
			goto out;
		}
		if (!strncmp(line, "DYING", 5)) {
			printf("# server %d died with the WRITE in hand\n", srv);
			break;
		}
		if (!strncmp(line, "WRITER", 6))
			printf("# %s", line);
	}
	waitpid(srv, &status, 0);
	srv = 0;

	/* 6. the writer is stuck, STOP_DEV wedges */
	usleep(2000000);
	printf("# 2s after the server died:\n");
	dump_task(wr, "writer");
	if (task_state(wr) == 'D')
		reproduced = 1;
	stopper = fork();
	if (stopper == 0) {
		struct ctrl sc;

		if (ctrl_open(&sc) == 0)
			ctrl_cmd(&sc, UBLK_U_CMD_STOP_DEV, dev_id, NULL, 0, 0);
		_exit(0);
	}
	deadline = now() + 5;
	while (now() < deadline && waitpid(stopper, &status, WNOHANG) != stopper)
		usleep(100000);
	if (task_state(stopper)) {
		printf("# STOP_DEV from pid %d has not returned after 5s:\n", stopper);
		dump_task(stopper, "STOP_DEV issuer");
		dump_threads(stopper, "STOP_DEV issuer");
	} else {
		printf("# STOP_DEV returned\n");
		stopper = 0;
	}

	/* 7. drop the helper's reference */
	printf("# killing helper %d\n", helper);
	kill(helper, SIGKILL);
	waitpid(helper, &status, 0);
	helper = 0;
	deadline = now() + 10;
	for (;;) {
		int r;

		if (read_line(a[0], line, sizeof(line), deadline) <= 0) {
			printf("# writer still stuck 10s after the helper died\n");
			dump_task(wr, "writer");
			break;
		}
		if (sscanf(line, "WRITER fsync returned %d errno %d", &r, &err) == 2) {
			printf("# %s", line);
			break;
		}
	}
	if (stopper) {
		deadline = now() + 10;
		while (now() < deadline && waitpid(stopper, &status, WNOHANG) != stopper)
			usleep(100000);
		printf("# STOP_DEV %s after the helper died\n",
		       task_state(stopper) ? "still stuck" : "returned");
		if (task_state(stopper))
			kill(stopper, SIGKILL);
		stopper = 0;
	}
	if (reproduced && err == EIO)
		printf("ok 1 request handed to a dead server is only failed when the inherited char dev fd goes away\n");
	else if (reproduced)
		printf("not ok 1 # writer stuck (reproduced) but did not get -EIO after the helper died\n");
	else
		printf("not ok 1 # writer was not stuck 2s after the server died\n");
out:
	if (srv > 0)
		kill(srv, SIGKILL);
	if (helper > 0)
		kill(helper, SIGKILL);
	if (wr > 0) {
		deadline = now() + 5;
		while (now() < deadline && waitpid(wr, &status, WNOHANG) != wr)
			usleep(100000);
	}
	if (dev_id >= 0) {
		pid_t del = fork();

		if (del == 0) {
			struct ctrl dc;

			if (ctrl_open(&dc) == 0)
				ctrl_cmd(&dc, UBLK_U_CMD_DEL_DEV, dev_id, NULL, 0, 0);
			_exit(0);
		}
		deadline = now() + 10;
		while (now() < deadline && waitpid(del, &status, WNOHANG) != del)
			usleep(100000);
		if (task_state(del)) {
			printf("# DEL_DEV stuck too\n");
			kill(del, SIGKILL);
		}
	}
	return !reproduced;
}

--5pdgwqct6uuqapc3
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename="vfork_ublk_test.c"

// SPDX-License-Identifier: GPL-2.0
/*
 * A single-threaded ublk server vforks a child that opens the block
 * device the server serves, dirties a page and then either execs (the
 * file is O_CLOEXEC), closes the file or exits.
 *
 * The final release of the block device runs sync_blockdev() and the
 * write can only be served once the parent runs again.
 *
 *   exec:  the release runs from close_cloexec_files() in exec.
 *   close: the release runs from close(2), synchronous since v6.6.
 *   exit:  the release runs from exit_files(), after exit_mm() woke
 *          the parent.
 *
 * A monitor process issues START_DEV, waits for the asynchronous
 * partition scan (its reads are served by the server and it holds the
 * disk's open_mutex, so the server must not vfork before it is done),
 * and kills a server that is stuck in vfork.
 */
#define _GNU_SOURCE
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <liburing.h>
#include <linux/ublk_cmd.h>
#include <poll.h>
#include <sched.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#define QD		4
#define DEV_SIZE	(4UL << 20)
#define IO_BUF_BYTES	(64U << 10)
#define HANG_SECS	15
#define STACK_SIZE	(256 * 1024)
#define UD_GO		1000

enum mode { MODE_EXEC, MODE_CLOSE, MODE_EXIT };
static const char *mode_name[] = { "exec", "close", "exit" };

struct ctrl {
	struct io_uring ring;
	int fd;
};

static double now(void)
{
	struct timespec ts;

	clock_gettime(CLOCK_MONOTONIC, &ts);
	return ts.tv_sec + ts.tv_nsec / 1e9;
}

static int ctrl_open(struct ctrl *c)
{
	c->fd = open("/dev/ublk-control", O_RDWR);
	if (c->fd < 0)
		return -errno;
	return io_uring_queue_init(8, &c->ring, IORING_SETUP_SQE128);
}

static int ctrl_cmd(struct ctrl *c, __u32 cmd_op, int dev_id, void *addr,
		    __u16 len, __u64 data0)
{
	struct io_uring_sqe *sqe = io_uring_get_sqe(&c->ring);
	struct ublksrv_ctrl_cmd *cmd;
	struct io_uring_cqe *cqe;
	int ret;

	memset(sqe, 0, 128);
	sqe->opcode = IORING_OP_URING_CMD;
	sqe->fd = c->fd;
	sqe->cmd_op = cmd_op;
	cmd = (struct ublksrv_ctrl_cmd *)sqe->cmd;
	cmd->dev_id = dev_id;
	cmd->queue_id = -1;
	cmd->addr = (__u64)(uintptr_t)addr;
	cmd->len = len;
	cmd->data[0] = data0;
	ret = io_uring_submit(&c->ring);
	if (ret < 0)
		return ret;
	ret = io_uring_wait_cqe(&c->ring, &cqe);
	if (ret < 0)
		return ret;
	ret = cqe->res;
	io_uring_cqe_seen(&c->ring, cqe);
	return ret;
}

static void queue_io_cmd(struct io_uring *ring, int cfd, __u32 cmd_op, int tag,
			 void *buf, int result)
{
	struct io_uring_sqe *sqe = io_uring_get_sqe(ring);
	struct ublksrv_io_cmd *cmd;

	memset(sqe, 0, 128);
	sqe->opcode = IORING_OP_URING_CMD;
	sqe->fd = cfd;
	sqe->cmd_op = cmd_op;
	cmd = (struct ublksrv_io_cmd *)sqe->cmd;
	cmd->q_id = 0;
	cmd->tag = tag;
	cmd->addr = (__u64)(uintptr_t)buf;
	cmd->result = result;
	sqe->user_data = tag;
}

struct child_args {
	const char *self;
	const char *bdev;
	enum mode mode;
	int to_mon;
};

static char child_buf[4096] __attribute__((aligned(4096)));

static void child_say(int fd, const char *s)
{
	if (write(fd, s, strlen(s)) < 0)
		_exit(20);
}

/* Runs on its own stack in the parent's mm. Only syscalls, never returns. */
static int child_fn(void *arg)
{
	struct child_args *a = arg;
	char *const argv[] = { (char *)a->self, "--child", NULL };
	int flags = O_RDWR | (a->mode == MODE_EXEC ? O_CLOEXEC : 0);
	int fd;

	fd = open(a->bdev, flags);
	if (fd < 0)
		_exit(11);
	child_say(a->to_mon, "CHILD opened\n");
	memset(child_buf, 'u', sizeof(child_buf));
	if (write(fd, child_buf, sizeof(child_buf)) != sizeof(child_buf))
		_exit(12);
	child_say(a->to_mon, "CHILD wrote\n");
	switch (a->mode) {
	case MODE_EXEC:
		child_say(a->to_mon, "CHILD exec\n");
		execv(a->self, argv);
		_exit(13);
	case MODE_CLOSE:
		child_say(a->to_mon, "CHILD close\n");
		if (close(fd))
			_exit(14);
		child_say(a->to_mon, "CHILD closed\n");
		_exit(0);
	case MODE_EXIT:
		child_say(a->to_mon, "CHILD exit\n");
		_exit(0);
	}
	_exit(15);
}

static int server(enum mode mode, int to_mon, int from_mon, const char *self)
{
	struct ublksrv_ctrl_dev_info info = {
		.nr_hw_queues = 1,
		.queue_depth = QD,
		.max_io_buf_bytes = IO_BUF_BYTES,
		.dev_id = -1,
	};
	struct ublk_params params = {
		.types = UBLK_PARAM_TYPE_BASIC,
		.basic = {
			.logical_bs_shift = 9,
			.physical_bs_shift = 12,
			.io_opt_shift = 12,
			.io_min_shift = 9,
			.max_sectors = IO_BUF_BYTES >> 9,
			.dev_sectors = DEV_SIZE >> 9,
		},
	};
	struct child_args args = { .self = self, .mode = mode, .to_mon = to_mon };
	struct io_uring ring;
	struct ctrl c;
	void *bufs[QD], *desc, *stack;
	char *ram, cpath[64], bpath[64], go;
	size_t desc_size, cmd_buf_size;
	int ret, dev_id, cfd = -1, i, status;
	pid_t child = 0;
	double t0 = 0, t_vfork = 0;

	ret = ctrl_open(&c);
	if (ret < 0) {
		dprintf(to_mon, "FAIL ctrl_open %d\n", ret);
		return 1;
	}
	ret = ctrl_cmd(&c, UBLK_U_CMD_ADD_DEV, -1, &info, sizeof(info), 0);
	if (ret < 0) {
		dprintf(to_mon, "FAIL ADD_DEV %d\n", ret);
		return 1;
	}
	dev_id = info.dev_id;
	desc_size = info.io_desc_size ?: sizeof(struct ublksrv_io_desc);
	params.len = sizeof(params);
	ret = ctrl_cmd(&c, UBLK_U_CMD_SET_PARAMS, dev_id, &params, sizeof(params), 0);
	if (ret < 0) {
		dprintf(to_mon, "FAIL SET_PARAMS %d\n", ret);
		return 1;
	}

	snprintf(cpath, sizeof(cpath), "/dev/ublkc%d", dev_id);
	snprintf(bpath, sizeof(bpath), "/dev/ublkb%d", dev_id);
	args.bdev = bpath;
	for (i = 0; i < 200 && cfd < 0; i++) {
		cfd = open(cpath, O_RDWR);
		if (cfd < 0)
			usleep(10000);
	}
	if (cfd < 0) {
		dprintf(to_mon, "FAIL open %s %d\n", cpath, -errno);
		return 1;
	}
	cmd_buf_size = (QD * desc_size + 4095) & ~4095UL;
	desc = mmap(NULL, cmd_buf_size, PROT_READ, MAP_SHARED | MAP_POPULATE,
		    cfd, UBLKSRV_CMD_BUF_OFFSET);
	if (desc == MAP_FAILED) {
		dprintf(to_mon, "FAIL mmap desc %d\n", -errno);
		return 1;
	}
	for (i = 0; i < QD; i++) {
		if (posix_memalign(&bufs[i], 4096, IO_BUF_BYTES)) {
			dprintf(to_mon, "FAIL memalign\n");
			return 1;
		}
	}
	ram = calloc(1, DEV_SIZE);
	stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
	if (!ram || stack == MAP_FAILED) {
		dprintf(to_mon, "FAIL alloc\n");
		return 1;
	}

	ret = io_uring_queue_init(32, &ring, IORING_SETUP_SQE128);
	if (ret < 0) {
		dprintf(to_mon, "FAIL io ring %d\n", ret);
		return 1;
	}
	for (i = 0; i < QD; i++)
		queue_io_cmd(&ring, cfd, UBLK_U_IO_FETCH_REQ, i, bufs[i], 0);
	ret = io_uring_submit(&ring);
	if (ret != QD) {
		dprintf(to_mon, "FAIL FETCH submit %d\n", ret);
		return 1;
	}
	{
		struct io_uring_sqe *sqe = io_uring_get_sqe(&ring);

		io_uring_prep_read(sqe, from_mon, &go, 1, 0);
		sqe->user_data = UD_GO;
	}

	/* The monitor issues START_DEV now and tells us when to go. */
	dprintf(to_mon, "READY %d\n", dev_id);

	for (;;) {
		struct __kernel_timespec ts = { .tv_nsec = 100 * 1000 * 1000 };
		struct io_uring_cqe *cqe;

		io_uring_submit(&ring);
		ret = io_uring_wait_cqe_timeout(&ring, &cqe, &ts);
		while (ret == 0) {
			__u64 ud = cqe->user_data;
			int res = cqe->res;

			io_uring_cqe_seen(&ring, cqe);
			if (ud == UD_GO) {
				dprintf(to_mon, "GO\n");
				t0 = now();
				child = clone(child_fn, (char *)stack + STACK_SIZE,
					      CLONE_VM | CLONE_VFORK | SIGCHLD, &args);
				t_vfork = now() - t0;
				dprintf(to_mon, "VFORK %.2f %d\n", t_vfork, child);
				if (child < 0)
					return 1;
			} else if (res == UBLK_IO_RES_OK) {
				const struct ublksrv_io_desc *iod = desc + ud * desc_size;
				__u8 op = iod->op_flags & 0xff;
				__u64 off = iod->start_sector << 9;
				__u32 len = iod->nr_sectors << 9;
				int result = len;

				dprintf(to_mon, "IO op=%u sector=%llu n=%u\n", op,
					(unsigned long long)iod->start_sector,
					iod->nr_sectors);
				if (off + len > DEV_SIZE) {
					result = -EIO;
				} else if (op == UBLK_IO_OP_READ) {
					memcpy(bufs[ud], ram + off, len);
				} else if (op == UBLK_IO_OP_WRITE) {
					memcpy(ram + off, bufs[ud], len);
				} else if (op == UBLK_IO_OP_FLUSH) {
					result = 0;
				} else if (op == UBLK_IO_OP_DISCARD ||
					   op == UBLK_IO_OP_WRITE_ZEROES) {
					memset(ram + off, 0, len);
				} else {
					result = -EOPNOTSUPP;
				}
				queue_io_cmd(&ring, cfd, UBLK_U_IO_COMMIT_AND_FETCH_REQ,
					     ud, bufs[ud], result);
			} else {
				/* -ENODEV: the device is going away. */
				dprintf(to_mon, "DEAD %d\n", res);
				return 1;
			}
			ret = io_uring_peek_cqe(&ring, &cqe);
		}
		if (child > 0 && waitpid(child, &status, WNOHANG) == child) {
			dprintf(to_mon, "DONE 0x%x %.2f %.2f\n", status,
				t_vfork, now() - t0);
			break;
		}
	}
	return 0;
}

/* Read one line from @fd with a deadline. Returns 0 on EOF, -1 on timeout. */
static int read_line(int fd, char *buf, size_t len, double deadline)
{
	size_t n = 0;

	while (n + 1 < len) {
		struct pollfd pfd = { .fd = fd, .events = POLLIN };
		int ms = (int)((deadline - now()) * 1000);
		ssize_t r;

		if (ms <= 0 || poll(&pfd, 1, ms) <= 0)
			return -1;
		r = read(fd, buf + n, 1);
		if (r <= 0)
			return 0;
		if (buf[n++] == '\n')
			break;
	}
	buf[n] = 0;
	return 1;
}

static void cat(const char *path, const char *prefix)
{
	char buf[4096];
	ssize_t n;
	int fd = open(path, O_RDONLY);

	if (fd < 0)
		return;
	n = read(fd, buf, sizeof(buf) - 1);
	close(fd);
	if (n <= 0)
		return;
	buf[n] = 0;
	for (char *p = buf, *e; p && *p; p = e) {
		e = strchr(p, '\n');
		if (e)
			*e++ = 0;
		printf("#   %s%s\n", prefix, p);
	}
}

static void dump_task(pid_t pid, const char *what)
{
	char path[64], line[256];
	FILE *f;

	snprintf(path, sizeof(path), "/proc/%d/status", pid);
	f = fopen(path, "r");
	if (!f)
		return;
	printf("# %s pid %d:\n", what, pid);
	while (fgets(line, sizeof(line), f)) {
		if (!strncmp(line, "Name:", 5) || !strncmp(line, "State:", 6))
			printf("#   %s", line);
	}
	fclose(f);
	snprintf(path, sizeof(path), "/proc/%d/wchan", pid);
	cat(path, "wchan: ");
	snprintf(path, sizeof(path), "/proc/%d/stack", pid);
	cat(path, "");
}

static pid_t children[8];
static int nr_children;

static void dump_family(pid_t srv)
{
	struct dirent *d;
	DIR *dir;

	nr_children = 0;
	dump_task(srv, "server");
	dir = opendir("/proc");
	if (!dir)
		return;
	while ((d = readdir(dir))) {
		char path[64], line[256];
		pid_t pid = atoi(d->d_name), ppid = 0;
		FILE *f;

		if (pid <= 0)
			continue;
		snprintf(path, sizeof(path), "/proc/%d/status", pid);
		f = fopen(path, "r");
		if (!f)
			continue;
		while (fgets(line, sizeof(line), f))
			if (sscanf(line, "PPid: %d", &ppid) == 1)
				break;
		fclose(f);
		if (ppid == srv) {
			dump_task(pid, "child");
			if (nr_children < 8)
				children[nr_children++] = pid;
		}
	}
	closedir(dir);
}

/* Is @pid still around and in D state? */
static int task_state(pid_t pid)
{
	char path[64], line[256];
	int st = 0;
	FILE *f;

	snprintf(path, sizeof(path), "/proc/%d/status", pid);
	f = fopen(path, "r");
	if (!f)
		return 0;
	while (fgets(line, sizeof(line), f)) {
		if (!strncmp(line, "State:", 6)) {
			st = line[7];
			break;
		}
	}
	fclose(f);
	return st;
}

/* After the server was killed: does the stuck child get going again? */
static void watch_children(const char *mode)
{
	double deadline = now() + 10;
	int i;

	for (i = 0; i < nr_children; i++) {
		int st;

		while ((st = task_state(children[i])) == 'D' && now() < deadline)
			usleep(100000);
		if (!st)
			printf("# %s: child %d is gone after the kill\n", mode, children[i]);
		else if (st == 'D')
			printf("# %s: child %d still in D state 10s after the kill\n",
			       mode, children[i]);
		else
			printf("# %s: child %d left D state after the kill (%c)\n",
			       mode, children[i], st);
		if (st == 'D')
			dump_task(children[i], "child");
	}
}

/* STOP_DEV + DEL_DEV can block on a dead device, so do it in a helper. */
static void cleanup_dev(int dev_id)
{
	double deadline;
	int status;
	pid_t pid;

	pid = fork();
	if (pid == 0) {
		struct ctrl mc;

		if (ctrl_open(&mc) == 0) {
			ctrl_cmd(&mc, UBLK_U_CMD_STOP_DEV, dev_id, NULL, 0, 0);
			ctrl_cmd(&mc, UBLK_U_CMD_DEL_DEV, dev_id, NULL, 0, 0);
		}
		_exit(0);
	}
	deadline = now() + 10;
	while (now() < deadline) {
		if (waitpid(pid, &status, WNOHANG) == pid)
			return;
		usleep(100000);
	}
	printf("# cleanup of ublk%d stuck, abandoning it\n", dev_id);
	dump_task(pid, "cleanup helper");
	kill(pid, SIGKILL);
}

static int run_mode(enum mode mode, int nr, const char *self)
{
	int a[2], b[2], dev_id = -1, status, ret, i, fd, rc = 1, scan_reads = 0;
	char line[128], bpath[64];
	double deadline, t_vfork = -1, t_done = -1;
	pid_t srv;
	struct ctrl mc;

	if (pipe(a) || pipe(b)) {
		printf("not ok %d %s # pipe: %m\n", nr, mode_name[mode]);
		return 1;
	}
	srv = fork();
	if (srv < 0) {
		printf("not ok %d %s # fork: %m\n", nr, mode_name[mode]);
		return 1;
	}
	if (srv == 0) {
		close(a[0]);
		close(b[1]);
		_exit(server(mode, a[1], b[0], self));
	}
	close(a[1]);
	close(b[0]);

	deadline = now() + 10;
	if (read_line(a[0], line, sizeof(line), deadline) <= 0 ||
	    sscanf(line, "READY %d", &dev_id) != 1) {
		printf("not ok %d %s # server setup: %s", nr, mode_name[mode], line);
		goto out_kill;
	}
	ret = ctrl_open(&mc);
	if (ret < 0) {
		printf("not ok %d %s # monitor ctrl_open %d\n", nr, mode_name[mode], ret);
		goto out_kill;
	}
	ret = ctrl_cmd(&mc, UBLK_U_CMD_START_DEV, dev_id, NULL, 0, srv);
	if (ret < 0) {
		printf("not ok %d %s # START_DEV %d\n", nr, mode_name[mode], ret);
		goto out_kill;
	}
	snprintf(bpath, sizeof(bpath), "/dev/ublkb%d", dev_id);
	for (i = 0; i < 200 && access(bpath, F_OK); i++)
		usleep(10000);
	if (access(bpath, F_OK)) {
		printf("not ok %d %s # %s missing\n", nr, mode_name[mode], bpath);
		goto out_kill;
	}

	/*
	 * The partition scan runs from a workqueue and holds the disk's
	 * open_mutex while the server serves its reads. Wait for its first
	 * read, then open the device ourselves: that blocks until the scan
	 * is done, and only then may the server vfork.
	 */
	deadline = now() + 10;
	while (!scan_reads) {
		unsigned op;

		if (read_line(a[0], line, sizeof(line), deadline) <= 0) {
			printf("not ok %d %s # no partition scan read: %s", nr,
			       mode_name[mode], line);
			goto out_kill;
		}
		if (sscanf(line, "IO op=%u", &op) == 1 && op == UBLK_IO_OP_READ)
			scan_reads++;
	}
	for (i = 0; i < 100; i++) {
		fd = open(bpath, O_RDONLY);
		if (fd >= 0 || errno != ENXIO)
			break;
		usleep(100000);
	}
	if (fd < 0) {
		printf("not ok %d %s # open %s: %m\n", nr, mode_name[mode], bpath);
		goto out_kill;
	}
	close(fd);

	deadline = now() + HANG_SECS;
	if (write(b[1], "g", 1) != 1)
		goto out_kill;
	for (;;) {
		unsigned st;
		int pid;

		ret = read_line(a[0], line, sizeof(line), deadline);
		if (ret < 0) {
			printf("# %s: no progress for %ds\n", mode_name[mode], HANG_SECS);
			dump_family(srv);
			printf("not ok %d %s # server %d stuck in vfork(), child's block device release waits for it\n",
			       nr, mode_name[mode], srv);
			goto out_kill;
		}
		if (ret == 0) {
			printf("not ok %d %s # server died\n", nr, mode_name[mode]);
			goto out_kill;
		}
		if (!strncmp(line, "IO ", 3))
			continue;
		if (sscanf(line, "VFORK %lf %d", &t_vfork, &pid) == 2) {
			printf("# %s: vfork() returned after %.2fs\n", mode_name[mode], t_vfork);
			continue;
		}
		if (sscanf(line, "DONE 0x%x %lf %lf", &st, &t_vfork, &t_done) == 3) {
			printf("# %s: child reaped after %.2fs, status 0x%x\n",
			       mode_name[mode], t_done, st);
			if (WIFEXITED(st) && WEXITSTATUS(st) == 0 && t_vfork < HANG_SECS / 3) {
				printf("ok %d %s\n", nr, mode_name[mode]);
				rc = 0;
			} else {
				printf("not ok %d %s # status 0x%x vfork %.2fs\n",
				       nr, mode_name[mode], st, t_vfork);
			}
			break;
		}
		printf("# %s: %s", mode_name[mode], line);
		if (!strncmp(line, "FAIL", 4) || !strncmp(line, "DEAD", 4)) {
			printf("not ok %d %s # %s", nr, mode_name[mode], line);
			goto out_kill;
		}
	}
	waitpid(srv, &status, 0);
	srv = 0;
out_kill:
	if (srv > 0) {
		printf("# %s: killing server %d\n", mode_name[mode], srv);
		kill(srv, SIGKILL);
		deadline = now() + 10;
		while (waitpid(srv, &status, WNOHANG) != srv) {
			if (now() > deadline) {
				printf("# %s: server %d does not die\n", mode_name[mode], srv);
				dump_family(srv);
				break;
			}
			usleep(100000);
		}
		printf("# %s: server %d reaped\n", mode_name[mode], srv);
		watch_children(mode_name[mode]);
	}
	if (dev_id >= 0)
		cleanup_dev(dev_id);
	close(a[0]);
	close(b[1]);
	return rc;
}

int main(int argc, char **argv)
{
	int rc = 0;

	if (argc > 1 && !strcmp(argv[1], "--child"))
		return 0;
	setvbuf(stdout, NULL, _IONBF, 0);
	if (access("/dev/ublk-control", F_OK)) {
		printf("not ok 1 # no /dev/ublk-control\n");
		return 1;
	}
	if (argc > 1) {
		for (int m = 0; m < 3; m++)
			if (!strcmp(argv[1], mode_name[m]))
				return run_mode(m, 1, argv[0]);
		return 1;
	}
	rc |= run_mode(MODE_EXEC, 1, argv[0]);
	rc |= run_mode(MODE_CLOSE, 2, argv[0]);
	rc |= run_mode(MODE_EXIT, 3, argv[0]);
	{
		struct dirent *d;
		DIR *dir = opendir("/proc");

		while (dir && (d = readdir(dir))) {
			pid_t pid = atoi(d->d_name);
			char path[64], comm[64] = "";
			FILE *f;

			if (pid <= 0 || pid == getpid())
				continue;
			snprintf(path, sizeof(path), "/proc/%d/comm", pid);
			f = fopen(path, "r");
			if (!f)
				continue;
			if (fgets(comm, sizeof(comm), f) && !strncmp(comm, "vfork_ublk_test", 15))
				dump_task(pid, "leftover");
			fclose(f);
		}
		if (dir)
			closedir(dir);
	}
	return rc;
}

--5pdgwqct6uuqapc3--
