Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC203C2BA1A
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 19:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808F8206C0
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 19:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dywiWxzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDFTod (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:44:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46093 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgDFToc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 15:44:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id q3so8063091pff.13
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2020 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=z8a9M9x142HC0RfYYegJqkEWIweLC4W1tendlM2sneE=;
        b=dywiWxzg+O/bsVUpLkaclbMSnQtm877sTSy4k5SFTdapkooaATDQZc1VdLM1yDhm3C
         eESZ+wXde7SHtkuB57N/4bSiNAaRivZNfiQAVHSNQYvE66gPVeJVXVqWXcpFNT1Z3B/3
         piYv1FUM1YijvoyI83P0S0HrP0vdKvAfGNY8hpMGovAeDpVCWQiJB1tGsYEpdB0u5v0G
         804fRjuJURg9ptuRgjO77oy67srNqLVHa8gtB1zk702bhMe29KWAXl7VUJ7ddjpT+NgF
         2YRyFE8LsS3xzengWA6WqxwDIcDLrOmExg5ovvpErfKNzUa2pf/W/baHdiIgAKYlpKBh
         GU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z8a9M9x142HC0RfYYegJqkEWIweLC4W1tendlM2sneE=;
        b=a0t4L9R/mp43bvuhsg8lWIJ37XV7esWWl3K8v3hZRMG/7/rkjgZ7mRn5+DS8an6h6Z
         URF7AB9ixtTCn+bB+MaySWYuyeW1pXwJ2lrbY+KhUSuVOSscIefGg7xHkP2lAUxRH5xt
         rK8e4V7D4eE923yR4W6peMxRAIpJy8O+ggyjPnwYsPqkPs7U8TFqKjhy/4Wn1EWUgrqY
         +ThgGR9sHBB3nvKtmnR9qvpkKPgbBur9LbnMxX6jDp5waXIL0hEe2udq07fLMUX5zZ71
         dA1HMqVVZk7ZIyuWQurGLiALOchbAQgukT/o0SUljFkAZ/p/d5+rfToZTQnSMbVXuF3j
         M34A==
X-Gm-Message-State: AGi0Pub8uVy30SGQP1KpXORbitmJ/beZL9HxbUP25kh1Ov0m+kQkLyT1
        xPLdBGuZbt7ryoVjfOf3S2gWq7icPZ1ksg==
X-Google-Smtp-Source: APiQypI+gn87UAGTawm2RZeGh7jY/d+xKED1h4NytleceLkXbxlgzYTWk6gkhtT/ntyPxE1lvV9gQw==
X-Received: by 2002:a62:15cc:: with SMTP id 195mr1130275pfv.276.1586202270643;
        Mon, 06 Apr 2020 12:44:30 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:7d7c:3a38:f0f8:3951? ([2605:e000:100e:8c61:7d7c:3a38:f0f8:3951])
        by smtp.gmail.com with ESMTPSA id a24sm12287709pfl.115.2020.04.06.12.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 12:44:29 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: don't commit_rqs() if none were queued
To:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org
References: <20200406181348.1496-1-kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1767a159-925b-eca0-1b6c-363cf61ad53d@kernel.dk>
Date:   Mon, 6 Apr 2020 12:44:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200406181348.1496-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/20 11:13 AM, Keith Busch wrote:
> Unburden the drivers from checking if a call to commit_rqs() is valid by
> not calling it when there are no requests to commit.

Applied, thanks.

-- 
Jens Axboe

