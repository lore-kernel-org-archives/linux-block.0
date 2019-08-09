Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FA8C433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 10:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D742086D
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 10:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbHJCV9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfHIKx6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:53:58 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:35561 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfHIKx6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Aug 2019 06:53:58 -0400
Received: by mail-ed1-f52.google.com with SMTP id w20so94525816edd.2;
        Fri, 09 Aug 2019 03:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpu48NrJ/N+aBzW1ETgFc+YkqmC+gBUoWKM1GBG3b+w=;
        b=vbHJCV9lrrvBAT3OpV0V6QBmDK3Vd3V119GyuI3MJDUKSV/zyeDGh9kENGw1FW+nkh
         Cqk7R8cquNTvKRbZql/16FB5WJV8N9qaYGmLAvxjy120qZs1HZjdcCd50LiYpdPVPCs8
         yHkc181JpojW+DR4QU/cK4LOlmSqQBjafLb10SHZ0cHe7xE8Lw+PN2MHe9ucyEslPEU6
         Um955SnBRM1o8o7oD29J1Ixi0cBKq/J936Rc1l1Ej2mExjqXI15LQDl9hv383QT0QlwB
         /S5siCNZ4ihJ/lNXx5fAqdB/zRH+eCy+uQYHh+3HCPOxfNKWa8CEk/xMbMPi4gX32Lcw
         MulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpu48NrJ/N+aBzW1ETgFc+YkqmC+gBUoWKM1GBG3b+w=;
        b=oIn6v4AtSPczcwqCfAKuB7EwNFI1KdHzpkzQyZnnErUt7ddU01SjYNTvZhPAFDDw6H
         qWfi2UKqH/i01Lg5xaOvaIj4dldardVNHKUYa+jBSrBaFVef+dDYz5m6rohxc/3mSMYP
         EFJms1tWjRS1VTnSiYP1aU+veD5mDlLZwtrwI4+dCKrsGpFDqxrip0kb0HbrWDNuBOvv
         V2R/u0q5Yo0udK6neY4Y2gegu1oWnQlGomqH9yaTg37OdLSAnNEa9ul6j9Qfi5zAwc/R
         g3FVsmxpx2Br2Ro8l9sVdnuerTLv8RVnJ5GXmGvrXTl49+DdFrhOXusK5tjqwmwNHf35
         eXzQ==
X-Gm-Message-State: APjAAAW3ql1C+lwxwRtnFwvs2pyAs3u2/FkHaYOm2ZjGubYGzZb1wkPD
        vrZA3fR/Ee7fhebfQHfxhIXjc0+Ga4U=
X-Google-Smtp-Source: APXvYqzucxC/PRWe4rQR/rciSlEwsx/vW7MrGUR7YZTsJ0MMO4vpD3H/mYbk2tcSMelo4Y43H/JvgQ==
X-Received: by 2002:a50:9fca:: with SMTP id c68mr9705050edf.246.1565348036428;
        Fri, 09 Aug 2019 03:53:56 -0700 (PDT)
Received: from continental.suse.de ([177.96.42.43])
        by smtp.gmail.com with ESMTPSA id x55sm22289167edm.11.2019.08.09.03.53.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 03:53:55 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCHv2  0/4] blk_execute_rq{_nowait} cleanup part1
Date:   Fri,  9 Aug 2019 07:54:29 -0300
Message-Id: <20190809105433.8946-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After checking the request_queue argument of funtion blk_execute_rq_nowait, I
now added three more patches, one to remove the same argument from
blk_execute_rq and other two to change the at_head argument from
blk_exeute_rq_{nowait} from int to bool.

Original patch can be checked here[1].

After this patch gets merged, my plan is to analyse the usage the gendisk
argument, is being set as NULL but the majority of callers.

[1]: https://lkml.org/lkml/2019/8/6/31

Marcos Paulo de Souza (4):
  block: Remove request_queue argument from blk_execute_rq_nowait
  fs/block/drivers: Remove request_queue argument from blk_execute_rq
  block: Change at_head argument of blk_execute_rq_nowait to bool
  block: Change at_head argument of blk_execute_rq to bool

 block/blk-exec.c                   | 12 ++++--------
 block/bsg.c                        |  2 +-
 block/scsi_ioctl.c                 | 10 +++++-----
 drivers/block/mtip32xx/mtip32xx.c  |  2 +-
 drivers/block/paride/pd.c          |  2 +-
 drivers/block/pktcdvd.c            |  2 +-
 drivers/block/sx8.c                |  4 ++--
 drivers/block/virtio_blk.c         |  2 +-
 drivers/cdrom/cdrom.c              |  2 +-
 drivers/ide/ide-atapi.c            |  2 +-
 drivers/ide/ide-cd.c               |  2 +-
 drivers/ide/ide-cd_ioctl.c         |  2 +-
 drivers/ide/ide-devsets.c          |  2 +-
 drivers/ide/ide-disk.c             |  2 +-
 drivers/ide/ide-ioctls.c           |  4 ++--
 drivers/ide/ide-park.c             |  2 +-
 drivers/ide/ide-pm.c               |  4 ++--
 drivers/ide/ide-tape.c             |  2 +-
 drivers/ide/ide-taskfile.c         |  2 +-
 drivers/mmc/core/block.c           | 10 +++++-----
 drivers/nvme/host/core.c           | 18 +++++++++---------
 drivers/nvme/host/lightnvm.c       |  6 +++---
 drivers/nvme/host/nvme.h           |  2 +-
 drivers/nvme/host/pci.c            |  7 +++----
 drivers/scsi/scsi_error.c          |  2 +-
 drivers/scsi/scsi_lib.c            |  2 +-
 drivers/scsi/sg.c                  |  3 +--
 drivers/scsi/st.c                  |  2 +-
 drivers/target/target_core_pscsi.c |  5 ++---
 fs/nfsd/blocklayout.c              |  2 +-
 include/linux/blkdev.h             |  7 +++----
 31 files changed, 60 insertions(+), 68 deletions(-)

--
2.22.0

