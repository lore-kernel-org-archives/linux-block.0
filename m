Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE3EC31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F0620850
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="xvG8BKrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfFNNuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:50:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42593 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbfFNNuK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:50:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so2477859qtk.9
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rdet0I+UWXME2YtJOPcri6B791wkgPbT0ODn/e0NNDE=;
        b=xvG8BKrsNAVh/vCgi+a/I1WY/69P6du33JCLdiidof2V0IfXffFjeJiQhuvNbYv8Hb
         POIBevYAmKF2ZByQmirjeiMx1gkNMeiM85Z6/HtgCH0trjaz6oG9cE5s+cG1k9XmxdsA
         jpsOdJwKw5qG+wPH48dKjymEbS6O2XDcPedhF3KcoyecbH/QNxglXXctQjWGu/SR09+j
         3KzU8bLFH7PuOVeqXWOfWsvhSvJ3IMxABCbhnNq0itq+E2Hh/FnLEfzLunbj8HYnXL0p
         wfStLgLLMwK34P3zkkOb8twGzdXLL1kOqPqWVPuYUxcV5CXpjnabkhrJMBBeIoS78Axp
         EvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rdet0I+UWXME2YtJOPcri6B791wkgPbT0ODn/e0NNDE=;
        b=s8Gpv3cCdgQ+cmYw7dKOxHTuKfwuHWzl85e/ZNzjrTjJvCquVnYmENFtsPX1FwPfPE
         7RavbuSBWum3bps0OpuHUOLHTURLD3bnaFT9GfSBePVGpP/HqEyZiTRspXmLJkxs/bib
         R1wAzSR9uTD5cvlJVFdNR3bXnflpzltZn59zk5BA3qIEr8LBZZipL3SiADiOsPkhQYth
         AvHuAPANkG+yRdEVf8bYvNDcU5QulFr0aXH+3fD/4PF09t4mVC3/HKYOBAP3bzoDH4YF
         /MgXhs4jgJsW6WiOqGcJuGFB+ES3keWJmTvnimPNlXGfeakdpWbNixKYSCrSrDNVj/zL
         ECEA==
X-Gm-Message-State: APjAAAUzwvJ813/z983JbTTR48Ll36XadB6FSruFrC9szmkw/rLd+JQu
        3lw/nyRZiaYjWIRAKt4IJE07fQ==
X-Google-Smtp-Source: APXvYqyDDDI8puKpDK9WlTUrJOIA8FGHM2Hd0M/1HQJqRcBRsNVkseNvcj5yoYx4W5gNyPaN5wFsIQ==
X-Received: by 2002:aed:224d:: with SMTP id o13mr77466543qtc.56.1560520209532;
        Fri, 14 Jun 2019 06:50:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id d38sm1670624qtb.95.2019.06.14.06.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:50:08 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:50:07 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 7/8] Btrfs: use REQ_CGROUP_PUNT for worker thread
 submitted bios
Message-ID: <20190614135006.ug5qgpc5uocuip6b@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-8-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-8-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:49PM -0700, Tejun Heo wrote:
> From: Chris Mason <clm@fb.com>
> 
> Async CRCs and compression submit IO through helper threads, which
> means they have IO priority inversions when cgroup IO controllers are
> in use.
> 
> This flags all of the writes submitted by btrfs helper threads as
> REQ_CGROUP_PUNT.  submit_bio() will punt these to dedicated per-blkcg
> work items to avoid the priority inversion.
> 
> For the compression code, we take a reference on the wbc's blkg css and
> pass it down to the async workers.
> 
> For the async crcs, the bio already has the correct css, we just need to
> tell the block layer to use REQ_CGROUP_PUNT.
> 
> Signed-off-by: Chris Mason <clm@fb.com>
> Modified-and-reviewed-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
