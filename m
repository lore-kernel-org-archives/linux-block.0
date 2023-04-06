Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91524C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 05:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjDFFPM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 01:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFFPK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 01:15:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C968A66
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 22:15:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id le6so36501035plb.12
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 22:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680758109; x=1683350109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uw6zlP/g+3SJKo5U7eCIo+BlN/XnfSbZX1rCCG9M9s=;
        b=KUSJaRPCt604LcWsLV+BKW9oRw7PHUCJjE5Y1DUr1hggPcxqo7FpF2GtjscJorsWmM
         q9vgC3F8AUQyRy4cIgzzvC2BEGMK7CI8lBW9BEolUwE7A1k0V5pkDanxsVzlSeWrTaam
         z17xT3KHjdiykaHOLuf6KHUf3TcXmGKq7YJa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680758109; x=1683350109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uw6zlP/g+3SJKo5U7eCIo+BlN/XnfSbZX1rCCG9M9s=;
        b=1/Ruz8gxB6pue2yMF5AWFi5itNbBIxFwEA8T3u+qir3+sFJYQGQ9eHBF5Zc5IEzt3A
         jVX/+2MUTtZqvUexFWp2fhFLsqNLuxgjmMOOS65BrMzKRiC0QNPVYP5XnNnuFmEvcSbQ
         DKLufqTV7FlSHWoqxfLRKBdSpye3/zLRIG418Bx70zzzVvVl/CY6j1MEBMahmOBXj2sv
         E6A+0VynolsgWGkGQH+ogJ6X57VwObTClwhwj3H6Q2oTMBxLDJaIxwvy0gsaCUFDBOkn
         daxww9tNvuV00GqO3f09bytVtPrqLR/x01DmO2yfWdqwT1C2X2yToMIw3te9NERPEd7R
         wS9g==
X-Gm-Message-State: AAQBX9fLn6Mj8dag9OSxyOrrQZ50Jf+3oNY46BGH4ive6/ZxtOak9ldo
        YQscD6Mo2i+6p7fEuAadpEHVfg==
X-Google-Smtp-Source: AKy350bCYVveGzVTCpTe3kx9jMQPUSIQqXgQJa4XI3gDNd9/lpJs6SYg7m4e9ZLeQnChaTPRKtpoWg==
X-Received: by 2002:a05:6a21:8693:b0:de:13c4:5529 with SMTP id ox19-20020a056a21869300b000de13c45529mr1695897pzb.62.1680758109586;
        Wed, 05 Apr 2023 22:15:09 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id v7-20020a62a507000000b0058dbd7a5e0esm311751pfm.89.2023.04.05.22.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 22:15:09 -0700 (PDT)
Date:   Thu, 6 Apr 2023 14:15:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 12/16] zram: refactor zram_bdev_write
Message-ID: <20230406051505.GB10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-13-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> 
> -static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
> -				u32 index, int offset, struct bio *bio)
> +/*
> + * This is a partial IO.  Read the full page before to writing the changes.

A super nit: 		double spaces and "before writing"?
