Return-Path: <SRS0=nSht=BN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4403C433E5
	for <linux-block@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C482075A
	for <linux-block@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgHCGs5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:48:57 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:43579 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHCGs5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Aug 2020 02:48:57 -0400
Received: by mail-wr1-f42.google.com with SMTP id a15so33066909wrh.10
        for <linux-block@vger.kernel.org>; Sun, 02 Aug 2020 23:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6rPl/XQAx312kYBDl1D3OvoqQvb50hFc5fzpRw9mLU=;
        b=HXgZjKzfQI9+ZjKjqMFzSpHG2VxeBAUk2+mr++b788r+bb10eObBkgQyAOFB/WR6PF
         jKymFYzCE6nex3OmTfkV9XKb6Tg9s7kduI+yZCpH/mVcb/1vZbNqUMp5V0WsvzUHBjE/
         6Al14GtyDkYJdQKkG0m3ThLcDu5/gT7Deh474aHdi1IHJg1MxXXNsPn9b/EqImlVSG8N
         tCdHXqmxROpvklArbck23YNpa7obK26Fc72vfEXoDgTMF3gF8f7nasB8bVG+59kF2E5S
         TN/5xWcgVOsLaH8SsggROZaVtOzy1bvYlWSeAtsXN9QudqwfmEKIRaD4Opbzvn1iAO3I
         RewQ==
X-Gm-Message-State: AOAM532BEVvyRibe0hqqDCDyZCmO1I+AWOq85vVdjWBG67vzUgpvvlOw
        OBWTpAVgc/uIGCZuu+EVsl4=
X-Google-Smtp-Source: ABdhPJwhvMVB5aSMCJUgeujA4jYf9i+HuzyArtUjN3y4od2abhibpchkQsVNaR+XZ7OVLgV+O/ybog==
X-Received: by 2002:adf:e647:: with SMTP id b7mr14730428wrn.220.1596437336048;
        Sun, 02 Aug 2020 23:48:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
        by smtp.gmail.com with ESMTPSA id z6sm23740647wrs.36.2020.08.02.23.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 23:48:55 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH rfc 5/6] nvme: support nvme-tcp when runinng tests
Date:   Sun,  2 Aug 2020 23:48:34 -0700
Message-Id: <20200803064835.67927-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803064835.67927-1-sagi@grimberg.me>
References: <20200803064835.67927-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

run with: nvme_trtype=tcp ./check test/nvme

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index a2cb0c0add93..69ab7d2f3964 100644
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

