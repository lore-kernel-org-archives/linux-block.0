Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA44C433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 19:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C3420C09
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 19:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PoYjnYeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbgFSTrt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389005AbgFSTrt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 15:47:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070FCC06174E;
        Fri, 19 Jun 2020 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=SC1wNgoq67qHHn/xTU7CmL82fHBZ9cfNf2rA2nn1B+Q=; b=PoYjnYebg4s9hk8wFqcmkRDZ6n
        aXFObGvBlgZXDhKPKcGgTd4fwftb7LXQskFi27OYS08CIYy/GnncokgCJNSOA8AUIeD9j2FOe3vE3
        +i49h9ZTU1wi2BGAn7zKQdM1XSoeRStDA4G3WepfQgLh/6Jk5EvLXUdHZBPDAB3Ffpq0nMPnz3nNY
        8AfVCzt1GJgdu6HchR0KugMRz72imx+zpGgpxYgGXgh0OaRA4A7M1h63oVr6gvAj5EARtb4WXzym5
        CAdies/e+NOvKlWQ7QQk/ujr+SWRSCL5w3HgkE4f+DfUyrepsBt+4obneWJZQWoJY4BcrC2z/wEL6
        N/d6A1rw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmMzM-0005YI-HM; Fri, 19 Jun 2020 19:47:48 +0000
Subject: Re: [PATCH v2] docs: block: Create blk-mq documentation
To:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, krisman@collabora.com
References: <20200605175536.19681-1-andrealmeid@collabora.com>
 <20200619134503.60ab689b@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cdab3be8-0d39-5085-34b5-7bf11cc7fb60@infradead.org>
Date:   Fri, 19 Jun 2020 12:47:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619134503.60ab689b@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/20 12:45 PM, Jonathan Corbet wrote:
> On Fri,  5 Jun 2020 14:55:36 -0300
> André Almeida <andrealmeid@collabora.com> wrote:
> 
>> Create a documentation providing a background and explanation around the
>> operation of the Multi-Queue Block IO Queueing Mechanism (blk-mq).
>>
>> The reference for writing this documentation was the source code and
>> "Linux Block IO: Introducing Multi-queue SSD Access on Multi-core
>> Systems", by Axboe et al.
>>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>> ---
>> Changes from v1:
>> - Fixed typos
>> - Reworked blk_mq_hw_ctx
> 
> Jens, what's your pleasure on this one?  Should I take it, or do you want
> it...?

I wouldn't mind seeing a v3.

-- 
~Randy

