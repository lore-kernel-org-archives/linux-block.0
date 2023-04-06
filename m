Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA507C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 20:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbjDFUfz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 16:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239710AbjDFUfT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 16:35:19 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27938CA0E
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 13:32:59 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so41840729pjb.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 13:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813178; x=1683405178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUSlRouRUPwDgt4ablxw0d3WPEUntxqcZMTlBUnQHB4=;
        b=Xz5wJ0aRFe1xNWD/exNXn1YcAnLaOGcEmzrdJ55oNpV2nctrKUDJC0bsxrwx5uo2ke
         TrFjpZqi8Skx6QZyl1757Uo4BFeHrU8Bvbi23UcV3wGTDNITFHobtp/S7/XwCn4xIpDz
         EGVLaucnhW+8Cn01zGH8aiS7+A1M0E7flAnNDGCuq0u0opj57ujpvlaaUxGG/is0D48r
         gChOipGbV/AGmuL7xsNDZKQeBxx3BK07CHkBaQuVcOn/S83XH3znk2LKGyvgYp3a4ZGs
         FaH0rHudVbvIncPa1KMPEU1ygvBlH5cMBirMTSZxtbPr3NW2HEbKg/3eBIyM8/LSjlXk
         FhEw==
X-Gm-Message-State: AAQBX9cHAs0oW5hUE1wiT6aI85/44JrP92Sq/zZUY/x1z1PGTe4aA3Nj
        kGpzsj/F5Pz5JYXfZNoBwicM2VbuTvg=
X-Google-Smtp-Source: AKy350aNbGkqDC6z4scKf5qwjYaCPNGQ/t7T4nBq7vuMFMzO2moOIGgcemoNpx+vbsBbVv0pve0ASw==
X-Received: by 2002:a17:90b:1c0e:b0:234:889f:c35d with SMTP id oc14-20020a17090b1c0e00b00234889fc35dmr12960528pjb.3.1680813178404;
        Thu, 06 Apr 2023 13:32:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8af7:e62e:d5b6:a90? ([2620:15c:211:201:8af7:e62e:d5b6:a90])
        by smtp.gmail.com with ESMTPSA id d19-20020a170903209300b0019aa4c00ff4sm1740811plc.206.2023.04.06.13.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 13:32:57 -0700 (PDT)
Message-ID: <25f62b62-b73c-fcac-cbe0-03fe90849a24@acm.org>
Date:   Thu, 6 Apr 2023 13:32:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Submit split bios in LBA order
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230318062909.GB24880@lst.de>
 <da0c7538-1a51-61dd-6359-8c618fde6c1b@acm.org>
 <20230323082756.GD21977@lst.de>
 <80988a60-f340-529a-0931-30689599e724@acm.org>
 <20230326234429.GB20017@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230326234429.GB20017@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/23 16:44, Christoph Hellwig wrote:
> On Fri, Mar 24, 2023 at 10:05:48AM -0700, Bart Van Assche wrote:
>> If someone else wants to work on this that would be great. I do not plan to
>> work on this because I do not expect that a SCSI zone append command would
>> be standardized by the time we need it. Although there are references to
>> T10 drafts in the UFS standard, since a few months JEDEC strongly prefers
>> to refer to finalized external standards in its own standards. Hence,
>> standardizing zoned storage for UFS would have to wait until T10 has
>> published a standard that supports a zone append command. INCITS published
>> ZBC-1 in 2016, two years after the first ZBC-1 draft was uploaded to the
>> T10 servers. INCITS approved ZBC-2 this month, six years after the first
>> ZBC-2 draft was uploaded to the T10 servers. Because of the long time it
>> takes to complete new versions of T10 standards we plan not to wait until
>> T10 has standardized a zone append operation.
> 
> Which is why we need to start the work now.  Note that I don't think
> your time frames matter too much - the first draft of zbc2 is where
> people opened up the process again.  The more relevant time frame is
> between getting the main new feature in and publusing, which is way
> shorter.

Hi Christoph,

If you help with the npo2 zone size patch series making progress towards 
being integrated in the upstream kernel I will help with the 
standardization of a write append command in the T10 ZBC standard.

Thanks,

Bart.
