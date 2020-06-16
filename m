Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91947C433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 14:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6493020786
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 14:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Njo0oUKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgFPOQY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgFPOQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 10:16:24 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E06C061573
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 07:16:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y13so21697215eju.2
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6PWDuPTkrXleyY02khhPslJk/OM89kQqOYof8Xt9yHk=;
        b=Njo0oUKYpM2x8GPJ/D8RopLES3YBM9Ix48tYOprYcVt+9EfKZKDy/sDD+L+kUL1eXT
         01RzLC7T0Vyldau9ODEXV1VChCqNyjpYhYo5hVYs/63kEJnXdlnA2ZUCP3E085YpX82K
         wxLm0Q3yyOyVUKrMNMMTGbyrMD0j4H87G/8N9mlWtjljv4YUGDpzvSVS71kUeSdoLI2i
         r4rQYNoa9xihIoa04PASggkKg0n6Qlr3q9N6ubkdOVt1hgwYPU6h7cPcDYg+EbwyuMZg
         wdKIl548fehCeffn6M9HiBDKHxtusnfDMwA/YJ1NllMaerBMmk/YoNJIHxsa45kBiEIS
         7r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6PWDuPTkrXleyY02khhPslJk/OM89kQqOYof8Xt9yHk=;
        b=TvxZGluLKuC7rToNFnn+inX7T3wF6fnVb8Aj1LibMBAbdjIBbcSYL6lfPYAwWfjxB0
         2GKUFdyOuEyO/ubJFUs/pgFngyCvHFOJQ8b/enNukE9mI8rqvc9ViQcTdZbmgjCsKFh2
         3poQddydl3WW/Rs+Ay+mvmQAEg5qZM+qOAdcHrt9/ZSfW7nJuX1Cws8nSaULVHZGbgWL
         YYIYkRbn80p5wdoE8RJb2DUAR0CCMsL6ejlEmr/xb/viF0f/WZ2OXbzByDFQYPWethKZ
         WEZnE9gcdUsfLl6JP8TZGTW29QC2spptN5Twuod7c4CMv9mXOEm0mnEWvPv1y2WMKUTq
         qfUg==
X-Gm-Message-State: AOAM532rbP389va7sBN823W5H4Ws7Xp+bNfeTgSb9jgXfurSjR62s8nN
        v+76Nqoztzx8Mj2euGpK2gHsMg==
X-Google-Smtp-Source: ABdhPJzhsm7I9PyI7ohWJAAIdecI/C9wgCHgZ2I9lCFpLr7leG+zZv2BlHmNSY9Jc1GLRrPO8EuR7w==
X-Received: by 2002:a17:906:69c3:: with SMTP id g3mr3152625ejs.47.1592316982230;
        Tue, 16 Jun 2020 07:16:22 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id z38sm6863582ede.96.2020.06.16.07.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:16:21 -0700 (PDT)
Date:   Tue, 16 Jun 2020 16:16:20 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16.06.2020 12:35, Damien Le Moal wrote:
>On 2020/06/16 21:24, Javier González wrote:
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
>>>>>>
>>>>>> Why are we enforcing the append command? Append is optional on the
>>>>>> current ZNS specification, so we should not make this mandatory in the
>>>>>> implementation. See specifics below.
>>>>
>>>>>
>>>>> There is already general support in the kernel for the zone append
>>>>> command. Feel free to submit patches to emulate the support. It is
>>>>> outside the scope of this patchset.
>>>>>
>>>>
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
>>>
>>> The Zone Append command is mandatory for zoned block devices. Please
>>> see https://lwn.net/Articles/818709/ for the background.
>>
>> I do not see anywhere in the block layer that append is mandatory for
>> zoned devices. Append is emulated on ZBC, but beyond that there is no
>> mandatory bits. Please explain.
>
>This is to allow a single write IO path for all types of zoned block device for
>higher layers, e.g file systems. The on-going re-work of btrfs zone support for
>instance now relies 100% on zone append being supported. That significantly
>simplifies the file system support and more importantly remove the need for
>locking around block allocation and BIO issuing, allowing to preserve a fully
>asynchronous write path that can include workqueues for efficient CPU usage of
>things like encryption and compression. Without zone append, file system would
>either (1) have to reject these drives that do not support zone append, or (2)
>implement 2 different write IO path (slower regular write and zone append). None
>of these options are ideal, to say the least.
>
>So the approach is: mandate zone append support for ZNS devices. To allow other
>ZNS drives, an emulation similar to SCSI can be implemented, with that emulation
>ideally combined to work for both types of drives if possible.

Enforcing QD=1 becomes a problem on devices with large zones. In
a ZNS device that has smaller zones this should not be a problem.

Would you agree that it is possible to have a write path that relies on
QD=1, where the FS / application has the responsibility for enforcing
this? Down the road this QD can be increased if the device is able to
buffer the writes.

I would be OK with some FS implementations to rely on append and impose
the constraint that append has to be supported (and it would be our job
to change that), but I would like to avoid the driver rejecting
initializing the device because current FS implementations have
implemented this logic.

We can agree that a number of initial customers will use these devices
raw, using the in-kernel I/O path, but without a FS on top.

Thoughts?

> and note that
>this emulation would require the drive to be operated with mq-deadline to enable
>zone write locking for preserving write command order. While on a HDD the
>performance penalty is minimal, it will likely be significant on a SSD.

Exactly my concern. I do not want ZNS SSDs to be impacted by this type
of design decision at the driver level.

Thanks,
Javier
