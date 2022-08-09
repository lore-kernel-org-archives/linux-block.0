Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C1AC19F2D
	for <linux-block@archiver.kernel.org>; Tue,  9 Aug 2022 10:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbiHIKKg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Aug 2022 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbiHIKKd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Aug 2022 06:10:33 -0400
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32C81F619;
        Tue,  9 Aug 2022 03:10:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VLpQdlv_1660039827;
Received: from 30.178.80.175(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VLpQdlv_1660039827)
          by smtp.aliyun-inc.com;
          Tue, 09 Aug 2022 18:10:28 +0800
Message-ID: <90938e46-a865-064c-493f-cf1016161156@linux.alibaba.com>
Date:   Tue, 9 Aug 2022 18:10:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH] blk-mq: avoid potential infinite loop in
 __blk_mq_alloc_request
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1658467343-55843-1-git-send-email-liusong@linux.alibaba.com>
 <Yto2sHfyiJITgYAn@infradead.org>
 <eb99b420-3e28-98c7-dacc-767d564661e2@linux.alibaba.com>
 <YtrLYiJFlqL64voT@infradead.org>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <YtrLYiJFlqL64voT@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Fri, Jul 22, 2022 at 04:15:49PM +0800, Liu Song wrote:
>> It is a reasonable approach to prevent abnormal alloc from going down,
>> but this is a very rare exception after all, and above modification is
>> checked
>> every alloc request, which seems to be a bit excessive overhead.
> Every allocation of a passthrough requests.  Which isn't really the
> normal fast path.

Hi,

It is true that there is no possibility of triggering an infinite loop 
in the current code,

but the necessary guard code should also exist without adding extra 
overhead.


Thanks

