Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB90C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FA420838
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="WXtLRXVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfBTSWb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:22:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36152 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfBTSWb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 13:22:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so12280084pgr.3
        for <linux-block@vger.kernel.org>; Wed, 20 Feb 2019 10:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oQA8pQFveG9EbQE4VG24sxKhAlZzk3AuMgVQEmloGR8=;
        b=WXtLRXVE+CHclI+ejnJPx1w94p22hDf+XwSQLbIJmNb1agSXA/xhQA8RLh4LpVoM6T
         GQzZeq8JWq1MysATHjzTDNf583pWjrsgsktd3zcJa2F3GBGdX3c71YWME22FqynmgJsp
         M3uKpb+2Hvve50UZ/xqM2ARyz6ahr9QqDYsgAPoL+oVtU2+okqTLVtimgASNaSUVueEd
         TA3+n/axCHb0UERXIFaklEe6l3a6nt+Mk2VIcYlZUqpFCwGKySsC0Sv2mM2dz3ZbyuR0
         qe4/6mmuG+qdpGgBEG/rvPwnCJXtyI65kbVJbm+RX8+3+ksN6c8+dm1tqvHpraZ4Ll/N
         H2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oQA8pQFveG9EbQE4VG24sxKhAlZzk3AuMgVQEmloGR8=;
        b=D/7urqt6MglKZevNa2VMoMmd4+xIwKCyRC8L1jSzfIzpHCZqveEhYt8Yzt3wM9tllX
         dM93vvkUhxIsSAjMDFZ5HHcoDD0EBgB5mmstdiCtZEdWd/toBN3Z2NIdTFf9d9bg70tj
         rwi9r6eB8Ypsv9Wc93obqrZGBJ1/J/YcFnLC3qZ7PhmmfgP6A0udClWZQh7DqIAaGNsr
         0WYGUGcKe1l+vedGJ1wt7YD4g2Gpx6nvqzKwlM7WSC6c13RIJMiQs/Y35+gYdEzzRTvK
         t9LhtDlGjl8P6P/ijN4a+4xX9wzeVpf8WfRPl1KBJMmB8GyRO+Gv4ES79IfQG+SmtjKt
         l28A==
X-Gm-Message-State: AHQUAua8bVW+z03Ma59dfkOLIAcm7GyaCOmNii72+ff8ra328QQovn7V
        cLpV5aiPDXsJDu5sGj1BtN+D3g==
X-Google-Smtp-Source: AHgI3Ia1LwIarZEx6JqEXSGuk1A6io+4MFJ4BNTZAYlVkYu5aiSbTAoFkIBuuwO8MPl2FkLG+Q99fQ==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr30335362pgb.249.1550686950315;
        Wed, 20 Feb 2019 10:22:30 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id b7sm9204070pfi.36.2019.02.20.10.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 10:22:29 -0800 (PST)
Date:   Wed, 20 Feb 2019 10:22:29 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 0/5] Fix failures found with zoned block devices
Message-ID: <20190220182229.GC8325@vader>
References: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 05:12:26PM +0900, Shin'ichiro Kawasaki wrote:
> This patch series addresses two incorrect test failures found in the zbd test
> group. Two other problems with the check script and the common rc script are
> also fixed.
> 
> More specifically,
> * Patch 1 addresses an incorrect failure of block/024 caused by shorter write
>   I/O time than expected on very fast systems with a low overhead.
> * Patch 2 fixes test zbd/004 which can fail when a disk closes an implicitly
>   open zone after completion of a write command. To avoid this failure, the
>   closed zone condition is added as an allowed condition.
> * Patch 3 to 5 fix problems to access a block device sysfs attributes if the
>   target device is a partition.
> 
> Of note is that test block/004 still fails with a target device that is a
> partition of a zoned block device. The failure cause is due to an incorrect
> access to sysfs disk attributes by fio. A patch to fix this issue was sent to
> fio mailing list.

Thanks, I merged 1 and 2. I'm not necessarily opposed to the rest, but
I'm curious what your use case is for testing on partitions?

> Masato Suzuki (1):
>   block/024: Increase I/O time
> 
> Shin'ichiro Kawasaki (4):
>   zbd/004: Add zone condition "Closed" for sequential write required
>     zones
>   check: Add TEST_DEV_PART_SYSFS variable
>   common: Add _test_dev_is_partition() helper function
>   zbd: Change sysfs path for partition devices
> 
>  check           | 51 ++++++++++++++++++++++++++++++++-----------------
>  common/rc       |  8 ++++++++
>  new             | 16 ++++++++++++++--
>  tests/block/024 |  5 +++--
>  tests/zbd/004   |  9 ++++++++-
>  tests/zbd/rc    |  9 +++++++--
>  6 files changed, 74 insertions(+), 24 deletions(-)
> 
> -- 
> 2.20.1
> 
