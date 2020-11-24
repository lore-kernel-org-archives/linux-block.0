Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F51AC56202
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 18:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6DD206D5
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 18:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCU6FL9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390838AbgKXSBy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 13:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390831AbgKXSBx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 13:01:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C97C0613D6
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 10:01:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m6so23245330wrg.7
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 10:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uyPaDEgxnhkda5ON45tyMJ+cO7d9IDL/IheDlTow2W8=;
        b=XCU6FL9epl6xZZityRT3ARR9jgKYKGYvqEvMaVBP1gNYDi37sJhY6etAxM/rJGMLR2
         x3XQv91YQ5LtYMbQWBmtz4xKXLYqGt/aZbSJbTW/B2bf9obWfptzlRE/YkQbWC96fSIE
         Mryj89ysuwBpyju6ZlqOhbAp8cAZ0esF1lfu4r+Fl7x8c9YjhNdFP8dXV55/1zSGc+L2
         iUYAvOEXwUWEEYUObub1TnpOP4dUxFyoW9pE4A/BpDHHbLh2TVeKOn8Ta3eniTXTiPe8
         CJlbhJaYjNlxf0XGGsIxcnvqy37alAZrJUKuqoO+abZlD/BivdUaPz1qNFymzhNCqzVK
         1kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uyPaDEgxnhkda5ON45tyMJ+cO7d9IDL/IheDlTow2W8=;
        b=esp7tNTI/qSapwdoIURmuEMM4yRZYbRKRmzhyQBLaAkrF9KawNY16VnnRMU7uLAFwO
         9C20mq6AjtpxGD/O3lelB/3cvuK09KTFkH0srT+QrFjQHGq5enq6oFUdnyV+2v87K/HB
         P2BtIv2Lq/+DsQWeU1TOipGx8XDSPHiXfROaJJNAEvPmg+llrdEDP/rNR9jxRiqDYgEK
         ozKcte6w5WkxIhiRpMUn3gj8MCGl5WwuzuiREQHx4z8xtlHL7Fpd0/u1ixL9M7R5b/Bc
         gsTuxE1FMbufY9GuCPmV1G7CbX42yvEQfuh1BwEeHNxMpeQnLfmqYAl/9X+H4v+k0u1A
         B25A==
X-Gm-Message-State: AOAM531kUuEzLePakt9jdE1su3P0G4pi2Ix4xHgasAHEArQ8+luL2WV7
        PiXHY7kopRxdCwYO9ppEF0I=
X-Google-Smtp-Source: ABdhPJxgBkwuOaJG6x0ucQ4wZ4GzAhei1mI5GD5a1YjSncdh+gYFMQnihNAZblDsN9pIXKy0f24XNw==
X-Received: by 2002:a05:6000:11c2:: with SMTP id i2mr6594883wrx.21.1606240912237;
        Tue, 24 Nov 2020 10:01:52 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id x4sm12246403wrv.81.2020.11.24.10.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:01:51 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 0/2] optimise bvec/bio iteration
Date:   Tue, 24 Nov 2020 17:58:11 +0000
Message-Id: <cover.1606240077.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds simpler versions of bvec_iter_advance() and bio_advance_iter()
(i.e. *_single()), that are faster but work with the restriction that
@bytes shouldn't be more than available in the current bvec segment.

That covers most of bvec/bio iteration/foreach, that are massively
inlined, and thus also nicely shrinks binary.

Others non core-block users might be updated on case by case basis
(if applicable) after the change is merged.

Pavel Begunkov (2):
  block: optimise for_each_bvec() advance
  bio: optimise bvec iteration

 block/bio.c          |  4 ++--
 include/linux/bio.h  | 17 +++++++++++++++--
 include/linux/bvec.h | 20 +++++++++++++++-----
 3 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.24.0

