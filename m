Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B19AC433B4
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E35461411
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhD1GOy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhD1GOy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 02:14:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F2CC061574
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 23:14:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w3so92888308ejc.4
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 23:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vAs0GtEOvs8uARxFT+1JD+buu8xhLde1VOWSmhnnggs=;
        b=b4rNF8HawvUaB1WVzNy7njpfatTRjPrXXd2AmyothbZHbky9Z0JCDvAIJSPOgCD9lk
         ecO4RRqq+qQzdK6jzolGXj7X9RqKXHYJ0lA34XRcxideMC04Oih0LKMHu4L2NJXpfT0J
         IxBD+xRIFMoFC59yyL/pjUCcF5ftwBTnNP0cArNIEA+9ijOeT40ip/R9dNp2RlWkeN1N
         9vsYxtkztcIp657aL7WxaAJVXz84LcCLjd0gRuBxQRrndKxM/lvinhGbBfPNzR/Hqymm
         AYTUNbQ6XCDMyU5yToNlvfzRXCzZWjp1sSgljwnWU28nOAtHQAi3gny5NW17w/p6kRzE
         S6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vAs0GtEOvs8uARxFT+1JD+buu8xhLde1VOWSmhnnggs=;
        b=P4M/157xCVvr+1fFd97aPo6UNbMzHit+16pA16ZQ8dsjUmp4PfhcZsKrhhoBBdr2vF
         m6r6nW3Wsn3tVZx9LkH9k2tSs63SjzIrS+EmusoBqc21hVPpLIso+g/kAb3LSXntwlf4
         soXsS4PMSf2Ravk3adfJEFAsbSKcka4dP+DvZyb6GhS43lcrvWUphpHIvXHW83pyFpKq
         dwP0v0WrwtFdKUPSH0MASW58V4tftNCkqsvGMX3aZtEwXCEcbOJUezLPuvJA1A1aoNDL
         SpW8ixkIHGSEdXW97By4MNXVLhjkQt1WtoszRVt8UHC3KVyjiNhRCySfFH89XtiGoqjG
         5VSA==
X-Gm-Message-State: AOAM532Uzh+pbrBr4fAuxNw+pxYYbbK/Fyz4PELACsPsyfsP/xpssYJk
        q+jV0UlkiGVC/FlWwOomOtzTpVeWDyXNnQ==
X-Google-Smtp-Source: ABdhPJwG3AYKjyCCOi8Y33eJxOp8E4pvfNFaGVTrguYv+M5eFyaesPvIzlu5RMjC7AG7O1vGQyv0SA==
X-Received: by 2002:a17:906:1fca:: with SMTP id e10mr14825359ejt.486.1619590448450;
        Tue, 27 Apr 2021 23:14:08 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5ae8b9.dynamic.kabel-deutschland.de. [95.90.232.185])
        by smtp.googlemail.com with ESMTPSA id t4sm3970322edd.6.2021.04.27.23.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 23:14:08 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 0/4] Misc update for RNBD
Date:   Wed, 28 Apr 2021 08:13:55 +0200
Message-Id: <20210428061359.206794-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some misc updates for RNBD:
* Remove unnecessary likely/unlikely macro from if-else statement
* Fix coding style issues reported by checkpatch.pl
* Add error check

Dima Stepanov (1):
  block/rnbd: Fix style issues

Gioh Kim (1):
  block/rnbd: Remove all likely and unlikely

Md Haris Iqbal (2):
  block/rnbd-clt: Change queue_depth type in rnbd_clt_session to size_t
  block/rnbd-clt: Check the return value of the function rtrs_clt_query

 drivers/block/rnbd/rnbd-clt.c | 46 ++++++++++++++++++++---------------
 drivers/block/rnbd/rnbd-clt.h |  2 +-
 drivers/block/rnbd/rnbd-srv.c |  2 +-
 3 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.25.1

