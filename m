Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAFAC43610
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7911722506
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="K+Rxj7wP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7911722506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbeKOBWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:22:07 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:39283 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbeKOBWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:22:07 -0500
Received: by mail-it1-f172.google.com with SMTP id m15so24350356itl.4
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 07:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZ+inWvfHVDSEV1usxer1b2XqfBkS3568/ukX1pOf1M=;
        b=K+Rxj7wPrdTCWQLhNRupB4mTyIqSqc10IWF6H72K2rlgYNHwaXoJ3RfU2g+k3rfWQc
         mfhqUqLuQN+4haK7oPaFeYNHNfZPPQKSQrwmNTSeo8GJyK3J+HYbK/7CmaZ7yFCmeGDK
         Kkb9+Krywz7K2fkhgiiolbQjuMOkMqMQmtooAEjO7rLhj9s5azYXa9+sV+tt9hpoUlEd
         NgH3C9P311UP9DW5RIUq6uCCbNgjFeZKwmAKiuTnrci7kd1w969zVJETOfHs0YYbg3R+
         6zO7398g+/bahknIK9nsPD40HAqkax2Yt3+/8Ad0fR0V7X4hxCWB2AvLTwZICvfv6NT7
         mnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZ+inWvfHVDSEV1usxer1b2XqfBkS3568/ukX1pOf1M=;
        b=XsXmBC2Fr6fMn1+VedOCZkkqVoT3EXlLsi6jnGj4KNfphqsdfx29gukiYExpjyjLzb
         udr2ay7aXu+JBj908SEJmoR5sOv/rIyJakrvIL/4uqCeQ0b9mFbaJBWT40ws88p8ILAK
         SfEfy20vkZ+Krf2pwHSfE5FAWW/0IBZT5q/dExCSCqETFOIie1lleJ7wAIvh9kdbbj/l
         khGmpz7W1S3gw6D7vnxz4dTptua1GnOt4qqvbKYDkeGvq25cNkVUxeZWYBH1agISMLj5
         XB1gxmhzQ9Luy1vT1D+11KaiBqwIUjrGdySyBzfnDT3n+SF6yOIkTSUkssHYl5YPNc6C
         53eg==
X-Gm-Message-State: AGRZ1gJFUz354J71UjgwfjSb7vDr613wsObF0p6jyWuf3riGKyGMipma
        dV+ZKpExTrl2F/4JeOJCx3hL2Q==
X-Google-Smtp-Source: AJdET5dnEpQ25v6+ETv7+Ja7eR+2EZc0UfDq5s3KBL1Z2E46gqjmwVnlKivPy/ezagMmUUgchymkjw==
X-Received: by 2002:a24:1706:: with SMTP id 6-v6mr2279539ith.169.1542208707074;
        Wed, 14 Nov 2018 07:18:27 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c102sm2653599itd.38.2018.11.14.07.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:18:25 -0800 (PST)
Subject: Re: [PATCH] block: fix 32 bit overflow in __blkdev_issue_discard()
To:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20181113214337.20581-1-david@fromorbit.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <10a8dd78-7c00-8593-9f4e-b20eb1161b92@kernel.dk>
Date:   Wed, 14 Nov 2018 08:18:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113214337.20581-1-david@fromorbit.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/13/18 2:43 PM, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> A discard cleanup merged into 4.20-rc2 causes fstests xfs/259 to
> fall into an endless loop in the discard code. The test is creating
> a device that is exactly 2^32 sectors in size to test mkfs boundary
> conditions around the 32 bit sector overflow region.
> 
> mkfs issues a discard for the entire device size by default, and
> hence this throws a sector count of 2^32 into
> blkdev_issue_discard(). It takes the number of sectors to discard as
> a sector_t - a 64 bit value.
> 
> The commit ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
> takes this sector count and casts it to a 32 bit value before
> comapring it against the maximum allowed discard size the device
> has. This truncates away the upper 32 bits, and so if the lower 32
> bits of the sector count is zero, it starts issuing discards of
> length 0. This causes the code to fall into an endless loop, issuing
> a zero length discards over and over again on the same sector.

Applied, thanks. Ming, can you please add a blktests test for
this case? This is the 2nd time it's been broken.

-- 
Jens Axboe

