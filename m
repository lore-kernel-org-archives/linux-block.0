Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1CECA9ED3
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 16:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692A821655
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 16:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="uU7Krz5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfKDQtI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:49:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37504 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfKDQtG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 11:49:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id q130so16792841wme.2
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2GCXse3i8dZWY3iqcdbG+HD0y8Pc0P0D/i6paZcwU8A=;
        b=uU7Krz5FyeHVlvMbtIzCRn0+S2fQ4+7O8QJiCjuVTYJQPBx2WQGcY2NLBUeM9wn25R
         ROpekZAVJdynYiLoqnmy6yth/tVdTozzYI4O4kTuodyCLkwBH9rPqN91EyaJ8P2FjEB6
         vTrulmhp2Lv5osMWzTLwC8qhEylr5fJ4Q/07FsjB64uDW4p4XsD76qDv3gUYh0THoJu4
         lzIebTQu7vHAsZYYIOFukkOEqsGynlPelbBzIPg7q4kh9EW5trD2FL5HHV28FBzaLLyq
         puDlYKiOT9yIxGVaAhZ+MmOApLMavJgW7KoyQrdoqfE9LJtu3YuNqKaPug9LBt2XYaFj
         SBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2GCXse3i8dZWY3iqcdbG+HD0y8Pc0P0D/i6paZcwU8A=;
        b=FaaT5XvANfyGjIgbk+utGuD/vPo/c9C9/XSteG2mQ/pWVlzdnkT1Z/3vPKW7LpvAi2
         BLCtHIbWt3lcBIRh3LXI3l6IJcUE5OmxjsqxEJ1rq+3GdctTCcMize4ZAwsCkiSDRNNu
         5hfyCYano5I3COBTLdCKcartC15V/4tCmLw82lBJEEjgVQP7Enuvjw8DJ1o0BkfNWPEL
         P7v6zdtWsesT3tgLzI1aLh3s/NDTCmrBQInve1P4OUDyjjGRGabX+Gg28jMuBbi9tfxl
         Kf5uCEUtPBPvOKkcwr+36C1yoOvmL3HNlSsj72zvM0RgN9wV3DUVeY5hBL45LeSkk/OI
         PB+g==
X-Gm-Message-State: APjAAAXXJP+tsYBGMrHWZJpjl5bvlppPGBBnLXoUftoiK36Tw5XEDVFb
        HNzw8/6SJkaYVFJuMRQhce7zRKWH6Y1R1A==
X-Google-Smtp-Source: APXvYqzS3PC9EJyw/esjee1y5JXKX5z6exdfXWx7Y3WpW46Yp/B/ETCxm60YFm9UwlSt0+elBZDFaA==
X-Received: by 2002:a1c:60d7:: with SMTP id u206mr15589wmb.101.1572886143360;
        Mon, 04 Nov 2019 08:49:03 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id x205sm23003638wmb.5.2019.11.04.08.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 08:49:02 -0800 (PST)
Date:   Mon, 4 Nov 2019 16:49:00 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair G Kergon <agk@redhat.com>,
        elsk@google.com, dvander@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: dm-snapshot for system updates in Android
Message-ID: <20191104164900.GA10934@google.com>
References: <20191025101624.GA61225@google.com>
 <alpine.LRH.2.02.1910290957220.25731@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1910290957220.25731@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Mikulas,

Thank you for your answer and suggestions.

On Tue, Oct 29, 2019 at 10:21:14AM -0400, Mikulas Patocka wrote:
> Hi
> 
> On Fri, 25 Oct 2019, Alessio Balsini wrote:
> 
> > Hello everyone!
> > 
> > I hope you will appreciate knowing that we are currently evaluating the use of
> > dm-snapshot to implement a mechanism to obtain revertible, space-efficient
> > system upgrades in Android.  More specifically, we are using
> > dm-snapshot-persistent to test the updated device after reboot, then issue a
> > merge in case of success, otherwise, destroy the snapshot.
> > This new update mechanism is still under evaluation, but its development is
> > openly done in AOSP.
> > 
> > At the current stage, we have a prototype we are happy with, both in terms of
> > space consumption overhead (for the COW device) and benchmarking results for
> > read-write and merge operations.
> > 
> > I would be glad if you could provide some feedback on a few points that I don't
> > have completely clear.
> > 
> > 
> > -- Interface stability
> > 
> > To obtain an initial, empty COW device as quick as possible, we force to 0 only
> > its first 32 bit (magic field). This solution looks clear from the kernel code,
> > but can we rely on that for all the kernels with SNAPSHOT_DISK_VERSION == 1?
> 
> It will work, but, to be consistent with lvm, I suggest to overwrite the 
> first 4k with zeroes.
> 
> > Would you appreciate it if a similar statement is added as part of
> > /Documentation, making this solution more stable? Or maybe I can think of
> > adding an initialization flag to the dm-snapshot table to explicitly request
> > the COW initialization within the kernel?
> > 
> > Another issue we are facing is to be able to know in advance what the minimum
> > COW device size would be for a given update to be able to allocate the right
> 
> This is hard to say, it depends on what the user is doing with the phone. 
> When dm-snapshot runs out of space, it invalidates the whole snapshot. 
> You'll have to monitor the snapshot space very carefully and take action 
> before it fills up.

I forgot to mention that all the partitions we are updating are
read-only, and can only be modified by snapshot-merge. This allows us to
establish a direct relation between the required COW device size and the
operations performed by the update (i.e. the number of chunks that are
going to be modified).

> 
> I suggest - run main system on the origin target and attach a snapshot 
> that will be used for backup of the data overwritten in the origin. If the 
> updated system fails, merge the snapshot back into the origin; if the 
> update succeeds, drop the snapshot. If the user writes too much data to 
> the device, it would invalidate the only the snapshot (so he can't revert 
> anymore), but it would not invalidate the origin and the data would not be 
> lost.

This is an approach we evaluated, but the main reason why we decided for
the solution of updating the snapshot and then merging it to the base
device is that we want to be sure that the update was successful before
permanently change to the base device. For example, if for some reason
the update is interrupted, it would be more difficult to roll-back or
restore the update. Additionally, if the update wants to resize the
partitions, this operation could not be done until reboot.

> 
> > size for the COW device in advance.  To do so, we rely on the current COW
> > structure that seems to have kept the same stable shape in the last decade, and
> > compute the total COW size by knowing the number of modified chunks. The
> > formula would be something like that:
> > 
> >   table_line_bytes      = 64 * 2 / 8;
> >   exceptions_per_chunk  = chunk_size_bytes / table_line_bytes;
> >   total_cow_size_chunks = 1 + 1 + modified_chunks
> >                         + modified_chunks / exceptions_per_chunk;
> > 
> > This formula seems to be valid for all the recent kernels we checked. Again,
> > can we assume it to be valid for all the kernels for which
> > SNAPSHOT_DISK_VERSION == 1?
> 
> Yes, we don't plan to change it.
> 
> > -- Alignment
> > 
> > Our approach follows the solution proposed by Mikulas [1].
> > Being the block alignment of file extents automatically managed by the
> > filesystem, using FIEMAP should have no alignment-related performance issue.
> > But in our implementation we hit a misalignment [2] branch which leads to
> > dmwarning messages [3, 4].
> > 
> > I have a limited experience with the block layer and dm, so I'm still
> > struggling in finding the root cause for this, either in user space or kernel
> > space.
> 
> I don't know. What is the block size of the filesystem? Are all mappings 
> aligned to this block size?

Here follows a just generated warning coming from a Pixel 4 kernel (4.14):

[ 3093.443808] device-mapper: table: 253:16: adding target device dm-15
caused an alignment inconsistency: physical_block_size=4096,
logical_block_size=4096, alignment_offset=61440, start=0

Does this contain all the info you asked for?

I started investigating this issue, but since we didn't notice any
performance degradation, I prioritized other things. I'll be hopefully
able to get back to this warning in the next months.
Please let me know if I can help you with that or if you need additional
information.

> 
> > But our benchmarks seems to be good, so we were thinking as last option to
> > rate-limit or directly remove that warning from our kernels as a temporary
> > solution, but we prefer to avoid diverging from mainline. Rate-limiting is a
> > solution that would make sense also to be proposed in the list, but completely
> > removing the warning doesn't seem the right thing to do. Maybe we are
> > benchmarking something else? What do you think?
> > 
> > Many thanks for taking the time to read this, feedbacks would be highly
> > appreciated.
> > 
> > Regards.
> > Alessio
> > 
> > [1] https://www.redhat.com/archives/dm-devel/2018-October/msg00363.html
> > [2] https://elixir.bootlin.com/linux/v5.3/source/block/blk-settings.c#L540
> > [3] https://elixir.bootlin.com/linux/v5.3/source/drivers/md/dm-table.c#L484
> > [4] https://elixir.bootlin.com/linux/v5.3/source/drivers/md/dm-table.c#L1558
> 
> Mikulas
> 

Thanks again,
Alessio

