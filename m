Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83993C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 03:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiGVDEL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 23:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiGVDEH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 23:04:07 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30288D5F2
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 20:04:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VK3N5yh_1658459042;
Received: from 30.97.56.196(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VK3N5yh_1658459042)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 11:04:03 +0800
Message-ID: <fdb3d405-6f5b-01c8-58bb-5e2255475c8e@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 11:04:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] ublk_drv: make sure that correct flags(features)
 returned to userspace
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220722023638.601667-1-ming.lei@redhat.com>
 <20220722023638.601667-3-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220722023638.601667-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/22 10:36, Ming Lei wrote:
> Userspace may support more features or new added flags, but the driver
> side can be old, so make sure correct flags(features) returned to
> userpsace, then userspace can work as expected.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
