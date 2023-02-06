Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B77BC636D3
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 18:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBFSb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 13:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjBFSb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 13:31:26 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6A7244B0
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 10:31:26 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so12214876pjb.5
        for <linux-block@vger.kernel.org>; Mon, 06 Feb 2023 10:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wygvp9D47oFgpWWmCEw7cu3PHNH8Lh9kY/5fECkPL2c=;
        b=O2ECBpRZOeQhG55MhR4LYFeaXtCqsvqPfh2wsXVwDaaJzNAyvA5PIM63EEf/c2Dxhx
         TwzDjJIOjaqGkpt1iQ1DAza+ihUa72uE5QHKfNXn4mf95bh6zrAzw3NV+IJvPOj9NSV1
         5E7wKN3VxMdCjs10eVxMJL5jB9c6aBRunZVGEOdkGasp//3c0YqewneCAyWYU5s+G6T4
         AAz8R4TXO9qS80HLTrddVroCC5u0JS9N5BDwDCC1FDVAoKj7FpckWKa724SEdBZM0UFS
         7oMgTfmemg/AmHuUwU7+XMWBTk+umm/nhSFS00RgxMQBH+ktJNLu2993sb4IcCCX0Uzy
         z8Kg==
X-Gm-Message-State: AO0yUKWsVSocCW+cbxwoUrV+24TAELRR082ruP1q8bqsgci+j1f+2xKF
        yZChUIRYhUZDKDl4cXz1YMQ=
X-Google-Smtp-Source: AK7set96Qed7ZrpEf1hPtauKUG01f9TPZmu96WT5STYxNh7yyU0cWqxS+RIdrqIqgh0RmPhYED+u1w==
X-Received: by 2002:a05:6a21:3813:b0:b8:ca86:d1e8 with SMTP id yi19-20020a056a21381300b000b8ca86d1e8mr105534pzb.14.1675708285370;
        Mon, 06 Feb 2023 10:31:25 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:546b:df58:66df:fe23? ([2620:15c:211:201:546b:df58:66df:fe23])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709026b8100b00194d2f14ef0sm7180615plk.23.2023.02.06.10.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 10:31:24 -0800 (PST)
Message-ID: <a25e02a6-4f79-da85-bf35-427b7a523aec@acm.org>
Date:   Mon, 6 Feb 2023 10:31:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
Content-Language: en-US
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        =?UTF-8?Q?J=c3=b8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        "andreas@metaspace.dk" <andreas@metaspace.dk>,
        "javier@javigon.com" <javier@javigon.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "hch@lst.de" <hch@lst.de>
References: <20230206100019.GA6704@gsv> <Y+D3Sy8v3taelXvF@T590>
 <BN8PR04MB6417488E54789C123E6EAA4AF1DA9@BN8PR04MB6417.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <BN8PR04MB6417488E54789C123E6EAA4AF1DA9@BN8PR04MB6417.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/23 06:34, Matias Bjørling wrote:
>> Maybe it is one beginning for generic open-source userspace SSD
>> FTL, which could be useful for people curious in SSD internal. I
>> have google several times for such toolkit to see if it can be
>> ported to UBLK easily. SSD simulator isn't great, which isn't disk
>> and can't handle real data & workloads. With such project, SSD
>> simulator could be less useful, IMO.
>> 
> 
> Another possible avenue could be the FTL module that's part of SPDK.
> It might be worth checking out as well. It has been battletested for
> a couple of years and is used in production
> (https://www.youtube.com/watch?v=qeNBSjGq0dA).
> 
> The module itself could be extracted from SPDK into its own, or
> SPDK's ublk extension could be used to instantiate it. In any case, I
> think it could provide a solid foundation for a host-side FTL
> implementation.

Thanks Matias for the link. I had not yet heard about this project. 
Although I have not yet had the time to watch the video, on 
https://spdk.io/doc/ftl.html I found the following: "The Flash 
Translation Layer library provides efficient 4K block device access on 
top of devices with >4K write unit size (eg. raid5f bdev) or devices 
with large indirection units (some capacity-focused NAND drives), which 
don't handle 4K writes well. It handles the logical to physical address 
mapping and manages the garbage collection process." To me that sounds 
like an effort that has very similar goals as ZNS and ZBC? Does the 
following advice apply to that project: "Don't stack your log on my 
log"? (Yang, Jingpei, Ned Plasson, Greg Gillis, Nisha Talagala, and 
Swaminathan Sundararaman. "Don’t stack your log on my log." In 2nd 
Workshop on Interactions of NVM/Flash with Operating Systems and 
Workloads ({INFLOW} 14). 2014.)

Thanks,

Bart.
