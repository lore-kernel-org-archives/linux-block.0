Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2B5C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 18:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C52B64ED6
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 18:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhBXSp1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 13:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhBXSp1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 13:45:27 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA8FC061574
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 10:44:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id g4so2069265pgj.0
        for <linux-block@vger.kernel.org>; Wed, 24 Feb 2021 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P9aQpStscMGku60oH2hmTuYdF4P6Pwf73VuxOiTz16g=;
        b=uPjFK9+8QEwFHFhYGSLW/HvBbWmvpxRtPXqfa+zWMa4bwjJRsaiobgYrVg5GdjK3XR
         fzsC5dUwCzVf5/9s8/Ynm/7cSahGzinQKALF3PL1YPc0jK8UOVKnUz0ygPNBs0GdMbnf
         P8hmZVFHRYOMSh7kYPgN02kyCIxFAF9teQvZ3AWTULXCMSnOHs80XuSBl0KbGMRPhpQp
         xE4BEfZRQXIkMu7EDeWXZh6n57g5pRhSiVIKoy9tYRC91FzFQRTomofF2zoOpWbBQFmy
         2IkNxWBEUWuDbMFj5l+W+xWhl41ZF/pkSg4ZkDDmsmiauNDhynTRqAVy1IGYI2Mw8mC0
         i7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9aQpStscMGku60oH2hmTuYdF4P6Pwf73VuxOiTz16g=;
        b=PchgtKIrRU+ZzntW33Byk2ZI5QiDCRtK/0NI4Clq5MeE119XAVcFen6XRN5KPw5EZb
         gqwFYHPWu9IE7WeC0Fr+G/lgOv8PFrMOjl7Exa0X7dDXfUCvEkVauGx0u/SOzJx7gMbw
         CiEtJZ55QkAsPd/I2rWlitAM6gU+sOj0WLmS3gRqBHroKIGx5jqPAqsR3GHvxFwigfyM
         TLaEwBZ+0+UY/pIJKYpXjyVBe3mMeVNFfqjX8MqfEQzacJlTeVMyuUk4ysfY4hpMy2FN
         WxRHLOgC01GnIB9t25gWNB5U57XR90U8NvnI1eW2CN2ExqynIZy7unb9sytJ0jOmwnkm
         IQaQ==
X-Gm-Message-State: AOAM532HpTpkM446t2YJkZwlNv4IfhGYT+kDEWMkMkW7L4DRDor9R/g/
        a+jDgVC8Pr8pF4uiVFuaodGDijhza4UASg==
X-Google-Smtp-Source: ABdhPJwXNQ9x98vY4prYhSHoOKgJ+btDjgvYi4U+zcjPQwpsjYuh9eELs0I7mMXdiMsEMjEkm01QBA==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr15021933pgl.29.1614192284860;
        Wed, 24 Feb 2021 10:44:44 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id c24sm3664136pfd.11.2021.02.24.10.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 10:44:44 -0800 (PST)
Date:   Thu, 25 Feb 2021 03:44:41 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     javier@javigon.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me
Subject: Re: [PATCH V5 2/2] nvme: allow open for nvme-generic char device
Message-ID: <20210224184441.GA2626@localhost.localdomain>
References: <20210222190107.8479-1-javier.gonz@samsung.com>
 <20210222190107.8479-3-javier.gonz@samsung.com>
 <20210224164523.GB11338@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210224164523.GB11338@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21-02-24 17:45:23, Christoph Hellwig wrote:
> On Mon, Feb 22, 2021 at 08:01:07PM +0100, javier@javigon.com wrote:
> > @@ -1885,7 +1885,7 @@ static int nvme_ns_open(struct nvme_ns *ns)
> >  {
> >  #ifdef CONFIG_NVME_MULTIPATH
> >  	/* should never be called due to GENHD_FL_HIDDEN */
> > -	if (WARN_ON_ONCE(ns->head->disk))
> > +	if (WARN_ON_ONCE(!nvme_ns_is_generic(ns) && ns->head->disk))
> >  		goto fail;
> 
> Maybe just move the check into the block device caller instead?

Sure, then check for nvme_ns_is_generic(ns) will be not neccessary.  Let
me move this check to nvme_open() with only checking if it's head or not.
