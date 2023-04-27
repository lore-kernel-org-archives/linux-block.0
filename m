Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B0BC77B7C
	for <linux-block@archiver.kernel.org>; Thu, 27 Apr 2023 00:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbjD0A0X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 20:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbjD0A0V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 20:26:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7E740F5
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 17:26:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a6a50dd62cso10068775ad.1
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682555179; x=1685147179;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTOkRfNYIcCyobGPmwTR41HZBXplh4O+VdZT8qkDAZs=;
        b=SG/9x29S2i7UOgFAB9FBCxeDkY9UXuXY4AHfghZkPkuVh1BqDqug6ga/nRw2yuSZr1
         OWKsZtymxEJJAZVRwQPl5w//p/ZCSTV7WlIss3X6FnvHVdhZihsl4TX4GP9tbn4MVHRu
         Dop89EfFJqUvw6cq5UiqAWG+jVAUfM1UPZ8CXa0b38tIW5ieYECKsSzKm2fIDuDAdWrX
         7ejR+BN96Sgfvfe3ALjEz153NNL0t7FG4XoyuTjd4hFVsdAoiwp1o1B2NNwxv53cp+DQ
         8T/Q03QqC+N8/pFUW8XEXdVZInL1HFWP+a4r5XJF8uDw5LPlOpHmUTxn1lJ56h3+4k75
         djsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682555179; x=1685147179;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTOkRfNYIcCyobGPmwTR41HZBXplh4O+VdZT8qkDAZs=;
        b=djFk3JfiThKbL3cf6TOiye+qlMOOi0oITTXzh6Be0f6MWJZB17Ae0DJE8RW9IQW2+u
         6sCaUEyF8XnarkXJ9376mVDUEmzbO6BxTxtckEPtPOF3MrA5C+jqoB0rRAJNtgiMVF3z
         pyorPZ5rrRIdf1UGxOLMqs/zgxVztXunS5ci3/+gvEPFLUNDyKkcsrxkW2vj9K9w2SaA
         eETQFS8B2L69crk/k3nqmkyVEyLKPFvELxfoaVdPNdXOSXEPUuf13+EBD3BqjXeGIp/k
         FpYC4rwlH7lRX5ZftzFPbPyQFYFX9kIAQtIk3gCJ2ARIVG8/ZdXQXSm7ns+S0AYvarYs
         pBEg==
X-Gm-Message-State: AC+VfDx/p1Y8vmsd0DR6bYqZK9xShWMRD7xRlUoF2i57Poo78JQnLQ68
        7J2Pjdt3hZMvn33aU8M/u7uF8ObBNdijX6+QGZg=
X-Google-Smtp-Source: ACHHUZ7q1W+ObQVu0dbQ+J+W3jj+iRhsLm6KT6rUgicarGzFDj0n8iSNF9dqH7imMUY1nISc44EC5w==
X-Received: by 2002:a17:902:ea12:b0:1a9:4167:5db7 with SMTP id s18-20020a170902ea1200b001a941675db7mr8985693plg.4.1682555179437;
        Wed, 26 Apr 2023 17:26:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902a9c500b001a6f6638595sm10403862plr.92.2023.04.26.17.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 17:26:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
References: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
Subject: Re: [PATCH v3 0/3] blk-integrity: drop integrity_kobj from gendisk
Message-Id: <168255517853.49697.6615983265026536560.b4-ty@kernel.dk>
Date:   Wed, 26 Apr 2023 18:26:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 18 Mar 2023 17:36:22 +0000, Thomas Weißschuh wrote:
> The embedded member integrity_kobj member of struct gendisk violates
> the assumption of the driver core that only one struct kobject should be
> embedded into another object and then manages its lifetime.
> 
> As the integrity_kobj is only used to hold a few sysfs attributes it can
> be replaced by direct device_attributes and removed.
> 
> [...]

Applied, thanks!

[1/3] blk-integrity: use sysfs_emit
      commit: 3315e169b446249c1b61ff988d157238f4b2c5a0
[2/3] blk-integrity: convert to struct device_attribute
      commit: 76b8c319f02715e14abdbbbdd6508e83a1059bcc
[3/3] blk-integrity: register sysfs attributes on struct device
      commit: ff53cd52d9bdbf4074d2bbe9b591729997780bd3

Best regards,
-- 
Jens Axboe



