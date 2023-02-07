Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCDC636CD
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 14:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjBGOV7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 09:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBGOV4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 09:21:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2740213E
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 06:21:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id i2so2371674ple.13
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuLo5xmCQA7HCDPYB+dPYCIEzUJh8YFIDf7ruxM4qCE=;
        b=mymHd5wVulEhDFURIvOVP6Canl4YaLV7h7awsmV6Nul3FH+zKN7q74r17SdAJYSeuP
         8JL5z/f/a7fW38AfgDMHY4+0SrSkuX186tfukvztq5d5D+cpoumBkozUNSUKrtqS5kWx
         jGfq5jYJk8pPqFEHPJVzH7Cq5eLFdyv+Ygh5OfoNCxwLlv7kRu5mDVv/Tm0DP9j5vmMR
         PnubS3nBbOdCuE1UIF7n1fIXwYdXEHHA4wqV0rfzRnZh0oICVMLJVxRA513Iolwpml1+
         KrXX/mk8GeXw+PSa+AvcFZH6meQ7USMkugMRBYJTL9oYTScX7lGL1D0YTOxa7t9HuQFX
         VEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuLo5xmCQA7HCDPYB+dPYCIEzUJh8YFIDf7ruxM4qCE=;
        b=Poq/GRTDNMPUOxaf2fDYZhA1R88F08q8T6WXWtbwhPzoeH1unUsEkBIS6/ZDzCSHRB
         odfCa84OTz84KeKvA/P2pKjqd1puIAplr/nomtlOREDtIDzPEWnH46TRBZ6Ja0Zv2p+7
         4VOVX3xhQU1FXm3uibTw2sX1nIE4hJHcVEmLeb05cfLqd39GZVScXs4aNCZBZMNenaB2
         YBo0scUVuJ6892RIJ6gVETdODZD7Z3muouKcv9zMnY6FKdtvrtT4wCatkEWLA0AfhJrM
         A7NJaWqjTX7ExW6naOIBHXRKj7HPd0MhhtQyTtxtqNAYKvakl1lMD1P6Bsa4jaGQGxs4
         Juww==
X-Gm-Message-State: AO0yUKWpPZYustTsjp00PazAv0rnCRCLfZ4huFywnKzXdf01SXA5nQFW
        Etx9SpFf5zfGyewx0JA/ydzeOA==
X-Google-Smtp-Source: AK7set+lo6k1ZYQG6kZyGznnpvWpXiNfKJmSb4W9HbiZmZf0HC8PVSLbclmFhLiAR0S6qAJuDTZq4w==
X-Received: by 2002:a17:903:182:b0:198:a5d9:f2fd with SMTP id z2-20020a170903018200b00198a5d9f2fdmr3372813plg.6.1675779712592;
        Tue, 07 Feb 2023 06:21:52 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x20-20020a1709027c1400b0018963b8e131sm8937392pll.290.2023.02.07.06.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 06:21:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
In-Reply-To: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
References: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH RESEND 0/3] cleanup for ublk
Message-Id: <167577971177.163087.4942198134039715702.b4-ty@kernel.dk>
Date:   Tue, 07 Feb 2023 07:21:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 07 Feb 2023 15:08:36 +0800, Ziyang Zhang wrote:
> removing unnecessary NULL check, unused variable and comment fix.
> 
> Ziyang Zhang (3):
>   ublk: remove unnecessary NULL check in ublk_rq_has_data()
>   ublk: mention WRITE_ZEROES in comment of ublk_complete_rq()
>   ublk: pass NULL to blk_mq_alloc_disk() as queuedata
> 
> [...]

Applied, thanks!

[1/3] ublk: remove unnecessary NULL check in ublk_rq_has_data()
      commit: 731e208d7b4b38d2bac4b7c53403c8abbf306d01
[2/3] ublk: mention WRITE_ZEROES in comment of ublk_complete_rq()
      commit: b352389e7ba34bdb5bcf4254fa1e85319ba76352
[3/3] ublk: pass NULL to blk_mq_alloc_disk() as queuedata
      commit: 1972d038a5401781377d3ce2d901bf7763a43589

Best regards,
-- 
Jens Axboe



