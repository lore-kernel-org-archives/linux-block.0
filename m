Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5D3CAE60
	for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791674306; cv=pass; b=kCZFKYPnb5k6k3khcoyTSXRy4mKJir9hwBDix9XHdW2T3ItLbmEQ4s9DL4eFrzNcxWtzi4RdrLLy2eeStgR2CcjJ7vYKnX7Y6m570ekgxGfxECTeRcqGI2N4IVaNNb/l9BWLtHZ7JHvXb9/WZBrnjUPb0sYzJwr1en/4yxh1Rs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791674306; c=relaxed/simple;
	bh=355EGaUJYFZp6jfpqSYkvIRp6cHIUjGi7YkRprB+maw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ac00d2lRRLbPj3SwsbHdrc27xIFTLDGeBnub1DiL+OEzLXdef+KH1k84yhKB6n4ETBadvx71uICaCIyLWQidmSfNWkQIAfdHeIt7+5/cP+tqpUXsgHnu4vCikTJkSvyooHF1h2ePnqYMgwO76QcTaBTdUAy665ttxkP07Q6wt4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRiOoL60; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRiOoL60"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6acbdbc1725so993085a12.3
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 16:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791674303; cv=none;
        d=google.com; s=arc-20260327;
        b=YW5Q3fqgkQVw0PA1h4QyYnyVIRQziFE+B8D5z2qd9Y9jlyT3RrCwBo5VH5bRsECtRF
         oqMrP+tJpCQAMdRcvFgyxtZNa+ox0j9zqUoO18QQogZ7S7nrxoqoVRHvzrh3DUBOuIon
         uIozcCVkCiKXHNy0Y4ekn/7Uk8V9hnAnbcpIbu4VJqRMCKyZlzhSDUQVfw7AhNEVDiku
         dXYZIuaU2AC+c5DzgE4J3a/sWB9zflx2P43B0pc6lNzTSNjK62uG0+++i+0hkk88ygSo
         yXs4x+HBtYJqlw6JOmQsMe4kljSGiBZCkm47ciLQcyCbkQ9opYKRyjoh6PXZ3/zZsgX8
         LKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/r4ycoL5XfheLLaA5R+/7a/5lId96HKcGHX0fF2Fjio=;
        fh=1gGoDRYI+3kpmUey+hZd5HIXwxFTUiOWMvfO7vHLoms=;
        b=E5P34xpkQsNr7x9iWYdIOPZhK56Ke+97Ee0cLUR23C0HzbK995j8qtt6zPERR/2oD+
         nUvhSSaW4ykshXhR0K/VkNKB/jTgzYmuNWyzWLU4DE8TGci6NKawaXPpNt3VyYMurNd5
         PW1eflFdJiWPb0l+fLfNX+iHF48oy/+VJusEFnGJvqkM1u3PM4z6j2jmt4MACq6vx3EP
         ja/OorqTew8HzHpOMl0dTBdEgzBi2IuUYhLqf6jStHOfjTEKnBePPNNzOswJcBIqn/WR
         Qb6u9zUXVJMbcUZX0dVFBU49CF16MTFfKn1HUI4lXyCK3vBmVXrb6PC3y7QWenPSrR+m
         rtdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791674303; x=1792279103; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/r4ycoL5XfheLLaA5R+/7a/5lId96HKcGHX0fF2Fjio=;
        b=FRiOoL60ig2HK+mClImRndM4XVIM6Vqj0R0K+0P+/jDRVBlQ/ds6EsW2KMPLg+QjQt
         Qzd4h7talT7GAUzoOsbWuceo0ptGVqEiDSTVcg/ZL6SLgkKNPLFGZH4EPEPwlhXqmoz6
         NBQyghecWuMmaFn4mKehCmA0bAAVTye5ZEpnjGw3i8SmTG7Bu/Bd0klXcPd6gAmMUXBL
         RCGxEl+VbmlxnWObWrvMxHF36M5w+1Fre2jobszYGl6R2Rf0HdQBoTPRTeWbeE4/QC8s
         1pQeOeVyyIwgkjt3hLnmQiCePmho7L/BuBONWRuVvtbghblCqCW7QRrzEhVxulIiw2cn
         fuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791674303; x=1792279103;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/r4ycoL5XfheLLaA5R+/7a/5lId96HKcGHX0fF2Fjio=;
        b=25TD9ZJOEYSwFy94NC1a19ma4YJoZGlFafS0Nx95+6zEOuqWxMPawOvdteIaxn3U4V
         hnLdW1lRtqnE/VohAtzFKHzYk9wInlS1xliDUfQMEKL9r39RKlFXVVbKEBVoTHiOYDwv
         UNwBA8SJjPQQPbRPX5c81qfIerKeyNnxevlI4O8WGQQykWYKN9KpRIX9IzWN4IgjoTRe
         00FwMUDaKI7C8fK/j4QPrtzuv3tL53P48iCHAc2BwG/hLbapveYtqYlB8Slz5aagVJko
         e7NpxX4rWoxSa8cAqObOaPy3X/PgmG6GYCxVopxF/1M/fwDYZtvnCLvsZlSa69/gWbIU
         gcjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzENe73gyj1NYEPRHJM58I+SiSndqi5kY0c8DKzL2Em+9aDvJOCdWA3L9dOuTvjAOZ5wpyYBKSmzDEA3Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIngIq8ZdQ6Dy9KpQznLue3wjqQf1nPvwSrAYYQd8BcV6RqMm0D
	BJ4mn1PzT1G4VgDyOG5NW8rMTH2fqurhoyP9mStOMCc3uSItTdg4IRVeTMsOtMO6lqz1q/R+IME
	cZim1WngSXdJiqkr3wGTFew3BS+rxrzsXpi724jY=
X-Gm-Gg: AYBFou19kgcO0rJb0hPCy2BHBzgUfNcZKiPLsldHJGy6sNfUCdppGDyG+35JS30DX+s
	cdUHA6oH6Q0wL9qb05X9gcWgajn8i+76pXO3+FGqNn/xfOahroe4WNpAwAgwLQHdriHdccMYmgk
	gPmDqDZjHQ/IJ9mMkQxAULhktBIAOUfot2awOD3TiJvQNKV9gzc5rbOSnGOCo8iGOWimdrCFIgB
	OGcJMB/q/6lO5eZwYF3CXuDI5QJHTIMbeeLTSi1yfsUK1WC7JaljsFtE3IbtLGCX8hYffppi9hD
	/4q6bGRF8Ss2jZxxntncxO3nE0mg/p8iOsqNnjy9pBd2Ta8duZnLV1Kv2PiW3YC6GnplY2S9Swz
	F4eLPVMA2Y3+vXImBZY3c+BK8upGGyp2TlII6tNUfSS6fHQ==
X-Received: by 2002:a17:906:c142:b0:c21:9870:c4f7 with SMTP id
 a640c23a62f3a-c31aa029203mr562427066b.20.1791674302874; Sat, 10 Oct 2026
 16:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eugene Siegel <elzeigel@gmail.com>
Date: Sat, 10 Oct 2026 19:18:10 -0400
X-Gm-Features: AclHuK9Guq-V0L3VJ_CEXxIk0the-6HfwbRa7Dk_Yxlhnb03THqA0y82XVl_pC4
Message-ID: <CALkdYjXcbwUW0=Eb52Fu1X+kLyVxVYZC0D3iEL-E+BmH6C7FkQ@mail.gmail.com>
Subject: Re: [syzbot] [io-uring?] WARNING in io_wq_put_and_exit (2)
To: syzbot+b0d54b9e81de55179e47@syzkaller.appspotmail.com, 
	io-uring@vger.kernel.org
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "tom.leiming@gmail.com" <tom.leiming@gmail.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi (hope I'm cc'ing the right people),

Using an LLM and a deterministic hypervisor, I was able to reproduce
one instance of this
happening that occurs sometimes with a process submitting
UBLK_U_CMD_START_DEV and being
killed or exiting shortly after. It leaves an unkillable process around.

The process did the following:

1. open /dev/ublk-control
2. io_uring_setup
3. send UBLK_U_CMD_ADD_DEV with 1 queue of depth 4
4. SET_PARAMS

The process did not send UBLK_U_IO_FETCH_REQ. This way the queues are not ready.

5. send UBLK_U_CMD_START_DEV, since it will block, it will get queued. A worker
   will spawn here in the idle state.
6. do_exit is called. io_wq_put_and_exit will set IO_WQ_BIT_EXIT and later calls
   io_wq_exit_workers which will wake workers with
__set_notify_signal. Then this thread will
   wait in wait_for_completion_timeout.
7. io_wq_worker will get_signal while still idle and exit the loop because the
   IO_WQ_BIT_EXIT bit is set. Then, io_worker_handle_work is called.
There is work on
   the queue and this worker thread will call ublk_ctrl_start_dev.
This will call
   ublk_wait_dev_ready_and_lock which needs ublk_dev_ready to return
true. Because the
   process did not send UBLK_U_IO_FETCH_REQ, this will always be false
so it will keep
   waiting.
8. no progress is made, so the trace happens after IO_URING_EXIT_WAIT_MAX.

This race depends on the worker being idle and not having run earlier.
If the worker has
already run the item on the queue, then it would be waiting in
ublk_wait_dev_ready_and_lock
and return -EINTR instead.

I think this is just one instance of this bug, there might be
unrelated instances also
in io_wq_put_and_exit.

LLM-generated test case (7.3-rc6 (3857c2fe5449), KASAN, 1 CPU, needs
root and CONFIG_BLK_DEV_UBLK) below. Note this will leave unkillable
process on machine. If you run with an argument of 400, see dmesg to
observe the WARNING.

```
// io_uring worker shutdown hangs behind ublk START_DEV.
//
// A child process adds a ublk device, queues UBLK_U_CMD_START_DEV through
// io_uring and exits straight away, before the io_uring worker has picked the
// request up. Exit signals the worker once; the worker consumes the signal in
// its main loop, then runs the still-queued request and sleeps in
// ublk_wait_dev_ready_and_lock() for a device that can never become ready.
// The child never finishes exiting; after 5 minutes the kernel prints
//   WARNING: io_uring/io-wq.c:... at io_wq_put_and_exit
//
// Needs root, CONFIG_BLK_DEV_UBLK, CONFIG_IO_URING. No kernel change. Timing:
// the child must reach exit before the worker runs. Pinning to one CPU and
// running as SCHED_FIFO (see child()) makes that ordering deterministic.
//
// Usage: repro [wait-seconds]   (default 20; use 400 to see the WARNING too)
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <linux/io_uring.h>
#include <linux/ublk_cmd.h>
#include <sched.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <unistd.h>

static int ring_fd;
static unsigned *sq_tail, *sq_mask, *sq_array, *cq_head, *cq_mask;
static struct io_uring_sqe *sqes; // 128-byte entries (IORING_SETUP_SQE128)
static struct io_uring_cqe *cqes;

static void die(const char *m)
{
perror(m);
_exit(1);
}

static void ring_init(void)
{
struct io_uring_params p = { .flags = IORING_SETUP_SQE128 };

ring_fd = syscall(SYS_io_uring_setup, 8, &p);
if (ring_fd < 0)
die("io_uring_setup");
size_t sq_sz = p.sq_off.array + p.sq_entries * sizeof(unsigned);
size_t cq_sz = p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe);
char *sq = mmap(0, sq_sz, PROT_READ | PROT_WRITE, MAP_SHARED |
MAP_POPULATE, ring_fd, IORING_OFF_SQ_RING);
char *cq = mmap(0, cq_sz, PROT_READ | PROT_WRITE, MAP_SHARED |
MAP_POPULATE, ring_fd, IORING_OFF_CQ_RING);
sqes = mmap(0, p.sq_entries * 128, PROT_READ | PROT_WRITE, MAP_SHARED
| MAP_POPULATE, ring_fd, IORING_OFF_SQES);
if (sq == MAP_FAILED || cq == MAP_FAILED || (void *)sqes == MAP_FAILED)
die("mmap ring");
sq_tail = (unsigned *)(sq + p.sq_off.tail);
sq_mask = (unsigned *)(sq + p.sq_off.ring_mask);
sq_array = (unsigned *)(sq + p.sq_off.array);
cq_head = (unsigned *)(cq + p.cq_off.head);
cq_mask = (unsigned *)(cq + p.cq_off.ring_mask);
cqes = (struct io_uring_cqe *)(cq + p.cq_off.cqes);
}

// Put one ublk control command in the submission ring; if wait, submit it and
// return its result.
static int ctrl(int ctl_fd, unsigned op, struct ublksrv_ctrl_cmd *c, int wait)
{
unsigned idx = *sq_tail & *sq_mask;
struct io_uring_sqe *sqe = (void *)((char *)sqes + idx * 128);

memset(sqe, 0, 128);
sqe->opcode = IORING_OP_URING_CMD;
sqe->fd = ctl_fd;
sqe->cmd_op = op;
memcpy(sqe->cmd, c, sizeof(*c));
sq_array[idx] = idx;
__atomic_store_n(sq_tail, *sq_tail + 1, __ATOMIC_RELEASE);
if (!wait)
return 0;
if (syscall(SYS_io_uring_enter, ring_fd, 1, 1, IORING_ENTER_GETEVENTS,
NULL, 0) < 0)
die("io_uring_enter");
int res = cqes[*cq_head & *cq_mask].res;
__atomic_store_n(cq_head, *cq_head + 1, __ATOMIC_RELEASE);
return res;
}

static void child(void)
{
// Run as SCHED_FIFO. The io_uring worker is created as a thread of this
// process and inherits the policy and priority; a FIFO task is not
// preempted by a wakeup of an equal-priority one. So when START_DEV is
// queued the worker stays runnable-but-waiting until this task blocks,
// which is inside exit. Without this the worker may preempt us right at
// the wakeup, reach the ublk wait first, and be interrupted normally.
struct sched_param sp = { .sched_priority = 1 };
if (sched_setscheduler(0, SCHED_FIFO, &sp))
perror("sched_setscheduler(SCHED_FIFO)");
int ctl = open("/dev/ublk-control", O_RDWR);

if (ctl < 0)
die("open /dev/ublk-control");
ring_init();

struct ublksrv_ctrl_dev_info info = { .nr_hw_queues = 1, .queue_depth
= 4, .max_io_buf_bytes = 1 << 20, .dev_id = -1 };
struct ublksrv_ctrl_cmd c = { .dev_id = -1, .queue_id = -1, .len =
sizeof(info), .addr = (unsigned long)&info };
int r = ctrl(ctl, UBLK_U_CMD_ADD_DEV, &c, 1);
printf("ADD_DEV: %d (dev_id %u)\n", r, info.dev_id);

struct ublk_params prm = { .len = sizeof(prm), .types = UBLK_PARAM_TYPE_BASIC,
.basic = { .logical_bs_shift = 9, .physical_bs_shift = 12,
.io_opt_shift = 12, .io_min_shift = 9, .max_sectors = 8, .dev_sectors
= 1 << 16 } };
c = (struct ublksrv_ctrl_cmd){ .dev_id = info.dev_id, .queue_id = -1,
.len = sizeof(prm), .addr = (unsigned long)&prm };
printf("SET_PARAMS: %d\n", ctrl(ctl, UBLK_U_CMD_SET_PARAMS, &c, 1));
fflush(stdout);

// Queue START_DEV (ublk control commands always go to an io_uring worker)
// and exit at once: nothing here blocks, so on one CPU the worker has not
// run yet when the exit starts.
c = (struct ublksrv_ctrl_cmd){ .dev_id = info.dev_id, .queue_id = -1 };
c.data[0] = getpid();
ctrl(ctl, UBLK_U_CMD_START_DEV, &c, 0);
syscall(SYS_io_uring_enter, ring_fd, 1, 0, 0, NULL, 0);
syscall(SYS_exit_group, 0);
}

int main(int argc, char **argv)
{
int wait_s = argc > 1 ? atoi(argv[1]) : 20, st, i;
cpu_set_t one;
char cmd[320];

CPU_ZERO(&one);
CPU_SET(0, &one);
sched_setaffinity(0, sizeof(one), &one);
pid_t pid = fork();
if (!pid) {
child();
_exit(0);
}
for (i = 0; i < wait_s; i++) {
if (waitpid(pid, &st, WNOHANG) == pid) {
printf("child exited normally after %d s: NOT reproduced\n", i);
return 0;
}
sleep(1);
}
printf("child %d still not reaped after %d s: REPRODUCED (stuck in
exit)\n", pid, wait_s);
fflush(stdout);
snprintf(cmd, sizeof(cmd),
"for t in /proc/%d/task/*; do echo \"-- $t $(cat $t/comm)\"; head -6
$t/stack; done; "
"dmesg | grep -A3 'WARNING: .*io-wq' | head -5",
pid);
return system(cmd) != 0;
}
```

Eugene Siegel
