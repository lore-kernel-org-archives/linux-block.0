Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B3EC43214
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 23:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7465361027
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 23:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhHaXnB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Aug 2021 19:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbhHaXnB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Aug 2021 19:43:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACBEC061760
        for <linux-block@vger.kernel.org>; Tue, 31 Aug 2021 16:42:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 17so893754pgp.4
        for <linux-block@vger.kernel.org>; Tue, 31 Aug 2021 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kvzhf+3RsKiOClW18InqWDffCAEpvbvcEytauDg5dBI=;
        b=clXSDUEgN3jUuMOzV1jXXOX+LtpeGDWxkgPu3htj+QLDQjdRePj7tEjTY9srirtNZH
         M2jbpc85QPlacRGba7QPm8kPk7xZBQy+bI9/dZfKegvID19aZeoFRkfb8fEinkwvlCEs
         3SAgV67FuXW8ykJW/7LdcZ7IEsTHoicEooQrETjf+RQ0BXWJwjBwHTnHtWFD+cdrM0j6
         BFaNOXsR7vZx+IN2HRrRac0LJBpwBCRP4mb39C/xCj+lK0KA1aS0Dljht4NuAvqocB6P
         PLUOCsOcNdALS26Atq/5kyj0NOLXk0w9f2mPlOF23ViMR/YK26AtdQLoUc7CgjsYxwkX
         iOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kvzhf+3RsKiOClW18InqWDffCAEpvbvcEytauDg5dBI=;
        b=uPsCkgXvFCGXFJ/PhrLQupcuwzi20Id+LUlpFrqjY4SPonolj/bU+seDsoWhVmrhtG
         GqFXc5PTJIhVGc6uWOwZaZkpVR5XERE70qLb9v58z/qiL+NMr/lVsDkbePA180srZARu
         En08tSVRRz4dymfPnUttnbgEpdifeTSRnbYgv94YIti5rdE1wYeP8+cC8YzCSHoTx+Ez
         63UvYz5xhthCbS0a8yAcW6WmnePHDE+Fd76VE/zrHIbSgi4PMtyySzDXfJ4d9yUZelfq
         yyL4qO5HNrloTMKxZC9SRNVGUU3d37YUMpxs+vPc0ySZXw2u/IIrChHfKDbmXazFzxAM
         ZJyQ==
X-Gm-Message-State: AOAM532YzQswXwWZTnz/kMuxv/tk5Wj7WwoNVS7RvaLyvNoepmK4iCoA
        uHTW7J8vjTr2ZjdHXT/yA17qPeYBZtvbfA==
X-Google-Smtp-Source: ABdhPJyjdl+hJ+P2YnLvZ1VDeLEu0NHMqXllx25IMHTtgvB51JsuN4A7S+LmNwAR2Tba+Q0KcCTt9w==
X-Received: by 2002:a63:e50a:: with SMTP id r10mr5401421pgh.84.1630453324780;
        Tue, 31 Aug 2021 16:42:04 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:3f9a])
        by smtp.gmail.com with ESMTPSA id b17sm22058104pgl.61.2021.08.31.16.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 16:42:04 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:42:02 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] block/001: don't exit test with pending async scan
Message-ID: <YS6+Skn65PQTeZDt@relinquished.localdomain>
References: <20210830023844.1870471-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830023844.1870471-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 30, 2021 at 10:38:44AM +0800, Ming Lei wrote:
> We have to run scan and delete together, otherwise pending async
> may prevent scsi_debug from being unloaded, and cause failure of
> 'modprobe: FATAL: Module scsi_debug is in use.'
> 
> Fix the issue by always running both scan and delete together.
> 
> Fixes: f3bcd8c ("block/001: wait until device is added")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/block/001 | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Applied, thanks.
