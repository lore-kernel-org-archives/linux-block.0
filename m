Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BEBC678D5
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 03:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCHDu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 22:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCHDu1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 22:50:27 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E047E9B9BD;
        Tue,  7 Mar 2023 19:50:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VdNiHxB_1678247421;
Received: from 30.97.56.232(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VdNiHxB_1678247421)
          by smtp.aliyun-inc.com;
          Wed, 08 Mar 2023 11:50:22 +0800
Message-ID: <98cfc350-8664-a478-9c2b-d88bd2512a50@linux.alibaba.com>
Date:   Wed, 8 Mar 2023 11:50:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH V2 08/17] block: ublk_drv: don't consider flush request in
 map/unmap io
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>
References: <20230307141520.793891-1-ming.lei@redhat.com>
 <20230307141520.793891-9-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230307141520.793891-9-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/3/7 22:15, Ming Lei wrote:
> There isn't data in request of REQ_OP_FLUSH always, so don't consider
> it in both ublk_map_io() and ublk_unmap_io().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
