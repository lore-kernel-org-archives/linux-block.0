Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BAAC71156
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 20:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6130E21D42
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 20:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="cSxy1C0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgLAUpp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgLAUpo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 15:45:44 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB42DC0613D6
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 12:44:58 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id y4so5425615edy.5
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 12:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NmOstAzoE1wzkZ59zT3uONq7HE1n7Ff0vJ4qXFAyQoM=;
        b=cSxy1C0NaNS/QCcH2pyc47tStkEcVwFkupq4B68yoNNltqmatQK8iadY1Kma+5J3Ka
         cYqqXvJNyC7+nrexqxpNE1QTiggX2QtRDoIbILkdlzSSePJkqeqHQT5hyyzaeU5HMMOC
         Wxxvf4F5gkB4+I1qiJWQf1hx1WZ6A5pnx2+EGzte4QM2bbmXkz6TpSh6JMmJv3hdqWZC
         UDmaP4zDF0MGIF+L65+gzBpcTZllwWuj9UHff0/KsA5uykyMfZXqFI0KvOu+iY38TqSK
         OPn2Y+7ltsOxBmkG4JxcQNDcWuwW+yNJO1XFxek/6V2UqvxbXHvDUYXVsE/PGzOuW/xx
         VkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NmOstAzoE1wzkZ59zT3uONq7HE1n7Ff0vJ4qXFAyQoM=;
        b=m9DsKJI49MBFaCx3auPJH1H26oCLoqX5++JrwVh+E1MwKgnzEtKKX0Sxj+VrHXrkWV
         XDbXxBvkGAsdhDa+k1hjpxHzyDN1VdG7yBRR3q9AGiLLlvUtSVe83xCRLtAw3DCH+UGU
         43f+zD1fg/R3aW8uIiTeIDCSrunZ5flNAnnA/f6SpONbvFIMlihIes469Qx81kOI4RTv
         Y8gd0iZRMprS1wWEFNSOQ+Ib7ecRMl/1N8H21br7Qy+u5eoAoMpWwsb5jMx0Mp2HuoHG
         vW2OVFiw0OPd06yyNeUtz0iPWc6VOWoiivcCt7LSmyjSL5y2jfWf/0SeYWOIlNVudxXW
         gJQQ==
X-Gm-Message-State: AOAM530RBcY0aIDwSErNX9FIJZIrsyDbnb2UIIb4Mbg0Gv0LA57H5xrh
        R2HVzZUNgComQ6wcjJiKx0uKwg==
X-Google-Smtp-Source: ABdhPJxIKppkjwxKxfiVMEBUAQqhOKwJQreGLForJIlRN/dfWK4sFkIYsAqpKTSc9pjCae5+xJyxnw==
X-Received: by 2002:a05:6402:1c96:: with SMTP id cy22mr4878517edb.339.1606855497384;
        Tue, 01 Dec 2020 12:44:57 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id d6sm363069ejy.114.2020.12.01.12.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:44:56 -0800 (PST)
Date:   Tue, 1 Dec 2020 21:44:56 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        sagi@grimberg.me
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201201204456.dt2niquyaqvuci4s@MacBook-Pro.localdomain>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-5-javier.gonz@samsung.com>
 <CGME20201201140354eucas1p1940891b47ca0c03ea46603393c844f61@eucas1p1.samsung.com>
 <20201201140348.GA5138@localhost.localdomain>
 <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain>
 <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
 <20201201193823.GA3522@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20201201193823.GA3522@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01.12.2020 20:38, Christoph Hellwig wrote:
>On Wed, Dec 02, 2020 at 04:30:02AM +0900, Keith Busch wrote:
>> > > In multi-path, private namespaces for a head are not in /dev, so I don't
>> > > think this will hurt private namespaces (e.g., nvme0c0n1), But it looks
>> > > like it will make a little bit confusions between chardev and hidden blkdev.
>> > >
>> > > I don't against to update nvme-cli things also even naming conventions are
>> > > going to become different than nvmeXcYnZ.
>> >
>> > Agree. But as I understand it, Keith had a good argument to keep names
>> > aligned with the hidden bdev.
>>
>> My suggested naming makes it as obvious as possible that the character
>> device in /dev/ and the hidden block device in /sys/ are referring to
>> the same thing. What is confusing about that?

Ok. I see your point. I was thinking of the case where the multipath
bdev is also enabled so we would have the same name in different places
referring to a different device.

>>
>> > It is also true that in that comment he suggested nesting the char
>> > device in /dev/nvme
>>
>> Yeah, I'm okay with sub-directories for these special handles, but there
>> are arguments against it too. I don't feel that strongly about it either
>> way.
>
>I'd prefer different naming for the char vs the block devices.  Yes,
>this will require a little work in the userspace tools to support the
>character device, but I think it is much cleaner.
>
>Devices in subdirectories of /dev/ are very rare and keep causing problem
>with userspace tooling for the few drivers that use them, so I don't
>think they are a good idea.

Would something like nvmeXnYc work here or your prefer something
different where we need to implement new, dedicated filters for
user-space? I thing you suggested nvmegXnY at some point?

Here, the naming would be for both the char device and the sysfs
entry.
