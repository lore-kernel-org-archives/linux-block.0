Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2F0C0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 13:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3668721881
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 13:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TKePpm9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfGCNaU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:30:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39449 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 09:30:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so775675pgi.6
        for <linux-block@vger.kernel.org>; Wed, 03 Jul 2019 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BOQopJXAuMMFDz8dSKMSnNTjWIrXd0JdRzELF1wRPL8=;
        b=TKePpm9/SXWG7U1N8gE7jlTOK57kHLJpzd0Sa5SktfZTrB/bnh2hwjAeVBJTLzD+qC
         turSAazWyF4+NEwAbyuLTA1mveHeDVOroqu9zFAQArrMdkkLXctgWB/XSgxVKBK9smx+
         PJFJcvnH5Fo9+ruSQ+RIEf5XwzlNymIiW1Ceub4EMnFl0HThp8fUehHF28NclxUTE7kf
         Pc9EqCLMxuqnOM1/EqdmF9x/MImNudK+dfU3XOVZivM9MwDTPfN5voGLekGSKtHInRrz
         uyfO7YtmlB2+ysxT0F9uQPkISYk7E6TzbBVEfvdHvfJt3J2UK3+2pnDGojTeTDv+xgrY
         EIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BOQopJXAuMMFDz8dSKMSnNTjWIrXd0JdRzELF1wRPL8=;
        b=h6vD75qFdlfBQSPdepzALHs8RRj06D2pZ/ATa8xaXeN7vTYM7t1elfQDqJuFKxZ3Na
         8ikEfcvIXdU15v0iYpPBPTqpUDEZNwUQb8NqUkEcgJAOFI1825hLwa6DPsEy/9pUf4Gj
         bdD4WQuurxUmy/s1r5Z2NhOgvZYPzqsYWwkqrTFkyjDp55nz924KDkiaa7EV3a0SDFGU
         BQrIOK9eOcnB6evrBXIhA+6PxVap26SlOOrekF0i0cUR9QQtGfKV4t9ChjofK7UFPU7i
         un/VnsZ3RW95+03rrBQzyObSiSJZNDIXKYgjGcxV4wvpseZqjguAGjcWB+2OY9zfMhH+
         QPlw==
X-Gm-Message-State: APjAAAX6w7NsvH1gyvbePHpd5KbqBlSu9BuUWFeNkxG3ykB8Pi2pzpar
        1zgvNrO097apEs3X9HECjAIG+ztJ794sVA==
X-Google-Smtp-Source: APXvYqwlL3eaGz6UnYspgRKQJbqvN8Bm+n8oVphvBP2ql6OkmvXTyFpQMPxpAQMf4lgXKZl7/t6AMA==
X-Received: by 2002:a17:90a:d14b:: with SMTP id t11mr12840929pjw.79.1562160619247;
        Wed, 03 Jul 2019 06:30:19 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id g62sm2211781pje.11.2019.07.03.06.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:30:18 -0700 (PDT)
Subject: Re: [PATCH] block: nr_phys_segments needs to be zero for
 REQ_OP_WRITE_ZEROES
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20190703122435.18255-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f23ef30d-d764-c921-9e7f-89bf11e66c4f@kernel.dk>
Date:   Wed, 3 Jul 2019 07:30:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703122435.18255-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/3/19 6:24 AM, Christoph Hellwig wrote:
> Fix a regression introduced when removing bi_phys_segments for Write Zeroes
> requests, which need to have a segment count of zero, as they don't have a
> payload.

Fixes it for me, thanks. Applied.

-- 
Jens Axboe

