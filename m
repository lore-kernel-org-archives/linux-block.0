Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C29C433DF
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 10:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3788520878
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 10:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="FlmdXyXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgJMKax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgJMKax (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 06:30:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1630BC0613D0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 03:30:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e17so23338279wru.12
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r5ll7PzkEWkvNwWGO7rDgdDYPXIa9Jx8wDcdZQ/cXzM=;
        b=FlmdXyXHgNGojC2p5XFp11S7Hej9pJOu6WMZfkf0rrAAyGQcKuee1u5+w1ZKlYKkF6
         7nC2lnkYRSsxNtMoEepS5Zlxz+BCIBvesCupgaMnGlxdwpc9r5bypyvBPPotT17jsqfo
         7XR6ajntCoKu8hfqSAWZ5ZDFmoiBI78sr31beblWCvjcBRlGnS8tj7IQNgm5mrK8PqKQ
         9O/jDM/VrcjWGsJog8p2Ow/ypiuk//kXpoXqf7kFLkNQjXwLoEfIXJGRZRnJ1bxEkVuv
         uCh2k2aO5BFsTzwNasAIRIpEBIPuCZUCAMHZQ4qqbHE+n3BbJUWxoXroqAGLfUaIJUFw
         5Efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r5ll7PzkEWkvNwWGO7rDgdDYPXIa9Jx8wDcdZQ/cXzM=;
        b=ZAWFT3Gg3VQhEfEOBy1L4eNPHyegDTZL3SS+l87oONzLNUzctcAekmxIJmAkAIJrFG
         wymr6l7SJy8RudrKB7k1Qj27nlF97IMW7pHWxclME9/TWBfuutqDQvHMmFUETDZsH4yp
         tmqOVXTPYpYvYoZ3naTy0kN0lg6scdwu+Ic0PCwsWsNH/DITUwADhU2BJ+Ui5Nh78dZ7
         Muw8XDuVVB9n2boELO/A2Z3GNSDcoKdWwvXeA4c/wQV6x/1Mh99nMbCzDckXYJdbt/Ua
         tcrpCpxvWP9Sv7HYWTIYrK9ieiCJliKwHD4+tsNFBiZO8VXv07UOerjYYjPbgZOG1Oo3
         OKqQ==
X-Gm-Message-State: AOAM531BPYs+idVxtrcKg/8iDvqj1rAPDbFgZ7sKbCRRgoJaFD94HVZt
        oZpSqHzw9pToz+QdtWbQlwBowYu8IThXdA==
X-Google-Smtp-Source: ABdhPJxxZ4ycGnucedwgqkaWCIZIVaHu2LdsmauksnJSWwHoRy5HRPKfKgE2ChpK7hmDaRXVzu0H2g==
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr37347675wrg.166.1602585051626;
        Tue, 13 Oct 2020 03:30:51 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4969:6200:8c9c:36cf:ff31:229e])
        by smtp.gmail.com with ESMTPSA id p4sm28458634wru.39.2020.10.13.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 03:30:51 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, bvanassche@acm.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
Subject: [PATCH for-next 0/3] misc fix and cleanup for rnbd
Date:   Tue, 13 Oct 2020 12:30:47 +0200
Message-Id: <20201013103050.33269-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please consider to include following changes to upstream. 

The first one is just a resend, Gioh sent it 2 weeks ago, it got ignored
somehow.

The second one is just a small clean up.

The third one is a small bugfix.

Regards!
Jack Wang

Gioh Kim (1):
  block/rnbd-clt: send_msg_close if any error occurs after send_msg_open

Guoqing Jiang (1):
  block/rnbd-clt: remove nr argument from send_usr_msg

Jack Wang (1):
  block/rnbd-clt: do not cap max_hw_sectors & max_segments with remote
    device

 drivers/block/rnbd/rnbd-clt.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

-- 
2.25.1

