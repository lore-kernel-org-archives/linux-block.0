Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1056C7EE33
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 02:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCCCQA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 21:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCCP7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 21:15:59 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65DB39BBD;
        Thu,  2 Mar 2023 18:15:57 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vcz9Fdt_1677809754;
Received: from 30.97.56.172(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0Vcz9Fdt_1677809754)
          by smtp.aliyun-inc.com;
          Fri, 03 Mar 2023 10:15:55 +0800
Message-ID: <0a585f38-b115-4c4b-ac1e-14322774a177@linux.alibaba.com>
Date:   Fri, 3 Mar 2023 10:15:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 11/12] block: ublk_drv: add common exit handling
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        io-uring@vger.kernel.org,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20230301140611.163055-1-ming.lei@redhat.com>
 <20230301140611.163055-12-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230301140611.163055-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/3/1 22:06, Ming Lei wrote:
> Simplify exit handling a bit, and prepare for supporting fused command.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
