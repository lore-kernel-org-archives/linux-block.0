Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440D5C4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 17:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2582060FE6
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 17:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhHTRVf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233455AbhHTRVe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 13:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629480056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=84KgFhe0KBgW9+2WOyyInUYxCF6IYc93sWP+ad5crAQ=;
        b=h7BhHJdz3xDGnXbH4k1GHu5zFUUJVO4oS2XH7KM82FKMUd5aLRaLitgXzb37afdUFXZCu0
        2bW39U09UFtop2Z6PVbg9vf9900PbtdiDNl1rrYXwJBcKVchk8NBG9WIkSibtm+J+RkoeJ
        ebBLlHMaZ8uoA8zikOJbvd3LrUJyZ2s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-ojJxOMY-Oqqj55Rhri3TIw-1; Fri, 20 Aug 2021 13:20:54 -0400
X-MC-Unique: ojJxOMY-Oqqj55Rhri3TIw-1
Received: by mail-qk1-f198.google.com with SMTP id 13-20020a05620a06cdb02903d28ef96942so6907241qky.19
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 10:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=84KgFhe0KBgW9+2WOyyInUYxCF6IYc93sWP+ad5crAQ=;
        b=GrIzkRmWAWgcsPTeTlhDj6r9eGz2lrQJXrSWxYkPHKarCiN8gVXgzV3voDc6jshvfx
         RnEpM4gO9D7hQ15gsGGm9gGRndzXwCPNZqTkJkGmUNpr9qN5+O1L0G9MPc7uZVJMyAFK
         TqC0vOpVdCHJFP3CaONOzCNBaiSFjtefrmw9/Z5wJtsW9u0XcFtYTOXTYu/A/MDASKpl
         FiPLJ9QWCda+vgRP4k0MITbbv+x3QC8IgBZgLS3ctCwgdJkB8rpBKe7tmnHDQsCVFKSh
         VfrpuHGfmGqO+6pJMMwXTvNhXg+HAUAmJuZjg/zKM+rpMUKK+tgTVIQQEPOBmx7j47uN
         Jt5Q==
X-Gm-Message-State: AOAM531dAm6kmxzirDHVv/K2JBQ7YYB94yokC+lTo+FcxgPkx/TWJZES
        QdQmAv0CzMF+DlVLPl9EFPlzguQOnt9adzZazI8E6TCCZYiiHgoCEabpM2VfG8MUmKogbv3E38+
        w5cGHhB5qRr9XjD6K4Dq1BQ==
X-Received: by 2002:a05:6214:1d25:: with SMTP id f5mr19647879qvd.26.1629480054131;
        Fri, 20 Aug 2021 10:20:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoB15XBX7/Fzi8pLSIiqgllwujiL22ylqJXVxhPsYebX9mFnWITVQofFMC/yNTu6n9lJ7zgg==
X-Received: by 2002:a05:6214:1d25:: with SMTP id f5mr19647858qvd.26.1629480053959;
        Fri, 20 Aug 2021 10:20:53 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w20sm3258814qkj.116.2021.08.20.10.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:20:53 -0700 (PDT)
Date:   Fri, 20 Aug 2021 13:20:52 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        tusharsu@linux.microsoft.com
Subject: Re: block: add back the bd_holder_dir reference in
 bd_link_disk_holder
Message-ID: <YR/kdG/J0odIzGsF@redhat.com>
References: <20210820094929.444848-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820094929.444848-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 20 2021 at  5:49P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> This essentially reverts "block: remove the extra kobject reference in
> bd_link_disk_holder".  That commit dropped the extra reference because
> the condition in the comment can't be true.  But it turns out that
> comment did not actually describe the problematic situation, so add
> back the extra reference and document it properly.
> 
> Fixes: fbd9a39542ec ("block: remove the extra kobject reference in bd_link_disk_holder")
> Reported-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, thanks.
(btw, your linux-block cc had a typo, Jens are you able to pick this fix up regardless?)

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

