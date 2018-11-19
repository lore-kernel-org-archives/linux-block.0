Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3ACC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6357920851
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 16:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M0lqPoWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6357920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbeKTCb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:31:28 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38249 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbeKTCb1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 21:31:27 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so4915098ith.3
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nIgDwjTIpcF6TnFc+HosPWwmukdMMECQHTnK3BNS0pM=;
        b=M0lqPoWKD5aT9lMWZt4jzid5jCntHY3Fzg9jUrfuNI3qPwOFMYIWxI3a1RK9olHmj/
         bd0CJI1HZAzxdhIOwSLGGcn5V0NS9psgBhxyjO6BAPG+fIdgsxuqP9rO/JPOVcyRkn4H
         diWnuRHDcbuyZ80RGn3IMV4nhPjafI8nnAqUK+VcLSuxmjcD4UohdjBANE74LJe36n0u
         jXI1XS5avqrN0uLG8LjoAn0C+NYReiWqSmKLGuKy9HSJG7AsZVIVpEk/WZTRcNwNY+39
         ty5GULPFSWVTSnxPrcKGYnlw0QdP+gfL+U7qwEPQEmCp8PpRXHHFlnqffRLCkHsvngFd
         2kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIgDwjTIpcF6TnFc+HosPWwmukdMMECQHTnK3BNS0pM=;
        b=Yzn/Oint4iQZkTZ5M1EHIB2saeSnIdUtMf8F8AM1aCUd6sw5XLprYqCCEC5/E1Ykca
         36OcnTrP1BfziybvZKDmFdGc+tc5YisVFe6q732oTj7MeAYREHSIJ2PmZqNTy/ETn5vY
         AbgiG5VPXiwD010FCVebW3vSzsCEHOU7rfN8Gq74JmW5ebCkLNYNWJUUOKdFG8mrQbH+
         Satr+hJvKHEQXVwyXmOGSoljTn3AdrZxIt+zmL5wxhvJ8oTWSPG0mLxFxV+k/lxKWDFx
         Y0DcrpBFY2/ZRch+ZaQsNyczGge+KMzD4aBSdVRt4r4X357I0YNli7Mqfe34zHSF/f7t
         mo5A==
X-Gm-Message-State: AGRZ1gJg5e24T7hFJQvouCOZoCmp+933AKreQLnGjaETQsx+hDc4gmmH
        lOO6ppxoOIKt6esl1UaAq2ryxg==
X-Google-Smtp-Source: AFSGD/WvTxbtrkeanqqAVYXxiHJQc3E//Q3Q1yJAveReXyHK226HNNRFeH38h8l+6BKzBjkhTTE7PA==
X-Received: by 2002:a24:3842:: with SMTP id b63mr9938616ita.19.1542643645372;
        Mon, 19 Nov 2018 08:07:25 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d3sm5958097itc.40.2018.11.19.08.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 08:07:24 -0800 (PST)
Subject: Re: [PATCH 4/5] aio: support for IO polling
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20181117235317.7366-1-axboe@kernel.dk>
 <20181117235317.7366-5-axboe@kernel.dk> <20181119081119.GJ9622@infradead.org>
 <20181119133254.GA32705@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f6689a04-430c-cd79-cd4d-997e37d4ecb5@kernel.dk>
Date:   Mon, 19 Nov 2018 09:07:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119133254.GA32705@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/18 6:32 AM, Christoph Hellwig wrote:
> 
> I just saw the patch that avoids the irq disabling show up in your
> tree this morning.  I think we can do even better by using slightly
> lazy lists that are not updated from ->ki_complete context.

I totally agree, it's just a first step. One restriction you added
is that only one task can be on io_getevents at the time for an
io_context, I didn't want to go that far. One issue with that is
that we can find events that are for other io contexts, if you
saw my patch for the stack list, then that's in there too. So you have
to deal with the case where multiple tasks can be completing events for
the same io_context, regardless of whether you try to block that
behavior at io_getevents() entry time.

> Please take a look at the patch below - this replaces patch 3 from
> my previous mail, that is it is on top of what you send to the list
> plus my first two patches.

Thanks, I'll take a look. I'll split out fhe fops change, as that is
indeed how I wanted to get this done ultimately as well, since it's the
only way to support more complicated setups.

-- 
Jens Axboe

