Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11BAC433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 15:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98852073E
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 15:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Sn3fqfGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgFQPAh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQPAg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 11:00:36 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33126C06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 08:00:35 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id x25so2172801edr.8
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ewYLiJNTJQyB+3rQIPwKj+FxYZbp7ZBwEtIXKeY2qqg=;
        b=Sn3fqfGTHn6bYrrySPdwadSbaHKPPiBKIhvPi2KTzfd0DNiHw805I8fzFiWxpsNprX
         wpIbEQbziRobHV1nIEbjd4ofrQol+I5SVoZtW3MPDAoFNNsz1BMo2IliXdwdADvrcR/S
         yZAFEklrkDShy5LdwTepUusd1rA2WsDJEO5TCsvOUKrj3YO2R6uh9PEcA5zwqNELDsJC
         oox5prCNqUPGa598SUwMxMG+06n7lGeWjBMjk2jbodCiSBqStt0iiWZaIrAyXDFoE+6E
         wwk2wFV+9LlHgkD5L/NFkrQQritez6InH0ciP9Bvtz/xjijmFVI0ViLfbE9sP95AeX4b
         Ypxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ewYLiJNTJQyB+3rQIPwKj+FxYZbp7ZBwEtIXKeY2qqg=;
        b=CABi1gETaHz4Vfzxr8XeNRxzmJcrbgdK9GoaNyI5tlqFe7D28V6yMZVvNyJFHHrW8+
         h0ykchqG9RlCvpHNbx60iU6aAAAgeeoD9pHTIfb+femDx7gJRDhzdKrkBKGBzQzxNAn2
         rx04jck0xwRP/6scmSUM9p/I6jNF3Qmdsl6++C9eVfyENgKvabgy/lUkEUwfE3mP0fDY
         BaRGly3n/ENaJncYqpVYBo6BZClJS4fCilKGs2yDr2I19BGnzG0nZkdsI21vPAF3tZxV
         Mnd+i+BBM4i4H/GcBPQMD6lcvK/LhHN44U5OmNC0qpAOTMKUZ1UrqikwCEppK/Vtbe7F
         Js8g==
X-Gm-Message-State: AOAM5310OGB55Yd/aPKfgDZxITUF+TXH0ASh0zrzpqBliWDruGrwHiO/
        VH2yeUnbdjnqRZTuyuCtO+MgXw==
X-Google-Smtp-Source: ABdhPJzZKVXfpt+AqDo00fk98HiTiL6MUQK+cv/hAolqAHenZd5/pRSFqI2sutgAEN9R6h8hqeALNQ==
X-Received: by 2002:a05:6402:1bde:: with SMTP id ch30mr7806388edb.163.1592406033845;
        Wed, 17 Jun 2020 08:00:33 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id n3sm141063ejd.82.2020.06.17.08.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 08:00:33 -0700 (PDT)
Date:   Wed, 17 Jun 2020 17:00:32 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617150032.s5q6ktbbz5ndvvpi@mpHalley.localdomain>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <yq1r1uej7j6.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <yq1r1uej7j6.fsf@ca-mkp.ca.oracle.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.06.2020 08:01, Martin K. Petersen wrote:
>
>> Because Append is the way to go and we've moved the Linux zoned block
>> I/O stack to required it,
>
>Just to add some historical context: The first discussions about how to
>support block devices with a non-random write model in Linux happened
>maybe a decade ago.
>
>Drive vendors came to LSF/MM to solicit feedback on how Linux could
>support impending SMR devices. We spent a long time going over various
>approaches, including some that are similar to what is now being
>entertained as alternative to Append. The conclusion back then was that
>an Append-like model (tell-us-where-you-put-it) was the only reasonable
>way to accommodate these devices in Linux given how our filesystems and
>I/O stack worked.
>
>Consequently, I don't think it is at all unreasonable for us to focus on
>devices that implement that mode of operation in the kernel. This is
>exactly the that we as a community asked the storage industry to
>provide!
>

Martin,

Thanks for sharing the historical context. I agree that append solves a
number of problems in Linux - we have had internal implementations of
append for a long time (and are sending patches extending support for it
later today).

This said, there are users that do not see append as a good fit for
their needs and we would like to support them too.

We will go back to our code and re-iterate based on the feedback we have
gotten out of this thread.

Thanks,
Javier
