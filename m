Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A176C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E413A208C4
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfF1UHz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:07:55 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46565 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfF1UHz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 16:07:55 -0400
Received: by mail-pl1-f180.google.com with SMTP id e5so3815896pls.13
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 13:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ll04O8po6o5v8a2qdK2rcxaAzHqyRYBeEO0jwgzChKI=;
        b=EdR/lQTXf1UkPBIl6jBz27lvfq1ZuW9pveuiRkZP2BDMhsL8T2n5FECq5NMTFpzSej
         mYtU5JU4A/8U4EoymC8TIYQAGr/uyFsywMLmQzEtWh/0+JUG3+BSTLmlDXBbvXzvDFPu
         6ghR7NJyLwRE3iZjqII1x0ZZMxRnFob1pfjM3N/nb0Ll7xg1ZhjShTz2AjCrZVa41tTL
         DoLRnIpMs3VJBF6LWEHAfDeoL/iRSOlfDVrcYssbe8INJhcd3E8pYpyHeUbEaFYMbLko
         SjEzUGvr3Rtm4JK1fV3MVxX7DVfwGA1m30UiFWHyhO1P4tTmaoQs6L7xtheDdOaUDiPu
         dnHA==
X-Gm-Message-State: APjAAAW/e6OBy2TA1Z9c7QcBYasBXJuO26Cyyb4oR/eHmeGmFBpxRlJ0
        TXpTfpw6ikpI+7OYLc6TX4s=
X-Google-Smtp-Source: APXvYqwT4I65aDwJsyQcpGGmXJOVvLNpT/n54jvd+SPDqHWimMlAUPlnSK/zS4PCzNR4FuKqJEgQrw==
X-Received: by 2002:a17:902:2ae6:: with SMTP id j93mr608328plb.130.1561752474389;
        Fri, 28 Jun 2019 13:07:54 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 65sm1186010pff.148.2019.06.28.13.07.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 13:07:53 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] Improve block layer request queue sysfs parameter documentation
Date:   Fri, 28 Jun 2019 13:07:41 -0700
Message-Id: <20190628200745.206110-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

While reviewing Documentation/block/queue-sysfs.txt I noticed one spelling
issue, that the parameters are not listed alphabetically, that the word
'segments' needs clarification and also that documentation for some
parameters is missing. These patches address all four these issues. Please
consider these patches for kernel v5.3.

Thanks,

Bart.

Bart Van Assche (4):
  block, documentation: Fix wbt_lat_usec documentation
  block, documentation: Sort queue sysfs attribute names alphabetically
  block, documentation: Explain the word 'segments'
  block, documentation: Document discard_zeroes_data, fua,
    max_discard_segments and write_zeroes_max_bytes

 Documentation/block/queue-sysfs.txt | 64 +++++++++++++++++++----------
 1 file changed, 43 insertions(+), 21 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

