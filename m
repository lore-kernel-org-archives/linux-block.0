Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795218025;
	b=x9OgLwOSfM8G02qvT6G/lo3mIpUTLm5j8lBYttdPQ3NFFpz66K3Im2oKxzZhCDd1jrMk
	 IzBDRdBX7Wnu9KpWYB1KA2oul4TzeB3/C9xcR67Zdo2EzAMbE2feDSdAiXbL+jMKV492N
	 s/SwFcl/ECIRJXAv4gnjOc+vm4ouZBJHcFsaLmEysG894LAcCiXS0uCq3ojN2zAAmiS8j
	 /pbRaz+pqGewkRCbjpQC092coO9sMkQRIKSqe55QOVGmj6KI+Lp+UjtiKAC4lFG0jO4fa
	 eYbX/2u0JuYhFxx8j9bmAwleV6EFYXcz0PMwxhjhLTjBkHhrpwhACouzGvbpl3RXXbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795218025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=P575Q9brE/+upDEGKX8xapQROmOnKTqfCZs6ZbbAFyE=;
	b=XZtirR7//BvJZ+LhqdGGSPszrTN1N/+im8msuEx7OlcRIVXRJGjWQTZRkWDbHcjrRxxc
	 x7wMsoutly0hJBnjRZ8Zl01n3OJzhcJwriB1PgQbSC9nvlYuBoyfMwix8E4bcSUcpdG9R
	 oCK923x2GNGOx2llFchvjE6zrec54CbAHoXxx2V625MHWWgNK10ug/DtKr5Oy9o4BhBNb
	 MhurG9hZd4drE1XM8qKBagQ9D4n0ipcP3V+lhOon6EFgpXluSFvz0xuvmilmn/IACWXW+
	 gaibzZ6z9EIP64jXQKQYnYCHPk+VNS74GyDNb40c3Medlsz4P8OvykfD23DWgNL9dcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LTsIrEnj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A8D606A698
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 23:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05A8D606A698
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LTsIrEnj
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-679aeeddc6bso1462986d50.2
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 15:40:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795218022; cv=none;
        d=google.com; s=arc-20260327;
        b=kSuf6GahnSW6KwfEWQy1xeL2RWlZ71/+w6GY8LLiRcgoPqs6+Eqj0qxBVGODiANK8u
         kut3F2HNMsCdSO5V+ZOPUJ23gmdQub4yaMJWP1F3b/EPk+AUvR7j7frBGycYzXio8nIm
         rx5UTyfkxknzQNpcd12HwsW/q2BiIVtocgXdtMQaMEUVgIYlsO6Cu8UzUgbuPyE2qLut
         5zN3OiBhmhrBUSoTvH1Buy2nciKRisKNcKolTrUX2bQz3Xxlo1R67fJuJh44iVJdX249
         MEMgPhhCs9qYHThfZfwIjo/4s8LI/uP8FgqEoYa6REniPbZm2Lp0+Myov+r7/FIOgHbe
         1JQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P575Q9brE/+upDEGKX8xapQROmOnKTqfCZs6ZbbAFyE=;
        fh=nywHiBQObux+AKTKPL09//ZFUzAcz+dNIMyPSYw0jIQ=;
        b=ox+CNrNKWDP0Vwopt8ATxB27EzbBEbv6uxrIMxRNvdNOvj2SGieoj9AjaJoKWi0qGx
         qSUw4JbJax4pvgLVSwLYuaPlbrzcL331YPp4C/C9W4ymrgO3a36eWCg6fjSBXlFX+vtr
         cpdIF8pQCqK8rrjeSRJwPUrrEVtS3MMSKAlLymxsBLHrBvt5nQyDoaNzuiT8MjLbIoIO
         +NJhGTUApkCLw6mURihz/vmcJUm/BsNqRRSJlIQbS9/NkDtTsqbSwg+piAzznhBCxVys
         reuv4gZiyseudeDPtsDXzW8cSvOiup+HJmlWPlCNFFI4LemVQIN6ygfiG4mNuAoLtkuL
         ilog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795218022; x=1795822822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P575Q9brE/+upDEGKX8xapQROmOnKTqfCZs6ZbbAFyE=;
        b=LTsIrEnjM1Z8Scsa2rHSnmi2P0zH2qbuHBDRFUWRw9ZO2ElAGo3z2FrSd7b92HKRDu
         dPKCdW45zD4QsSNXsPAi/rNZxAFc+k2BqoJPuOiteVkxmWFNXKgmVu6nnn+wjkXst1Yt
         EYN9Umf3jHCRB7lQIyasjUjJyshUeEjhPEId0YExsUNEKeEzVLBzwAwO/lox0tiM+oe6
         RT7FSk7LaNdAQ3zVQvN5tYsWNx9wxZzKggIYdMUe8u8wzHA9pf5ve3DKetSeYTp9fZhV
         lpq6eg+iFRZFSGzjmoclOByYKK4SgoeqIArkjPyRbvnYRfV7XYdYCtnseEmdHbE+PZ+i
         6IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795218022; x=1795822822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P575Q9brE/+upDEGKX8xapQROmOnKTqfCZs6ZbbAFyE=;
        b=1pqT88CgGpo96EeD0qj5KRGl/A4HOypdMK768J4Zh4msVr/ZPLvd5w2vGC4pjEPCbI
         xQRGctXC8sPWbsoomKnwjBqERBLkSzKeCo90znG9D+iFXZQhBK3DiEXGQstg7Pg97DdJ
         Kqve24S9+c7eRiGwdgFNaDU7VCGw6DgcNgyG3sQk4WT5bPd24l8jt2dSqfIMd17rwgt5
         HcCAntdUPSvaQyVaQtfQSJ79/UImh2bVfd5YCdVfhNzIGVZ2g0YgEBqLJ27DiFOTpFe3
         sXGggXbZSqW3NZaaXUzdivS7PnN8o7IdJWpL7xLK9HlwDHdROul2N0Dcg4ggOSv/PO+S
         N2cA==
X-Gm-Message-State: APuU4Z9YFzuRzZkXEV7U6cNEeGOnBHs8r15twNgbwl9FW9NHMAle486s
	ujDIUHyxDaB7W5OES4l6CZdjJtJ7DI3cHhJSYV99/zbxf8FmkEAOBqgYithxQb8q4XCNAmgPp9M
	sigwelg/Qi6FAmF2P+OPiDWgoEYIjiNU=
X-Gm-Gg: AZFdTZeqqDPNR3E7IJB4RgmmHjvNkeVolAxAEpJXKqBU+YGUJozP7OTJpItA/nsuNas
	U0AIf62BxCLukhhlmWJfQTN8iX6TavQ5Hv8OGPQrDOI5I06fbeW29Ic4GUQL6VUkoTfOzGbaHNc
	xyNqh5niCGE5ZMzvZouAX47jgDsXKO66zrBAXI4mkSW4CNQGqZTJPFB1C4Exx/vfKs89548Q1ze
	QjV2/b6h1ZnH1/tewHRsuV5spfuoYLB3Ogwy2fAOI1gQqPoYT2XIT+erM2XOeLk9prkExfd2/kw
	GMt1GSzWAymLnSJH99M+S+bzsGyx5JIeTgZBm5n8/OrZN0eXRgDM6TCa4JuJmuV2y9aVgItEsnI
	DpXMzhFSuUZMMip2DVNZzbugKPHfc/pZgkuU=
X-Received: by 2002:a05:690e:478f:10b0:67d:c046:4f74 with SMTP id
 956f58d0204a3-67df44234b3mr1082543d50.25.1795218022001; Fri, 20 Nov 2026
 15:40:22 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFS5DSFUi28HgX8t5bRRGVqPkOZ+VqrP+LtyMiwPQhyRpTxFTg@mail.gmail.com>
 <556c4720-0159-4874-8d5b-6379566f6d4a@bsbernd.com>
In-Reply-To: <556c4720-0159-4874-8d5b-6379566f6d4a@bsbernd.com>
From: Luciano Lo Giudice <lmlogiudice@gmail.com>
Date: Fri, 20 Nov 2026 20:40:09 -0300
X-Gm-Features: Aa3M54rtJZ9pDNW5zIOi0412D3UCWrKeKTEw-1RlRRJd1NmXScLarnrzrZaMguk
Message-ID: <CAFS5DSEhgk8fJgAwEn+-U-7vnBchCrx6L1uReT3Upm+AA22=Wg@mail.gmail.com>
Subject: Re: [REGRESSION] ublk: dispatched IO intermittently never posts its
 fetch completion (v7.0)
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	regressions@lists.linux.dev, axboe@kernel.dk, stable@vger.kernel.org, 
	Ming Lei <tom.leiming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Bernd,

Yes, I can do that. I'll go ahead and compile ublk_drv from your repo
for the 7.0 backport and see how that goes.

All the best,
Luciano.

On Fri, Nov 20, 2026 at 8:27=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 11/20/26 23:55, Luciano Lo Giudice wrote:
> > From: Luciano Lo Giudice <lmlogiudice@gmail.com>
> > To: linux-block@vger.kernel.org, io-uring@vger.kernel.org
> > Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
> >     stable@vger.kernel.org, regressions@lists.linux.dev
> > Subject: [REGRESSION] ublk: dispatched IO intermittently never posts it=
s
> >  fetch completion (v7.0)
> >
> > Hello everyone,
> >
> > I'm writing a library that implements various block devices in userspac=
e by
> > utilizing the ublk framework. Every so often, I'm hitting a completion =
loss on
> > Linux 7.0, in which an inflight request is lost forever, which leads to=
 an
> > unkillable process and a ublk block device that cannot be torn down, an=
d so the
> > machine needs to be rebooted to remedy this. I've tested the attached r=
eproducer
> > on 6.8, but found no hangs after many runs. Details of the bug are belo=
w.
>
> Hi Luciano,
>
> I just scanned the io-uring list and found this by accident. I have been
> working on this for a couple of month.
>
>
> Would you be open to test a specific branch or dkms module? I actually
> wanted to send this to upstream last months already, but then found and
> fixed (with a lot of AI help) more issues and also got busy with other
> tasks.
>
> https://github.com/bsbernd/linux/tree/ublk-stop-races-with-tests-for-7.3
>
> and here the backports, that also work on 7.0 (with a compat patch) and
> that is used for our dkms module
>
> https://github.com/bsbernd/linux/tree/niova-ublk-7.1-fix-backports
>
> The 7.3 patches are actually verified through tla+ and an ublk branch
> for https://github.com/brauner/linux-formal
>
>
> @Ming the patches for 7.3 include heavy ublk state changes (it is now a
> bit closer to what fuse-io-uring does) and also adds debugfs that can be
> used understand state issues.
>
>
> Thanks,
> Bernd
>
>
> >
> > 1. Environment
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - Breaks on 7.0.0-31-generic and 7.0.0-43-generic using the kernels tha=
t ship
> >   with Ubuntu. Tested on amd64 and the ublk_drv module.
> > - An identical binary was run on 6.8.0-117-generic but no hangs were re=
produced.
> > - This was run on virtual machines provisioned with LXD and with 4 CPUs=
.
> > - After reading the code, I suspect the issue arises due to the 2025 re=
work (the
> >   list batching first appeared in 6.15 and the per-IO task tracking in =
6.16).
> >   I have not run any kernels between 6.8 and 7.0
> >
> > 2. About the attached reproducer
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - It's a single C file that requires only liburing.
> > - 3 devices are loaded (2 are file-backed, the other memory-backed).
> > - A fourth device is added, started, loaded (briefly), stopped and
> >   deleted in a loop while the others are under loaded. This is the
> >   fastest way I found to reproduce the issue.
> > - On 7.0, this hangs within the first 2 runs. On 6.8, no hangs were
> >   observed after more than 10 runs. When the issue is detected, the
> >   program prints what evidence it can gather (per-device inflight
> >   operation numbers, the running threads' waiting channels and the
> >   io_uring's pending CQE counts).
> > - Bonus: 2 additional bugs where found when shrinking the workload:
> >   A queue was leaking its io_uring (keeping the chardev pinned), and
> >   START_DEV issued for a queued that had died before arming. Both stall=
ed
> >   the program identically on 6.8 and both were fixed in the attached ve=
rsion.
> >
> > 3. What indicates a failure (from userspace's POV)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > - The issue is always connected to a READ request:
> >   /sys/block/ublkb$N/inflight yields "1 0" and is never modified again.
> > - The thread that handles the queue is blocked in io_cqring_wait (as se=
en by
> >   inspecting /proc/$TID/wchan), byt the ring has no entries to consume.
> > - The ublksrv_io_desc for the corresponding tag was written by the kern=
el
> >   at dispatch. The server reads descriptors after a CQE is posted, but
> >   this never happens.
> > - There is no way (AFAIK) to recover the tag. The lost completion is th=
e
> >   one that would set UBLK_IO_FLAG_OWNED_BY_SRV so a COMMIT_AND_FETCH fo=
r
> >   the tag is rejected (returns -EINVAL).
> > - Something very similar also shows on the control plane, which is why =
I
> >   suspect shared implementation details rather than something queue-spe=
cific.
> > - START_DEV, STOP_DEV and DEL_DEV will occassionnally never post their =
CQE
> >   after the kernel provably completes. In one capture, the deleted bloc=
k
> >   device was already gone from /sys/block when the caller's 30 seconds
> >   time bound fired. Repeated re-enters never produced the completion.
> > - DEL_DEV was seen stalling 30-90 seconds on the kernel for operations =
that
> >   should complete instantly. The io-wq worker thread was blocked in:
> >
> >   ublk_ctrl_del_dev
> >     del_gendisk
> >       blk_mq_freeze_queue_wait
> >
> >   the device was stuck half-deleted, and it reacted to ADD_DEV by retur=
ning
> >   -EEXIST for minutes. In the worst instance it survivied its own serve=
r
> >   exiting and stayed un-deletable (needed a reboot).
> > - A START_DEV completed with -EINTR. The process was detached and arms =
no
> >   signal sources. I didn't capture the pending signal set in that insta=
nce,
> >   so I cannot rule out a spurious signal, but the same op's immediate r=
etry
> >   stalled for a full 30 seconds.
> > - Not needed to repro the bug: COOP_TASKRUN, readahead bursts, eventfd =
wakeups.
> >
> > 4. Aftermath
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - AFter the request is lost, teardown hangs and takes the control plane=
 with
> >   it. Looking at /proc/*/wchan and dmesg of a hanged instance shows tha=
t the
> >   teardown uring command (running in an io-wq worker) is stucj in
> >
> >   ublk_stop_dev/ublk_ctrl_del_dev
> >     del_gendisk
> >       blk_unregister_queue
> >         elevator_set_none
> >           blk_mq_freeze_queue_wait
> >
> >   And the message printed by the kernel is:
> >
> >     INFO: task iou-wrk-2115:2118 blocked for more than 122 seconds.
> >     [...]
> >      ublk_stop_dev_unlocked.part.0+0x38/0x160 [ublk_drv]
> >      ublk_ctrl_uring_cmd+0x629/0x830 [ublk_drv]
> >
> > - Subsequent control command hangs on the control mutex:
> >     task iou-wrk-12720:12721 is blocked on a mutex likely owned by task
> >     iou-wrk-12626:12629.
> >     [...]
> >      ublk_ctrl_get_params+0x8b/0x190 [ublk_drv]
> >
> > - Killing the process doesn't help. The worker thread keeps waiting on =
the
> >   queue and the frozen queue waits for a request whose owner (the serve=
r) is
> >   gone. On 7.0, ublk_timeout(...) only takes action for unprivileged de=
vices by
> >   SIGKILL'ing the server. On privileged processes it retursn BLK_EH_RES=
ET_TIMER
> >   so a lost request is re-armed forever and never aborted, even when th=
e
> >   server is dead.
> >
> > - When the process exits, the io_uring io-wq teardown warns while a wor=
ker is
> >   still stuck and the process remains a zombie. The following message i=
s
> >   printed by the kernel:
> >
> >     WARNING: io_uring/io-wq.c:1370 at io_wq_put_and_exit+0x10d/0x2e0,
> >     CPU#3: live_server_ram/2115
> >
> > 5. Where I suspect is the problem
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - Evidence points at the completion side of the 2025 rework.
> > - per-IO task tracking ( ("ublk: require unique task per io instead of
> >   unique task per queue", Pure Storage, 04/2025,
> >   https://patchew.org/linux/20250416-ublk._5Ftask._5Fper._5Fio-v5-0-926=
1ad7bff20@purestorage.com/):
> >   our fetches are all submitted by the queue's own thread, so io->task
> >   should always match at dispatch time;
> > - rq_list batching: ublk_queue_rqs() coalesces same-<ctx_handle, task>
> >   requests into one list and queues a single
> >   io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb) for the
> >   whole batch. If that single task work is lost, every request in the
> >   list strands - the observations are consistent with one lost request =
per
> >   occurrence.
> >
> > 6. Follow-ups
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - Does this ring any bells in the 7.0 completion rework (lost task work
> >   for ublk_cmd_list_tw_cb / ublk_cmd_tw_cb, or io->task mismatch taking
> >   a path that neither completes nor aborts)? Is a fix already in
> >   flight?
> > - Independently of the completion loss: should ublk_timeout() for
> >   privileged daemons fail a request whose ublk server is gone? Today
> >   BLK_EH_RESET_TIMER keeps a lost request - and with it the del_gendisk
> >   freeze and the control mutex - stuck forever after server's death,
> >   which turns a single lost completion into a machine-level hang.
> >
> > I can test candidate patches on 7.0.0-43 or bisect across 6.15-7.0 on a
> > VM, or capture the trace of a missing completion.
> >
> > #regzbot introduced: v6.8..v7.0
> >
> > Best regards,
> > Luciano
>
