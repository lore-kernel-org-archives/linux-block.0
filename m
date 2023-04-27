Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995CC77B7C
	for <linux-block@archiver.kernel.org>; Thu, 27 Apr 2023 11:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbjD0LAt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Apr 2023 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243640AbjD0LAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 07:00:48 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A41559E;
        Thu, 27 Apr 2023 04:00:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vh7Lbrs_1682593239;
Received: from 30.221.148.223(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0Vh7Lbrs_1682593239)
          by smtp.aliyun-inc.com;
          Thu, 27 Apr 2023 19:00:40 +0800
Message-ID: <cab2259e-c938-de21-495c-abb4b82a3455@linux.alibaba.com>
Date:   Thu, 27 Apr 2023 19:00:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: another nvme pssthrough design based on nvme hardware queue file
 abstraction
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <CGME20230426132010epcas5p4ad551f7bdebd6841e2004ba47ab468b3@epcas5p4.samsung.com>
 <24179a47-ab37-fa32-d177-1086668fbd3d@linux.alibaba.com>
 <20230426135937.GA27829@green245>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
In-Reply-To: <20230426135937.GA27829@green245>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi,

> On Wed, Apr 26, 2023 at 09:19:57PM +0800, Xiaoguang Wang wrote:
>
> Good to see this.
> So I have a prototype that tries to address some of the overheads you
> mentioned. This was briefly discussed here [1], as a precursor to LSFMM.
Cool, and I'll go through your discussions later, thanks.

Regards,
Xiaoguang Wang
>
> PoC is nearly in shape. I should be able to post in this week.
>
> [1] fourth point at
> https://lore.kernel.org/linux-nvme/20230210180033.321377-1-joshi.k@samsung.com/
>
>

