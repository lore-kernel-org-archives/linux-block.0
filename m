Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC553176FB1
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770619401; cv=pass; b=eAQeAYqPLYs2YDsFnbI5KKuzwTcFjrCtKmT3YV35arWCczAbevpjbDmDDRDPso5ISaOSKsFtq0EEQKoxDY6EHElul6ZrG9Tqecj5jFLOn0K1WqjyZFekd2GvOtPrbBhQlae9E5D0lyxLaRdYCqt7RwX7rh1L+xyHhGvjCI79wjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770619401; c=relaxed/simple;
	bh=ENOnUOAkxza38S3xY2M0u/jrCf60em0N7iszpajEF4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ty1oAkkpT7kQiTzjJnoDY5lBcLddNQiNX2JKzDqq4TSo0PPsYsnIR+Rh3S3m5lZDqbIatWzDU/9MKcvpNit1O5ay/wu9XRqZUhqwiHrLAsZMIT/kids8kUw2OzHXCCgxE0jVw1zq2BCAGB7894icrGHXrVycJNXPB2tXvbWM1BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QH1kvU9m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATYY2S/t; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH1kvU9m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATYY2S/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770619399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GnKK6sfc2GmKpLWJlrvgIGsj8vO+Vk+aDDg65qlfvg=;
	b=QH1kvU9mw5A0Ipv5wDHB08ZKuVRqOnQbdv7F12KrnBL3BV2ImYWGPN6cAlcaT2S4RLe2bj
	nvOUzdCqsgPCQZ8mSdq6m/CTC92j72CLjw+I0IlF4++HcAB30cKkBKEgZIRze8mtR5gkcA
	Ar9CC9kfNOs6EsrKd+uEeRHv5uF+2fs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-I6I6dHmjO0yM-6mFh6nD1w-1; Mon, 09 Feb 2026 01:43:18 -0500
X-MC-Unique: I6I6dHmjO0yM-6mFh6nD1w-1
X-Mimecast-MFC-AGG-ID: I6I6dHmjO0yM-6mFh6nD1w_1770619397
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-386904bbb9cso23373381fa.1
        for <linux-block@vger.kernel.org>; Sun, 08 Feb 2026 22:43:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770619397; cv=none;
        d=google.com; s=arc-20240605;
        b=FEIpfJOIrBeTL2mjZFi6fyYb7bJmp3X6RJfE7TNTtuUmcRXrzDWSguuUj+jqSV5Pgq
         WC1A2MMKDN5mp0rrTrAf+WvSMcorg1q1DWl2QRu3w3rB6ZRms4iHewjvoY6GZP13rfgK
         Uh3gI8zBgMS1lX3GqtKIY+iUgFEnRTbWRljQYTuFtSCRVuQCs1zQ3veH6APQ0HM3MUkP
         HBhZMELGSp+/+Dr0jiwCDKcmg4WSiGEJrCGPeQqmdwp0/f8HqZ2r6p4IJW78mr8494GZ
         yYxz3mG0wOEXA5Osn+MGkuquHpoX7nq0kYfec4AChSVoNh8CZSwyYmSMmiaHnnNWnPxA
         paHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6GnKK6sfc2GmKpLWJlrvgIGsj8vO+Vk+aDDg65qlfvg=;
        fh=XtwBAiglHC6mZKX3uv/GKQ2OLn1TKLTWbG3EzAFtjn0=;
        b=F4oDLLl+e7f+NvTSmwiRdHzPeFGDCE6K5s4DwjvfEAp3Pcgi12myHY/GfukRZV7dgF
         r2CXvhPmJHrj+Dfl7KgrsxXNN5SsNQrjTcrA06ONNZxfN5pMesmDa+O6ILjke7lQlKbz
         QvR1nSEEN6Usu9cIBYnCSz7pFXDwCteAJY/bCQLLI7DGdnFs4IudBksFlqmfSE5ixg50
         6XvWJNqv/L/u5UGCQAJjZJk6Um3NOz3giKycTRjRSIAPckslnjjuhgHsd6ZPK4G3PxFw
         ToyVbiKJsheM3xpYktLCcp06UerZupTiRYyVrmElizutuUCnar6RQEFwX0gJNorR980k
         vylg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770619397; x=1771224197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GnKK6sfc2GmKpLWJlrvgIGsj8vO+Vk+aDDg65qlfvg=;
        b=ATYY2S/tz0jp9NnApgZGoOSrVKQqWjeVHnSdBk6VlZLC+ykJrca/lqO1I5HCBURM+K
         STO6mUyHrTag97w+0gOSAfFcLvRJrafiE5scVWiCfaOAa1toQI4lkQ+dtsLuhE0EQH7X
         3uSnsSCYBnWvg/juXNQz5fvI1SiH3qsMDlKBWDb5u7FiQHwb1petGiflLF+6qGNjfmqz
         XIh+7xp+Drn0vpB3kAeF/GrKM6n/wKrzcQxSswARgywafIN+ALYURoyRMA1rz/yjI9x6
         0pFGMUB6v5Z9Qc0VeDDauuO9mryVB1KyyIdwmyzRW4EVrago866lMSYiZiMBmVYWyX1a
         C6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770619397; x=1771224197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6GnKK6sfc2GmKpLWJlrvgIGsj8vO+Vk+aDDg65qlfvg=;
        b=ryLddlijItsArSREJdioVNBFG1v/GGvNkGiUY+QTugvcLCwIsznrRb/6YA9XQ919Nb
         Y8fE73Wjclq4jQJOEoIq31K6U0r13iNmUftntQqYvsnkHQk5ssStUGZCacymxViWEOGB
         CIgrJfq/M8SqIZprBk6RTdHgTy4Rn7nFQ6+ptuww2Nco6q0P4IhLQtsTehZrM5rP/iRt
         7Fzjeh0OuWjt4J5uLXBMBbeP3d1wk1kZ8kGa0wGXJtzZlTgC1JXJWiiGMXz4tvuUvaIT
         jr+W7dQf8f94o8Zk+BJfZFOqPfAmgWM9Zou3Q5v55OFujz2+NtWtFSnT02kcJv7YNgys
         LRcg==
X-Gm-Message-State: AOJu0YxyWbefUHVffkqhoQs191pZOiMWh8EIXeKoM9QW7tL8zv4xRpEO
	RKGB0FY4NxhcY/5G0WsIRzsUsBT7PkQEqlwOEGgEaHMrVSSMYD3s8RNRhbxlgkg7SBOp4ElM4Dx
	0OTld024ksqwecutfhQ9Nqmvoluhvp9AJwolELYMg5fBAvJGT4uTtb/r1HAFJD1jfvMe9GkI9MS
	IpgNIsKA8O6DUj2eoGJq4TDOjeRaIWPwc4ZBupvbA=
X-Gm-Gg: AZuq6aIiCF4+PFDTz4VUAhAb/AvIe2OvGGlCWOeGgY3D1wN+y8pbsia28fgXjZ2mp7F
	wvkfiOaYNmOTffFDT+Kg7nRNd7HHwtc6+C/uiZc74h6OmlPXrJRrQFHnQJ3bCtk3/uMey1FdZna
	oGLzhR9THobUEiM5Uk5MT/MZtsirG3vBLzkXacT2v3taHxOYyrhgVRfqKUdIiV+a1apET21dNE1
	y1aEZC2fB63eQktcP8wYu/lQkFR64mTphmZtRw=
X-Received: by 2002:a05:651c:4185:b0:383:25e7:88e8 with SMTP id 38308e7fff4ca-386b4f15c63mr31665661fa.13.1770619396644;
        Sun, 08 Feb 2026 22:43:16 -0800 (PST)
X-Received: by 2002:a05:651c:4185:b0:383:25e7:88e8 with SMTP id
 38308e7fff4ca-386b4f15c63mr31665591fa.13.1770619396133; Sun, 08 Feb 2026
 22:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8F=OV9s3La2kEQ34YndgfZP-B5PHS4Z8_b9euKG6J4mw@mail.gmail.com>
 <95f56935-9df0-4012-9d82-8f10b021c9f5@linux.ibm.com>
In-Reply-To: <95f56935-9df0-4012-9d82-8f10b021c9f5@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 9 Feb 2026 14:43:03 +0800
X-Gm-Features: AZwV_QjXHYKR8kqI6ZxJTlKMN7BO7kssP5VvrGYNfrsUbbnRlj_Qcs5DEs0rN-4
Message-ID: <CAHj4cs_iETU_7VnfYkA8RF41PHgXsEqw82oCH9_pJp_usZDRYg@mail.gmail.com>
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected at pcpu_alloc_noprof+0x8a3/0xd90 and __blk_mq_update_nr_hw_queues+0x76c/0xca0
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block <linux-block@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Ming Lei <ming.lei@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nilay

In case you missed this bug report, this issue can still be reproduced
on the latest linux-block/for-next, thanks.

[ 1549.643282] run blktests block/029 at 2026-02-08 08:22:30
[ 1549.968483] null_blk: disk nullb1 created

[ 1551.208843] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1551.215023] WARNING: possible circular locking dependency detected
[ 1551.221203] 6.19.0-rc8+ #1 Not tainted
[ 1551.224962] ------------------------------------------------------
[ 1551.231142] check/12517 is trying to acquire lock:
[ 1551.235933] ffffffffa8356190 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
pcpu_alloc_noprof+0x92f/0xf10
[ 1551.244565]
               but task is already holding lock:
[ 1551.250397] ffff888227b5c7e8
(&q->q_usage_counter(io)#28){++++}-{0:0}, at:
__blk_mq_update_nr_hw_queues+0x758/0xd00
[ 1551.260849]
               which lock already depends on the new lock.

[ 1551.269021]
               the existing dependency chain (in reverse order) is:
[ 1551.276501]
               -> #2 (&q->q_usage_counter(io)#28){++++}-{0:0}:
[ 1551.283564]        __lock_acquire+0x58c/0xbd0
[ 1551.287923]        lock_acquire.part.0+0xbd/0x260
[ 1551.292631]        blk_alloc_queue+0x5c1/0x740
[ 1551.297085]        blk_mq_alloc_queue+0x14b/0x230
[ 1551.301800]        __blk_mq_alloc_disk+0x18/0xd0
[ 1551.306426]        null_add_dev+0x7c1/0x1420 [null_blk]
[ 1551.311661]        nullb_device_power_store+0x1e6/0x280 [null_blk]
[ 1551.317848]        configfs_write_iter+0x2ac/0x460
[ 1551.322641]        vfs_write+0x525/0xfd0
[ 1551.326577]        ksys_write+0xf9/0x1d0
[ 1551.330510]        do_syscall_64+0x95/0x520
[ 1551.334705]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1551.340276]
               -> #1 (fs_reclaim){+.+.}-{0:0}:
[ 1551.345956]        __lock_acquire+0x58c/0xbd0
[ 1551.350324]        lock_acquire.part.0+0xbd/0x260
[ 1551.355035]        fs_reclaim_acquire+0xc9/0x110
[ 1551.359655]        prepare_alloc_pages+0x166/0x5f0
[ 1551.364447]        __alloc_frozen_pages_noprof+0x151/0x3b0
[ 1551.369934]        __alloc_pages_noprof+0x10/0x1b0
[ 1551.374727]        pcpu_alloc_pages.isra.0+0xcf/0x3d0
[ 1551.379780]        pcpu_populate_chunk+0x35/0x70
[ 1551.384408]        pcpu_alloc_noprof+0x7b1/0xf10
[ 1551.389035]        iommu_dma_init_fq+0x197/0x750
[ 1551.393664]        iommu_dma_init_domain+0x553/0x990
[ 1551.398639]        iommu_setup_dma_ops+0xd2/0x1a0
[ 1551.403353]        bus_iommu_probe+0x1ee/0x4b0
[ 1551.407796]        iommu_device_register+0x186/0x270
[ 1551.412765]        iommu_init_pci+0xb8f/0xc20
[ 1551.417131]        amd_iommu_init_pci+0x80/0x500
[ 1551.421749]        state_next+0x297/0x5c0
[ 1551.425763]        iommu_go_to_state+0x2b/0x60
[ 1551.430209]        pci_iommu_init+0x3b/0x70
[ 1551.434396]        do_one_initcall+0xa7/0x260
[ 1551.438762]        do_initcalls+0x1b4/0x1f0
[ 1551.442950]        kernel_init_freeable+0x4b0/0x540
[ 1551.447836]        kernel_init+0x1c/0x150
[ 1551.451848]        ret_from_fork+0x4ce/0x710
[ 1551.456122]        ret_from_fork_asm+0x1a/0x30
[ 1551.460577]
               -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
[ 1551.466772]        check_prev_add+0xf1/0xc80
[ 1551.471046]        validate_chain+0x481/0x560
[ 1551.475412]        __lock_acquire+0x58c/0xbd0
[ 1551.479773]        lock_acquire.part.0+0xbd/0x260
[ 1551.484479]        __mutex_lock+0x1a7/0x1ba0
[ 1551.488760]        pcpu_alloc_noprof+0x92f/0xf10
[ 1551.493387]        sbitmap_init_node+0x287/0x730
[ 1551.498007]        sbitmap_queue_init_node+0x2e/0x3e0
[ 1551.503061]        blk_mq_init_tags+0x15f/0x2c0
[ 1551.507599]        blk_mq_alloc_map_and_rqs+0xa6/0x310
[ 1551.512740]        __blk_mq_alloc_map_and_rqs+0x104/0x1f0
[ 1551.518140]        blk_mq_realloc_tag_set_tags+0x1e8/0x300
[ 1551.523634]        __blk_mq_update_nr_hw_queues+0x79f/0xd00
[ 1551.529207]        blk_mq_update_nr_hw_queues+0x3b/0x60
[ 1551.534440]        nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
[ 1551.540714]        nullb_device_submit_queues_store+0xdb/0x170 [null_blk=
]
[ 1551.547509]        configfs_write_iter+0x2ac/0x460
[ 1551.552302]        vfs_write+0x525/0xfd0
[ 1551.556226]        ksys_write+0xf9/0x1d0
[ 1551.560155]        do_syscall_64+0x95/0x520
[ 1551.564348]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1551.569921]
               other info that might help us debug this:

[ 1551.577920] Chain exists of:
                 pcpu_alloc_mutex --> fs_reclaim --> &q->q_usage_counter(io=
)#28

[ 1551.589323]  Possible unsafe locking scenario:

[ 1551.595244]        CPU0                    CPU1
[ 1551.599776]        ----                    ----
[ 1551.604308]   lock(&q->q_usage_counter(io)#28);
[ 1551.608850]                                lock(fs_reclaim);
[ 1551.614517]                                lock(&q->q_usage_counter(io)#=
28);
[ 1551.621574]   lock(pcpu_alloc_mutex);
[ 1551.625246]
                *** DEADLOCK ***

[ 1551.631167] 8 locks held by check/12517:
[ 1551.635094]  #0: ffff888147060440 (sb_writers#16){.+.+}-{0:0}, at:
ksys_write+0xf9/0x1d0
[ 1551.643213]  #1: ffff888122889490 (&buffer->mutex){+.+.}-{4:4}, at:
configfs_write_iter+0x71/0x460
[ 1551.652192]  #2: ffff88823e73d080 (&p->frag_sem){++++}-{4:4}, at:
configfs_write_iter+0x1d9/0x460
[ 1551.661083]  #3: ffffffffc1c40eb0 (&lock){+.+.}-{4:4}, at:
nullb_device_submit_queues_store+0xab/0x170 [null_blk]
[ 1551.671361]  #4: ffff888171e6c228
(&set->update_nr_hwq_lock){++++}-{4:4}, at:
blk_mq_update_nr_hw_queues+0x27/0x60
[ 1551.681726]  #5: ffff888171e6c118
(&set->tag_list_lock){+.+.}-{4:4}, at:
blk_mq_update_nr_hw_queues+0x31/0x60
[ 1551.691649]  #6: ffff888227b5c7e8
(&q->q_usage_counter(io)#28){++++}-{0:0}, at:
__blk_mq_update_nr_hw_queues+0x758/0xd00
[ 1551.702534]  #7: ffff888227b5c828
(&q->q_usage_counter(queue)#19){+.+.}-{0:0}, at:
__blk_mq_update_nr_hw_queues+0x758/0xd00
[ 1551.713681]
               stack backtrace:
[ 1551.718040] CPU: 11 UID: 0 PID: 12517 Comm: check Kdump: loaded Not
tainted 6.19.0-rc8+ #1 PREEMPT(voluntary)
[ 1551.718046] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.21.1 09/24/2025
[ 1551.718050] Call Trace:
[ 1551.718053]  <TASK>
[ 1551.718057]  dump_stack_lvl+0x6f/0xb0
[ 1551.718065]  print_circular_bug.cold+0x38/0x45
[ 1551.718074]  check_noncircular+0x146/0x160
[ 1551.718090]  check_prev_add+0xf1/0xc80
[ 1551.718095]  ? alloc_chain_hlocks+0x8/0x1d0
[ 1551.718100]  ? srso_return_thunk+0x5/0x5f
[ 1551.718105]  ? add_chain_cache+0x11c/0x300
[ 1551.718114]  validate_chain+0x481/0x560
[ 1551.718126]  __lock_acquire+0x58c/0xbd0
[ 1551.718136]  lock_acquire.part.0+0xbd/0x260
[ 1551.718141]  ? pcpu_alloc_noprof+0x92f/0xf10
[ 1551.718150]  ? srso_return_thunk+0x5/0x5f
[ 1551.718154]  ? rcu_is_watching+0x15/0xb0
[ 1551.718160]  ? local_clock_noinstr+0xd/0xe0
[ 1551.718164]  ? srso_return_thunk+0x5/0x5f
[ 1551.718169]  ? lock_acquire+0x10b/0x140
[ 1551.718177]  __mutex_lock+0x1a7/0x1ba0
[ 1551.718182]  ? pcpu_alloc_noprof+0x92f/0xf10
[ 1551.718187]  ? _raw_spin_unlock_irqrestore+0x57/0x80
[ 1551.718192]  ? srso_return_thunk+0x5/0x5f
[ 1551.718197]  ? lockdep_hardirqs_on+0x78/0x100
[ 1551.718203]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[ 1551.718208]  ? srso_return_thunk+0x5/0x5f
[ 1551.718212]  ? pcpu_alloc_noprof+0x92f/0xf10
[ 1551.718222]  ? __pfx___mutex_lock+0x10/0x10
[ 1551.718227]  ? srso_return_thunk+0x5/0x5f
[ 1551.718231]  ? kasan_save_stack+0x3f/0x50
[ 1551.718236]  ? kasan_save_stack+0x30/0x50
[ 1551.718241]  ? kasan_save_track+0x14/0x30
[ 1551.718245]  ? __kasan_kmalloc+0x8f/0xa0
[ 1551.718250]  ? blk_mq_init_tags+0x6c/0x2c0
[ 1551.718256]  ? blk_mq_realloc_tag_set_tags+0x1e8/0x300
[ 1551.718260]  ? __blk_mq_update_nr_hw_queues+0x79f/0xd00
[ 1551.718267]  ? ksys_write+0xf9/0x1d0
[ 1551.718272]  ? do_syscall_64+0x95/0x520
[ 1551.718277]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1551.718290]  ? pcpu_alloc_noprof+0x92f/0xf10
[ 1551.718295]  pcpu_alloc_noprof+0x92f/0xf10
[ 1551.718313]  sbitmap_init_node+0x287/0x730
[ 1551.718326]  sbitmap_queue_init_node+0x2e/0x3e0
[ 1551.718332]  ? srso_return_thunk+0x5/0x5f
[ 1551.718340]  blk_mq_init_tags+0x15f/0x2c0
[ 1551.718349]  blk_mq_alloc_map_and_rqs+0xa6/0x310
[ 1551.718353]  ? blk_mq_realloc_tag_set_tags+0xd0/0x300
[ 1551.718362]  __blk_mq_alloc_map_and_rqs+0x104/0x1f0
[ 1551.718371]  blk_mq_realloc_tag_set_tags+0x1e8/0x300
[ 1551.718379]  __blk_mq_update_nr_hw_queues+0x79f/0xd00
[ 1551.718391]  ? __pfx___blk_mq_update_nr_hw_queues+0x10/0x10
[ 1551.718402]  ? blk_mq_alloc_sched_ctx_batch+0x1aa/0x270
[ 1551.718418]  blk_mq_update_nr_hw_queues+0x3b/0x60
[ 1551.718426]  nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
[ 1551.718444]  nullb_device_submit_queues_store+0xdb/0x170 [null_blk]
[ 1551.718458]  ? __pfx_nullb_device_submit_queues_store+0x10/0x10 [null_bl=
k]
[ 1551.718469]  ? srso_return_thunk+0x5/0x5f
[ 1551.718482]  configfs_write_iter+0x2ac/0x460
[ 1551.718491]  vfs_write+0x525/0xfd0
[ 1551.718502]  ? __pfx_vfs_write+0x10/0x10
[ 1551.718511]  ? __lock_acquire+0x58c/0xbd0
[ 1551.718522]  ? local_clock_noinstr+0xd/0xe0
[ 1551.718528]  ? srso_return_thunk+0x5/0x5f
[ 1551.718532]  ? __lock_release.isra.0+0x1a2/0x2c0
[ 1551.718541]  ksys_write+0xf9/0x1d0
[ 1551.718548]  ? __pfx_ksys_write+0x10/0x10
[ 1551.718562]  do_syscall_64+0x95/0x520
[ 1551.718569]  ? srso_return_thunk+0x5/0x5f
[ 1551.718574]  ? rcu_is_watching+0x15/0xb0
[ 1551.718579]  ? srso_return_thunk+0x5/0x5f
[ 1551.718585]  ? srso_return_thunk+0x5/0x5f
[ 1551.718589]  ? lockdep_hardirqs_on_prepare.part.0+0x8e/0x170
[ 1551.718595]  ? irqentry_exit+0x93/0x5f0
[ 1551.718603]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1551.718608] RIP: 0033:0x7f39150f1544
[ 1551.718613] Code: 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 40 00 f3 0f 1e fa 80 3d a5 cb 0d 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24
18 48
[ 1551.718617] RSP: 002b:00007ffcf40efb08 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[ 1551.718623] RAX: ffffffffffffffda RBX: 00007f39151c75c0 RCX: 00007f39150=
f1544
[ 1551.718627] RDX: 0000000000000003 RSI: 0000562d12a21940 RDI: 00000000000=
00001
[ 1551.718630] RBP: 0000000000000003 R08: 0000000000000073 R09: 00000000fff=
fffff
[ 1551.718633] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00003
[ 1551.718636] R13: 0000562d12a21940 R14: 0000000000000003 R15: 00007f39151=
c4f00
[ 1551.718655]  </TASK>

On Wed, Oct 15, 2025 at 8:51=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
>
>
> On 10/15/25 6:00 PM, Yi Zhang wrote:
> > Hi
> > I reproduced the issue below with blktests block/040 on the latest
> > linux-block/for-next, please help check it, and let me know if you
> > need any info/test for it. Thanks.
> >
> > dmesg:
> > [  283.273904] run blktests block/040 at 2025-10-15 08:23:18
> > [  283.607382] null_blk: disk nullb1 created
> >
> > [  284.828241] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  284.834421] WARNING: possible circular locking dependency detected
> > [  284.840599] 6.18.0-rc1+ #4 Not tainted
> > [  284.844360] ------------------------------------------------------
> > [  284.850539] check/1726 is trying to acquire lock:
> > [  284.855245] ffffffffb3d47210 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
> > pcpu_alloc_noprof+0x8a3/0xd90
> > [  284.863876]
> >                but task is already holding lock:
> > [  284.869710] ffff88821320ca68
> > (&q->q_usage_counter(io)#30){++++}-{0:0}, at:
> > __blk_mq_update_nr_hw_queues+0x76c/0xca0
> > [  284.880160]
> >                which lock already depends on the new lock.
> >
> > [  284.888332]
> >                the existing dependency chain (in reverse order) is:
> > [  284.895812]
> >                -> #2 (&q->q_usage_counter(io)#30){++++}-{0:0}:
> > [  284.902875]        __lock_acquire+0x57c/0xbd0
> > [  284.907243]        lock_acquire.part.0+0xbd/0x260
> > [  284.911950]        blk_alloc_queue+0x5ca/0x710
> > [  284.916402]        blk_mq_alloc_queue+0x14b/0x230
> > [  284.921109]        __blk_mq_alloc_disk+0x18/0xd0
> > [  284.925728]        null_add_dev+0x7b6/0x1410 [null_blk]
> > [  284.930973]        nullb_device_power_store+0x1e6/0x280 [null_blk]
> > [  284.937159]        configfs_write_iter+0x2ac/0x460
> > [  284.941959]        vfs_write+0x525/0xfd0
> > [  284.945888]        ksys_write+0xf9/0x1d0
> > [  284.949822]        do_syscall_64+0x94/0x760
> > [  284.954015]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  284.959588]
> >                -> #1 (fs_reclaim){+.+.}-{0:0}:
> > [  284.965266]        __lock_acquire+0x57c/0xbd0
> > [  284.969632]        lock_acquire.part.0+0xbd/0x260
> > [  284.974340]        fs_reclaim_acquire+0xc9/0x110
> > [  284.978965]        prepare_alloc_pages+0x159/0x5a0
> > [  284.983761]        __alloc_frozen_pages_noprof+0x151/0x3b0
> > [  284.989253]        __alloc_pages_noprof+0x10/0x1b0
> > [  284.994045]        pcpu_alloc_pages.isra.0+0xcf/0x3d0
> > [  284.999109]        pcpu_populate_chunk+0x35/0x70
> > [  285.003735]        pcpu_alloc_noprof+0x775/0xd90
> > [  285.008353]        iommu_dma_init_fq+0x197/0x750
> > [  285.012973]        iommu_dma_init_domain+0x553/0x990
> > [  285.017939]        iommu_setup_dma_ops+0xd2/0x1a0
> > [  285.022645]        bus_iommu_probe+0x1ee/0x4b0
> > [  285.027099]        iommu_device_register+0x186/0x270
> > [  285.032064]        iommu_init_pci+0xb8f/0xc20
> > [  285.036426]        amd_iommu_init_pci+0x80/0x4e0
> > [  285.041051]        state_next+0x297/0x5d0
> > [  285.045064]        iommu_go_to_state+0x2b/0x60
> > [  285.049512]        pci_iommu_init+0x3b/0x70
> > [  285.053707]        do_one_initcall+0xa7/0x260
> > [  285.058072]        do_initcalls+0x1b4/0x1f0
> > [  285.062259]        kernel_init_freeable+0x4ae/0x540
> > [  285.067139]        kernel_init+0x1c/0x150
> > [  285.071160]        ret_from_fork+0x393/0x480
> > [  285.075441]        ret_from_fork_asm+0x1a/0x30
> > [  285.079895]
> >                -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
> > [  285.086091]        check_prev_add+0xf1/0xcd0
> > [  285.090364]        validate_chain+0x487/0x570
> > [  285.094725]        __lock_acquire+0x57c/0xbd0
> > [  285.099092]        lock_acquire.part.0+0xbd/0x260
> > [  285.103797]        __mutex_lock+0x1a7/0x1ae0
> > [  285.108079]        pcpu_alloc_noprof+0x8a3/0xd90
> > [  285.112699]        sbitmap_init_node+0x287/0x730
> > [  285.117325]        sbitmap_queue_init_node+0x2e/0x3e0
> > [  285.122379]        blk_mq_init_tags+0x15f/0x2c0
> > [  285.126921]        blk_mq_alloc_map_and_rqs+0xa6/0x310
> > [  285.132067]        __blk_mq_alloc_map_and_rqs+0x104/0x1f0
> > [  285.137467]        blk_mq_realloc_tag_set_tags+0x1e8/0x300
> > [  285.142952]        __blk_mq_update_nr_hw_queues+0x7b4/0xca0
> > [  285.148526]        blk_mq_update_nr_hw_queues+0x3b/0x60
> > [  285.153759]        nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
> > [  285.160032]        nullb_device_submit_queues_store+0xdb/0x170 [null=
_blk]
> > [  285.166827]        configfs_write_iter+0x2ac/0x460
> > [  285.171621]        vfs_write+0x525/0xfd0
> > [  285.175555]        ksys_write+0xf9/0x1d0
> > [  285.179481]        do_syscall_64+0x94/0x760
> > [  285.183674]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  285.189250]
> >                other info that might help us debug this:
> >
> > [  285.197248] Chain exists of:
> >                  pcpu_alloc_mutex --> fs_reclaim --> &q->q_usage_counte=
r(io)#30
> >
> I think we need to break pcpu_alloc_mutex dependency on the ->freeze_lock=
.
> We already fixed one such dependency while allocating sched-tags earlier
> under this commit 04225d13aef1 ("block: fix potential deadlock while runn=
ing
> nr_hw_queue update"). But it seems we do have one more such dependency ex=
ists
> while allocating non-sched/driver tags. I'll prepare and submit the fix.
>
> Thanks,
> --Nilay
>


--=20
Best Regards,
  Yi Zhang

