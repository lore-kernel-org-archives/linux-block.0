Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD328C43334
	for <linux-block@archiver.kernel.org>; Sat, 23 Jul 2022 10:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiGWKRV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jul 2022 06:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbiGWKRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jul 2022 06:17:10 -0400
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBB2DA5C8
        for <linux-block@vger.kernel.org>; Sat, 23 Jul 2022 03:07:02 -0700 (PDT)
X-QQ-mid: bizesmtp85t1658570658th2mgs73
Received: from eureka.localdomain ( [123.124.208.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 18:04:07 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000B00A0000020
X-QQ-FEAT: ILHsT53NKPj0HRDuEtI5CbFD7rnuEHAyGC+20aqF8DJXqYDMQ5BN+2SdvaKK5
        zCGT1gSzYgjkwhGLcKrh3muLGgmAKIE0BdZ8BLlySm7EAJ4bnrGbaZHVQoHMHLSzcANBti3
        +B7UiNHj+XVbpxfxe9rm7UvYiMgBdpEdvIk8E0TH/ZIWFH/0qd4O+HNmV1hBLREisoz5Gl+
        nT38oQvOWPKfZe/DcCrHNfSNcCHRirRTd+7YOf75SsT0vc1nQ/vXLS1JAsPvr04dNLEp51p
        4h9+uDR0AAaT1DLeNOcOzMty/hsgfyQ4eXiep6N8UQPnwexDrXHN5gUzCjFBdHIB/um3Cyw
        hC39LlHsUDwA/t4P5GI44+8yyAzAyCThZOA3t8SbsMwyGDWZ5NLpDyodWBK0A==
X-QQ-GoodBg: 2
From:   Wang You <wangyoua@uniontech.com>
To:     bvanassche@acm.org
Cc:     axboe@kernel.dk, fio@vger.kernel.org, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        wangxiaohua@uniontech.com, wangyoua@uniontech.com
Subject: Re: [PATCH v2 1/2] block: Introduce nr_sched_batch sys interface
Date:   Sat, 23 Jul 2022 18:04:06 +0800
Message-Id: <20220723100406.437387-1-wangyoua@uniontech.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <da0fe451-c036-cd18-7eb2-55c51c104ab5@acm.org>
References: <da0fe451-c036-cd18-7eb2-55c51c104ab5@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Do we need this new parameter? How does the performance of reducing 
> nr_requests compare to configuring nr_sched_batch?

It seems I can't get convincing data in the current test conditions, sorry, 
please ignore it unless I can produce valid evidence.

I will reconsider the effect of this modification on a single disk, 
from recent testing it seems that the link to the raid controller has 
a lot of impact.

Thanks,

Wang.


