Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2155CC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 19:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE8D2083B
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 19:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GMHS6abO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfBHTnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:43:50 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:51538 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHTnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 14:43:50 -0500
Received: by mail-it1-f181.google.com with SMTP id y184so5398555itc.1
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 11:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0pNN/atECk3oJAeCN3JzA1Vns5R0stl/sYoPKUzhYCk=;
        b=GMHS6abOaCR9//YUt4z4XFgjQBQ1YldOcyL1NwlN787wNmWWHGYY31oGDsR24Fr3vR
         fFypdZq1jr/jxPPVhdUA/GKuamGuQ3IYIyl4iWSL71R3XMkkKmJyJhfab3Ao2rb2FzTV
         4Bc9skV7Ozm8ZMTFxyIOTcq8+S5ZxrhijN2ot89MhiMMgtoQOSN4kidDavwydIJsQsW6
         AjUqrywpCxonWQhnydVW8oSpgoZQSbumG9+52c0qx1Mdvq8w6aEcYx6nk2OslFHwO6YY
         eEgRp/ejY0zIYYzPBcHr/R/m1yU4EZhNBci9iPrY4/cMfUmW/DKIh77gdVFILMHbjdPb
         cr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0pNN/atECk3oJAeCN3JzA1Vns5R0stl/sYoPKUzhYCk=;
        b=XsJQRdTzDVOV0mHULChpwSOBtgKo1ROh8TdxkiN9vIot9Mg0CaffD1WgQn+ETozux8
         EI68vIMb0l0/VajRGRsjG/Pr2sedrsi/EOTKDNPGMTOugj+cXPLUsxZuldd9XcfiE/58
         jHqQhR28fhYvO8Mb2ma4lRDaRpw34peVND2ip4+FpPyhi4fFRcvMv5zNh8nEwecz8pry
         RZdaKX67D5pn9oWakFQT3s3pwTtmw+ny8iT01kY2sQyPOvKEzGecv4ev8Axq24DN43S4
         +UVyoK6lnJqxv2lmjfpEI+MWU05nybvSvNunIA4VbID3PDwNUG7Pe6N42AerLB8pZRoN
         STzg==
X-Gm-Message-State: AHQUAubR3obMorzJVhbfzDOxp6AI0OHmKLCmli9A2qNXim/E+wEVZGBK
        jEkS4m6U5y+Iqr+TSzG78LV2hdgm7X0i2g==
X-Google-Smtp-Source: AHgI3IY0U5BKRbNfn5H1Emev4dnVQCnlxdqfUi4qpeoZEDFYatX5NYV6BACbDl8EBWYezbnHok1ZyQ==
X-Received: by 2002:a5d:928b:: with SMTP id s11mr14240559iom.111.1549655028895;
        Fri, 08 Feb 2019 11:43:48 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 125sm1635607itk.28.2019.02.08.11.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:43:48 -0800 (PST)
Subject: Re: [PATCH] block: avoid setting nr_requests to current value
To:     Aleksei Zakharov <zakharov.a.g@yandex.ru>
Cc:     linux-block@vger.kernel.org
References: <1549642445-1935-1-git-send-email-zakharov.a.g@yandex.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9531b406-7307-5642-7014-76b6e31a56df@kernel.dk>
Date:   Fri, 8 Feb 2019 12:43:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549642445-1935-1-git-send-email-zakharov.a.g@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 9:14 AM, Aleksei Zakharov wrote:
> There's no reason to freeze queue and set nr_requests value
> if current value is the same.

Applied for 5.1, thanks.

-- 
Jens Axboe

