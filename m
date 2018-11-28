Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C1FC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 18:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3023520832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 18:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X07vnaNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3023520832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbeK2Fwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:52:55 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37023 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeK2Fwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 00:52:55 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so5884546iti.2
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 10:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nk6Ijf5n2PbgVEl5figkzJQ6nQw3WlR2m4+z1tnOPMs=;
        b=X07vnaNHypyuvEB1jnuQq7A79+gVVObQLJhOjyIdhJobTSWst2h7inFbT6YuvjD3lc
         KOXR62E2I8xdK9d3iA46CuWuc09gtnNWtU1inLUBKt3W2VFxv1oZP0MWogvyGFRqAqpm
         5rj7fAvSBkQeH/6tjW/7+8wmkcY7+DkvuWKc5GVS2vJvpYvi6zqeADFPeQ5KYlVhDGCJ
         oqOVkwbMSIOvTMyixmxhb4UIeBoj35AWsOKYyCUfQVRCFwIQImaltkOas2sLPSOOOYAT
         j6glTGaswJaRstf2YFybDkitbBFMuALInVpuhQcmFFkiNtRztJVAu/oY0iscQ4/j4Q5X
         b+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nk6Ijf5n2PbgVEl5figkzJQ6nQw3WlR2m4+z1tnOPMs=;
        b=rKZ7k34Z5GsUKPL/fXSfvHS6JQ/st3HJXYjZEVL/igBFxgdn6xpNKyhCGr4L4/h5Mx
         C60hUh8BFwnwNBmH9xdees007Hd3rAXD9GlfrOZQ0SESBoGvYgIQ2j9FL6PoS6ByLAWY
         wWXccgUef8hsbEmfXa2c0Ssovi5ARcJz1b9XErSzQqmgEMLX4WPgYoHC51lkD2nPIGZ9
         3ZaHoxVsmaG7ddL6uGMTD5CGHzIhqfd34eDdwXVhpnrwQ7JoJ61oyvQIFqr0WE3y8x0M
         xwQ2vt2O87+81sF6O05scQnfpUP5EYRazEDw46UERPJgOctaL6s0xYQ+7XlEHXqE9gvA
         m4Hg==
X-Gm-Message-State: AA+aEWYo2+bZ8nNIZ+CQ7WzKCv6clEFwZyBWvPywWBCJrgL65uVh5c9E
        l8KOEzX8fe+Rmut1/XMpUvqXww==
X-Google-Smtp-Source: AFSGD/ULnUWq5yqPSE4NSem9nopInug6P/7IREWBdxJY333h5zPP3Ah86S4zdsdbOQHiBabE2S/GSg==
X-Received: by 2002:a24:4648:: with SMTP id j69mr4104439itb.56.1543431018554;
        Wed, 28 Nov 2018 10:50:18 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t129sm1319515ita.4.2018.11.28.10.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 10:50:17 -0800 (PST)
Subject: Re: [PATCH 17/20] aio: support for IO polling
To:     Benny Halevy <bhalevy@scylladb.com>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20181126164544.5699-1-axboe@kernel.dk>
 <20181126164544.5699-18-axboe@kernel.dk>
 <69acea804eaf71f2d05b6ab649ecbf9bfd026447.camel@scylladb.com>
 <a58a7fd3-7994-0e30-40f7-f990a162205f@kernel.dk>
 <1b282e42a1573bbcba31bd628860b31ce9b60e5c.camel@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c4fbcb50-edc2-2411-dfd4-fd4d05cf8c40@kernel.dk>
Date:   Wed, 28 Nov 2018 11:50:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1b282e42a1573bbcba31bd628860b31ce9b60e5c.camel@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 2:33 AM, Benny Halevy wrote:
>> I don't see how we can get there with it being larger than already,
>> that would be a big bug if we fill more events than userspace asked
>> for.
>>
> 
> Currently we indeed can't, but if the code changes in the future and
> we do, this will reduce the damage - hence being safer (and it costs
> nothing in terms of performance).

The thing is, if we're ever over max, we have potentially corrupted user
space memory by copying back too many events. So if anything, it should
be a BUG() condition, not just a check.

-- 
Jens Axboe

