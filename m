Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D77BC4346A
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 13:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1336D2067D
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 13:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PP7JSFsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgGQN0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgGQN0M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 09:26:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E1C061755
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2020 06:26:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so5429914ply.11
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2020 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AWTA31x5zu3vCOICJIW5AiaVQMn4V/4dUEb8Pk6svIs=;
        b=PP7JSFsAUJNCoA2yu6LaqqbtFD/7UUko37MDibJevtbGxuzrRIB2BvowqfN8ydzVOU
         /bJVRM0R0Ryy7Kn0Q/bFFx+rYpz7t/1CJlkKVql6ZrCOTyaXxNVAR025Ocb/uA2suW47
         oKrtJt7D8m3MXaHm/sVwbAKQM+g7EJa1tNUVl9kG3Cxz7gQv7pekoI+w4XEiFJR2+N5x
         XA3Lz4q3UxeWuYZ6ZDM4vB7y65K9U+sYdd2FZxPlt9k0d+NvbVkrIdMC95rom60wgXXK
         QtuEUP0rK7Ldd29LZ/X0Yy32nGDRbHlhEZ00UwJwpUYFABVGQyOgJjQkpnIJ5b5q8NS3
         1KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AWTA31x5zu3vCOICJIW5AiaVQMn4V/4dUEb8Pk6svIs=;
        b=NGg53Cz5iUYEznQ5AnqAtp9sHj301lkGKOTzBhcz9+vvTkaP9BTe2KsqWwpJwrHiqT
         hXtwVIMCG8+H059DuYdunAaJmqcxPQtA3HgjJP8/a68iK+BUd+swQZBwHBggiJ+jWE5w
         xW73eTKrhYxTlu612Yl4boS5CmlMF34lUN+zepD5HGkjA6uQu57hN/sDqiEn9r2+vpMx
         V0wl1KEQ6o5CCENSKD2+rbgjRkKwnlGV270OZk+cyG2KCXdgS69ecN+MJRk26HSNKcQ4
         +lSMqHlBW8xse40/BUs4c9+9u3wodpm1ZA94HnEiZPnVQyWGELpAnlDNIW9+r1ywrm5B
         F1KQ==
X-Gm-Message-State: AOAM533wqa0gWJWmE0XUIlaHAbzfgSkFkgZIevdsl7kGzWDrTppgvk3f
        9PUES321Ko/D0TW3czc7DntzjkyJmOsRGg==
X-Google-Smtp-Source: ABdhPJyOMUDnqnCS/x4Yd5DVhYDLDz+8QahOwlj3WelMTP+GxORUMxKMY1tcrMqetnjmv3Gk734fuw==
X-Received: by 2002:a17:90a:ff09:: with SMTP id ce9mr9317721pjb.149.1594992370958;
        Fri, 17 Jul 2020 06:26:10 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a9sm8049532pfr.103.2020.07.17.06.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 06:26:10 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: remove unused code exist in
 blk_mq_dispatch_rq_list
To:     yangerkun <yangerkun@huawei.com>, ming.lei@redhat.com,
        linux-block@vger.kernel.org
References: <20200717092348.36303-1-yangerkun@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a2538b5-2883-056c-3928-62a32069baae@kernel.dk>
Date:   Fri, 17 Jul 2020 07:26:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717092348.36303-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/17/20 3:23 AM, yangerkun wrote:
> Once .queue_rq return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE, we will
> insert the rq back to list, and will return false since '(!list_empty)'
> always be true. The latter check seems unused.

This check is already gone in for-5.9/block

-- 
Jens Axboe

