Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33A0C433E1
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8ABF21475
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="n2a6eLWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbgFPQOB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732016AbgFPQN5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 12:13:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A571CC061573
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 09:13:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gl26so22109013ejb.11
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bXcqhpFhMhk8ZY77KeGqnjs+Bytviss9YJw9YsVxTJs=;
        b=n2a6eLWR3NoMSw+HpzxNmzS9zLNPjd338tmR6hrKmRQtkz5V1gNKYZyAbjyjv3o3xX
         +6L3HLzvqWXweOkIeDhWyX4VHoQPUVFFnhLbSLIAoCnqIm0G5wghhljvFqdZB57IFaSH
         hadU/xYGKEyXrN3C9XrRMT5fsRxbW78j1Epq24w8xeO5vuDmf75Nedevt/zI5lePxfCE
         wdfkpYJBMEKn0K1vlowTEOUTTWK/Q1EdHIj1QIJhBalSXjAYRS1Rlu34Twig2G2XLUUk
         ua1LL5Q/OyFwipQ+Ggl/+WR6O6dX9HgNtA2mmiHIblsNPK48VgOFM2q5THXsQo410KVR
         41JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bXcqhpFhMhk8ZY77KeGqnjs+Bytviss9YJw9YsVxTJs=;
        b=KLA1vARTY76itEgrmIMrRHSrrvlUBSdDp4/RBEd3insnISRmguGSpF/FEg9h1zRhXc
         2hejhy7rh691Y5iRYNL1cdeaXKIAtFyZBCeqxZauR0o14wKC77Pf1pedbjeXjOgUWVKp
         73K2LVASRnVzsRFOkXkKn4nhcMM2hQrbKNRuhMBHEzXZKZPZWQqpCfiyZMwpJny0/y8b
         6SApwXGzwcTwCdzEl3EAZG52XX09WMOmpcH7SYJZEi5U6q0hpQc03e9guhI10X9Y6pZM
         wgGPusfVHNUuNIJnNvnoD9PpwYrMIGymcXMzfG7q3ukQ+Yp5XGVsmJJgbRb12huwQxj8
         hrig==
X-Gm-Message-State: AOAM532YpzNp4HmxNuC08ZMmkOy7jp7Pg3r/+/RkNZA194t/g+3RAVdh
        DvbAxj5Yo56tFThiPuJu+9DbCw==
X-Google-Smtp-Source: ABdhPJzKupq0vpkrwjE8NxyCitWzJPu8lVhXR8vDNa7MHrIVP+xXxWO84QoS1vbEwJCIUoMmtziZMQ==
X-Received: by 2002:a17:906:5418:: with SMTP id q24mr3483880ejo.266.1592324035322;
        Tue, 16 Jun 2020 09:13:55 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id s14sm11378495ejd.111.2020.06.16.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:13:54 -0700 (PDT)
Date:   Tue, 16 Jun 2020 18:13:54 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
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
Message-ID: <20200616161354.q3p2vy2go6tszs67@mpHalley.localdomain>
References: <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
 <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16.06.2020 09:07, Keith Busch wrote:
>On Tue, Jun 16, 2020 at 05:55:26PM +0200, Javier González wrote:
>> On 16.06.2020 08:48, Keith Busch wrote:
>> > On Tue, Jun 16, 2020 at 05:02:17PM +0200, Javier González wrote:
>> > > This depends very much on how the FS / application is managing
>> > > stripping. At the moment our main use case is enabling user-space
>> > > applications submitting I/Os to raw ZNS devices through the kernel.
>> > >
>> > > Can we enable this use case to start with?
>> >
>> > I think this already provides that. You can set the nsid value to
>> > whatever you want in the passthrough interface, so a namespace block
>> > device is not required to issue I/O to a ZNS namespace from user space.
>>
>> Mmmmm. Problem now is that the check on the nvme driver prevents the ZNS
>> namespace from being initialized. Am I missing something?
>
>Hm, okay, it may not work for you. We need the driver to create at least
>one namespace so that we have tags and request_queue. If you have that,
>you can issue IO to any other attached namespace through the passthrough
>interface, but we can't assume there is an available namespace.

That makes sense for now.

The next step for us is to enable a passthrough on uring, making sure
that I/Os do not split.

Does this make sense to you?

Thanks,
Javier
