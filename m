Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E92C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 15:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiCJPRg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiCJPRf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 10:17:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB45F5D
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 07:16:30 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id x15so8438396wru.13
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 07:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dRNE1Q3UHcAv6Ct12abpAnXUsUnbwAcbxOzLZWSk128=;
        b=j9fj+0YOsW71ldzLgCBoUAGcbVKjFIK6ZRvCAMZRypA/XSyKwDDMydzdGnTXQtDQHm
         ixEaVK1IyqfaAPq1O6W67jzIO0cFZcmjT6I1DcPxOwvehTFhaw2+Xi2K3NsROy8CjG7W
         qmJ/MmZ43pez3z9Aan/E/w+zMs/qFZ7qKcwpI2d4FWIbg9gjhlTNh0RHndjlsjnyXshr
         PgSaPiYkq+PkTdPGfsTobMqrKnrQ9ky53l/8IHw3KXwaMm6Gz+GWGUHZ6IeqdoOgid69
         TJKWYxq+BFtGjhvCFNLAulrVzMrmTjHwgPgIEGLAQbEEDBRhJ+MiK+p+I+k63ofbzHEA
         W9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dRNE1Q3UHcAv6Ct12abpAnXUsUnbwAcbxOzLZWSk128=;
        b=jgXjYb64Hi6wcRXicy/piI4GAHKuIxdKuYRWeSLD1R52PGViOEpxCXBWRQtnwxYWnQ
         Gc7LaDNW8vu243y3BWkPG8oRNLp2eB5fgAyzCUZTa/Pb+i9LIFttqOi+RgYYvN/kvpSt
         Hbpb+eraAL7NuLiZhpi7jHV/cuqlIPNQ4ooc3etE8TlJpUYqJhLQ7G7TVUyQ9UDX+E1d
         i3aqrMthO8Mx0M7tbWyFbfzgaLfuSxkTb6ap0BICR7xTdkwFG5K+ChO/jgiq+S/no42t
         P3Cal1ut6PQzNRR3f/Xa6CCSFDp7TC4t99VyTe6hE05Z6U9SxUyjeP8CKUFblPPf9l46
         Vnwg==
X-Gm-Message-State: AOAM533TN0j/NFP1MjmNgmurdHqHMCAVib+g2ONwkRN+49w3R0TVnR4p
        BBn3Q57movfyfPypvQKC0eWU0Q==
X-Google-Smtp-Source: ABdhPJzUi+LPZUiXwebXV78bx1zgz6gydw/BcJqlaUAKuEgMiIAzEW/wR7qbM0cLhgpzF1q28AZJ5Q==
X-Received: by 2002:a05:6000:188e:b0:1f1:f8f0:f75a with SMTP id a14-20020a056000188e00b001f1f8f0f75amr3772099wri.682.1646925389123;
        Thu, 10 Mar 2022 07:16:29 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d64e5000000b00203914f5313sm818592wri.114.2022.03.10.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 07:16:28 -0800 (PST)
Date:   Thu, 10 Mar 2022 16:16:28 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220310151628.awfihyvsjc7hawnz@ArmHalley.local>
References: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <C2710A6C-340D-4BFC-A8DB-28D456095468@javigon.com>
 <BYAPR04MB49684A8C6FEDA0B999ABCBB2F10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220310150730.GA329710@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310150730.GA329710@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10.03.2022 07:07, Keith Busch wrote:
>On Thu, Mar 10, 2022 at 02:58:07PM +0000, Matias Bjørling wrote:
>>  >> Yes, these drives are intended for Linux users that would use the
>> > >> zoned block device. Append is supported but holes in the LBA space
>> > >> (due to diff in zone cap and zone size) is still a problem for these users.
>> > >
>> > > With respect to the specific users, what does it break specifically? What are
>> > key features are they missing when there's holes?
>> >
>> > What we hear is that it breaks existing mapping in applications, where the
>> > address space is seen as contiguous; with holes it needs to account for the
>> > unmapped space. This affects performance and and CPU due to unnecessary
>> > splits. This is for both reads and writes.
>> >
>> > For more details, I guess they will have to jump in and share the parts that
>> > they consider is proper to share in the mailing list.
>> >
>> > I guess we will have more conversations around this as we push the block
>> > layer changes after this series.
>>
>> Ok, so I hear that one issue is I/O splits - If I assume that reads
>> are sequential, zone cap/size between 100MiB and 1GiB, then my gut
>> feeling would tell me its less CPU intensive to split every 100MiB to
>> 1GiB of reads, than it would be to not have power of 2 zones due to
>> the extra per io calculations.
>
>Don't you need to split anyway when spanning two zones to avoid the zone
>boundary error?

If you have size = capacity then you can do a cross-zone read. This is
only a problem when we have gaps.

>Maybe this is a silly idea, but it would be a trivial device-mapper
>to remap the gaps out of the lba range.

One thing we have considered is that as we remove the PO2 constraint
from the block layer is that devices exposing PO2 zone sizes are able to
do the emulation the other way around to support things like this.

A device mapper is also a fine place to put this, but it seems like a
very simple task. Is it worth all the boilerplate code for the device
mapper only for this?
