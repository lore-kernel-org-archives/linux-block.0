Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4FDC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 01:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39749214F1
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 01:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VTNbTIz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39749214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbeKOL5h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:57:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41430 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeKOL5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 06:57:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so8228617pgh.8
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 17:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NRS0WNPRswomrkeKUIMnHidk8L9CBK22oE+san0mMLw=;
        b=VTNbTIz4evsD0cHuyKTcmIawQ7wg65Fc5Jy8Nycg6eQsTtpVYB+8vUlJ32xBmIKLUC
         nZcMm4GvItzPcUbHiMF6dJ/z3pFTlAjPwNnOnVXNshhwIfOk0gWOSotqkICXA2kbUICt
         sT6fpkvFrOCEfkXu77SQ8VtrVfRsb119asxeIOf4TkVK/wdMcqwbWvdp05eJp8D+LZij
         am1aq2xTfbZpm5a9laN9ONat5zdN/lQXRtSC/wgVVcGZJqkK35laLl4hk9YIlcYtdKBo
         UMIy3y7Y2E6PqDRpTd4WAXRIljMBIZqhp5uBLrySO6BZPkrW2su8W2rEEHAV+zwdk4Y9
         zM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NRS0WNPRswomrkeKUIMnHidk8L9CBK22oE+san0mMLw=;
        b=ILYJAB/5yECNFUMfDGrkXREWROXrLc5K0WOOR0dy7gdR5Z8CkbFyO4wHZJ06dmkoiO
         wSMHHE8G6kg9NjNLl7pMV1uEiYyGkUCIYmPXFasFHr4O2OcI83k1Af09WimRB4W9hltN
         an7k3Tm2Y5ThNxFJllwg/u0Allpynty+SqqUrXpOM0GzSBV4ffM80wCd0A0rayGB2MjO
         j6+pn0jzUinjX/uc5feXSfIToxG1Icx94LMgzcKn4zLpK9sAv9rCs9c+OLehGJGX4ekV
         QoAByC0k2YdzGv/xIq8OqCmopueEKLFQ4cMGcfT2F2+p+FnMOpUiqIVKmj+0GEuKXMFU
         UmRQ==
X-Gm-Message-State: AGRZ1gK4F9C7DNXIJ1Uq91zOCetw9yU25P3g4Dvrl4kw/kJMeogIJNAJ
        45RjymZ1cFCn4Snd77n0ezQrkNQbRDY=
X-Google-Smtp-Source: AJdET5dvbAygKzTGpf+PD5EWVU+d8b7fMqj23zRkJi5DHndK1kNCF+EtWlSYD9RAwkt/rM/XhTRdNw==
X-Received: by 2002:a63:2447:: with SMTP id k68-v6mr3918030pgk.156.1542246710117;
        Wed, 14 Nov 2018 17:51:50 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f22-v6sm30657171pff.29.2018.11.14.17.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 17:51:49 -0800 (PST)
Subject: Re: [PATCH] block: fix 32 bit overflow in __blkdev_issue_discard()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20181113214337.20581-1-david@fromorbit.com>
 <10a8dd78-7c00-8593-9f4e-b20eb1161b92@kernel.dk>
 <20181115010651.GD32603@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <80b9c4b7-1625-a1b6-0f1e-94de9d8b446b@kernel.dk>
Date:   Wed, 14 Nov 2018 18:51:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115010651.GD32603@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 6:06 PM, Ming Lei wrote:
> On Wed, Nov 14, 2018 at 08:18:24AM -0700, Jens Axboe wrote:
>> On 11/13/18 2:43 PM, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> A discard cleanup merged into 4.20-rc2 causes fstests xfs/259 to
>>> fall into an endless loop in the discard code. The test is creating
>>> a device that is exactly 2^32 sectors in size to test mkfs boundary
>>> conditions around the 32 bit sector overflow region.
>>>
>>> mkfs issues a discard for the entire device size by default, and
>>> hence this throws a sector count of 2^32 into
>>> blkdev_issue_discard(). It takes the number of sectors to discard as
>>> a sector_t - a 64 bit value.
>>>
>>> The commit ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
>>> takes this sector count and casts it to a 32 bit value before
>>> comapring it against the maximum allowed discard size the device
>>> has. This truncates away the upper 32 bits, and so if the lower 32
>>> bits of the sector count is zero, it starts issuing discards of
>>> length 0. This causes the code to fall into an endless loop, issuing
>>> a zero length discards over and over again on the same sector.
>>
>> Applied, thanks. Ming, can you please add a blktests test for
>> this case? This is the 2nd time it's been broken.
> 
> OK, I will add zram discard test in blktests, which should cover the
> 1st report. For the xfs/259, I need to investigate if it is easy to
> do in blktests.

null_blk has discard support, might be an easier target in terms
of blktests.

-- 
Jens Axboe

