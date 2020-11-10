Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFDDC388F7
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7CC206B2
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 15:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NfZt6Z/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgKJPBq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgKJPBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 10:01:45 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4B2C0613CF
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 07:01:45 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f18so5901285pgi.8
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yv0x4pKmyqoQ3NFgWKouoXjBWuY7N5DeTwdLHRsMbfM=;
        b=NfZt6Z/35bJEdyriRwGK5uqICs+0CxQHGvpSYM3Lgc6R+5p0JpIhgJYh2xuBoSX7u3
         v91SBGhKbidwlMHYyxh7pcfhGBIbZxj/YICsU7SSe3FwCLOD40+Vg0w5uKajxxxHQncP
         fmjKrtSYgiDd21F+8j5vTTuezli89Jk6YEpo3+vQWcRGYu7TW0b0yBr4g3bSAwmIM0eR
         GR28yd6yuJB04T6XI4484ptmrj7K8glvtMJfC28oh/j5xkVVyxwSIOUkOGY+jbO0A5z+
         YtU1Aw4n/U0aMJUfImoROeoVJPIoGAQBb8lLu7D/coJM6vtGgQ95Av6cf2bCfyzTNzMr
         Uyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yv0x4pKmyqoQ3NFgWKouoXjBWuY7N5DeTwdLHRsMbfM=;
        b=PVos3H2UmH/qCQTZcJzd0wKIqXew+v9VoqVhmo4jx8pvY9RWrKlKJnQwdafNGjg1Jw
         057Uarls91PbxtAx1irPPDsXc9wsfOwJRbfs5nF3+bN69Czs5qHky/Jlkn3rnK92occ2
         h4GjxXERvW4+PVqsObd15g0iGvxGgWkmUMmRujDs4q4V3whWAGDe4/clu9ZyF+IQH5wg
         Xaoq03UImWvm5Sw54CvTZ7Tw4vs5JJlnualAgC5MyoE6/NpDAh1FQbqLnXFBAQUlriSi
         /E2PjmGD5QXn8veEu+LTRLylYvclxJbMx/au/9OWKwTfeksAYScwqKlkJbMs7W8iqvPz
         jSow==
X-Gm-Message-State: AOAM530kw/BeHRDtM5CMhRJVDdWbBcEOl4hmS3oSInbmA9YZpPo4oQLv
        tvIPu2Kw+UEBLV60d3DfX2edlFIlDsWe9g==
X-Google-Smtp-Source: ABdhPJxuY9FhzKUndO6y0cD5/gR3kLJeqwn2W95CY52lKt35Oh+eeXPQnj4xA2xeoqIRbNo1Fh14uQ==
X-Received: by 2002:a17:90a:4dc8:: with SMTP id r8mr75784pjl.1.1605020505013;
        Tue, 10 Nov 2020 07:01:45 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s22sm13304748pfu.119.2020.11.10.07.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 07:01:44 -0800 (PST)
Subject: Re: [PATCH] nbd: fix a block_device refcount leak in nbd_release
To:     Christoph Hellwig <hch@lst.de>, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
References: <20201109173059.2500429-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b1054866-85f3-54f9-999a-07760b1237f2@kernel.dk>
Date:   Tue, 10 Nov 2020 08:01:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109173059.2500429-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/20 10:30 AM, Christoph Hellwig wrote:
> bdget_disk needs to be paired with bdput to not leak a reference
> on the block device inode.

Applied, thanks.

-- 
Jens Axboe

