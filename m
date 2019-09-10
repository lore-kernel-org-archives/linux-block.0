Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EDEC49ED7
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 16:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BC72089F
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 16:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="obUbjTpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436869AbfIJQmw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:42:52 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:42042 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436804AbfIJQmv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 12:42:51 -0400
Received: by mail-io1-f44.google.com with SMTP id n197so39033574iod.9
        for <linux-block@vger.kernel.org>; Tue, 10 Sep 2019 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=FTwSjOa+ddRUmeeCyEnpLSkkgtF+L1Ayf7cslpccqXI=;
        b=obUbjTpOszV3gzECc7y/zZlYpMEAJwXK6LhfA+WomKgUaYtK7GWKg7J9uQITj71H/o
         hH2DBcrbJInry5+acZIhAFh4FDHIbxGAwOOvy+OkOlQuor8xrZS3lgXAxiHf3P9SsPaC
         HjlXYBD37VWR8+7jZ1tuoN0u3VsKT5mRfaFJM1LkH/rHtgSVXGVY6OymqofLtdsv4nPt
         QRrI+XT4wXlgv/BwicgRLq4q5fnP22sls6gHmBtHtnnPhnNo2Rh/YZyaHRdr6NgUXDKh
         7gWKG5zNIqbE/VCPjaMB2YE98Boz71dDg79XFEwjgX+4ncP+6n7JFiVeUhLJrOtea8n0
         BS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=FTwSjOa+ddRUmeeCyEnpLSkkgtF+L1Ayf7cslpccqXI=;
        b=CeTSqhecJCXCUlp5h/dJrSNZ9Zd2zNOaCleINGg9G3tAIcxqmpQiSYiNMsqHm1SDgP
         mUvSaouCA69icUOWIVtUMsld/SQ+eWFTMc12+0y8SfjEWUyhXRZYOVAcK91Eyqbio5ch
         8g4iwtR+cHFa81T/uHQj7ZbHcfzN/aELvsZXNX+WAgul8Bn1bjLtHW4Hk1pQSvE+CWq9
         9JZXV2Rfh+/RriVb3xPmSqUxLcHx2VE6JxQXp1EEFnOcUp989n48t566o5W96xiL4VEN
         J/F8zYDR3VfCxcZxJEFk1x+3vKqU9ULLU7weiBuPPMdLeK8mzD627RcdYmPxAcxLU6Z4
         VTTA==
X-Gm-Message-State: APjAAAXLhsFSP15eSV3IzqAfnDfO9wItScXy8/twN8DQACaGOPD4s+SK
        LbxozF4XeK7KpO6R+2DUM9QCEsxbaxO2PQ==
X-Google-Smtp-Source: APXvYqw2ZkQK0n6coqSme0bcJQA1TmH6EjWWzuJNlkvprDvzzvjuWE2/ySwgVMa9WUgP4gocKgW0RQ==
X-Received: by 2002:a5d:91ce:: with SMTP id k14mr22533874ior.95.1568133769096;
        Tue, 10 Sep 2019 09:42:49 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b7sm16849797iod.78.2019.09.10.09.42.47
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 09:42:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/2] io_uring: improve handling of buffered writes
Date:   Tue, 10 Sep 2019 10:42:43 -0600
Message-Id: <20190910164245.14625-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

XFS/ext4/others all need to lock the inode for buffered writes. Since
io_uring handles any IO in an async manner, this means that for higher
queue depth buffered write workloads, we have a lot of workers
hammering on the same mutex.

Running a QD=32 random write workload on my test box yields about 200K
4k random write IOPS with io_uring. Looking at system profiles, we're
spending about half the time contending on the inode mutex. Oof.

For buffered writes, we don't necessarily need a huge amount of threads
issuing that IO. If we instead rely on normal flushing to take care of
getting the parallelism we need on the device side, we can limit
ourselves to a much lower depth. This still gets us async behavior on
the submission side.

With this small series, my 200K IOPS goes to 370K IOPS for the same
workload.

This issue came out of postgres implementing io_uring support, and
reporting some of the issues they saw.

-- 
Jens Axboe


