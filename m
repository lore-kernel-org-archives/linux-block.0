Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF42C433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 21:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9EC620E65
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 21:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="u+ajFCQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgINVxz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 17:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgINVxx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 17:53:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC46C06174A
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 14:53:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v196so716430pfc.1
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 14:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fdb1+XGdJXS/95f0xuZP5+Vca+20dd59IHhXELw6DQU=;
        b=u+ajFCQXDkBPYZlp+creOqB2OGBwcENucojKJ+6zyQ6YL9TIZwPFwpH3dpOaL/6sFB
         FWdTKjUsVdkOWqLYSWSHqmq0AIzb8OBAtCPeJeWF953gBrElO6UUTSeKgH6Gawo6UGdL
         mNoddAeIPVNdRD86K2k7eQon5wA19C+am2KVpUHAVYB0lrOQwlG92kk4EOoKqlXIYem4
         BKvQaT+4pbVPmy59NcR+Ldn+DsCwY+i/Ozh4ChU+8jFMbC7qTsUGpwdxyOftFDYfczpF
         NNQo984Ee7fx5xsHqekOC7fPMxGG6YMBj1asJpqWJozfRo1ySEE39Ldgm+TEXARlE62+
         F/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fdb1+XGdJXS/95f0xuZP5+Vca+20dd59IHhXELw6DQU=;
        b=pV7qTJWztNVXywvOuYHBor7tcr5zxnEn55rpGYt+GIHRIyQTcb+DtsEMgg7C484KD0
         2YeSKDE6FPJiCC3Eqa9huSGem9qLkw56RzShDz1eGvVaSsJoyGNASF7Wk80i3ynT9M6F
         KwB4OTFI8DcmoDN+qIdfukI+Q47xSXXIOaoa7n0TinbbEf8lWRp3xFxd06smTQx+R0um
         GAC+68SACKJhNKagH6mU91z8awswIRJUpvlB04Q3H/vD2mS6QfUwJZN1+Us4bwJYGhxg
         gToNo+C3VmVqmhtArme2VRVlRMRWQUPqmxbY3E09rd2aHbhspIwKHVj1/IDLQzvlSrX9
         UiyQ==
X-Gm-Message-State: AOAM531rpfC5YA74PABZZQptuXuEnchU2Prwb+LG5256Sj8dQ4O+WaT8
        /lY5RK6vZ0I/QdeGJOzajN7/REgAQqMM7w==
X-Google-Smtp-Source: ABdhPJyG94WN0xI3WIghEToJNetpl5TZS1fqBsjfp6yghrnCYrxDLXvtjpiZGvP6iR/Aq4ObLgUuFw==
X-Received: by 2002:a63:1c18:: with SMTP id c24mr12444689pgc.30.1600120430301;
        Mon, 14 Sep 2020 14:53:50 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1687])
        by smtp.gmail.com with ESMTPSA id mt8sm10140102pjb.17.2020.09.14.14.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:53:49 -0700 (PDT)
Date:   Mon, 14 Sep 2020 14:53:47 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 4/7] tests/nvme: restrict tests to specific transports
Message-ID: <20200914215347.GB148663@relinquished.localdomain>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-5-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903235337.527880-5-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 03, 2020 at 04:53:34PM -0700, Sagi Grimberg wrote:
> Protect against running tests with the wrong transport type. Most tests
> cannot have nvme_trtype=nvme and discovery tests expect the $trtype to
> be written and verified in the .out file. Adding a couple of helpers
> to restrict the transport types in tests.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  tests/nvme/002 |  1 +
>  tests/nvme/003 |  1 +
>  tests/nvme/004 |  1 +
>  tests/nvme/005 |  1 +
>  tests/nvme/006 |  1 +
>  tests/nvme/007 |  1 +
>  tests/nvme/008 |  1 +
>  tests/nvme/009 |  1 +
>  tests/nvme/010 |  1 +
>  tests/nvme/011 |  1 +
>  tests/nvme/012 |  1 +
>  tests/nvme/013 |  1 +
>  tests/nvme/014 |  1 +
>  tests/nvme/015 |  1 +
>  tests/nvme/016 |  1 +
>  tests/nvme/017 |  1 +
>  tests/nvme/018 |  1 +
>  tests/nvme/019 |  1 +
>  tests/nvme/020 |  1 +
>  tests/nvme/021 |  1 +
>  tests/nvme/022 |  1 +
>  tests/nvme/023 |  1 +
>  tests/nvme/024 |  1 +
>  tests/nvme/025 |  1 +
>  tests/nvme/026 |  1 +
>  tests/nvme/027 |  1 +
>  tests/nvme/028 |  1 +
>  tests/nvme/029 |  1 +
>  tests/nvme/030 |  1 +
>  tests/nvme/031 |  1 +
>  tests/nvme/rc  | 16 ++++++++++++++++
>  31 files changed, 46 insertions(+)
> 
> diff --git a/tests/nvme/002 b/tests/nvme/002
> index 955f68da026a..ca11c11c9a09 100755
> --- a/tests/nvme/002
> +++ b/tests/nvme/002
> @@ -12,6 +12,7 @@ DESCRIPTION="create many subsystems and test discovery"
>  requires() {
>  	_nvme_requires
>  	_have_modules loop
> +	_require_nvme_trtype_is_loop

Same comment here, chain these with &&.
