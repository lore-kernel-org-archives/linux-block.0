Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5688CC636C8
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317A0613D8
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhGOU0j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:26:39 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:38744 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGOU0j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:26:39 -0400
Received: by mail-pl1-f169.google.com with SMTP id u3so4026661plf.5;
        Thu, 15 Jul 2021 13:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixur1kT6q2L39lVn6OXUbS7dWhX7OKvKjb1djFVXLmc=;
        b=rsqdmI7Y2OoYqmxcLgbs1K11qAkf9BxE8/mpb65/QkE10buXZTn//bUTHfcbf2Idf9
         3NkiV5aalCOIXFHrEweQew991BNOlJR6eS4hhZ/658CaS7bf5p9LLB8TtIF8NpJlRGD3
         zGjJbcVPsBfBcc7pDH6OGtHEzi5g45NJ1pvhhxtNGcDhOD0wI/+fFgZIGXP4085KUHRz
         PZq7AaJrVrzF23H8ePiJwla83A0HQLX4CVNaGX0cDRYhJmZLg2oJ/akRG0LXXhUvudf/
         qxBPFPD78iw+zJ/WR+hr/ZypfBKNKewSH/qD1E3QWfJabHULQieHzesZREtL6u/JbNWV
         yvKA==
X-Gm-Message-State: AOAM532J/9EC3CTDjaITOGFWlwZFij64lfnB71ogCmctnn8fhdTyOM5d
        jcrJceE63aW7KBBOcbUJqnE=
X-Google-Smtp-Source: ABdhPJyg73vFIMetSBkcyM1cDMEWkfv/DLcDLDknB2DXnCtqkI7Tc+ojychHcFd5eOqao23TcWph9A==
X-Received: by 2002:a17:90a:8c8f:: with SMTP id b15mr5819724pjo.201.1626380625125;
        Thu, 15 Jul 2021 13:23:45 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id mu9sm8471367pjb.26.2021.07.15.13.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:23:44 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 0/6] block: enhance use of GENHD_FL_UP
Date:   Thu, 15 Jul 2021 13:23:35 -0700
Message-Id: <20210715202341.2016612-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the second group of patches which I'd like some review on as
part of the *add_disk*() error handling conversion. While converting
drivers to add error handling, I noticed some were using the flag
GENHD_FL_UP to see if a block device is ready, or for bringing a
device down, so to call del_gendisk() safely. This first group of
patches just address the few areas where the flag is used directly.

Direct use of the flag GENHD_FL_UP is useful but incorrect as we can
add the flag in a gendisk left half built. Instead, add a flag to
actually represent the desired goal.

The next group will deal with the use of the flag for del_gendisk().

Luis Chamberlain (6):
  genhd: update docs for GENHD_FL_UP
  block: add flag for add_disk() completion notation
  md: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED on is_mddev_broken()
  mmc/core/block: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
  nvme: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
  fs/block_dev: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED

 block/genhd.c                 |  8 ++++++++
 drivers/md/md.h               |  2 +-
 drivers/mmc/core/block.c      |  2 +-
 drivers/nvme/host/core.c      |  4 ++--
 drivers/nvme/host/multipath.c |  2 +-
 fs/block_dev.c                |  5 +++--
 include/linux/genhd.h         | 13 +++++++++++--
 7 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.27.0

