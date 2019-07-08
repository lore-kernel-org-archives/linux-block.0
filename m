Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C38C606CD
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 19:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9402B2086D
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 19:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfGHT56 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:57:58 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:46666 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfGHT56 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 15:57:58 -0400
Received: by mail-pg1-f182.google.com with SMTP id i8so8190082pgm.13
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2019 12:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pXYhJSDkO4bpcq+kPKRA5TNp87lu47K+VoZ9OkFGl1Y=;
        b=Ms1jrH4jlonr4w77Xw7ehOSt1Ob/FN6SF3/8OFT/hmuYro/4feq+RL4gl7YvXxRdlH
         NHKlnppHG+aMAQeQoW0crVocpUScDNWxmDWsbrtVwrGK5j+3aKTTk0qJAKJQSh/zCCIV
         6oPuXaH6g+izktOTysg9tFa5neNiwcjm5l9oaP9FnaM5cdMcuss4LbFfWEdgoAXa/3mG
         oKP6+c9ppPGhb9sazx9KeSosKFD8A7225RRWU0NDcpSoECnhav1bukU4ekOHTk6Rfn4M
         AmsxrxeN/JsNvCrEZ4FKxtx4Wc0DMSAnYCrW26Fi0DHZ30HlUiH9Fi59U8QDiffhaW/H
         Cszg==
X-Gm-Message-State: APjAAAU1GQMs/T0PEP8aTDMbccxMnc6FJW+wziDvshU1TqsxQ7wgWSoG
        hzQR9KVfusxGjKe4vxYsN3E=
X-Google-Smtp-Source: APXvYqztF03FYlxprPpJXpkTo/82nNfPcSUoruuukGH3PbnsODpXb8+rlnYKEex8Or4ijGvqmca85Q==
X-Received: by 2002:a17:90a:7f85:: with SMTP id m5mr27935558pjl.78.1562615878056;
        Mon, 08 Jul 2019 12:57:58 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t8sm298043pji.24.2019.07.08.12.57.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 12:57:56 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH liburing 0/4] Optimize i386 memory barriers
Date:   Mon,  8 Jul 2019 12:57:46 -0700
Message-Id: <20190708195750.223103-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The four patches in this series optimize i386 memory barriers and fix the 32-bit liburing
build. Please consider these patches for the official liburing repository.

Thanks,

Bart.

Bart Van Assche (4):
  Makefiles: Support specifying CFLAGS on the command line
  Fix the 32-bit build
  Change __x86_64 into __x86_64__
  Optimize i386 memory barriers

 examples/Makefile        |  3 ++-
 src/Makefile             |  2 +-
 src/barrier.h            | 24 ++++++++----------------
 test/Makefile            |  3 ++-
 test/io_uring_register.c | 11 ++++++-----
 test/send_recvmsg.c      |  4 ++--
 6 files changed, 21 insertions(+), 26 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

