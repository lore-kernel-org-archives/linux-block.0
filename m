Return-Path: <SRS0=mZfT=B2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08000C433DF
	for <linux-block@archiver.kernel.org>; Sun, 16 Aug 2020 23:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A5E2078A
	for <linux-block@archiver.kernel.org>; Sun, 16 Aug 2020 23:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t9jp2mfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgHPXkw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Aug 2020 19:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgHPXkw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Aug 2020 19:40:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38DFC061786;
        Sun, 16 Aug 2020 16:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=E093XKq91oPFn1xbWF3HTVXXCCZ141wxPnL00SPkX/g=; b=t9jp2mfC1gcp3mNP95khCZXBcb
        Xvh1aF1hgRTdwt6odUtkgV7qmJLduQjOOVJu/YInP6ZcsPzlvfC+m0NJOIk4wwCozJntsdJEWQfwl
        tjMC7S7reQSBIWdvpmMhVLlKu9OfW5Bp67tWfOX8nmZ24rICCtj5aabFRg5925apIbUjILZ2908X1
        NIZI0wWeJ9rdxctrWq9hfjFwFIZ91+uRzTpGEMjyA2IsDiX0ryGksOdZ3b11x5iC0aAyUdVo0WPDs
        csH7wv3EBWwrnFD9FrHz9leQXvbhusL7eKcS/F++PIJGm+sLOy50BkMeb9KTWlSHsTneVqqIR6i6f
        jLoXk/4Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7SBA-0001iN-G7; Sun, 16 Aug 2020 23:35:09 +0000
Subject: Re: [PATCH] block: blk-mq.c: fix @at_head kernel-doc warning
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20200816222519.313-1-rdunlap@infradead.org>
 <ce836be4-a430-eec3-9268-a9ad080122e7@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <edbe148b-d916-2325-790a-075f700a8115@infradead.org>
Date:   Sun, 16 Aug 2020 16:35:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ce836be4-a430-eec3-9268-a9ad080122e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/20 3:50 PM, André Almeida wrote:
> Hi Randy,
> 
> On 8/16/20 7:25 PM, Randy Dunlap wrote:
>> Fix a new kernel-doc warning in block/blk-mq.c:
>>
>> ../block/blk-mq.c:1844: warning: Function parameter or member 'at_head' not described in 'blk_mq_request_bypass_insert'
>>
>> Fixes: 105663f73e71 ("blk-mq: Document functions for sending request")
> 
> By the time commit 105663f73e71 ("blk-mq: Document functions for sending
> request") was merged, the parameter @at_head didn't exist[1].
> 
> The commit that inserted this warning is 01e99aeca397 ("blk-mq: insert
> passthrough request into hctx->dispatch directly"), that added @at_head
> without updating the documentation.
> 
> Thanks,
> 	André

Hi André,

Sorry, I'll correct that.

thanks.

> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/blk-mq.c?id=105663f73e71b5e79ecf472c0499c9acde654b28#n1673


-- 
~Randy

