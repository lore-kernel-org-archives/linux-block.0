Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA47C433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 11:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FF564F45
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 11:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbhBDLrM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 06:47:12 -0500
Received: from so15.mailgun.net ([198.61.254.15]:52487 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235477AbhBDLrL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 06:47:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612439206; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=Odha96na2nVoCzNN3drN6XcA6usmBDol8IV5BXH8O2g=; b=sMVR//qiscNIsLOwMu0xFNrKI5SPUgy7oBmkPV/g99QmyoTv6jaBw0KqBGfBgJ7FsMz5D3o/
 /mMdgKD8OTZ1bwDvOfdfyAnHg2PLfSQHHOmtvN9uH/P4XfxhmWEIZ1Waby3QkEiKm9TjgIOf
 5ymTmlR8k/J1ifi+L3UNfTgbaCc=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 601bde894bd23a05ae31a844 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Feb 2021 11:46:17
 GMT
Sender: pragalla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25CF4C43461; Thu,  4 Feb 2021 11:46:17 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pragalla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E2D5C433C6;
        Thu,  4 Feb 2021 11:46:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Feb 2021 17:16:16 +0530
From:   pragalla@codeaurora.org
To:     axboe@kernel.dk, bvanassche@acm.org, evgreen@google.com,
        jianchao.w.wang@oracle.com
Cc:     linux-block@vger.kernel.org, stummala@codeaurora.org
Subject: use-after-free access in bt_iter()
Message-ID: <f98dd950466b0408d8589de053b02e05@codeaurora.org>
X-Sender: pragalla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, Bart,

This is with regards to use-after-free access in bt_iter().
i saw this got discussed and reported on many separate threads but could 
see
more discussions and conversations over the solution was made on [1]
as pointed in [2].

[1] 
https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/
[2] https://lkml.org/lkml/2019/2/14/942

A similar issue was reported again on 5.4 kernel during internal 
stability testing.

<2> Unable to handle kernel paging request at virtual address 
ffffff8107929600
<2> Mem abort info:
<2>   ESR = 0x96000007
<2>   EC = 0x25: DABT (current EL), IL = 32 bits
<2>   SET = 0, FnV = 0
<2>   EA = 0, S1PTW = 0
<2> Data abort info:
<2>   ISV = 0, ISS = 0x00000007
<2>   CM = 0, WnR = 0
<2> swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000a2603000
<2> [ffffff8107929600] pgd=00000001bf909003, pud=00000001bf909003, 
pmd=00000001bf8cc003, pte=0068000187929f12
<2> Internal error: Oops: 96000007 [#1] PREEMPT SMP
<2> Skip md ftrace buffer dump for: 0x1609e0

<2> CPU: 0 PID: 220 Comm: kworker/0:1H Tainted: G S      W  O      
5.4.61-qgki-debug-g85faaf6 #2
<2> Workqueue: kblockd blk_mq_timeout_work
<2> pstate: 20c00005 (nzCv daif +PAN +UAO)
<2> pc : bt_for_each+0x114/0x1a4
<2> lr : bt_for_each+0xe0/0x1a4
<2> sp : ffffffc017f7bc60
<2> x29: ffffffc017f7bc80 x28: 0000000000000001
<2> x27: 0000000000000008 x26: 0000000000000001
<2> x25: 0000000000000001 x24: 0000000000000008
<2> x23: ffffff8107bcd800 x22: ffffff810872bd10
<2> x21: ffffffd764e6ea50 x20: 0000000000000008
<2> x19: 0000000000000000 x18: ffffffc017f51030
<2> x17: 0000000005f5e100 x16: 0000000000000000
<2> x15: ffffffffff84bf5c x14: 0000000000000598
<2> x13: 0000000000000008 x12: 00000000212d4a53
<2> x11: 00000000000000ff x10: 0000000000000000
<2> x9 : ffffff810872cd00 x8 : 0000000000000009
<2> x7 : 0000000000000000 x6 : ffffffd763890758
<2> x5 : 0000000000000000 x4 : 0000000000000000
<2> x3 : ffffffc017f7bd20 x2 : 0000000000000001
<2> x1 : ffffff8107929600 x0 : 0000000000000001
<2> Call trace:
<2>  bt_for_each+0x114/0x1a4
<2>  blk_mq_queue_tag_busy_iter+0xd8/0x1a4
<2>  blk_mq_timeout_work+0xd4/0x1c0
<2>  process_one_work+0x280/0x460
<2>  worker_thread+0x27c/0x4dc
<2>  kthread+0x160/0x170
<2>  ret_from_fork+0x10/0x18

Is this issue got fixed on any latest kernel ? if so, can you please 
help point the patch ?
If not got fixed, can we have a final solution ? i can even help in 
testing the solution.

Thanks and Regards,
Pradeep
