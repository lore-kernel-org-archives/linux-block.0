Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58636C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 22:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C0A2082E
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 22:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tPINeHbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfDJWO4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:14:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41980 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfDJWO4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 18:14:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so2360468pgs.8
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 15:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wg+iQil3DoY9mwTW1mfserS3u376EbXt0yARzUcfgdw=;
        b=tPINeHbrEiszxSoR1taj3mpafE1NWS5DJ89QHSCklWKkcP2kLCHftDwO2UtHFSFNE4
         OtGTXUthULRDybFp+ku6X0sQa0d178t50ANTUtV8PUAbv0a8mq2tKkf8Eb5JogSCUgFL
         HxzBGHng2xubXdR5Q2aKKakGAxLdOC4FctnhEw22YjdyqiR5YFKgwgH/hMpcD5cz0l9i
         eGhEcvmMNo9yBN2IbT8X2yAGNu+Nn0XqbWoWTcLUsPPJ4lSoJq9y3bAEhVd7Wv4Q85jr
         UM9xiIqlv37vgizMVuaFAUHSXlDG/G3bFNvBKH7hB2cSDYwPpM2aSXO4YTFVLw4R0jIf
         fgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wg+iQil3DoY9mwTW1mfserS3u376EbXt0yARzUcfgdw=;
        b=aHZXrFWUcCHlVhB81An+bT5AUTQ9y6Jgrq12QRg1dnuVTZ1Rlnmq4L1uYWatJDFHg7
         mXoDUuLGT+MlshIQQWL5QPXFL4W9mvx80HnECLI4N8vIMAmvjnMyxPyWEjQ5Ikhy2Ncl
         SNpK9H49v6RghDQt+blFbN1kDCTcM5ADYCO3ar2q8/KCJx4SMXQaC0EM7qa6M1axbEA9
         RERPy0yyf2pw5Rn+pB9t2+dHw6h4xsvxtneQfJza3a9V/2/PGh9XPbOaXpZHUWrpmN89
         oLg5ovgoJX2jOyy55+vPi5SILzD1bxRifCePWgFav8VmFvNE6ASiEnqUwA684feRynfa
         mAdQ==
X-Gm-Message-State: APjAAAUrkYvEWgVGpyGES3eH7EKk2ELMnqrtLRwoi3e+fVZk5l5jRb1J
        gwFr6Hz19NNf0mU/SHay06y0Tg==
X-Google-Smtp-Source: APXvYqzFap2u/I0lMbg2XZ2uTIfmLdmxN65OJmpxt1g9axofjTKjnjVdwjG6mYSjWp9XuWAKXlOjPg==
X-Received: by 2002:a62:e80f:: with SMTP id c15mr45888215pfi.93.1554934495509;
        Wed, 10 Apr 2019 15:14:55 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c1sm52150997pfd.114.2019.04.10.15.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:14:54 -0700 (PDT)
Subject: Re: [PATCH] block: do not leak memory in bio_copy_user_iov()
To:     jglisse@redhat.com, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org
References: <20190410202751.20712-1-jglisse@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e25d90b2-62ff-18bc-efe2-ef37c56bfa52@kernel.dk>
Date:   Wed, 10 Apr 2019 16:14:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410202751.20712-1-jglisse@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/19 2:27 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> When bio_add_pc_page() fails in bio_copy_user_iov() we should free
> the page we just allocated otherwise we are leaking it.

Applied, thanks.

-- 
Jens Axboe

