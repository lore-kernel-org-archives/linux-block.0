Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B636C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 21:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB7624672
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 21:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="LFRZsR9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLSVri (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:47:38 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52104 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSVrh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 16:47:37 -0500
Received: by mail-pj1-f66.google.com with SMTP id j11so3142906pjs.1
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2019 13:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N8q92WQU1dx8IPzReTKY++APFp6A1/GLCW7izPc9ebA=;
        b=LFRZsR9TvlJy9z9dZNy8laCAxwxp+uJyNaS/qU2SGzDpLjOXKgzfQG+rjteL77yGnT
         0brwKOSKuR5ozlSwzwdISS4x9xdFmegxTE2bVNkhRQs6yFLrwv16q4tEpOfuUbyJzuqP
         SG5fdRNLFC8RPU6MvpRBXDwdi6qa3kSol6psfKW93AHv0dVsrxuYsWrxoudGniOEUcLJ
         ANDeuGu1u+J76Ezomx3XxgaygXMdS8yFqImbfiIX8Bqr73nleLC4VXJzup+dYjI8+dpX
         qkSQuA/YiZ+R79nlSQp9UPXmALNEwdn6X/0BDfFrGukXk5TGYWTNX1Yv7rS3nF/0msqD
         mnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N8q92WQU1dx8IPzReTKY++APFp6A1/GLCW7izPc9ebA=;
        b=DeNVgpe6HGIwY4NvpyVDf1LaZKAErPTL/vSuOCeNdg5aUvUAjvbf8tQOJ/t1Mj7wfT
         /sGQ/hEmbyG6eIG+At1aojOQRLcW7ibCij1hqZcvdaH7Lxzl7iifyZ6/rcsNqF975csh
         UGcY4Elv+dBgW2+LUMmTI9fKktnNIDxVvirTxvX43QEtG7ForqqiriVf44cT7jHNGeY4
         5hXnZV1McVgzwK8Eh7IX+pEy0nzNULfW/kM61RKOjM4O545SNxmt5zP/m/6Foh4FjEL1
         XKozWSLARHCMFjI3amL0JZpbr6rLKP5/OCQ4OhcFvrzoN7VgufhrG7QY3izZAl1Qhgpp
         4fwA==
X-Gm-Message-State: APjAAAVnPjlh0pWx62hHpGYfMPzCtMvE97ftbiCX1OS6ZaSinAGu2TVC
        khvHPtHPURY/BjKfiqoZ++pbog==
X-Google-Smtp-Source: APXvYqwsOxTYtNyS825AbcB23gWzKQgnEe+Z8TsxlsXkPuBsBalZdm9XS7YGpvLzMGH6ek7G8mNTyw==
X-Received: by 2002:a17:902:ba97:: with SMTP id k23mr11214225pls.343.1576792056826;
        Thu, 19 Dec 2019 13:47:36 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id u20sm8078894pgf.29.2019.12.19.13.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 13:47:36 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:47:35 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add an SRP test for the SoftiWARP driver
Message-ID: <20191219214735.GA830111@vader>
References: <20191213143232.29899-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213143232.29899-1-bvanassche@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 13, 2019 at 09:32:28AM -0500, Bart Van Assche wrote:
> Hi Omar,
> 
> Recently a new low-level RDMA driver went upstream, namely the SoftiWARP
> driver. That driver implements RDMA over TCP. Support has been added in the
> SRP initiator and target drivers for iWARP. This patch series adds a test
> for SRP over SoftiWARP. Please consider integration of this patch series in
> the official blktests repository.
> 
> Thanks,
> 
> Bart.
> 
> Changes compared to v1:
> - Only run the new test if the kernel version is at least 5.5 (the version in
>   which iWARP support was added to the SRP drivers) and if "rdma link" is
>   supported.

Hi, Bart,

Is there no way to detect this feature other than checking the kernel
version?

Thanks.
