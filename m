Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C16C433DF
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C18C20715
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgESEHq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 00:07:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45530 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgESEHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 00:07:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id r22so5791451pga.12
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 21:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hYUX6voGZfYRYydZjEdr4vAkhvU7YAqYWOqsFwcUXPs=;
        b=Vg2biy5s+zkf8r7jPZ2f3hKUWc7hKAs2TNwoYeKBXtzBKlyhhOT4rI6sJP2jl4oASi
         bLVtr07BaA4jMB8j+qZ+UfB8Y3LaRmZvUlMP9890YMpAeTZcdSZXfFy9WHJmwxwweDL7
         rkU93hncDTRLlnP6qyIgw+YpejTHHMzIUyYxRFQLcRG89knfnhv4wul31hcSWG7/uKPj
         /j+i+ZVbikdZvQAdOyc8TYcQ94ENqyg8SyRHpk7hL1dSvnaHWIk1uRosUGOsRCHSUXQd
         Bvzf3ESYW6hLf2cgUFbrzR1Rx6uYcSi7hM2JwliP5EVONsJZJ5eguhrFVuXqjTTDuUve
         YhVg==
X-Gm-Message-State: AOAM531RFXSEKEaxwohYmQhx3XH3xsZThhQoSFbnK4ziYREB/KzrPMrh
        e44lUtdmwWcMbv5+iwEyHMA=
X-Google-Smtp-Source: ABdhPJweb6GupjRgHDQmMXFSQFHP/mG4PLojRYfHVYOnPuCaxFgJs4ulnXftUAqFWLj3HiqVvFMz2A==
X-Received: by 2002:a05:6a00:804:: with SMTP id m4mr13479124pfk.89.1589861265678;
        Mon, 18 May 2020 21:07:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:dc5d:b628:d57b:164])
        by smtp.gmail.com with ESMTPSA id l3sm823479pju.38.2020.05.18.21.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 21:07:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/4] Block layer patches for kernel v5.8
Date:   Mon, 18 May 2020 21:07:33 -0700
Message-Id: <20200519040737.4531-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The patches in this series are what I came up with as the result of
analyzing Alexander Potapenko's report about reading from null_blk.
Please consider these patches for kernel v5.8.

Thanks,

Bart.

Changes compared to v2:
- In patch 4/4, use __rq_for_each_bio() (Ming).

Changes compared to v1:
- Adjusted the comments added by patch "Document the bio_vec properties" as
  requested by Christoph.
- Left out the patch "Fix zero_fill_bio()" since it is not necessary.
- Moved zero_fill_bvec() from patch "Fix zero_fill_bio()" into patch
  "null_blk: Zero-initialize read buffers in non-memory-backed mode".

Bart Van Assche (4):
  block: Fix type of first compat_put_{,u}long() argument
  bio.h: Declare the arguments of the bio iteration functions const
  block: Document the bio_vec properties
  null_blk: Zero-initialize read buffers in non-memory-backed mode

 block/ioctl.c                 |  4 ++--
 drivers/block/null_blk_main.c | 26 ++++++++++++++++++++++++++
 include/linux/bio.h           |  6 +++---
 include/linux/bvec.h          | 13 +++++++++++--
 4 files changed, 42 insertions(+), 7 deletions(-)

