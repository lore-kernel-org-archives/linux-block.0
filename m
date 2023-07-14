Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11535EB64DC
	for <linux-block@archiver.kernel.org>; Fri, 14 Jul 2023 19:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjGNTos (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jul 2023 15:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGNTos (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2023 15:44:48 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32A02D57
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 12:44:47 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-780c89d1998so16013239f.1
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689363887; x=1689968687;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veFKUMZBQrX/Dj8inbuI++veCSXQIqVt2O+DqAlAqSY=;
        b=nI/ZAOQV+22/fvMKdASmAS2SLR9eTK2unZNTUpvZw/A/zJidy+4aCVns6AEKtElt0C
         TI90FTvp67Dbr9Qp8foTg3k/whZFGH3wrHjcTpGaM+5A01LFuZnaMxuNqH+fvGUN+ftT
         2Zg24dm1e2Zmn6JCnTLUZnM3si7Dy+ctAWpZP86X2l72fqt/Mj7pStO4ak6Bh85zmuXG
         TtUPdpVwoQ9qT5vXxmRUs7+T+imGLj7dKZblJT6G9YRE03zswHcVrH5OjViWr/PSZJCc
         qr6J7Ntj7aWafAKtoe9HYjXrtTpYbSJFsrvEn/cw3vxvOS0O5z2aEoQlfWwbdhKKoFIb
         oHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689363887; x=1689968687;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veFKUMZBQrX/Dj8inbuI++veCSXQIqVt2O+DqAlAqSY=;
        b=iwtz1iVfWXR+5F1Vd2fOMTH4QeFz654qkoHOp8u+bxL6linryhtphXJgPdR37WSGmw
         PNIW3H4O6oy8wcCLtJZ9gaJH3a0b42kcM905KPCRKdZuV0H0fxCOvEzSFRWUa9xZgB0T
         6uZlw+73Fj1gFd9VVFPWhH7twizWCOu8D82aUrSL46OloBluJX3u8YVoygxE6x+RPY8E
         2EKKfw5tqDYhn6x+cvLTyOhMIheCdtHKPvcHAmYUZt5L/DDOMfn0vwVLb4l8JlhwUFLM
         yzqNymNYf+Z9M2lrlUI9hjmf3Ii5j7o8sUVDLipxD7tMpxKWBaUmCvKKlHRYwDkNqTSG
         K4xA==
X-Gm-Message-State: ABy/qLasYh4PjhVY4kYZXpmBrAT0HSFqP6AimdPnixG7BXpSC16inMtR
        2pGvh/vcfVRbqyaiMu5VjD9s8fgykTtYRkRFg44=
X-Google-Smtp-Source: APBJJlG27kU39KKaVWGTaq5CRYEHuODaHBkyLwAjTzymnofWUm93qrBD6npjvYvi1P7RfNjMUISuhQ==
X-Received: by 2002:a05:6602:2c93:b0:780:d6ef:160 with SMTP id i19-20020a0566022c9300b00780d6ef0160mr197778iow.1.1689363887060;
        Fri, 14 Jul 2023 12:44:47 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o27-20020a056602125b00b00777b94e8efasm2880017iou.18.2023.07.14.12.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 12:44:46 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230714101106.3635611-1-ross.lagerwall@citrix.com>
References: <20230714101106.3635611-1-ross.lagerwall@citrix.com>
Subject: Re: [PATCH v2] blk-mq: Fix stall due to recursive flush plug
Message-Id: <168936388618.743920.17372805107217904539.b4-ty@kernel.dk>
Date:   Fri, 14 Jul 2023 13:44:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 14 Jul 2023 11:11:06 +0100, Ross Lagerwall wrote:
> We have seen rare IO stalls as follows:
> 
> * blk_mq_plug_issue_direct() is entered with an mq_list containing two
> requests.
> * For the first request, it sets last == false and enters the driver's
> queue_rq callback.
> * The driver queue_rq callback indirectly calls schedule() which calls
> blk_flush_plug(). This may happen if the driver has the
> BLK_MQ_F_BLOCKING flag set and is allowed to sleep in ->queue_rq.
> * blk_flush_plug() handles the remaining request in the mq_list. mq_list
> is now empty.
> * The original call to queue_rq resumes (with last == false).
> * The loop in blk_mq_plug_issue_direct() terminates because there are no
> remaining requests in mq_list.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: Fix stall due to recursive flush plug
      commit: 70904263512a74a3b8941dd9e6e515ca6fc57821

Best regards,
-- 
Jens Axboe



