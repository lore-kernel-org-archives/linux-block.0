Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AF9C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 10:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbiFOKcL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiFOKcJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 06:32:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E031E4B87F
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 03:32:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so1682736pjl.4
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 03:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MKCQ4Kven3aZ8G3GecuK409NOxVitL3Lqc8x7hcJkoU=;
        b=iTcRIcIbnLCdeGlgrkirIVgRJeBH+nlWwf7x13mBYVrBtNxFKTbAUeYa/jM56Jdtp8
         WdZiIaE4N8Q7vDSLp4g01MG5mXrD6YRvOpSM93OCEKApJfMw4SHpizmdGRxmYXXXgqwP
         Wbl7qLYJ4bdqV9oNOULGuGxcJcOirE/7KE0Weta+U3KB5zmBLZuq23MC+kW9k+bclwKC
         T60iInSm03ojcM8THbhGywIRF/hoMzpv4wNk2VTBAdE2oxJ+HVLeEYAoHo7M3MXP2Zkg
         M2Mkbbr4hwm84brGmqE7DAY5nFkOZJrYPb9fiN+DA+3BxPFSxAGdI5y7SFo19hzB1UVZ
         0ZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MKCQ4Kven3aZ8G3GecuK409NOxVitL3Lqc8x7hcJkoU=;
        b=PU9EIPDmcszFg/jcw5iTi+mH4QltF9KZZy313fNb+4NgKYW1WALb4QLh/VfpR9NIry
         6zWKVsifaU15zB/GH2KHO+iMeLY+tBY1WHeeKuxZsLhAkLBk9Z3HKRSCsSGeB9oLmlVc
         DFtKt1d17Ub69gJj7wUNPM2tQGO7B5a3nppRZkBTVfu1eUvuIBFZ34GgedcmMLevO1J3
         UBkj+eDMOyyNurgW89WN0psvnCs5DPyjQIAShnDmxX/usVsTPoeSAs0JYW27TR8ux1Eh
         TO32b15Mdb4BXrjFLt8T+bDR/eYQkO1PXmeX+8tB5rkK3yaKSmY4riKWvZSHlMrHI4Us
         FoEw==
X-Gm-Message-State: AJIora8IQ9Lja/26cREAepDU00Xest2WEWkqIFYY1dfUEyY4J/Q88n0e
        wueOWLxr6KnNAYOVwH3Bvx8=
X-Google-Smtp-Source: AGRyM1uaXQV3dVsMinLRj83h6vlRejswI4fVrPUeCXkrCTf5O1ZXq5QnAxKVyEkUrwDC2AbAmOsWRQ==
X-Received: by 2002:a17:902:eb8d:b0:168:e324:f0a3 with SMTP id q13-20020a170902eb8d00b00168e324f0a3mr9025285plg.56.1655289128345;
        Wed, 15 Jun 2022 03:32:08 -0700 (PDT)
Received: from localhost ([122.183.153.161])
        by smtp.gmail.com with ESMTPSA id y15-20020a170902d64f00b00163cc9d6a04sm8919738plh.299.2022.06.15.03.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:32:07 -0700 (PDT)
Date:   Wed, 15 Jun 2022 12:32:04 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/6] block: factor out a chunk_size_left helper
Message-ID: <20220615103204.qck26yl2svict7ah@quentin>
References: <20220614090934.570632-1-hch@lst.de>
 <20220614090934.570632-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614090934.570632-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 11:09:29AM +0200, Christoph Hellwig wrote:
> Factor out a helper from blk_max_size_offset so that it can be reused
> independently.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blkdev.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
