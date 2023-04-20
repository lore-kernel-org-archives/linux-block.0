Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A6CC77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 19:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDTTEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 15:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDTTEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 15:04:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3301995
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 12:04:44 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-32b625939d4so450145ab.1
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682017483; x=1684609483;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=321FOBJ4dEHL13eQ91j4GJNabzgencKGbsgJHFsFBI0=;
        b=H2WRhV268ghne0+CcBWBzJdU5avx4LWBJn1prb216v/Aa7PQTq9BanF0LFz+3Chm70
         LJzpHB5Dw86GpaSxvzIt3qJg7mwJtaMr/JHeIib+9tUwOhHzhuUnByZ08vzj5woJZs7I
         9QW8BRC2/8qZGmEZ316J4650QV8pjdD7nm2+puiW+X1UuW1JOQBzKh/6qzg2lG3l21LF
         Da+/P5n3XRWBcbFxuAjQHMsWcTtYBvnbo9MotERUfyb0f3HysNuN50VYPLl561fCvQJ/
         i+UP/uREv38J8uXecPUOyIrozlQnOzAzoG6XBOfEIO35ihJwotVq7QIL62qdO3XJrqL+
         0XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682017483; x=1684609483;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=321FOBJ4dEHL13eQ91j4GJNabzgencKGbsgJHFsFBI0=;
        b=NKWjkYR8ckX/GhFgCrHbGNRjqGNycsvteyguq06dCCtKVRM3u2/x3YPpD8S6vTC9NG
         8KknMFXmIWFMVUzdJcJA9ONd0t9C7sUBcfPCVUQZVUpnz8Ymuf6399qITgjeG/Choiow
         id1uim5xWd3POuQKv2Nrub6B+//2gU6GLxwTxUdUrO7msXqyEBxsvITpVtwEqRw2y5lU
         v2mHJZqJeXKEPspPX/iv1YuTB1w2kWjYpKxxv62M16/ye3j8C2FnKrBkp775PDovZFgq
         be63KW0hhMfVCLPy7eG4OjISJWE1UTXSdJDglqve7XL/toMM+SAG2UL4rh+ZKhcbycAG
         1h1Q==
X-Gm-Message-State: AAQBX9f4J8D9SLKHW4nTTSRAUh6ecC8AzV6uMCjdD750EJhB+5G0eqqO
        oimCDCojNMTGxR2O+fzyQgI5yQ==
X-Google-Smtp-Source: AKy350aitap0bvgJTwNViNmwGxoRJE+89NJLTSZeg5IjZV4YRjwx3mXliN5fC0eZd3dCeLebeBJP+g==
X-Received: by 2002:a05:6602:26c2:b0:760:ebcb:957 with SMTP id g2-20020a05660226c200b00760ebcb0957mr2178434ioo.2.1682017483513;
        Thu, 20 Apr 2023 12:04:43 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d9d03000000b00762f8d3156asm566959ioj.14.2023.04.20.12.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:04:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20230420091104.1092972-1-ming.lei@redhat.com>
References: <20230420091104.1092972-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: don't return 0 in case of any failure
Message-Id: <168201748279.133109.13409286278981630134.b4-ty@kernel.dk>
Date:   Thu, 20 Apr 2023 13:04:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 20 Apr 2023 17:11:04 +0800, Ming Lei wrote:
> Commit 2d786e66c966 ("block: ublk: switch to ioctl command encoding")
> starts to reset local variable of 'ret' as zero, then if any failure
> happens when handling the three IO commands, 0 can be returned to ublk
> server.
> 
> Fix it by returning -EINVAL in case of command handling failure.
> 
> [...]

Applied, thanks!

[1/1] ublk: don't return 0 in case of any failure
      (no commit info)

Best regards,
-- 
Jens Axboe



