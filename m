Return-Path: <SRS0=rsSL=Y2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F65CA9ED1
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 03:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FB1208CB
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 03:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h+MfaCg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfKBDBm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Nov 2019 23:01:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38281 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfKBDBl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Nov 2019 23:01:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so5143137plq.5
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2019 20:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7NwBt9a6SQW1gZdGthoi1MUCZhj7J0hx7vs90QD7LPE=;
        b=h+MfaCg927dhNpvl0H8VQw4r4ERYDqOec6spoW7SUz+tWBjXj/3hJEGDBjiAiT7AMC
         IpnssFR1q2ahJkigI3Q2WIP8yfKNUHX5rJSoYCOE2YM4cLLxEsukdWowKlt/XgRLmEXw
         tM//7cnLLFna2Rap3Y/iE9ddHqoql79nqwFqfwDSPFHuDEkhOk0CXYGG9PJ6K4odzqvh
         WNLsPi9glnK7esFp1SHef7ClH/9U4ifHthMwo6pbj+nxKMXzBSsQ9F54l3eQueyvQMKs
         jfAH3AxDNKLAoBCdm2Z8pIEKNdu1P0UooEOekRrpVxr1wlJ85b2eNgT8abOCDd3I1KlU
         otzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7NwBt9a6SQW1gZdGthoi1MUCZhj7J0hx7vs90QD7LPE=;
        b=gviaVYB9JDt6+2ej+Evh1LUDhYBNiEvGNUYMxyYUPoGtBoICToecjMEqqt6YeIuITl
         Da4lNdIswWUYa6ZPLp67oO6E5Gf5ThxYuUr+Qb4/lt0tTB+uDYgOBfEdMuSKNabLnU8A
         mICmFllB1NDCqhVUj6W1iY5bMcALrJ8WdFO3CJhjCWRf739AsBICoHOxpKpI1+/76Cue
         3dzTdHHkz23CnHRND5Mk2pAD+S1wMEZFdpku4QYg9DJc3rFMR1NfwRNhEYPbf0l/vDJs
         IqDoVtCWTnxzjvB/34TG9I/tCxhPUp3o4TJzQIh3ooO0yt2Osgo7PConYB2GOmrMHngm
         z7lg==
X-Gm-Message-State: APjAAAX/xS+n4QmPTVqPuqT7qvzupktRCIc7QaDoQUkEgeXWNrMpZdkR
        EEROsFcji40gwEs3zutXHyt5LA==
X-Google-Smtp-Source: APXvYqz3du8Nu9k+fUXmP6mr2iwTN2aAu0IEqPhw0GrrVGm8ADdK4T5H+F5WeWr42XXK+Dzp6tSURg==
X-Received: by 2002:a17:902:8d8a:: with SMTP id v10mr16010030plo.32.1572663700720;
        Fri, 01 Nov 2019 20:01:40 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id q6sm8368926pgn.44.2019.11.01.20.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 20:01:39 -0700 (PDT)
Subject: Re: [PATCH 0/8] Zone management commands support
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Cc:     Ajay Joshi <ajay.joshi@wdc.com>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Keith Busch <kbusch@kernel.org>
References: <20191027140549.26272-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <926948c1-d9a0-4156-4639-bbac1d0ba10b@kernel.dk>
Date:   Fri, 1 Nov 2019 21:01:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191027140549.26272-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/19 8:05 AM, Damien Le Moal wrote:
> This series implements a few improvements and cleanups to zone block
> device zone reset operations with the first three patches.
> 
> The remaining of the series patches introduce zone open, close and
> finish support, allowing users of zoned block devices to explicitly
> control the condition (state) of zones.
> 
> While these operations are not stricktly necessary for the correct
> operation of zoned block devices, the open and close operations can
> improve performance for some device implementations of the ZBC and ZAC
> standards under write workloads. The finish zone operation, which
> transition a zone to the full state, can also be useful to protect a
> zone data by preventing further zone writes.
> 
> These operations are implemented by introducing the new
> REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH request codes
> and the function blkdev_zone_mgmt() to issue these requests. This new
> function also replaces the former blkdev_reset_zones() function to reset
> zones write pointer.
> 
> The new ioctls BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE are also
> defined to allow applications to issue these new requests without
> resorting to a device passthrough interface (e.g. SG_IO).
> 
> Support for these operations is added to the SCSI sd driver, to the dm
> infrastructure (dm-linear and dm-flakey targets) and to the null_blk
> driver.

Can patch 3 go in separately, doesn't look like we need it in this
series?

Also need the DM folks to review/sign off on patch 7. Mike?

-- 
Jens Axboe

