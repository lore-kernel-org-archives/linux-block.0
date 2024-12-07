Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDA17E0
	for <linux-block@vger.kernel.org>; Sat,  7 Dec 2024 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733541485; cv=none; b=UxksTTvaRxm7+hcJ9h8EdjxzskuUGPLPwFxiG9AlEM4Qsoyti+yxELswl/dAOWOMOvT3I2YK2Mf1bVhUfEAGz7Qm9sTkegB/yHWTu0z17WCH7HBzxp1xt4qoPO0bOJ+gxHKtKii1qPV5oUAn2xnXEncpFfNY5TLjGV/MJq2a1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733541485; c=relaxed/simple;
	bh=kITkkFmRqwEVCO72oHw8CMfGWkzFfViY3zZ2aKhH2AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3jEpFdSW28e+bEBHByrodB1gqrCFx1l2iqB92fL5yr7HPL1xNbj0ZgPzaAUWC1r86l30iurAa11ugLx/1wieXEhiJiM/d4ydWD2dZd4Yw0RUQREe1ELJr6Np+TwMo7sdq8SUHTRnuqHcY7wUz1avGifMytRu6SuOh58sRFmJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gh1gkhxO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gh1gkhxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733541479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcilOn3agHY5GqxVttVJ4JMf4VTS9mR5uuoN5RQWKTY=;
	b=gh1gkhxOS5tqLjMbkbALVmXJKyCfNH37z1UuE6yNRISdib/asM4BqTrJ0YSeH7Iehtecw1
	j7r9TVElDfHOo6p2wjsiqbpeJbfiR5+TcG8VV8U+YZLZmFVUw52RslZyvqEH+nLThdrfub
	BAOU/lfRHaIOj8F9VLEVXAQXIQ1SLH0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-SP_Y5WkUMCWG-m3ENwGUdg-1; Fri, 06 Dec 2024 22:17:58 -0500
X-MC-Unique: SP_Y5WkUMCWG-m3ENwGUdg-1
X-Mimecast-MFC-AGG-ID: SP_Y5WkUMCWG-m3ENwGUdg
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-855c41b9f27so325227241.1
        for <linux-block@vger.kernel.org>; Fri, 06 Dec 2024 19:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733541477; x=1734146277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcilOn3agHY5GqxVttVJ4JMf4VTS9mR5uuoN5RQWKTY=;
        b=NtRJVca5QU/h2tor9TZAe8CMN2z1f//6MZlBerFoWsCI4MY1WHEjiF+XtH6olKOPrR
         Sqh88V3V6zvosPXeXrjMa9OPju89NGVsmhHbDjrK5tpdyTfUVe/YyiCt49psxpoZ+Tjt
         4uFch5v85f1Y2qOoNdmz+FKfO5KzpPK8NmWJPLaIr08jRm3Kpz4SU+bTKDwz51tHI5WX
         Rrd7h09lH/bZyyfqvTTe7oq7qJSyRpbyGoPoqF5Fxd9mH6Mt0pOtnV9ALdrvBWJCQxF+
         aWS1hI3zftAbB9a/WnfOIs7AOxQV8q2HsJVI0999SCesor+Nrv6AJ1CrA1nOpSOUyM07
         TS2A==
X-Gm-Message-State: AOJu0Yxz610akaZiCW4HoR+NJh5ZRudK4L3tWLanRCNEfcPUXMhZoBo4
	+76oqNxUFjeyR0/w4uA+rCznQoXx8A4TsuruA7p3sWlgyAtTK9C6wV+KYkbCCeNGIyILUywXmZJ
	CnkS2bx/EKNcWCEJ7zPrB8Hg+AkHE2HSy7isO3b33cs8fUhxx/ukbIgfXWxaf4FJbs6tSvh2y1F
	hYVhsj0F1lSaisXsEZh7oj30nQ+wo68ckA2SE=
X-Gm-Gg: ASbGncvU2ePsbD+1ZjHlpZwchZVpGzjz7wM/xSUQt1nEnKYzUPsTwus+uaA0NolnuB1
	NwGRMBI7q6KDkP17u6KC/4/QCTLyAti6v
X-Received: by 2002:a05:6102:3a13:b0:4af:a967:65c5 with SMTP id ada2fe7eead31-4afcaa28a8cmr7155635137.10.1733541477616;
        Fri, 06 Dec 2024 19:17:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2j0zsvaUUjWcRpA1fYb974S1tJqXk9dIhUbIvShuoZu18kp+UBKv7pv1IM8X/4wWQZm+6PwzPlIez2jaUH/I=
X-Received: by 2002:a05:6102:3a13:b0:4af:a967:65c5 with SMTP id
 ada2fe7eead31-4afcaa28a8cmr7155634137.10.1733541477376; Fri, 06 Dec 2024
 19:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206164742.526149-1-nilay@linux.ibm.com>
In-Reply-To: <20241206164742.526149-1-nilay@linux.ibm.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 7 Dec 2024 11:17:46 +0800
Message-ID: <CAFj5m9Ke8+EHKQBs_Nk6hqd=LGXtk4mUxZUN5==ZcCjnZSBwHw@mail.gmail.com>
Subject: Re: [PATCH] block: Fix potential deadlock in queue_attr_store()
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, kjain101@in.ibm.com, hch@lst.de, 
	axboe@kernel.dk, ritesh.list@gmail.com, gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 12:48=E2=80=AFAM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> For storing a value to a queue attribute, the queue_attr_store function
> first freezes the queue (->q_usage_counter(io)) and then acquire
> ->sysfs_lock. This seems not correct as the usual ordering should be to
> acquire ->sysfs_lock before freezing the queue. This incorrect ordering
> causes the following lockdep splat which we are able to reproduce always
> simply by accessing /sys/kernel/debug file using ls command:
>
> [   57.597146] WARNING: possible circular locking dependency detected
> [   57.597154] 6.12.0-10553-gb86545e02e8c #20 Tainted: G        W
> [   57.597162] ------------------------------------------------------
> [   57.597168] ls/4605 is trying to acquire lock:
> [   57.597176] c00000003eb56710 (&mm->mmap_lock){++++}-{4:4}, at: __might=
_fault+0x58/0xc0
> [   57.597200]
>                but task is already holding lock:
> [   57.597207] c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{4:4},=
 at: iterate_dir+0x94/0x1d4
> [   57.597226]
>                which lock already depends on the new lock.
>
> [   57.597233]
>                the existing dependency chain (in reverse order) is:
> [   57.597241]
>                -> #5 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
> [   57.597255]        down_write+0x6c/0x18c
> [   57.597264]        start_creating+0xb4/0x24c
> [   57.597274]        debugfs_create_dir+0x2c/0x1e8
> [   57.597283]        blk_register_queue+0xec/0x294
> [   57.597292]        add_disk_fwnode+0x2e4/0x548
> [   57.597302]        brd_alloc+0x2c8/0x338
> [   57.597309]        brd_init+0x100/0x178
> [   57.597317]        do_one_initcall+0x88/0x3e4
> [   57.597326]        kernel_init_freeable+0x3cc/0x6e0
> [   57.597334]        kernel_init+0x34/0x1cc
> [   57.597342]        ret_from_kernel_user_thread+0x14/0x1c
> [   57.597350]
>                -> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
> [   57.597362]        __mutex_lock+0xfc/0x12a0
> [   57.597370]        blk_register_queue+0xd4/0x294
> [   57.597379]        add_disk_fwnode+0x2e4/0x548
> [   57.597388]        brd_alloc+0x2c8/0x338
> [   57.597395]        brd_init+0x100/0x178
> [   57.597402]        do_one_initcall+0x88/0x3e4
> [   57.597410]        kernel_init_freeable+0x3cc/0x6e0
> [   57.597418]        kernel_init+0x34/0x1cc
> [   57.597426]        ret_from_kernel_user_thread+0x14/0x1c
> [   57.597434]
>                -> #3 (&q->sysfs_lock){+.+.}-{4:4}:
> [   57.597446]        __mutex_lock+0xfc/0x12a0
> [   57.597454]        queue_attr_store+0x9c/0x110
> [   57.597462]        sysfs_kf_write+0x70/0xb0
> [   57.597471]        kernfs_fop_write_iter+0x1b0/0x2ac
> [   57.597480]        vfs_write+0x3dc/0x6e8
> [   57.597488]        ksys_write+0x84/0x140
> [   57.597495]        system_call_exception+0x130/0x360
> [   57.597504]        system_call_common+0x160/0x2c4
> [   57.597516]
>                -> #2 (&q->q_usage_counter(io)#21){++++}-{0:0}:
> [   57.597530]        __submit_bio+0x5ec/0x828
> [   57.597538]        submit_bio_noacct_nocheck+0x1e4/0x4f0
> [   57.597547]        iomap_readahead+0x2a0/0x448
> [   57.597556]        xfs_vm_readahead+0x28/0x3c
> [   57.597564]        read_pages+0x88/0x41c
> [   57.597571]        page_cache_ra_unbounded+0x1ac/0x2d8
> [   57.597580]        filemap_get_pages+0x188/0x984
> [   57.597588]        filemap_read+0x13c/0x4bc
> [   57.597596]        xfs_file_buffered_read+0x88/0x17c
> [   57.597605]        xfs_file_read_iter+0xac/0x158
> [   57.597614]        vfs_read+0x2d4/0x3b4
> [   57.597622]        ksys_read+0x84/0x144
> [   57.597629]        system_call_exception+0x130/0x360
> [   57.597637]        system_call_common+0x160/0x2c4
> [   57.597647]
>                -> #1 (mapping.invalidate_lock#2){++++}-{4:4}:
> [   57.597661]        down_read+0x6c/0x220
> [   57.597669]        filemap_fault+0x870/0x100c
> [   57.597677]        xfs_filemap_fault+0xc4/0x18c
> [   57.597684]        __do_fault+0x64/0x164
> [   57.597693]        __handle_mm_fault+0x1274/0x1dac
> [   57.597702]        handle_mm_fault+0x248/0x484
> [   57.597711]        ___do_page_fault+0x428/0xc0c
> [   57.597719]        hash__do_page_fault+0x30/0x68
> [   57.597727]        do_hash_fault+0x90/0x35c
> [   57.597736]        data_access_common_virt+0x210/0x220
> [   57.597745]        _copy_from_user+0xf8/0x19c
> [   57.597754]        sel_write_load+0x178/0xd54
> [   57.597762]        vfs_write+0x108/0x6e8
> [   57.597769]        ksys_write+0x84/0x140
> [   57.597777]        system_call_exception+0x130/0x360
> [   57.597785]        system_call_common+0x160/0x2c4
> [   57.597794]
>                -> #0 (&mm->mmap_lock){++++}-{4:4}:
> [   57.597806]        __lock_acquire+0x17cc/0x2330
> [   57.597814]        lock_acquire+0x138/0x400
> [   57.597822]        __might_fault+0x7c/0xc0
> [   57.597830]        filldir64+0xe8/0x390
> [   57.597839]        dcache_readdir+0x80/0x2d4
> [   57.597846]        iterate_dir+0xd8/0x1d4
> [   57.597855]        sys_getdents64+0x88/0x2d4
> [   57.597864]        system_call_exception+0x130/0x360
> [   57.597872]        system_call_common+0x160/0x2c4
> [   57.597881]
>                other info that might help us debug this:
>
> [   57.597888] Chain exists of:
>                  &mm->mmap_lock --> &q->debugfs_mutex --> &sb->s_type->i_=
mutex_key#3
>
> [   57.597905]  Possible unsafe locking scenario:
>
> [   57.597911]        CPU0                    CPU1
> [   57.597917]        ----                    ----
> [   57.597922]   rlock(&sb->s_type->i_mutex_key#3);
> [   57.597932]                                lock(&q->debugfs_mutex);
> [   57.597940]                                lock(&sb->s_type->i_mutex_k=
ey#3);
> [   57.597950]   rlock(&mm->mmap_lock);
> [   57.597958]
>                 *** DEADLOCK ***
>
> [   57.597965] 2 locks held by ls/4605:
> [   57.597971]  #0: c0000000137c12f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fd=
get_pos+0xcc/0x154
> [   57.597989]  #1: c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{=
4:4}, at: iterate_dir+0x94/0x1d4
>
> Prevent the above lockdep warning by acquiring ->sysfs_lock before
> freezing the queue while storing a queue attribute in queue_attr_store
> function.
>
> Reported-by: kjain101@in.ibm.com
> Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
> Tested-by: kjain101@in.ibm.com
> Cc: hch@lst.de
> Cc: axboe@kernel.dk
> Cc: ritesh.list@gmail.com
> Cc: ming.lei@redhat.com
> Cc: gjoyce@linux.ibm.com
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 4241aea84161..f648b112782f 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -706,11 +706,11 @@ queue_attr_store(struct kobject *kobj, struct attri=
bute *attr,
>         if (entry->load_module)
>                 entry->load_module(disk, page, length);
>
> -       blk_mq_freeze_queue(q);
>         mutex_lock(&q->sysfs_lock);
> +       blk_mq_freeze_queue(q);
>         res =3D entry->store(disk, page, length);
> -       mutex_unlock(&q->sysfs_lock);
>         blk_mq_unfreeze_queue(q);
> +       mutex_unlock(&q->sysfs_lock);
>         return res;

We freeze queue first in __blk_mq_update_nr_hw_queues() in which
q->sysfs_lock is acquired after the freezing.

So this simple fix may trigger a new ABBA warning.

Thanks,

