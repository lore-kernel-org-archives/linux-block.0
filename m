Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECDCC04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 01:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiG1Bwa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 21:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiG1Bw3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 21:52:29 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1CC51A39
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 18:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658973148; x=1690509148;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QVVBWQ6JmTLGyCI9T6RhLFvgwT91qI0IoKUt3pFI0/Q=;
  b=Rwl66SrgMP6HOgCh7Xe/naGLUdOFB1+qkvjJQgy2mAVsyuctgycRQwQw
   ALqsbvNAhxAGGPIc9X6ag63+BuNKlPut7zlNafk4BxQuclu30HiJWBVo9
   Q4F5JNE0WIVsfg6p8Hho+NAvEr+rcdTpBacHtshLpDP5jJkmCcsTJ9Uym
   qmkjh6AbsKvaCckEDAvFJBp+bmrhTe+jImX1LI9Ux8NU2pMq4nEXZQbUQ
   216WSUMcSJ7YuPOMx58TrSQGUNr5Zmwc6AmxMF5+Lo8OwgSjIJe1wwkEM
   4N2lqR9R+QmeXYM2r4rJBDkamnXQqmCNbNY3/3SLZ0KAN60M0a+E/BbaZ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="319193626"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 09:52:27 +0800
IronPort-SDR: 4mdY772RK7kqCzI0nBfkuPFKxQeOC1cINF5Pegh1AF1vWq6S/LZtI6myhj/JNnnhaF2zZvAU02
 3/y8Ip8isPX44aUWdinbrahggFF7E9ho5mTFCuCOsxI+wOe0su7+5dxKQohayalXO3A9cuU3zE
 fInV1whOY4IjDn5AiusMCnmGqScdxxbLVFAw0hPAjCbTb1lI6slbobyDJ4QFhv82SX/04fONJ7
 eI5sxfrXq8bJoU8QZUicGKi2XL1UdSEISfsy0E7b2tKSraRarYeMGzk/2qR/rFzuM6hJr0PL/1
 St9dzIw3e335mSBQf2emiv2Z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 18:13:39 -0700
IronPort-SDR: pJdC0vZr8nI49MiONfrcKh0U7iiBiOcdfq42O/mQ3aEzyPB8wHAVh0df8QxmzaIBkf5DEvG9qF
 0kVNc66Ma/iRK82D5F1wioQt3815/4FQ3NYLcVhN+r38RLmN28IFo0xjkA9in3WCynlP5YvlxM
 O6oSw8D9kw5BcFXYCkOdnaEwkChDyqAcZUgttUu2XEN6IQZ6BfOZ83nDRMBbD0E90cTsOA5zOj
 xjwr14ghHQhLewDISZL72x99AGEJ3f+7sWhIAB41eUCLT5RcDWoNVnycc7vPsYeE/UISagDXP0
 AZQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 18:52:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtYYl37NLz1Rws0
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 18:52:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658973146; x=1661565147; bh=QVVBWQ6JmTLGyCI9T6RhLFvgwT91qI0IoKU
        t3pFI0/Q=; b=F2iFvoSMiJbccMADjVAZVn3gxWlhNSCpud0qSERpSOd0Ry5Xo6F
        81dY6m6tBCK2oCJXK4dOrRJS7yNisxUJtbfIfLOGG7EjrS5D/amN0FY+Hzj45R+L
        Oe5u5/l77XqslEMw0POtUwr7nVVYFzCyx/bcl3ycltBiovl0G1yxk50QbnjCapjx
        VG/XkGyfKk+WK613YwwwKpQXFZn+ty9vLUAVcqOYeXLtobUoJcygQwMnnLylXPYx
        RhXfOrxRLu3TdBEledwgd0z/EubL2m3Y60eLOH+lQW5gcXeEwhv7WiaAVoRGRAzO
        KZB8F0gXFZOk2ZhFee8Ub4lkhrskmA2GbIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FBVBa80bOHoC for <linux-block@vger.kernel.org>;
        Wed, 27 Jul 2022 18:52:26 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtYYh12zFz1RtVk;
        Wed, 27 Jul 2022 18:52:23 -0700 (PDT)
Message-ID: <f2f29f97-5994-37f9-c922-31158c1c1b9a@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 10:52:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/11] support non power of 2 zoned device
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        axboe@kernel.dk, snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org
References: <CGME20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754@eucas1p1.samsung.com>
 <20220727162245.209794-1-p.raghav@samsung.com>
 <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/22 08:19, Bart Van Assche wrote:
> On 7/27/22 09:22, Pankaj Raghav wrote:
>> This series adds support to npo2 zoned devices in the block and nvme
>> layer and a new **dm target** is added: dm-po2z-target. This new
>> target will be initially used for filesystems such as btrfs and
>> f2fs that does not have native npo2 zone support.
> 
> Should any SCSI changes be included in this patch series? From sd_zbc.c:
> 
> 	if (!is_power_of_2(zone_blocks)) {
> 		sd_printk(KERN_ERR, sdkp,
> 			  "Zone size %llu is not a power of two.\n",
> 			  zone_blocks);
> 		return -EINVAL;
> 	}

There are no non-power of 2 SMR drives on the market and no plans to have
any as far as I know. Users want power of 2 zone size. So I think it is
better to leave sd_zbc & scsi_debug as is for now.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
