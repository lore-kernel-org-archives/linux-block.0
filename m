Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B885C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 02:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiCVCyX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 22:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiCVCyW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 22:54:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E7157141
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 19:52:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x2so798449plm.7
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 19:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=M6oq/tOGUFHqn9dRmxnPpjiw8BgT9b678SUijCIrhRw=;
        b=OkJaEyO8K1zXGE2XNdPzKdHo0IoLuaK7B6XXPfg7a6Yxat8dYyZpUWLgkxa7z+uHrH
         UXccoBwAXgm2DensUVsLwWrimwA5PSRyyaf85nxLVFJLDi62PL+rSk7/rj0Gq2CXuoVR
         wPEajxEOWGPd9rTTIcIZ5qetcZv6DqL4eI73vNdvblwcCilsn4eCNlfFeZi6PrWekfni
         7c5I65e2qS1//OgvAqL0jH641gjrDjirMalgcaagucJ4OBnTfy3fWlCttsfNCZChCoNw
         2LL5OFHbm39mKDy2Si2y3apSqTcoJAmwUhWhR8ZdlZvGgchGJ1+mHYqqSY0W+fRCN66N
         jfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=M6oq/tOGUFHqn9dRmxnPpjiw8BgT9b678SUijCIrhRw=;
        b=FEeoKvxTM3+elexMr1CrStGaSOtqfMS/HgfPXf0ikJn9IVffszHBfU5zDPjWq5XfVa
         DW/iEi+iYg9B2TKpDkmwQPSs6PpYY/7JxLzZ/QaWLIFuIZqa3OSOSpQYyDsy5UBLSnTx
         ob6JUOukNx9EPTA9dCnZARCuWcubPhk/o4hYtY4rOe66XFKAcOchQHXavqgY0c2BLwTw
         Knsr1lOwQAJ6bKn0zKOjtJ/iwBM+A+Zdq8GcOLmJhDuK9Bcf6ZpzgU5GAg5nZ42Hdfjl
         ZICC0pfn11gHrLS1guVDdV0AwRrDrdCmYyYmN6Dfwg/s65zN/m0ShYZrtxFNDzXJmjGQ
         235w==
X-Gm-Message-State: AOAM5329qDDArmukITZPobpiIv/rx1fhgmbEP5nPOCwdubEN8tvHcu7j
        BIpSkjUVkBvZJh1hCE0EQWIYytC1Gi53NtG2
X-Google-Smtp-Source: ABdhPJx7QOnm3FDV10SrCWeqAWV8NYy7jEoLgob0xWRzbhk5eaJHbCgD4Qp0xDxNGroQ+TukO4PzAA==
X-Received: by 2002:a17:90b:1652:b0:1c7:305f:3a32 with SMTP id il18-20020a17090b165200b001c7305f3a32mr2415585pjb.108.1647917574538;
        Mon, 21 Mar 2022 19:52:54 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090aa58100b001bcb7bad374sm759348pjq.17.2022.03.21.19.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 19:52:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, "Ewan D . Milne" <emilne@redhat.com>
In-Reply-To: <20220316012708.354668-1-ming.lei@redhat.com>
References: <20220316012708.354668-1-ming.lei@redhat.com>
Subject: Re: [PATCH] lib/sbitmap: allocate sb->map via kvzalloc_node
Message-Id: <164791757361.261186.18356313381544261892.b4-ty@kernel.dk>
Date:   Mon, 21 Mar 2022 20:52:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 16 Mar 2022 09:27:08 +0800, Ming Lei wrote:
> sbitmap has been used in scsi for replacing atomic operations on
> sdev->device_busy, so IOPS on some fast scsi storage can be improved.
> 
> However, sdev->device_busy can be changed in fast path, so we have to
> allocate the sb->map statically. sdev->device_busy has been capped to 1024,
> but some drivers may configure the default depth as < 8, then
> cause each sbitmap word to hold only one bit. Finally 1024 * 128(
> sizeof(sbitmap_word)) bytes is needed for sb->map, given it is order 5
> allocation, sometimes it may fail.
> 
> [...]

Applied, thanks!

[1/1] lib/sbitmap: allocate sb->map via kvzalloc_node
      commit: 863a66cdb4df25fd146d9851c3289072298566d5

Best regards,
-- 
Jens Axboe


