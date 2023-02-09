Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F79C636D6
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 15:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjBIPNM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjBIPNL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 10:13:11 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CD45D1E5
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 07:12:57 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r18so1741797pgr.12
        for <linux-block@vger.kernel.org>; Thu, 09 Feb 2023 07:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUsloZN2imGNoJ9xZqSEFM0OkT75KLqemOD7adq/Qpc=;
        b=OmcpHZRIeQssC3VLtnzbaca/Vb/YqroPYy1hMJ1t2wBH5S/+MoFfiQZIaSC11a03Dq
         zy1P1lxdQW4Ox4bcN//U9+kjpq5LQr3LZiVmyFbOB/0Jo6yDXqHuGmMeWxiLel36REZu
         EnXnq0dy8N1ADC6ApalmH4vJi4BWTpcNT6RYsNe15sg330xs/5XAHlWWzVvOwmvwB1Ti
         +MbzrW6KMNxVGNd6rCHSmrXs8mPh9kwxZVMye2/P26D5nO31J8JTKjX6/27I/cmg0Y7/
         UlIga/CAJMTTZ+V4u069lNRg0Lj45Dxgu2iUg6JuwTWCN8hhn553Wp3zirGAWEU1SSa0
         Ep7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUsloZN2imGNoJ9xZqSEFM0OkT75KLqemOD7adq/Qpc=;
        b=xQmVmu/OPVa3wBrkGq/E5WyaMCBmqDKUMR96qWUK0SOcbEgoLlq43YKQV8kSMvkJb7
         vGCmCFpeBM+bJePdsDA57Vmf5mAtJY7ngg+4kZgJ0EY7NOEd9aFdzXy3JilN9w+zXj+w
         IcKeEP2dXhEJIAzHku/PzKD0Ma3/MnJGBBMkR2BM2vuDHT4Yk/TfSI3jz1ZktivC8FFx
         dQMXnB/v5B+qNDPrA82pCs0Yu0ylPSL4fM2Ckv2dicn+V9t9JIhiS1EIXs6TDU+cQpvs
         NTiIWILDaveusrZZ68sSZocxx5D4dTRJgkgUpA+5rLesKZpU522Sz6zHdwLxKEQujUYl
         GwlA==
X-Gm-Message-State: AO0yUKWtVtiFuf5u55UdsZndX7R5m98jNSPDzg1EIF3MzpvI2y9SiAKr
        sjzcxuHbSusg6CWwBoS0IX55Tg==
X-Google-Smtp-Source: AK7set9mBexRpKJ4Gt18CmTNNrW55B+J0EYKXWrJANNvd88c204NIxCE3lp2mXU05AJfOIZOv03Drg==
X-Received: by 2002:a62:d156:0:b0:5a8:4dc6:a1a9 with SMTP id t22-20020a62d156000000b005a84dc6a1a9mr3510215pfl.3.1675955576567;
        Thu, 09 Feb 2023 07:12:56 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78d43000000b00593906a8843sm1585716pfe.176.2023.02.09.07.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:12:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230207150700.545530-1-ming.lei@redhat.com>
References: <20230207150700.545530-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: ublk: improve handling device deletion
Message-Id: <167595557586.325128.789287147510588091.b4-ty@kernel.dk>
Date:   Thu, 09 Feb 2023 08:12:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 07 Feb 2023 23:07:00 +0800, Ming Lei wrote:
> Inside ublk_ctrl_del_dev(), when the device is removed, we wait
> until the device number is freed with holding global lock of
> ublk_ctl_mutex, this way isn't friendly from user viewpoint:
> 
> 1) if device is in-use, the current delete command hangs in
> ublk_ctrl_del_dev(), and user can't break from the handling
> because wait_event() is used
> 
> [...]

Applied, thanks!

[1/1] block: ublk: improve handling device deletion
      commit: 0abe39dec065133e3f92a52219c3728fe7d7617f

Best regards,
-- 
Jens Axboe



