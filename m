Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D19A320F;
	Tue, 14 May 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688469; cv=none; b=NPndq+zoImSvfzWA/YASDF1O7fDEBzTZekF9721RFpMYHbReITXb6CQdKG0SWo0Gbw1a9QlLCuFFzORXW+2hV5vCapNCkvC0Mhks1muS7M0zcXOCd/DsTnOkdEuFU7jd5pCMbzm/YJXlPVuW2fTnArzy/qHGDNPgs8ztjxGPvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688469; c=relaxed/simple;
	bh=mLL7B8vDyCDH8vmnqNlRJpEkXI6Ms8si8mOelAOXJwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5W2/gEV8xCWA8TWK00vNVhBmK8IyYkphcjPP5wfpgpSpngy1M9/TYe+o3TaozyAcHf2YykIhEOCka6BJxePY++zA99DPboROFZ6NKT0HxsVNXSdEFH3HxLW5Jco788TbXOdRWXioMcnt+7FZ8826dHqj1S2p5ehRXHz/z4E2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM88O5ZQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM88O5ZQ"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59c0a6415fso23314666b.1;
        Tue, 14 May 2024 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715688466; x=1716293266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spJhcMCJLLZ5XYu12iV4bIRUrYgxZ4FzOTF2itKzb8U=;
        b=jM88O5ZQYK4FiYSvnsvy6Tk1goyb06yBKHacC6xdxswpm9LlZSMjhdMcQpA9GWUi5f
         vR5UXBfGTJx2hilanCi2foJKoXPj9Yqzf+cMiAPyte4FxXVTc8WdEkeJ8LjxzFofAw/b
         ZqF4DVyhxAdjG+crhG6ntgDewYYjrcphRryjk71wby0sG8RSPQ3yVg+PueSwcEQ3rx1F
         Rg3MmIsyKkWpS1qrVbPl2d8OTBo6NrLOi69rR7VRwZ7n7EQoGGX1OUMwuWfW+kVbLv6y
         zndb48RhrJFTEj33p8K8dXyZ+hYL75moEk8T3Dn2oTewEef8aNzcjkQ5xfmGCDfDAjvm
         Vhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715688466; x=1716293266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spJhcMCJLLZ5XYu12iV4bIRUrYgxZ4FzOTF2itKzb8U=;
        b=IoHX0areuj4wh8tAhieLjeQiCdsrHeQAKFtXZ6Yud+U70mZZA2Caqna/Ck8DHk7AnB
         CoxlMUSXAGVeTOj6TcvXijkLtlC5WzgDC3lGQvLL6uT0FJFeEqG8YkTNDw5LrubYVp3M
         hNZy/fdIwoPHfeBB6HeZ3i6uKPoupyY/glR+U4NEfgj8qhNi6K5JM3haqh3FbDpYd+M2
         lS17GV3BXYKiYJXFGHpfwkN4vg85nSeUt0TGoPUId6vw9dqtKES+lbIx2oq5XxzsYMiP
         awazdIxzQD0U2A2DvRlmtlBOKm65VsVa2pS7vdUvYj0eKx3qwYIBKhkekDpRP4FQrBr7
         1z5A==
X-Forwarded-Encrypted: i=1; AJvYcCUJvovLLvsb+cBkSr5HXuPPUvkqDRxGUQuFBAQ6fuR8fzeq7XSpGDxUa8AMhDhjqT2LrgSOTdgIDUJRfOJTtWc8fOxj8DZIBxxmxD4=
X-Gm-Message-State: AOJu0Yzyjf1TLHtOje4r1SJ1GglK88lTxmpFYcCzCfXZzoY2sizg58wu
	pSxfUlVsSkCk9GSxVClTrBNfEoRL2wC529LHJmVY6QMQy/wYWBUw5FcM/Z3WuS5eovBCdkcLGjb
	SA0u0+dYLA+1V/aRDMzPu1G5+npg=
X-Google-Smtp-Source: AGHT+IHJuloMH1XSDHVgTqa/HlyWJaT93NPV8YsGUHp1LosKD76lHUgKrGDPCc7F4L5qVYKU2iSiFjkXnFF6c1o/eTM=
X-Received: by 2002:a17:907:7757:b0:a59:c9ce:3389 with SMTP id
 a640c23a62f3a-a5a2d673aa6mr751324566b.67.1715688466430; Tue, 14 May 2024
 05:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYMhv8AxxHSVdPT9bCX1cJZXw39+bMFh=2N9uNOB4Hcr=w@mail.gmail.com>
 <20240514103742.3137-1-hdanton@sina.com>
In-Reply-To: <20240514103742.3137-1-hdanton@sina.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 14 May 2024 20:07:34 +0800
Message-ID: <CAEkJfYPH3SJ6J3kLSjMGqkWOzgbgKZV_f2Hq05cpZZv7RmhvOg@mail.gmail.com>
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
To: Hillf Danton <hdanton@sina.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 6:37=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Tue, 14 May 2024 10:05:21 +0800 Sam Sun <samsun1006219@gmail.com>
> > On Tue, May 14, 2024 at 6:54=E2=80=AFAM Hillf Danton <hdanton@sina.com>=
 wrote:
> > > On Mon, 13 May 2024 20:57:44 +0800 Sam Sun <samsun1006219@gmail.com>
> > > >
> > > > I applied this patch and tried using the C repro, but it still cras=
hed
> > > > with the same task hang kernel dump log.
> > >
> > > Oh low-hanging pear is sour, and try again seeing if there is missing
> > > wakeup due to wake batch.
> > >
> > > --- x/lib/sbitmap.c
> > > +++ y/lib/sbitmap.c
> > > @@ -579,6 +579,8 @@ void sbitmap_queue_wake_up(struct sbitma
> > >         unsigned int wake_batch =3D READ_ONCE(sbq->wake_batch);
> > >         unsigned int wakeups;
> > >
> > > +       __sbitmap_queue_wake_up(sbq, nr);
> > > +
> > >         if (!atomic_read(&sbq->ws_active))
> > >                 return;
> > >
> > > --
> >
> > I applied this patch together with the last patch. Unfortunately it
> > still crashed.
>
> After two rounds of test, what is clear now so far is -- it is IOs
> in flight that caused the task hung reported, though without spotting
> why they failed to complete within 120 seconds.
> >
> > Pointed out by Tetsuo, this kernel panic might be caused by sending
> > NMI between cpus. As dump log shows:
> > ```
> > [  429.046960][   T32] NMI backtrace for cpu 0
> > [  429.047499][   T32] CPU: 0 PID: 32 Comm: khungtaskd Not tainted 6.9.=
0-dirty #6
> > [  429.048417][   T32] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> > [  429.049873][   T32] Call Trace:
> > [  429.050299][   T32]  <TASK>
> > [  429.050672][   T32]  dump_stack_lvl+0x201/0x300
> > ...
> > [  429.063133][   T32]  ret_from_fork_asm+0x11/0x20
> > [  429.063735][   T32]  </TASK>
> > [  429.064168][   T32] Sending NMI from CPU 0 to CPUs 1:
> > [  429.064833][   T32] BUG: unable to handle page fault for address:
> > ffffffff813d4cf1
>
> Given many syzbot reports without gpf like this one, I have difficulty
> understanding it. If it is printed after task hung detected, it should
> be a seperate issue.
>

I tried to run

# echo 0 > /proc/sys/kernel/hung_task_all_cpu_backtrace

before running the reproducer, the kernel stops panic. But still, even
if I terminate the execution of the reproducer, kernel continues
dumping task hung logs. After setting bung_task_all_cpu_backtrace back
to 1, it panic immediately during next dump. So I guess it is still a
task hung instead of general protection fault.

> > [  429.065765][   T32] #PF: supervisor write access in kernel mode
> > [  429.066502][   T32] #PF: error_code(0x0003) - permissions violation
> > [  429.067274][   T32] PGD db38067 P4D db38067 PUD db39063 PMD 12001a1
> > [  429.068068][   T32] Oops: 0003 [#1] PREEMPT SMP KASAN NOPTI
> > [  429.068767][   T32] CPU: 0 PID: 32 Comm: khungtaskd Not tainted
> > 6.9.0-dirty #6
> > [  429.069666][   T32] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> > [  429.071142][   T32] RIP: 0010:__send_ipi_mask+0x541/0x690
