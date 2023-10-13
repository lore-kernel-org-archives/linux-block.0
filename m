Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BDACDB474
	for <linux-block@archiver.kernel.org>; Fri, 13 Oct 2023 01:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjJMBFP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 21:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMBFO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 21:05:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC4EA9
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 18:05:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690f8e63777so387872b3a.0
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 18:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697159112; x=1697763912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFKNxhJyELCJ4CtwQAGJllnq1EOws5WG7RiXFQG+45Q=;
        b=z2QqMCKkbLdCJcIxb3QIPoJsd5IMNcHQ39fhFy3Bx4COcmaux9wqQXmKCHKtISiUyW
         U69yKwTZe+1tRckor2bzjBs347bm/HRav0vEtH+vOY5jFpudZgjEmH9zL10AtsInjSy9
         AeJM44VIsjQl4RsVD9Kod00xy1Fh3DIFgUdk197ZCmGGXIJO8qzF4Zs7CKc6zrMNTx0/
         1egedmthkBPwljyXLLaU31fKgyn5nPeFBsVQVZsYHiVebSGiO1YDo19otsnYr51BgUL7
         3lKJNli7xCb3Z6q7PYTHmyLxresSW2Sun/bGagkeB7fkq6ponG3qMnRF1MpikxlPg6L8
         a/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697159112; x=1697763912;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFKNxhJyELCJ4CtwQAGJllnq1EOws5WG7RiXFQG+45Q=;
        b=KtiH25Li6Zad+KHheXq8kKS/5rHm64dWGJ036eBzCCSTF07cnU9soKd1pdGLT8JDkF
         L2lD9phQfTqH2Z40RCI92pl9q6G+nHqrZzxs6I+FSz2mSTFhEFAfppwxp8JHja8CAPlq
         X6N5RvwvqMcVVbX2M9zZpqgzafkbZnG7J6BBuY0K6IASxSBwlTPo7qe3tYnoMZivFZpI
         mfEFzP5lUvzyKXn2Df890CdCnEbFYWZdU29kHJr1e2djAk6NJULM8kxIbOTLf5FdDydv
         6A6+D9CrzLdeWGgXabvsQ5wv9SEgym5Eh9xC2RmpdHM7ordHlzwvXhtGTl3ZT8K+Ovmb
         RNjQ==
X-Gm-Message-State: AOJu0Yw4OsPxhKxYyJ9zfoNgOx7A9r25BVk0ynel3IkJzJt8vSXrSm9L
        3emtyIojq+6kaTFwW2xWQTkrIw==
X-Google-Smtp-Source: AGHT+IFv+oO+Vpo3LoGswek7+pL5Y5ICAsLd9QOVM9Q2QrE4UJs/0vWdyUV05tm02DOzk1Katoay3A==
X-Received: by 2002:a05:6a20:7d85:b0:163:57ba:2ad4 with SMTP id v5-20020a056a207d8500b0016357ba2ad4mr30545266pzj.2.1697159112198;
        Thu, 12 Oct 2023 18:05:12 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id fz2-20020a17090b024200b0026b46ad94c9sm2433918pjb.24.2023.10.12.18.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 18:05:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20231012150600.6198-1-michael.christie@oracle.com>
References: <20231012150600.6198-1-michael.christie@oracle.com>
Subject: Re: [PATCH v2 0/2] ublk: Allow more than 64 ublk devices
Message-Id: <169715911113.1830750.8151305758997406451.b4-ty@kernel.dk>
Date:   Thu, 12 Oct 2023 19:05:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 12 Oct 2023 10:05:58 -0500, Mike Christie wrote:
> The following patches were made over Linus's tree and also apply over
> Jens's for-6.7/block and io_uring branches. They allow users to
> configure the max number of ublk devices. We are currently converting
> users from tcmu to ublk so the 64 device limit is too small, because we
> have setups that have 512-1k devices.
> 
> V2:
> - Set UBLK_MAX_UBLKS to UBLK_MINORS.
> - Use param_set_uint_minmax.
> 
> [...]

Applied, thanks!

[1/2] ublk: Limit dev_id/ub_number values
      commit: 8378a3e3718eb47f0ff404f4830fc07ea5c51f40
[2/2] ublk: Make ublks_max configurable
      commit: aff3a66230e078e35cbaa7c68537e87dc78dd887

Best regards,
-- 
Jens Axboe



