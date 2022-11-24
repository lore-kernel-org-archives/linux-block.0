Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0657C4332F
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 06:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKXGsy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Nov 2022 01:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiKXGsx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2022 01:48:53 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F0174AB9
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 22:48:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVZrgl-_1669272528;
Received: from 30.97.56.235(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VVZrgl-_1669272528)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 14:48:49 +0800
Message-ID: <94c774e8-85a0-8ef6-5ab8-cc8238491562@linux.alibaba.com>
Date:   Thu, 24 Nov 2022 14:48:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH V2 2/6] ublk_drv: don't probe partitions if the ubq daemon
 isn't trusted
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20221124030454.476152-1-ming.lei@redhat.com>
 <20221124030454.476152-3-ming.lei@redhat.com>
Content-Language: en-US
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221124030454.476152-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/11/24 11:04, Ming Lei wrote:
> If any ubq daemon is unprivileged, the ublk char device is allowed
> for unprivileged user actually, and we can't trust the current user,
> so not probe partitions.
> 
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
