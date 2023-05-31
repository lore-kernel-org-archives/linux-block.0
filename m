Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63B1C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 16:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjEaQVR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 May 2023 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaQVQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 12:21:16 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96A4126
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 09:21:14 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7748ca56133so25041739f.0
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685550074; x=1688142074;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCNYIZMh0VCAQl5u0ro+C+7Me91NUFmJ7xbiQ3ZleV8=;
        b=MqO0Qkc6Sft8fEB3qZM360EkSqalNMCwvMjFTbWOGu66sPWBuCG5IJgUXUuZ5m2V8S
         5PeBprTTw2d0Da2qtV58unpQ7f9FO/BUa82lSVHAQzdNMW+8kFvKzDmmaww6X8ZqSP0s
         uNLgEMu/qCTy3U08EbCHMrAbqBC2Mamt+yjUMM7Los7dvOCzJgoVaCitstuvw10w0xmu
         9krP9H4u9CNElc5lhDagCUGt5eUTX4LrtZjiNV4SKETk92bdBtOStUMvc4+MKVX39D9D
         yyqBygfsY43tDmnu4rgMG0TjVbSK0X9dC8c6BhgXoYpPSRzhswbxVwK04BBd7g9wE0Fo
         bVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685550074; x=1688142074;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCNYIZMh0VCAQl5u0ro+C+7Me91NUFmJ7xbiQ3ZleV8=;
        b=QgiZHXRjX/gCp8G10mqso5x7hRqpODBBVx8ngX0JfmgmXKdR7vYiHBEVWobMkDJ8/i
         PufItz6n+AeCSi97NxWEweCcCWUeQF31oBRZl070HmikeyYJyg2nWNgU++Ug3UKK0pAj
         +vCxFotc2+odFC35hdjw4lm5V+sPAt9i8nNlw1wVunQD6ZuJkP1XnDTSsR5GQSNgpyme
         vQ0dmlADQpWUAySRotNInHt38RPwZZI88B78Kp30LqO/LAJiuSRrlgfoK1nthtpG+Bau
         /DJCIsrKzEX1tsRm4qNS5gsnIeCAZbMx77Ejohbc4Av83b/lUM24BdrreIoAvHrOZmJz
         q/dQ==
X-Gm-Message-State: AC+VfDzAXEd4aSeDJywN+rCygBUxFTtU50tbY/7LH6Y4VOh8jIP6+7hb
        mPWLsjAjqERmf46MvywulAiXY2OLkBPr0eMbJHE=
X-Google-Smtp-Source: ACHHUZ7XkmaaL84ol4JPVQFe78ajEmm17OiN1f3wTJZYxvO25zasrvdApynXoJiQuf9643RbgcNMIw==
X-Received: by 2002:a6b:5f1d:0:b0:774:9499:6590 with SMTP id t29-20020a6b5f1d000000b0077494996590mr2005418iob.2.1685550074318;
        Wed, 31 May 2023 09:21:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w13-20020a022a0d000000b0041669a9fb62sm1486855jaw.131.2023.05.31.09.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 09:21:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, dlemoal@kernel.org, quic_pragalla@quicinc.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230531073435.2923422-1-yukuai1@huaweicloud.com>
References: <20230531073435.2923422-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-ioc: protect ioc_destroy_icq() by 'queue_lock'
Message-Id: <168555007304.194776.14532611731698933970.b4-ty@kernel.dk>
Date:   Wed, 31 May 2023 10:21:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 31 May 2023 15:34:35 +0800, Yu Kuai wrote:
> Currently, icq is tracked by both request_queue(icq->q_node) and
> task(icq->ioc_node), and ioc_clear_queue() from elevator exit is not
> safe because it can access the list without protection:
> 
> ioc_clear_queue			ioc_release_fn
>  lock queue_lock
>  list_splice
>  /* move queue list to a local list */
>  unlock queue_lock
>  /*
>   * lock is released, the local list
>   * can be accessed through task exit.
>   */
> 
> [...]

Applied, thanks!

[1/1] blk-ioc: protect ioc_destroy_icq() by 'queue_lock'
      commit: 2dea233fdc6a00e53bf2ee5cd4b6fca353fd81f8

Best regards,
-- 
Jens Axboe



