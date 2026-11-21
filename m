Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795227981;
	b=R2rwgVrobvV3BahO7DTKDCHofuLw7kaWzV3g2Pxbtk4vo00RUw78rCedq8YFS/X2hCnx
	 8XzdjBFjWovzCbBVPRtw3juylpmnMr7Au2dTAtoJYhR1NO+03O3UYzyZeWq4xzra/EvqY
	 PQDqYrjheSvy2qQfzTun1qNeGPYrKJqPY3aAfcaUuay8Yo7BYGvvWhWVcik2DorVp8VDb
	 uFcrnFg9eIYIeUrNiW8azpUzNXIdssyF9nfl48mzEBX2aBjAzOR/vfjwTsx1F+uClrx65
	 pVZNgvfv7zma2r2tgNwlJHHysxsneZ5SdhBTphYBJOCWJ3wJA6mCaQ2z9cFUdtE6A+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795227981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=qvzvR7eFw18VmCP4IyCpLYFsv+yar7ywiKXjqrHf1do=;
	b=mWkc/R9vF+dueTFlL9RQmH90C1uoFcEB/lEWnAy71E0NrlzU0kS592oeU2zEPRnFGGTP
	 KaxL7dJ4AqYieQQLKGHA7Q3lekHqU1KgtwN+UayOGmba19GfNB4loafP/Zo7rXADdNWKd
	 BXohnKIv62JEXKQSA6y1mOmMjmtnvvy74g4MTyfnqTrkR15wJ4yYtQrPHyoEEXZjJ9WsO
	 xqo/G+/BY239iX1d0a+FaCSXMHLi7atEa8FlSwRdMVVAFX8pCAoP4bGa6R9NujKNq5ljL
	 /BkipKXsE9MtQM4kJF4nwEJn5uZBLgIFZoraU2llexVa7wA/ukKBA2r7092mI4p06OA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V5EMnqUz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D4606A69B
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 02:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D5D4606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V5EMnqUz
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67db35e7953so1762615d50.0
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 18:26:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795227971; cv=none;
        d=google.com; s=arc-20260327;
        b=bM51fImd4/8bn8JKIFwseExGm1R+QWMCFmTUoeswpIOrRcpxO3enzP37F0NIwp6fBE
         wUJN0RDoVdzBpFBwIQ4C4xuCGGzCez8+0R2kentdRe8nffHwGBt+siSeQmPjfESHubSm
         zTfXv6xzF4N8CS6/BKsuHAR4g3TaSSzuc1foyJ5iIvTrGqrXk0QvsMXDRrtf9AO4xbOT
         jHY2T598WS8E/hBfgbvoH+arIlMfFRxXEKd729VG67ZOitUjjbRXvQaOCyG35lBHCKlT
         jeVmdDYEKJGWV3mSaaJ8qVK04Wa4QY9mrN0ucAnGy0apHkUbHuc+YfS/ARGEdi2kM+1m
         Au5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qvzvR7eFw18VmCP4IyCpLYFsv+yar7ywiKXjqrHf1do=;
        fh=nywHiBQObux+AKTKPL09//ZFUzAcz+dNIMyPSYw0jIQ=;
        b=oaZjrS4r4nedTSmWphSqWzehsNXxSWsn47FhNGqpCHc6T3uQmkDYCMY3f9/yuerleJ
         ZlfDTFRkQbogID7nRVDPSt+umYe7VzPSkLWund9JFJSX+J77NSFaldoowb6tB40xC7s1
         odlf66qU6WkRUekn73TWV7WDZ4VQPsDNIM5WSLxYeXGAkF4SwYGEP6ItMRw/dePiR+lr
         J6GCNvWHh6+OKiUuUkq4aUqftP2vzUquLMYHbOk01j4ScG9HhwbU1j2aQHl/nYteq1Yb
         ilG1LA9VCBbZYTTySykl3kJcDgXxff7ZlgDw/6wG3DpmGa+i7QhOzzTX0ynRvGaqOp9o
         f4CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795227971; x=1795832771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qvzvR7eFw18VmCP4IyCpLYFsv+yar7ywiKXjqrHf1do=;
        b=V5EMnqUzwfev+SaM3bHqSQWdq6wINhR0WBksnZ+hiWG1PwAkD6zwtsKAnGZUKFi/lf
         2oC0PKPF0COU643inK8nsUnZleUYXcTBRYdymJ6YF9CDGJ0VvEzwNSgPMaOnmiNX0crt
         CliLMqNgVQvzyXkeTREinriztHT+Jz3lJSW792tUH6WXI/9qq3ATlQ+0VixODm6g+xU+
         8DcRW2MPyWFfVIZu437opgWdlXM1yL3BgKkRNP4GYYS9Ps7cUgLEXHDoUeePQdo43fy+
         sOqfWkWuXeXx43ALizg5YDJR34XEtzNUeIJTRWwKqcWpCExkRifsCd2CMeAkTlpNT35X
         BGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795227971; x=1795832771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qvzvR7eFw18VmCP4IyCpLYFsv+yar7ywiKXjqrHf1do=;
        b=LMIPtUwYzWqulCdFaFH/HdhyC+pAP7P7HCnWQcVEzWu+/u3temKWgckb17hKkN3P9t
         OHVPOffAi8P0OrX0TzuasZlXTCE8AnDPnI+UlcfuE8A+v6AwiZEfy5YOJQyx9BoK9JEW
         RpNkMiUy9f8Nznj3XNZBePYbMY2azMzV8ti8CzAs3mz/pnfbC+x+VWcJ7B0ouWxAkSu6
         RTJb7c6ot3mlr/PbYl3feNCYSM3LUoR9KKQgnibPLwzmaal5nMxF0ZAAd16tUaa3VbZh
         ktqVruPdiQYaXRjDuXnSHAxIrOoQfU53GqKOVGu7wFS/32rDhXjdTUYRGPmf2x4mEhz9
         rE/g==
X-Gm-Message-State: APuU4Z8qGaTbiyFOHThXS6mxKEzxSN6d/mvvxu1Aac3nwKbMQ2Blof1o
	95RUmxBSBejCYwE3BM9CXGSX6poitzUxA4EaLOzpHPp3qPWQ/GnFI0meKjNFaNrTe+CiSr6PJi/
	OxJi3jIUbfDp5cCDKLlqP4eiCmFjBu2M=
X-Gm-Gg: AZFdTZeEZWeOHLnS9E3MKJLteMBsSOeri2+OWqGHCq4jrGe65PUu6tK54UmKVgIUs9i
	bT+OnDN6w6tTlyTMnhGHZ4T1fAGCPdYbLGZfxT8w7+SxZK1Oivn0p6YaMG/HrW5+mPOCE7NIflO
	RiW3OPI5ulhm78oL7htiTpKldBabdypRK5Ow2s5dDExhJRKD6HNz79fytAPowxLzhWV+ayNy5Qa
	ZcchnWp0tox5JGTEwHiTgaxph5sPvIpWdxURZc1v1PPL07IfwPCZRAOPrNy7OWzZGlQ3LaI8NNa
	lW4koBBcT3K4HXb0A08IJ0Op9OmC6YPOD0BZyAl3Z8dFgPERdRFapIYUYx9koJL6DGpqnPZ9XCF
	9UnqdMi4USaV5UsoLei+EVZaJbWZ/Eg/1Hn4=
X-Received: by 2002:a05:690e:1247:b0:67c:f8c:2300 with SMTP id
 956f58d0204a3-67df44d4536mr1726391d50.80.1795227971008; Fri, 20 Nov 2026
 18:26:11 -0800 (PST)
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
 <556c4720-0159-4874-8d5b-6379566f6d4a@bsbernd.com> <CAFS5DSEhgk8fJgAwEn+-U-7vnBchCrx6L1uReT3Upm+AA22=Wg@mail.gmail.com>
In-Reply-To: <CAFS5DSEhgk8fJgAwEn+-U-7vnBchCrx6L1uReT3Upm+AA22=Wg@mail.gmail.com>
From: Luciano Lo Giudice <lmlogiudice@gmail.com>
Date: Fri, 20 Nov 2026 23:25:59 -0300
X-Gm-Features: Aa3M54ojJXgcnAb9fjbJ0QGRhwYz0P_qQIncZccMkVpu2WqI-CMZLaLFuOpuoYw
Message-ID: <CAFS5DSEsdz8Eu1vmeCkE+6eeXgk+9yS6EwqyHSeD2jkq90DZaA@mail.gmail.com>
Subject: Re: [REGRESSION] ublk: dispatched IO intermittently never posts its
 fetch completion (v7.0)
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	regressions@lists.linux.dev, axboe@kernel.dk, stable@vger.kernel.org, 
	Ming Lei <tom.leiming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Using Bernd's repo, I was _unable_ to reproduce the bug after several
runs (it used to hang in about 1 out of 3 runs). I had to add a small
compat layer to make the module build in 7.0, but it was overall
pretty easy. I will be now using this module for any development on
7.0 (thanks, Bernd!) and will report if any other issues arise.

All the best,
Luciano.

On Fri, Nov 20, 2026 at 8:40=E2=80=AFPM Luciano Lo Giudice
<lmlogiudice@gmail.com> wrote:
>
> Hello Bernd,
>
> Yes, I can do that. I'll go ahead and compile ublk_drv from your repo
> for the 7.0 backport and see how that goes.
>
> All the best,
> Luciano.
>
> On Fri, Nov 20, 2026 at 8:27=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com=
> wrote:
> >
> >
> >
> > On 11/20/26 23:55, Luciano Lo Giudice wrote:
> > > From: Luciano Lo Giudice <lmlogiudice@gmail.com>
> > > To: linux-block@vger.kernel.org, io-uring@vger.kernel.org
> > > Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
> > >     stable@vger.kernel.org, regressions@lists.linux.dev
> > > Subject: [REGRESSION] ublk: dispatched IO intermittently never posts =
its
> > >  fetch completion (v7.0)
> > >
> > > Hello everyone,
> > >
> > > I'm writing a library that implements various block devices in usersp=
ace by
> > > utilizing the ublk framework. Every so often, I'm hitting a completio=
n loss on
> > > Linux 7.0, in which an inflight request is lost forever, which leads =
to an
> > > unkillable process and a ublk block device that cannot be torn down, =
and so the
> > > machine needs to be rebooted to remedy this. I've tested the attached=
 reproducer
> > > on 6.8, but found no hangs after many runs. Details of the bug are be=
low.
> >
> > Hi Luciano,
> >
> > I just scanned the io-uring list and found this by accident. I have bee=
n
> > working on this for a couple of month.
> >
> >
> > Would you be open to test a specific branch or dkms module? I actually
> > wanted to send this to upstream last months already, but then found and
> > fixed (with a lot of AI help) more issues and also got busy with other
> > tasks.
> >
> > https://github.com/bsbernd/linux/tree/ublk-stop-races-with-tests-for-7.=
3
> >
> > and here the backports, that also work on 7.0 (with a compat patch) and
> > that is used for our dkms module
> >
> > https://github.com/bsbernd/linux/tree/niova-ublk-7.1-fix-backports
> >
> > The 7.3 patches are actually verified through tla+ and an ublk branch
> > for https://github.com/brauner/linux-formal
> >
> >
> > @Ming the patches for 7.3 include heavy ublk state changes (it is now a
> > bit closer to what fuse-io-uring does) and also adds debugfs that can b=
e
> > used understand state issues.
> >
> >
> > Thanks,
> > Bernd
> >
> >
> > >
> > > 1. Environment
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > - Breaks on 7.0.0-31-generic and 7.0.0-43-generic using the kernels t=
hat ship
> > >   with Ubuntu. Tested on amd64 and the ublk_drv module.
> > > - An identical binary was run on 6.8.0-117-generic but no hangs were =
reproduced.
> > > - This was run on virtual machines provisioned with LXD and with 4 CP=
Us.
> > > - After reading the code, I suspect the issue arises due to the 2025 =
rework (the
> > >   list batching first appeared in 6.15 and the per-IO task tracking i=
n 6.16).
> > >   I have not run any kernels between 6.8 and 7.0
> > >
> > > 2. About the attached reproducer
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > - It's a single C file that requires only liburing.
> > > - 3 devices are loaded (2 are file-backed, the other memory-backed).
> > > - A fourth device is added, started, loaded (briefly), stopped and
> > >   deleted in a loop while the others are under loaded. This is the
> > >   fastest way I found to reproduce the issue.
> > > - On 7.0, this hangs within the first 2 runs. On 6.8, no hangs were
> > >   observed after more than 10 runs. When the issue is detected, the
> > >   program prints what evidence it can gather (per-device inflight
> > >   operation numbers, the running threads' waiting channels and the
> > >   io_uring's pending CQE counts).
> > > - Bonus: 2 additional bugs where found when shrinking the workload:
> > >   A queue was leaking its io_uring (keeping the chardev pinned), and
> > >   START_DEV issued for a queued that had died before arming. Both sta=
lled
> > >   the program identically on 6.8 and both were fixed in the attached =
version.
> > >
> > > 3. What indicates a failure (from userspace's POV)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >
> > > - The issue is always connected to a READ request:
> > >   /sys/block/ublkb$N/inflight yields "1 0" and is never modified agai=
n.
> > > - The thread that handles the queue is blocked in io_cqring_wait (as =
seen by
> > >   inspecting /proc/$TID/wchan), byt the ring has no entries to consum=
e.
> > > - The ublksrv_io_desc for the corresponding tag was written by the ke=
rnel
> > >   at dispatch. The server reads descriptors after a CQE is posted, bu=
t
> > >   this never happens.
> > > - There is no way (AFAIK) to recover the tag. The lost completion is =
the
> > >   one that would set UBLK_IO_FLAG_OWNED_BY_SRV so a COMMIT_AND_FETCH =
for
> > >   the tag is rejected (returns -EINVAL).
> > > - Something very similar also shows on the control plane, which is wh=
y I
> > >   suspect shared implementation details rather than something queue-s=
pecific.
> > > - START_DEV, STOP_DEV and DEL_DEV will occassionnally never post thei=
r CQE
> > >   after the kernel provably completes. In one capture, the deleted bl=
ock
> > >   device was already gone from /sys/block when the caller's 30 second=
s
> > >   time bound fired. Repeated re-enters never produced the completion.
> > > - DEL_DEV was seen stalling 30-90 seconds on the kernel for operation=
s that
> > >   should complete instantly. The io-wq worker thread was blocked in:
> > >
> > >   ublk_ctrl_del_dev
> > >     del_gendisk
> > >       blk_mq_freeze_queue_wait
> > >
> > >   the device was stuck half-deleted, and it reacted to ADD_DEV by ret=
urning
> > >   -EEXIST for minutes. In the worst instance it survivied its own ser=
ver
> > >   exiting and stayed un-deletable (needed a reboot).
> > > - A START_DEV completed with -EINTR. The process was detached and arm=
s no
> > >   signal sources. I didn't capture the pending signal set in that ins=
tance,
> > >   so I cannot rule out a spurious signal, but the same op's immediate=
 retry
> > >   stalled for a full 30 seconds.
> > > - Not needed to repro the bug: COOP_TASKRUN, readahead bursts, eventf=
d wakeups.
> > >
> > > 4. Aftermath
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > - AFter the request is lost, teardown hangs and takes the control pla=
ne with
> > >   it. Looking at /proc/*/wchan and dmesg of a hanged instance shows t=
hat the
> > >   teardown uring command (running in an io-wq worker) is stucj in
> > >
> > >   ublk_stop_dev/ublk_ctrl_del_dev
> > >     del_gendisk
> > >       blk_unregister_queue
> > >         elevator_set_none
> > >           blk_mq_freeze_queue_wait
> > >
> > >   And the message printed by the kernel is:
> > >
> > >     INFO: task iou-wrk-2115:2118 blocked for more than 122 seconds.
> > >     [...]
> > >      ublk_stop_dev_unlocked.part.0+0x38/0x160 [ublk_drv]
> > >      ublk_ctrl_uring_cmd+0x629/0x830 [ublk_drv]
> > >
> > > - Subsequent control command hangs on the control mutex:
> > >     task iou-wrk-12720:12721 is blocked on a mutex likely owned by ta=
sk
> > >     iou-wrk-12626:12629.
> > >     [...]
> > >      ublk_ctrl_get_params+0x8b/0x190 [ublk_drv]
> > >
> > > - Killing the process doesn't help. The worker thread keeps waiting o=
n the
> > >   queue and the frozen queue waits for a request whose owner (the ser=
ver) is
> > >   gone. On 7.0, ublk_timeout(...) only takes action for unprivileged =
devices by
> > >   SIGKILL'ing the server. On privileged processes it retursn BLK_EH_R=
ESET_TIMER
> > >   so a lost request is re-armed forever and never aborted, even when =
the
> > >   server is dead.
> > >
> > > - When the process exits, the io_uring io-wq teardown warns while a w=
orker is
> > >   still stuck and the process remains a zombie. The following message=
 is
> > >   printed by the kernel:
> > >
> > >     WARNING: io_uring/io-wq.c:1370 at io_wq_put_and_exit+0x10d/0x2e0,
> > >     CPU#3: live_server_ram/2115
> > >
> > > 5. Where I suspect is the problem
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > - Evidence points at the completion side of the 2025 rework.
> > > - per-IO task tracking ( ("ublk: require unique task per io instead o=
f
> > >   unique task per queue", Pure Storage, 04/2025,
> > >   https://patchew.org/linux/20250416-ublk._5Ftask._5Fper._5Fio-v5-0-9=
261ad7bff20@purestorage.com/):
> > >   our fetches are all submitted by the queue's own thread, so io->tas=
k
> > >   should always match at dispatch time;
> > > - rq_list batching: ublk_queue_rqs() coalesces same-<ctx_handle, task=
>
> > >   requests into one list and queues a single
> > >   io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb) for the
> > >   whole batch. If that single task work is lost, every request in the
> > >   list strands - the observations are consistent with one lost reques=
t per
> > >   occurrence.
> > >
> > > 6. Follow-ups
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > - Does this ring any bells in the 7.0 completion rework (lost task wo=
rk
> > >   for ublk_cmd_list_tw_cb / ublk_cmd_tw_cb, or io->task mismatch taki=
ng
> > >   a path that neither completes nor aborts)? Is a fix already in
> > >   flight?
> > > - Independently of the completion loss: should ublk_timeout() for
> > >   privileged daemons fail a request whose ublk server is gone? Today
> > >   BLK_EH_RESET_TIMER keeps a lost request - and with it the del_gendi=
sk
> > >   freeze and the control mutex - stuck forever after server's death,
> > >   which turns a single lost completion into a machine-level hang.
> > >
> > > I can test candidate patches on 7.0.0-43 or bisect across 6.15-7.0 on=
 a
> > > VM, or capture the trace of a missing completion.
> > >
> > > #regzbot introduced: v6.8..v7.0
> > >
> > > Best regards,
> > > Luciano
> >
