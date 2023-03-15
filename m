Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D97C7618B
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 07:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjCOHGJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Mar 2023 03:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCOHGC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 03:06:02 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBA06A2FF;
        Wed, 15 Mar 2023 00:05:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vdv8ykU_1678863929;
Received: from 30.97.56.196(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0Vdv8ykU_1678863929)
          by smtp.aliyun-inc.com;
          Wed, 15 Mar 2023 15:05:29 +0800
Message-ID: <056d1725-b204-e922-a9f5-3f5b49e2cc9b@linux.alibaba.com>
Date:   Wed, 15 Mar 2023 15:05:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V2 12/17] block: ublk_drv: cleanup ublk_copy_user_pages
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>
References: <20230307141520.793891-1-ming.lei@redhat.com>
 <20230307141520.793891-13-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230307141520.793891-13-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/3/7 22:15, Ming Lei wrote:
> Clean up ublk_copy_user_pages() by using iov iter, and code
> gets simplified a lot and becomes much more readable than before.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
