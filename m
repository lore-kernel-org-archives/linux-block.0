Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F1CC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1EA20663
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Y9WUV0Wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1EA20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLAIsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:48:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36196 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeLAIsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 03:48:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so3048433pgm.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 13:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3tuak7JnyZqKp/ecO2KsIkyJPmUmmZ4op+2SAsKmhEo=;
        b=Y9WUV0WogEcE7qpi+v+OD55ZIMK7hNcD5nyD2XuqGP7dmz7lZrOhveS1EGEQdYcyzR
         Mp4WP9VyZGwH5ezUtu9k//CiOvwJ6wQocepZllkLRF/5X5crKmNJ+6guRHLHy+yXRdpX
         8Mubiyifca2CZHen8948LWvy1URwoueOEcrFQ+21DW6HENRCf/NSt/mlVgxbJSRJl+M7
         wFEv8bDmHL4Jx7jgk/HEfSBCofiPtRif4FWxofg664WQ1RdE/z3rLn/Q8gryekTlQ5FF
         IaDma9tZF4RsVV9qs2zRJ5ryr9wArF1DuCuFIpIHq3wbgLEn+ZJx4VCTET4Jqq/zChu0
         EJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3tuak7JnyZqKp/ecO2KsIkyJPmUmmZ4op+2SAsKmhEo=;
        b=Z1plNMO9+uneL/QbXyI92aNogl6GWf/knzpkTOPJ7rnGYfyJQvy4+pCJdlZaO+O3+V
         XzpqO8uzPccDHiB/6BzJMFM+nGGsVJVDsEOBh6gIw83Xel1EQ4hS+pVaREOET93tq+Gz
         DZjCmhQXqW+FP/pekGzkAPRJYFevln/YuektJRwOQ1NXCn3iSJNSUQjF+2IwEZxrdzXf
         qmbYU5s6fD/8fVdHdzXCs7JEY+iDSEL1FeAHqRTOiAQpe1vm+8F6eMfWRS2Ufz4NSg+6
         0bAcqj6z5FT0S7RU/BhXxCehLJSYPehdrFiZtG2wzsDWANEZ8qwqGv3eJv4BNvsOxfPd
         ENCg==
X-Gm-Message-State: AA+aEWZ33WeU/ZFyBqE6NVIkxy1M2izCUxasZL7K2ko2wAbORTwGhZof
        8/10UJ4ujUZRmzkHweVhSErylg==
X-Google-Smtp-Source: AFSGD/VXjktjTCTBBVfohW9QkkT2zMb6YS4mzcfK17iDBwZTZBFlLipITvwN/k/ZDH2NKkF1ackH8w==
X-Received: by 2002:a62:670f:: with SMTP id b15mr7169928pfc.212.1543613871830;
        Fri, 30 Nov 2018 13:37:51 -0800 (PST)
Received: from vader ([2620:10d:c090:200::4:705d])
        by smtp.gmail.com with ESMTPSA id a16-v6sm7876755pfh.107.2018.11.30.13.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 13:37:51 -0800 (PST)
Date:   Fri, 30 Nov 2018 13:37:50 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] sbitmap: optimize wakeup check
Message-ID: <20181130213750.GA11220@vader>
References: <20181130160118.24683-1-axboe@kernel.dk>
 <20181130160118.24683-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130160118.24683-3-axboe@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 09:01:18AM -0700, Jens Axboe wrote:
> Even if we have no waiters on any of the sbitmap_queue wait states, we
> still have to loop every entry to check. We do this for every IO, so
> the cost adds up.
> 
> Shift a bit of the cost to the slow path, when we actually have waiters.
> Wrap prepare_to_wait_exclusive() and finish_wait(), so we can maintain
> an internal count of how many are currently active. Then we can simply
> check this count in sbq_wake_ptr() and not have to loop if we don't
> have any sleepers.
> 
> Convert the two users of sbitmap with waiting, blk-mq-tag and iSCSI.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq-tag.c                       | 11 ++++----
>  drivers/target/iscsi/iscsi_target_util.c | 12 +++++----
>  include/linux/sbitmap.h                  | 34 ++++++++++++++++++++++++
>  lib/sbitmap.c                            | 28 +++++++++++++++++++
>  4 files changed, 74 insertions(+), 11 deletions(-)
