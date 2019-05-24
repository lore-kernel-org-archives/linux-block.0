Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A2CC072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB06206A3
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 14:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vh5ovxTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403934AbfEXOOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 10:14:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41023 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403921AbfEXOOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 10:14:45 -0400
Received: by mail-io1-f67.google.com with SMTP id a17so7859591iot.8
        for <linux-block@vger.kernel.org>; Fri, 24 May 2019 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ck1nHJ1vjI+FGqbGClCTUVeta38xhHA7A+d5pEhzf0E=;
        b=vh5ovxTWx97P7Q6UPQCr5LOrm0EYUxzZ1JWtl4ubZ10FfAxc69gLdY8KsHDdP5FWbU
         VZZ+MpX6ifXlewl4OQFVHTNAPvuAEJn78csM3xGS2dHMDKqVyNsL/mI9s+gRQaxxhm44
         lwA9fC3+NgpodKECFZcLNwBw6Dq3pFKwApMgptqn0iQS6xzFIrWw+Q0ELfMc9ubrlwjY
         hhD9Px0BvsMKmelM5SsELsRpPv5vAY6DdNfkacEWFfc6fd9SGlqK/EbQ1LMJkKBkgklY
         CAtSe6Vi6TXQUPMdD0dZSFcwroqFtXLKTqb0djVmoSM8XFeF2k/e88HKLIQouLpAnfvX
         9TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ck1nHJ1vjI+FGqbGClCTUVeta38xhHA7A+d5pEhzf0E=;
        b=Y9oc44ZT8AF5QTKJ9pd7uF82x07qE1oKm0vZoBKnEvfLgk2xbrMnbI4HE4GQA1qyRs
         z1XK6SeYlJaSIem6tDCSslo3P9Yq6FAiNEFRSL4QOo9ZKZuzYlf671iNXxomL94s3i8u
         QMtkefvidOBy8yil08GNw/Ho32DUCbkq+/g8jx009azA2QkIa3Vk2PWLm0fD6B3b74t3
         YPjc/CRYPWLInLagI2B/Iqr6NJLiPwZ5/NaZVC9ifyTecYOkq2fuq+uoyEnsIGqxSAfv
         2OTv2JFftvwC5t3NvcYMfS0WbMUV1CcKqZeo36Cq1OWb0CTsTY3gZlamUfIf6p7ra0u3
         OTNw==
X-Gm-Message-State: APjAAAVoF7qNCOHfi+o5gIbv39DJXqvDenvD6PFdYk3U9dD7matndiMC
        Y3czzbtQBzu6zeY9vevVC7Vhf0movw7eqQ==
X-Google-Smtp-Source: APXvYqyoyYOyZ0A8I0mV3PMe+Pnaz2Mnrh8eoInR9tSurhjg5a42jRtFpLcTNCeBkTjAWyTLT+yNDQ==
X-Received: by 2002:a6b:6209:: with SMTP id f9mr4120359iog.75.1558707284666;
        Fri, 24 May 2019 07:14:44 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s4sm902190ioc.76.2019.05.24.07.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 07:14:43 -0700 (PDT)
Subject: Re: Packaging liburing for Fedora
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>, linux-block@vger.kernel.org
References: <20190524084827.GA31048@stefanha-x1.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <26a35a83-fae3-e502-cf15-20f3f2fe4a0e@kernel.dk>
Date:   Fri, 24 May 2019 08:14:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524084827.GA31048@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/24/19 2:48 AM, Stefan Hajnoczi wrote:
> Hi Jens,
> Applications are beginning to use liburing and I'd like to package it
> for Fedora.
> 
> Two items that would be useful for an official distro package:
> 
> 1. A 0.2 release git tag so that downstream packagers have a
>     well-defined version to package.  0.1 has no git tag and useful
>     changes have been made since the 0.1 .spec file was committed.
> 
> 2. A pkg-config .pc file so that applications don't need to hardcode
>     details of how to compile against liburing.
> 
> I can take care of #2.

Once we have #2 covered, I'd be happy to tag 0.2.

> Are there other known todos before distros start shipping liburing?

Not that I'm aware of.

-- 
Jens Axboe

