Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5767441E;
	Wed, 15 May 2024 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777211; cv=none; b=M9+ayzWdhyiw+XvPDQycbb1gpmJGSh0cW2BT6ZLsxO7YTajQ07T3SX5iDymP4Zz3MmoOBWH7yO/bySKuceVGruVmbzWA8pIDaqSz94APWMMJYmlSlOuTX2zKBsei99jD1Gnz1t71jwv/MTwhUF17ue6tudyaGRS9Hin9TwqejLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777211; c=relaxed/simple;
	bh=vCkixihGAHMCZD4hjqNxYUhpECreVDeVJgtb7Db8tmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWwVQerx8SmYD7fXTHIEvS9fWtpS+C/QFneiNhgxt6s2Ju6wlc7SQdIaEVjZQGwFRgmVDKjlSqS8QHAgZp5tdl8PIZseY30SbKala7IjFBcOCzn+A+HmZqZGm2nydP2flIHbC3YYi4rJYjPYse3QNnUeAM0RPgLeuY4qkYvkEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9s+peDf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9s+peDf"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59e4136010so167867766b.3;
        Wed, 15 May 2024 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715777208; x=1716382008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCbHSlIiQkVh6r2b3TdDKkhr0wW+rLUkzXX3Zyv+AVQ=;
        b=D9s+peDfuZ7gysk0W3FreyflyRf+/EEdOixuOlbiOmMaIHgHC7bJXQte5VZY2M6dXX
         aB3j1mMe+RDTVzL4nhmSkRPZxHwogg+TZeSmncDh8+SSH3M9qYao7m4TA6o9vnbov7jQ
         jNgR/PVigYtvChGR5FYCHkepM2GxDOkDg3y+QIcvdfJK1m7JEy0qJO6sBsP4jacAuaGc
         ISdLEffoupB6wAXoDk723DgqFnsPxzXATclpDqUwVawRaYHUtrx69fQ543b0Rvx4A7WF
         3J4QB3iQhGAvkpZ2/C8lu1m69qkeBdCsUYVbVluWXEzUgF3Oc5KKTMksYyqMcGO5wH/W
         jZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715777208; x=1716382008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCbHSlIiQkVh6r2b3TdDKkhr0wW+rLUkzXX3Zyv+AVQ=;
        b=vYE68hTzOjgdYtXKUEaveJuftw1A2hwBnzEi9ClEaFF0k/YYHTPQu5U0absKQZx1Tx
         eBfntaMYv3FYSLjQvXFVxoXAZqdCoVYf1vMcVOo3avSgXao3wa+HGsEjlvFVA4u1LZab
         WjUf5oLb5SMGonggooRt7gBCD3VLCNqx0+FMREx5k1afozHzwIwfPfa2RSvXndChY6NV
         Z5eMUHEWWhUFmOb9AQu0+xB3nlhf49jumSmulU7kOm6ruxnq4EZTNH0KE7OiZY+i+h9I
         DVWWlFTVlr6rDgQc3Z7+i24trpaTAU9tbGMYp/jM/3EDv8/KpAeIdvQ8YI6VVD7Z3PUD
         f/UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn9wf2nJ+I9bEB55AMUjnQT6I8MhKWM4lheSaMclRgWW4zu6/ZfJT39SXcCxrSietFEdPN/5zR+vyddJuy6EEBEN4z09PpU2BSYKj8lAVr/5gTM2UuZ3hm9osjQXd1fewtBiuocOHxoxA=
X-Gm-Message-State: AOJu0Yxk7HyIdUWzlGF2L7jafTPydsNJLvh9ADDp2Wo5K1eYkdPzwcVu
	qLAgzEHIUkCZU/8zYa6ozsKzjlJh+32Ackz+Ai26AGtIyQpUvY3V8L7rgIABq8NCla15VqT8WTZ
	mgKv+GGzu+K0LKjqHr6sqGyDb3MNAsIeNpkE=
X-Google-Smtp-Source: AGHT+IFTIx1w0/U+UfL4ENchmnZCIM7OjFd9HphcvovLro1JG1CJ2Upf83UsSCE98FiHHVN7UMv9Kz0oeMTrhRaXaYY=
X-Received: by 2002:a17:907:d22:b0:a59:aa9d:3142 with SMTP id
 a640c23a62f3a-a5a2d5cb794mr1293085166b.37.1715777207927; Wed, 15 May 2024
 05:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYMhv8AxxHSVdPT9bCX1cJZXw39+bMFh=2N9uNOB4Hcr=w@mail.gmail.com>
 <20240514103742.3137-1-hdanton@sina.com> <CAEkJfYPH3SJ6J3kLSjMGqkWOzgbgKZV_f2Hq05cpZZv7RmhvOg@mail.gmail.com>
 <cfe6b902-5e2d-415d-afeb-672cafd8d0b7@I-love.SAKURA.ne.jp>
In-Reply-To: <cfe6b902-5e2d-415d-afeb-672cafd8d0b7@I-love.SAKURA.ne.jp>
From: Sam Sun <samsun1006219@gmail.com>
Date: Wed, 15 May 2024 20:46:36 +0800
Message-ID: <CAEkJfYOBnhVGNENZkkdoX1g+gE=eVNFwNRG6HwFUdCw2+Kda=Q@mail.gmail.com>
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, axboe@kernel.dk, syzkaller-bugs@googlegroups.com, 
	xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:46=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/05/14 21:07, Sam Sun wrote:
> > I tried to run
> >
> > # echo 0 > /proc/sys/kernel/hung_task_all_cpu_backtrace
> >
> > before running the reproducer, the kernel stops panic. But still, even
> > if I terminate the execution of the reproducer, kernel continues
> > dumping task hung logs. After setting bung_task_all_cpu_backtrace back
> > to 1, it panic immediately during next dump. So I guess it is still a
> > task hung instead of general protection fault.
>
> What execute_one() in the reproducer is doing is only
>
>   int fd1 =3D open("/dev/sg0", O_RDONLY);
>   int fd2 =3D open("/sys/module/sg/parameters/allow_dio", O_RDWR);
>   write(fd2, "100\0", 4); // returns 4
>   ioctl(fd1, FIBMAP, 0x20000140); // returns 2
>
> . But your hung task report includes device rescan sequence.
>
>  schedule+0x147/0x310 kernel/sched/core.c:6838
>  io_schedule+0x87/0x100 kernel/sched/core.c:9044
>  blk_mq_get_tag+0x509/0xba0 block/blk-mq-tag.c:187
>  __blk_mq_alloc_requests+0xbc1/0x1710 block/blk-mq.c:499
>  blk_mq_alloc_request+0x513/0xbc0 block/blk-mq.c:599
>  scsi_alloc_request drivers/scsi/scsi_lib.c:1229 [inline]
>  scsi_execute_cmd+0x17a/0x1140 drivers/scsi/scsi_lib.c:304
>  scsi_vpd_inquiry drivers/scsi/scsi.c:312 [inline]
>  scsi_get_vpd_size+0x2e3/0x6b0 drivers/scsi/scsi.c:363
>  scsi_get_vpd_buf+0x89/0x460 drivers/scsi/scsi.c:433
>  scsi_attach_vpd+0xdc/0x5e0 drivers/scsi/scsi.c:501
>  scsi_rescan_device+0xd8/0x290 drivers/scsi/scsi_scan.c:1698
>  ata_scsi_dev_rescan+0x1fe/0x3c0 drivers/ata/libata-scsi.c:4764
>  process_one_work kernel/workqueue.c:3254 [inline]
>
> Something is triggering this sequence, and writing to allow_dio interface
> confuses the "if (sg_allow_dio && ...)" path in sg_start_req()
> in drivers/scsi/sg.c ?
>
> What happens if you disable
>
>   sysfd =3D write(sysfd, input, hash - input + 1);
>
> line (i.e. stop updating sg_allow_dio value) in the reproducer?
>

I tried to change the value of /sys/module/sg/parameters/allow_dio to
0 and remove write() call, both still triggers task hang report and
kernel panic. I think this write is not the call crashing the kernel.
