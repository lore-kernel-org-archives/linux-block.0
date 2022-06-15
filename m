Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53309C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 19:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbiFOTij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349710AbiFOTi2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 15:38:28 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BA85469F
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 12:38:28 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id e11so12335915pfj.5
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 12:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I7zieuqY8NGNDCuWBUBJcL+bJu4eb/wBIOaRWuYTBCE=;
        b=SsLRValO+qIVV9el8MODbw3Ojy0mdETybm9ZWP5QreDvjRPDGMNG+N0RZeT4xaKdqD
         FEdve8X1PFlsx7hTe6wGxdDZpwvXVMfTzjn9Wzd1PSg0J7k2TMA1HGyyXZSjnuQ7V+O5
         XXDc7NuByMok9sB/1eso8auYJu9MGQvV+6mUtKzXCFWBatslfhGyhhbvIvS8o1S7FxlU
         L8cM2v1Mj1A4veD672Nw4YlJw/65/SQQsaFx1KBZbSp6vdLvaW437qoi8qYlX5XXgojm
         zu/5ivFPCeFwPq1Dbwt0ULQz5S1yjgmPsnLnrtt3G+bOtwhXXDmtEToYqFe7e1khag0i
         sPPw==
X-Gm-Message-State: AJIora/jIPOogox7WH6BaV0AZLkz9mLf0vLiRSt+rn8I94KUidwDqNLM
        c5aCVmaDKFGD0W5rIvvEYPA=
X-Google-Smtp-Source: AGRyM1siQ91HBfxDlFL0TZvv8LKKeDMB6DWovoxeAMfXFvZBqpQzVNcQqOVQedCnW2SBMsOH2LVmhw==
X-Received: by 2002:a63:6a85:0:b0:3fa:722a:fbdc with SMTP id f127-20020a636a85000000b003fa722afbdcmr1227477pgc.174.1655321907429;
        Wed, 15 Jun 2022 12:38:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:36ac:cabd:84b2:80f6? ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b00518d06efbc8sm11774pfl.98.2022.06.15.12.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 12:38:26 -0700 (PDT)
Message-ID: <6096a273-c88d-3e15-927a-add3071ffbad@acm.org>
Date:   Wed, 15 Jun 2022 12:38:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-3-bvanassche@acm.org>
 <399e595b-06d2-ceb1-1b42-2a98a7724320@opensource.wdc.com>
 <29a13708-56b1-60e8-558a-ec4a469eaa6d@acm.org>
 <20220615054909.GA22044@lst.de>
 <434cb0ae-a6e7-62a0-81dc-cd86f55108d4@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <434cb0ae-a6e7-62a0-81dc-cd86f55108d4@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/22 00:21, Damien Le Moal wrote:
> On 6/15/22 14:49, Christoph Hellwig wrote:
>> On Tue, Jun 14, 2022 at 04:56:52PM -0700, Bart Van Assche wrote:
>>> The performance penalty of zone locking is not acceptable for our use case.
>>> Does this mean that zone locking needs to be preserved for AHCI but not for
>>> UFS?
>>
>> It means you use case needs to use zone append, and we need to make sure
>> it is added to SCSI assuming your are on SCSI based on your other comments.
> 
> For scsi, we already have the zone append emulation in the sd driver which
> issues regular writes together with taking the zone lock. So UFS has zone
> append, not as a native command though. But if for UFS device there are no
> issue of command reordering underneath sd, then the zone append emulation
> can be done without taking the zone write lock, which would result in the
> same performance as what a native zone append command would give.
> 
> At least for the short term, that could be a good solution until native
> zone append is added to zbc specs. That last part may face a lot of
> pushback because of the difficulty of having that same command on ATA side.

Is there more information available about the difficulties of defining a 
ZONE APPEND command for ATA? It seems to me that there is enough space 
available in the ATA Status Return Descriptor to report the LBA back to 
the host?

Thanks,

Bart.
