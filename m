Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B9BC56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5033C2158C
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="QrayGlfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbgKZKra (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388340AbgKZKr1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 05:47:27 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32748C0613D4
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:26 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k1so1732851eds.13
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axrojLEk2qy7b62wcr26iDD8DxsptSwG15Wu46KcDis=;
        b=QrayGlfp/k8UAueytVgEeNyFJapMQw5GCF2poYOpSAaDin2nbqMEOZYSem4DuNlQVz
         okElyGXaVlIt3OKzFsExlpvPcmDdRBXlVOo5IDlPMfupgzcrrlJHOb9kOUhtCiwHQToW
         m22eJt5RCofPPaU03Zxyb92lhwB2xyCS83ZXMFmOIW/MV9RWQmlh0J66x4JIAR8yzxDs
         giqgEf49KpvyI8kvIzHbpR/yRqs1ICZEmgnZK7GSvhxRVst7rgEYW9nJLyoDUOJsyGM6
         h+aU1EO5kA5iuS8PzpD6XpOFZZgAsnXPcfWayC21ItgsWWGAwIj9CrSXRgHWvkLHmbV3
         4n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axrojLEk2qy7b62wcr26iDD8DxsptSwG15Wu46KcDis=;
        b=MpgGOdYmKi+lWQWDx4xmq07GDOj/VNS+88Jl9P8yXe+5Md1tnroZBqIL7tZQsOyPTh
         xca+7exztX2YYNWRyxONJXON0u/aJpZuWho2PhXiL80119rGYOvwkqgdbA9ALUOru3qF
         heaIlsxIDxT3Szl2amx2PYbbHzQC4a5dlFhT1t1drfY219KthrzHklyvtllRfjekbBLj
         Pna3dlWHWC09vawAZFpQpBTxQuUhoD+YjDE/or+vSP4cxhPKQ31aO/Lu7/EotGiN6209
         XZrNC7YfClNUEAgexf0+IMQJ7p7p/lDA+2bw6csVgoWEFJv7K3GHziLENLUNjx2FokAe
         IZdw==
X-Gm-Message-State: AOAM530cOzyhFX0io0uthn7GyIzNS/1CgJ1LvtbHnyFQTMLOgxYv3Tof
        hwIomyJVRTW8KaMxnza3QlkRd633jTXNeg==
X-Google-Smtp-Source: ABdhPJwYL+9rgL34rD3hyceksmk+YiifGKo7PkOVMREjN9kycqoAi2pOhWJk4kjsDlD+n7bx8dIWow==
X-Received: by 2002:a05:6402:22e3:: with SMTP id dn3mr85059edb.136.1606387644808;
        Thu, 26 Nov 2020 02:47:24 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4961:8400:6960:35a2:747a:e0ad])
        by smtp.gmail.com with ESMTPSA id f19sm2910053edm.70.2020.11.26.02.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:47:24 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com
Subject: [PATCH for-next 0/8] update for rnbd
Date:   Thu, 26 Nov 2020 11:47:15 +0100
Message-Id: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please consider to include following changes to next merge window.

Bugfix:
- fix memleak when kobject_init_and_add fails.

features:
- rnbd-clt to support mapping two devices with same name from
different servers, and documentation
- rnbd-srv: force_close devices from one client and documentation.

misc:
- rnbd-clt: make path parameter optional
- rnbd-clt: dynamically alloc buffer to reduce memory footprint.

Thanks!
Jack Wang.

Gioh Kim (2):
  Documentation/ABI/rnbd-clt: fix typo in sysfs-class-rnbd-client
  Documentation/ABI/rnbd-clt: session name is appended to the device
    path

Guoqing Jiang (2):
  block/rnbd-clt: support mapping two devices with the same name from
    different servers
  block/rnbd: call kobject_put in the failure path

Jack Wang (1):
  Documentation/ABI/rnbd-srv: add document for force_close

Lutz Pogrell (1):
  block/rnbd-srv: close a mapped device from server side.

Md Haris Iqbal (2):
  block/rnbd-clt: Make path parameter optional for map_device
  block/rnbd-clt: Dynamically alloc buffer for pathname &
    blk_symlink_name

 .../ABI/testing/sysfs-class-rnbd-client       |  8 +--
 .../ABI/testing/sysfs-class-rnbd-server       |  8 +++
 drivers/block/rnbd/rnbd-clt-sysfs.c           | 21 ++++--
 drivers/block/rnbd/rnbd-clt.c                 | 33 +++++++---
 drivers/block/rnbd/rnbd-clt.h                 |  4 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c           | 66 +++++++++++++++----
 drivers/block/rnbd/rnbd-srv.c                 | 19 +++++-
 drivers/block/rnbd/rnbd-srv.h                 |  4 +-
 8 files changed, 129 insertions(+), 34 deletions(-)

-- 
2.25.1

