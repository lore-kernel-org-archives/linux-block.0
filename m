Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D46C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 07:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiGUHTK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiGUHTK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 03:19:10 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8FC7B7AD
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 00:19:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK-R-og_1658387943;
Received: from 30.97.56.180(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VK-R-og_1658387943)
          by smtp.aliyun-inc.com;
          Thu, 21 Jul 2022 15:19:04 +0800
Message-ID: <f4094148-1585-ee06-a4db-fd787a73f6c8@linux.alibaba.com>
Date:   Thu, 21 Jul 2022 15:19:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 5/8] ublk: cleanup ublk_ctrl_uring_cmd
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20220721051632.1676890-1-hch@lst.de>
 <20220721051632.1676890-6-hch@lst.de>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220721051632.1676890-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/21 13:16, Christoph Hellwig wrote:
> Move all per-command work into the per-command ublk_ctrl_* helpers
> instead of being split over those, ublk_ctrl_cmd_validate, and the main
> ublk_ctrl_uring_cmd handler.  To facilitate that, the old
> ublk_ctrl_stop_dev function that just contained two function calls is
> folded into both callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
