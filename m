Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18B0C4332F
	for <linux-block@archiver.kernel.org>; Sat, 24 Dec 2022 05:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiLXFZK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Dec 2022 00:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiLXFZJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Dec 2022 00:25:09 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB4FE0BE
        for <linux-block@vger.kernel.org>; Fri, 23 Dec 2022 21:25:08 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id a16so5139735qtw.10
        for <linux-block@vger.kernel.org>; Fri, 23 Dec 2022 21:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BvE2awRwFzFbxJ18OKrhIqmcucLQ6AvTFfNUPm7G5WM=;
        b=k6yGb/e8VmV5KYVZsTahb9RS1DKkPk395PBpTV6Q0c0DCTyRc82+Q8HoH8NgoHMKlu
         k0OJAqWW+dtvDsPiUy+FHoe2+HNwiRoRulbbb/udOX5BbqyGakPkGPqYwtw//+x8CJNH
         LgqkLvXGhZp7vBGd/aGwXhmFxSo/qDjCyUXHaVuYpgTeIrv1fjIQiX83kC67SV+3rW/n
         Prew+NQNkcr42MsV06oBUb6os+U5uPv4Ocej1jDMD9c3BVENdFVTXiv3gsleYn8W+Tlm
         fkaLLbvNvYxPcDoryiGUIf4ka6vhmNl57zxitj1ZSgqZX6C55cy+MeUN99MLsdp/X6Ew
         iPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvE2awRwFzFbxJ18OKrhIqmcucLQ6AvTFfNUPm7G5WM=;
        b=01VbGHs02F4C+nYnuBaNbfa+84RQL6m4HDKLmC0j0LifjTJTznMZAtT8Lez9UvF5IO
         z1OhLXa9iQgEtMZf/jziwZ5zYYbXMzKsuU2aWYt3Wp0aazAEpJ84ud7N9bynNlpG6yLJ
         AWzpANXrzEgKs+/WpvH0c2bM2KHgA1VlqezzAsZP7f9t8jsCzs8UNZvBSbSWUtUKCykO
         c+BrHGNr9SWgZvjeVW7lx5J2LryUO0A1KIVcFENiulxb2MbExGooimTtBCWlCHsEeK1N
         1577pZgcWehGrVmoe6GcgWemSYxkf6evNkhZQ6GFvWcs+gzEJygxfysj+bs7wWwM2GG2
         1/Xw==
X-Gm-Message-State: AFqh2kqwaoTlUQL8I8zdVNWTK0pTU4erKEIFMsH3ldTPK12eWEYT5K7d
        9jssfbgzKlToJrUbSntyz3bIYQ==
X-Google-Smtp-Source: AMrXdXvarlLSAFP/bDWauq4ZnQA3IIy1ziyTyivTcJn+nGyKDos6haGrFxuYk8OoGGeRKpx00w3VuA==
X-Received: by 2002:ac8:649:0:b0:3a6:93d7:873f with SMTP id e9-20020ac80649000000b003a693d7873fmr14076523qth.49.1671859507050;
        Fri, 23 Dec 2022 21:25:07 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v2-20020a05620a440200b006fed2788751sm3654004qkp.76.2022.12.23.21.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 21:25:06 -0800 (PST)
Date:   Fri, 23 Dec 2022 21:24:56 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: 6.2 nvme-pci: something wrong
Message-ID: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

There's something wrong with the nvme-pci heading for 6.2-rc1:
no problem booting here on this Lenovo ThinkPad X1 Carbon 5th,
but under load...

nvme nvme0: I/O 0 (I/O Cmd) QID 2 timeout, aborting
nvme nvme0: I/O 1 (I/O Cmd) QID 2 timeout, aborting
nvme nvme0: I/O 2 (I/O Cmd) QID 2 timeout, aborting
nvme nvme0: I/O 3 (I/O Cmd) QID 2 timeout, aborting
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: I/O 0 QID 2 timeout, reset controller

...and more, until I just have to poweroff and reboot.

Bisection points to your
0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
And that does revert cleanly, giving a kernel which shows no problem.

I've spent a while comparing old nvme_pci_alloc_tag_set() and new
nvme_alloc_io_tag_set(), I do not know my way around there at all
and may be talking nonsense, but it did look as if there might now
be a difference in the queue_depth, sqsize, q_depth conversions.

I'm running load successfully with the patch below, but I strongly
suspect that the right patch will be somewhere else: over to you!

Hugh

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4926,7 +4926,7 @@ int nvme_alloc_io_tag_set(struct nvme_ct
 
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
-	set->queue_depth = ctrl->sqsize + 1;
+	set->queue_depth = ctrl->sqsize;
 	/*
 	 * Some Apple controllers requires tags to be unique across admin and
 	 * the (only) I/O queue, so reserve the first 32 tags of the I/O queue.
