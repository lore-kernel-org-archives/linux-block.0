Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8F8C433B4
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 20:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4368613DC
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 20:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhDTUiR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:38:17 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.142]:31755 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233660AbhDTUiQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 16:38:16 -0400
X-Greylist: delayed 724 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2021 16:38:16 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 7E20B30184
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 15:37:44 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Yx7wlmBzNPkftYx7wl01bB; Tue, 20 Apr 2021 15:37:44 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l6vahtvgtZ1p4am0RjK2z2rakl6hM2z1m9+8qYMYvp8=; b=eodyvHTbYl7syCTL6dvpNCWXBh
        8xCPKyo4MRPzNso1FkQWqVoxm8xWj2gs7jWPyY03oK4uaNBu6M7mbGap7HXQ43Lqn0T+CEb9SkKgt
        +ItgSiuhOfxiUqcLAN0GXx4N0045JSP0zwQvMZyvqDfwnbHviZWxpSkSHtO7UaZ8FuoByHIrk8FZB
        b4IK3ELYtx83hrK3ylza3Fi6Ut3zJcT8/5Ro2yZOLaRLck+SzWMPoh7fg5QeZQxmTWxos5uQ5TIqv
        B/+Xdciz7Q64O9d1bATS//5Evemnccx1s0utSqgReTMWV2kDGGgLRHBnwAxErGMCEURuFz6G4sJGp
        QzLGPd1g==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:49098 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYx7u-003RAy-32; Tue, 20 Apr 2021 15:37:42 -0500
Subject: Re: [PATCH 032/141] floppy: Fix fall-through warnings for Clang
To:     Jens Axboe <axboe@kernel.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <ede7ffddba64f621150f8f5c5f2b8f080b560903.1605896059.git.gustavoars@kernel.org>
 <2599e39d-faec-01fc-e835-16a5c96082d6@embeddedor.com>
 <47bcd36a-6524-348b-e802-0691d1b3c429@kernel.dk>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ba8c33c1-ccd9-0c99-c45c-1b1301f3e130@embeddedor.com>
Date:   Tue, 20 Apr 2021 15:37:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <47bcd36a-6524-348b-e802-0691d1b3c429@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lYx7u-003RAy-32
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:49098
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 232
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/20/21 15:30, Jens Axboe wrote:

>>>
>>> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
>>> index 7df79ae6b0a1..21a2a7becba0 100644
>>> --- a/drivers/block/floppy.c
>>> +++ b/drivers/block/floppy.c
>>> @@ -2124,6 +2124,7 @@ static void format_interrupt(void)
>>>  	switch (interpret_errors()) {
>>>  	case 1:
>>>  		cont->error();
>>> +		fallthrough;
>>>  	case 2:
>>>  		break;
>>>  	case 0:
> 
> I wonder about the consistency of the patches. The one I just applied
> for libata adds a break, this one annotates fallthrough. But the cases
> are really 100% the same. Why aren't the changes consistent? Both are
> obviously fine, but for identical cases it seems odd that they differ.
> 
> IMHO, adding a break makes more sense. Annotate the fallthrough if the
> two cases share work that needs to be done, as then that solution makes
> sense.
> 

Yeah; I'll resend this with a break, instead.

Thanks for the feedback.
--
Gustavo
