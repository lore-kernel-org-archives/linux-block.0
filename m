Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE44C001DB
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 14:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjHKONh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 10:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKONh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 10:13:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD89E65
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 07:13:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6874a386ec7so412354b3a.1
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691763215; x=1692368015;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxKTwgMpj3yN9lGWSWOwGFnVyHcZAUMXobQQNAAA2z4=;
        b=xiDVJ7nqQFIU+zxoSVkeuTdjOjOdwwjOHIyjaUGD5nlC3dWskLJ46ZOeNORH6jV0sq
         h6Scpw6V/v+fLV+aCHPQ6S7aYGCd++OgTMbr9ZtTHdWcJj37EZvSFYKYBK0/vdyI+JRD
         i1mZtw4IfsE+2ygAQJuUu40GL0jt7sTqKWQ/aDO58cYb3OxDqOIDRVkkt6WaxZyW2Vhk
         WgjYKOLlDSqPafSSQwxU6UuBApEWyhNCiM3ztpxfLc6DjNChZ9NssI7CAvGismBf2sD2
         6jJGe5vUWSrQuMYA6zjNgXY1xDv1azNk1T8kZtiIJSzlewfl0ESyabWCS8fHWR5KXQUU
         upYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763215; x=1692368015;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxKTwgMpj3yN9lGWSWOwGFnVyHcZAUMXobQQNAAA2z4=;
        b=OdF1z6cBJ3hfjb9idttr64Y9TGX9S/U6SzLEst/x5/HUsngbtCG/TSPDE9nvhROKci
         PDLPFQrzebzQfCuw9yyZrihhul5Is0pEDSUevwsCLaqR7nB26cimtDbOJfVHjeYuoiBw
         XxXJO6jgEBSKy8dc0TmyGO03TXZJ2bD727UUXYXg/MKSPnTPia4//3FTkud220kUHiBn
         JjhyeAyGyKRPJ0dHgTYTQOA1epzJzNOHE/JzWONdVOMIAvjXEKVpEG6DxJMNhAM//7j3
         Zg1ix+M5+540SQ6ogPUv3qSvuYgjKLk5sDiESk2INfoTvapH168sjzKd88hUhYKTQFUX
         8bfw==
X-Gm-Message-State: AOJu0YyM+uKTYA2tkB5aNc40FtxCiV2o5EgjHjEKnsQRQKtCAwZWIvsb
        7kn2rG1yeQ8fVlN2hDOCb0g3Ob27GzLh+3soEv0=
X-Google-Smtp-Source: AGHT+IGLPt+gUajvnyagkdIIHabRCwch9yxZ+WmtE94QXFIa75VbFm8kA/BepgsmLfafWCMvgi0Rbw==
X-Received: by 2002:a05:6a21:6d88:b0:13f:9233:58d with SMTP id wl8-20020a056a216d8800b0013f9233058dmr3184937pzb.2.1691763215591;
        Fri, 11 Aug 2023 07:13:35 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i12-20020aa78b4c000000b0068338b6667asm3359158pfd.212.2023.08.11.07.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:13:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20230811135216.420404-1-ming.lei@redhat.com>
References: <20230811135216.420404-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: fix 'warn: variable dereferenced before check
 'req'' from Smatch
Message-Id: <169176321465.160916.11466301531789958956.b4-ty@kernel.dk>
Date:   Fri, 11 Aug 2023 08:13:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 11 Aug 2023 21:52:16 +0800, Ming Lei wrote:
> The added check of 'req_op(req) == REQ_OP_ZONE_APPEND' should have been
> done after the request is confirmed as valid.
> 
> Actually here, the request should always been true, so add one
> WARN_ON_ONCE(!req), meantime move the zone_append check after
> checking the request.
> 
> [...]

Applied, thanks!

[1/1] ublk: fix 'warn: variable dereferenced before check 'req'' from Smatch
      commit: e24721e441a7c640e4e7b2b63c23c06d9a750880

Best regards,
-- 
Jens Axboe



