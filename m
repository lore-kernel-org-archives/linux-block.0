Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540D7C43332
	for <linux-block@archiver.kernel.org>; Wed,  3 Mar 2021 16:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2679E64EF1
	for <linux-block@archiver.kernel.org>; Wed,  3 Mar 2021 16:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345573AbhCCQiN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Mar 2021 11:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843030AbhCCKYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Mar 2021 05:24:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6920C08ECB8
        for <linux-block@vger.kernel.org>; Wed,  3 Mar 2021 02:02:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j2so10122919wrx.9
        for <linux-block@vger.kernel.org>; Wed, 03 Mar 2021 02:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IN4csN/tIDBWFNMljb2TQOPsrzBCa+hy7W7Ri9Ms9BA=;
        b=D06W3jcaxkyfLLWehHEA1KSZybTfutUorO7qKIi0xU4FfSetGALeqbPPyvcBmlCpBe
         ckSVhm1xMsnvIa0scm5aShh8RpUNXPXCuQC+QVsFPkcqE0Z0ih+lNjKvws/bD7P2LnFu
         FzoAQ9LD5xEf/qMI/zN979rCbBr3y5RtCwlyNm5KF/aWoCWzryXkEn5rZzAH4SdPQexz
         IPq8xDkVVoUfxkDBAOUyvRci1n6QYUtqJ0nycPRvC6bozBOVnOuvaXZl99ZsFTCI7ehv
         k2az9sfTQ5Z7Bh+KKj+iw9rg9BKYPq1MwY/WFdLiIaRn9zNwukua/MLC35ZX1w6Jt4/5
         9ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IN4csN/tIDBWFNMljb2TQOPsrzBCa+hy7W7Ri9Ms9BA=;
        b=ZDp7wFR6jost0ndlYpA8MzOhEKFLcjcwUuUIisQGRf+ioTQRohHrv5qtX2bj8hnIPM
         BX31ek3Yw4nYOHD1j8sWXMb6TEAGe0tlVRTK++4wQHet//UPOdS0soDf6Cyns+MmUhq5
         0KIjBvmEMi/4jcEs7QqKNKyyKjObBVGlbOE3b20RRiHt9Jt1wuIbl89rb4MdNBGNKl5N
         lKEV3pX79Sk6CIPIU55LC9xo88/xW5rZdf22NJs3F3TmXwctZ+hG1yvK3vGJXZzouJ3f
         3TqGFO6g1nueLrHYCNfSdgfjUFwPHnzJljJYxHRKUnfa6jg40FJ0lNZHkVbcajUHty2+
         TZmw==
X-Gm-Message-State: AOAM532Db+W6Jl2X8vwKK0s4PSGbZT1czjXcOdNd7v1faEXETl/XF9D2
        ezjFsiuQOjwoCE2owy/2jWkjrA==
X-Google-Smtp-Source: ABdhPJzBZ8VRJHJo7828xeX1KUFyDAQHh9wAtm0lEBnQzY78Mj0gG5jMJBBqtkJDLPTI8tv+Opw0ug==
X-Received: by 2002:a5d:5043:: with SMTP id h3mr26038578wrt.120.1614765734353;
        Wed, 03 Mar 2021 02:02:14 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id z7sm3704954wrt.70.2021.03.03.02.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 02:02:13 -0800 (PST)
Date:   Wed, 3 Mar 2021 11:02:12 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <20210303091022.GA12784@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303091022.GA12784@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03.03.2021 10:10, Christoph Hellwig wrote:
>On Mon, Mar 01, 2021 at 08:24:51PM +0100, javier@javigon.com wrote:
>> From: Javier González <javier.gonz@samsung.com>
>>
>> Create a char device per NVMe namespace. This char device is always
>> initialized, independently of whether the features implemented by the
>> device are supported by the kernel. User-space can therefore always
>> issue IOCTLs to the NVMe driver using the char device.
>>
>> The char device is presented as /dev/nvme-generic-XcYnZ. This naming
>> scheme follows the convention of the hidden device (nvmeXcYnZ). Support
>> for multipath will follow.
>
>So I'm a little worried about the "support for multipath will follow" as
>this has implications for the naming scheme, and our policy of how we
>allow access to a namespace.

I maintained the message to follow the original commit. In this
patchset multipath is implemented. I maintains the same naming scheme.

We can remove this comment as multipath is supported in the existing
series.

>
>Ignoring some of the deprecated historic mistakes I think the policy
>should be:
>
> - admin commands that often are controller specific should usually
>   go to a controller-specific device, the existing /dev/nvmeX
>   devices
> - I/O commands and admin command that do specific a nsid should go
>   through a per-namespace node that is multipath aware and not
>   controller specific

Sounds good.

The current implementation re-routes IOCTLs to the char device through
the existing bdev IOCTLs, so I believe we follow this policy already. We
basically default to current behavior.

And I assume that for legacy, namespace IOCTLs to the controller will
still be routed to the namespace (assuming a single namespace).

>Which also makes me wonder about patch 2 in the series that seems
>somewhat dangerous.   Can we clearly state the policy implemented?

Patch 2 is the one that exposes the existing logic for multipath. How do
you think we should do it instead?
