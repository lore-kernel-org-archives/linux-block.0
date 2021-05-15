Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4E6C43461
	for <linux-block@archiver.kernel.org>; Sat, 15 May 2021 00:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E389F613D7
	for <linux-block@archiver.kernel.org>; Sat, 15 May 2021 00:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhEOAEa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 20:04:30 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.18]:41817 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234466AbhEOAEa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 20:04:30 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 556C3D53F5
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 19:03:16 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hhm0lWCDVnrr4hhm0lV60I; Fri, 14 May 2021 19:03:16 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pk6PtlPuiMH4r2ZGSvo7HvjoXb9nyKtTfLHMjVbKyiA=; b=BRPzuh+yiH9mKDyBKk68+dEfbx
        LZGJ/LRnixG6qCWOmspXWpb7lUem66nqvsdKbH9Juo0I08XxtCKRn8eORvzvKeSiPj2EpAWT+I/qX
        5Cf1uJJ6ljAtSSDW+nb65eFHmuL5y5u/6oscwUOGC7mBkkXrjJmAhPLQM5u/ilVjwQ6oZksLmhaog
        ievY82Y2eYgv5sdDTLpo1E2uqA6kbZEDOxqXKtsvaKecr19fgvww9e7qdBkrEM6Wb5pPIXptTwMrI
        LArpdYQc8sMDoHHjh0R/Zdahdv1a1V0bY8sd24b2S4fMdUPfb/7X+ELl5Lkx0l4aVELJWPZ99htoR
        Iyab3IEw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:55108 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lhhlx-0037bL-Uk; Fri, 14 May 2021 19:03:13 -0500
Subject: Re: [PATCH][next] rsxx: Use struct_size() in vmalloc()
To:     Jens Axboe <axboe@kernel.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210513203730.GA212128@embeddedor>
 <fb567b7b-5ea4-fe8b-52cc-f148ff6a61b7@kernel.dk>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <86254a3d-b9a2-d0b9-d20c-f9c86666bc1b@embeddedor.com>
Date:   Fri, 14 May 2021 19:03:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fb567b7b-5ea4-fe8b-52cc-f148ff6a61b7@kernel.dk>
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
X-Exim-ID: 1lhhlx-0037bL-Uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:55108
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/14/21 10:00, Jens Axboe wrote:

> 
> Applied, thanks.
> 

Thanks, Jens.

--
Gustavo
