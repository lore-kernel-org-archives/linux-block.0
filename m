Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F7CC433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 12:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbiCJMZo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 07:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiCJMZo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 07:25:44 -0500
X-Greylist: delayed 1894 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 04:24:42 PST
Received: from iris.vrvis.at (iris.vrvis.at [92.60.8.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0889D63F4;
        Thu, 10 Mar 2022 04:24:41 -0800 (PST)
Received: from [10.43.0.34]
        by iris.vrvis.at with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <valentin@vrvis.at>)
        id 1nSHqQ-0006AS-SW; Thu, 10 Mar 2022 13:24:39 +0100
Message-ID: <50ddedf1-5ac3-91c3-0b50-645ceb541071@vrvis.at>
Date:   Thu, 10 Mar 2022 13:24:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <c274db07-9c7d-d857-33ad-4a762819bcdd@vrvis.at>
 <YinpIKY0HVlJ+TLR@kroah.com>
From:   Valentin Kleibel <valentin@vrvis.at>
In-Reply-To: <YinpIKY0HVlJ+TLR@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] block: aoe: fix page fault in freedev()
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/03/2022 13:03, Greg Kroah-Hartman wrote:
>> This patch applies to kernels 5.4 and 5.10.
> 
> We need a fix for Linus's tree first before we can backport anything to
> older kernels.  Does this also work there?

It is fixed in Linus' tree starting with 5.14.
The patch reproduces the behavior of the current master introduced in 
commit 6560ec961a08 (aoe: use blk_mq_alloc_disk and blk_cleanup_disk).

>> Fixes: 3582dd2 (aoe: convert aoeblk to blk-mq)
> 
> A few more digits in the sha1 here would be good, otherwise our tools
> will complain.  It should look like:
> Fixes: 3582dd291788 ("aoe: convert aoeblk to blk-mq")

thanks for the hint, i will do so in the future.

cheers,
valentin
