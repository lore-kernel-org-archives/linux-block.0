Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2646EC7EE23
	for <linux-block@archiver.kernel.org>; Sun,  4 Jun 2023 14:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjFDOfS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Jun 2023 10:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjFDOfR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Jun 2023 10:35:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB14DF2
        for <linux-block@vger.kernel.org>; Sun,  4 Jun 2023 07:34:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6584553892cso149651b3a.0
        for <linux-block@vger.kernel.org>; Sun, 04 Jun 2023 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685889273; x=1688481273;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDNiEjmcT76CGWhVA0wu0AtafPvzFp9/FTf2B8bDrd4=;
        b=mwb2a8sbXziJagMciWe4iNgQXJhC/Lg6+YFAMmVZ8s/vdpJLkyLX11XT73DdkquHc/
         oylWrD44nbHTNuhMi9HIVIGO4uGITfpPBxgucb1nrLzjQaLrudA4FQKvZMys05AhrQw7
         /VhUaSOniYeBHBUMzUtutAINo2wKG+0EfLZoqyfvTBiDj+85BM11fxCdqOuoHo4sWW9S
         78iQsDkZWi7bEieA5wiBiOILvgEMJ4ihKkQfEGfLGON99L9/k43yw9ferYptb42NexI6
         tQuojI5Fh/emgnXQ8bPnI9mTxS8W1uMuRydlfuQsOX8iXwymNOJVlAuEthuDhngIDt2y
         ZC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685889273; x=1688481273;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDNiEjmcT76CGWhVA0wu0AtafPvzFp9/FTf2B8bDrd4=;
        b=Nkmb4cQvdelmxoXi1WcKB3RYAc1j2Ickq4dYYHZ2+/cBhheR6QaRAeSESsKPix5Fxq
         kfOuQZCK5urzkbmnDS4Qn4HeHjtTf7fClOjZSjb541MC+6M/cuLtkDbgHkeZCInILFPv
         uFy9MydR+15eCDBFnXOeO5o1pvfycMiMnr/+96ONwVP3Ylt+qVex1/9Cuk1FpHSvXWvc
         9Ypmln+UU9s5b1BQcGd/m8GEOVLpV1jLgB6I19tDZYw4RfT92cuj33oBtdQd8OtO+CLr
         gCvZT/9XHtXcCM9EkpOE3X69kFRtX104gXwq9erF0iL4TJsfGRadkuOFCEZ7jPXEJhpL
         HxAw==
X-Gm-Message-State: AC+VfDxlZPAYgntcs0tTDbw7H/v08ZT5IULUka301AQ9oQmPI6VpQMQU
        P9rB2dtMZiSa3pZ+z0KoLeiDgaH3b5oU7JocpFQ=
X-Google-Smtp-Source: ACHHUZ6pGUWcTED+h01ZniPB8QE4IEChgQ21iuFfccmXDXTNC6s2glszqAUyqIwW1jBS5Jik58oUvw==
X-Received: by 2002:a05:6a21:339a:b0:112:cf5:d5cc with SMTP id yy26-20020a056a21339a00b001120cf5d5ccmr15721624pzb.1.1685889273303;
        Sun, 04 Jun 2023 07:34:33 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x5-20020a654545000000b004fab4455748sm3835941pgr.75.2023.06.04.07.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 07:34:32 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230603040601.775227-1-ming.lei@redhat.com>
References: <20230603040601.775227-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: add control command of UBLK_U_CMD_GET_FEATURES
Message-Id: <168588927222.4566.13635658855258211518.b4-ty@kernel.dk>
Date:   Sun, 04 Jun 2023 08:34:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 03 Jun 2023 12:06:01 +0800, Ming Lei wrote:
> Add control command of UBLK_U_CMD_GET_FEATURES for returning driver's
> feature set or capability.
> 
> This way can simplify userspace for maintaining compatibility because
> userspace doesn't need to send command to one device for querying driver
> feature set any more. Such as, with the queried feature set, userspace
> can choose to use:
> 
> [...]

Applied, thanks!

[1/1] ublk: add control command of UBLK_U_CMD_GET_FEATURES
      commit: b5bbc52fd01278642773818642288999a0236cb6

Best regards,
-- 
Jens Axboe



