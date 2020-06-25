Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA6DC433DF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 13:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D178B20672
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 13:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="xl82oj18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404812AbgFYNEc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404709AbgFYNEc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 09:04:32 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AA6C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 06:04:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg28so4141347edb.3
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LXs+TzGY6PPMha6FRa+oZWEDxK46Uyk5PsHPv06NVpI=;
        b=xl82oj18jf62fmDoTChkZ8YmO7nenU7bhbYS/vO1c47CEVNQ45TAh4UIhcIAgqSNMG
         oYK2MWos6eUYqvWP8hPKTEeFbRS+uGq4b4FOCiEMGWEOV+j6no3uKy5Dc9+6QFwnIo1j
         CTN3aUPkrk9/+7FBZuyxK7qGMVpNVw+5p6LanglGWydIoqKMXjBMc95aj3nRP5YEBU/Y
         N+8kKLKCgmcXRO6B6NZ4VnyqLTfa2p58VFW4tVRvSZM4bkRwDsiEidN41y3pwNES3xwX
         TkQbmEVukYQo2ISUD52eCgjaqnvttzH06ojE4NVoJw3S+np+fXClb00jnvy6QOJfurSL
         RbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LXs+TzGY6PPMha6FRa+oZWEDxK46Uyk5PsHPv06NVpI=;
        b=MDFnJlPrZyRq51j8IvzKOij4UAOs0ia3thVrDJ4DM1CqvDHwlGC6HsQgow/bywZv6J
         LxYe8WGZPe03arZ7Y3D0Vus/XHq8SauZPaQICtz5I4E9WeA56ndSn54OxBlctFbLjEZr
         n3SvsbK/7TUfl19PoybZIlk90NgXd8FgEFVVFHy2abDnJbBeq4PKJmZ/EFobOvzSTmiH
         syq+hnn4tZ+vXeycrDLp/CHn8b8/ktFKIk1rib/Nh1uvw+ngxX51X0Jpn/E6965XE3at
         vsYnSv9jZwuEPBfNWF4ihGSxbGowqEJ2EJT31LiC0R9mVuVyddr8I+QFd1QFxpZ710kb
         pZZQ==
X-Gm-Message-State: AOAM532jMqMb+TYsvOgRD58tGPflXEToLPmF7lKXWlWMAJmke5Tmuftw
        udOe/30a/KPbaKNJInZcOVu1KTaF4yQ=
X-Google-Smtp-Source: ABdhPJwdStNd66XgsiZUp82JpCb2P6cjIylVEwAd7Diy4jK0ziWtYFEzFSu8MAvL2oHFqJRV0wPq4Q==
X-Received: by 2002:a50:d78f:: with SMTP id w15mr32998851edi.245.1593090270288;
        Thu, 25 Jun 2020 06:04:30 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id bc23sm734494edb.90.2020.06.25.06.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:04:29 -0700 (PDT)
Subject: Re: [PATCH 0/6] ZNS: Extra features for current patches
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>
References: <20200625122152.17359-1-javier@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
Date:   Thu, 25 Jun 2020 15:04:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625122152.17359-1-javier@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/06/2020 14.21, Javier González wrote:
> From: Javier González <javier.gonz@samsung.com>
>
> This patchset extends zoned device functionality on top of the existing
> v3 ZNS patchset that Keith sent last week.
>
> Patches 1-5 are zoned block interface and IOCTL additions to expose ZNS
> values to user-space. One major change is the addition of a new zone
> management IOCTL that allows to extend zone management commands with
> flags. I recall a conversation in the mailing list from early this year
> where a similar approach was proposed by Matias, but never made it
> upstream. We extended the IOCTL here to align with the comments in that
> thread. Here, we are happy to get sign-offs by anyone that contributed
> to the thread - just comment here or on the patch.

The original patchset is available here: https://lkml.org/lkml/2019/6/21/419

We wanted to wait posting our updated patches until the base patches 
were upstream. I guess the cat is out of the bag. :)

For the open/finish/reset patch, you'll want to take a look at the 
original patchset, and apply the feedback from that thread to your 
patch. Please also consider the users of these operations, e.g., dm, 
scsi, null_blk, etc. The original patchset has patches for that.





>
> Patch 6 is nvme-only and adds an extra check to the ZNS report code to
> ensure consistency on the zone count.
>
> The patches apply on top of Jens' block-5.8 + Keith's V3 ZNS patches.
>
> Thanks,
> Javier
>
> Javier González (6):
>    block: introduce IOCTL for zone mgmt
>    block: add support for selecting all zones
>    block: add support for zone offline transition
>    block: introduce IOCTL to report dev properties
>    block: add zone attr. to zone mgmt IOCTL struct
>    nvme: Add consistency check for zone count
>
>   block/blk-core.c              |   2 +
>   block/blk-zoned.c             | 108 +++++++++++++++++++++++++++++++++-
>   block/ioctl.c                 |   4 ++
>   drivers/nvme/host/core.c      |   5 ++
>   drivers/nvme/host/nvme.h      |  11 ++++
>   drivers/nvme/host/zns.c       |  69 ++++++++++++++++++++++
>   include/linux/blk_types.h     |   6 +-
>   include/linux/blkdev.h        |  19 +++++-
>   include/uapi/linux/blkzoned.h |  69 +++++++++++++++++++++-
>   9 files changed, 289 insertions(+), 4 deletions(-)
>

