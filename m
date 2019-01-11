Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11805C43387
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFA120652
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dYoqMfGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfAKSGK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:06:10 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:44411 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733214AbfAKSFj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:39 -0500
Received: by mail-pg1-f174.google.com with SMTP id t13so6602851pgr.11
        for <linux-block@vger.kernel.org>; Fri, 11 Jan 2019 10:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KXI71lrceaBNGaDQEEbP1H6jV0DXjuTfPVEN31a43AM=;
        b=dYoqMfGtVjQcNU+3E7MlVSdFQIvgSNQg/mKJakIfBrqnW9RKFdoiPrKG7ZUKNfRE32
         u1EK+uhVqSWdU/nGOQbiZsfBq0JxG35tVTlSFMYJ9eJ3w3ztKiVqXoNmR/7M7fSZOA7t
         VMiSFK/3kZf3fjlaBS+lZz6q0F/3FT2Tov0OdqT1z7L/OolEKex5RACWx6czaosgjcfM
         J9TdHCgAAJ0BIjB02r5X/CYzHvtLTp6M+jojXvJBMajpcL9QJwawgOlMyTAsN6m/nVq5
         R4vPmv5Mo4Ol+MWwFadFrp026X1FE4vniUwiMOrheS7yNlguxM9S4sVJaSO2TOVduFni
         nB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KXI71lrceaBNGaDQEEbP1H6jV0DXjuTfPVEN31a43AM=;
        b=W/70jIw19eMx/cCeJv/J/j9xJiFxLhV6Dp9jRZhZCC5fbDdsbw8otX5WUMVD6ZfNdR
         3lfqsyqBD5hYtiNfGQKL3TABk6s50ps1Y+wpgVGxchiWpHn71ZVIxRdlduVRyju2sWia
         U8TzDHxUhnf+2FX9Wo1NVhALCTeTSjRuDYOtkUxQSInDWZuxRBEIWs+31P/I+62JK7ES
         SNrST5x53AuhGpX3MJurLHetEnQPsiaknjFlo9WZteJKjWgrp71ndmFy2A/idZboDGtk
         6thsKYODNSpZ7/5QJAE1m56KWMXNcLtuX+FTL+2aD/zj54NwfMqW5gtF0cnZxRES+fUJ
         3QZQ==
X-Gm-Message-State: AJcUukfBlig+DWiLNAVtmsfM274jb/JvnPfjNVxUGmMqMuo4SWfPquBT
        ihIGeJVaA5MO1Rd1VwPvtBRlkw==
X-Google-Smtp-Source: ALg8bN6hkP1XScA/ClUQm56dxW8M+zTYWamzzwAqnEwtjmrrliIIMYBL5VXAZnVjl7jXwT3OAKAwZQ==
X-Received: by 2002:a62:220d:: with SMTP id i13mr15425956pfi.162.1547229938732;
        Fri, 11 Jan 2019 10:05:38 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1250? ([2620:10d:c090:180::1:fab8])
        by smtp.gmail.com with ESMTPSA id i184sm109108844pfc.41.2019.01.11.10.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 10:05:37 -0800 (PST)
Subject: Re: [PATCHSET v2] io_uring IO interface
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
References: <20190110024404.25372-1-axboe@kernel.dk>
 <fe686e4316f9746c46b91fd58c984531@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a4a23c7-7842-0a12-2d46-c892cf2082bd@kernel.dk>
Date:   Fri, 11 Jan 2019 11:05:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fe686e4316f9746c46b91fd58c984531@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/19 2:46 AM, Roman Penyaev wrote:
> Hi Jens,
> 
> That is interesting.  Recently I sent an rfc related to epoll uring:
> 
> https://lore.kernel.org/lkml/20190109164025.24554-1-rpenyaev@suse.de
> 
> which can be mapped to userspace and all ready events can be consumed
> from it directly.  I am wondering, is it possible to make some common
> API for all kind of ready events / urings, or it doesn't make any
> sense?

Not sure that's easily possible, even out of the two rings in io_uring,
the sq and cq rings aren't the same. The latter is sequentially
written, as completions come in. The former ring is actually indexes
into the array, so you can submit things out of order when needed.

-- 
Jens Axboe

