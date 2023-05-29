Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35305C77B7E
	for <linux-block@archiver.kernel.org>; Mon, 29 May 2023 14:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjE2Ol0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 May 2023 10:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjE2OlV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 May 2023 10:41:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE3A0
        for <linux-block@vger.kernel.org>; Mon, 29 May 2023 07:41:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d61fff78aso809393b3a.1
        for <linux-block@vger.kernel.org>; Mon, 29 May 2023 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685371278; x=1687963278;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OG76HNB7npnw/rHN1WMaWhQZtlraiTnBwKpKSz5JGBs=;
        b=hb59JQN3zEZE3VQe0Uh+tAYY8N1ae8m2mw6ExQ2Z+IX03G27U1B//O2lDN2DIizr8V
         9VZyXcb0YFNJb45nLg+9xvYlOnRwDVWo5oxqGD/96VPiJNNbaeUNhP1bbU2lhBZSiOhE
         6Tbw1x+mKHTigGZZEhfw5fqCQCXEyEeiPoxbdNKQu22nuRgyn8wYLaw1JLfC+juhovs6
         QpjmXKqDoO3YuLlZsXqT7BdE6QF6THp5fPi7Ec7jkc2v9WwDfidKFrcqt1xb6RcnMXJL
         xrJmkwPtEXVPo7pmwAUjrrQzXoX7S5IfjJS8hDaaNQra7ifH2Y7CGJmWKYw2ObhIkxDt
         GKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685371278; x=1687963278;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OG76HNB7npnw/rHN1WMaWhQZtlraiTnBwKpKSz5JGBs=;
        b=S9vX1vLk5DtjMzKlxkIKRUhr2tRUv1jTTlN9t7iYEqIn+Ds3dgCOZqNNeltr8ohr7P
         m2M+QjkZ3k8SG0JeYgHiMCkFgRFz5kLHrvohVgie0CpuFLPUe4YqwUDOeQf165feI2RZ
         sE8wS3i3wRK+QolBbIauY68lLjAwVLk309nmYQpvG5AAC6QDib7T/AKtA4ym0IsprL7I
         po3alsMC3OhE/4DV4mc2Yri1i21ObH4cV76UD2Gi9DosqDNS+6SM1tS11XcnIYn7z95U
         yAK50ItqSTbgQz74/jswNE7XtrL6wrgtxA17V35OUrt3oMcHNJZxSVNWGkZlzFSx5Lq/
         x2YQ==
X-Gm-Message-State: AC+VfDz8OMCytB5KbQ/5jckTd/ZVMVU0ZZzcdZuZ6mL/hmtdiqzVtyhi
        92vEpw6hPjDn7Gzo/Kk3TcLVwg==
X-Google-Smtp-Source: ACHHUZ7De38RS/n38mOB9v2BcBuas/NGuFjcBe3VijwLzSlJZU4yEcJ9OWVl92Dq5aoox/gX3DfeRQ==
X-Received: by 2002:a05:6a20:8e19:b0:10c:8939:fc48 with SMTP id y25-20020a056a208e1900b0010c8939fc48mr11916581pzj.3.1685371278555;
        Mon, 29 May 2023 07:41:18 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902654900b001a64011899asm8443851pln.25.2023.05.29.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 07:41:17 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc:     Brian Bunker <brian@purestorage.com>
In-Reply-To: <20230529073237.1339862-1-dlemoal@kernel.org>
References: <20230529073237.1339862-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2] block: fix revalidate performance regression
Message-Id: <168537127713.974829.9443681036221072157.b4-ty@kernel.dk>
Date:   Mon, 29 May 2023 08:41:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 29 May 2023 16:32:37 +0900, Damien Le Moal wrote:
> The scsi driver function sd_read_block_characteristics() always calls
> disk_set_zoned() to a disk zoned model correctly, in case the device
> model changed. This is done even for regular disks to set the zoned
> model to BLK_ZONED_NONE and free any zone related resources if the drive
> previously was zoned.
> 
> This behavior significantly impact the time it takes to revalidate disks
> on a large system as the call to disk_clear_zone_settings() done from
> disk_set_zoned() for the BLK_ZONED_NONE case results in the device
> request queued to be frozen, even if there are no zone resources to
> free.
> 
> [...]

Applied, thanks!

[1/1] block: fix revalidate performance regression
      commit: 47fe1c3064c6bc1bfa3c032ff78e603e5dd6e5bc

Best regards,
-- 
Jens Axboe



