Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49870C43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 19:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE41C20828
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 19:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="NqwNQcGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfIETEs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:04:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38783 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfIETEs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Sep 2019 15:04:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id c12so2939743lfh.5
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2019 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0X0neFSzhuU4nKeVW55wrsCexXnGfAFzrsvBOwk+6g4=;
        b=NqwNQcGzZieDYorRRnirEowNPE133HeDTZIG9gf9ZavEpMcLuYSz7K4ovB5kB7uh2Y
         VFHUgW1FTd1kz8C7gTTzkGxtgGlg9l7Cgj/pKas0u9hdLA+8f07ueuoeo5ZMx9yb1ypj
         4IN0U/62BFZksxsJ29+ap1J2pbQlRCS8AlMdwMhW2siDx36Jmzo8DOLcrh/564iivp1c
         psmi+UmHDqwYBCAObtSq5zw1PhoJTIMsRNK2nwqsyMKw6kf70ADB/+Bgh+OJWTQrI7fa
         v2LFuf3XoNWrJN157dT7hFtm+LJ2a1WDkmTYTQfOdf+M5A+QtH0wE3GSiedf6I2MhfrB
         zJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0X0neFSzhuU4nKeVW55wrsCexXnGfAFzrsvBOwk+6g4=;
        b=NlluhDz31W+YIgV7Jhu6jcOed6HDRsM658g/NR85ibX5knNKkIH+iv333SM8UiODp3
         /4sGAHlv4TN+YmDKMTgXHJAvO30Gm5fH92VPkYVTFGH5mFBlxP3epi+SOsSt6CeG8+TZ
         29mdGHb0NQhc/zMxJfdrdQXQQDM5RGzUkT3ngRDmFRM8j5rIlXze0BqkhEJgwisppelk
         IHUis9ufVLDFPT0rhBUtkNreIiAI1DVWuzekPHCHlQzMu13kcFCSsMhGWQNyJxUQ48Zz
         DT7mIcW+gYLSdCENyTJnTM94ZCbbk+TN7cJuB0VWYQ5TLb5fhg7iOkygq1+S2TjcL00Z
         MeIg==
X-Gm-Message-State: APjAAAU1WRpRVOdFfXVNJF8O8eXnn7NFzBpa1tzqmGXfhpVx9j/18X4R
        O311BbWh8KUnhjADQBPRoPzi3A==
X-Google-Smtp-Source: APXvYqz6hpVqjB/kh1DpDc9oocq29hm053qCI8Ia4Ais3yvuwuGtk53gJroo21JJkcfrN8Xuzt0L0A==
X-Received: by 2002:ac2:4835:: with SMTP id 21mr3383015lft.121.1567710286087;
        Thu, 05 Sep 2019 12:04:46 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id 6sm599037ljr.63.2019.09.05.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 12:04:45 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 0/2] lightnvm updates for 5.4
Date:   Thu,  5 Sep 2019 21:04:31 +0200
Message-Id: <20190905190433.8247-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Two small patches for the 5.4 window. Can you please pick them up?

Thank you,
Matias

Minwoo Im (2):
  lightnvm: introduce pr_fmt for the prefix nvm
  lightnvm: print error when target is not found

 drivers/lightnvm/core.c | 54 ++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

-- 
2.19.1

