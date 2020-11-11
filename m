Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AEFC55ABD
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1912074B
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 16:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="amXksHve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKKQUO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 11:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgKKQUN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 11:20:13 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316C4C0613D4
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 08:20:12 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so2847245ioo.7
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 08:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fOD1nMMF6xKjZcnCwmaEBCbtNKt+hxsuSOTEQV+SmIk=;
        b=amXksHverqoYdwke+9U3grbcsYKP4hIoezX7XTE+yI0QL76PJpiWZ+/BjrhOT0OCcR
         hMByiuxw2YIeoSo1c+hYvTJG59f980brkCQD37VLcEKT+Ol68/ng5pOXXvMZ1zXpwWu5
         lmU4d+3qjeRYoBXlTlvPoXnGGy9Gw0htJ/zv3A3ZlEPGlVnCYO17WtZqT++uMEohqEXW
         QLctHDoOAcoBWh6HAFpC255iG5PAqJUI+Yu7maQ5rxkHgXMgwGyw3JizPv0aWB5wWN4b
         x/FRNAFD6a8W71sLULwNWxOJyGZzAwdh00mZ484WZnmQlWREC3shuoAPcWmTg1LDiQP1
         P/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fOD1nMMF6xKjZcnCwmaEBCbtNKt+hxsuSOTEQV+SmIk=;
        b=Q1wQVquwd8d3VZ0LE2bNWCa3MPbAauZaJtB/VOIWWAax+0IUGTszMTQbQtq1fwABYo
         /P3/cTpFQenu7BHLSTb+ixj2KVJtodPSGcy3vPn5Z4Y1pECgVD8457mDDdBS4FGarOwU
         eQHAEgMm8swGko9MPn1HoxLrs+pGhOZ5+6DI8cFMkdM4OQ1xStVM8fBIOOArKeTdMBO2
         32lVtI3Ioent/ESBWSlSFR6OY5byVd2auc0qftqi9cn5TEU43tm42QIm8XHCXv8K5vz2
         +ftJIUB/P84aH9D8iiwb1QEN7W5oR4aDGf8x7mlnSpfIYYPeYewAhquLDMt0B4GNWzUh
         ev6g==
X-Gm-Message-State: AOAM533SIy3/e3/1xprRBrqfx6YO4Ox7EWj5IpsC+Rf5guxoxXdxOTAR
        bzJrKWVLCjAwj6jeUqSJhHDTSCkECd3iog==
X-Google-Smtp-Source: ABdhPJxTPobXuEImgKsoBtCjVpMmtDPsI8xNzPbLiDP1NZpNJXnD7n/7Ffd3N3YwPlTvyDuh085sig==
X-Received: by 2002:a02:c817:: with SMTP id p23mr20600958jao.138.1605111611562;
        Wed, 11 Nov 2020 08:20:11 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n1sm1399525ile.86.2020.11.11.08.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 08:20:11 -0800 (PST)
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201012183550.GA12341@imap.linux.ibm.com>
 <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
 <b5038d44-aa46-bbde-7a9f-0de46fed516a@linux.ibm.com>
 <17e1142c-4108-6f74-971a-dee007162786@kernel.dk>
 <ad3caaf7-ed8e-9f21-c3a6-c385139feb7b@linux.ibm.com>
 <6468cfad-e14c-060d-a525-00d75fe66819@kernel.dk>
 <30740ed3-21b9-71cd-b48c-1d6947c6f029@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <be2933c0-4827-ab38-872f-01cb02e44fc4@kernel.dk>
Date:   Wed, 11 Nov 2020 09:20:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <30740ed3-21b9-71cd-b48c-1d6947c6f029@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/10/20 8:50 AM, Stefan Haberland wrote:
> Am 14.10.20 um 03:19 schrieb Jens Axboe:
>>
>>> So, instead could you please apply the patches for 5.11 as soon as it is
>>> suitable?
>> I will - I have it queued up, won't create anything public until we
>> get past the merge window.
>>
> 
> Sorry to bother you again with this.
> Is there any outlook when you are going to push the patches to your
> for-next branch?
> 
> Or shall I resend the patches?

I already did apply it, just don't push out next release branches
that early. Pushed out now, so it is in.

-- 
Jens Axboe

