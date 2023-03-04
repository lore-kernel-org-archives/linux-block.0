Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F91C64EC4
	for <linux-block@archiver.kernel.org>; Sat,  4 Mar 2023 13:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCDNZA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Mar 2023 08:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCDNY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Mar 2023 08:24:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021301114A
        for <linux-block@vger.kernel.org>; Sat,  4 Mar 2023 05:24:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ay14so17145818edb.11
        for <linux-block@vger.kernel.org>; Sat, 04 Mar 2023 05:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112; t=1677936295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1Alr84dTUeXL8BqAnraROnsxhewVG8ff6KdOjLRqpg=;
        b=L0dlnMu/KWMEnv5YdUvbCmjH3VLx+p/cZ9i0/fvQL3OmW7o9yCE3nHNX9ywhWzahXS
         nFV6KeskLXnyOJVPlkpXWLTtict2gCReI0HiH+zjr9cOv2QOe+nN8A//46y5CrNrMW5k
         ZRW12NzlnMJgcPb6przCZdRJTL/Jll5Gfe7D1A3TtySgditjBAhmLd0myF35ed1L3zUI
         Efg5X3eJcaJbw8kuvEJiGf4wBZjTjq0OsUR8lNc0iKl+6+8Fp/EwSZVTH/DiBhNckgrI
         nISy9rAouZcmvLz//BY/7LcBSCOHfq/GoKnnOSXAeg0Y04pstu2uOXx8LbKFDh4agWWt
         s3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677936295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1Alr84dTUeXL8BqAnraROnsxhewVG8ff6KdOjLRqpg=;
        b=svZUvPNCni8fuILACn6VBXg8iIqZ34pDPbHU6131NBlSSHUPWLX/mz7z3V0vRVu6X6
         LMEqOK9jIkK2/PM0g52lqlCvh9Mf0eGVu2UD1/NUzSGUmV7/sX0I3RqqinSITFGzhwzj
         eU8KWHGfOe0T1MA3BL13ENZhmHkskzNMrpWRxaIRk3QCgEWhpMVO0yz6fnAtjnlvRvmk
         oGQdpfavIKTddHizqnubgaLcMlfcoZfcVS8wT/Q4AFmI4bPYn0djS3l+i03WtfgP1ZRx
         BvoqV1wB6CDdHkQ0gxVBjyt5CrbQTN2imlkTULfZVcgrTUg9SPQF4nXnQ17VkEP6ABA8
         TAUQ==
X-Gm-Message-State: AO0yUKW3lRQrbz+vTi2VDbiLp/WDnbwZbz1uUxoTxpGshaeKwqai8LNe
        t1D2mpK0F8c9VTRS69ZqTAmRdA==
X-Google-Smtp-Source: AK7set+wSqK6yZKtTvNhsBuh5Q0PfonJUVZDO9hu6OEg1WcYI82cR21EBudH8wBUk9ldFiwfOQ309w==
X-Received: by 2002:a17:906:99d4:b0:8ed:5aac:6973 with SMTP id s20-20020a17090699d400b008ed5aac6973mr5324415ejn.35.1677936295336;
        Sat, 04 Mar 2023 05:24:55 -0800 (PST)
Received: from localhost (89.239.251.72.dhcp.fibianet.dk. [89.239.251.72])
        by smtp.gmail.com with ESMTPSA id v24-20020a50d598000000b004bfc59042e5sm2417834edi.61.2023.03.04.05.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 05:24:54 -0800 (PST)
Date:   Sat, 4 Mar 2023 14:24:53 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <20230304132453.fy6gu4q64wrs2mxs@mpHalley-2.localdomain>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <CGME20230304110844eucas1p2a5c9168247323d17e90808c8718d9a0f@eucas1p2.samsung.com>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04.03.2023 12:08, Hannes Reinecke wrote:
>On 3/3/23 22:45, Luis Chamberlain wrote:
>>On Fri, Mar 03, 2023 at 03:49:29AM +0000, Matthew Wilcox wrote:
>>>On Thu, Mar 02, 2023 at 06:58:58PM -0700, Keith Busch wrote:
>>>>That said, I was hoping you were going to suggest supporting 16k logical block
>>>>sizes. Not a problem on some arch's, but still problematic when PAGE_SIZE is
>>>>4k. :)
>>>
>>>I was hoping Luis was going to propose a session on LBA size > PAGE_SIZE.
>>>Funnily, while the pressure is coming from the storage vendors, I don't
>>>think there's any work to be done in the storage layers.  It's purely
>>>a FS+MM problem.
>>
>>You'd hope most of it is left to FS + MM, but I'm not yet sure that's
>>quite it yet. Initial experimentation shows just enabling > PAGE_SIZE
>>physical & logical block NVMe devices gets brought down to 512 bytes.
>>That seems odd to say the least. Would changing this be an issue now?
>>
>>I'm gathering there is generic interest in this topic though. So one
>>thing we *could* do is perhaps review lay-of-the-land of interest and
>>break down what we all think are things likely could be done / needed.
>>At the very least we can come out together knowing the unknowns together.
>>
>>I started to think about some of these things a while ago and with the
>>help of Willy I tried to break down some of the items I gathered from him
>>into community OKRs (super informal itemization of goals and sub tasks which
>>would complete such goals) and started trying to take a stab at them
>>with our team, but obviously I think it would be great if we all just
>>divide & and conquer here. So maybe reviewing these and extending them
>>as a community would be good:
>>
>>https://protect2.fireeye.com/v1/url?k=bd8b143b-dcf6fc7c-bd8a9f74-74fe485fff30-e62d6b1f7e2b2236&q=1&e=64cdf12c-742d-4d0b-9870-bfc5c26dba21&u=https%3A%2F%2Fkernelnewbies.org%2FKernelProjects%2Flarge-block-size
>>
>>I'm recently interested in tmpfs so will be taking a stab at higher
>>order page size support there to see what blows up.
>>
>Cool.
>
>>The other stuff like general IOMAP conversion is pretty well known, and
>>we already I think have a proposed session on that. But there is also
>>even smaller fish to fry, like *just* doing a baseline with some
>>filesystems with 4 KiB block size seems in order.
>>
>>Hearing filesystem developer's thoughts on support for larger block
>>size in light of lower order PAGE_SIZE would be good, given one of the
>>odd situations some distributions / teams find themselves in is trying
>>to support larger block sizes but with difficult access to higher
>>PAGE_SIZE systems. Are there ways to simplify this / help us in general?
>>Without it's a bit hard to muck around with some of this in terms of
>>support long term. This also got me thinking about ways to try to replicate
>>larger IO virtual devices a bit better too. While paying a cloud
>>provider to test this is one nice option, it'd be great if I can just do
>>this in house with some hacks too. For virtio-blk-pci at least, for instance,
>>I wondered whether using just the host page cache suffices, or would a 4K
>>page cache on the host modify say a 16 k emualated io controller results
>>significantly? How do we most effectively virtualize 16k controllers
>>in-house?
>>
>>To help with experimenting with large io and NVMe / virtio-blk-pci I
>>recented added support to intantiate tons of large IO devices to kdevops
>>[0], with it it should be easy to reproduce odd issues we may come up
>>with. For instnace it should be possible to subsequently extend the
>>kdevops fstests or blktests automation support with just a few Kconfig files
>>to use some of these largio devices to see what blows up.
>>
>We could implement a (virtual) zoned device, and expose each zone as a
>block. That gives us the required large block characteristics, and
>with
>a bit of luck we might be able to dial up to really large block sizes
>like the 256M sizes on current SMR drives.

Why would we want to deal with the overhead of the zoned block device
for a generic large block implementation?

I can see how this is useful for block devices, but it seems to me that
they would be users of this instead.

The idea would be for NVMe devices to report a LBA format with a LBA
size > 4KB.

Am I missing something?

>ublk might be a good starting point.

Similarly, I would see ublk as a user of this support, where the
underlying device is > 4KB.
