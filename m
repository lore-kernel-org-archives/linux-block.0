Return-Path: <SRS0=t87n=EI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609EAC388F9
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 21:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3F8208B6
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 21:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="WgiN9CB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgKBVYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 16:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgKBVYI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Nov 2020 16:24:08 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938EEC0617A6
        for <linux-block@vger.kernel.org>; Mon,  2 Nov 2020 13:24:08 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id o9so18777898ejg.1
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2020 13:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BipIl57MTmMMQMBlG+7ISd6m7Cm+omAdyc53iQ+SbyY=;
        b=WgiN9CB3FL0EJYyG1GCyEB83z1+z9qoXNdxL4XRxwQ66wq9l+rgeMHEI7HoOU2XzUo
         x1iQKoZv08dY7TSmZgT5mFjjlErBQsD5h0TRyk8UvMx8MLmC3lhmN0WLNQCT3f1hO1JT
         jqrwQpCduRgHyRv6gIxXOwrSszFzvsGwu+IaBexg7nQ3fJ8XSF95BrWHV53FbRN97xmm
         aKrMPM/zu34D0JRdEJssSXudTLPguORdZ7qZ/XPm62UDCRUbw0N+QVLnpz41yyvMk/xn
         YAplXYesI/FfMCseHg/aORc1qrBMa3tSCJwyi5nHkFt1C2dVhuKmacn76sD1NHk8qo1h
         qA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BipIl57MTmMMQMBlG+7ISd6m7Cm+omAdyc53iQ+SbyY=;
        b=Vdz+lSdobQrsvvsmk73AwG+rcUpClOoM1Q18wljlJYgpsH1K+tNro2VOfK9RMe0fAw
         1dyxwU6XV4UUjhnzXMkc7aBO1E0oAaHZR+CHdp4hdiOYCDxWa7EACf6PJoOyRNEJg6OO
         ACkE8kg7XTaTed/RfcDuNQFnBGnfwIqk2zCVjZKfQHWX34Z+D6zpiFPHixORkY49SKPh
         GWK8qvsDiotsw+++yFJ1nFZXVo2WvCOoDgPZSJj/QKWEwYfzobiZ4u/rCFX2wQU3V7sv
         zdC/wY/zyZS3P8umeNeexg//R1xqN61fb/V+MCYQ1fS14MF4ZKrdxjEMGo4AxwyafvSe
         hrlw==
X-Gm-Message-State: AOAM533WETonCK0PBHNd3pp/qoZlyHZUa7EAyjuefzh7K7QbW7JX0U4b
        z48Qx2XmCKt5xLJDQeChwaEgSQ==
X-Google-Smtp-Source: ABdhPJxah9ERjLK5n4yrv9cRj2vDgPvBvq6uF5pZsPQOVp962pYQY2uZvpKkhzWxtCIObyacP8P64w==
X-Received: by 2002:a17:906:52c6:: with SMTP id w6mr16228680ejn.199.1604352247302;
        Mon, 02 Nov 2020 13:24:07 -0800 (PST)
Received: from localhost (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
        by smtp.gmail.com with ESMTPSA id k26sm11091887edf.85.2020.11.02.13.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 13:24:06 -0800 (PST)
From:   Javier Gonzalez <javier@javigon.com>
X-Google-Original-From: Javier Gonzalez <javier.gonz@samsung.com>
Date:   Mon, 2 Nov 2020 22:24:05 +0100
To:     "hch@lst.de" <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Klaus B. Jensen" <k.jensen@samsung.com>,
        "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>
Subject: Re: nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102212405.j43m47ewg65v4k5k@MacBook-Pro.localdomain>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20201102185851.GA21349@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02.11.2020 19:58, hch@lst.de wrote:
>On Mon, Nov 02, 2020 at 10:33:55AM -0800, Keith Busch wrote:
>> I can see this going one of two ways:
>>
>>  a) Set up the existing controller character device with a generic
>>     disk-less request_queue to the IO queues accepting IO commands to
>>     arbitrary NSIDs.
>>
>>  b) Each namespace that can't be supported gets their own character
>>     device.
>>
>> I'm leaning toward option "a". While it doesn't create handles to unique
>> namespaces, it has more resilience to potentially future changes. And I
>> recall the target side had a potential use for that, too.
>
>The problem with a) is that it can't be used to give users or groups
>access to just one namespaces, so it causes a real access control
>nightmare.  The problem with b) is that now applications will break
>when we add support for new command sets or features.  I think
>
>  c) Each namespace gets its own character device, period.
>
>is the only sensible option.

This sounds reasonable. We have been back and forth on a patchset with
async passthru using io_uring. I believe this can help with some of the
questions we are preparing for a RFC.

If I understand correctly, the model would be that a namespace will
always have (i) a character device associated where I/O is always allowed
through user formed commands, and if the namespace has full support in
the kernel (ii) a block device where I/O is as it is today. In case of
(ii) both interfaces can be used for I/O.

While we work on iterations for c), do you believe it is reasonable to
merge a version of the current path that follows the PI convention for
unsupported command sets and features? I would assume that we will have
to convert PI to this model too when it is available.

Javier
