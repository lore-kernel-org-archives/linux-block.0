Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E358C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAB72147C
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="I2e/OXSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCKUUu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:20:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45040 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfCKUUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 16:20:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id h34so1338528pgh.11
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2019 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2hFEz1NPo6Ta+HWyO4vmouu7fZiLzI5uBFZPhPoMO6g=;
        b=I2e/OXSDPUrnH5aM5HfRdUHe90Qx/8bxvPPFZLVjp8f4oMdrVv/f5cxl7pGmi1pHFl
         JEaYKYe0vEJUbC9jmts1FyOTSd2lD9fClvIgrtjz5gnDlRhL+32DkABLSFXDIFySaiT1
         ONUcbQJzQzNQuSolfct+krmqzbUwyyvjkyGxvnZVNgHjH0tFpaNkobeOZDgMS7kwrlnl
         69M3xTlGamAdlU41H3K+zxR70EwtfVmvr48kTmKOXrN1jVKPV/eHFLqay6xZNXQqTOx6
         Wm9a3hKGWEgjeHXnTJUdFQM94gFLLjJ5tfe3mWtEj/OtfxHTLfLI6ppI+g3PjA+r+btb
         RkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2hFEz1NPo6Ta+HWyO4vmouu7fZiLzI5uBFZPhPoMO6g=;
        b=WTRqwLcqO6WpVIuhJ4QvcuKtiVlUCT6p9gwjECkV1n0AYL1fxA58eSV33YmCFfnMKs
         g5l46B5y3/F3wlZD+cWwU9MIDODBo3u5UZA9xx/LsbAoqitlexyN5Emx6cUsJH52j5vO
         /pK5oI5LmOLK9BL14CmME6/1SIehGIkKWPVaiadefB4SsGbdDBW/OX0b6EfGpkRr6JTc
         1PHEtbnNYhNPUnX8AA1rF4KajyD3CzZNS5axcuxTooqfYuv/e7wOZOG4uvC9Ks6D04LA
         RUBUjHUp3s4MuSSmDoc3y0vx4bcWvl5MOjt4n0IEKg/LjzJnnvniHeXIomcEcTvYNeSu
         VorQ==
X-Gm-Message-State: APjAAAVk7L0uwANB+o2ZKFdFr+EYjzbBhTAGsi5EtfMICk3suRLPGc53
        DVBrt4Xlb9gy9gFddL+20XSzVg==
X-Google-Smtp-Source: APXvYqzZQF/qApi/tPOI9EIhMXtk2eR7bEc0mmJ5u+aWL0ka5c/itR6zeUr0ztPxGlv0SZz1b+hQog==
X-Received: by 2002:aa7:8157:: with SMTP id d23mr34863583pfn.67.1552335649180;
        Mon, 11 Mar 2019 13:20:49 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::1:4c93])
        by smtp.gmail.com with ESMTPSA id l63sm10077333pfc.89.2019.03.11.13.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 13:20:48 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:20:47 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 0/3] Fix partition device sysfs access
Message-ID: <20190311202047.GA30813@vader>
References: <20190305052447.24291-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305052447.24291-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 05, 2019 at 02:24:44PM +0900, Shin'ichiro Kawasaki wrote:
> This patch series fixes test failures found in the zbd test group when run on
> partition devices. The failure cause is a block device sysfs attributes access
> problem if the target device is a partition.
> 
> This series resends patches 3, 4 and 5 posted as a part of another series.
> 
>   https://www.spinics.net/lists/linux-block/msg37431.html
> 
> The patches reflect the review comments by Omar made on the list.
> 
> Shin'ichiro Kawasaki (3):
>   check: Add TEST_DEV_PART_SYSFS variable
>   common: Add _test_dev_is_partition() helper function
>   zbd: Change sysfs path for partition devices
> 
>  check        | 46 +++++++++++++++++++++++++---------------------
>  common/rc    |  8 ++++++++
>  new          | 16 ++++++++++++++--
>  tests/zbd/rc |  8 ++++++--
>  4 files changed, 53 insertions(+), 25 deletions(-)

Applied, thanks.
