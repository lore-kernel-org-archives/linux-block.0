Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B54C433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 23:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37C761166
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 23:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhDPXx5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPXx5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 19:53:57 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4633C061574
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 16:53:31 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o5so30695522qkb.0
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 16:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=QyhvZCSvtA03X8xN6o/W0M+lSp8c9SWEUE8ZmCr9STo=;
        b=JsIEI4hnfM7XZkx0kTFWX29u6sKY++3HK8McTuBMTVIMLBa6jL+mSdtBeE+BE1z6+e
         AVHycaL0mhnCcrXLL/9YR9rVoEY8n4Ps1Ur+22FPY3X2J7jvjSjxYtE5Q6N4nfR8VCql
         y6blXYg3nrIsFQzLJzx0T3WfT2Gk9d8mmQleZ874dAgkIfBnK7VkfSdu2uhaoza8ceWv
         sjMXCEEhXTTrSsPda3lTABiS0I12Nhqpm/YJK7Mw1lYHh/Tyf4Smv/rGXd4MTNR8A4MD
         1h8yYplpqCSUNTz04c9B4bXbZ0OooekkrWyg0MxZKdDTOkAMplGpc980Bq59RCT4jZpW
         zIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=QyhvZCSvtA03X8xN6o/W0M+lSp8c9SWEUE8ZmCr9STo=;
        b=jH7iBR2AO6dvXR6q9ZQG769JEXd08ZXRqSYpq2OrsdYKhU9vHM7VG0/DugNBJ3eySw
         kgrzRvSdr/bdchu49zi/h4vZF+cPTXUd66EDEGfT5Sl9nUiZ1s6e2jRQi/JS5AWyI6y6
         q2/f5Pegikfzxjy5sNm9XyUz3hwjTWzl+zCYmFSaDhi3kiPeyh7Jq6SykQle9P1St1cN
         ZXxvkoCLblOARrDrSy66cffPqs0truYZSt3uUJI8SR00sUCbqWlQ/oEwQdzkNmask5Yz
         T7E2u02h/BqslVxco+eHWHA61IcUnNPTq3Zo1GOr2OlLYPjRCsR6rmOQ0lvKoWlR5gOz
         VGEw==
X-Gm-Message-State: AOAM530/Mk7TNEFmxssGvUps6o0pMSDKVNKjfkZk88tEl82lF97z+nNH
        AbFVeNrU6t7qSPfZgjp3s70=
X-Google-Smtp-Source: ABdhPJyxfAxWmx5hFRT5ylJQlPp9g7ESFqO4NhBYv63c6HS/QO0qUMBxMVRjxTlMTrV+x8HDbBMqNA==
X-Received: by 2002:a37:390:: with SMTP id 138mr406655qkd.136.1618617210999;
        Fri, 16 Apr 2021 16:53:30 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id 2sm5164675qko.134.2021.04.16.16.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:53:30 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/4] nvme: improve error handling and ana_state to work well with dm-multipath
Date:   Fri, 16 Apr 2021 19:53:26 -0400
Message-Id: <20210416235329.49234-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patchset reflects changes needed to make NVMe error handling and
ANA state updates work well with dm-multipath (which always sets
REQ_FAILFAST_TRANSPORT).

RHEL8 has been carrying an older ~5.9 based version of this patchset
(since RHEL8.3, August 2020).

RHEL9 is coming, would really prefer that these changes land upstream
rather than carry them within RHEL.

All review/feedback welcome.

Thanks,
Mike

v3 -> v4, less is more:
- folded REQ_FAILFAST_TRANSPORT local retry and FAILUP patches
- simplified nvme_failup_req(), removes needless blk_path_error() et al
- removed comment block in nvme_decide_disposition()

v2 -> v3:
- Added Reviewed-by tags to BLK_STS_DO_NOT_RETRY patch.
- Eliminated __nvme_end_req() and added code comment to
  nvme_failup_req() in FAILUP handling patch.

Mike Snitzer (3):
  nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
  nvme: allow local retry and proper failover for REQ_FAILFAST_TRANSPORT
  nvme: decouple basic ANA log page re-read support from native
    multipathing

 drivers/nvme/host/core.c      | 22 +++++++++++++++++++---
 drivers/nvme/host/multipath.c | 16 +++++++++++-----
 drivers/nvme/host/nvme.h      |  4 ++++
 include/linux/blk_types.h     |  8 ++++++++
 4 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.15.0

