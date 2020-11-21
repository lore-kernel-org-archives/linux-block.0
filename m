Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF10AC2D0E4
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 00:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F23723A65
	for <linux-block@archiver.kernel.org>; Sat, 21 Nov 2020 00:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgov9oQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgKUAEe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKUAEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 19:04:33 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B5FC0613CF;
        Fri, 20 Nov 2020 16:04:33 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so12672250wml.2;
        Fri, 20 Nov 2020 16:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkYcfvmDakdmQmwnyVh4JPSG/cRSYOu+JefUy3uu6fQ=;
        b=Fgov9oQOCvWkU9MvXIoP+uug07hlE1qO3PwWuX64UNJlMOBdC/Fn55wK8XSqhGH773
         2ElcXSP3YNl5MGrabuSr/nEFddfyQHTstRUgBZddD3/+KfdXVrJ0XBzpoj3Rm+ocMPX3
         pCMZeWyOq1fbZEpjuqPTigPiwYZL+DCQiargi95TBsfxSZ/gYzlqRXOs7xLxKhxBiNRx
         B+Bw/3mN+p46WU1mV7sHUguFWjXfLLhlnKTC9ATfEwTcVBTRG/TTq/uVww42Ggui/5TC
         9qULLQHEGf4gy5hSSYKT0Gd7FdBtWt1IxnZUbR3z9nRb6GvyVSndPwEqoyNgHujcMul8
         OTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkYcfvmDakdmQmwnyVh4JPSG/cRSYOu+JefUy3uu6fQ=;
        b=N3VQBTD8AE1lfA+6fImP/vLzbOR5StzN1skJlNXD4SBaPbP2Jq5w01L1lmXABi+ecZ
         sDUCVhf+uRutZbEdS/CgKJRDn/NC0WCZU59KBwc3MQsC1J40PSltc6g5NAfwt+DqmDtj
         qqnp/KnHvVgsXdjWykqohzX0hoCO8gBLUt7e3S13hXe94nE7/XnKubfcgCoRjzr7Pj0B
         53NKljEcFp6ysA0Fo03flDYBZAKcdQpK4a/nt7nVgxLStnff21FmpiSRNB29LUPmZa/z
         mUOXSZU0QpEAWYRpD5CJxsqt7rM6X+3IKRER9Dc3CE35hNvPL97iUNI3nyomJ/AQAUuF
         RsCg==
X-Gm-Message-State: AOAM530b0VOVp3uIzEuM2KEHacoToUnlhMsCun9U+lyoyRI+LcAgUzOh
        nU94mamK3kW4Aaf7s8OoNJ4N3LDKZao=
X-Google-Smtp-Source: ABdhPJxmv+Yf88QGJBlRgfyp9AxCDwe7mH52rrASD3Qti38rEr3MAgqNxwFUTQVMMOG7ETUYAqEIkA==
X-Received: by 2002:a1c:2c2:: with SMTP id 185mr12451580wmc.103.1605917072001;
        Fri, 20 Nov 2020 16:04:32 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id d3sm6145518wmb.5.2020.11.20.16.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:04:31 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH for-next 0/2] optimise sbitmap deferred clear
Date:   Sat, 21 Nov 2020 00:01:14 +0000
Message-Id: <cover.1605908165.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In short, sbitmap_deferred_clear() lights up pretty much in my profiler,
so these optimisations gave me ~1% more t-put. All the heavy stuff is in
[2/2]. Would love someones eye to check it.

I also want to replace cmpxchg() in that function with a single
atomic and, that's slightly lighter and also transfers it from
lock-free to wait-free, that's pretty neat.
The problem is that apparently there is a non-atomic_t atomic and,
and atomic_t is unsigned int but all the bitmap do unsigned long.
Advice is welcome.

Pavel Begunkov (2):
  sbitmap: optimise sbitmap_deferred_clear()
  sbitmap: remove swap_lock

 include/linux/sbitmap.h |  5 -----
 lib/sbitmap.c           | 21 +++++++--------------
 2 files changed, 7 insertions(+), 19 deletions(-)

-- 
2.24.0

