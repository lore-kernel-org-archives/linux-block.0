Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7E2C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 07:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiGVHfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiGVHfY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 03:35:24 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8344C1834C
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 00:35:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK4GFC7_1658475313;
Received: from 30.97.56.196(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VK4GFC7_1658475313)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 15:35:14 +0800
Message-ID: <0e564701-a5fd-e31f-17fd-8d6a96f736ec@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 15:35:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V2 1/2] ublk_drv: fix error handling of ublk_add_dev
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20220722050930.611232-1-ming.lei@redhat.com>
 <20220722050930.611232-2-ming.lei@redhat.com>
 <Yto6FyKmdCvx0Iym@infradead.org> <YtpA70BmGMDrdnsU@infradead.org>
Content-Language: en-US
In-Reply-To: <YtpA70BmGMDrdnsU@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/22 14:17, Christoph Hellwig wrote:
> On Thu, Jul 21, 2022 at 10:48:07PM -0700, Christoph Hellwig wrote:
>> I think __ublk_destroy_dev just needs to go away in that form.
>> Also I'd much rather do the copy_to_user before the ublk_add_chdev
>> as that means we never remove a devic already marked life due to a
>> failure.  Something like the patch below, which will need testing first
>> before I'd dare to submit it:
> 
> Improved and tested version:
> 
> ---
> From 49ba6d0c5788ea9d3a6ef88d910b702152f5d75a Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 22 Jul 2022 07:38:59 +0200
> Subject: ublk_drv: fix error handling of ublk_add_dev
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
> ---
Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
