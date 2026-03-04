Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F6361DA7
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608229; cv=pass; b=NVELc5LVXHyROaKlZhG7cc2Ee3W8kLL2NP7A9I9Iyx7ihQlbAYZe+rHsqgZGdVL7jiSrHMZmLbcLNN/8Y7IFDb78DhwuzIjrsfEDdNEgeztY1LsXvpMo4JYS3VVE04G/6gnKSAFfBk3XlH9NDuOphNzQjeMKON9Nvps65sbid4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608229; c=relaxed/simple;
	bh=Wbnv7uySncqiKWzUOhhfH/KJ9R/jae/oIPRi+cf9DWY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WvRrlZ/kVRNNSgPTupqp1ynXHFD/a6OvaU0QiqYH5R+JWgg3bpxY4h3BhLCwqQYq6v3MXpwMjLNNymWPujd3Bf/SSok/r/3fRz6kmrz9j7jLYWY7PJloiEDRletdtsiAzepA1pxSEkLyAQXNJaPYv2tt9oAER6+bkLryvu73pq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9s7vHeH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kdWw8uPl; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9s7vHeH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kdWw8uPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772608226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=zyGGs3R7lbJ+khIaUnwQ99YhxaFZt/O2WPTZx5j8EF0=;
	b=W9s7vHeHQ64EhnHKP2N2FGXYgCm1ylfL0BYfKCIJlPdrCiBnc8+K4X9jbnFc2FvrGx2jqI
	SWfUofupupS/V0NUO7Q1peEKfPvO1UP51gOKIguzRjWPRt4M1cCxEvzYdgjLyvFKnPeNbc
	fBOWCyNdhaEAWWi3edvGxgP7jIGR2tM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-gD0Cd_o9P_WtnBPUHkurZg-1; Wed, 04 Mar 2026 02:10:25 -0500
X-MC-Unique: gD0Cd_o9P_WtnBPUHkurZg-1
X-Mimecast-MFC-AGG-ID: gD0Cd_o9P_WtnBPUHkurZg_1772608224
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38709142f7aso56790101fa.2
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 23:10:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772608220; cv=none;
        d=google.com; s=arc-20240605;
        b=U572+BiZbZJpbiKRgQm/7wyQsxwc1Xs7GDttKB1YNjUoDNpv4XNk7D2Rp3Lve2DHCF
         K4Htr/fDa7O84mKhYHIMOKJWvtU5rvaDuXj6bNbq8dy/2Tk/4kIkgUjjDQNyac8mpNzX
         Jj2MQK40dVvepl6v3V2KpcgKES959dOO6XilOitBI30yFJdOMxjrmhe7hDTto/EFuPvt
         KlTcKihUY6gggOt7WZT3ik4Bl121p777I6Fsx9NyYw00kyApQ06mYv1sxMmzN5AbjZa+
         p4CmGTResa938c8Avgyv2cTf4q7pQaNEK+O1J99UH3hj2yISSgqZcMLum3chfnCQ7tDc
         GMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=zyGGs3R7lbJ+khIaUnwQ99YhxaFZt/O2WPTZx5j8EF0=;
        fh=QeEcbxyneVCUJlEAI9EGr91x8a/xyH7twq7USfJw/m0=;
        b=eyiCjxYcjEJ6kT3Gj2JWB8Q7sAE/ccADKQT1ktAMXlTM1XPghLVumblqCLMj0R52x4
         oZfxbh2mbI3q3KY2ab/SJNRpaO+PPWW3dWJI5ilSreagBRRUpiYdyRF1xPBVw85sSyDQ
         oP8+fM6nVlm9nNYfXWFbt9bPkWyjFM/SZf91xedO/ZAfaLZxWyfsIsJ/DJPphgAQcoQY
         psPTzHhCdaaEQHFNg4SfLr1+MhMQ0HnjcFedSU7rdyAmg+RKJuIr0u0fLg8vJP/U1vSz
         23iQhneJPz/hVRnjJmkAjvC5GzmijsXYdOFlTDkYjr3kMduEcs5IUumPbHCOrdyHe+ZT
         3gLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772608220; x=1773213020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zyGGs3R7lbJ+khIaUnwQ99YhxaFZt/O2WPTZx5j8EF0=;
        b=kdWw8uPlRudns9kSrKacg+C0d0bWJzq23EH+ZPreqBoc4TNG0R5+ZQ55vn/t59y8e7
         4lfVotAmDZ7Sr72Zc9pk/hukkLEl3y26tWooYjf7TZB25znByKWBodLmQ3J7PsqWDwGn
         f5SVRNkhGKukxqePace/34AThV5X4UgRJfqSSrIpZCJEY3wO3WejWgvRe6EtpvbxC6qR
         QRWpJHl4oDniJCTWf7y7hNtjt8QvpBFZ1qgZNO6MxGGCw6u38NcxLhFDtk8XxRqYhBmf
         I1pZj8A4rEtsQe2UuG+XrCXemlQuxcx4Vjfndh3FRbd9m39TdBAYMfjOvgJHCVvfeYum
         yCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608220; x=1773213020;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyGGs3R7lbJ+khIaUnwQ99YhxaFZt/O2WPTZx5j8EF0=;
        b=Qq2jYIHZYrjagSSZTpyN8GTBK2LP5nelVY3JBW8f8l5EYbUHgoa45xHUzwV6mFiOiP
         UKE1GZWu9gMkFcY8sT1aF1VLz6HHDLRR81aQXb0ubZlk156XHLqi722ENXmWK/7181u7
         J4Oo99xEgtu9xZmf3FQ/1kVg25G+ILEKUTi9KcD2ySs+b38o1h758XYD7PSvqFkuDBWr
         h7jgtXQbRigNVQFz1cbJgChW/bcLNX1DIBUuCUmlK0aLUjlkYBLDnb2zL6HV/RPfK1M0
         SX/+lIsH7CUj5zu0bO+eHDz7h3uQwgX7WGURlN/zzglV0Ai+g3y7+IhcbD3PamwWVN36
         kKjw==
X-Gm-Message-State: AOJu0YynFnC7abHsfnPExFGkmq1RMyye+1SwJSAfw69QogH2a3zXsLFr
	9fjq04hW+ql4jFk0P/DGB+qzxZ0fcwITcYxZ2R2BrSWZkkoaXWy7fTrTjiIlTqrsVQB3v796pFR
	d/4dE0YMwO2a5eh9xwvkQytLmu5B1JZIKZMgpvjvvoTUVnUkYCX2MsdazJv5998zJHfFHNxBjap
	Cskkp3lEyPQaFglehpofDxSkbRy7bHPLuZCiSBoEhopm+nMrnwUCHeW5g=
X-Gm-Gg: ATEYQzwTYaiRTMm3eRhCfxD6DskzvhlHNMTn4KBugVTNztGqBgX1jfEIr0wIagkvcYn
	LmvT3qwpvGB8iTUyCKYAQTA3Be5I83V8FYmANaCwmTSYmr6EZGt+IzFzUs3Jp0bOahnNyrcc9BJ
	a5AQNT47yBPj9tNh5VHnwAXeLP9TayHieUF0UA0x0bDXCLa80rO4shpOaWugMeo7oXf8Tn29j4m
	4UQ18RHrUbx55MTFEZeP5/y8E7GW0bd6eyyv+2f4EYucWB8u3c=
X-Received: by 2002:a2e:8245:0:b0:386:1e28:4d72 with SMTP id 38308e7fff4ca-38a2c7cf3f0mr6942811fa.30.1772608220048;
        Tue, 03 Mar 2026 23:10:20 -0800 (PST)
X-Received: by 2002:a2e:8245:0:b0:386:1e28:4d72 with SMTP id
 38308e7fff4ca-38a2c7cf3f0mr6942531fa.30.1772608219484; Tue, 03 Mar 2026
 23:10:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 4 Mar 2026 15:10:06 +0800
X-Gm-Features: AaiRm52OmRqgY3qt4RN4bm8LukcYuPxsB5jOFxzJ2zphs7RjQdBnC_ZRStpmrO4
Message-ID: <CAHj4cs-em-4acsHabMdT=jJhXkCzjnprD-aQH1OgrZo4nTnmMw@mail.gmail.com>
Subject: [bug report] blktests block/022 failed with possible circular locking
 dependency detected at: __kernfs_remove+0x275/0x710 and del_gendisk+0xfd/0x190
To: linux-block <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi

I found blktests block/022 failed on the latest
linux-block/for-next[1], please help check it and let me know if you
need any info/testing for it, thanks.

[1]
commit b82c5e4f1bcb3fa78ba3c95a0d198f55553c0fc1
Merge: 187d9a5a18b4 d47f7c173262
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Mar 2 14:04:16 2026 -0700

    Merge branch 'for-7.1/block' into for-next

dmesg:
[ 1329.227229] run blktests block/022 at 2026-03-03 13:51:07
[ 1329.838331] null_blk: module loaded
--snip--
[ 1349.577627] null_blk: disk 1 created
[ 1349.590297] ======================================================
[ 1349.596474] WARNING: possible circular locking dependency detected
[ 1349.602654] 7.0.0-rc2+ #1 Not tainted
[ 1349.606320] ------------------------------------------------------
[ 1349.612499] check/14895 is trying to acquire lock:
[ 1349.617291] ffff8883142961f8 (kn->active#104){++++}-{0:0}, at:
__kernfs_remove+0x275/0x710
[ 1349.625576]
               but task is already holding lock:
[ 1349.631410] ffffffffc1fe7db0
(&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0xfd/0x190
[ 1349.640130]
               which lock already depends on the new lock.

[ 1349.648300]
               the existing dependency chain (in reverse order) is:
[ 1349.655780]
               -> #1 (&set->update_nr_hwq_lock){++++}-{4:4}:
[ 1349.662670]        __lock_acquire+0x58c/0xbd0
[ 1349.667037]        lock_acquire.part.0+0xbd/0x260
[ 1349.671742]        down_read+0xa2/0x490
[ 1349.675581]        elv_iosched_store+0x31e/0x3b0
[ 1349.680203]        queue_attr_store+0x232/0x2f0
[ 1349.684741]        kernfs_fop_write_iter+0x3df/0x5f0
[ 1349.689711]        vfs_write+0x525/0xfd0
[ 1349.693644]        ksys_write+0xf9/0x1d0
[ 1349.697578]        do_syscall_64+0x13a/0x1520
[ 1349.701947]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1349.707528]
               -> #0 (kn->active#104){++++}-{0:0}:
[ 1349.713551]        check_prev_add+0xf1/0xc80
[ 1349.717832]        validate_chain+0x481/0x560
[ 1349.722200]        __lock_acquire+0x58c/0xbd0
[ 1349.726568]        lock_acquire.part.0+0xbd/0x260
[ 1349.731281]        kernfs_drain+0x3cf/0x4a0
[ 1349.735466]        __kernfs_remove+0x275/0x710
[ 1349.739914]        kernfs_remove_by_name_ns+0x9c/0x100
[ 1349.745062]        remove_files+0x8c/0x1a0
[ 1349.749170]        sysfs_remove_group+0x7b/0x170
[ 1349.753797]        sysfs_remove_groups+0x53/0xa0
[ 1349.758424]        __kobject_del+0x7d/0x1e0
[ 1349.762610]        kobject_del+0x35/0x50
[ 1349.766536]        blk_unregister_queue+0x112/0x2b0
[ 1349.771417]        __del_gendisk+0x265/0x9e0
[ 1349.775696]        del_gendisk+0x105/0x190
[ 1349.779796]        null_del_dev.part.0+0x165/0x480 [null_blk]
[ 1349.785551]        nullb_device_power_store+0x1a2/0x280 [null_blk]
[ 1349.791737]        configfs_write_iter+0x2ac/0x460
[ 1349.796530]        vfs_write+0x525/0xfd0
[ 1349.800456]        ksys_write+0xf9/0x1d0
[ 1349.804383]        do_syscall_64+0x13a/0x1520
[ 1349.808742]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1349.814315]
               other info that might help us debug this:

[ 1349.822314]  Possible unsafe locking scenario:

[ 1349.828232]        CPU0                    CPU1
[ 1349.832766]        ----                    ----
[ 1349.837296]   rlock(&set->update_nr_hwq_lock);
[ 1349.841752]                                lock(kn->active#104);
[ 1349.847767]                                lock(&set->update_nr_hwq_lock);
[ 1349.854647]   lock(kn->active#104);
[ 1349.858148]
                *** DEADLOCK ***

[ 1349.864068] 5 locks held by check/14895:
[ 1349.867994]  #0: ffff8882807d0440 (sb_writers#16){.+.+}-{0:0}, at:
ksys_write+0xf9/0x1d0
[ 1349.876106]  #1: ffff8881c5d6fa90 (&buffer->mutex){+.+.}-{4:4}, at:
configfs_write_iter+0x71/0x460
[ 1349.885085]  #2: ffff8881a17a6280 (&p->frag_sem){++++}-{4:4}, at:
configfs_write_iter+0x1d9/0x460
[ 1349.893975]  #3: ffffffffc1fe7eb0 (&lock){+.+.}-{4:4}, at:
nullb_device_power_store+0xab/0x280 [null_blk]
[ 1349.903562]  #4: ffffffffc1fe7db0
(&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0xfd/0x190
[ 1349.912712]
               stack backtrace:
[ 1349.917076] CPU: 1 UID: 0 PID: 14895 Comm: check Not tainted
7.0.0-rc2+ #1 PREEMPT(full)
[ 1349.917082] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.21.1 09/24/2025
[ 1349.917086] Call Trace:
[ 1349.917090]  <TASK>
[ 1349.917094]  dump_stack_lvl+0x6f/0xb0
[ 1349.917103]  print_circular_bug.cold+0x38/0x45
[ 1349.917113]  check_noncircular+0x146/0x160
[ 1349.917130]  check_prev_add+0xf1/0xc80
[ 1349.917134]  ? alloc_chain_hlocks+0x8/0x1d0
[ 1349.917139]  ? srso_return_thunk+0x5/0x5f
[ 1349.917144]  ? add_chain_cache+0x11c/0x300
[ 1349.917152]  validate_chain+0x481/0x560
[ 1349.917157]  ? srso_return_thunk+0x5/0x5f
[ 1349.917162]  ? mark_lock+0x2e3/0x3d0
[ 1349.917172]  __lock_acquire+0x58c/0xbd0
[ 1349.917178]  ? srso_return_thunk+0x5/0x5f
[ 1349.917187]  lock_acquire.part.0+0xbd/0x260
[ 1349.917192]  ? __kernfs_remove+0x275/0x710
[ 1349.917201]  ? srso_return_thunk+0x5/0x5f
[ 1349.917205]  ? rcu_is_watching+0x15/0xb0
[ 1349.917211]  ? srso_return_thunk+0x5/0x5f
[ 1349.917215]  ? lock_acquire+0x159/0x180
[ 1349.917225]  kernfs_drain+0x3cf/0x4a0
[ 1349.917231]  ? __kernfs_remove+0x275/0x710
[ 1349.917239]  ? __pfx_kernfs_drain+0x10/0x10
[ 1349.917245]  ? srso_return_thunk+0x5/0x5f
[ 1349.917249]  ? __lock_release.isra.0+0x1a2/0x2c0
[ 1349.917258]  ? kernfs_root+0xb2/0x1c0
[ 1349.917263]  ? srso_return_thunk+0x5/0x5f
[ 1349.917269]  ? srso_return_thunk+0x5/0x5f
[ 1349.917274]  ? kernfs_root+0xbc/0x1c0
[ 1349.917283]  __kernfs_remove+0x275/0x710
[ 1349.917289]  ? kernfs_find_ns+0x1a1/0x390
[ 1349.917299]  kernfs_remove_by_name_ns+0x9c/0x100
[ 1349.917307]  remove_files+0x8c/0x1a0
[ 1349.917316]  sysfs_remove_group+0x7b/0x170
[ 1349.917324]  sysfs_remove_groups+0x53/0xa0
[ 1349.917332]  __kobject_del+0x7d/0x1e0
[ 1349.917340]  kobject_del+0x35/0x50
[ 1349.917346]  blk_unregister_queue+0x112/0x2b0
[ 1349.917354]  __del_gendisk+0x265/0x9e0
[ 1349.917362]  ? down_read+0xbf/0x490
[ 1349.917367]  ? local_clock_noinstr+0xd/0xe0
[ 1349.917374]  ? __pfx___del_gendisk+0x10/0x10
[ 1349.917378]  ? __lock_release.isra.0+0x1a2/0x2c0
[ 1349.917384]  ? srso_return_thunk+0x5/0x5f
[ 1349.917390]  ? srso_return_thunk+0x5/0x5f
[ 1349.917395]  ? __up_write+0x27e/0x4e0
[ 1349.917400]  ? del_gendisk+0xb4/0x190
[ 1349.917409]  del_gendisk+0x105/0x190
[ 1349.917417]  null_del_dev.part.0+0x165/0x480 [null_blk]
[ 1349.917434]  nullb_device_power_store+0x1a2/0x280 [null_blk]
[ 1349.917448]  ? __pfx_nullb_device_power_store+0x10/0x10 [null_blk]
[ 1349.917460]  ? srso_untrain_ret+0x2/0x2
[ 1349.917473]  configfs_write_iter+0x2ac/0x460
[ 1349.917484]  vfs_write+0x525/0xfd0
[ 1349.917495]  ? __pfx_vfs_write+0x10/0x10
[ 1349.917507]  ? srso_return_thunk+0x5/0x5f
[ 1349.917511]  ? __lock_acquire+0x58c/0xbd0
[ 1349.917521]  ? srso_return_thunk+0x5/0x5f
[ 1349.917526]  ? srso_return_thunk+0x5/0x5f
[ 1349.917530]  ? find_held_lock+0x32/0x90
[ 1349.917541]  ksys_write+0xf9/0x1d0
[ 1349.917547]  ? __pfx_ksys_write+0x10/0x10
[ 1349.917553]  ? srso_return_thunk+0x5/0x5f
[ 1349.917557]  ? lockdep_hardirqs_on+0x78/0x100
[ 1349.917563]  ? srso_return_thunk+0x5/0x5f
[ 1349.917568]  ? do_syscall_64+0xde/0x1520
[ 1349.917577]  do_syscall_64+0x13a/0x1520
[ 1349.917582]  ? rcu_is_watching+0x15/0xb0
[ 1349.917589]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1349.917593]  ? srso_return_thunk+0x5/0x5f
[ 1349.917598]  ? lockdep_hardirqs_on+0x78/0x100
[ 1349.917603]  ? srso_return_thunk+0x5/0x5f
[ 1349.917607]  ? do_syscall_64+0x212/0x1520
[ 1349.917616]  ? srso_return_thunk+0x5/0x5f
[ 1349.917620]  ? __lock_acquire+0x58c/0xbd0
[ 1349.917630]  ? srso_return_thunk+0x5/0x5f
[ 1349.917634]  ? lock_acquire.part.0+0xbd/0x260
[ 1349.917641]  ? srso_return_thunk+0x5/0x5f
[ 1349.917645]  ? find_held_lock+0x32/0x90
[ 1349.917651]  ? set_close_on_exec+0x5c/0x1d0
[ 1349.917658]  ? srso_return_thunk+0x5/0x5f
[ 1349.917662]  ? srso_return_thunk+0x5/0x5f
[ 1349.917667]  ? find_held_lock+0x32/0x90
[ 1349.917672]  ? srso_return_thunk+0x5/0x5f
[ 1349.917676]  ? local_clock_noinstr+0xd/0xe0
[ 1349.917682]  ? srso_return_thunk+0x5/0x5f
[ 1349.917687]  ? __lock_release.isra.0+0x1a2/0x2c0
[ 1349.917693]  ? do_fcntl+0x58e/0xde0
[ 1349.917701]  ? srso_return_thunk+0x5/0x5f
[ 1349.917705]  ? do_raw_spin_unlock+0x58/0x1f0
[ 1349.917712]  ? srso_return_thunk+0x5/0x5f
[ 1349.917716]  ? _raw_spin_unlock+0x2d/0x50
[ 1349.917722]  ? srso_return_thunk+0x5/0x5f
[ 1349.917726]  ? do_fcntl+0x58e/0xde0
[ 1349.917733]  ? __pfx_do_fcntl+0x10/0x10
[ 1349.917741]  ? srso_return_thunk+0x5/0x5f
[ 1349.917746]  ? srso_return_thunk+0x5/0x5f
[ 1349.917750]  ? find_held_lock+0x32/0x90
[ 1349.917759]  ? __lock_release.isra.0+0x1a2/0x2c0
[ 1349.917765]  ? srso_return_thunk+0x5/0x5f
[ 1349.917769]  ? srso_return_thunk+0x5/0x5f
[ 1349.917773]  ? selinux_file_fcntl+0x1c/0xf0
[ 1349.917782]  ? srso_return_thunk+0x5/0x5f
[ 1349.917787]  ? rcu_is_watching+0x15/0xb0
[ 1349.917793]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1349.917797]  ? srso_return_thunk+0x5/0x5f
[ 1349.917802]  ? lockdep_hardirqs_on+0x78/0x100
[ 1349.917807]  ? srso_return_thunk+0x5/0x5f
[ 1349.917812]  ? do_syscall_64+0x212/0x1520
[ 1349.917816]  ? srso_return_thunk+0x5/0x5f
[ 1349.917821]  ? do_syscall_64+0x212/0x1520
[ 1349.917825]  ? srso_return_thunk+0x5/0x5f
[ 1349.917830]  ? do_syscall_64+0x212/0x1520
[ 1349.917834]  ? srso_return_thunk+0x5/0x5f
[ 1349.917839]  ? do_syscall_64+0x212/0x1520
[ 1349.917849]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1349.917854] RIP: 0033:0x7f18a1d9d544
[ 1349.917860] Code: 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 40 00 f3 0f 1e fa 80 3d a5 cb 0d 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
18 48
[ 1349.917864] RSP: 002b:00007ffcc4f4aca8 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1349.917870] RAX: ffffffffffffffda RBX: 00007f18a1e735c0 RCX: 00007f18a1d9d544
[ 1349.917873] RDX: 0000000000000002 RSI: 00005646e17c3970 RDI: 0000000000000001
[ 1349.917877] RBP: 0000000000000002 R08: 0000000000000073 R09: 00000000ffffffff
[ 1349.917880] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
[ 1349.917883] R13: 00005646e17c3970 R14: 0000000000000002 R15: 00007f18a1e70f00
[ 1349.917902]  </TASK>


-- 
Best Regards,
  Yi Zhang

