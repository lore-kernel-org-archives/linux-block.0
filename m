Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B8C4332F
	for <linux-block@archiver.kernel.org>; Fri, 30 Sep 2022 15:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiI3POQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 11:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiI3POK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 11:14:10 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6BE129FE6
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 08:14:03 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d8so3490007iof.11
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JfR2GfqXfwHVRcahJmnUzB1Y/QLxN5cyd7oQednba7g=;
        b=P9WWNQtWlB5f/IfBNtwL4w5+xcZ6cZI0BVKiGfdweWgPvQHQEQESV3CnmEnXNXiU+U
         vp+xXcUEit+8B9sj9Hh6xdpeXWF+P6xAL/QS/2JUGxfs6ia29xDNYZN4USoUdbcCO+B3
         2egNXSKAYMBg8zUmbPfKgrHXmfZ2/feemYNI3gL7/71mJEbGW3bABE4qDEBKJe15hThf
         HVTPHWHhvFTL1eubX12elfdIi8vvHFzKCFs9WVn3Pi7pLNPzNL9294YBAquRnqs2KKaO
         rbw92cJxck6GdkD/dmmDOaLcK+VZcLXWLOXJkaiGGcX4OCwgWbbSrC/fLR/t5al86cv8
         Syyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JfR2GfqXfwHVRcahJmnUzB1Y/QLxN5cyd7oQednba7g=;
        b=6gviPYT+bNgjXIjfIS1TtSDGbpE9RBWYMRGbjRYfSol5sgKc2r0kH/Rf1oSTEY5q3x
         WCPS8d2W94kZah/ZW1GiNVCvjdI4gASva6yR5+02MAdcMwNUxSGtmiipldGz8MMRN7Uw
         tliwTdrtzBpCRSro85O2yagTCrT/dIrAQ878zq+8tFsVPl911x5MLmllTv1F20LbCWsO
         7U4Z+ocyEg7uilGt8aSLZteCBbQV5rOwpRa4veSxfFPR9DqBCDUg2Pnu2NazhVfSvNzU
         ucitRWzf+BGmNsxAmFp5cq8e+wqDiMyNL/r2JnDORw+Xc+/Ap25GT46egKB94iSgTFaa
         IFSQ==
X-Gm-Message-State: ACrzQf0GFPsnwwT+NKbdDAkxPX2QDhdg2ECUtAHGV+a1x6apYcrMfR7Y
        eczkoTo6IRakgO3F5PmSypUwGw==
X-Google-Smtp-Source: AMsMyM56qoijmhJXnYPF8kxaWuSK3ez2mfK6ZmVjsiLUqUdOlYO1SRhJq4es+Rf++wuS3uh8BhpzXw==
X-Received: by 2002:a6b:b80a:0:b0:6a4:949:4681 with SMTP id i10-20020a6bb80a000000b006a409494681mr4032792iof.96.1664550843041;
        Fri, 30 Sep 2022 08:14:03 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t2-20020a056e02060200b002eae6cf8898sm1052303ils.30.2022.09.30.08.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 08:14:02 -0700 (PDT)
Message-ID: <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
Date:   Fri, 30 Sep 2022 09:13:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        Keith Busch <kbusch@kernel.org>
Cc:     jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
        snitzer@kernel.org, damien.lemoal@opensource.wdc.com,
        bvanassche@acm.org, linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/29/22 12:31 AM, Pankaj Raghav wrote:
>> Hi Jens,
>>   Please consider this patch series for the 6.1 release.
>>
> 
> Hi Jens, Christoph, and Keith,
>  All the patches have a Reviewed-by tag at this point. Can we queue this up
> for 6.1?

It's getting pretty late for 6.1 and I'd really like to have both Christoph
and Martin sign off on these changes.

-- 
Jens Axboe


