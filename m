Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7CDC38A30
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 00:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5F2206E9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 00:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQPGxAaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDUAoA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgDUAoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 20:44:00 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA4C061A0E
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 17:43:59 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k28so9654812lfe.10
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 17:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZRwrK1UjiJpxDYSszjRPtqs1cjLjLji6Aam7rS81wo=;
        b=FQPGxAaF17vSSjjng+SYnVVTyYVA5s2NG2nnA/4N5kDp/WGCIrb9f25On61fC0A+Mz
         ArASZ/MOC2sFxS+nTQb0i3heZ8Ll8zNSL8IdvP2+Mna+8oUk343fzXUGUxuQLgoMW1Z4
         O1jPs/t5whKhm7gTkJBQZestxtL3Dmcfy7EBMApLi0iSO0KWfQQuLCxKrEFiTYNN/OWU
         h0Ilp90Q6OjyQ3npdWPqddwv5b8E9qdaHGsEOkd8UvwVHnCIO9+AnxuUgJmr+wM8tDXz
         7krNt+EMRR4FeeU9CTQQ/Ufy7Dc5u+ind2EDMZ2YSGF7sRuDCng69DxqD8wNP25ug6Nz
         Ql8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZRwrK1UjiJpxDYSszjRPtqs1cjLjLji6Aam7rS81wo=;
        b=XFO48p8H631MpSdzlF29Is42e43yZLteiqwQB3slX3Gh2gm49gi2Cza6nM8VjdKdSK
         IggXMckTtq+V3NJYpAYcVVvuBwE7rHzabFoPPvqTXQ+bZ+/DjP2COgxvgeZLRSemJYZ/
         N3zyfOes/8gQsPblPtaLOybdWvYgftmKaAxJjbs85SyAgotULpjTDRFihb6XTn4I64vU
         SfVddfc1qxxmHbCN56AYdL3eP78dgqaBwiDDfOZHS8PxrHu3MM+e5YveNNJxm7jBKPVo
         aQQmzt+Ga2zKN/QHuQvlZ0kGmy+noc87zVB4fKvlzbAQPL4RqA5XvK4nm+YOxSg5W6it
         3XHw==
X-Gm-Message-State: AGi0PuZM4yZDabkyPLDlNq9NeOaDsJrgwbsF9iE2hbdU28x2dtSZzEBq
        wLy0Emrqj+sEfAF0FmvujdcbeTSheDTtTeHigTllPw==
X-Google-Smtp-Source: APiQypJA0kncl3JUukHJh3Fz03w09zxZUG/GX3THwphT5IE6WJ7yzeQ6IMtZBOX7BEGJ02BB50U5guI79IbFaZqJp2g=
X-Received: by 2002:a05:6512:318a:: with SMTP id i10mr12195933lfe.96.1587429838243;
 Mon, 20 Apr 2020 17:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200420223936.6773-1-schatzberg.dan@gmail.com> <20200420223936.6773-3-schatzberg.dan@gmail.com>
In-Reply-To: <20200420223936.6773-3-schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 20 Apr 2020 17:43:47 -0700
Message-ID: <CALvZod4GizLVogLoGObxqXveeFX+vBm2SEpHNYA+Yz+Op7o0Qg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: support nesting memalloc_use_memcg()
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 20, 2020 at 3:41 PM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> The memalloc_use_memcg() function to override the default memcg
> accounting context currently doesn't nest. But the patches to make the
> loop driver cgroup-aware will end up nesting:
>
> [   98.137605]  alloc_page_buffers+0x210/0x288
> [   98.141799]  __getblk_gfp+0x1d4/0x400
> [   98.145475]  ext4_read_block_bitmap_nowait+0x148/0xbc8
> [   98.150628]  ext4_mb_init_cache+0x25c/0x9b0
> [   98.154821]  ext4_mb_init_group+0x270/0x390
> [   98.159014]  ext4_mb_good_group+0x264/0x270
> [   98.163208]  ext4_mb_regular_allocator+0x480/0x798
> [   98.168011]  ext4_mb_new_blocks+0x958/0x10f8
> [   98.172294]  ext4_ext_map_blocks+0xec8/0x1618
> [   98.176660]  ext4_map_blocks+0x1b8/0x8a0
> [   98.180592]  ext4_writepages+0x830/0xf10
> [   98.184523]  do_writepages+0xb4/0x198
> [   98.188195]  __filemap_fdatawrite_range+0x170/0x1c8
> [   98.193086]  filemap_write_and_wait_range+0x40/0xb0
> [   98.197974]  ext4_punch_hole+0x4a4/0x660
> [   98.201907]  ext4_fallocate+0x294/0x1190
> [   98.205839]  loop_process_work+0x690/0x1100
> [   98.210032]  loop_workfn+0x2c/0x110
> [   98.213529]  process_one_work+0x3e0/0x648
> [   98.217546]  worker_thread+0x70/0x670
> [   98.221217]  kthread+0x1b8/0x1c0
> [   98.224452]  ret_from_fork+0x10/0x18
>
> where loop_process_work() sets the memcg override to the memcg that
> submitted the IO request, and alloc_page_buffers() sets the override
> to the memcg that instantiated the cache page, which may differ.
>
> Make memalloc_use_memcg() return the old memcg and convert existing
> users to a stacking model. Delete the unused memalloc_unuse_memcg().
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

This patch was from Johannes, so I would suggest to keep his
authorship and signoff along with your signoff.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
