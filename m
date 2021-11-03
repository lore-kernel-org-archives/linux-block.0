Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F93C433EF
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D6C60F5A
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhKCSfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhKCSfB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 14:35:01 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31152C061714
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 11:32:25 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id s19-20020a056830125300b0055ad9673606so3513904otp.0
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dFqgP2FbMTzHHfLYasVDIweQDXQ1G2gV5azxUhJaS9s=;
        b=pSq8Z0LZOrnQ/+9+CqdnjeAYVHJOEF58Dt0h/xpG6AshjDbF20f+IMPj9dnQ+iGle/
         z5JyIY5WH3bZXIRwQDybBo+Dbag8R7qcrJqZWrCSfxIWH4EOVpKyQ3NYHbGckFeLWTBH
         ZsrHChVNsXMNdN0TtFQa/oOtWvEfxBFl4wrcCcEX3vdDWFSkXhcqoY/ZYG3oDe++RE8q
         NaAMd2Oe9ZUEUqmrB1cNWk0vcT/TGjKsBRvMsUUQTDtomU+dpGGc1IuJs7eWkLS4nviO
         63yVR/gHDvWjeobXie0HvKhfzH/J93M0jEFAke+2y2LYnwGeH/S7RX+apKQxs5slnO+h
         yKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dFqgP2FbMTzHHfLYasVDIweQDXQ1G2gV5azxUhJaS9s=;
        b=p/3CCirZEBapqfhAwJQpYyRmWsszLNdV70EjE0gv3OgTosjSWZR4jQiUJkJoyJjR8c
         v0sbMaQjMdPZ24ihVKd4p6U8ofkoc4pg6u8B0H5c6t5nO/9PeiciaCwgebH4lVlBUfIc
         eBiiu5Kvid6wiK6MXRycvMLwRKiSicmCcXW0IZu2t0zBbueZV4imJh2FbMJ8lURN9OhN
         hrEkQHg/dAsI3HaoN6T+2lAdXie7MUnf5gNgslqiKJbpiMGleWwzRPdxcTA6DMhNNKlK
         i5WF1x1Em7bACv3tNOS7Jf8mH9BuHoKpLuE0oUkq1djK8jyBFBYFC2GBMqnWYYDGoz15
         bWdw==
X-Gm-Message-State: AOAM533HRWT0rrDBRgYI8WS7hQlD7Hhi/fqC+AeTrG8dAzFLf1Ah5c4t
        VwfvrR8eHpNdjIVoVn1gqXFVHJ9UAfSLIA==
X-Google-Smtp-Source: ABdhPJw+dvU28urhN6KlabUQQL9dN55O3Q97LPHWSglRNyZtA/bYDB8nyztqy01nKxT/XITA4D0RAA==
X-Received: by 2002:a9d:461c:: with SMTP id y28mr30212898ote.319.1635964344241;
        Wed, 03 Nov 2021 11:32:24 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i20sm766056otp.18.2021.11.03.11.32.23
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:32:23 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/4] Alloc batch fixes
Date:   Wed,  3 Nov 2021 12:32:18 -0600
Message-Id: <20211103183222.180268-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

A few fixes related to the batched allocations:

- Have the requests hold a queue reference, flush them on schedule
  unplug as well.

- Make sure the queue matches, could be a mismatch if we're driving
  multiple devices.

-- 
Jens Axboe


