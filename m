Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE69BC0650F
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 16:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F30721743
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 16:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="auFYz7/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404102AbfHHQNz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:13:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36563 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404099AbfHHQNz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 12:13:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so44302410pgm.3
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fStnaNjXUWAg/OKYuQqYQGZmoa78iOIp6NL7XaIjD7o=;
        b=auFYz7/qJjXjBsfd7bJRpvC8qFOt9Gs6WL3NXJL5ze9wHPiQLSH2j2U6JINaC4h0QH
         vW+vFxGjKJA5bkmPv2pSbbkItFO1zsvsbsIsc0trXG3HPsDy/KHZVdNSmmGiToYosxi6
         lFd8BE+bR9+qRhgcZ4OogK1CuBdcxQ3vCJcEINpgBcyHFU39F9pFLZipbMvh5jReoZCl
         Y11sb3S77Dp+RAwQIDB9QlySFkoNfbAqQLXxulJM4UgRoJVsLPzdXCZ3mb/RBRFY0zhn
         LeBPa7kI2elNeyMf9YgsRv0V8/GZD2mQQA07/BjIRDUlfCfCmGBZsLYx2NOxFyriF5AU
         Rlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fStnaNjXUWAg/OKYuQqYQGZmoa78iOIp6NL7XaIjD7o=;
        b=PFzMxlbTzFAc2QinMitl9PN4Q/oE7YFF3gHwKlK9UAwO/o9UZ5Kv3uRApeL6E4tQQS
         KkB1DjabpLkyO9AedpWe53Pt76DNUmOh5MZs5CC3BpIR+YbiSmjvbsTtpT/RBeMbK0OM
         DKMqf3HBeJrMO23msYTafpMkvycjeecinQxIpxp+Emn/zYSKo5h1fII69cAZhC2mygOy
         D3SpcuYESkR+I4WQjqajTqSsVIzvWX168GDftIjLnxZ+1L2tFe/amfqhK9xK4rKyZNXR
         Ao674fXEOu8+vknC9H3QbJd2pU8UsHWy5hHceqy59mONB0HixWRarWKvkRUCADYybReK
         YBPw==
X-Gm-Message-State: APjAAAVSlKMNCGT0+rbyuckUilh6pIZCX53i7dRgmYLsDHFidkShn/Q5
        4mwwEIGOEYLKzUmOHIYEhNkIM5boyK/40A==
X-Google-Smtp-Source: APXvYqy0OjtSzFmnkkHWxfix7dd2lxQgeI5J415PWHZKmz3KIiP3j+ZeI2fitmOiF4SSqd9uwxVz2w==
X-Received: by 2002:a17:90a:8c18:: with SMTP id a24mr4726741pjo.111.1565280833786;
        Thu, 08 Aug 2019 09:13:53 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:4042:6c37:d29d:2320? ([2605:e000:100e:83a1:4042:6c37:d29d:2320])
        by smtp.gmail.com with ESMTPSA id r27sm113131691pgn.25.2019.08.08.09.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 09:13:53 -0700 (PDT)
Subject: Re: [PATCH liburing 0/4] spec: rpmlint fixes in preparation for
 Fedora packaging
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>, linux-block@vger.kernel.org
References: <1ecc837f-6177-c0a9-2d29-13efd29faf28@kernel.dk>
 <20190805161411.GA10487@stefanha-x1.localdomain>
 <20190808103254.GA3120@stefanha-x1.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <595efa3b-484a-188a-f867-cf2962cb0bdf@kernel.dk>
Date:   Thu, 8 Aug 2019 09:13:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808103254.GA3120@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/19 3:32 AM, Stefan Hajnoczi wrote:
> On Mon, Aug 05, 2019 at 05:14:11PM +0100, Stefan Hajnoczi wrote:
> 
> Sorry Jens, I had your old email address.  Resent.
> 
>> Hi Jens,
>> I've minimized one of the qemu-iotests failures and it looks like a
>> kernel bug.  io_uring completes a request with EAGAIN on an O_DIRECT
>> file with Linux 5.3-rc1 on XFS + dm-thin + dm-crypt:
>>
>>    $ qemu-img create -f raw t.img 6G
>>    $ qemu-io -f raw -n -i io_uring -c "aio_write 0 1M" -c "aio_write 512 1M" t.img
>>    $ qemu-io -f raw -n -i io_uring -c "aio_write $((1 * 1024 * 1024)) 1M" -c "aio_write $((1 * 1024 * 1024 + 512)) 1M" t.img
>>    Formatting 'tests/qemu-iotests/scratch/t.img', fmt=raw size=6442450944
>>    wrote 1048576/1048576 bytes at offset 0
>>    1 MiB, 1 ops; 00.01 sec (128.598 MiB/sec and 128.5985 ops/sec)
>>    wrote 1048576/1048576 bytes at offset 512
>>    1 MiB, 1 ops; 00.00 sec (201.017 MiB/sec and 201.0169 ops/sec)
>>    aio_write failed: Resource temporarily unavailable
>>    wrote 1048576/1048576 bytes at offset 1049088
>>    1 MiB, 1 ops; 00.00 sec (391.620 MiB/sec and 391.6198 ops/sec)
>>
>> The third write request should not fail with EAGAIN ("Resource
>> temporarily available").  I think device-mapper is returning EAGAIN at
>> some point but I haven't gotten to the bottom of this yet.
>>
>> Interestingly it only happens when qemu-img create is run before the
>> test to create a new file.  Rerun qemu-io on an existing raw image file
>> and it succeeds.  This could be because the failing request is XFS a
>> metadata I/O request that only happens when writing the file for the
>> first time.

It's due to how XFS handles (or doesn't handle) REQ_NOWAIT. I've got
a patch for this that needs some testing, but I probably won't get to
this until Monday, currently out on vacation until Sunday.

-- 
Jens Axboe

