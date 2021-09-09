Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D1CC433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 04:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E7F61090
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 04:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhIIEI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 00:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhIIEIZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 00:08:25 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0F6C061575
        for <linux-block@vger.kernel.org>; Wed,  8 Sep 2021 21:07:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1631160435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wo9UEsRIayeSrouu7jDNAqNpavMOIBmAOXW7MpQG1Qc=;
        b=X1QkGEnZY16UCC+D+0DR8GlL5y+M33D1FQs1uEjmG0v0eQC4BiTsoTBJ7QmcCwWZUxOmqH
        MZXCp508zeLcZKwoHnaQuhr6f9ZfmP1PubGUr2S8ueQ5V1FkkvSj3eSxkHMxilPud+kk5e
        IAaXEWHEv3EI/l+wdhmrjjKbxH1UIqI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: bfq - suspected memory leaks
To:     Jens Axboe <axboe@kernel.dk>, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org
Message-ID: <72691728-304b-a80b-5850-92879fffc61a@linux.dev>
Date:   Thu, 9 Sep 2021 12:07:10 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

With latest kernel (commit 4ac6d90867a4 "Merge tag 'docs-5.15' of 
git://git.lwn.net/linux"),
I got lots of kmemleak reports during compile kernel source code.

# dmesg |grep kmemleak
[18234.655491] kmemleak: 1 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[18890.247552] kmemleak: 2 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[19745.602271] kmemleak: 2 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[20390.965851] kmemleak: 4 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[21150.173950] kmemleak: 4 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[21929.951448] kmemleak: 15 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[23589.726859] kmemleak: 2 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[24416.441263] kmemleak: 1 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[30400.835853] kmemleak: 10 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[68673.737862] kmemleak: 2 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[72770.498898] kmemleak: 1 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[77046.434369] kmemleak: 7 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)

All of them  have similar trace as follows.

   comm "sh", pid 27054, jiffies 4302241171 (age 47562.964s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 00 b0 20 02 80 88 ff ff  .......... .....
     04 00 02 00 04 00 02 00 00 00 00 00 00 00 00 00 ................
   backtrace:
     [<000000004fa2550b>] bfq_get_queue+0x2a8/0xfd0
     [<00000000b1757a70>] bfq_get_bfqq_handle_split+0xa4/0x240
     [<00000000ac263274>] bfq_init_rq+0x1f7/0x1d10
     [<00000000110283e1>] bfq_insert_requests+0xf7/0x5f0
     [<000000002ed06e79>] blk_mq_sched_insert_requests+0xfe/0x350
     [<000000000ebf38ac>] blk_mq_flush_plug_list+0x256/0x3e0
     [<00000000bc647b2b>] blk_flush_plug_list+0x1ff/0x240
     [<000000004e7e49f8>] blk_finish_plug+0x3c/0x60
     [<000000008802f1e4>] read_pages+0x28f/0x580
     [<000000009986d1f4>] page_cache_ra_unbounded+0x266/0x3a0
     [<00000000492c494f>] filemap_fault+0x8a8/0xfe0
     [<000000009cbd8d38>] __do_fault+0x70/0x150
     [<000000002740a35f>] do_fault+0x112/0x670
     [<00000000a74facab>] __handle_mm_fault+0x57e/0xcc0
     [<0000000024009667>] handle_mm_fault+0xd6/0x330
     [<00000000fb1e0780>] do_user_addr_fault+0x2a9/0x8b0
unreferenced object 0xffff888021e5dd90 (size 560):

Thanks,
Guoqing
