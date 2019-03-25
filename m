Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AC0C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 17:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863542087E
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 17:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="aBmxi0ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfCYRlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:41:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44335 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfCYRlS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 13:41:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so6912016pgj.11
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gTndVCA/vSpAvpFQRyHPkl2jyiowbQwgMRk+KOixUGo=;
        b=aBmxi0ieQirXtxGG+mgXmOLIkjy76+D3CnScTUmA3cS9llQwVDog57Lr1+Jc2cuq2i
         xPdSXbSNaIpcqSN5QCv8JBYdWHbeDPvbUvxgEolSuv8pDvaXByk49jZKjU/Xod1t1GAe
         36/rMcv0Dmu2b5LX0SRGLFuwk9VARKeLtAqKzFnt+fz7qMkpdU/Pq+mv7QgAABYJUkzd
         igNe0E6ySkqcFWeapxA3giAOIcJYQoDlQ/TCh+l3SFe6D/e1FLXqlM4Ftsg1I0G9+Lsk
         Qu+WVCOdaso30gTmLYcej+TcWo0Vd2RKEGfumH2h9DSOdoZS6hnN5CjekjJKFtPcKnjT
         uA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gTndVCA/vSpAvpFQRyHPkl2jyiowbQwgMRk+KOixUGo=;
        b=oLT3eYSDlWZ5Ky8jwAA1KHQ8tuX1WwEVAQYyfZSaFNLpOkXkmf4RkAReAg53mk0BSF
         ddkGbdg8wvrE/fI0wFPaKxK41qv23aFC+ORd3WR2ROi5PV4KRv27z/43YrssycQZugjV
         lbEG8ftLE0r/qn5uLxKX6y/v2HQ5iKvjeW02CU+4FiSJo0qWoYVJ91NWQpy/OAj4ieM/
         RaOgZGdnmkARZdcp59NIWrZVJVjTadV+0rJHp26FLSaUt1ebugjAIeN/gqXeDD+tYCRV
         fI12RdnBefEXoNktIfJeEpeNJnogMljn6FmzuHRq36KvYMwq+yAeCYX5ILl6+nUd0aWy
         B9QA==
X-Gm-Message-State: APjAAAWiftf5SrVYfxbj8aHekPRV0L4tHEwmlKzZdDJhMAqktKq5gzot
        kxAi6MipPY2R171m+eRKkKPirg==
X-Google-Smtp-Source: APXvYqzfuohSk68GnFI9k59zAzLS9QNeGAuYJT2o//j/B8YWJTZncDhZdLnx9M8TAeKDqTS/vwufhw==
X-Received: by 2002:a63:4750:: with SMTP id w16mr24957671pgk.256.1553535678076;
        Mon, 25 Mar 2019 10:41:18 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:b619])
        by smtp.gmail.com with ESMTPSA id h65sm18947134pfd.108.2019.03.25.10.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 10:41:17 -0700 (PDT)
Date:   Mon, 25 Mar 2019 10:41:16 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     osandov@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] check: add zoned sysfs node checking in
 _test_dev_is_zoned
Message-ID: <20190325174116.GC5826@vader>
References: <20190322081228.21898-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322081228.21898-1-yi.zhang@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 04:12:28PM +0800, Yi Zhang wrote:
> Some kernel may not have zoned sysfs node, e.g. RHEL7, checking if
> it exists first in _test_dev_is_zoned.
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Applied, thanks.
