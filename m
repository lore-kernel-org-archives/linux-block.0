Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2FB1C01;
	Mon, 13 May 2024 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715611765; cv=none; b=CHtXZ5J3w07X51Sr+OGpMtnDav/xquTqUV7sVzSSAe4SIpaSCHwqwn6pS1dEm00tGRpcd9qQasQLVv+hT2Owqxrj34RNuSEkKXCbJJqu/vCod0d/hYdGqAY2MMA2fJzfuFTWFG2xHjUsAWh535zxgc9IFS/Ev0zsCr+hYEDPSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715611765; c=relaxed/simple;
	bh=lCk35/KPHYXF7XoKul//QZ8sphv4Cc2vKkICycEuxiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJbEkQARWhmy4btai9IAv3VOG7YD14KaZh+EY5cbam8N+QTa8qopXhnlpZjK4bFNvImcHBnHIXANencwGzhB0DXFYYkmCm9whHt6czoa/pdYsKOW0E7k1+BT65/2c7zuzSRckpiSsfL+jVLw7RGO8rzPkEeIF6cdjRuPgyitFNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtrvWs9d; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtrvWs9d"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59c0a6415fso1221675166b.1;
        Mon, 13 May 2024 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715611761; x=1716216561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUnYr7z3/ner4NLYLyiwNhdfDrVjLBB0zgRnpWuLGIc=;
        b=RtrvWs9dbOhmFmSzF5JjZjt1pwEqQgtUCIkFJZ9vyqmOn+C2ZlehRpo0xIudxcl+xd
         YSmmtJGzO4ou9ByH7VlYRSIFDUreZlAa13kpkE0SR3o4hKju5+7s7+y6Ay1pyFdgJOJO
         bCAQX1hnx+heylghVCLovtcVwa6jkS0nKOITtISPAQup/GXBObkhAYSiYP/sUuvcgD8M
         aZF24TtkK9MxfufC4EABoE+4uYxHq+nxVvCqf5l4KCbHV9Q7wgSmUl8uejpx645wcZNt
         O22CCnUnhWfhnrvg+LCHB3/OTBkGxBITjBPRcCkgooS2+cvs84K95PgiFLft/IZBd9jZ
         /JAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715611761; x=1716216561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUnYr7z3/ner4NLYLyiwNhdfDrVjLBB0zgRnpWuLGIc=;
        b=B8ZbEUNLyTNUnBLDMLOHlyIovzoysMRqX4+bRxOvZNJ4XM8uUhtnso96DpEuZ7+hz+
         a7L9JEST0HazGv3jgijlHZMOemMiQA/GMAU+si+iUw89Y7ndufcEakFsDJN/snM2t5h9
         sr/Frjoz7Gm7ynNAmfQd/yE3B1166CBMJZs6/7InsS7UCCQrOI7AA3KfObM2puEuSmvT
         ZRRcQtBaLRqQAgtkv2QeN1IbW9I0GLpfCnjg6gYaHEZpJsLo5Je70qG+l6nYL8Ro9Rz4
         llrY1/ZqFCagIQ7CgXobGqW9rG0GY8TdIcX68k1SPc3Q53mvBSNqZo+YYnOuEfTm7Uex
         mxIg==
X-Forwarded-Encrypted: i=1; AJvYcCUoaEwU/q2RGydnMMPcer6RyBeDWffdSfGQAyFudU1d6JzbnoC/Brs+ZMA5YFnuH8SXquL6B2/5iKtG75Vg/ePfSo+cgzNOXKswkAfXz0rYnNRUJJ5ki/i/TIDux+bh+5I7HXKRiJu3Cp0=
X-Gm-Message-State: AOJu0YzkQfL77Y+/03cyd21ZUo6XqAmQRcpXEwVspDGyjC2260NVasLs
	QEp8tES9+AtS8j/Gv6JvAIhyvuQdPLysEDIGYv60UtIJjeerYeEj/ED4sK2AMBzqiqWrvjNtgEA
	tCscY2CN4WZQScSmy1PYYMvLN4pc=
X-Google-Smtp-Source: AGHT+IG2vhuvtGk8Y3fp4lEzCM5Z1vRT72YjPIBaCM5q+3wl/L5pNVkV5DcH0W7xDdX0MGAHRD9TGE6XjnZCSemHt/0=
X-Received: by 2002:a17:906:1293:b0:a59:bde5:398 with SMTP id
 a640c23a62f3a-a5a2d536c98mr676393566b.14.1715611760791; Mon, 13 May 2024
 07:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYPO8OK=JCFphuZvqzqCWpUjPiTVoHma3CY0gLo+rdLKNw@mail.gmail.com>
 <20240513105413.2951-1-hdanton@sina.com> <CAEkJfYPxWBfEnuKeCGEsscVTYy8MrNxCJwdbxS=c2-B0H+HfTA@mail.gmail.com>
 <a15774ef-1c18-4604-af10-44d458e3207a@I-love.SAKURA.ne.jp>
In-Reply-To: <a15774ef-1c18-4604-af10-44d458e3207a@I-love.SAKURA.ne.jp>
From: Sam Sun <samsun1006219@gmail.com>
Date: Mon, 13 May 2024 22:49:09 +0800
Message-ID: <CAEkJfYPZCEuF+Km_Zir1=JHx64v2yNv5d=ovz-TzOVOJPG5o_A@mail.gmail.com>
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, axboe@kernel.dk, syzkaller-bugs@googlegroups.com, 
	xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 10:16=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/05/13 21:57, Sam Sun wrote:
> > On Mon, May 13, 2024 at 6:54=E2=80=AFPM Hillf Danton <hdanton@sina.com>=
 wrote:
> >>
> >> On Mon, 13 May 2024 10:38:34 +0800 Sam Sun <samsun1006219@gmail.com>
> >>> Dear developers and maintainers,
> >>>
> >>> We encountered a task hung in function blk_mq_get_tag. It was tested
> >>> against the latest upstream kernel which was compiled by clang 14.
>
> Did you confirm that the task hung messages continue forever
> even after you terminated the reproducer when the task hung
> message started?
>

I confirmed that this reproducer caused a kernel panic and it stopped
generating information after stack dump.

> If the task hung messages stop after you terminated the reproducer,
> it is possible that this is just a problem of over-stressing.
>
> If the task hung messages continue forever even after you terminated
> the reproducer, collecting stacktraces of all lock holders using
> https://lkml.kernel.org/r/77e32fdc-3f63-e124-588e-7d60dd66fc9a@I-love.SAK=
URA.ne.jp
> might be helpful.
>
> Please be sure to run
>
>   # echo 0 > /proc/sys/kernel/hung_task_panic
>   # echo -1 > /proc/sys/kernel/hung_task_warnings
>
> before starting the reproducer, for by default hung_task_warnings
> prints only up to 10 times (i.e. has a risk of misjudging that the
> problem disappeared).
>

I run these commands before starting the reproducer, and the result is
the same. Here are all the commands I used to trigger this bug and the
stack dump results. Hope this could help :)
```
root@syzkaller:~# cd bugs/
root@syzkaller:~/bugs# echo 0 > /proc/sys/kernel/hung_task_panic
root@syzkaller:~/bugs# echo -1 > /proc/sys/kernel/hung_task_warnings
root@syzkaller:~/bugs# ./blk_mq_get_tag
[  131.818956][   T31] audit: type=3D1400 audit(1715610954.852:7): avc:
denied  { execmem } for  pid=3D8007 comm=3D"blk_mq_get_tag"
scontext=3Dsystem_u:system_r:kern1
[  131.833420][ T8010] program blk_mq_get_tag is using a deprecated
SCSI ioctl, please convert it to SG_IO
[  131.843039][ T8013] program blk_mq_get_tag is using a deprecated
SCSI ioctl, please convert it to SG_IO
[  131.852890][ T8014] program blk_mq_get_tag is using a deprecated
SCSI ioctl, please convert it to SG_IO
[  131.853834][ T8015] program blk_mq_get_tag is using a deprecated
SCSI ioctl, please convert it to SG_IO
[  193.345796][  T991] ata1: lost interrupt (Status 0x58)
[  193.515114][  T991] ata1: found unknown device (class 0)
[  193.536614][ T8016] program blk_mq_get_tag is using a deprecated
SCSI ioctl, please convert it to SG_IO
[  254.764977][  T991] ata1: lost interrupt (Status 0x58)
[  254.935089][  T991] ata1: found unknown device (class 0)
[  254.952028][ T8017] program blk_mq_get_tag is using a deprecated
SCSI ioctl, please convert it to SG_IO
[  316.204981][  T991] ata1: lost interrupt (Status 0x58)
[  316.375087][  T991] ata1: found unknown device (class 0)
[  316.394963][ T8018] program blk_mq_get_tag is using a deprecated
SCSI ioctl, please convert it to SG_IO
[  377.664934][  T991] ata1: lost interrupt (Status 0x58)
[  377.666840][  T991] ata1.00: limiting speed to MWDMA1:PIO4
[  377.835090][  T991] ata1: found unknown device (class 0)
[  377.854027][ T8020] program blk_mq_get_tag is using a deprecated
SCSI ioctl, please convert it to SG_IO
[  398.554980][    T1] systemd[1]: systemd-journald.service: State
'stop-watchdog' timed out. Killing.
[  398.558234][    T1] systemd[1]: systemd-journald.service: Killing
process 4521 (systemd-journal) with signal SIGKILL.
[  428.805242][   T32] INFO: task kworker/u10:9:2459 blocked for more
than 143 seconds.
[  428.808290][   T32]       Not tainted 6.9.0-dirty #5
[  428.809958][   T32] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  428.813046][   T32] task:kworker/u10:9   state:D stack:21024
pid:2459  tgid:2459  ppid:2      flags:0x00004000
[  428.816957][   T32] Workqueue: writeback wb_workfn (flush-8:0)
[  428.819223][   T32] Call Trace:
[  428.820464][   T32]  <TASK>
[  428.821527][   T32]  __schedule+0xf19/0x15e0
[  428.823182][   T32]  ? schedule+0x8d/0x310
[  428.824971][   T32]  ? release_firmware_map_entry+0x190/0x190
[  428.827108][   T32]  ? __lock_acquire+0x1f60/0x1f60
[  428.828935][   T32]  ? __blk_flush_plug+0x4b9/0x570
[  428.830519][   T32]  ? kthread_data+0x51/0xc0
[  428.831596][   T32]  ? schedule+0x8d/0x310
[  428.832601][   T32]  ? wq_worker_sleeping+0x65/0x240
[  428.833799][   T32]  ? schedule+0x8d/0x310
[  428.835170][   T32]  schedule+0x147/0x310
[  428.836193][   T32]  io_schedule+0x87/0x100
[  428.837232][   T32]  blk_mq_get_tag+0x5d1/0xbb0
[  428.838358][   T32]  ? blk_mq_get_tags+0x240/0x240
[  428.839514][   T32]  ? rq_qos_wait+0x247/0x480
[  428.840596][   T32]  ? wake_bit_function+0x240/0x240
[  428.841788][   T32]  ? wbt_inflight_cb+0x2e0/0x2e0
[  428.842982][   T32]  ? rq_depth_scale_down+0x440/0x440
[  428.844214][   T32]  ? rq_qos_wait+0x480/0x480
[  428.845393][   T32]  __blk_mq_alloc_requests+0xbc1/0x1710
[  428.846734][   T32]  ? wbt_wait+0x3fa/0x660
[  428.847764][   T32]  ? trace_wbt_step+0x200/0x200
[  428.848910][   T32]  ? blk_mq_alloc_request+0xbc0/0xbc0
[  428.850181][   T32]  ? trace_wbt_step+0x200/0x200
[  428.851335][   T32]  blk_mq_submit_bio+0xcd2/0x1f00
[  428.852526][   T32]  ? blk_mq_plug_issue_direct+0x5c0/0x5c0
[  428.853853][   T32]  ? ktime_get+0x83/0x280
[  428.855142][   T32]  ? lockdep_hardirqs_on+0x91/0x140
[  428.856380][   T32]  ? seqcount_lockdep_reader_access+0x1a6/0x1f0
[  428.857830][   T32]  __submit_bio+0x23d/0x2e0
[  428.858924][   T32]  ? __folio_memcg_unlock+0x105/0x120
[  428.860173][   T32]  ? blk_free_queue_rcu+0x40/0x40
[  428.861349][   T32]  ? rcu_is_watching+0x15/0xb0
[  428.862491][   T32]  submit_bio_noacct_nocheck+0x9e1/0xc40
[  428.863805][   T32]  ? __might_sleep+0xe0/0xe0
[  428.865006][   T32]  ? should_fail_request+0x80/0x80
[  428.866247][   T32]  ? __folio_end_writeback+0xd20/0xd20
[  428.867513][   T32]  ? blk_should_throtl+0x16e/0x4f0
[  428.868697][   T32]  ? __lruvec_stat_mod_folio+0x7d/0x300
[  428.870010][   T32]  ? submit_bio_noacct+0xd21/0x1440
[  428.871225][   T32]  ext4_bio_write_folio+0x118d/0x1d60
[  428.872481][   T32]  mpage_submit_folio+0x192/0x210
[  428.873665][   T32]  mpage_process_page_bufs+0x6c5/0x8d0
[  428.875188][   T32]  mpage_prepare_extent_to_map+0xe9b/0x19d0
[  428.876591][   T32]  ? kmem_cache_alloc+0x172/0x360
[  428.877767][   T32]  ? ext4_init_io_end+0x29/0x120
[  428.878952][   T32]  ? ext4_do_writepages+0xbae/0x3920
[  428.880189][   T32]  ? trace_ext4_writepages+0x1e0/0x1e0
[  428.881472][   T32]  ? rcu_is_watching+0x15/0xb0
[  428.882613][   T32]  ? ext4_init_io_end+0x29/0x120
[  428.883765][   T32]  ? trace_kmem_cache_alloc+0x1f/0xc0
[  428.885132][   T32]  ? kmem_cache_alloc+0x1c2/0x360
[  428.886367][   T32]  ext4_do_writepages+0xbf4/0x3920
[  428.887481][   T32]  ? __lock_acquire+0x133b/0x1f60
[  428.888454][   T32]  ? ext4_normal_submit_inode_data_buffers+0x260/0x260
[  428.889758][   T32]  ? rcu_read_lock_any_held+0xb5/0x140
[  428.890808][   T32]  ? rcu_read_lock_bh_held+0x100/0x100
[  428.891585][   T32]  ? do_writepages+0x2d5/0x830
[  428.892137][   T32]  ext4_writepages+0x210/0x3c0
[  428.892700][   T32]  ? ext4_read_folio+0x140/0x140
[  428.893286][   T32]  ? do_raw_spin_unlock+0x138/0x8a0
[  428.893938][   T32]  ? ext4_read_folio+0x140/0x140
[  428.894845][   T32]  do_writepages+0x373/0x830
[  428.895582][   T32]  ? write_cache_pages+0x210/0x210
[  428.896352][   T32]  ? wbc_attach_and_unlock_inode+0x321/0x560
[  428.897239][   T32]  ? __lock_acquire+0x1f60/0x1f60
[  428.897988][   T32]  ? rcu_is_watching+0x15/0xb0
[  428.898739][   T32]  __writeback_single_inode+0xe2/0x660
[  428.899579][   T32]  ? wbc_attach_and_unlock_inode+0x373/0x560
[  428.900471][   T32]  writeback_sb_inodes+0x831/0x1020
[  428.901271][   T32]  ? __lock_acquire+0x133b/0x1f60
[  428.902066][   T32]  ? queue_io+0x400/0x400
[  428.902730][   T32]  ? __init_rwsem+0x160/0x160
[  428.903441][   T32]  ? trace_writeback_wait+0x1c0/0x1c0
[  428.904257][   T32]  ? do_raw_spin_lock+0x14c/0x370
[  428.905065][   T32]  __writeback_inodes_wb+0x11b/0x260
[  428.905884][   T32]  wb_writeback+0x3c4/0x720
[  428.906585][   T32]  ? trace_writeback_exec+0x1c0/0x1c0
[  428.907413][   T32]  ? lockdep_hardirqs_on_prepare+0x418/0x760
[  428.908298][   T32]  ? process_scheduled_works+0x979/0x14a0
[  428.909166][   T32]  ? process_scheduled_works+0x979/0x14a0
[  428.910071][   T32]  ? get_nr_dirty_inodes+0x200/0x230
[  428.910865][   T32]  wb_workfn+0xa38/0xf30
[  428.911532][   T32]  ? inode_wait_for_writeback+0x2d0/0x2d0
[  428.912385][   T32]  ? lockdep_hardirqs_on_prepare+0x418/0x760
[  428.913243][   T32]  ? print_irqtrace_events+0x210/0x210
[  428.914052][   T32]  ? preempt_schedule_thunk+0x1a/0x30
[  428.914940][   T32]  ? process_scheduled_works+0x979/0x14a0
[  428.915769][   T32]  ? rcu_is_watching+0x15/0xb0
[  428.916480][   T32]  ? process_scheduled_works+0x979/0x14a0
[  428.917294][   T32]  process_scheduled_works+0x9cb/0x14a0
[  428.918169][   T32]  ? assign_work+0x410/0x410
[  428.918874][   T32]  ? assign_work+0x3a4/0x410
[  428.919588][   T32]  worker_thread+0x85c/0xd50
[  428.920318][   T32]  ? _raw_spin_unlock_irqrestore+0xc5/0x120
[  428.921221][   T32]  ? __kthread_parkme+0x169/0x1c0
[  428.921992][   T32]  ? pr_cont_work+0x5e0/0x5e0
[  428.922720][   T32]  kthread+0x2ef/0x390
[  428.923354][   T32]  ? pr_cont_work+0x5e0/0x5e0
[  428.924095][   T32]  ? kthread_blkcg+0xd0/0xd0
[  428.924855][   T32]  ret_from_fork+0x4d/0x80
[  428.925531][   T32]  ? kthread_blkcg+0xd0/0xd0
[  428.926301][   T32]  ret_from_fork_asm+0x11/0x20
[  428.927036][   T32]  </TASK>
[  428.927508][   T32] INFO: task kworker/1:3:2531 blocked for more
than 143 seconds.
[  428.928545][   T32]       Not tainted 6.9.0-dirty #5
[  428.929151][   T32] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  428.930161][   T32] task:kworker/1:3     state:D stack:24888
pid:2531  tgid:2531  ppid:2      flags:0x00004000
[  428.931365][   T32] Workqueue: events ata_scsi_dev_rescan
[  428.932097][   T32] Call Trace:
[  428.932577][   T32]  <TASK>
[  428.933011][   T32]  __schedule+0xf19/0x15e0
[  428.933624][   T32]  ? schedule+0x8d/0x310
[  428.934153][   T32]  ? release_firmware_map_entry+0x190/0x190
[  428.935026][   T32]  ? preempt_schedule+0xba/0xd0
[  428.935627][   T32]  ? __lock_acquire+0x1f60/0x1f60
[  428.936240][   T32]  ? lockdep_hardirqs_on_prepare+0x418/0x760
[  428.936956][   T32]  ? schedule+0x8d/0x310
[  428.937470][   T32]  ? schedule+0x8d/0x310
[  428.937996][   T32]  schedule+0x147/0x310
[  428.938601][   T32]  io_schedule+0x87/0x100
[  428.939223][   T32]  blk_mq_get_tag+0x5d1/0xbb0
[  428.939908][   T32]  ? blk_mq_get_tags+0x240/0x240
[  428.940608][   T32]  ? wake_bit_function+0x240/0x240
[  428.941321][   T32]  ? blk_try_enter_queue+0x22/0x3f0
[  428.942076][   T32]  __blk_mq_alloc_requests+0xbc1/0x1710
[  428.942856][   T32]  ? blk_mq_alloc_request+0xbc0/0xbc0
[  428.943632][   T32]  blk_mq_alloc_request+0x513/0xbc0
[  428.944389][   T32]  ? add_lock_to_list+0x1cd/0x2d0
[  428.945190][   T32]  ? blk_rq_init+0x2c0/0x2c0
[  428.945898][   T32]  ? lockdep_lock+0x106/0x290
[  428.946574][   T32]  scsi_execute_cmd+0x17a/0x1140
[  428.947288][   T32]  ? scsi_failures_reset_retries+0x130/0x130
[  428.948135][   T32]  scsi_get_vpd_size+0x2e3/0x6b0
[  428.948855][   T32]  ? scsi_get_vpd_page+0x590/0x590
[  428.949610][   T32]  ? __mutex_trylock_common+0x189/0x2e0
[  428.950423][   T32]  ? __might_sleep+0xe0/0xe0
[  428.951094][   T32]  ? trace_raw_output_contention_end+0xd0/0xd0
[  428.951975][   T32]  scsi_get_vpd_buf+0x89/0x460
[  428.952671][   T32]  ? __mutex_lock+0x2e1/0xd90
[  428.953348][   T32]  ? scsi_attach_vpd+0x5e0/0x5e0
[  428.954058][   T32]  ? print_irqtrace_events+0x210/0x210
[  428.954940][   T32]  ? scsi_rescan_device+0x32/0x290
[  428.955689][   T32]  scsi_attach_vpd+0xdc/0x5e0
[  428.956363][   T32]  ? _raw_spin_unlock_irqrestore+0xc5/0x120
[  428.957184][   T32]  ? _raw_spin_unlock+0x40/0x40
[  428.957860][   T32]  ? _raw_spin_lock_irqsave+0xc3/0x100
[  428.958652][   T32]  scsi_rescan_device+0xd8/0x290
[  428.959360][   T32]  ata_scsi_dev_rescan+0x1fe/0x3c0
[  428.960092][   T32]  ? process_scheduled_works+0x979/0x14a0
[  428.960907][   T32]  process_scheduled_works+0x9cb/0x14a0
[  428.961615][   T32]  ? assign_work+0x410/0x410
[  428.962175][   T32]  ? assign_work+0x3a4/0x410
[  428.962721][   T32]  worker_thread+0x85c/0xd50
[  428.963274][   T32]  ? _raw_spin_unlock_irqrestore+0xc5/0x120
[  428.963966][   T32]  ? __kthread_parkme+0x169/0x1c0
[  428.964575][   T32]  ? pr_cont_work+0x5e0/0x5e0
[  428.965185][   T32]  kthread+0x2ef/0x390
[  428.965672][   T32]  ? pr_cont_work+0x5e0/0x5e0
[  428.966240][   T32]  ? kthread_blkcg+0xd0/0xd0
[  428.966786][   T32]  ret_from_fork+0x4d/0x80
[  428.967315][   T32]  ? kthread_blkcg+0xd0/0xd0
[  428.967865][   T32]  ret_from_fork_asm+0x11/0x20
[  428.968433][   T32]  </TASK>
[  428.968809][   T32] INFO: task jbd2/sda-8:4494 blocked for more
than 143 seconds.
[  428.969689][   T32]       Not tainted 6.9.0-dirty #5
[  428.970294][   T32] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  428.971284][   T32] task:jbd2/sda-8      state:D stack:25408
pid:4494  tgid:4494  ppid:2      flags:0x00004000
[  428.972459][   T32] Call Trace:
[  428.972852][   T32]  <TASK>
[  428.973208][   T32]  __schedule+0xf19/0x15e0
[  428.973737][   T32]  ? schedule+0x8d/0x310
[  428.974254][   T32]  ? release_firmware_map_entry+0x190/0x190
[  428.975058][   T32]  ? __lock_acquire+0x1f60/0x1f60
[  428.975665][   T32]  ? __blk_flush_plug+0x4b9/0x570
[  428.976258][   T32]  ? blk_check_plugged+0x250/0x250
[  428.976855][   T32]  ? schedule+0x8d/0x310
[  428.977355][   T32]  schedule+0x147/0x310
[  428.977848][   T32]  io_schedule+0x87/0x100
[  428.978384][   T32]  blk_mq_get_tag+0x5d1/0xbb0
[  428.978943][   T32]  ? blk_mq_get_tags+0x240/0x240
[  428.979519][   T32]  ? wake_bit_function+0x240/0x240
[  428.980126][   T32]  ? dd_bio_merge+0x10d/0x180
[  428.980742][   T32]  ? __lock_acquire+0x1f60/0x1f60
[  428.981465][   T32]  __blk_mq_alloc_requests+0xbc1/0x1710
[  428.982264][   T32]  ? wbt_wait+0x21b/0x660
[  428.982882][   T32]  ? trace_wbt_step+0x200/0x200
[  428.983599][   T32]  ? blk_mq_alloc_request+0xbc0/0xbc0
[  428.984391][   T32]  ? trace_wbt_step+0x200/0x200
[  428.985165][   T32]  blk_mq_submit_bio+0xcd2/0x1f00
[  428.985835][   T32]  ? blk_mq_plug_issue_direct+0x5c0/0x5c0
[  428.986551][   T32]  ? ktime_get+0x83/0x280
[  428.987075][   T32]  ? lockdep_hardirqs_on+0x91/0x140
[  428.987751][   T32]  ? seqcount_lockdep_reader_access+0x1a6/0x1f0
[  428.988630][   T32]  __submit_bio+0x23d/0x2e0
[  428.989213][   T32]  ? bio_associate_blkg+0x67/0x220
[  428.989819][   T32]  ? rcu_is_watching+0x15/0xb0
[  428.990504][   T32]  ? blk_free_queue_rcu+0x40/0x40
[  428.991268][   T32]  ? rcu_is_watching+0x15/0xb0
[  428.991985][   T32]  submit_bio_noacct_nocheck+0x9e1/0xc40
[  428.992835][   T32]  ? __lock_acquire+0x1f60/0x1f60
[  428.993583][   T32]  ? should_fail_request+0x80/0x80
[  428.994357][   T32]  ? bio_associate_blkg+0x67/0x220
[  428.995235][   T32]  ? blk_should_throtl+0x16e/0x4f0
[  428.996008][   T32]  ? submit_bio_noacct+0xd21/0x1440
[  428.996791][   T32]  jbd2_journal_commit_transaction+0x2412/0x5500
[  428.997716][   T32]  ? jbd2_journal_finish_inode_data_buffers+0xb0/0xb0
[  428.998679][   T32]  ? lockdep_hardirqs_on_prepare+0x418/0x760
[  428.999511][   T32]  ? print_irqtrace_events+0x210/0x210
[  429.000162][   T32]  ? _raw_spin_unlock_irqrestore+0x8f/0x120
[  429.000852][   T32]  ? lockdep_hardirqs_on+0x91/0x140
[  429.001470][   T32]  ? _raw_spin_unlock_irqrestore+0xc5/0x120
[  429.002173][   T32]  ? _raw_spin_unlock+0x40/0x40
[  429.002742][   T32]  ? detach_if_pending+0xbe/0x290
[  429.003327][   T32]  ? __timer_delete_sync+0x339/0x3d0
[  429.003952][   T32]  ? timer_delete_sync+0x20/0x20
[  429.004562][   T32]  ? _raw_spin_unlock_irqrestore+0xc5/0x120
[  429.005498][   T32]  ? _raw_spin_unlock+0x40/0x40
[  429.006226][   T32]  ? finish_wait+0xd3/0x1e0
[  429.006923][   T32]  kjournald2+0x45f/0x870
[  429.007572][   T32]  ? print_irqtrace_events+0x210/0x210
[  429.008379][   T32]  ? trace_jbd2_write_superblock+0x1c0/0x1c0
[  429.009273][   T32]  ? wake_bit_function+0x240/0x240
[  429.010049][   T32]  ? __kthread_parkme+0x169/0x1c0
[  429.010819][   T32]  ? trace_jbd2_write_superblock+0x1c0/0x1c0
[  429.011709][   T32]  kthread+0x2ef/0x390
[  429.012322][   T32]  ? trace_jbd2_write_superblock+0x1c0/0x1c0
[  429.013211][   T32]  ? kthread_blkcg+0xd0/0xd0
[  429.013918][   T32]  ret_from_fork+0x4d/0x80
[  429.014599][   T32]  ? kthread_blkcg+0xd0/0xd0
[  429.015426][   T32]  ret_from_fork_asm+0x11/0x20
[  429.016158][   T32]  </TASK>
[  429.016627][   T32] INFO: task systemd-journal:4521 blocked for
more than 143 seconds.
[  429.017813][   T32]       Not tainted 6.9.0-dirty #5
[  429.018582][   T32] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  429.019842][   T32] task:systemd-journal state:D stack:18800
pid:4521  tgid:4521  ppid:1      flags:0x00000004
[  429.021326][   T32] Call Trace:
[  429.021825][   T32]  <TASK>
[  429.022282][   T32]  __schedule+0xf19/0x15e0
[  429.022966][   T32]  ? schedule+0x8d/0x310
[  429.023615][   T32]  ? release_firmware_map_entry+0x190/0x190
[  429.024500][   T32]  ? __lock_acquire+0x1f60/0x1f60
[  429.025320][   T32]  ? lockdep_hardirqs_on_prepare+0x418/0x760
[  429.026104][   T32]  ? _raw_spin_unlock_irqrestore+0x8f/0x120
[  429.026794][   T32]  ? schedule+0x8d/0x310
[  429.027296][   T32]  schedule+0x147/0x310
[  429.027792][   T32]  io_schedule+0x87/0x100
[  429.028304][   T32]  bit_wait_io+0x12/0xc0
[  429.028812][   T32]  __wait_on_bit+0xb2/0x320
[  429.029350][   T32]  ? bit_wait+0xc0/0xc0
[  429.029839][   T32]  out_of_line_wait_on_bit+0x1c7/0x240
[  429.030498][   T32]  ? bit_wait+0xc0/0xc0
[  429.031000][   T32]  ? __wait_on_bit+0x320/0x320
[  429.031569][   T32]  ? bit_waitqueue+0x30/0x30
[  429.032119][   T32]  ? do_raw_spin_unlock+0x138/0x8a0
[  429.032744][   T32]  do_get_write_access+0x10c/0xcd0
[  429.033410][   T32]  jbd2_journal_get_write_access+0x206/0x250
[  429.034278][   T32]  __ext4_journal_get_write_access+0x1e6/0x6a0
[  429.035124][   T32]  ? __ext4_journal_ensure_credits+0x5f0/0x5f0
[  429.035859][   T32]  ext4_reserve_inode_write+0x271/0x360
[  429.036521][   T32]  ? ext4_mark_iloc_dirty+0x1ae0/0x1ae0
[  429.037162][   T32]  ? rcu_is_watching+0x15/0xb0
[  429.037723][   T32]  ? ext4_dirty_inode+0xc9/0x110
[  429.038319][   T32]  __ext4_mark_inode_dirty+0x127/0x670
[  429.038961][   T32]  ? rcu_is_watching+0x15/0xb0
[  429.039533][   T32]  ? ext4_blocks_for_truncate+0x270/0x270
[  429.040309][   T32]  ? rcu_is_watching+0x15/0xb0
[  429.041023][   T32]  ? trace_jbd2_handle_start+0x8a/0x200
[  429.041811][   T32]  ? __ext4_journal_start_sb+0x13f/0x1f0
[  429.042634][   T32]  ext4_dirty_inode+0xc9/0x110
[  429.043342][   T32]  ? trace_ext4_mark_inode_dirty+0x1e0/0x1e0
[  429.044195][   T32]  __mark_inode_dirty+0x1f1/0x610
[  429.045093][   T32]  file_update_time+0x3d4/0x410
[  429.045685][   T32]  ext4_page_mkwrite+0x200/0xde0
[  429.046296][   T32]  ? do_wp_page+0x12ac/0x26d0
[  429.046856][   T32]  ? ext4_change_inode_journal_flag+0x830/0x830
[  429.047593][   T32]  do_page_mkwrite+0x190/0x480
[  429.048160][   T32]  do_wp_page+0x137d/0x26d0
[  429.048775][   T32]  ? read_lock_is_recursive+0x20/0x20
[  429.049549][   T32]  ? folio_put+0xb0/0xb0
[  429.050181][   T32]  ? __rwlock_init+0x140/0x140
[  429.050874][   T32]  handle_pte_fault+0x943/0xd90
[  429.051588][   T32]  ? wp_huge_pmd+0x270/0x270
[  429.052282][   T32]  __handle_mm_fault+0xcdd/0x1230
[  429.053032][   T32]  ? lock_vma_under_rcu+0x188/0x730
[  429.053810][   T32]  ? rcu_is_watching+0x15/0xb0
[  429.054555][   T32]  ? handle_mm_fault+0x880/0x880
[  429.055428][   T32]  ? lock_vma_under_rcu+0x188/0x730
[  429.056222][   T32]  ? mmap_write_unlock+0x160/0x160
[  429.056960][   T32]  ? lockdep_hardirqs_on_prepare+0x418/0x760
[  429.057828][   T32]  handle_mm_fault+0x3bd/0x880
[  429.058870][   T32]  do_user_addr_fault+0xa8b/0x1290
[  429.059628][   T32]  ? rcu_is_watching+0x15/0xb0
[  429.060316][   T32]  ? trace_irq_disable+0x3b/0x110
[  429.061047][   T32]  exc_page_fault+0x7f/0x120
[  429.061715][   T32]  asm_exc_page_fault+0x26/0x30
[  429.062467][   T32] RIP: 0033:0x7f5d5dbc5fde
[  429.063136][   T32] RSP: 002b:00007fff76fe2420 EFLAGS: 00010246
[  429.064042][   T32] RAX: 00007f5d5c60b200 RBX: 0000560298ca3410
RCX: 000000000000acf8
[  429.065246][   T32] RDX: 0000000000000000 RSI: 0000560298ca3410
RDI: 00007f5d5c7f0ea8
[  429.066418][   T32] RBP: 0000560298c8b010 R08: 00000000001f0e68
R09: 00000000001f0e68
[  429.067582][   T32] R10: 0000000000000002 R11: 0000000000006c88
R12: 0000000000000025
[  429.068748][   T32] R13: 0000000000009c10 R14: 0000000000000000
R15: 00007fff76fe2440
[  429.069915][   T32]  </TASK>
[  429.070379][   T32] INFO: task rs:main Q:Reg:7584 blocked for more
than 143 seconds.
[  429.071530][   T32]       Not tainted 6.9.0-dirty #5
[  429.072278][   T32] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  429.073558][   T32] task:rs:main Q:Reg   state:D stack:24568
pid:7584  tgid:7555  ppid:1      flags:0x00000000
[  429.075172][   T32] Call Trace:
[  429.075608][   T32]  <TASK>
[  429.075966][   T32]  __schedule+0xf19/0x15e0
[  429.076501][   T32]  ? schedule+0x8d/0x310
[  429.077015][   T32]  ? release_firmware_map_entry+0x190/0x190
[  429.077700][   T32]  ? __lock_acquire+0x1f60/0x1f60
[  429.078305][   T32]  ? lockdep_hardirqs_on_prepare+0x418/0x760
[  429.079001][   T32]  ? _raw_spin_unlock_irqrestore+0x8f/0x120
[  429.079698][   T32]  ? schedule+0x8d/0x310
[  429.080199][   T32]  schedule+0x147/0x310
[  429.080697][   T32]  io_schedule+0x87/0x100
[  429.081219][   T32]  bit_wait_io+0x12/0xc0
[  429.081729][   T32]  __wait_on_bit+0xb2/0x320
[  429.082278][   T32]  ? bit_wait+0xc0/0xc0
[  429.082782][   T32]  out_of_line_wait_on_bit+0x1c7/0x240
[  429.083432][   T32]  ? bit_wait+0xc0/0xc0
[  429.084067][   T32]  ? __wait_on_bit+0x320/0x320
[  429.084833][   T32]  ? bit_waitqueue+0x30/0x30
[  429.085513][   T32]  ? do_raw_spin_unlock+0x138/0x8a0
[  429.086307][   T32]  do_get_write_access+0x10c/0xcd0
[  429.087067][   T32]  jbd2_journal_get_write_access+0x206/0x250
[  429.087958][   T32]  __ext4_journal_get_write_access+0x1e6/0x6a0
[  429.088870][   T32]  ? __ext4_journal_ensure_credits+0x5f0/0x5f0
[  429.089786][   T32]  ext4_reserve_inode_write+0x271/0x360
[  429.090624][   T32]  ? ext4_mark_iloc_dirty+0x1ae0/0x1ae0
[  429.091468][   T32]  ? rcu_is_watching+0x15/0xb0
[  429.092197][   T32]  ? ext4_dirty_inode+0xc9/0x110
[  429.092933][   T32]  __ext4_mark_inode_dirty+0x127/0x670
[  429.093742][   T32]  ? rcu_is_watching+0x15/0xb0
[  429.094490][   T32]  ? ext4_blocks_for_truncate+0x270/0x270
[  429.095473][   T32]  ? rcu_is_watching+0x15/0xb0
[  429.096209][   T32]  ? trace_jbd2_handle_start+0x8a/0x200
[  429.097028][   T32]  ? __ext4_journal_start_sb+0x13f/0x1f0
[  429.097851][   T32]  ext4_dirty_inode+0xc9/0x110
[  429.098578][   T32]  ? trace_ext4_mark_inode_dirty+0x1e0/0x1e0
[  429.099315][   T32]  __mark_inode_dirty+0x1f1/0x610
[  429.099910][   T32]  file_modified_flags+0x423/0x490
[  429.100518][   T32]  ext4_write_checks+0x24a/0x2c0
[  429.101105][   T32]  ext4_buffered_write_iter+0xa1/0x340
[  429.101755][   T32]  ext4_file_write_iter+0x1d1/0x1a10
[  429.102436][   T32]  ? read_lock_is_recursive+0x20/0x20
[  429.103100][   T32]  ? ext4_file_read_iter+0x670/0x670
[  429.103853][   T32]  vfs_write+0xa63/0xcf0
[  429.104410][   T32]  ? kernel_write+0x330/0x330
[  429.105040][   T32]  ? __fget_files+0x3ea/0x460
[  429.105739][   T32]  ? __x64_sys_readlinkat+0x90/0xb0
[  429.106530][   T32]  ? __fdget_pos+0x255/0x320
[  429.107229][   T32]  ksys_write+0x17b/0x2a0
[  429.107889][   T32]  ? __ia32_sys_read+0x90/0x90
[  429.108612][   T32]  ? do_syscall_64+0xa5/0x240
[  429.109305][   T32]  do_syscall_64+0xe4/0x240
[  429.109982][   T32]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[  429.110862][   T32] RIP: 0033:0x7f1788547fef
[  429.111526][   T32] RSP: 002b:00007f17871ff860 EFLAGS: 00000293
ORIG_RAX: 0000000000000001
[  429.112765][   T32] RAX: ffffffffffffffda RBX: 00007f1774022a20
RCX: 00007f1788547fef
[  429.113941][   T32] RDX: 000000000000005c RSI: 00007f1774022cc0
RDI: 0000000000000007
[  429.115169][   T32] RBP: 000000000000005c R08: 0000000000000000
R09: 0000000000000000
[  429.116288][   T32] R10: 0000000000000000 R11: 0000000000000293
R12: 00007f1774022cc0
[  429.117397][   T32] R13: 0000000000000000 R14: 000000000000005c
R15: 00007f1774022a20
[  429.118530][   T32]  </TASK>
[  429.118993][   T32] INFO: task blk_mq_get_tag:8016 blocked for more
than 143 seconds.
[  429.120115][   T32]       Not tainted 6.9.0-dirty #5
[  429.120869][   T32] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  429.122123][   T32] task:blk_mq_get_tag  state:D stack:26080
pid:8016  tgid:8016  ppid:8012   flags:0x00000004
[  429.123645][   T32] Call Trace:
[  429.124133][   T32]  <TASK>
[  429.124577][   T32]  __schedule+0xf19/0x15e0
[  429.125366][   T32]  ? schedule+0x8d/0x310
[  429.126012][   T32]  ? release_firmware_map_entry+0x190/0x190
[  429.126855][   T32]  ? _find_next_zero_bit+0x11f/0x140
[  429.127489][   T32]  ? __lock_acquire+0x1f60/0x1f60
[  429.128076][   T32]  ? sbitmap_find_bit+0x4a7/0x510
[  429.128825][   T32]  ? schedule+0x8d/0x310
[  429.129487][   T32]  schedule+0x147/0x310
[  429.130125][   T32]  io_schedule+0x87/0x100
[  429.130777][   T32]  blk_mq_get_tag+0x5d1/0xbb0
[  429.131479][   T32]  ? blk_mq_get_tags+0x240/0x240
[  429.132203][   T32]  ? wake_bit_function+0x240/0x240
[  429.132971][   T32]  ? blk_try_enter_queue+0x22/0x3f0
[  429.133756][   T32]  __blk_mq_alloc_requests+0xbc1/0x1710
[  429.134645][   T32]  ? __kasan_kmalloc+0x98/0xb0
[  429.135490][   T32]  ? blk_mq_alloc_request+0xbc0/0xbc0
[  429.136319][   T32]  blk_mq_alloc_request+0x513/0xbc0
[  429.137117][   T32]  ? scsi_ioctl+0x1db5/0x2dd0
[  429.137849][   T32]  ? blk_rq_init+0x2c0/0x2c0
[  429.138578][   T32]  ? __kmalloc+0xbf/0x4c0
[  429.139267][   T32]  ? __might_sleep+0xe0/0xe0
[  429.139997][   T32]  ? rcu_is_watching+0x15/0xb0
[  429.140715][   T32]  ? scsi_ioctl+0x1db5/0x2dd0
[  429.141427][   T32]  ? trace_kmalloc+0x1f/0xc0
[  429.142138][   T32]  ? __kmalloc+0x252/0x4c0
[  429.142815][   T32]  scsi_alloc_request+0x26/0x180
[  429.143605][   T32]  scsi_ioctl+0x1e09/0x2dd0
[  429.144325][   T32]  ? do_vfs_ioctl+0xeaa/0x2d10
[  429.145111][   T32]  ? get_sg_io_hdr+0x1130/0x1130
[  429.145888][   T32]  ? __x64_compat_sys_ioctl+0x90/0x90
[  429.146730][   T32]  ? read_lock_is_recursive+0x20/0x20
[  429.147570][   T32]  ? avc_has_perm_noaudit+0x50/0x4f0
[  429.148386][   T32]  ? __lock_acquire+0x1f60/0x1f60
[  429.149162][   T32]  ? avc_has_perm_noaudit+0x50/0x4f0
[  429.149852][   T32]  ? avc_has_perm_noaudit+0x487/0x4f0
[  429.150515][   T32]  ? avc_has_perm_noaudit+0x50/0x4f0
[  429.151153][   T32]  ? avc_has_perm+0x14b/0x250
[  429.151728][   T32]  ? kfree+0x137/0x310
[  429.152224][   T32]  ? avc_perm_nonode+0x190/0x190
[  429.152826][   T32]  ? tomoyo_path_number_perm+0x608/0x710
[  429.153505][   T32]  ? file_has_perm+0x4d0/0x680
[  429.154084][   T32]  ? match_file+0x140/0x140
[  429.154641][   T32]  sg_ioctl+0x174e/0x2f00
[  429.155419][   T32]  ? selinux_file_ioctl+0x240/0x520
[  429.156217][   T32]  ? sg_poll+0x3c0/0x3c0
[  429.156865][   T32]  ? lockdep_hardirqs_on_prepare+0x418/0x760
[  429.157786][   T32]  ? security_file_ioctl+0xa5/0xc0
[  429.158592][   T32]  ? sg_poll+0x3c0/0x3c0
[  429.159246][   T32]  __se_sys_ioctl+0xfe/0x170
[  429.159974][   T32]  do_syscall_64+0xe4/0x240
[  429.160685][   T32]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[  429.161588][   T32] RIP: 0033:0x7fc85eb23f29
[  429.162283][   T32] RSP: 002b:00007ffd3eb47148 EFLAGS: 00000202
ORIG_RAX: 0000000000000010
[  429.163542][   T32] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007fc85eb23f29
[  429.164664][   T32] RDX: 0000000020000140 RSI: 0000000000000001
RDI: 0000000000000003
[  429.165672][   T32] RBP: 00007ffd3eb47160 R08: 002367732f766564
R09: 00007ffd3eb47160
[  429.166857][   T32] R10: 000000000000000f R11: 0000000000000202
R12: 0000564fc8e661c0
[  429.168069][   T32] R13: 0000000000000000 R14: 0000000000000000
R15: 0000000000000000
[  429.169287][   T32]  </TASK>
[  429.169775][   T32]
[  429.169775][   T32] Showing all locks held in the system:
[  429.170962][   T32] 1 lock held by khungtaskd/32:
[  429.171707][   T32]  #0: ffffffff8dd343e0
(rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x54/0x2a0
[  429.173215][   T32] 4 locks held by kworker/u10:2/779:
[  429.174051][   T32]  #0: ffff888013fd7948
((wq_completion)writeback){+.+.}-{0:0}, at:
process_scheduled_works+0x94f/0x14a0
[  429.175866][   T32]  #1: ffffc90002087d00
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_scheduled_works+0x979/0x14a0
[  429.177744][   T32]  #2: ffff8880188700e0
(&type->s_umount_key#53){++++}-{3:3}, at:
super_trylock_shared+0x22/0xf0
[  429.179352][   T32]  #3: ffff888018872b98
(&sbi->s_writepages_rwsem){++++}-{0:0}, at:
ext4_writepages+0x1be/0x3c0
[  429.180998][   T32] 4 locks held by kworker/u10:9/2459:
[  429.181814][   T32]  #0: ffff888013fd7948
((wq_completion)writeback){+.+.}-{0:0}, at:
process_scheduled_works+0x94f/0x14a0
[  429.183552][   T32]  #1: ffffc9000ee4fd00
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at:
process_scheduled_works+0x979/0x14a0
[  429.185503][   T32]  #2: ffff8880188700e0
(&type->s_umount_key#53){++++}-{3:3}, at:
super_trylock_shared+0x22/0xf0
[  429.187114][   T32]  #3: ffff888018872b98
(&sbi->s_writepages_rwsem){++++}-{0:0}, at:
ext4_writepages+0x1be/0x3c0
[  429.188697][   T32] 4 locks held by kworker/1:3/2531:
[  429.189484][   T32]  #0: ffff888013478948
((wq_completion)events){+.+.}-{0:0}, at:
process_scheduled_works+0x94f/0x14a0
[  429.191167][   T32]  #1: ffffc9000ee8fd00
((work_completion)(&(&ap->scsi_rescan_task)->work)){+.+.}-{0:0}, at:
process_scheduled_works+0x979/0x14a0
[  429.193212][   T32]  #2: ffff88804491c360
(&ap->scsi_scan_mutex){+.+.}-{3:3}, at: ata_scsi_dev_rescan+0x3e/0x3c0
[  429.194640][   T32]  #3: ffff88804515a378
(&dev->mutex){....}-{3:3}, at: scsi_rescan_device+0x32/0x290
[  429.196188][   T32] 3 locks held by systemd-journal/4521:
[  429.197025][   T32]  #0: ffff8880171fd3d0
(&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x2f7/0x730
[  429.198579][   T32]  #1: ffff888018870518
(sb_pagefaults){.+.+}-{0:0}, at: ext4_page_mkwrite+0x1e9/0xde0
[  429.200008][   T32]  #2: ffff888018874950
(jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1f81/0x21e0
[  429.201457][   T32] 1 lock held by in:imklog/7582:
[  429.202187][   T32]  #0: ffff88804b2d19c8
(&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x255/0x320
[  429.203616][   T32] 4 locks held by rs:main Q:Reg/7584:
[  429.204412][   T32]  #0: ffff88801c3f5248
(&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x255/0x320
[  429.205846][   T32]  #1: ffff888018870420
(sb_writers#4){.+.+}-{0:0}, at: vfs_write+0x230/0xcf0
[  429.207217][   T32]  #2: ffff88801e614000
(&sb->s_type->i_mutex_key#7){++++}-{3:3}, at:
ext4_buffered_write_iter+0x96/0x340
[  429.208877][   T32]  #3: ffff888018874950
(jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1f81/0x21e0
[  429.210341][   T32]
[  429.210691][   T32] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[  429.210691][   T32]
[  429.211897][   T32] NMI backtrace for cpu 1
[  429.212559][   T32] CPU: 1 PID: 32 Comm: khungtaskd Not tainted
6.9.0-dirty #5
[  429.213644][   T32] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[  429.215483][   T32] Call Trace:
[  429.215983][   T32]  <TASK>
[  429.216428][   T32]  dump_stack_lvl+0x201/0x300
[  429.217125][   T32]  ? tcp_gro_dev_warn+0x260/0x260
[  429.217877][   T32]  ? panic+0x840/0x840
[  429.218516][   T32]  ? vprintk_emit+0x5ea/0x710
[  429.219223][   T32]  ? printk_sprint+0x2f0/0x2f0
[  429.219959][   T32]  nmi_cpu_backtrace+0x41e/0x450
[  429.220726][   T32]  ? nmi_trigger_cpumask_backtrace+0x300/0x300
[  429.221609][   T32]  ? _printk+0xc4/0x110
[  429.222263][   T32]  ? panic+0x840/0x840
[  429.222880][   T32]  ? __wake_up_klogd+0xcc/0x100
[  429.223630][   T32]  ? panic+0x840/0x840
[  429.224250][   T32]  ? __rcu_read_unlock+0x95/0x100
[  429.225003][   T32]  ? arch_trigger_cpumask_backtrace+0x10/0x10
[  429.225919][   T32]  nmi_trigger_cpumask_backtrace+0x185/0x300
[  429.226825][   T32]  watchdog+0xddb/0xe20
[  429.227468][   T32]  ? watchdog+0x1e8/0xe20
[  429.228127][   T32]  ? hungtask_pm_notify+0x90/0x90
[  429.228886][   T32]  kthread+0x2ef/0x390
[  429.229491][   T32]  ? hungtask_pm_notify+0x90/0x90
[  429.230288][   T32]  ? kthread_blkcg+0xd0/0xd0
[  429.230980][   T32]  ret_from_fork+0x4d/0x80
[  429.231646][   T32]  ? kthread_blkcg+0xd0/0xd0
[  429.232341][   T32]  ret_from_fork_asm+0x11/0x20
[  429.233027][   T32]  </TASK>
[  429.233588][   T32] Sending NMI from CPU 1 to CPUs 0:
[  429.234413][   T32] BUG: unable to handle page fault for address:
ffffffff813d4cf1
[  429.235539][   T32] #PF: supervisor write access in kernel mode
[  429.236436][   T32] #PF: error_code(0x0003) - permissions violation
[  429.237367][   T32] PGD db38067 P4D db38067 PUD db39063 PMD 12001a1
[  429.238261][   T32] Oops: 0003 [#1] PREEMPT SMP KASAN NOPTI
[  429.238943][   T32] CPU: 1 PID: 32 Comm: khungtaskd Not tainted
6.9.0-dirty #5
[  429.240034][   T32] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[  429.241882][   T32] RIP: 0010:__send_ipi_mask+0x541/0x690
[  429.242700][   T32] Code: c2 b1 00 48 8b 9c 24 c0 00 00 00 48 8b 8c
24 c8 00 00 00 48 89 d8 48 09 c8 74 33 48 63 54 24 18 b8 0a 00 00 00
48 8b 74 24 38 <0f8
[  429.245552][   T32] RSP: 0018:ffffc90000547ca0 EFLAGS: 00010002
[  429.246443][   T32] RAX: 000000000000000a RBX: 0000000000000001
RCX: 0000000000000000
[  429.247652][   T32] RDX: 0000000000000000 RSI: 0000000000000400
RDI: 0000000000000000
[  429.248809][   T32] RBP: ffffc90000547e00 R08: ffffffff813d4989
R09: 1ffff920000a8fac
[  429.249996][   T32] R10: dffffc0000000000 R11: fffff520000a8fad
R12: dffffc0000000000
[  429.251048][   T32] R13: ffffffff8f49ca60 R14: ffffc90000547d60
R15: 1ffff920000a8fa0
[  429.252125][   T32] FS:  0000000000000000(0000)
GS:ffff88807ec00000(0000) knlGS:0000000000000000
[  429.253458][   T32] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  429.254434][   T32] CR2: ffffffff813d4cf1 CR3: 000000000db34000
CR4: 00000000003506b0
[  429.255596][   T32] Call Trace:
[  429.256095][   T32]  <TASK>
[  429.256549][   T32]  ? __die_body+0x88/0xe0
[  429.257218][   T32]  ? __send_ipi_mask+0x541/0x690
[  429.258010][   T32]  ? page_fault_oops+0x7b5/0xa90
[  429.258770][   T32]  ? __send_ipi_mask+0x541/0x690
[  429.259544][   T32]  ? kernelmode_fixup_or_oops+0xe0/0xe0
[  429.260406][   T32]  ? is_prefetch+0x4a4/0x700
[  429.261113][   T32]  ? prb_read_valid+0xa9/0xf0
[  429.261846][   T32]  ? page_fault_oops+0xa90/0xa90
[  429.262609][   T32]  ? prb_next_reserve_seq+0x450/0x450
[  429.263433][   T32]  ? __send_ipi_mask+0x541/0x690
[  429.264200][   T32]  ? __bad_area_nosemaphore+0x117/0x750
[  429.265065][   T32]  ? __send_ipi_mask+0x541/0x690
[  429.265826][   T32]  ? find_next_clump8+0x1b0/0x1b0
[  429.266461][   T32]  ? vprintk_emit+0x710/0x710
[  429.267037][   T32]  ? _printk+0xc4/0x110
[  429.267537][   T32]  ? spurious_kernel_fault_check+0x120/0x120
[  429.268246][   T32]  ? __send_ipi_mask+0x541/0x690
[  429.268837][   T32]  ? __send_ipi_mask+0x541/0x690
[  429.269409][   T32]  ? spurious_kernel_fault+0x447/0x5e0
[  429.270056][   T32]  ? __send_ipi_mask+0x541/0x690
[  429.270638][   T32]  ? __send_ipi_mask+0x541/0x690
[  429.271224][   T32]  ? __send_ipi_mask+0x541/0x690
[  429.271827][   T32]  ? exc_page_fault+0xc9/0x120
[  429.272402][   T32]  ? asm_exc_page_fault+0x26/0x30
[  429.273005][   T32]  ? __send_ipi_mask+0x1d9/0x690
[  429.273607][   T32]  ? __send_ipi_mask+0x541/0x690
[  429.274225][   T32]  ? kvm_send_ipi_mask_allbutself+0x120/0x120
[  429.274943][   T32]  ? nmi_trigger_cpumask_backtrace+0x196/0x300
[  429.275676][   T32]  ? panic+0x840/0x840
[  429.276155][   T32]  ? panic+0x840/0x840
[  429.276629][   T32]  ? nmi_backtrace_stall_snap+0x1cd/0x1f0
[  429.277296][   T32]  ? arch_trigger_cpumask_backtrace+0x10/0x10
[  429.278016][   T32]  nmi_trigger_cpumask_backtrace+0x28d/0x300
[  429.278726][   T32]  watchdog+0xddb/0xe20
[  429.279239][   T32]  ? watchdog+0x1e8/0xe20
[  429.279767][   T32]  ? hungtask_pm_notify+0x90/0x90
[  429.280363][   T32]  kthread+0x2ef/0x390
[  429.280851][   T32]  ? hungtask_pm_notify+0x90/0x90
[  429.281455][   T32]  ? kthread_blkcg+0xd0/0xd0
[  429.282025][   T32]  ret_from_fork+0x4d/0x80
[  429.282557][   T32]  ? kthread_blkcg+0xd0/0xd0
[  429.283115][   T32]  ret_from_fork_asm+0x11/0x20
[  429.283690][   T32]  </TASK>
[  429.284060][   T32] Modules linked in:
[  429.284538][   T32] CR2: ffffffff813d4cf1
[  429.285032][   T32] ---[ end trace 0000000000000000 ]---
[  429.285679][   T32] RIP: 0010:__send_ipi_mask+0x541/0x690
[  429.286357][   T32] Code: c2 b1 00 48 8b 9c 24 c0 00 00 00 48 8b 8c
24 c8 00 00 00 48 89 d8 48 09 c8 74 33 48 63 54 24 18 b8 0a 00 00 00
48 8b 74 24 38 <0f8
[  429.288515][   T32] RSP: 0018:ffffc90000547ca0 EFLAGS: 00010002
[  429.289213][   T32] RAX: 000000000000000a RBX: 0000000000000001
RCX: 0000000000000000
[  429.290110][   T32] RDX: 0000000000000000 RSI: 0000000000000400
RDI: 0000000000000000
[  429.291040][   T32] RBP: ffffc90000547e00 R08: ffffffff813d4989
R09: 1ffff920000a8fac
[  429.291978][   T32] R10: dffffc0000000000 R11: fffff520000a8fad
R12: dffffc0000000000
[  429.292911][   T32] R13: ffffffff8f49ca60 R14: ffffc90000547d60
R15: 1ffff920000a8fa0
[  429.293856][   T32] FS:  0000000000000000(0000)
GS:ffff88807ec00000(0000) knlGS:0000000000000000
[  429.294929][   T32] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  429.295696][   T32] CR2: ffffffff813d4cf1 CR3: 000000000db34000
CR4: 00000000003506b0
[  429.296625][   T32] Kernel panic - not syncing: Fatal exception
[  429.297771][   T32] Kernel Offset: disabled
[  429.298287][   T32] Rebooting in 86400 seconds..
```
Best Regards,
Yue
