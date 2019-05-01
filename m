Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08A4C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734BB21734
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eZ1/3rM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfEAMnl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 08:43:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41390 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfEAMnk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 08:43:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9so8158423pls.8
        for <linux-block@vger.kernel.org>; Wed, 01 May 2019 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3pIW3eZxBARiAaq686usbPL+O7aOABXkZ5yz2Nasnws=;
        b=eZ1/3rM5EP+z9+y9t2LO8YpNUXdPX34lNTCK6lV61EfWBF1g9BTXEkcSZ0KoixMlQF
         2S/qu8sOtI38QvVbo3TOy69x86sjwPJQUbFIN9yl2V+/h9TjJ9mv2j5SjtCKAGwyS5+R
         MCKWzGppPvzeqHi7OqN1XYXNG8Ih3Tn1yeV5eks8DobriOwxywa5IUaL6/ONgnoW9bdh
         +ha++kxPx++gngvnRoOk4Pv65Mtzo+bzm8V2tY9Xerz/sl1nYR9opzNgOGRNkMEvevra
         gVjUwoSgPmOb1aQmQ7SF0UYanDOy4jA36XOUQ0/RyKpRC7TlFg/EBOPD6TyX3I673SK7
         vH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3pIW3eZxBARiAaq686usbPL+O7aOABXkZ5yz2Nasnws=;
        b=A01H6XjvXGd5fg7hkmqB2YteQAx1aqoAacgMWkGbXJpNari30qOj1D9RollhYH3n9g
         /L5vVxq2jSJhxGFCXnzWwSjYyZoS6I4gCiCuZy/s2QjA/HhI4PKQES4hEn/1dP91h/LV
         YHAV4lOkqk1lEzZsmqizO6CYR8cD9TSOPVv8wWEN7kvKbnATmpGK4a5JZ096xzCj9cnA
         uazMqBDLE7EXQrI4esj7nzi+CXKGwpSxUb6d5NxYyP4YsDQ3BnJvvE4WjPwUU3VOB3Iq
         67X5Tl0Akqz1zvOoRfk1w5ach8Qp+IauN3iiXQGsRgyDyzBUWhkDtNWNQV/dCd1Dwzzm
         mOEQ==
X-Gm-Message-State: APjAAAU2YwMOlCVQpK5J7mqdOV4kJX2SmM4bQcYuQpUwHDu4WFY5fRhZ
        OBMTgKV6niKQgKoI5pc7si1cLQHnv+Oxzg==
X-Google-Smtp-Source: APXvYqzVlpLWF25LVDPLkYX8DCpX33t07LYS7enpTFiXCCTOBEvDeChTStEXm5hfkqr8jZ4b+Qv+NA==
X-Received: by 2002:a17:902:84:: with SMTP id a4mr2682221pla.210.1556714620261;
        Wed, 01 May 2019 05:43:40 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z124sm43256106pfz.116.2019.05.01.05.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 05:43:39 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] [io_uring] don't stall on submission errors
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <fc1f2755-2c79-f5de-4057-ff658f3919ca@kernel.dk>
 <20190501114955.13103-1-source@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f8552598-0c4d-fc2f-2a91-94efd99e1638@kernel.dk>
Date:   Wed, 1 May 2019 06:43:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501114955.13103-1-source@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/1/19 5:49 AM, Stefan Bühler wrote:
> Stalling is buggy right now, because it might wait for too many events;
> for proper stalling we'd need to know how many submissions we ignored,
> and reduce min_complete by that amount.
> 
> Easier not to stall at all.
> 
> Also fix some local variable names.

I folded this in, but removed the renaming. Thanks!

-- 
Jens Axboe

