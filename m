Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A11C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 12:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C036525D
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 12:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCIMm5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 07:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhCIMm0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 07:42:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD07C06174A
        for <linux-block@vger.kernel.org>; Tue,  9 Mar 2021 04:42:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso5917117wma.4
        for <linux-block@vger.kernel.org>; Tue, 09 Mar 2021 04:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yQ9Tmm2gIeDEXy/XW+0pX8KjL1wB8WvlsRUFdFPh2n4=;
        b=AQqxydTa7hr/fy+3OfSd0FUs8oA+OYYms1kHhyS6B4WaVovEwShZee+UEmzPV0ezAf
         OpHA0SAgP5/Kaiuq/53Hlwskd3/i2HlzdoaQDTiHFAAC9EwPuaE9QGufDJg1l448+uV7
         AOExI7iSEScVhuKtx+yPv2FuQy/oqvrvxAZ/Aa9M0M1tYf17+3DljC4OuWIfwRW+zCyL
         3Nh30feQK8bN1GLGfPsPguFyWPgLQYdljdIV59PBKzM2zqY7op4tYv+N7BIa1VzDEkzi
         ew7Cq6kaCsqrVtoddCTSDe+Vzb8knpReGtiAfdIAVRSmeIX3syKBKrJwPlhQsTMIYQFy
         HL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yQ9Tmm2gIeDEXy/XW+0pX8KjL1wB8WvlsRUFdFPh2n4=;
        b=cnrZRHuFwbTp89g7b1qVsaqroZHvYaVJhukgZniLkOARAR7bJwm5I8W45hncZ2HXru
         7b2bMkpDsqG3+PR64z5fqIaJTybXQDgjl8FdjTQvqhdtfZFQliSIi0IbUInYu0QadKhc
         rDQXSlg379SNKlTVQvuZP/01elx6ZIK0Z7EsMDOo3eVR9gmeLO29ysWAMiGLpC+V2b3N
         fFEt6yl5/0ELzxaFAKdc6uU0BbkhBG4zYr5vQPsy2rgkEWis+RYqoNc4BEVNZlZ6cubT
         tJsWYdcVvd8FjijbPPm4coR62/7NBhFGNKBpaznLJ1BX3mNeh19dpNU+NttxkvrNgHQy
         MG7w==
X-Gm-Message-State: AOAM530ylM9MR5jF1I3e+Eonttd31ZuRFjN4oHbqpmsqtb/ZavXneI+P
        yHn5jAlyM0uhggGESFBBCpajEg==
X-Google-Smtp-Source: ABdhPJzT5v9Q8cRmtdG3cuTjJZWrMzv00SusH5ZrPUPYuSE3lKxZ50rCN6bpW7sEfq34HrhqEEZ+ew==
X-Received: by 2002:a05:600c:198f:: with SMTP id t15mr3873457wmq.8.1615293744941;
        Tue, 09 Mar 2021 04:42:24 -0800 (PST)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id v18sm21351788wrf.41.2021.03.09.04.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 04:42:23 -0800 (PST)
Date:   Tue, 9 Mar 2021 13:42:23 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210309124104.uowad6bd4vlcthmw@mpHalley.local>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <20210303091022.GA12784@lst.de>
 <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain>
 <20210309113103.GA9233@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309113103.GA9233@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09.03.2021 12:31, Christoph Hellwig wrote:
>On Wed, Mar 03, 2021 at 11:02:12AM +0100, Javier González wrote:
>>> Ignoring some of the deprecated historic mistakes I think the policy
>>> should be:
>>>
>>> - admin commands that often are controller specific should usually
>>>   go to a controller-specific device, the existing /dev/nvmeX
>>>   devices
>>> - I/O commands and admin command that do specific a nsid should go
>>>   through a per-namespace node that is multipath aware and not
>>>   controller specific
>>
>> Sounds good.
>>
>> The current implementation re-routes IOCTLs to the char device through
>> the existing bdev IOCTLs, so I believe we follow this policy already. We
>> basically default to current behavior.
>>
>> And I assume that for legacy, namespace IOCTLs to the controller will
>> still be routed to the namespace (assuming a single namespace).
>>
>>> Which also makes me wonder about patch 2 in the series that seems
>>> somewhat dangerous.   Can we clearly state the policy implemented?
>>
>> Patch 2 is the one that exposes the existing logic for multipath. How do
>> you think we should do it instead?
>
>So trying to follow the code:
>
> - nvme_cdev_fops implements file operations that directly on a nvme_ns,
>   so they are path specific

This is correct.

> - we allow opening them even for a hidden controller

This is also correct.

> - there does not seem to be a char device node for ns_head at all.

Also correct.

We tried to keep it simple in the first iteration. Am I understanding
that you see necessary to have per ns_head char devices?

