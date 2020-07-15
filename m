Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CCBC433E1
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E0A2065E
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 14:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0u2Kc4Bb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgGOOqx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgGOOqw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 10:46:52 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F7EC061755
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 07:46:52 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k6so2187009ili.6
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F4RPWWzGL3R/GCn0bvbwjBdbK6S6cE2QN9yjE6Xn0cU=;
        b=0u2Kc4BbWmwqMLQKEJHRDpBEJQpzqwYbPJxfunBxjCbM9XoXIJdh4ic5sLff+bM3HS
         UVxabkw47fb1BNRMp+j3OBgdFXAZKAiJWSmwGGcMv6s9XbdCdZtxIR+Lp2hMbwpbd1RP
         0Wzw70fTs9QvLPAL8nuBWNGO9v5wIWi2t5mct1IkS/k8x4Rdx1J5jKNaZt1fhKj6qwcB
         FnFD2kanifPSCY5VGAb+fNiHM+yrXN9ZMsYflEtECyqB263KwRGlR6qy2JbBRRNLaHW+
         BoPMFk5DuXaHL7N2cVYtmq5x1fW+tNwEjXz1G/IjNwFO/hNuUjn3jXRJRw96iiurE/VT
         fTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F4RPWWzGL3R/GCn0bvbwjBdbK6S6cE2QN9yjE6Xn0cU=;
        b=Tyl7Stzm4eFQfVRdoBhBHaPx7eXL4TXOnkD60pqJGBs1tcV5cM25IQlQPFx/WG6Mpa
         DAczeN3vNbTa7lqZmt1wroDSHVvfLUb3Q3sBrzAqIOzxySiOIOZgoN6L8g7ACDepygsF
         CGu/yFKqdA6F2XEC7ZpZYndmCHtWfpqA0qBwo4QZhAMkiREKD5lEeTg3KuzOds19rT27
         RIq/6Sj7wuQDdnsbjZxLKZuRTjAQ9BYrkD2sBv+Nanr24ox4IJcS0z62h9BymSV/brmv
         jpiTlhntthoWCybikJImosNyini8xz425Vy8ZOYhA4KtEbCBehEDE1Rq6ghorQ3S2g+s
         I2mg==
X-Gm-Message-State: AOAM533nXynir439LnJFxQOYkBWSi5xEUYAx4GV7xeJ7s3X8gWsZ2evS
        zdNJKiAtGR7LMS33acjFA8KfEQ==
X-Google-Smtp-Source: ABdhPJxrHJBSTzgZh/+7MHQ8okNVpQMZE1Sc68iJMdEjxrNZwXRKvb3UvJu7xbyC0ol40FSQSY7guA==
X-Received: by 2002:a05:6e02:606:: with SMTP id t6mr9861925ils.181.1594824411871;
        Wed, 15 Jul 2020 07:46:51 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u15sm1249813iog.18.2020.07.15.07.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:46:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] s390/dasd: fix inability to use DASD with DIAG driver
To:     Stefan Haberland <sth@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200714200327.40927-1-sth@linux.ibm.com>
 <20200714200327.40927-2-sth@linux.ibm.com>
 <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
 <20200715064854.GA5409@infradead.org>
 <88f32826-4bd2-27c1-c9e0-204aa556b0a6@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <85ea2f21-64e3-aae6-b069-013bb929045a@kernel.dk>
Date:   Wed, 15 Jul 2020 08:46:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <88f32826-4bd2-27c1-c9e0-204aa556b0a6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/20 7:32 AM, Stefan Haberland wrote:
> Am 15.07.20 um 08:48 schrieb Christoph Hellwig:
>> On Tue, Jul 14, 2020 at 02:12:27PM -0600, Jens Axboe wrote:
>>> Just curious, any reason this isn't just using bio_alloc()?
>> The dasd_diag_bio doesn't seem to have anything to do with the
>> block layer struct bio..
> 
> exactly, that's a struct dasd_diag_bio.

Duh, guess I should have looked a bit more closely...

-- 
Jens Axboe

