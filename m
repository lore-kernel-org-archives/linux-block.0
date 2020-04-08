Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40A5C2D0F4
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 22:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FF12078E
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 22:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="zXHn27oS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgDHWFk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 18:05:40 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52288 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgDHWFj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 18:05:39 -0400
Received: by mail-pj1-f66.google.com with SMTP id ng8so413407pjb.2
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2020 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ludTOzVGbLylg68o0etdVskjjKZx1JhplvRfJs80ekw=;
        b=zXHn27oSky65QGt00abCsmG+jxXH0SqaGK7hsfqoWYyev5zG95f4w1+AtpaR34FSPA
         FYIdZPsTi96cRp0/yh8BHptHboU9l4++ZkFcHhFENhgSRHjkyGtGJbnCx3vkw5EX+aQX
         SyIssUyX06VtXCr1/DetOd4+7DKcXr2SEbJqHPmQS3tpP+HXshTm6njgldirl08yVQlO
         yilzgVArtpBS2SbdZji9Y3zZ9nDN8djA6rgHAg3QHvh50hGDxdd7/DRQghOUBaKa3T/B
         yUX2wDdbzymxna04VDWBAeY5qSFf5ejHKZH+Pr0QAO7d9a7ffQdlcVVh08XsH4rr8U+3
         Inog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ludTOzVGbLylg68o0etdVskjjKZx1JhplvRfJs80ekw=;
        b=B6ESEvP29PIr+C78u7nt20nvsUsNHdNAaoS+ByV1cGj74C9lOdMRMkvWb869eHXNRS
         NTnIWiciKZcNGrLv8huyczH1rCTSFUC3ekp0yD0Sr1/XRkuNFiH19YX7NgpENNoppRv6
         50FrkOoFBfzwa4X2Ko4AxcChTDW+ApEikVx6tUOlkEAZqk/M8COeByj6JW64sGMDEsGO
         LbrB4f1GpgK141VCn3rqZxEtHy+AV+POkQn2hGPDhCymGOi6RPX2+H23qha1w8bdZGpn
         4ewlNnEAGFfK00RLKhqv24su8bqoZgMTeCVUC3k3PmoxwYKCrkGwik4dTuK4aVfo1PmF
         oqsQ==
X-Gm-Message-State: AGi0PubKTRMT8tY0fCHMxmwhOzcj/MxAAo9HHvagy3zdmMvRDAl8pDNB
        byHY4NGuesXCnTUhxF+Tk2dbmA==
X-Google-Smtp-Source: APiQypKlrftZjGluWVf0Hm/bIiqnxH81m2XULcfulSVVJ3Tpx4MRY+pi7+CDaiwxma7D4hBeiEWjJQ==
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr8625753plb.255.1586383538366;
        Wed, 08 Apr 2020 15:05:38 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:9008])
        by smtp.gmail.com with ESMTPSA id d14sm17606765pfq.29.2020.04.08.15.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 15:05:37 -0700 (PDT)
Date:   Wed, 8 Apr 2020 15:05:36 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests v4 0/4] Test the blk_mq_realloc_hw_ctxs() error
 path
Message-ID: <20200408220536.GC226277@vader>
References: <20200328182251.19945-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328182251.19945-1-bvanassche@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 11:22:47AM -0700, Bart Van Assche wrote:
> Hi Omar,
> 
> Please consider this patch series for the official blktests repository.
> 
> Thanks,
> 
> Bart.
> 
> Changes compared to v3:
> - Addressed Daniel Wagner's review comments.
> 
> Changes compared to v2:
> - Addressed Omar's review comments.
> 
> Changes between v1 and v2:
> - Added three patches that refactor null_blk loading, unloading and
>   configuration (Chaitanya).
> 
> Bart Van Assche (4):
>   Make _exit_null_blk remove all null_blk device instances
>   Use _{init,exit}_null_blk instead of open-coding these functions
>   Introduce the function _configure_null_blk()
>   Add a test that triggers the blk_mq_realloc_hw_ctxs() error path
> 
>  common/multipath-over-rdma | 29 ++++++---------------
>  common/null_blk            | 21 ++++++++++++++-
>  tests/block/022            |  3 ---
>  tests/block/029            | 17 ++-----------
>  tests/block/030            | 52 ++++++++++++++++++++++++++++++++++++++
>  tests/block/030.out        |  1 +
>  tests/nvmeof-mp/rc         |  2 +-
>  7 files changed, 84 insertions(+), 41 deletions(-)
>  create mode 100755 tests/block/030
>  create mode 100644 tests/block/030.out

Merged, thanks, Bart!
