Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DD4C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 15:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C487A2089F
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 15:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sgioImtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfAGPoD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:44:03 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52399 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfAGPn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 10:43:59 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so1730255itg.2
        for <linux-block@vger.kernel.org>; Mon, 07 Jan 2019 07:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=P08c4p8m2yQXXUd8zce6G+IwRET3mWVF9SN+ew2zf14=;
        b=sgioImtKCj9JUys8/YTXTLvUERigtgM7frZrDBGPDsWXoQC9O90goFSiz9nXmPO6Ka
         XP24/L1+7bKUy/osXzgPJZsCWeRDwPkg5J/fiwi30BdR+NHD2btp9Z+5bhf+4IxQIhBA
         ftVz2B+pTZUSzairO6etOlk1ZPMDr10ZUQ8FSnoa6hHvwcpl7+T9qWPe94NbvXnzRYUS
         hKPgb7zrX7BUXn4KSlDfNbaZ3nk0WCVa/CSrx+37gs6hnT7bUHX+R7420VivFTw6w/Gp
         h1uE071N9NmA+yQmHGpyOuOMzYL45d+A7Ch57rZhUG4jctqvYzYX8GYA1kdN3xH4pjG3
         QttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P08c4p8m2yQXXUd8zce6G+IwRET3mWVF9SN+ew2zf14=;
        b=cRtavIHWSRafNiYa0bqZmNQMiAKHrzCr7Wnzy09MuJl3beSSisKkNJookLtwrFauB6
         5Cm7QGT+hT89SlOf6DusQqgl2K5mczLe8nvlEpVqE8j8UKNsqQ66k8VnKlfnhVY0D5EX
         BOBXViR+/farbylAA82sQI1WUaGw0ObPjKClFTE+g33WMINL034dJ8530EWeNE6XGK62
         tne9b7eEdjH809dRduNs1l1H9u9bJkhThQM0T4k+4aEkYkZiRFMZJXOWF4Gj1BR8Ysxx
         OyoLbgpz5kRY6/AqezComExJcVmfYyCw7wIwg8u662OsDHTTRsle0CRST1tmcGMcxKzX
         N6ww==
X-Gm-Message-State: AA+aEWabTPv9jAquS0n/d5NCRdAjJ0M4FzKIlNq1y3ZL9l/fowE1jOhE
        D0ySBVEjCudklQz0qMeND2x2tWHX8pEO8A==
X-Google-Smtp-Source: AFSGD/WDvxKz0xGT8s0W+QL8R2bjYjUOBm0oKogerKvM4jrXOq4QKyKymIgDtKL5qoDoQMEDuwr1Ew==
X-Received: by 2002:a02:98bb:: with SMTP id q56mr41092570jaj.24.1546875838124;
        Mon, 07 Jan 2019 07:43:58 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r63sm4292998ita.2.2019.01.07.07.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 07:43:57 -0800 (PST)
Subject: Re: [PATCH] block: don't show io_timeout if driver has no timeout
 handler
To:     bvanassche@acm.org, hch@infradead.org, linux-block@vger.kernel.org
References: <20190107125215.GA5039@192.168.3.9>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bdd9b6f8-4358-5d2e-d744-b2a89d6d4c5a@kernel.dk>
Date:   Mon, 7 Jan 2019 08:43:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107125215.GA5039@192.168.3.9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/7/19 5:52 AM, Weiping Zhang wrote:
> If the low level driver has no timerout handler, the
> /sys/block/<disk>/queue/io_timeout will not be displayed.

The alternative would be to make it return an error when read/written
instead of having this separate group code.

-- 
Jens Axboe

