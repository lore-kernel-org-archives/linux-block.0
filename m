Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2ECC433E2
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 17:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5182074B
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 17:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="05bWWGmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbgIHRx5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731384AbgIHQMt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Sep 2020 12:12:49 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E1AC08C5EB
        for <linux-block@vger.kernel.org>; Tue,  8 Sep 2020 07:19:02 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r9so17277005ioa.2
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2020 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DemIwnZBOAelJc9ndnKzywBy6oDjyjMd6qeSuxjV6/Y=;
        b=05bWWGmpTiYPIGyxq61v7vr4QS2c4zYxlISMCZeCw2r8FT8FELBeaLJ4iLGUaq2mDv
         K7MoPl6/Tw9vqYEpcIaHSaIVuBXEDr/df/SAsR7AIiWTWpwfXsvZYPc2htDsoD2u6Xbt
         lkY9/ny34iIa26HSoA5ADdRauF70ra8e2+cmWwqNMiJCMs9pwBysVvpWB1ta5EfqPsHI
         UN24o3XhohWojNjqGJQsY75IqnF/O34A0FfUJTFa9VpWnPTets56jYv7RglTFlZhunvx
         nurAEORS+IsBtNCU/0p8T572fmYpHrtGh3+DCGYozkK7yhRbZXjPHkUuhDnQzKrrZ+LP
         nZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DemIwnZBOAelJc9ndnKzywBy6oDjyjMd6qeSuxjV6/Y=;
        b=M7t6YYw31q28xuyZjBsUSOK2fLWwrA1LTtSAicePMsfb/L6VjMfB1K/cXHHIoj+46a
         aVgShacL+5pe6WW+r5zjoD700GP/x3jHwGe5vNBots0ozob63xcTU0mnwfuqcTfZUWZ4
         5EaFTCN8QAoA9yiVsP8SZKBO2MPTvr7wlF+XIQKZ3vcq0etkb1sifuSC2yfZFmdDKEax
         b/jBJr7U6q1qRdkDyiCRcrte2zNE4N+ZgQIa3+LFROslg63EWU1OAKt4xP4vgPrJdG36
         959kg2Wpj2u9ElPcKZc+q6r+JODLSo2YWSrPfy1oedrO8lFGCCXBb7jsJRMUxdSWRJQF
         HtqQ==
X-Gm-Message-State: AOAM530t8Hqn0IR5u24ex7bQy16he3JsDFi1HUbJBjml0aNANYTp6vlL
        mY+WNaup8wVV4pCcEwigd9V0HQ==
X-Google-Smtp-Source: ABdhPJyDRTODxDtwAm8U1Xo7FPEaOc3DYhFgy3Lj7hzraxP7yYhKY0YjO8CZ85BHYZ7+Dwn2/9YdZQ==
X-Received: by 2002:a6b:7f41:: with SMTP id m1mr20938987ioq.62.1599574741852;
        Tue, 08 Sep 2020 07:19:01 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x24sm10399566ilk.82.2020.09.08.07.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 07:19:01 -0700 (PDT)
Subject: Re: [PATCH] block: restore a specific error code in
 bdev_del_partition
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
References: <20200908141506.2894221-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <71fd3136-e5ca-2f16-7fb6-790f11274356@kernel.dk>
Date:   Tue, 8 Sep 2020 08:19:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908141506.2894221-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/8/20 8:15 AM, Christoph Hellwig wrote:
> mdadm relies on the fact that deleting an invalid partition returns
> -ENXIO or -ENOTTY to detect if a block device is a partition or a
> whole device.

Applied, thanks.

-- 
Jens Axboe

