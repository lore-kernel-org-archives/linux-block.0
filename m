Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDA2C61CE4
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD6B2086D
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 14:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DqXhGXWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfASOgE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 09:36:04 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:43727 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbfASOgE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 09:36:04 -0500
Received: by mail-pl1-f169.google.com with SMTP id gn14so7657936plb.10
        for <linux-block@vger.kernel.org>; Sat, 19 Jan 2019 06:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vPvuS8CRXrhkbKUYTQh0DA/CQrOijd57nsHZjBn/Si8=;
        b=DqXhGXWlndQPxpqg2q68pSXypCP/scWamCZKSifuszwQ16F7wu6uDTBv24z//jmQ32
         O+r4fqz3N9M99J1ICKy3TbE9yTQbeBV2GGfbiLKbLVUK8qjzrfPI18JGbs7H8ohmsGmu
         IjhGhBihf9vAvHrJatvSqbIlemsNq9AGFTU79Gn17Y5riAnGMao2jyDeCbi+JBjqyZEf
         odkZYWZdaN23pJ+JSU0AU88P3jNCqmCDYql5FMpDaTJ5yzsIczEN0ltDQ5MhVntqd3ey
         kUThmnYm8OEtQ2HNCKOdaXdKPUXXdPSVNGr0BZpe43TBQefMRnmsXnvnCVKwiiVQ9YM7
         USYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vPvuS8CRXrhkbKUYTQh0DA/CQrOijd57nsHZjBn/Si8=;
        b=YZ21DlqfQzrj4N08RhmQSeVlGf3pBpZHg/G9RlV6GgS+XsIeHb6S8OTfCgJiZvWEkv
         0C181WSh5mixcsCn1ajfq+PIA3KVxG5a9qRvygCTMIIyfFgNimIHTXH7ZepJykJNkQBD
         Uphpjl0Nf4wpkLn/R1Z726vVpBz3RalS9pJ8LGVPGIkp3Mx9E2OFNSXECMiS9lUGoma7
         nPR37nmnxlyEdxU2Y5E815KxbcOK8TeHQDdiikRe7L+5oTVyzfGpE4RiUrp2aPwPlydQ
         KSYYJzCUbl/22hkbMJeh1hpr/E4C4hgwbwdzVtrTATQL9JDPprHP8bYSratj0R1LGwzx
         wO2A==
X-Gm-Message-State: AJcUukcLsPv2yFB1NBD0PRsZRGpNI6S97ISas601weXZPDLAjOWz6JY/
        yL1W3ESGmLQi52HXfw7KKXRlxw==
X-Google-Smtp-Source: ALg8bN4Tok1RiFXpFMav9aeArGQM+sMoyRva6dQyVvfPNkL8CNErawvdDCun1dRxkyJh6toROIG/Rw==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9mr774273plo.27.1547908563722;
        Sat, 19 Jan 2019 06:36:03 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b26sm18198433pfe.91.2019.01.19.06.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 06:36:02 -0800 (PST)
Subject: Re: bfq: update internal depth state when queue depth changes
To:     Kai Krakow <hurikhan77@gmail.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        hurikhan77+bko@gmail.com
References: <013ca038-559d-0a56-4d49-366c7ec79ac3@kernel.dk>
 <CAMthOuPohGUM8gqxE8xoLdSnVaU2iEgOT60fqddWbsoDZSy0CA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <280d9cac-6373-8e90-dd52-11183db2e253@kernel.dk>
Date:   Sat, 19 Jan 2019 07:36:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMthOuPohGUM8gqxE8xoLdSnVaU2iEgOT60fqddWbsoDZSy0CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/19/19 4:13 AM, Kai Krakow wrote:
> Am Fr., 18. Jan. 2019 um 18:34 Uhr schrieb Jens Axboe <axboe@kernel.dk>:
>>
>> A previous commit moved the shallow depth and BFQ depth map calculations
>> to be done at init time, moving it outside of the hotter IO path. This
>> potentially causes hangs if the users changes the depth of the scheduler
>> map, by writing to the 'nr_requests' sysfs file for that device.
>>
>> Add a blk-mq-sched hook that allows blk-mq to inform the scheduler if
>> the depth changes, so that the scheduler can update its internal state.
>>
>> Reported-by: Paolo Valente <paolo.valente@linaro.org>
>> Fixes: f0635b8a416e ("bfq: calculate shallow depths at init time")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Works fine here in 4.18 as far as I could test (running a full backup,
> some compilations and Gentoo package upgrades, filling memory with web
> browsers to force swapping).
> 
> $ grep ^ /sys/block/*/queue/nr_requests
> /sys/block/bcache0/queue/nr_requests:128
> /sys/block/bcache1/queue/nr_requests:128
> /sys/block/bcache2/queue/nr_requests:128
> /sys/block/bcache3/queue/nr_requests:128
> /sys/block/bcache4/queue/nr_requests:128
> /sys/block/sda/queue/nr_requests:256
> /sys/block/sdb/queue/nr_requests:256
> /sys/block/sdc/queue/nr_requests:256
> /sys/block/sdd/queue/nr_requests:256
> /sys/block/sde/queue/nr_requests:256
> /sys/block/sdf/queue/nr_requests:256
> 
> Tested-by: Kai Krakow <kai@kaishome.de>

Great, thanks for testing!

-- 
Jens Axboe

