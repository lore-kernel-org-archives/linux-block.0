Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A82C433FE
	for <linux-block@archiver.kernel.org>; Wed, 25 May 2022 22:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245084AbiEYWSH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 18:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiEYWSG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 18:18:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A568674FC
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 15:18:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z25so174407pfr.1
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uOobr8g0kT4vEBTgEu41bzRQi+qLtEZA9dzxHh988+w=;
        b=xpDGw8HD+rq0ijZElDdUGvJGAZlpyvFvuENAf0s86Ef94wJeHiSRryth3N/ygc6E7L
         5EbTlAWA2vba+4KQRF0YHYTiOMYpfCE8L2MgOsIZ+w+i7JO5KPkF9xH/YAcXmLPaP1qy
         eQEVgSNsp37uRxguZlUK9MNiE7LoerAZtQ37XcBYz13entkCPWgEagwijO6PNNqKOvJh
         5bm9YGNvIy7wXQ/y81JLv6eS0t7JYb+HoHct/wdceSe1KE2/lnipDp4lcsvCGvwe64zJ
         iGyy7lWhoVTUfy7udPnkAQXCA0uBzZF/jRknEzFU9mqEnFQnJMD/T9ZZ9i97TYy2Tgur
         DZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uOobr8g0kT4vEBTgEu41bzRQi+qLtEZA9dzxHh988+w=;
        b=CLK+Qy6/tCLrGK/7+H3uGgwu/XOXCMdmTy/s0Ivqn0urPQWdbxTmNEm7+3Z6wfu/Wn
         YCCHSsH/I4Jr3Fx+LMUoXTh11WwdTEs1RNvkOzVm9nKannYN8bRPI6tzToTjiqner8lX
         9Bp+lEGQ5uEsQ/BlHf0noIpHkUJmqQi0YEqpdg5BIj8FidwfLBUJJUWXyVicsqadTl8I
         89W3yz47XV9uMDLJ/4XSXFAHKu/oFy5BgW+qjJKpxNPk6Wf6itm5LL3kEkqLbLVI+iVC
         izdK2gEvkm3rXarZ0wG0TaFNR+2mpOxT2MpNgE7hLhZoTXlBZS2zxBxVuVHmG7/3kpXT
         ft8Q==
X-Gm-Message-State: AOAM5335KjBqiH3dhlicpi6m9rwuX9Eh9HkJYSAllPA9r6BdDloAbsUf
        Jm6V/nTe1h52T8r88Einnt1HTRY5fTFCBQ==
X-Google-Smtp-Source: ABdhPJxpuTeIO1Oa9xMYMhqTlBj9aldPGGnhN2rnoNHGuNNCWXN2iKcf2lIwWGTCgnzjOycuK/okqg==
X-Received: by 2002:a63:5565:0:b0:3fa:78b7:55a0 with SMTP id f37-20020a635565000000b003fa78b755a0mr12773469pgm.384.1653517085208;
        Wed, 25 May 2022 15:18:05 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::4:38c1])
        by smtp.gmail.com with ESMTPSA id y21-20020a056a001c9500b00518895f0dabsm9109191pfw.59.2022.05.25.15.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 15:18:04 -0700 (PDT)
Date:   Wed, 25 May 2022 15:18:02 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [ANNOUNCE] blktests under new maintainership
Message-ID: <Yo6rGhGdccNJXCe8@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, everyone,

I'm happy to announce that Shin'ichiro Kawasaki is taking over as
maintainer of blktests. I haven't been working in the storage space for
awhile, and I also haven't been very prompt to review or merge patches
lately, so this should hopefully make things easier for everyone.

The GitHub repo will be staying in the same place
(https://github.com/osandov/blktests) for now. The main difference is
that you should now Cc Shin'ichiro instead of me when submitting
patches, and he'll be the one applying them.

Thanks!
Omar Sandoval
