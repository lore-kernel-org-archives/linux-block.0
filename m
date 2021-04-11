Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F0CC433B4
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 19:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482746109F
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 19:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbhDKT1B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 15:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbhDKT1B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 15:27:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BD4C06138B
        for <linux-block@vger.kernel.org>; Sun, 11 Apr 2021 12:26:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z24-20020a1cf4180000b029012463a9027fso5663590wma.5
        for <linux-block@vger.kernel.org>; Sun, 11 Apr 2021 12:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/8TJhA68h/8e3XqwlnCzlH6v3LnaNubb1RVVGCxTa4g=;
        b=J/l21sH2xEiKQ5zss8PE24t6RX0KijI3aKHY/zYCZ215ztzsJxk3YljLf/9ftP+pPe
         W2hIc9la/fpqnWUY3TUAuScz4dE1UIQItk2QhltQbkThx0ZFcUtLEyo9eWse4P5qaoGn
         sVrV13I6RW6IfJqFSoDl8o3kyGU7FpHMH7YI6Vv6I/QtjipsPPfa1VoVXNs55fE86dWB
         fmA6d8XTjvDkCBtqS8KZ8EzaGTFkfEAVMmtmWT7qIMmUGtH2ziIzg7IpgUebjLAj6Yb9
         l6g37HwskvyYSfmzdloylJzUbLJUGkrKUGnzOCqluZCe6dn9gEVSQ08hl5AMZ80QmEgB
         CohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/8TJhA68h/8e3XqwlnCzlH6v3LnaNubb1RVVGCxTa4g=;
        b=HYr3ElC2VhoGWBmhe6iCtIy7iRZdCf0XRG/EVKocWpnO1HjEF8xeRHN1//1tBMfnnM
         DljQB/tBEYBE0C8KXhZBWK7L8b8JjwzaH4F8ZE4tE179KuPGxgs89XWvwK9/K2bWbImw
         mr/Y4ljXw9pQvzL8mWCqhXJ0DC8us4GTnWZmHSJAPTbiXW6mQwCQ4hQ2AsZWFPegSobf
         b8q82eyA0DbkJl4Rbw9D5AGdRLPN01D1stJh2TNdvj/rsOK7GaA0h6mUT6o/Bt30aQU3
         sDuv3l8dAhi2QYsLlJy2qg7QaG4aJD8ZMvVXIx/wNsaHgnKhRMkC5efpOYHvtcT+pNBB
         O3Lw==
X-Gm-Message-State: AOAM53326IoFpKEPYsyEk5e8Rn8/WDlh4hztmFhPaTXgj+NWnhSmJAIM
        KaOWFtyZhRn8QJti9VehQu6KGQ==
X-Google-Smtp-Source: ABdhPJztsA/xwX5L/DoL1oZX+LcVXnIQD+VgkEO9P1o2PIOgshz/wlckdDgYHVifqaAMs+uSrN4kbw==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr23533683wmc.100.1618169203190;
        Sun, 11 Apr 2021 12:26:43 -0700 (PDT)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id d5sm16939244wrx.0.2021.04.11.12.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 12:26:42 -0700 (PDT)
Date:   Sun, 11 Apr 2021 21:26:41 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Damien Le Moal <damien.lemoal@wdc.com>, kch@kernel.org,
        sagi@grimberg.me, snitzer@redhat.com, selvajove@gmail.com,
        linux-kernel@vger.kernel.org, nj.shetty@samsung.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, joshi.k@samsung.com, kbusch@kernel.org,
        joshiiitr@gmail.com, hch@lst.de
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Message-ID: <20210411192641.ya6ntxannk3gjyl5@mpHalley.localdomain>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
 <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11.04.2021 12:10, Max Gurtovoy wrote:
>
>On 4/10/2021 9:32 AM, Javier González wrote:
>>>On 10 Apr 2021, at 02.30, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> wrote:
>>>
>>>﻿On 4/9/21 17:22, Max Gurtovoy wrote:
>>>>>On 2/19/2021 2:45 PM, SelvaKumar S wrote:
>>>>>This patchset tries to add support for TP4065a ("Simple Copy Command"),
>>>>>v2020.05.04 ("Ratified")
>>>>>
>>>>>The Specification can be found in following link.
>>>>>https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>>>>>
>>>>>Simple copy command is a copy offloading operation and is  used to copy
>>>>>multiple contiguous ranges (source_ranges) of LBA's to a single destination
>>>>>LBA within the device reducing traffic between host and device.
>>>>>
>>>>>This implementation doesn't add native copy offload support for stacked
>>>>>devices rather copy offload is done through emulation. Possible use
>>>>>cases are F2FS gc and BTRFS relocation/balance.
>>>>>
>>>>>*blkdev_issue_copy* takes source bdev, no of sources, array of source
>>>>>ranges (in sectors), destination bdev and destination offset(in sectors).
>>>>>If both source and destination block devices are same and copy_offload = 1,
>>>>>then copy is done through native copy offloading. Copy emulation is used
>>>>>in other cases.
>>>>>
>>>>>As SCSI XCOPY can take two different block devices and no of source range is
>>>>>equal to 1, this interface can be extended in future to support SCSI XCOPY.
>>>>Any idea why this TP wasn't designed for copy offload between 2
>>>>different namespaces in the same controller ?
>>>Yes, it was the first attempt so to keep it simple.
>>>
>>>Further work is needed to add incremental TP so that we can also do a copy
>>>between the name-spaces of same controller (if we can't already) and to the
>>>namespaces that belongs to the different controller.
>>>
>>>>And a simple copy will be the case where the src_nsid == dst_nsid ?
>>>>
>>>>Also why there are multiple source ranges and only one dst range ? We
>>>>could add a bit to indicate if this range is src or dst..
>>One of the target use cases was ZNS in order to avoid fabric transfers during host GC. You can see how this plays well with several zone ranges and a single zone destination.
>>
>>If we start getting support in Linux through the different past copy offload efforts, I’m sure we can extend this TP in the future.
>
>But the "copy" command IMO is more general than the ZNS GC case, that 
>can be a private case of copy, isn't it ?

It applies to any namespace type, so yes. I just wanted to give you the
background for the current "simple" scope through one of the use cases
that was in mind.

>We can get a big benefit of offloading the data copy from one ns to 
>another in the same controller and even in different controllers in 
>the same subsystem.

Definitely.

>
>Do you think the extension should be to "copy" command or to create a 
>new command "x_copy" for copying to different destination ns ?

I believe there is space for extensions to simple copy. But given the
experience with XCOPY, I can imagine that changes will be incremental,
based on very specific use cases.

I think getting support upstream and bringing deployed cases is a very
good start.
