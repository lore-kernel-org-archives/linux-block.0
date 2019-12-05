Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5B1C43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 18:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0AC2464D
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 18:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Zphzt5kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfLESiI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:38:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35259 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESiI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 13:38:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id b19so2020320pfo.2
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2019 10:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AgeSW3zGctG+Pi7YiPGk/0qK3GJJdvjIDRic+F7mVx4=;
        b=Zphzt5kjmPRfJyKg+pqtWzRj184lvEaJkLwnSP399fXWA2RDchXLVtbqizLRSb5GaO
         acStr2BCbu6rNddrm0BhSt1BWWzh+w0zQEMFoWmnOLc5JSz6SXS7pYi3ywRIvD2xGmY6
         1VHEquGM0IxWcH6c+LNZlMOx24LpDIqPVbUUphEbtSpm0Ab8uw4zS44AUnKSUmO1Rs4+
         f7lYt2YBbnQwrvorJbqQUsA4oVEuMQQEyShdzw7fU9VaGahV6v8meM2F9RVtZXpkdNVK
         qMUYq5wR+xOpGxf1KChpDftS1Ccl1dTmLyErmVbngVrHdZaat9xl6EwWMFRT43Dimvk2
         mfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AgeSW3zGctG+Pi7YiPGk/0qK3GJJdvjIDRic+F7mVx4=;
        b=T6FCdbmgGF/IF4jhM+q4kR1KvJz+zniqLFNo0V88KUi9KOw4XKm13mUa7pGa049suj
         fcFGI4hX3EoFB8Y5JO2Y0NVzsvmT873jYyG1QkKWwgYl/NPUJIITgi2THXO4N+afuQaA
         /nEuFGtx63G4bsBgtc/tJgGRuD6kueGwbNpcqnGdno6ah8wIyAVoHBflg30ZZoInEuCa
         q1BUlrEYF3CFDaxlTm2HBQVS+iVF8K3d+LYNqcWoGPR4J+uZYEPJa7Hi+caHldrpZmo7
         ESv0qDWQM+WevdSfgy15r3/tKWdtRJ1UuTNXraRaDrKBSCKfc7sQHsaDAj9h7p9YsRwH
         5aUA==
X-Gm-Message-State: APjAAAU/jdjOd+LP8deI14yIQQLVkvRwRGfXkTZQUefuCwjlOUbICGEH
        J4YjVdj1ytF01f3J5pxO0N1XWg==
X-Google-Smtp-Source: APXvYqxcm9WGYAzTK2KkGzJ8kco2IJ+qKMwg3WWYGfIqOeAFlZrW0KDfd+A4db0KEHrvJ0iiMx/uOg==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr10583647pfl.32.1575571087795;
        Thu, 05 Dec 2019 10:38:07 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1132::11db? ([2620:10d:c090:180::1372])
        by smtp.gmail.com with ESMTPSA id w6sm12478484pge.92.2019.12.05.10.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 10:38:06 -0800 (PST)
Subject: Re: [PATCH] block: fix memleak of bio integrity data
To:     Justin Tee <justin.tee@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20191205020901.18737-1-ming.lei@redhat.com>
 <CAAmqgVN6huL60c9aw41yC6wz6fG0w-T4xR0Tuoz0PqX2BqwKDA@mail.gmail.com>
 <20191205074932.GA21955@ming.t460p> <20191205080915.GB21955@ming.t460p>
 <f4f0f90a-0541-a25b-f9a6-f7e0762d6e28@broadcom.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33d14d7e-2033-8680-8746-d259b51209e7@kernel.dk>
Date:   Thu, 5 Dec 2019 11:38:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <f4f0f90a-0541-a25b-f9a6-f7e0762d6e28@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/19 11:30 AM, Justin Tee wrote:
> On 12/5/2019 12:09 AM, Ming Lei wrote:
>> On Thu, Dec 05, 2019 at 03:49:32PM +0800, Ming Lei wrote:
>>> On Wed, Dec 04, 2019 at 09:41:24PM -0800, Justin Tee wrote:
>>>> Hi Ming,
>>>>
>>>> I understand the patch, but I have a concern.
>>>>
>>>> Is it possible to come across a double-free?  from bio_endio ->
>>>> bio_integrity_endio -> __bio_integrity_endio -> bio_integrity_free;  And
>>>> then, resuming in bio_endio -> bio_uninit -> bio_integrity_free;.  Maybe
>>>> it's even possible queue_work  bio_integrity_verify_fn was scheduled and
>>>> called bio_integrity_free from there as well.  So, should also remove
>>>> bio_integrity_free from bio_integrity_verify_fn and __bio_integrity_endio
>>>> routines?
>>>
>>> Yeah, double-free could be caused for READ between bio_integrity_verify_fn()
>>> and bio_uninit().
>>
>> ooops, the above race doesn't exist because __bio_integrity_endio()
>> returns false and bio_endio() won't call bio_uninit(). And bio_uninit()
>> is only called from bio_endio() when bio_integrity_verify_fn() exits.
>>
>> Also we can't remove the bio_integrity_free() from bio_integrity_verify_fn(),
>> otherwise this bio may never be ended because bio_integrity_endio() will
>> schedule the verify_fn again if bio_integrity_verify_fn() won't clear
>> REQ_INTEGRITY.
>>
>> So bio_integrity_free() is always called serially, and the flag of REQ_INTEGRITY
>> guarantees that it is only freed once.
>>
>> I think there isn't such double free you mentioned.
>>
>> Thanks,
>> Ming
>>
>>
>>
> 
> Right agreed, the REQ_INTEGRITY flag is what is guaranteeing freeing 
> only once.
> 
> Thanks for clearing this up.  I'm good with the patch.

Thanks all - I have applied the patch, and re-instated Justin's
signed-off-by.

-- 
Jens Axboe

