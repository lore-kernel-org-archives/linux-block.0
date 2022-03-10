Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323B0C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 15:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245679AbiCJPPm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343551AbiCJPPD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 10:15:03 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BDE3C76
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 07:13:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q14so8504457wrc.4
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7FBVZq7XZGkkS6naSE+C/X1lM8HECCloqW52Bwph84E=;
        b=dCq3C/03AodtzkzSCegCHX1dOnrjDq0XBd8LzgRLcRRKsvC/2dVi49r4+ChmXd8eGl
         PoHvwFODMndGkpetREXYJCPDjXVHFsRTc/NkhxX4Mfeetxxd318LBZ1uZEpjiy5BaD+o
         TIgk6o1YppMf1sk20104O08QNpudMZoB34Xcg0edxDaRbTReaovaT6rzicunLSzXVdRJ
         GHUHhN4KJqGk/mRQnwNgcFPKmcG1onzWChOaJokqRdMktmgZUZPL05vS423woEUrFtfV
         hQf1nj68Qt4I+eDQ5e0bk64lQXxbhqKK8aA2eX+F0oc+/zmB7sJvvVRh+AubjiJ7sSEv
         SCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7FBVZq7XZGkkS6naSE+C/X1lM8HECCloqW52Bwph84E=;
        b=aFotlCe7HVIQ7UQVOdqwikpf/hZwyKv0Hcs9rwDzq7BaSWib0mbdfrs6ifujawx0zg
         6+cjzJl2U/HaaIlAolhlPOS1cmIjzhrPuq9VT6e+OnI37c9PVNIEpB8PuiGmfx/MU7th
         YXzafmYy+3WNjRueadO/wwD/IxgIWkolqCjD8NJk9noQK6OUFzNxAZa4W9BsnvXumvRK
         oUbqtsZdjnGbJgcCKOPUV4mer6BgDdkS6kM+41wtlNEbYRwfDF3fXPvEYlOn8KWaTfrA
         TndzBxSHawg6LtqElchB7N7twfIF4bK+aEIOAKrhfsH8mhmGXH8NvQwKr5saLxNm9Gub
         pPow==
X-Gm-Message-State: AOAM532SvCbKG2YX+Boe/mKrxRaNFzMP0rd4eq3mnUuNc78n5YEO7Bps
        sqsz9Ufq+kLH4t0CkNO4qKwo2w==
X-Google-Smtp-Source: ABdhPJy8MOxGh5/+BpXqOmuq6PF0jdQ0xtmQrMAzJVTofB2a4A2/yWAiEyrdYnRKoCrbTXEHXCKMvA==
X-Received: by 2002:a5d:59ab:0:b0:203:932b:22fd with SMTP id p11-20020a5d59ab000000b00203932b22fdmr369311wrr.108.1646925236491;
        Thu, 10 Mar 2022 07:13:56 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id e18-20020adfdbd2000000b001e4bbbe5b92sm4821957wrj.76.2022.03.10.07.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 07:13:55 -0800 (PST)
Date:   Thu, 10 Mar 2022 16:13:54 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220310151354.qjptzccfunil53l4@ArmHalley.local>
References: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <C2710A6C-340D-4BFC-A8DB-28D456095468@javigon.com>
 <BYAPR04MB49684A8C6FEDA0B999ABCBB2F10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB49684A8C6FEDA0B999ABCBB2F10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10.03.2022 14:58, Matias Bjørling wrote:
> >> Yes, these drives are intended for Linux users that would use the
>> >> zoned block device. Append is supported but holes in the LBA space
>> >> (due to diff in zone cap and zone size) is still a problem for these users.
>> >
>> > With respect to the specific users, what does it break specifically? What are
>> key features are they missing when there's holes?
>>
>> What we hear is that it breaks existing mapping in applications, where the
>> address space is seen as contiguous; with holes it needs to account for the
>> unmapped space. This affects performance and and CPU due to unnecessary
>> splits. This is for both reads and writes.
>>
>> For more details, I guess they will have to jump in and share the parts that
>> they consider is proper to share in the mailing list.
>>
>> I guess we will have more conversations around this as we push the block
>> layer changes after this series.
>
>Ok, so I hear that one issue is I/O splits - If I assume that reads are sequential, zone cap/size between 100MiB and 1GiB, then my gut feeling would tell me its less CPU intensive to split every 100MiB to 1GiB of reads, than it would be to not have power of 2 zones due to the extra per io calculations.
>
>Do I have a faulty assumption about the above, or is there more to it?

I do not have numbers on the number of splits. I can only say that it is
an issue. Then the whole management is apparently also costing some DRAM
for extra mapping, instead of simply doing +1.

The goal for these customers is not having the emulation, so the cost of
the !PO2 path would be 0.

For the existing applications that require a PO2, we have the emulation.
In this case, the cost will only be paid on the devices that implement
!PO2 zones.

Hope this answer the question.
