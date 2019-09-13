Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54CDC49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 23:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707FF20692
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 23:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="G4RDVMp7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yw5/OTHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390604AbfIMXlN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:41:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54739 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390603AbfIMXlN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 19:41:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C7AB21BA9;
        Fri, 13 Sep 2019 19:41:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 13 Sep 2019 19:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:mime-version:content-type; s=
        fm2; bh=y5EBeYOKSkkZGcC8iqxhvnyhrtPlS249Ck9HCUkn4qw=; b=G4RDVMp7
        n/wWYYrbuOrAaAY57xg+X+yTEJTvo3HvhpuW6RvyVrcnT/PFJ3ushPMTPFKgnA8M
        cdYhetL9W/YDGplRcCYk98W6YCCWIKEO8foVIvGrHA4hcxDRUCiHL28ywEGUPi61
        qsg/lUQpS2oyLGt/lY6eiaroh/hvrajaiFwHZGmlJcMPxcH7zLkQMcFKvqrFIpvU
        HN2pS1EbMzFz9TMKOmH6LJ8ZRVvQ6rj4sU9PJP2x1smOWZ+GAgTw+EtTj+BwZ/K4
        D9qMeUkjMguB11LFzhIa859hlprPT9KCqBMmybCVglBJ3z+ixrnMb7Jzr0vX8D5o
        q6NcpyXSpDV16Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=y5EBeYOKSkkZGcC8iqxhvnyhrtPlS
        249Ck9HCUkn4qw=; b=Yw5/OTHEWs/dIWIOMQ/TzF1eTAB5nxoSu6t+bzOs1AVdf
        C8435jADHzJ+CmAZAGAzvYjU/2ggRvTxK6aAU45hHJkoivDPc9FVl5rm1+rPnBWP
        efBJb/3vWy4SK5cjAzAiyfhEabbZn7jSzf34F2ILZ/eaKo4BmwKu4CLyj/O1VuBQ
        +0ClZsPrmqMWujCgBeL+hkv57kM4xBeEKwISNFuo6spRQbuqPhMRPwJx8lHEM3co
        5nHH3rDbiF0/+jWTYsV4Quy309xMHJgsLUVSQHtPEcvOfY7pM12Hfg9aFo+1Gx4P
        GrF6NpY9khsiS4QV4kPzaMe5HzY2Loga+ce/8tflQ==
X-ME-Sender: <xms:GCl8XZZ34qJnv40q__Ogf071k-xTFJObbOodwNQ67aXGc1q98HGPDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdekgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesthdtredttddtvdenucfhrhhomheptehnughrvghsucfh
    rhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecukfhppedvudeird
    dukeelrddvuddurdduhedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshes
    rghnrghrrgiivghlrdguvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:GCl8XadT78plijyOP3K8HAfzuAcfjvjf4O3-f8oY2TX0f6sPueixUw>
    <xmx:GCl8Xe0AgK2lbjTnsFtgXb_J2Vaj57beiF9O2kuKj8TePW0xgLNnjQ>
    <xmx:GCl8Xfk9NgoXrDpxpTY-NqwUSad44d6CYlh3ynq4vJ4iZ3lVOvzzXw>
    <xmx:GCl8XUxFLEQxEbzYrnM0H-DZbndiIXd5r93gVe6iBi905Co-WmMevw>
Received: from intern.anarazel.de (unknown [216.189.211.150])
        by mail.messagingengine.com (Postfix) with ESMTPA id D8B55D60057;
        Fri, 13 Sep 2019 19:41:11 -0400 (EDT)
Date:   Fri, 13 Sep 2019 16:41:08 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: buffered io_uring vs task io accounting
Message-ID: <20190913234108.gdux4v5xqckohfru@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

It appears that task io accounting doesn't currently work when io_uring
defers work to workqueues.

E.g. while I get system wide "iostats -xm 1 /dev/sda" stats like:

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
sda              0.00 36475.00      0.00    250.52     0.00   660.00   0.00   1.78    0.00    0.14   0.00     0.00     7.03   0.03  99.70

"pidstat -d 1" as the user execution fio just shows

03:15:37 PM   UID       PID   kB_rd/s   kB_wr/s kB_ccwr/s iodelay  Command
03:15:38 PM     0     13626     -1.00     -1.00     -1.00      53  kworker/u16:2-io_ring-wq
03:15:38 PM     0     13734     -1.00     -1.00     -1.00      51  kworker/u16:3+io_ring-write-wq
03:15:38 PM     0     13735     -1.00     -1.00     -1.00      53  kworker/u16:4+io_ring-wq
03:15:38 PM     0     13736     -1.00     -1.00     -1.00      50  kworker/u16:5-io_ring-wq
03:15:38 PM     0     13766     -1.00     -1.00     -1.00      52  kworker/u16:7-io_ring-wq
03:15:38 PM     0     13767     -1.00     -1.00     -1.00      51  kworker/u16:8-io_ring-write-wq
03:15:38 PM     0     13769     -1.00     -1.00     -1.00      51  kworker/u16:10+io_ring-wq

and as root I get:

03:20:05 PM   UID       PID   kB_rd/s   kB_wr/s kB_ccwr/s iodelay  Command
03:20:06 PM     0     13735      0.00  34344.00      0.00      49  kworker/u16:4+io_ring-wq
03:20:06 PM     0     13736      0.00  36080.00      0.00      47  kworker/u16:5+io_ring-wq
03:20:06 PM     0     13737      0.00  36624.00      0.00      43  kworker/u16:6+io_ring-wq
03:20:06 PM     0     13766      0.00  30616.00      0.00      50  kworker/u16:7+io_ring-wq
03:20:06 PM     0     13768      0.00  38728.00      0.00      47  kworker/u16:9+io_ring-wq
03:20:06 PM     0     13769      0.00  37792.00      0.00      51  kworker/u16:10+io_ring-wq
03:20:06 PM     0     13890      0.00  39176.00      0.00      47  kworker/u16:13+io_ring-wq

and nothing is attributed to fio itself.  For DIO I do get working task
stats however.

That is not all that surprising because tasks deferred to the workqueue
won't properly be accounted for, because the page is dirtied from within
the workqueue, rather than the normal process context.


I suspect this doesn't just affect task io stats, but also means that
io_uring writes will be able to escape writeback throttling, because
presumably the workqueue kthreads are going to be throttled as
individual tasks, rather than using causing the issuing process to be
throttled.

I assume this is a problem that needs to be fixed?

Greetings,

Andres Freund
