Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FA3C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E048D60524
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhKDPYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 11:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhKDPYq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 11:24:46 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C8C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 08:22:07 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id n13-20020a9d710d000000b005558709b70fso8706875otj.10
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 08:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mqh3qcHEB7s0bSNEyalrsAp1G1GaXwoELsB3oqQsHUs=;
        b=tvmrWHbMYM7DhBUf2ZD/snAEi4TzhKhkg2wl8S0C6VjSCRs3wXIRzXNePRqAYIiUh5
         E3imqi1OjzmcyMEKyxzqvbrqWahX5FORnZXvBb/o0E2+INOE+fV6xut+J6hlBUnCV33k
         Xm5ZagO9abw6T2rWXOz33NWEbk/IletiuKovFj4MPZg/BDrdF7Naggt4VAAyT6Mz+gHS
         4cJF1b1s4azM60UYf2zNGroCdSwy6XYjL4/bwsJeDuRdNi10VpMDNj0NCc8OaQXg09pK
         C8MyIonvmCAfKgF99fNKQM5Y9qJJ1emkA/thAyqtlhV8X1+Z87+i0PNdGi+YbMc6pVsJ
         WUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mqh3qcHEB7s0bSNEyalrsAp1G1GaXwoELsB3oqQsHUs=;
        b=Ey87h79t0U6cJzDtWQ0idzZi0tNn2xTzhP6Vb/8H6LgT+eqFFzmBrAQL8uWtP3j2il
         k6TA6ZIw4DucXrt8vGYrBRJVCvLjqIEEmr5hMN829O7eW6Dv5wPuN9X2vmUE6sByrD85
         6JhRRnHJ0KewxFNv721+iQyejxNPESt+NCdrT8ZMQAksFy3B9apZDk/CsPzJX4+cpTlr
         z/c1LSBoyajzpUyReqvCvoXc17F4JcUJZP+ffJlxlFepe+sRTsFIn5J/dr5bgUBm4GFz
         Pl2e/0kXJte8x+4BiXT+PmAaEF+EY98n+yeJQss9qXBDk0ZWPGCemt9VoxaBbeZAOzKJ
         XArA==
X-Gm-Message-State: AOAM531PREniWh+GURRpRgMXyaga1r5E24uyJtwK3Gf3sUouqIQyrqUu
        oW8zqSA73INrrNMhsKAKkrSD5K+hCLqohA==
X-Google-Smtp-Source: ABdhPJySjOrWp8EUKdjWVaO4yhg+rjj24ecNxLILyUpBZ5/VocsxEaoUav7PS1y8bRuYepo3FMfG+Q==
X-Received: by 2002:a05:6830:14c9:: with SMTP id t9mr26173462otq.24.1636039326545;
        Thu, 04 Nov 2021 08:22:06 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k2sm1023925oiw.7.2021.11.04.08.22.05
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 08:22:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET v2 0/5] Alloc batch fixes
Date:   Thu,  4 Nov 2021 09:21:59 -0600
Message-Id: <20211104152204.57360-1-axboe@kernel.dk>
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

Since v1:

- Reshuffle series to do plug rq alloc helper before enter changes
- Protect submit_bio_checks() by queue enter reference as well

-- 
Jens Axboe


