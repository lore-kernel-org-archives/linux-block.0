Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDC1C433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C136D61107
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhDPWHF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbhDPWHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 18:07:05 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E0C061574
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 15:06:40 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id h3so13436990qve.13
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=5dEer/ScS348Ta3IIzvxNKGHxZsJi4C+9EcorIShKM0=;
        b=nyFa7IvXiqDvwly2bpZMkafgCMzcO32+N4BPhbsIuWm9ruCVSzlZWLROZnwWET4CAL
         ECZomGiSlac6NPG9+dZucLHZ980vSMullN1NqF9C4HXaa/3Sg0NSIH9n/NT2tDDwuseF
         v3EIYfE5Ne86/kHWlxcHWI24lsRvLdmcdkE5ywmAW2mG2UT5KMjux3LEWiwKnSKzaprr
         wr1pmcuZXHC79eSqMZQrw9E3dRRrbkejs8004DchF8Rgbv2JtGekpl7iaXyxfVm8mAhs
         ThZ1bvahDFG3FMtOw7V+4WOZ4bDZGCVJbanhnJqGvrHBPqTmcleOEtc4Aom+LAZeonFF
         tKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=5dEer/ScS348Ta3IIzvxNKGHxZsJi4C+9EcorIShKM0=;
        b=Y+Lcf6u0sfa8wkkH+G6PuivPfmR6CuJpY0ei5S1Y6zgTyx49mdKYM7Uzbbr0Jru/lE
         tJ4+Efszpy4QqDjjM8qgqArorN2vp7ooGPiSgEwdHeaSnQ1g3/rObrY8R7SoAUWdSte0
         j5ma2QVDqOl5qlgigdL81CsU8rzHzP9bqk6Pqs/VopmJ1raEGr/jdeaZxrVc7+1jd0/a
         Pj1cogwHEcnQ+scuB1Fqbj7Y2AHPp2urtvNPiYR21ROIl4cPAASzc+kON0P1mOWftq8Z
         ulutpO1FeBN/YZozxFhAKwlq80/8JKN7muQ/dEJnKQMEKOhVIpHLLLqMEb9VKjC9/igh
         W7bA==
X-Gm-Message-State: AOAM533+kCTBAuLWIR0OiIaxFr69y63MmjEbdIsYNqAsVF+H7EIMU9OY
        mqX0yPx/KE15Tu+6l/hFHy8=
X-Google-Smtp-Source: ABdhPJwAD0B61FY0UKoYI7aZDzQ/jj3rFrz2wC2REHwr118+lfy9HJi6828NPN0YBM+uyBKehKvZAQ==
X-Received: by 2002:a0c:e286:: with SMTP id r6mr10668696qvl.26.1618610799177;
        Fri, 16 Apr 2021 15:06:39 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id c27sm5098619qko.71.2021.04.16.15.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:06:38 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/4] nvme: improve error handling and ana_state to work well with dm-multipath
Date:   Fri, 16 Apr 2021 18:06:33 -0400
Message-Id: <20210416220637.41111-1-snitzer@redhat.com>
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

v2 -> v3:
- Added Reviewed-by tags to BLK_STS_DO_NOT_RETRY patch.
- Eliminated __nvme_end_req() and added code comment to
  nvme_failup_req() in FAILUP handling patch.

Chao Leng (1):
  nvme: allow local retry for requests with REQ_FAILFAST_TRANSPORT set

Mike Snitzer (3):
  nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
  nvme: introduce FAILUP handling for REQ_FAILFAST_TRANSPORT
  nvme: decouple basic ANA log page re-read support from native
    multipathing

 drivers/nvme/host/core.c      | 42 +++++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/multipath.c | 16 +++++++++++-----
 drivers/nvme/host/nvme.h      |  4 ++++
 include/linux/blk_types.h     |  8 ++++++++
 4 files changed, 62 insertions(+), 8 deletions(-)

-- 
2.15.0

