Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE62C4320A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B35604DC
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhHPQwv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhHPQwt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:52:49 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C677C061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:52:17 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u10so27621241oiw.4
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xO5EMmY8sQ8S/tQm52A7GQ7bDU6ioSSVSLGS4hhhAGw=;
        b=hND9YVgRVkyT+6hFdajzVlyemD74d0Dj7GSNO/jU0Mv0S0HIRbE7N4Gw3lFjIRyaEp
         PLQJUADLOpuCj0SquKpzAaEuHJV/Iy+mnR3zbuoG5tihaV9mrV/h2US1MrmzNT0vJbCo
         7GKVEGxIutQfPYS/Br+RPQSCTcpaTtwzpDsaaf9J/lXuuEcTLosySspYeNzeiMdEMZjV
         BQSrN28ubk/LRZMC7ehadkTexB+KKj1N6v6xZwqp5SHDjpZp3dC6RlRvvADomSs3xcVs
         5fo3Z2H9mDhGB7rml9EAp2PLUFBdJSie+LdZrgE+wSZRBAPFhfj8U4zmEuxguAN7j87a
         /6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xO5EMmY8sQ8S/tQm52A7GQ7bDU6ioSSVSLGS4hhhAGw=;
        b=VyAgBr0xlWn3s2XJd8UGSVInm5CKp17XhjGQs5QCfskMMK/wwfCURpyAW9cXdJE97U
         uwayA9z/vUIYQAz+KdUwwzHmOC8OIy1ikXK3dvsJpyhYlhY5TqonAg6JePJtYj06fbF8
         KDweeaMpJUkENNuAz7vkKhx4rDYEm2Te7wD/NVMoSRI26ROT4LWH4bCvFt45zjcQXn2U
         OVox2/7rO88N41K7c9cYeTL3U2Ye/mthABrxGE4SqfHf+JfYqclpiYKVewGk8jgCd0ZE
         c5SJ/CxDX1UUgv/rKdCVrIgOA4AD53pm4IH6pfuQFtOD8taCZj5SNlJNfrjgLwEZL3+w
         oHsQ==
X-Gm-Message-State: AOAM53122ULrzXX+TmlHNeIJrFuat0r4CaE2F8TPMkoht7TsCpqHOKkJ
        8KuyNpF3C+qwAXZ7MGeKoTwh5w==
X-Google-Smtp-Source: ABdhPJzFMiQ5HbZK/pICulgA1JdF5qH8hgDHlnDpwG+eUzUgtthcXvNCZVHyDbeUqPXXCSuc/3r5Wg==
X-Received: by 2002:a05:6808:1301:: with SMTP id y1mr55854oiv.156.1629132736985;
        Mon, 16 Aug 2021 09:52:16 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i1sm642326ooo.15.2021.08.16.09.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:52:16 -0700 (PDT)
Subject: Re: paride initialization cleanup
To:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        Ondrej Zary <linux@rainbow-software.org>
References: <20210816161110.909076-1-hch@lst.de>
 <953db079-d556-f0c5-31eb-932d7f78a3c7@acm.org> <20210816164218.GA5244@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <181bb486-c102-0938-5649-67fa1942982c@kernel.dk>
Date:   Mon, 16 Aug 2021 10:52:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210816164218.GA5244@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/21 10:42 AM, Christoph Hellwig wrote:
> On Mon, Aug 16, 2021 at 09:33:10AM -0700, Bart Van Assche wrote:
>> On 8/16/21 9:11 AM, Christoph Hellwig wrote:
>>> the paride drivers currently have a major Linux 1.x-style mess for
>>> initializing the gendisks.  This series refactors them to be modular
>>> and self-contained in preparation of error handling for add_disk.
>>
>> Hi Christoph,
>>
>> My understanding is that both the parallel port and IDE are obsolete 
>> technologies. Is anyone still using the paride drivers?
> 
> It is fairly obsolete indeed.  But three years ago Ondrej still had
> some and did test the blk-mq conversion.

Was thinking the same, but if someone is actually using it... Ondrej,
are you still using it? And if so, any chance you can test these
patches?

-- 
Jens Axboe

