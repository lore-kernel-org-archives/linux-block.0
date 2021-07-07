Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA85C07E9B
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 15:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41D5619C0
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 15:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhGGPeb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 11:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhGGPeb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 11:34:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7DFC061574;
        Wed,  7 Jul 2021 08:31:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w13so2125610wmc.3;
        Wed, 07 Jul 2021 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQn9a4zjHHkcyd8nWBIk09uRnMx2xEYAXpXVNFTpdbA=;
        b=FywxYZ0w7PhbZPy1z43/Z/FLPkbHVBVsZu/4+U+T+ZpeEOaC5cJnIIczucsqHHX+dV
         jTu8LDX7kJdN5fiqEId9ExAklTEFb1GUGKifRGmvaP2vwhfp7yM1Snv8dqU2fAzEsp9m
         t3mNgD2ksPAVYw0aT6Oc1gLHoukmAhBf4vui5DBFMd0ujxN2+yNEYERUKMJaC+i3rSO0
         q4X7wbJel6JA1YSkeSzSHAOLjI5fHhIYEL+xfmrQ5XvlcRyQ60TWZ5TLNcYt5LAFkxac
         IYAqzbk2fsCz/15pW/eaIhAobTpAqj10f2iJ8C085iyou6Gn3Of5yRu2l/eHbnbh+DAv
         Z0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQn9a4zjHHkcyd8nWBIk09uRnMx2xEYAXpXVNFTpdbA=;
        b=HtULEtMGLJ9tFaqgvcxzUDGn1FNvpB0jpu6lv2ZhqDlBuFhvFB4OW+bo6h+Xy+8Uwh
         /YbvQ3k8+qs6FitLFDAQ3wW+QtidRStcYNx0l4EThUhcUQggN1234jYTxMH7Tnjl4xa3
         UwO1ow1uzjY0L6LH1LMA1X5o+5L8NAj/P0Ii4N8C9nvZ5bpk6dx/S9MK2HHcD0bGwI4k
         tT1ZzsUvyrHeAsYcnGRik74oIptYcXJ2qR6Ws+tOS1+ugo3d/5+4vo7OLb5Sddl1DlNN
         ZaDqoqBb351w8M248Mx6GNEIhKB/lGcgHlKJKM2LZTW+dCAeqCKYM5h4TgVeua9UjoXE
         8/7w==
X-Gm-Message-State: AOAM5329eeKz8Xd8e0sp+cXIMvDqikANoGEnSbUYeZJ9GJHQiTN6arWr
        lj/ju+cS2DSodItnIOLoLkA=
X-Google-Smtp-Source: ABdhPJw1Vcl8Qu3j3vcqh7x0hGEs+y8bp1eskE1vLjJ0m2ypT/PAEsFSOOECDxtDNjAMNRedjrZTbA==
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr185653wmi.139.1625671909447;
        Wed, 07 Jul 2021 08:31:49 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id o3sm20847579wrw.56.2021.07.07.08.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 08:31:48 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     arnd@arndb.de
Cc:     hch@infradead.org, deller@gmx.de, dave.anglin@bell.net,
        axboe@kernel.dk, bernie@develer.com, linux-parisc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: div_u64/do_div stack size usage, was Re: [v3] block: Removed a warning while compiling with a cross compiler for parisc
Date:   Wed,  7 Jul 2021 17:30:53 +0200
Message-Id: <20210707153053.62237-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
In-Reply-To: <CAK8P3a23=tcWx8iWNAKXcT9TRgPrZbEVVy9a_ad29hSde_jkKg@mail.gmail.com>
References: <CAK8P3a23=tcWx8iWNAKXcT9TRgPrZbEVVy9a_ad29hSde_jkKg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sorry for late respond, I was at work. The problem was solved for me too,
after setting the CONFIG_CC_OPTIMIZE_FOR_SIZE, and I have went through the
gcc 9.4 manual to look for the -f option for -O2, it seems that all -f option
that we would not specify is already excluded with -Os. changing defconfig, it
seems for me a good idea.

Abd-Alrhman
