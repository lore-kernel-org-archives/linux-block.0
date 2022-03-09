Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB241C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 16:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiCIQPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiCIQOu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 11:14:50 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9219818BA47
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 08:11:32 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id k25so3255740iok.8
        for <linux-block@vger.kernel.org>; Wed, 09 Mar 2022 08:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b0ahshq8jtP5jj+9bckwpJQeh/J039pxeuDgi8d3ElM=;
        b=J+9CeEdGMtIxLfEwdsBPQBfZHpKJRNrtkrc6rg3RfU+9gOqyqIZk0CX9rXPPGRuOOm
         zfLMsXjB/kLKla13VRnRPnHcZpAvrhVxx5M+vLbfMbjLoCErGbFJNvy1YbCpvT+u85H1
         8BEo7siFBKRhBGpVobGxp108tf5a+wrbUQhSnSOwJKiHxYCS3AFM/4MHfaPjeyJ9DTB1
         HRJQHgPMi8as3060rVp2HgS+PBySBOviTVyn+t4rL5ywwQzUpYy80DiiLQtJJw72Pm+g
         S0xm3DqVr2O4gHEDW6pPtw9ZLIo5gYgXLsgzr3AgHzYlfH7TsE0/X6Nozj67eDVjJHRG
         4Gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b0ahshq8jtP5jj+9bckwpJQeh/J039pxeuDgi8d3ElM=;
        b=k2unuDz6RNCwMR8F+gujubsvBWL7EXvA9XThPJPUhB1qq/O3GD4mwHv4RslRS0J15e
         hwHBNDvl4pbMD6QXSSHwb2d5OBmzjwK0jeSRGJT+erXL3JvRna4SppOSPXDX6v9mYNSz
         Mdlf8eFlRVvk0vnzYwAlaSqdfiR8EzPvfsIschWP3xlyaLaj0wITbSxkYOvA8ayxC8R+
         zpqdE1VCExy+fzAHAQZfEJ0USKadN8SM57TzoItE+u8pKVRGf6tZ3zYMYpEn2V428JxE
         lBW4ELsr84Mf0MGnQJhkX+RtHXJpjSeCBd8AI6XFLClimGDrncsXywO58mz04b1rMy5q
         PnIA==
X-Gm-Message-State: AOAM530lryRM6r3TB15veebvJUT8CvLrqIKBjhqz8zMA60WcasQnqyxa
        wv9D4vY0976wzxXll1zreiA9rg==
X-Google-Smtp-Source: ABdhPJyuCEx9TJ1HTABAFYwxnOLexkyNmpi/HFpX2Qu5vQVfApcXiGSfeOYFYppShGJ7MJwiEtcIJw==
X-Received: by 2002:a05:6602:2b0b:b0:60f:6c6f:d114 with SMTP id p11-20020a0566022b0b00b0060f6c6fd114mr305470iov.157.1646842287961;
        Wed, 09 Mar 2022 08:11:27 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p192-20020a6b8dc9000000b006412ce609edsm1187083iod.25.2022.03.09.08.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 08:11:27 -0800 (PST)
Message-ID: <d4657e24-4cc7-7372-bafe-d6c9c8005c6b@kernel.dk>
Date:   Wed, 9 Mar 2022 09:11:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 2/2] dm: support bio polling
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220307185303.71201-1-snitzer@redhat.com>
 <20220307185303.71201-3-snitzer@redhat.com>
 <eac88ad5-3274-389b-9d18-9b6aa16fcb98@kernel.dk> <Yif/Or0s1rV87a5R@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yif/Or0s1rV87a5R@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/22 6:13 PM, Ming Lei wrote:
> On Tue, Mar 08, 2022 at 06:02:50PM -0700, Jens Axboe wrote:
>> On 3/7/22 11:53 AM, Mike Snitzer wrote:
>>> From: Ming Lei <ming.lei@redhat.com>
>>>
>>> Support bio(REQ_POLLED) polling in the following approach:
>>>
>>> 1) only support io polling on normal READ/WRITE, and other abnormal IOs
>>> still fallback to IRQ mode, so the target io is exactly inside the dm
>>> io.
>>>
>>> 2) hold one refcnt on io->io_count after submitting this dm bio with
>>> REQ_POLLED
>>>
>>> 3) support dm native bio splitting, any dm io instance associated with
>>> current bio will be added into one list which head is bio->bi_private
>>> which will be recovered before ending this bio
>>>
>>> 4) implement .poll_bio() callback, call bio_poll() on the single target
>>> bio inside the dm io which is retrieved via bio->bi_bio_drv_data; call
>>> dm_io_dec_pending() after the target io is done in .poll_bio()
>>>
>>> 5) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
>>> which is based on Jeffle's previous patch.
>>
>> It's not the prettiest thing in the world with the overlay on bi_private,
>> but at least it's nicely documented now.
>>
>> I would encourage you to actually test this on fast storage, should make
>> a nice difference. I can run this on a gen2 optane, it's 10x the IOPS
>> of what it was tested on and should help better highlight where it
>> makes a difference.
>>
>> If either of you would like that, then send me a fool proof recipe for
>> what should be setup so I have a poll capable dm device.
> 
> Follows steps for setup dm stripe over two nvmes, then run io_uring on
> the dm stripe dev.

Thanks! Much easier when I don't have to figure it out... Setup:

CPU: 12900K
Drives: 2x P5800X gen2 optane (~5M IOPS each at 512b)

Baseline kernel:

sudo taskset -c 10 t/io_uring -d128 -b512 -s31 -c16 -p1 -F1 -B1 -n1 -R1 -X1 /dev/dm-0
Added file /dev/dm-0 (submitter 0)
polled=1, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
submitter=0, tid=1004
IOPS=2794K, BW=1364MiB/s, IOS/call=31/30, inflight=(124)
IOPS=2793K, BW=1363MiB/s, IOS/call=31/31, inflight=(62)
IOPS=2789K, BW=1362MiB/s, IOS/call=31/30, inflight=(124)
IOPS=2779K, BW=1357MiB/s, IOS/call=31/31, inflight=(124)
IOPS=2780K, BW=1357MiB/s, IOS/call=31/31, inflight=(62)
IOPS=2779K, BW=1357MiB/s, IOS/call=31/31, inflight=(62)
^CExiting on signal
Maximum IOPS=2794K

generating about 500K ints/sec, and using 4k blocks:

sudo taskset -c 10 t/io_uring -d128 -b4096 -s31 -c16 -p1 -F1 -B1 -n1 -R1 -X1 /dev/dm-0
Added file /dev/dm-0 (submitter 0)
polled=1, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
submitter=0, tid=967
IOPS=1683K, BW=6575MiB/s, IOS/call=24/24, inflight=(93)
IOPS=1685K, BW=6584MiB/s, IOS/call=24/24, inflight=(124)
IOPS=1686K, BW=6588MiB/s, IOS/call=24/24, inflight=(124)
IOPS=1684K, BW=6581MiB/s, IOS/call=24/24, inflight=(93)
IOPS=1686K, BW=6589MiB/s, IOS/call=24/24, inflight=(124)
IOPS=1687K, BW=6593MiB/s, IOS/call=24/24, inflight=(128)
IOPS=1687K, BW=6590MiB/s, IOS/call=24/24, inflight=(93)
^CExiting on signal
Maximum IOPS=1687K

which ends up being bw limited for me, because the devices aren't linked
gen4. That's about 1.4M ints/sec.

With the patched kernel, same test:

sudo taskset -c 10 t/io_uring -d128 -b512 -s31 -c16 -p1 -F1 -B1 -n1 -R1 -X1 /dev/dm-0
Added file /dev/dm-0 (submitter 0)
polled=1, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
submitter=0, tid=989
IOPS=4151K, BW=2026MiB/s, IOS/call=16/15, inflight=(128)
IOPS=4159K, BW=2031MiB/s, IOS/call=15/15, inflight=(128)
IOPS=4193K, BW=2047MiB/s, IOS/call=15/15, inflight=(128)
IOPS=4191K, BW=2046MiB/s, IOS/call=15/15, inflight=(128)
IOPS=4202K, BW=2052MiB/s, IOS/call=15/15, inflight=(128)
^CExiting on signal
Maximum IOPS=4202K

with basically zero interrupts, and 4k:

sudo taskset -c 10 t/io_uring -d128 -b4096 -s31 -c16 -p1 -F1 -B1 -n1 -R1 -X1 /dev/dm-0
Added file /dev/dm-0 (submitter 0)
polled=1, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
submitter=0, tid=1015
IOPS=1706K, BW=6666MiB/s, IOS/call=15/15, inflight=(128)
IOPS=1704K, BW=6658MiB/s, IOS/call=15/15, inflight=(128)
IOPS=1704K, BW=6658MiB/s, IOS/call=15/15, inflight=(128)
IOPS=1704K, BW=6658MiB/s, IOS/call=15/15, inflight=(128)
IOPS=1704K, BW=6658MiB/s, IOS/call=15/15, inflight=(128)
^CExiting on signal
Maximum IOPS=1706K

again with basically zero interrupts.

That's about a 50% improvement for polled IO. This is using 2 gen2
optanes, which are good for ~5M IOPS each. Using two threads on a single
core, baseline kernel:

sudo taskset -c 10,11 t/io_uring -d128 -b512 -s31 -c16 -p1 -F1 -B1 -n2 -R1 -X1 /dev/dm-0
Added file /dev/dm-0 (submitter 0)
Added file /dev/dm-0 (submitter 1)
polled=1, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
submitter=0, tid=1081
submitter=1, tid=1082
IOPS=3515K, BW=1716MiB/s, IOS/call=31/30, inflight=(124 62)
IOPS=3515K, BW=1716MiB/s, IOS/call=31/31, inflight=(62 124)
IOPS=3517K, BW=1717MiB/s, IOS/call=30/30, inflight=(113 124)
IOPS=3517K, BW=1717MiB/s, IOS/call=31/31, inflight=(62 62)
^CExiting on signal
Maximum IOPS=3517K

and patched:

udo taskset -c 10,11 t/io_uring -d128 -b512 -s31 -c16 -p1 -F1 -B1 -n2 -R1 -X1 /dev/dm-0
Added file /dev/dm-0 (submitter 0)
Added file /dev/dm-0 (submitter 1)
polled=1, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
submitter=0, tid=949
submitter=1, tid=950
IOPS=4988K, BW=2435MiB/s, IOS/call=15/15, inflight=(128 128)
IOPS=4985K, BW=2434MiB/s, IOS/call=15/15, inflight=(128 128)
IOPS=4970K, BW=2426MiB/s, IOS/call=15/15, inflight=(128 128)
IOPS=4985K, BW=2434MiB/s, IOS/call=15/15, inflight=(128 128)
^CExiting on signal
Maximum IOPS=4988K

which is about a 42% improvement in IOPS.

-- 
Jens Axboe

