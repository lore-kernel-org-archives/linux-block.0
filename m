Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ADAC61DA3
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 02:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjBVCCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Feb 2023 21:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjBVCCt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 21:02:49 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9773B32E7F
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 18:02:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VcEEK8V_1677031361;
Received: from 30.221.147.154(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VcEEK8V_1677031361)
          by smtp.aliyun-inc.com;
          Wed, 22 Feb 2023 10:02:42 +0800
Message-ID: <027eb20f-b750-a286-2213-92b78092e7fe@linux.alibaba.com>
Date:   Wed, 22 Feb 2023 10:02:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] ublk: remove check IO_URING_F_SQE128 in ublk_ch_uring_cmd
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230220041413.1524335-1-ming.lei@redhat.com>
Content-Language: en-US
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230220041413.1524335-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/2/20 12:14, Ming Lei wrote:
> sizeof(struct ublksrv_io_cmd) is 16bytes, which can be held in 64byte SQE,
> so not necessary to check IO_URING_F_SQE128.
> 
> With this change, we get chance to save half SQ ring memory.
> 
> Fixed: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>

Regards,
Zhang
 
