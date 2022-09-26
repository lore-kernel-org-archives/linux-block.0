Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4D8C32771
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 21:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIZV0o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIZV0m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 17:26:42 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD90EA033F
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 14:26:40 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f193so7738508pgc.0
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=kY6hbyrj4Er2hMaNY2bVxSrD12p1k4UpnFr1DNG+xVk=;
        b=H+0WbV1z0E40WB/I8Y+Yr4ZsRFxov0VzhWnvoRKBSt5i1JhCdfP6MT0ycpmp/ePG7g
         OyZsJmqRq220VC3Xu0Hpgj1cnxGFMY98OeH+uUz5TKG3/iskcPksu3hsGcuTV2QYwMGH
         Sb92A3FglUcveEZHrmFCrXDcNqNhXBg8eauFsk1+hxhM0wGgv8wx+8mPS0ydjovBRKIU
         6T6iKaApTW7ccvOk2Y2Hhmp3Pf/28JKEqfJyLy4OozGl1/6r1Z0/WdVc+gb8NfCijdG/
         tn4ErtxeASF+kBV2tp9D2aOHQaMM1TM3ocqOSRYP8ZIF9Bg74zk5+xRYuIZn3Hh7bKQB
         jJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kY6hbyrj4Er2hMaNY2bVxSrD12p1k4UpnFr1DNG+xVk=;
        b=G+FRUZY3qVCdpsFYUPk0nkUTuWYX2v5iKB9eOUMXeWG4FhN5u61eCQI0mT5r2i5tqQ
         9OVY7yUkiMEtPktgFSWizlRDAnkJf5DKECwuUUKeQ45/luF1f9PWtoXwBIrJJetIsgf3
         e6N+rLgRV8/akXGIzr9pMtIWKCX1xlgYRgbsz4K/i0ea/tGlgmexhSzzIkb8igy06xEV
         QOOrhObfCjg6HimGrxnPfc78zIukwtEvRRrKIBAXnuTU9mcFzrulRBzqo7C1ub5I52OG
         M7y8MmE9H9PRRdsd/PmIOPHj7EiEAjrPzgR3ONR647YvF2XLUJLmVcchv+utRvJPvD2G
         qVDw==
X-Gm-Message-State: ACrzQf0valDL5w4RdG/WG+HLuNaACRt6eSDozFQC8yO6cOETnjJ6hJ7v
        yeRdfttU+eUyHZtbTiGDQxh+lurkO53HPg==
X-Google-Smtp-Source: AMsMyM5+8V1BSA7fUOMm2X2B/y1+nraP/lpe9UjfRq2pYfU7l7bDWgvLyMkM7sa4e4t/LOrpV6e1Kw==
X-Received: by 2002:a05:6a00:804:b0:544:9d05:60a2 with SMTP id m4-20020a056a00080400b005449d0560a2mr25778336pfk.57.1664227599194;
        Mon, 26 Sep 2022 14:26:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a7e])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b00176d6ad3cd4sm3661222plh.100.2022.09.26.14.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:26:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Sep 2022 11:26:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: blk-cgroup cleanups
Message-ID: <YzIZDT6Kz8AAWiTP@slm.duckdns.org>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Wed, Sep 21, 2022 at 08:04:44PM +0200, Christoph Hellwig wrote:
> Hi Tejun and Jens,
> 
> this series has a bunch of blk-cgroup cleanups and preparation
> for preparing to make blk-cgroup gendisk based.  Another series
> for the next merge window will follow for the real changes that
> include refcounting updates.

I only had a minor comment on patch 5 which can be addressed later. For the
whole series,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
