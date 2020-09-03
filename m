Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E2C10DAA
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A663D20797
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgICXyD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:54:03 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:53388 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgICXyB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 19:54:01 -0400
Received: by mail-wm1-f43.google.com with SMTP id u18so4454394wmc.3
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 16:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iuto2pxfODOk9zAl9MpiH41FtDUvxGxjWYhRICRrL4Y=;
        b=kbD8qmINCotwgjaofYwwZKMsrrjb8dn7jry/MEjfsEOS9I4Jy72oQHcclCOVgKdFDw
         j1dfcRfG+4qyxC6vmCTv/MRo7IZwZ2aS5vZdgFw2ChThz66I9CYzCDeJZ35QiNato9Nu
         ovNJVq0KfvVRuaZ3Em3EDrJ5YOKJpjb6cGGnfGlCp4FJV5XBCkc395ArM6PZ8xlq6BEG
         EIDJ+m65gbiWxojr7PYlSTC/zGvyPu1V2pOOdxs796/WGUQFnWJjmj75ahOocqt4cDMr
         IpoZh00cTeEH9NA9ghtzUqB4ICuZvpKXMneSNbzdi+lhsVoWCAj08SzOV+YV/Vxb/DHR
         ugdg==
X-Gm-Message-State: AOAM533qUnR2QRh4Q6xS+bkvYBdoyEZiFzb9PgtxfjlHopK1zNyOU6Tk
        u7/+w/hj2gA66C50aP2In5LkAh5Fe8CbCA==
X-Google-Smtp-Source: ABdhPJzP5enYrr9v2JKs6+l576WmBa5UTPasfbquiO07LvKGOUgc1eeI3A6E8sP8EvjMl1RHXfQxjw==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr4730403wme.89.1599177240135;
        Thu, 03 Sep 2020 16:54:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id u17sm7024992wmm.4.2020.09.03.16.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:53:59 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 5/7] nvme: support nvme-tcp when runinng tests
Date:   Thu,  3 Sep 2020 16:53:35 -0700
Message-Id: <20200903235337.527880-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
References: <20200903235337.527880-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

run with: nvme_trtype=tcp ./check nvme

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 3b8754669af7..8df00e7d15d0 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,10 @@ _nvme_requires() {
 	pci)
 		_have_modules nvme nvme-core
 		;;
+	tcp)
+		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
+		_have_configfs
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
-- 
2.25.1

