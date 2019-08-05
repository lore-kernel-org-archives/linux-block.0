Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04848C433FF
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 06:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE42F2086D
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 06:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="OIeSnNO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfHEGiM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:38:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34222 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfHEGiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Aug 2019 02:38:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so36088924plt.1
        for <linux-block@vger.kernel.org>; Sun, 04 Aug 2019 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=c8VHeq19ya4NgPAfDdaqw+9aj+OFOs4WuaGxyy8ErMY=;
        b=OIeSnNO7cj0zewIOCmHFYjKvW+fx4JZINu923BjB0Hq/ubX+bwiftL7/216vqNXYB1
         Lvks5py6y2q6fGu/M7MagQ8j0/yj5L9KGlvU+Mibf3MLnOSONPXVuTIdfPrUM7z974aj
         /eVzeZ2pbGEtDq1N5I9ns4JjUvVzAwJ2GuM0Dp56b/MMHk55rwpC8sB9F58psHo3HV3f
         yiHG0YyHEFKQXZ6Lwpmr6OB9/t3xUkgMGy95WPvIGYYGwp00ReDgvYx+1hfgOoTkb4Hg
         HooskmgqWCHsPqVKWhVei8eC/pOEyaijR9Pk8/gclfLyAZkvoIiS+vIgNoO0O5tg/PcS
         4VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c8VHeq19ya4NgPAfDdaqw+9aj+OFOs4WuaGxyy8ErMY=;
        b=QqmECd9C4iuAUoxjR17Y0k7Xk+nLopvnNPS224yUc1xM6XWb36tA9dhvRWqHy+Vubz
         oem4eoeBzBENxz3OnUhmTs+Tq9wIdZ/vRlQSap3nUbAZOmB1LntfowY4WO0Bn/wZeDTM
         k8EY9gXslWgOxTl6nstG+BMMTwRt56hZFf/IHEDgMJ6yXd9Ko2R36jA+3+5RzTmujNP8
         TqQtiWGegVJmXiHWXXHO7jOo+ttaaxfix5P3SiXtf4KXPtGGqt7ykj+L8tMwkt/tqCBR
         Hns0Ve6W3wEfJDFsBFewX2/U/Goav8ZaTLBnouBhMhibfqmhOmRW74C07EIeOarlUaaT
         CvUA==
X-Gm-Message-State: APjAAAV51pKX+aSu/9FVMKjulTq+8NaMLeUzoErh4g1Q4/rF3ilO4MiN
        EN476dFhmfwznD63poZlmNcNIg==
X-Google-Smtp-Source: APXvYqzqL7SmIZkzv/9i2XMvJNac9FyB+DvqB1wnGifjnJX39xY3diG41KDD+0TGRZPyCyR1hnSZ+w==
X-Received: by 2002:a17:902:29e6:: with SMTP id h93mr83120613plb.297.1564987090946;
        Sun, 04 Aug 2019 23:38:10 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id r18sm88580639pfg.77.2019.08.04.23.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Aug 2019 23:38:10 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, fam@euphon.net, paolo.valente@linaro.org,
        duanxiongchun@bytedance.com, linux-block@vger.kernel.org,
        tj@kernel.org, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com
Subject: [PATCH v2 0/3] Implement BFQ per-device weight interface
Date:   Mon,  5 Aug 2019 14:38:04 +0800
Message-Id: <20190805063807.9494-1-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(Revision starting from v2 since v1 was used off-list)

Hi Paolo and others,

This adds to BFQ the missing per-device weight interfaces:
blkio.bfq.weight_device on legacy and io.bfq.weight on unified. The
implementation pretty closely resembles what we had in CFQ and the parsing code
is basically reused.

Tests
=====

Using two cgroups and three block devices, having weights setup as:

Cgroup          test1           test2
============================================
default         100             500
sda             500             100
sdb             default         default
sdc             200             200

cgroup v1 runs
--------------

    sda.test1.out:   READ: bw=913MiB/s
    sda.test2.out:   READ: bw=183MiB/s

    sdb.test1.out:   READ: bw=213MiB/s
    sdb.test2.out:   READ: bw=1054MiB/s

    sdc.test1.out:   READ: bw=650MiB/s
    sdc.test2.out:   READ: bw=650MiB/s

cgroup v2 runs
--------------

    sda.test1.out:   READ: bw=915MiB/s
    sda.test2.out:   READ: bw=184MiB/s

    sdb.test1.out:   READ: bw=216MiB/s
    sdb.test2.out:   READ: bw=1069MiB/s

    sdc.test1.out:   READ: bw=621MiB/s
    sdc.test2.out:   READ: bw=622MiB/s

Fam Zheng (3):
  bfq: Fix the missing barrier in __bfq_entity_update_weight_prio
  bfq: Extract bfq_group_set_weight from bfq_io_set_weight_legacy
  bfq: Add per-device weight

 block/bfq-cgroup.c  | 151 +++++++++++++++++++++++++++++++++++++++-------------
 block/bfq-iosched.h |   3 ++
 block/bfq-wf2q.c    |   2 +
 3 files changed, 119 insertions(+), 37 deletions(-)

-- 
2.11.0

