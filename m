Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3E9C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 19:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EF12082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 19:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="rdLIjCGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EF12082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeLDTuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:50:04 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35692 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDTuD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 14:50:03 -0500
Received: by mail-yb1-f195.google.com with SMTP id z2-v6so7378162ybj.2
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 11:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+ueYi+brXN7pPHAwUWTDfeiGp090xsVy/6F9O9E86E=;
        b=rdLIjCGjf0tAo/Mp4Kny0fqVkOhTxceoBFcGu715eAhPc4QSjcfOFbregjVvWysA4g
         OFhq2Kv5A3/fmL4WiVdxFam0H7sVbVUAjSBO1+VMItULxS2Oktve08quU8YU/EihF51c
         5vgqcqxmcxz6IFcwYbXNsHU+wm7gE3eRAmq2SFrSGkMb8WuaCebEB2U8Zcbr8mnCEwUE
         EEOWpScyOeFpUwmblq6k0XKhLKQmbCex2t6S12OZmI+69rF6s9BJZWsN4xJx+EZ7LZ3p
         N4toDwckwREJGuOA9MC8sbywTn6WDBGdVYqKvK3HRA364Bp4ojsAajuBQTrhM5c8awp8
         bZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+ueYi+brXN7pPHAwUWTDfeiGp090xsVy/6F9O9E86E=;
        b=AerWKrdGcY32K40NuTpscUB1m7ZjYBQlrfsUZN3OjGljMvWXzMEAiRkdbbLOUmakZp
         q1PQX4EuYhfwuXY/MArP58hv6VXwVSqNmhGBD3VZ6IhQ3Wpw/OoU8fUnQUHp1zIElgdf
         6AnWbkry3Vgshnlq4QWDFfKQq1a9kxRf/60J1di2o2hFU3YJ5H16dNk9vVnjE2SF4NUA
         e8pztfGSXWmIlBxfs4VthwHXktl/ZYf36JF05tPt/8MBp4DGx3MXwT73C0iDvXwmivtw
         VlrhMcxTChgfQIduc4oBEkLLFEYu9j1Be61M8HrI3KQKxMz3RjznTGm65WFpckZF1UCD
         6MZw==
X-Gm-Message-State: AA+aEWbu605RamfPPZeL4GWpSamoEQO4XqI2NE0OA7jj6FNx6EqSFp7j
        2uvT25CalmTVn8S1PZX3jS8xZQ==
X-Google-Smtp-Source: AFSGD/XganyIChOhV2HV9ze49waWnZtYnJD8GZyWa3jXy/971/UpDG6i0PbwvlNQmtHtRMnJgHcjPw==
X-Received: by 2002:a25:a285:: with SMTP id c5mr1650728ybi.356.1543953002922;
        Tue, 04 Dec 2018 11:50:02 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j12sm2747003ywk.43.2018.12.04.11.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:50:02 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:50:01 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] blkcg: consolidate bio_issue_init() to be a part
 of core
Message-ID: <20181204195000.gwhgdqa7ouaf73sp@MacBook-Pro-91.local>
References: <20181204183600.99746-1-dennis@kernel.org>
 <20181204183600.99746-8-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204183600.99746-8-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 01:35:53PM -0500, Dennis Zhou wrote:
> bio_issue_init among other things initializes the timestamp for an IO.
> Rather than have this logic handled by policies, this consolidates it to
> be on the init paths (normal, clone, bounce clone).
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
