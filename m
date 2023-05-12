Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C34C77B75
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbjELPJt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbjELPJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:09:42 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FC14C1C
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:09:40 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-76c56d0e265so30999039f.0
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683904179; x=1686496179;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdiymCeyZ0BB2LiX/YclbO314PbXaPpKTChTjluSnLU=;
        b=wk5YK9YZeFBHejkjbMxqOFGYF7udMjKb3dPLNrpxDcDmYmh0odUW7mYz6+lrtFmm+K
         KJfnvcSZjEmiYua7jaQ4DqAenHy6SF8QahlXS28Dmgspf+4Q9CoEXCXWnwEfk6E3zsEs
         avBLdmpE5Lqzq/H9dK0mQEKl8hoTVioYMMfChux3fYLJUrHITq/2paeNE3XP8uEc2m7a
         n5waa6Ymdxgp5ciE2QtYrCuoe0dZc3L+cNqAD66f0kI4cyzMzcaqC33BovPSBnaR2Cme
         aekHCSdgGqcXVZb+9Nm6q4CdIbBtZsQmzBlBrRN9E6z+RdOXgop2O/VK4eSLBFMzZoKA
         tHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683904179; x=1686496179;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdiymCeyZ0BB2LiX/YclbO314PbXaPpKTChTjluSnLU=;
        b=GE3X6XTPzJIy/B1CRzAyosE/1YHiYlUP319DjZxRiUN9tK/+eUGHoTd2nlH4sQWAB9
         Sl8O87CrkWwMSgKZH7hasq25QkHm2/3CTYJIEzYMMF6+EnBMHYRIChW2iQn/68EX+zBg
         Ei0OOM8UL02iSyLufcfAWtQu0I1VyyfqvJdbd50Pe1JFupyiOUbG5YoVZM96xGPFKecy
         q0EQYf+1IdQx5y2Zs7xeXY1Vfkxfk0/NjP9o9OJarLpYV4KTJezmDkZ96ikKiQHS6esV
         i5LgC5P9wYPXO/5imD9jsl7CK86QfeNGEG+wZCZG0FDt6vml4yRkgbCAPG5IFeiD0mff
         3V0w==
X-Gm-Message-State: AC+VfDwWheV/Xau44bDM5WiHg7V0mQGPJ6m2umy1hIFeJLyTp+OX1SWe
        W+4NrDZn2n+EXq6RqG9QWZWKn0pULmrf/a1RbB4=
X-Google-Smtp-Source: ACHHUZ6gyMzO//nGBXd5egolQDZ/FUH1crjy+LmlxtCpnqRJeSFQK38AxyoPvMDuUdUe4k8ETwoUbg==
X-Received: by 2002:a6b:c842:0:b0:76c:58d8:ff14 with SMTP id y63-20020a6bc842000000b0076c58d8ff14mr6446239iof.2.1683904179297;
        Fri, 12 May 2023 08:09:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u21-20020a6be315000000b0076c6f5b8db5sm1685542ioc.16.2023.05.12.08.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 08:09:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230505153142.1258336-1-ming.lei@redhat.com>
References: <20230505153142.1258336-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: fix command op code check
Message-Id: <168390417741.869582.12833845824015321021.b4-ty@kernel.dk>
Date:   Fri, 12 May 2023 09:09:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 05 May 2023 23:31:42 +0800, Ming Lei wrote:
> In case of CONFIG_BLKDEV_UBLK_LEGACY_OPCODES, type of cmd opcode could
> be 0 or 'u'; and type can only be 'u' if CONFIG_BLKDEV_UBLK_LEGACY_OPCODES
> isn't set.
> 
> So fix the wrong check.
> 
> 
> [...]

Applied, thanks!

[1/1] ublk: fix command op code check
      commit: e485bd9e2c419142430ae6fe3e8f64e3059aef50

Best regards,
-- 
Jens Axboe



