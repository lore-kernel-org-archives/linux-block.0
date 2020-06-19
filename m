Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C593C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6322158C
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR5C2Vnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392971AbgFSPWR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392493AbgFSPWN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 11:22:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10ACC06174E;
        Fri, 19 Jun 2020 08:22:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so10054202wrs.11;
        Fri, 19 Jun 2020 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=j0U0rAZaB2UWJgbn1tTj9uaBHYB8SQ8T+oF+7yWQ9HI=;
        b=QR5C2Vnby+RsbvUpnk8P6wlOAX3FZW2jWrIAVrqO9sjmHUM156Tpm33emb1ecdoPMr
         P6qprQEBhkORJx6pBLHYEE0Zs8qjO6hA99WsAbWiJw1qnN8mhoBr1fB/NF3EI9Jf1IH5
         674T4B4VhFYLtEJEQ0UgLOQnCfv42WSqU2AakjtCGP1xrQ+8OqC935k9NY24tFMBPuID
         LDMZeosGsW20GoEb9iC6ivIngVm/GeHqgqE1W9C+TTDOLRGY4gTrGzs1FnCZR0ZkFuu8
         UKAqNj3hTQ+repVROcf0Mf38EtWKuZi6aNKXrcaD+dZd6qrH5x1YypHnvknb7ZVKUyq8
         O6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=j0U0rAZaB2UWJgbn1tTj9uaBHYB8SQ8T+oF+7yWQ9HI=;
        b=jp0IdDJPCWhPFYH+dXMQ+DEz7xLmX6r0R5Duw5kWmmJJxNQQiagAHpfM+zLgH1uhir
         aIXKPdHgWfzCzpNAdj7YK8Eocj2FcMbbj/sW/Kp6WBd8TZ5d/Gw6ZzQZMla4+91lVKQn
         DQMORzdmfrioXcybfMzg5qlTKR7d33wgGJGt6PP5CJTtNT3EdyeLopuFaVyTTsTy7CKo
         7qgv3cuznVwT6FA2pw7p59CYdfy7LAo+p75NNi8PkOY/CaEEu+LSYxwlLp/qRLAqo26o
         z8NcOLrkByMTE+xDh+slLQRXqqx8ZgRQxKGY/JPjQtjEFIO/VYnUGG6ZUGmlIhF7meLX
         WW+Q==
X-Gm-Message-State: AOAM533e+hc4UzPOsDW0L1LqtKiLSF9mUvrVeEuj0asFNA4YHSRwTbiH
        C/ebJBZ1QehScBnNPcmZTg==
X-Google-Smtp-Source: ABdhPJzbYYGh+50s/qYT90REjaY3CzZFmBKEkQCXbq+dAzB9gdTAdEoLPnAFu40Kk0VlYPsicHoXCw==
X-Received: by 2002:adf:a1c1:: with SMTP id v1mr4768778wrv.205.1592580131741;
        Fri, 19 Jun 2020 08:22:11 -0700 (PDT)
Received: from localhost.localdomain ([46.53.250.254])
        by smtp.gmail.com with ESMTPSA id g16sm770354wrh.91.2020.06.19.08.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 08:22:10 -0700 (PDT)
Date:   Fri, 19 Jun 2020 18:22:08 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        javier.gonz@samsung.com, linux-aio@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] io_uring: add support for zone-append
Message-ID: <20200619152208.GA62406@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> 	uint64_t val = cqe->res; // assuming non-error here
> 
> 	if (cqe->flags & IORING_CQE_F_ZONE_FOO)
> 		val |= (cqe->flags >> 16) << 32ULL;

Jens, ULL in shift doesn't do anything for widening the result.
You need

	val |= (uint64_t)(cqe->flags >> 16) << 32;
