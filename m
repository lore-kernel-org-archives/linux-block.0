Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE6EC7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 15:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2CA20880
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 15:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jumHbyF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfGPP4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:56:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38611 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGPP4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 11:56:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id az7so10326553plb.5
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hpk81lAes3RpCfxLnXjxds1FyD4xGlub/UhWX9puWIs=;
        b=jumHbyF1R00QJM1rKgKv4C1muFvedxmaXI7re3KFMhPf+mcCh9yangw9ABTsV37Zew
         Oh8Y6e7LIn2XVRN3a0MmZw3RuD4QFPXXriaYrFw+XRQtDQTu62AgEzeCKO80UDCkP0ND
         yOadlEp6KeBs6J8KAKa5ML6HUKVWVEA4G1WiS8+fvTA81cOJwWdW+guO5/G4AyzaNevR
         2XJdMECKqoRVfa+R+W/6RHh5u9aikRhzCRApmhJEfGMY6SakzPkGW9p9cDh5KT/vG2ut
         CEsu6LwAWN6hG46OIbs8MOZ+z5kLdAjLF7WMtav1lh9IUj3Nga6Ogi34Bk7vL2khB9Gg
         2+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hpk81lAes3RpCfxLnXjxds1FyD4xGlub/UhWX9puWIs=;
        b=aY05zuNLezbOfAPDQxBWpPqbHmLO0WF274w1r1A1GG/zN55ImTNx8H55BYw8MuD5qW
         p4mQuYsTctzqubBzzOEgCsuG6o5fYFTl50BeCFyqVuDqDlG0tTgWlDRmyL91rlPiEeay
         QUjAI5K1V5H6yXUMJVLC+WrBf1A3b6q6ycM4lfe9ghCRCM6a4KC/Qo5YZCB93USVouWK
         Sl21zqfDdFClUOLuGEMn/Ds4vXbPt3x87jNTqjafPiCYp1H8VcdfukrUwExgKkC79Ykl
         7zb98A9KYKQgTub9ApXyYGMuGrDDbo+88v/3iGhgJJB8UrHRHXRUItjkKroARMeoirT0
         yq3w==
X-Gm-Message-State: APjAAAV4fRFSSRARS+UCzJ39LCXuLL0LPu5dPcEEu2rgbx35KsC0ZjHZ
        hBzDnxEM4LOFcsnYd0ja3NLYfrNKaP4=
X-Google-Smtp-Source: APXvYqx4vjCrplX/rkoXMGJBOfWVa8ytyiZsebLqQjhdIgqrxM78DYV75aNesdNc1wXgZ7t/KYDfJQ==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7mr35504947plb.183.1563292565858;
        Tue, 16 Jul 2019 08:56:05 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id j20sm20253440pfr.113.2019.07.16.08.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 08:56:04 -0700 (PDT)
Subject: Re: [PATCH v2] io_uring: fix the wrong counter in async_list
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20190716152614.15901-1-liuzhengyuan@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3625291-c7bc-4578-9ebe-b3fc2279c208@kernel.dk>
Date:   Tue, 16 Jul 2019 09:56:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716152614.15901-1-liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/16/19 9:26 AM, Zhengyuan Liu wrote:
> We would queue a work for each req in defer and link list without
> increasing async_list->cnt, so we shouldn't decrease it while exiting
> from workqueue as well as shouldn't process the req in async list.

Applied, thanks.

-- 
Jens Axboe

