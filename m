Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2FAECE58C
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 14:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B4721721
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 14:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hvCFFYhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfJGOKL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:10:11 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:33819 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfJGOKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Oct 2019 10:10:11 -0400
Received: by mail-io1-f47.google.com with SMTP id q1so28903516ion.1
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2019 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=X8SK3p2IaGf4v5OiU93KBR11J1mS28Q/ja3ag7HLeLE=;
        b=hvCFFYhAJlAUqsj6U7FJWga772YKLQwByHkRK+V5oe9oaoxZ/6DfXqo+CcGQxZbSg9
         lQLkxtvmraAFhQJ2f4UraQSC9BMK2vRvklwefguhOsQdBSRYgI/cH0WGzoQnk4IJOCSC
         49KoY2nHdyJ6w0NxJYRowYjyG48kYFaUQwnLJ6ud5nxZzewLIE47Rj9kjx9AbyKLqw51
         xj0gE6JbCF4c9KpUG8D7Jy+k+lyhYFE2DAzYXwSgTmAFBIpq5SQzQCWXvN1qN4+12lZN
         /OuwIb17sSXi8edunqoFreE56xs1VD2Yi5YizaWYkhDvHv5D3XePb6OghY8NKtvQwngE
         i5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X8SK3p2IaGf4v5OiU93KBR11J1mS28Q/ja3ag7HLeLE=;
        b=OBTL/VUOks5UWKw5B2UduysZ3blNuNeydTfnwIOH5uYeSzwIVe1XT0nbg+hY7rmNEU
         ItexBz/aSl1aLWk7+CHLo3NlgOXwOmXwmguDO1FwCiNUAukJ6ZRGzWOcc0MWmMeVPhND
         geUopV8HWmRa4Aut2RPVynw1uXW4n33r5+of1iFDeSy0P0fAYn/j4dFtcyilhQv9czAp
         W3q/IJEkcnUlAUOB4bcU6vflVCINfJ0ybwOLrwU4Ikk+eekg5O9nZ+55+Lur6Z381sum
         mEA1W09YAGbNSrYXv0jgJVkBvOTs86bD1jKYunjEJjKymi9uwAAC5BrkPeFucaWBr4/y
         eqFw==
X-Gm-Message-State: APjAAAXBp4JRs8+xuk2o2kUSuSgqXCU/CJQXUpolBIBUpmAMCds0tnAi
        vYDfI1fRF83rocB1GQZndgZLS1WiTutNRA==
X-Google-Smtp-Source: APXvYqxaSGqAlfzw+SDq2kJVH/3WHzwUDshEjx5v4gEP+IgNDCKAf+ut1mDbeK5VeinNrVfnsTDpyg==
X-Received: by 2002:a6b:b213:: with SMTP id b19mr23079699iof.58.1570457408777;
        Mon, 07 Oct 2019 07:10:08 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t26sm5242712ios.20.2019.10.07.07.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:10:07 -0700 (PDT)
Subject: Re: packet writing support
To:     Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>,
        linux-block@vger.kernel.org
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
 <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
 <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
 <fc70b63f-3780-5654-6bc5-0f2d6115bff0@kernel.dk>
 <6c51a5fe93cfad0f76fdbfe47caaa5f5d3f1ca88.camel@cyberfiber.eu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <99b7b647-8788-8a20-e052-db3306837e2f@kernel.dk>
Date:   Mon, 7 Oct 2019 08:10:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6c51a5fe93cfad0f76fdbfe47caaa5f5d3f1ca88.camel@cyberfiber.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/19 1:02 AM, Mischa Baars wrote:
>> Let's keep this very simple:
>>
>> 1) Have you used the pktcdvd code at all? How much?
> 
> Where are talking about the kernel/drivers/block/pktcdvd.ko.xz module.
> I have not used it directly, as it is a kernel module. Instead I have
> been working with K3b, the KDE cdwriting software package.

Let's keep it even simpler - why do you think you are using the pktcdvd
code at all? If you're using k3b to burn CDs or DVDs, then you are not
using that code at all. You'd have to actively setup a devie using
pktsetup, and you'd then mount it with UDF to write files. Doesn't sound
like what you are doing at all, which renders this whole discussion
pointless.

-- 
Jens Axboe

