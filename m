Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6444C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 08:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiGVI5p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiGVI5p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 04:57:45 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD75A024D
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 01:57:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK4TinB_1658480260;
Received: from 30.97.56.196(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VK4TinB_1658480260)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 16:57:40 +0800
Message-ID: <975dea28-0bb7-52ca-b565-82d6c58c840f@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 16:57:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH V3 1/2] ublk_drv: fix error handling of ublk_add_dev
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220722084516.624457-1-ming.lei@redhat.com>
 <20220722084516.624457-2-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220722084516.624457-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/22 16:45, Ming Lei wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> __ublk_destroy_dev() is called for handling error in ublk_add_dev(),
> but either tagset isn't allocated or mutex isn't initialized.
> 
> So fix the issue by letting replacing ublk_add_dev with a
> ublk_add_tag_set function that is much more limited in scope and
> instead unwind every single step directly in ublk_ctrl_add_dev.
> To allow for this refactor the device freeing so that there is
> a helper for freeing the device number instead of coupling that
> with freeing the mutex and the memory.
> 
> Note that this now copies the dev_info to userspace before adding
> the character device.  This not only simplifies the erro handling
> in ublk_ctrl_add_dev, but also means that the character device
> can only be seen by userspace if the device addition succeeded.
> 
> Based on a patch from Ming Lei.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
