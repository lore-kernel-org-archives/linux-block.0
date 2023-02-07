Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9EEC636CD
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 07:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjBGHL1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 02:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjBGHLW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 02:11:22 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF76F22DDE;
        Mon,  6 Feb 2023 23:11:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vb69SoH_1675753875;
Received: from 30.97.56.244(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0Vb69SoH_1675753875)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 15:11:16 +0800
Message-ID: <af6b8dbb-a93b-e215-2f43-04067c03b61d@linux.alibaba.com>
Date:   Tue, 7 Feb 2023 15:11:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 0/3] cleanup for ublk
Content-Language: en-US
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20230207070033.367423-1-ZiyangZhang@linux.alibaba.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230207070033.367423-1-ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/2/7 15:00, Ziyang Zhang wrote:
> Hi, this series contain cleanup for code and comment of ublk including
> removing unnecessary NULL check, unused variable and comment fix.
> 
> Ziyang Zhang (3):
>   ublk: remove unnecessary NULL check in ublk_rq_has_data()
>   ublk: mention WRITE_ZEROES in comment of ublk_complete_rq()
>   ublk: pass NULL to blk_mq_alloc_disk() as queuedata
> 
>  drivers/block/ublk_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Sorry, this patchset is wrong, please see the resent one.

Ziyang Zhang
