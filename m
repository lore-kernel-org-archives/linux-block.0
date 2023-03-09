Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5EAC6FD1F
	for <linux-block@archiver.kernel.org>; Thu,  9 Mar 2023 03:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCIDQH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 22:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCIDQH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 22:16:07 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E768F70C;
        Wed,  8 Mar 2023 19:16:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VdRargt_1678331761;
Received: from 30.97.56.238(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VdRargt_1678331761)
          by smtp.aliyun-inc.com;
          Thu, 09 Mar 2023 11:16:02 +0800
Message-ID: <ceea7e28-f623-c5eb-8711-273e0b2599b2@linux.alibaba.com>
Date:   Thu, 9 Mar 2023 11:16:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH V2 11/17] block: ublk_drv: cleanup 'struct ublk_map_data'
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>
References: <20230307141520.793891-1-ming.lei@redhat.com>
 <20230307141520.793891-12-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230307141520.793891-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/3/7 22:15, Ming Lei wrote:
> 'struct ublk_map_data' is passed to ublk_copy_user_pages()
> for copying data between userspace buffer and request pages.
> 
> Here what matters is userspace buffer address/len and 'struct request',
> so replace ->io field with user buffer address, and rename max_bytes
> as len.
> 
> Meantime remove 'ubq' field from ublk_map_data, since it isn't used
> any more.
> 
> Then code becomes more readable.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
