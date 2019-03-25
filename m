Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE94C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F96C20863
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Pl8B8yrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfCYQmo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:42:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34690 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbfCYQmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 12:42:44 -0400
Received: by mail-io1-f65.google.com with SMTP id n11so8215136ioh.1
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uoX8jNWSAXInEk3DZfyvqOe0hJmmnJ2TdvMsm5TZIwQ=;
        b=Pl8B8yrz0fH+bKiPi30eYEQMZ3KCQrd7fdd0aMkNKiqDi/feT58YGdBPZ4zayp/aX/
         y078MTMROXpzz7O6oqrk7DzWA9JmNuA6kWM78xxvFfoFvl7ashlvG7UVbs8AAJ/AlGrV
         EEss0/Glw2zSsaLKqMyHolwEuSY9F9DX3KSUGppDwR+kKXW645GuPlPFa/zfYtWgC6kb
         MSdKlGdU+GPM5Pd2FaCnbh5YtyKU/5RcQRXKLuJCWAdMOc7NNEGqMB+lMNX++spNmUGm
         NJBN6Zlq855qAlLSTiKzGmSHYUovDiBFTceMr0/xJdi+IacmzllVpWTk9WKojqIbOpuH
         J7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uoX8jNWSAXInEk3DZfyvqOe0hJmmnJ2TdvMsm5TZIwQ=;
        b=C3fNhEXllNK5RT4PJ747W3aY9475+rLEbnPms+Y4DuGUpROQlLtd7CjMkht4g9zKlX
         xh1hsWcQbejkWDVA5O2lJXLLIh8BrLsD+zS3zsQgNfTFavSw6ccOfcpXQfSgTz/42W+F
         8lXJsCR3jW8MI3mmx4j5zHa0JbO5orhX1XEQL+714XC3pBKq14+NLJlglVx8WbPtI3V3
         szHlQ/lGy1DMACv/BQOBEC4wg9fUUtpErYFbyTAmqQdwFPuiTV+2bIfBV2Ff6S9LSGl2
         w6PV5pZ/o6SSv0H6bhASlyS9vlKCZN6yJNjnp72pILpdO4E3MoxtHk8HKZ9lwpvqxBpZ
         NLug==
X-Gm-Message-State: APjAAAU0PQ3dP3EIzJXesfZwfR0bf7Z8OiFnGWLEy/5Y47rpb0zpKuEn
        LIC7fqG1Ko+Gn02454sqURHwv5QzuDxw+g==
X-Google-Smtp-Source: APXvYqwiw2JmOUOh+PoS+kDOuSHDMKIWQM/cNsk6vZow1vcjYi3vwUifxb4SdmAf+uDSnHcV2h1ULQ==
X-Received: by 2002:a6b:660e:: with SMTP id a14mr16743517ioc.136.1553532162969;
        Mon, 25 Mar 2019 09:42:42 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k18sm5117452itk.38.2019.03.25.09.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:42:42 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: fix sbitmap ws_active for shared tags
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Omar Sandoval <osandov@fb.com>
References: <c0d3f0c8-a5d7-19dd-7b7f-1d4f860c425b@kernel.dk>
 <1553531987.118779.9.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0ef38015-d57c-fdbd-6c1e-6cf2ceec3ec4@kernel.dk>
Date:   Mon, 25 Mar 2019 10:42:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553531987.118779.9.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 10:39 AM, Bart Van Assche wrote:
> On Mon, 2019-03-25 at 10:22 -0600, Jens Axboe wrote:
>> We now wrap sbitmap waitqueues in an active counter, so we can avoid
>> iterating wakeups unless we have waiters there. This works as long as
>> everyone that's manipulating the waitqueues use the proper helpers. For
>> the tag wait case for shared tags, however, we add ourselves to the
>> waitqueue without incrementing/decrementing the ->ws_active count. This
>> means that wakeups can take a long time to happen.
>>
>> Fix this by manually doing the inc/dec as needed for the wait queue
>> handling.
>>
>> Fixes: 5d2ee7122c73 ("sbitmap: optimize wakeup check")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Hi Jens,
> 
> Since commit 5d2ee7122c73 went upstream in kernel v5.0, does this patch need
> a "Cc: stable" tag?

I guess it does, I'll add it.

-- 
Jens Axboe

