Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641C6C10F14
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 02:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3235F20872
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 02:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYJYf+t8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfDQCKn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:10:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35075 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfDQCKn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 22:10:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id a71so13473657qkg.2;
        Tue, 16 Apr 2019 19:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SO80rdpZniHSnUwvSS7k2BSuBHsVW4tWrJMPiic0EyY=;
        b=kYJYf+t80OsNbG2oS3jlrah+MSNV1ikmiJi1uanr4ZoaTMS32eYV+OcNoVJCzZF267
         VbuM6I7rqhVl1ChyEJv7+KMR5DArpsZg2CEVj3ZpjNTXMm0BBwcY8bSsranHfLTnc5eu
         IWZQmLRyEge3gezuUoR2BcEnYOxsu4vS0qAz0xDinorLquOjEvssrm7iU+6ubBG3yg80
         ygPoP3h7VvQjcna2/mTgoISlelbkbf8p7oEAXRK/QTTpMNokMoSFpYf0R6Ofhyr46PMF
         Lt1op8ES6qtgWYy8Rxd1MU4u80gL+HZmXlEwyfvqu+RBPc3G1gibghiheFpVAC61iBOs
         uSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SO80rdpZniHSnUwvSS7k2BSuBHsVW4tWrJMPiic0EyY=;
        b=pMYtlw+CaVuH63ZwPc1zZxUQVkfhy9d3/bRbFXfKbWFxKyo5FZWgy4+0cgIEA0ua4k
         k+ifj/h+iYRflMBBgcteYDHINn/YmwUtqRgxNAr2Wr1H2/IW2cQLF1OcziiiR4k6Opee
         CEvrue576lXNlV99lW4FKY4Lc8DHk3f9EVkPCP4Dok2TE1mBCtTh22T8d4AQGeSg8dkj
         u/2xoZiiCa7L5czMxI75DSBRexpZMNwzujNt+ir2KEXhpn2vSTONAe31mx6OpMtd5ZGY
         17GIE3GfUOwwuFGPN/gBwtOfsZBldDYL1/Gq6eIxpkzW3gNZSk1HmIhpgL+OKH11vthM
         qTxA==
X-Gm-Message-State: APjAAAWl5a4qauXtWojWy5OPyC/bRSS+psW+YpkkloyemMn+D9iuWDv+
        V2/YzRb5PhHzMWv0JiOoFl7lzZvXoMg=
X-Google-Smtp-Source: APXvYqyMmWv245diNbENk7R2OalfxU+iXT6h9fPWXi3HQGhbJ7LaVCKBMPe3uVlAT9L7uf+VDhKayw==
X-Received: by 2002:a37:8d44:: with SMTP id p65mr63680186qkd.151.1555467041595;
        Tue, 16 Apr 2019 19:10:41 -0700 (PDT)
Received: from localhost.localdomain (179.187.200.226.dynamic.adsl.gvt.net.br. [179.187.200.226])
        by smtp.gmail.com with ESMTPSA id s55sm1497228qte.17.2019.04.16.19.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 19:10:40 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, marcos.souza.org@gmail.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com
Subject: [PATCH v3 0/3] Add documentation of some blk-mq functions
Date:   Tue, 16 Apr 2019 23:10:27 -0300
Message-Id: <20190417021030.82998-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_init_sq_queue and blk_mq_init_queue are being documented, more will be
added in further patches.

I would like to thank Chaitanya and Bart for their reviews.

Changes from v2:
* Changed the description of argument @set of blk_mq_init_sq_queue, making it
  less obvious and more informative. Now this argument has two example of
  possible flags for tag_set (suggested by Bart)
* Cover letter added (suggested by Bart)

Changes from v1:
* Change "SQ" to "only one hw_queue (SQ)" in the function signature
  documentation (suggested by Chaitanya)

Marcos Paulo de Souza (3):
  blk-mq.c: Add documention of function blk_mq_init_queue
  blk-mq.c: Rework documention of blk_mq_init_sq_queue function
  Documentation: kernel-api.rst: Add block/blk-mq.c

 Documentation/core-api/kernel-api.rst |  6 ++++++
 block/blk-mq.c                        | 27 ++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.16.4

