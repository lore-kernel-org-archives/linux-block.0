Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92271C433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 13:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F5E20739
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 13:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="vH+q5JDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgFPNcp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgFPNco (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 09:32:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F86EC061573
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 06:32:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so2918963wmj.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4m4ZglLowNs+DurcayIT6i2YoXzBpAduaR/DP9cXci4=;
        b=vH+q5JDhSpxI5oEDTF6difbUyWVMNTERRodyEIyQOlG4tYGCwkYBCdxqZSGUimd2RD
         CeYHPbqccvp1AZiTHYIhkSeJx3mUU79x323gNW9LicxI+sY97lduyT1mNho/1LQ0Y5Fe
         LFaSVH+FXoA/uOVC6+sK8dRLkRDWXuLG2uWWYiak1NdiwKq283ETdATtPsH0Ve2LIB+T
         f7Gu+vveLEid6ze91b/yxhwoSo6dQBgE70kx83r1FA1lmcgYf8TXh1wwruCEyhmHaNUq
         pRMXq4fdRA9o06Z0S4wUAaaGmLCRUA/v866ox6ORLcdd/h1Wp5srZi5UtXcb+D+Dk3+H
         uDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4m4ZglLowNs+DurcayIT6i2YoXzBpAduaR/DP9cXci4=;
        b=sYtGxMB5FAiBm+IeYUvcaAtHt9L11d3rdm675+UmlWW/QcKf/Hv+/HbxFCIs3Ki8Se
         JLPDVyWCyyvqoyQaJewVBKB8VW6S5Yc9w/v3k8xksENT9P61Aec02Uwv3ePiQ9CjMjWq
         0KA9tAnHpwXiXzLOe+UDqv/F5Vx9WA5s2RBKfljP6+A5J+X8U3Xj2Idhy8KEohuv7oGg
         0VlkOjO6DeGqxGe7EWIhk0wBTr2Vs8s7B7FL41BVvcEWkp5l4vDhZkSmpwWvlrXtXxH2
         sg2m8GbG/h5nTArDeU9loLLB4gXvAaLeQahU+hE/zeBcrz+4852EmqE/O0OouYsUE6hR
         Hc+Q==
X-Gm-Message-State: AOAM531Ggc6V6R7gUCFgF2va1+uDVU9vhT5WWoFj9Sv3v2xyUCb8f05z
        jnkQ5LPXIyPsHOmCagBx5OYvIYJAGho=
X-Google-Smtp-Source: ABdhPJxwKk5tExHQjvgJMI+SahwLq2Ic4Plenkek8H4YyWO+oHnleTZ4lpkV5PiCDxo5ztEgkQAw0g==
X-Received: by 2002:a7b:c343:: with SMTP id l3mr3285858wmj.178.1592314363077;
        Tue, 16 Jun 2020 06:32:43 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id b81sm4345365wmc.5.2020.06.16.06.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 06:32:42 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     Judy Brock <judy.brock@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <Keith.Busch@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CGME20200616130815uscas1p1be34e5fceaa548eac31fb30790a689d4@uscas1p1.samsung.com>
 <4a97bb114ece452c80f08b96d6cbc11d@samsung.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <1a4649d4-2021-e6bb-6bb1-f5f7efea628c@lightnvm.io>
Date:   Tue, 16 Jun 2020 15:32:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4a97bb114ece452c80f08b96d6cbc11d@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16/06/2020 15.08, Judy Brock wrote:
>      "The on-going re-work of btrfs zone support for instance now relies 100% on zone append being supported.... So the approach is: mandate zone append support for ZNS devices.... To allow other ZNS drives, an emulation similar to SCSI can be implemented, ...  While on a HDD the  performance penalty is minimal, it will likely be *significant* on a SSD."
>
> Wow. Well as I said, I don't know much about Linux but it sounds like the ongoing re-work of btrfs zone support mandating zone append should be revisited.
Feel free to go ahead and suggest an alternative solution that shows the 
same performance benefits.It is open-source, and if you can show and 
_implement_ a better solution. We will review it as any other 
contribution to the open-source eco-system.
> The reality is there will be flavors of ZNS drives in the market that do not support Append.  As many of you know, the ZRWA technical proposal is well under-way in NVMe ZNS WG.
>
> Ensuring that the entire Linux zone support ecosystem deliberately locks these devices out / or at best consigns them to a severely performance-penalized path, especially given the MULTIPLE statements that have been made in the NVMe ZNS WG by multiple companies regarding the use cases for which Zone Append is an absolute disaster (not my words), seems pretty darn inappropriate.

First a note: I appreciate you bringing up discussions that was made 
within the NVMe ZNS TG, but please note that those discussions happened 
in that forum that is under NDA. This is an open-source mailing list, 
and the content will be available online for many many years. Please 
refrain from discussing things that are not deemed public by the the 
NVMe board of directors.

On your statement, there is no deliberate locking out of devices , no 
more than a specific feature has not been implemented or that a device 
driver that is properitary to a company. Everyone is free to contribute 
to open-source. As Javier has previously pointed out, he intends to 
submit a patchset to add the necessary support for the zone append 
command API.

>
>
>
>
>
> -----Original Message-----
> From: linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Damien Le Moal
> Sent: Tuesday, June 16, 2020 5:36 AM
> To: Javier González; Matias Bjørling
> Cc: Jens Axboe; Niklas Cassel; Ajay Joshi; Sagi Grimberg; Keith Busch; Dmitry Fomichev; Aravind Ramesh; linux-nvme@lists.infradead.org; linux-block@vger.kernel.org; Hans Holmberg; Christoph Hellwig; Matias Bjorling
> Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
>
> On 2020/06/16 21:24, Javier González wrote:
>> On 16.06.2020 14:06, Matias Bjørling wrote:
>>> On 16/06/2020 14.00, Javier González wrote:
>>>> On 16.06.2020 13:18, Matias Bjørling wrote:
>>>>> On 16/06/2020 12.41, Javier González wrote:
>>>>>> On 16.06.2020 08:34, Keith Busch wrote:
>>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set defined
>>>>>>> in NVM Express TP4053. Zoned namespaces are discovered based on their
>>>>>>> Command Set Identifier reported in the namespaces Namespace
>>>>>>> Identification Descriptor list. A successfully discovered Zoned
>>>>>>> Namespace will be registered with the block layer as a host managed
>>>>>>> zoned block device with Zone Append command support. A namespace that
>>>>>>> does not support append is not supported by the driver.
>>>>>> Why are we enforcing the append command? Append is optional on the
>>>>>> current ZNS specification, so we should not make this mandatory in the
>>>>>> implementation. See specifics below.
>>>>> There is already general support in the kernel for the zone append
>>>>> command. Feel free to submit patches to emulate the support. It is
>>>>> outside the scope of this patchset.
>>>>>
>>>> It is fine that the kernel supports append, but the ZNS specification
>>>> does not impose the implementation for append, so the driver should not
>>>> do that either.
>>>>
>>>> ZNS SSDs that choose to leave append as a non-implemented optional
>>>> command should not rely on emulated SW support, specially when
>>>> traditional writes work very fine for a large part of current ZNS use
>>>> cases.
>>>>
>>>> Please, remove this virtual constraint.
>>> The Zone Append command is mandatory for zoned block devices. Please
>>> see https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_Articles_818709_&d=DwIFAw&c=JfeWlBa6VbDyTXraMENjy_b_0yKWuqQ4qY-FPhxK4x8w-TfgRBDyeV4hVQQBEgL2&r=YJM_QPk2w1CRIo5NNBXnCXGzNnmIIfG_iTRs6chBf6s&m=-fIHWuFYU2GHiTJ2FuhTBgrypPIJW0FjLUWTaK4cH9c&s=kkJ8bJpiTjKS9PoobDPHTf11agXKNUpcw5AsIEyewZk&e=  for the background.
>> I do not see anywhere in the block layer that append is mandatory for
>> zoned devices. Append is emulated on ZBC, but beyond that there is no
>> mandatory bits. Please explain.
> This is to allow a single write IO path for all types of zoned block device for
> higher layers, e.g file systems. The on-going re-work of btrfs zone support for
> instance now relies 100% on zone append being supported. That significantly
> simplifies the file system support and more importantly remove the need for
> locking around block allocation and BIO issuing, allowing to preserve a fully
> asynchronous write path that can include workqueues for efficient CPU usage of
> things like encryption and compression. Without zone append, file system would
> either (1) have to reject these drives that do not support zone append, or (2)
> implement 2 different write IO path (slower regular write and zone append). None
> of these options are ideal, to say the least.
>
> So the approach is: mandate zone append support for ZNS devices. To allow other
> ZNS drives, an emulation similar to SCSI can be implemented, with that emulation
> ideally combined to work for both types of drives if possible. And note that
> this emulation would require the drive to be operated with mq-deadline to enable
> zone write locking for preserving write command order. While on a HDD the
> performance penalty is minimal, it will likely be significant on a SSD.
>
>>> Please submitpatches if you want to have support for ZNS devices that
>>> does not implement the Zone Append command. It is outside the scope
>>> of this patchset.
>> That we will.
>>
>>
>> _______________________________________________
>> linux-nvme mailing list
>> linux-nvme@lists.infradead.org
>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwIFAw&c=JfeWlBa6VbDyTXraMENjy_b_0yKWuqQ4qY-FPhxK4x8w-TfgRBDyeV4hVQQBEgL2&r=YJM_QPk2w1CRIo5NNBXnCXGzNnmIIfG_iTRs6chBf6s&m=-fIHWuFYU2GHiTJ2FuhTBgrypPIJW0FjLUWTaK4cH9c&s=HeBnGkcBM5OqESkW8yYYi2KtvVwbdamrbd_X5PgGKBk&e=
>>
>

