Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6553AC4332F
	for <linux-block@archiver.kernel.org>; Fri, 25 Nov 2022 07:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKYH2C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Nov 2022 02:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKYH2B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Nov 2022 02:28:01 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDC72251F
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 23:28:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVeNk2z_1669361277;
Received: from 30.97.56.205(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VVeNk2z_1669361277)
          by smtp.aliyun-inc.com;
          Fri, 25 Nov 2022 15:27:58 +0800
Message-ID: <ef29976b-cca9-44ac-d54e-a9168e335c92@linux.alibaba.com>
Date:   Fri, 25 Nov 2022 15:27:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH V2 5/6] ublk_drv: add module parameter of ublks_max for
 limiting max allowed ublk dev
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20221124030454.476152-1-ming.lei@redhat.com>
 <20221124030454.476152-6-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221124030454.476152-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/11/24 11:04, Ming Lei wrote:
> Prepare for supporting unprivileged ublk device by limiting max number
> ublk devices added. Otherwise too many ublk devices could be added by
> un-trusted user, which can be thought as one DoS.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
