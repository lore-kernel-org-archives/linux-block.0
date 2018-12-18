Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8BCC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 23:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD54F218AD
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 23:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="pKnY0qwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeLRXMG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:12:06 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51181 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbeLRXMG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 18:12:06 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so6882972iti.0
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 15:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vxGrheFwhk9Y+R8ei25ivfnA3K+JQpJSvRcDT1fNgHw=;
        b=pKnY0qwXSCONkiqPUjSD+Ou+1hBGMqsjFhY1m9XW8BDx7oXNYNYCqTznoR+ZipB7MJ
         2+vJtP3S71s3El4DxOGfvfoJxAPGSI7I56LQTQ+bOMkG7oZMgrL66G/zydeCy3POIw9K
         Xs63Nb4omOAiBPSyTbO/RKToKtnuK3tkn+1kbeb9Z+4xlMKkoq9EYJ3+kmAZQzwPQnKb
         xw6vUFEogSJXZX/jP9liwh5SC5b/eF0s4KxW8t8WFgFVdIY8IoAS3pS27XdPuHqqwtOt
         N62i98YVObQV80tR5U5S2knE77mgRXlUHw10vGrjffsR0FwWAYY6uDYtIwJ38hZjH39p
         HWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxGrheFwhk9Y+R8ei25ivfnA3K+JQpJSvRcDT1fNgHw=;
        b=ZLp+H4ejOfmStGvY54ha2BUySdcwqAyM93G5/6FkOW1LXfeO1VbKvQMo1PHMFAqiNk
         M9h0YPjlnt+Dc19lhnzgdR0kI6d2V3fFRMt3t3D5dMqZjSNE2r/6e1KJPbl24+siF7oo
         jbr/ECq8jvunOUKcINjd5COHQ0wkuTqeyonKwE83dTyLwnVb5lzxpFHAGqbhwJmKaPvd
         HkIX/AAGPhkBTfzOhyc0yE1SKcO5jQ8Lv9bhfo1qliGF06uQ9sh92AdtVUMWZtvyDmeg
         mmgD3LP8BBXAXW9hCwHuylgksDHfnTCk0BN5jMqvQYaAIjlSPduDXZbnGd6C+FDEK/y+
         LlZw==
X-Gm-Message-State: AA+aEWYqqHlSr0JWLNk2VTLszNkhNEUkvJ1ZOHSTQqgjMsfi0q5DnBKu
        zcSSIA6vgcpJ0kqsXrWIRBIbY2O9dTtK1g==
X-Google-Smtp-Source: AFSGD/X79vjReCp6zWHIAtB/iEjwAonbbGhM20bZd8GEW4LsER5SiZvScrQzLN6ngcehnOVVAZS6SQ==
X-Received: by 2002:a24:8a44:: with SMTP id v65mr4521184itd.67.1545174725085;
        Tue, 18 Dec 2018 15:12:05 -0800 (PST)
Received: from vader ([2620:10d:c090:200::7:ffa])
        by smtp.gmail.com with ESMTPSA id t1sm8734801iol.85.2018.12.18.15.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 15:12:04 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:12:03 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     osandov@fb.com, linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] blktests: make block/026 run in constant time
Message-ID: <20181218231203.GB12683@vader>
References: <20181212154552.10422-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212154552.10422-1-josef@toxicpanda.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 10:45:52AM -0500, Josef Bacik wrote:
> The original test just did 4g of IO and figured out how long it took to
> determine if io.latency was working properly.  However this can run
> really long on slow disks, so instead run for a constant time and check
> the bandwidth of the two cgroups to determine if io.latency is doing the
> right thing.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Thanks, this is better. This still fails on my emulated NVMe device on
QEMU with "Too much of a performance drop for the protected workload".
The total I/O goes down from about 2.4 GB to 1.8 GB, so about 75%. It
works reliably on virtio-blk and virtio-scsi. Is the device hopeless, or
should the configuration/thresholds be tweaked?
