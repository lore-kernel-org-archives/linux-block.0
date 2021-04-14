Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C945BC433ED
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 20:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9696A61158
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 20:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhDNUKI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 16:10:08 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:53077 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhDNUKH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 16:10:07 -0400
Received: by mail-pj1-f46.google.com with SMTP id r13so7055526pjf.2
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 13:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rl1l/W8USiMo26LqwG/8WgWWvpiAhlNN1owodXZIi30=;
        b=ZzbVY9k1o1cNJQnKJU63KYpwWc9u18cIwe4INWLR1Hg5DHMmZm5pQWshj4L26HOBvP
         Sg/fa7kAd3ZYSSs2pMZskZEkJL5QN39Uas0uTtdKHfv0aBLEPlsBhFCnedIemjNx3Gza
         TaBD2fxlGMN8RCDkp5wjqZhl2k8n+1zzvC6FonPVClq08QT9aZDyEHkd/GXHqJb4H8cZ
         jaM0igzbHDMSP5U0IGxPV8qY6diiTRfybe3okY7CDHdu7KpkB45CDcGvQtazIXe16axB
         jukH21b8aOTDKueolxDLbE5Ors/haL7SW+Qs6h3I6SHW1Qw0IzLpVNhjf3G2E4u946V/
         7kEw==
X-Gm-Message-State: AOAM530Cvskae5AhMETcAfB0wXlyRt0k/9psbXY5gK+opxihFb/FTiJr
        8rVk1vEwcDQQDV0zPl+/uGI0XLihVfY=
X-Google-Smtp-Source: ABdhPJwhIOvZS9IT3K0lHjXYZHNYELuwRVYTYJ4HmWcv8CHirV9K5y/HT591Y59MYdTggsvGJOLU5A==
X-Received: by 2002:a17:903:2488:b029:e7:1f01:85c4 with SMTP id p8-20020a1709032488b02900e71f0185c4mr40021917plw.13.1618430985284;
        Wed, 14 Apr 2021 13:09:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6906:3c2c:a534:ef9? ([2601:647:4000:d7:6906:3c2c:a534:ef9])
        by smtp.gmail.com with ESMTPSA id z195sm228216pfc.146.2021.04.14.13.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 13:09:44 -0700 (PDT)
Subject: Re: [PATCH] ata: Fix several kernel-doc headers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210414182814.18065-1-bvanassche@acm.org>
 <5ef175ae-9ff4-dba3-25c7-a27bf745b5f1@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0cfa33b1-ed91-d2e0-81a1-114dbe3f7b08@acm.org>
Date:   Wed, 14 Apr 2021 13:09:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <5ef175ae-9ff4-dba3-25c7-a27bf745b5f1@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/21 11:39 AM, Jens Axboe wrote:
> On 4/14/21 12:28 PM, Bart Van Assche wrote:
>> Fix the kernel-doc warnings that are reported when building the ATA code
>> with W=1. This patch only modifies source code comments.
> 
> If you check for-5.13/libata, I think you'll find most/all of these
> already fixed.

Right, I should have checked that branch before I posted this patch. My
patch was prepared against the SCSI tree. Since all issues addressed by
my patch have already been addressed in the for-5.13/libata branch I
will drop my patch.

Bart.


