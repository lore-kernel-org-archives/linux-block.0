Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6626C77B77
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 19:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjDPTCl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 15:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDPTCj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 15:02:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7B3270B
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 12:02:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b78525ac5so576330b3a.0
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681671756; x=1684263756;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYoxsiNUY531J99P8y11bpcqupZdrsSJyv5wFnhQix8=;
        b=a4S78BfGQwcOM8W+trdndPtm/K1bvBRZ6nyD7VGFTIFi9OXI01K6MUSVKXePIH63yy
         12q//RcaGeXHxJN8oDdG8+E0Y87o2NrKJ1sfeGrZBD1aXuyQlrmcn54IEeciQuCbyh4j
         7fJIBQQMm3t/RQTwmjXNwNQP2WvhVG6Th7B4pXVvBgYu1t195LBTVZQtgD4ST5pJEwwu
         6IVtmCTPu0aOnlo+bzRdlRG39kK6NxtbYCCWLbE2GFsQIFNKXhx4n47yQ90utM0d+QT4
         dHe+BEn2CRZMjnx6qmn8NBccgHr5AveyqW7HMgMtfUhQtKW/tpS2jxtnTO8POgtJv7NH
         eJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681671756; x=1684263756;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYoxsiNUY531J99P8y11bpcqupZdrsSJyv5wFnhQix8=;
        b=g950WYp8TRRjdcJgWkMMvNj4kziakMsaRYT9K4eRtUbz+zn9LO1zea6acG5i8fGiuO
         kX8lZGPWPlmtuXhsuuy+ijMeFkaPaDX8sTQM4PFEJObO7sHrKuc47dyoD2vEhEHHGnP/
         hmBG/UPkcmh3UDhC+0r5AxkF1HN3EkwA13Lm4PP5gcJD8DHjLP2cHuyvGsMegQAzoT59
         GNs0L9p73SE6Vb/pemThvJTgvnjnbxkyCjCokHb5wTTCcwe5dck10a31g39P14wSbRO5
         JLA9XQzh9NH6Rgf8b7YPX0iYXV7F7wUbKl4M7Rkd7rUxMqnoP6fHtK2GkTEr4M6fIQnA
         GvNA==
X-Gm-Message-State: AAQBX9cZxhfQ34nkJtRB5THnQuntQy0cWJZcaZwMfPMgnjPU/U5ygIj8
        AurAQFR8dRKkbDKjki9ddGAwtQuhasC58XN+Vgo=
X-Google-Smtp-Source: AKy350Zl6d2wqYdoHN7Z4xSLKjexiyUIHxk3CaJYYe4yNQyDS/434FAAgPsfZnjrA4RPEZy5BTRVfQ==
X-Received: by 2002:a05:6a21:328f:b0:ef:e780:72d6 with SMTP id yt15-20020a056a21328f00b000efe78072d6mr347058pzb.2.1681671755984;
        Sun, 16 Apr 2023 12:02:35 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 12-20020aa7924c000000b006258dd63a3fsm6176156pfp.56.2023.04.16.12.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:02:35 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230416073553.966161-1-hch@lst.de>
References: <20230416073553.966161-1-hch@lst.de>
Subject: Re: [PATCH] blk-mq: fix the blk_mq_add_to_requeue_list call in
 blk_kick_flush
Message-Id: <168167175516.156307.9788404143285948106.b4-ty@kernel.dk>
Date:   Sun, 16 Apr 2023 13:02:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sun, 16 Apr 2023 09:35:53 +0200, Christoph Hellwig wrote:
> Commit b12e5c6c755a accidentally changes blk_kick_flush to do a head
> insert into the requeue list, fix this up.
> 
> 

Applied, thanks!

[1/1] blk-mq: fix the blk_mq_add_to_requeue_list call in blk_kick_flush
      commit: 26a42b614eb934f400cd3d1cc0b7fa1955ae3320

Best regards,
-- 
Jens Axboe



