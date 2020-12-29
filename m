Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D10C433DB
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CA7206F7
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 18:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgL2StX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 13:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgL2StX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 13:49:23 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAC3C061574
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 10:48:42 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id hk16so1962715pjb.4
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 10:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j57funms3/uk5S0lOWedY/kE6eMVwntL1XcK0k9XZiU=;
        b=s4rX+xwwQDt9td72uutMVIbhi4NHALu9el6Kn+egb0jJA1r55oN3UA2nnKRT876Avb
         /SCeKiLODMpDEl583kGv1UIYDQ7/HDVCbLBHdAJZvQbS2q/T3PTCOwrwZHMs+tBQ3foX
         Mx3QMqkCNF39LtGLdvAWpIJtJ0OVpsB9c39otTq4ZtYDKdS5PIJmr2Pm5X7fM6eCby4h
         5RduUk4CvoGO+5I1FE04hbuE17UPyDHOqQIA+gp/Ur+GaltmIpeQ34DFQQ+g3gLgYKya
         dfhLohqd1hzTS7Kp9/OtibdM2LSPtR553jAz4aRzkZ3wWc3cryrVxZFyZuKhg19PeVHV
         0EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j57funms3/uk5S0lOWedY/kE6eMVwntL1XcK0k9XZiU=;
        b=Z7YInApRmU0qT+Nn49+6TLgXVF55PVth75d2O7Fuq2kauxrA2ZmRwHiHL28uwwEJFz
         AukNAHIP/MoX1FKjXdolqys0GcxlvtPcj7cK2QbH7m4ekBD2XQHTaPWOquS7sOkgJAFW
         jft+TnUxILA2cdfyo7wWEyLc5syIwiGcO2ceanb+k9Jb8MMjwA4IJ0rEZCUoSFU902HI
         iyXgKmpyu/jymYtmqp7kt2EgczoJr8+8EdB2/TQWipLs771ZohbwzGTvyUjfBeoqXAix
         ok6/MZkFGSUOIloXpF5u26V44VmslxLV4YO5g/YHOwTIJ63ETQhtJFH+P6JicyqJoE+d
         s/5g==
X-Gm-Message-State: AOAM533ToB5oJB3y9IGCHsp9Wf1vRu7+byNfFcfK+9fSb0/2nihkVS3q
        fj8NP0vwWrG2NIoh8yuHDF04JN1dTwgf5Q==
X-Google-Smtp-Source: ABdhPJx+tUprsTWuIey7ZIqRjbTB3EHgIn9QBcq1P3a6HTx2As3PGmwvNcHv4EA8g+KLaSG+ZSQnZA==
X-Received: by 2002:a17:90a:674c:: with SMTP id c12mr5027600pjm.98.1609267722194;
        Tue, 29 Dec 2020 10:48:42 -0800 (PST)
Received: from ?IPv6:2603:8001:2900:d1ce:f5ec:8788:24db:a0d1? (2603-8001-2900-d1ce-f5ec-8788-24db-a0d1.res6.spectrum.com. [2603:8001:2900:d1ce:f5ec:8788:24db:a0d1])
        by smtp.gmail.com with ESMTPSA id gb9sm3775735pjb.40.2020.12.29.10.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 10:48:41 -0800 (PST)
Subject: Re: How to utilize a PCIE4.0 SSD?
To:     Keith Busch <kbusch@kernel.org>,
        Stefan Lederer <lederers@hs-furtwangen.de>
Cc:     linux-block@vger.kernel.org
References: <eeaa8871-59f5-a56a-f4e5-723c91ac8d5a@hs-furtwangen.de>
 <20201229161941.GA1018362@dhcp-10-100-145-180.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ee5f9acf-4239-cbfc-eb5a-d6ff837b6d94@kernel.dk>
Date:   Tue, 29 Dec 2020 11:48:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229161941.GA1018362@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/29/20 9:19 AM, Keith Busch wrote:
> On Tue, Dec 29, 2020 at 02:40:57PM +0100, Stefan Lederer wrote:
>> Hello dear list,
>>
>> (I hope I do not annoy you as a simple application programmer)
>>
>> for a seminar paper at my university we reproduced the 2009 paper
>> "Pathologies of big data" by Jacobs, where he basically reads a
>> 100GB file sequentially from a HDD with some light processing.
>>
>> We have a PCIE4.0 SSD with up to 7GB/s reading (Samsung 980) but
>> nothing we programmed so far comes even close to that speed (regular
>> read(), mmap() with optional threads, io_uring, multi-process) so we
>> wonder if it is possible at all?
>>
>> According to iostat mmap is the fastest with 4GB/s and a queue depth
>> of ~3. All other approaches do not go beyond 2.5GB/s.
>>
>> Also we get some strange effects like sequential read() with 16KB
>> buffers being faster than one with 16MB and io_uring being alot
>> slower than mmap (all tested on Manjaro with kernel 5.8/5.10 and ext4).
>>
>> So, now we are quite lost and would appreciate a hint into the right
>> direction :)
>>
>> What is neccesary to simply read 100GB of data at 7GB/s?
> 
> Is your device running at gen4 speed? Easiest way to tell with an nvme
> ssd (assuming you're reading from /dev/nvme0n1) is something like:
> 
>  # cat /sys/block/nvme0n1/device/device/current_link_speed
> 
> If it says less than 16GT/s, then it can't read at 7GB/s.

Does sound like that a lot. Simple test here on a gen4 device:

# cat /sys/block/nvme3n1/device/device/current_link_speed
16.0 GT/s PCIe

# ~axboe/git/fio/fio --name=bw --filename=/dev/nvme3n1 --direct=1 --bs=32k --ioengine=io_uring --iodepth=16 --rw=randread --norandommap
[snip]
   READ: bw=6630MiB/s (6952MB/s), 6630MiB/s-6630MiB/s (6952MB/s-6952MB/s), io=36.4GiB (39.1GB), run=5621-5621msec

-- 
Jens Axboe

