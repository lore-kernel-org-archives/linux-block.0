Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15A4C433E1
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D452070B
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 15:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pKu+ivn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbgG1PXh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgG1PXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 11:23:36 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A84C061794
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 08:23:36 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r12so16504783ilh.4
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F4Wsebso6IWC8aSQZbXXH5ooZdFajOtRRLZ4DaokWp4=;
        b=pKu+ivn1uOpQqNTDIQ1KY6QsdvMa8+DSGEMZGrbKfXulugnqrBwlXPUes12BmXvZq4
         fgPkcyKJ857iqq/EXdXswQOBbhAONGDc6Z/mwnWUoXPHVIIsOxCe46bCXjqc8pW8Vt6R
         BHpaJwPA3dpZm5WJme07DuvnBWkqIJIgtmAiGO9QiRx6z3XWuNG4+z4OpAVdfz/dtDYx
         83rvj+yRBtoLHdiA9eaMPosyaty/X9x8VH6FX58WK18zMkY4x4Mpn8fidJh+5OlCkn0K
         DWwFK/vx8NdSQ4WVrsLOZLs0/4vrxkO1F3HVVqVQWxazfw18/DYHZcOE8E1bgEcqJDk3
         CYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F4Wsebso6IWC8aSQZbXXH5ooZdFajOtRRLZ4DaokWp4=;
        b=n3v8/yxmycYIaFp5D3GfDZo/l5EHGS8ib3fB9nLxp5CKJcakEjA5YqlhjWXvrcOOJA
         Wb601WMfMqCa3p7660fydyHhGOC/Q3TOAnFlKEmC7x01agyTDizg6cC4A301nHCWnrmO
         qGj1AB1FgzS/OaUgJ4Fmidr6dK2nVdP/X8hsKeAkzjqgBqAoLx6jdRB6IFPgK3OSaInL
         A72rCEaYn3IdH2RU4ggFcXUamBI3B3dP196GEuG8/6JNfMm4X1gPYgTOUv2L/QhrsX4e
         ZtBm6MNhRXeDNy4D07fxD2Qk7527dBiG6irCwSMIsWrdxjiHqy8LbBH8ahPJd+xmd6SA
         J6vw==
X-Gm-Message-State: AOAM530Bd6lIHq+v5W+VLHTwa2xh2FFk92dlcMT7ps6G8Owt39akQ42K
        v42iNPZBQLjrRPlmDrGatD8kYZOio1Q=
X-Google-Smtp-Source: ABdhPJzUA/rPdjZE+tCi3vy8e9Z6IxJTfTdB3l1PLu8xq3p+qLhCLyEP8K2KM5/a58sm7uQwlDPAng==
X-Received: by 2002:a92:cc06:: with SMTP id s6mr28424185ilp.8.1595949816045;
        Tue, 28 Jul 2020 08:23:36 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l11sm6281065ioh.52.2020.07.28.08.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 08:23:35 -0700 (PDT)
Subject: Re: [PATCH] bcache: use disk_{start,end}_io_acct() to count I/O for
 bcache device
To:     colyli@suse.de
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
References: <20200728135920.4618-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <648c19eb-a718-a49b-37cb-d95ea78e831b@kernel.dk>
Date:   Tue, 28 Jul 2020 09:23:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728135920.4618-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/20 7:59 AM, colyli@suse.de wrote:
> From: Coly Li <colyli@suse.de>
> 
> This patch is a fix to patch "bcache: fix bio_{start,end}_io_acct with
> proper device". The previous patch uses a hack to temporarily set
> bi_disk to bcache device, which is mistaken too.
> 
> As Christoph suggests, this patch uses disk_{start,end}_io_acct() to
> count I/O for bcache device in the correct way.

Applied, thanks.

-- 
Jens Axboe

