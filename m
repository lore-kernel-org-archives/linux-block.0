Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B44FC6196
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 00:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A12217F5
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 00:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X2Ic0fSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfKGAJE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:09:04 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:43170 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfKGAJE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 19:09:04 -0500
Received: by mail-pl1-f178.google.com with SMTP id a18so51600plm.10
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 16:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nqDRoSA2IlRCgtZEklSoyPJxix3jduddAsTI1/jyNJM=;
        b=X2Ic0fSApnzTHNdrcWe9ggsXClLt1ZYXt51dLoiznXpJfWYe3WV0JSVtA1y/6Be8bk
         HohaOtxR35Sl1zMaaCuBEU2N7beBAJZ2RGI4bSzq0bz0ir/9PX0PQ4GkHuPfV3Tm1TiA
         8gHEAUPHwZf8+bIjL1S08URkQ/1PEnfN2DsVLfp5tonTKKUgKFExNd3mP7Q9z+dZEdi+
         kQegPZECwkYzCfuFG9PngeOxvXCXj1yp/FIhILtDJqzFKtbqNLiEjUhqqzmiufO0F/Em
         9ORpFhWbqBXvN/KD6ROet7VPkhdoEDubSk9PGlBk5PGcpq0Xcu/jpcL/NGK10FpQBF/j
         9YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nqDRoSA2IlRCgtZEklSoyPJxix3jduddAsTI1/jyNJM=;
        b=pQNEwSGPMkY/T1ykJIworhwmeU+L9TEcTtYoR7t7ZKUAWEGKTJZfQuk801iAGpAcDH
         1bfdFNxRlAgZV1khQ7JXBPubLyISVSZzyMn0Ac4Dvlxw8e02QTHIkWQmAaHJZSM3HS1k
         WCU1kwTSTc1/i88b5XIav615I5BrYr+J7LQUeCD0HR11eJRTiq8XvpRnGY6cflZINXJi
         aOQ1DfzZw0bP1xJs3uQ5fqFeI3u5Mj5ogiPl6Upy5xbEqFrWnkAwEtjNY/wR/RexY7y5
         rHxWwUqa9wAntnstZaPkvUJEhapHJCG8RfZFMN60MwR6ZBLZJBSmt81ZlTAqtxX97+4I
         QTyQ==
X-Gm-Message-State: APjAAAUGVdWfbA4eBhN+rTbA8h+Qc+NnGMFpMJLSN6ckB81kdtU8wyO1
        TtHrfZFdMVnGufJNcHGYQDrRuQ==
X-Google-Smtp-Source: APXvYqxqztqU9P4k3+g7ZoHWN0J9tb648zdmiFnKzrsyZaQHcNLcnwOFJw9OIFwA5s+3SGE4WdvJWg==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr432341pld.248.1573085342309;
        Wed, 06 Nov 2019 16:09:02 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id j14sm116231pfi.168.2019.11.06.16.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 16:09:01 -0800 (PST)
Subject: Re: [PATCH block/for-5.4-fixes] blkcg: make blkcg_print_stat() print
 stats only for online blkgs
To:     Tejun Heo <tj@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <jbacik@fb.com>
References: <20191105160951.GS3622521@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1ef277bb-8591-6029-2e9b-319820b3460c@kernel.dk>
Date:   Wed, 6 Nov 2019 17:08:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105160951.GS3622521@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/5/19 9:09 AM, Tejun Heo wrote:
> blkcg_print_stat() iterates blkgs under RCU and doesn't test whether
> the blkg is online.  This can call into pd_stat_fn() on a pd which is
> still being initialized leading to an oops.
> 
> The heaviest operation - recursively summing up rwstat counters - is
> already done while holding the queue_lock.  Expand queue_lock to cover
> the other operations and skip the blkg if it isn't online yet.  The
> online state is protected by both blkcg and queue locks, so this
> guarantees that only online blkgs are processed.

Applied, thanks Tejun.

-- 
Jens Axboe

