Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1624C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 08:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiCPIqB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 04:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiCPIqA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 04:46:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A273A19D
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:44:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x34so633049ede.8
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ivduCWllgAhkl431+NElDaj0MPOUaZZX1zUUbSYMRvM=;
        b=hAr/5zQTdbSkj5pHiBKvwAoDyObBsYXqHQrsoqDAhF2IBePz9UgYH6EwCehd4SRgUC
         9KM3Q/lVOGnmauhyuMrDhUYsmWS6ceBt6Hls2NPvjGNbeJxGIj7lFzX9shCGNMseH0cU
         u/kVgebRD1YDguODVWXwHX+iMbdRdDCtWcV6Bbl31+daHp3YMip0lwCaoYQfDt/6mOyM
         ffi5OCHT0taXV0DepiqI4ZcgsCdOgvItn0PCyFZJ/LUMpDsoNXWGWFyOAUOrCci3Ompc
         dUOsutm6lf23O45R0T3trR+rWlegzSUHNrGp4hhGfjeWf/lFruo5iPN/BFbmDEt1ROA7
         O58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ivduCWllgAhkl431+NElDaj0MPOUaZZX1zUUbSYMRvM=;
        b=FshB52oeDg0eJlbBQWVU4eUY8f343oTPH5hOQieV/qo8Ml6kvE+H5kFpIDVEMDI/JC
         U+cO12QMpWCzXNwpgRjAfJcd4JSxeBZjmKXmvlJ8h1jUKG6IlG3mguVsB9YPtzAw7sXq
         X0jskeMF38KNnug47r6qlnoCaLCZrUEhV9ZRSbbiDpVlhGHzVUaLzfu/XXIFe8NqowOL
         L4bRlH1Uao/ExLTT1Zd8oI1MAMDbAvRa+fkfOPKdvdHjfHSkAuy24fo5K3WOVexWyarK
         pknrd4qw1BVbNBYS55qNMK9Ry8Utlub4hZ8+H/aa7oJRv5L84mUQvERvHUOPNqrT7ikj
         wMzw==
X-Gm-Message-State: AOAM5335r8POW7tcpobaZ1qrpw0gh/Dnt3jzH/CE/ggMa6AcY/6D+Msh
        RRs0yTopZPrLY966TPoZIrlzVQ==
X-Google-Smtp-Source: ABdhPJyFtg89DVgaQqT6qtznmpTTA+nOpZ/sK0VzW/VVMlB9pc+PIJEWUWmWmfjyxhPsR9USMyikQA==
X-Received: by 2002:a05:6402:5243:b0:418:e5f7:7b1 with SMTP id t3-20020a056402524300b00418e5f707b1mr2717202edd.153.1647420285107;
        Wed, 16 Mar 2022 01:44:45 -0700 (PDT)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709063a0500b006da8fa9526esm582395eje.178.2022.03.16.01.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 01:44:44 -0700 (PDT)
Date:   Wed, 16 Mar 2022 09:44:44 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220316084444.gn27fxoh7xd3soly@ArmHalley.localdomain>
References: <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
 <yq1a6dqae7e.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <yq1a6dqae7e.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15.03.2022 22:27, Martin K. Petersen wrote:
>
>Luis,
>
>> Applications which want to support ZNS have to take into consideration
>> that NPO2 is posisble and there existing users of that world today.
>
>Every time a new technology comes along vendors inevitably introduce
>first gen devices that are implemented with little consideration for the
>OS stacks they need to work with. This has happened for pretty much
>every technology I have been involved with over the years. So the fact
>that NPO2 devices exist is no argument. There are tons of devices out
>there that Linux does not support and never will.
>
>In early engagements SSD drive vendors proposed all sorts of weird NPO2
>block sizes and alignments that it was argued were *incontestable*
>requirements for building NAND devices. And yet a generation or two
>later every SSD transparently handled 512-byte or 4096-byte logical
>blocks just fine. Imagine if we had re-engineered the entire I/O stack
>to accommodate these awful designs?
>
>Similarly, many proponents suggested oddball NPO2 sizes for SMR
>zones. And yet the market very quickly settled on PO2 once things
>started shipping in volume.
>
>Simplicity and long term maintainability of the kernel should always
>take precedence as far as I'm concerned.

Martin, you are absolutely right.

The argument is not that there is available HW. The argument is that as
we tried to retrofit ZNS into the zoned block device, the gap between
zone size and capacity has brought adoption issues for some customers.

I would still like to wait and give some time to get some feedback on
the plan I proposed yesterday before we post patches. At this point, I
would very much like to hear your opinion on how the changes will incur
a maintainability problem. Nobody wants that.

