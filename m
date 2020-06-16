Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7356C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C079620C56
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="NdH81GWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgFPMYx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPMYv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 08:24:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FC9C08C5C2
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 05:24:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q11so20575773wrp.3
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/kIpCjCnT58JEG0mlUt9/EOieRJkzoytsmJ6uVIikG4=;
        b=NdH81GWDoVE8IpZvXIvmiD9pU0wl/DubsUnumfs2pm8ffF3/3S9hBD32MTJQ12z3vx
         tg+dvD1OBOPIIMfoFOGk8RV18xUtaOOG8r1frHLCXDyZa2037wz5VWo8pQsNjxVoNafo
         HnjBoCefxCRABCpMcrPb0BSu1NUoZjHiH6BkJSxsO9mwIyUSe9N9FN4un3UmTdZ5Kfxd
         PjRvVXJvHjaLpZbx8B4mm1LmS7fRs9wJUtrZ2r0ZyQrUpMXKBK46cGAva0TGw9KZHjz6
         E2R2EFQZX7SgzqxBYkoZ094rpMpCmzMAvvUkkXFn1YBvtJRUKQ1V6mjUvr6vRRZ8aECI
         ZsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/kIpCjCnT58JEG0mlUt9/EOieRJkzoytsmJ6uVIikG4=;
        b=Cr26h8jpJF4j+tSyljH4o0yMT6yuKKY98RIumzM9qwg3NpkVU+FpuBewytXTLcRAvh
         chc9t8Ho0UuG/vt6YfPZ9W/0/l2oH+tQO2Jh00Uj140ReJc4+olrTH29sdZeHNMF6Ps3
         wb0ULORLe345vVFkN+2lr3UItKeOT2v3LHUSGOFc4wcvqhO3xlbXwEYEaqyqzbQJg64s
         xjJ1yvmVi6Fysf/T4dgV4Gipz+SReoJZFPPP0w9dX6wqLtUbR5tKaDUKtoN0EEvQAtsX
         edHfcTBMcoazSPl/4z1usRk9073JEMqufFvs/WDxAz9W6aLprVkJOIuKUCt+QOpfldeS
         zwsQ==
X-Gm-Message-State: AOAM531CE+rP/ikNARHljrzR3p16Ixvt8xSxA3UhDTdmouSpA8bLcm4l
        B/uviCi+VKH0xQE13Yqt1GRqZQ==
X-Google-Smtp-Source: ABdhPJxdYMJPpziDe8iXirHeV1pcVKa8DYd2hmGQF7C8+5WnJxa7+yKYZEo/WSDPHXONxAKse1WU/g==
X-Received: by 2002:a5d:56c3:: with SMTP id m3mr2807086wrw.393.1592310289602;
        Tue, 16 Jun 2020 05:24:49 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id w10sm29085408wrp.16.2020.06.16.05.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:24:48 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:24:48 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200616122448.4e3slfghv4cojafq@mpHalley.local>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16.06.2020 14:06, Matias Bjørling wrote:
>On 16/06/2020 14.00, Javier González wrote:
>>On 16.06.2020 13:18, Matias Bjørling wrote:
>>>On 16/06/2020 12.41, Javier González wrote:
>>>>On 16.06.2020 08:34, Keith Busch wrote:
>>>>>Add support for NVM Express Zoned Namespaces (ZNS) Command Set defined
>>>>>in NVM Express TP4053. Zoned namespaces are discovered based on their
>>>>>Command Set Identifier reported in the namespaces Namespace
>>>>>Identification Descriptor list. A successfully discovered Zoned
>>>>>Namespace will be registered with the block layer as a host managed
>>>>>zoned block device with Zone Append command support. A namespace that
>>>>>does not support append is not supported by the driver.
>>>>
>>>>Why are we enforcing the append command? Append is optional on the
>>>>current ZNS specification, so we should not make this mandatory in the
>>>>implementation. See specifics below.
>>
>>>
>>>There is already general support in the kernel for the zone append 
>>>command. Feel free to submit patches to emulate the support. It is 
>>>outside the scope of this patchset.
>>>
>>
>>It is fine that the kernel supports append, but the ZNS specification
>>does not impose the implementation for append, so the driver should not
>>do that either.
>>
>>ZNS SSDs that choose to leave append as a non-implemented optional
>>command should not rely on emulated SW support, specially when
>>traditional writes work very fine for a large part of current ZNS use
>>cases.
>>
>>Please, remove this virtual constraint.
>
>The Zone Append command is mandatory for zoned block devices. Please 
>see https://lwn.net/Articles/818709/ for the background.

I do not see anywhere in the block layer that append is mandatory for
zoned devices. Append is emulated on ZBC, but beyond that there is no
mandatory bits. Please explain.

> Please submitpatches if you want to have support for ZNS devices that
> does not implement the Zone Append command. It is outside the scope
> of this patchset.

That we will.

