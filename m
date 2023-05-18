Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3811DC77B7D
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 13:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjERN7U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjERN7T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 09:59:19 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4194DE5C
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 06:59:18 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-76c63acb667so9231039f.0
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684418357; x=1687010357;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7g1I597iIp4NAkbt20b5F7NYBEkAibhPCMLzk3nUp8=;
        b=s9pLK79eCSvZh2y0LBypPG09p0xKjw09TMQyHeMPmh86jbQS+QXHNfBQDlIhafiD9e
         av61kKEkxHbtuNRMPSFRiRhzKab/M2qnjcluNXMSffJxbItsS5wVEj9D0lo2HEAqS5Uy
         JHOyYusaHYdT2BtJNGj5lXgE7C60Alyt7o9R6f+1jupTXGlrZBuzp6P5reBB5ZSa2r5A
         YcAt5+6jaIV/YDWw2Ao+WmBhOqhpRmocPJHsyXItJFI+HaFBv9l/GLdweRvPjLnm7J/o
         N+LkLNXGEHvPVT3ZxXtsNjA+B6niOihNd4EOJ+nds4qK6aMPnAgfUD/KZ4Dne26ujm/u
         GreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684418357; x=1687010357;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7g1I597iIp4NAkbt20b5F7NYBEkAibhPCMLzk3nUp8=;
        b=fyaFbdzPVaum1jLJhaMqjJi3ggeoHGCB5sw/ggsoK3UtyXN76RgyUaCHm2NtHkOLG2
         mzU2p2FuspSkNbWjGOv0w+FSHeKGjOcJ+JCAdzc/ebHHw801a2uYToNY7kW7Q+cpPGNG
         FJ9MjoA4psaNxWNmy3tHBN8a1Al4RA0G7BESANFrtf/WGLzK6MoYheOxxv5Snx/1xvNo
         4i9ISvZQPULd3qw6NY1vyOJzJslIfwTzZSOvEMKnldr6NoEvg90oVVCa3g7yiGlquNgW
         MQqXjIgJ/WTDsJOxg3Ivt8BlMFZhuisMyy7InMmIUzym1Qq74jDx3g9KIavFsq2pxnBf
         kIiQ==
X-Gm-Message-State: AC+VfDxKdYTcTksdeI4pIhhAoyELfRspSEMS9Kzqpi+vlDhTPXbFwBxO
        XO7YWawXluywtiI+IFELDxosJw==
X-Google-Smtp-Source: ACHHUZ7pwHmaqi0Qff8eqyTHfyvERE7Dt0ZNtZ95xa899On9c6M7Zuj8xn98RK/+qbB+6GGX0pKuoQ==
X-Received: by 2002:a05:6602:2d13:b0:76c:883c:60a2 with SMTP id c19-20020a0566022d1300b0076c883c60a2mr4443328iow.0.1684418357635;
        Thu, 18 May 2023 06:59:17 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f61-20020a0284c3000000b0040fa75e5a3fsm445429jai.132.2023.05.18.06.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 06:59:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230517133408.210944-1-ming.lei@redhat.com>
References: <20230517133408.210944-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: fix AB-BA lockdep warning
Message-Id: <168441835654.2212592.3758370917789453249.b4-ty@kernel.dk>
Date:   Thu, 18 May 2023 07:59:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 17 May 2023 21:34:08 +0800, Ming Lei wrote:
> When handling UBLK_IO_FETCH_REQ, ctx->uring_lock is grabbed first, then
> ub->mutex is acquired.
> 
> When handling UBLK_CMD_STOP_DEV or UBLK_CMD_DEL_DEV, ub->mutex is
> grabbed first, then calling io_uring_cmd_done() for canceling uring
> command, in which ctx->uring_lock may be required.
> 
> [...]

Applied, thanks!

[1/1] ublk: fix AB-BA lockdep warning
      commit: ac5902f84bb546c64aea02c439c2579cbf40318f

Best regards,
-- 
Jens Axboe



