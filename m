Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF9DC04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 12:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623EB20848
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 12:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/OFE6/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfEPM0c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 08:26:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33948 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfEPM0c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 08:26:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id l17so3247925otq.1;
        Thu, 16 May 2019 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=R6h4BIGVJvtptsMKNVwQQt+BusPG5TRUU4VLnQNwELQ=;
        b=D/OFE6/uow+oa/SibWUaDfInJw2bg89B22yiZUGcvmY6dG9mhQaxzemULVUtQ/Fzu9
         E2bt75/h2sKML5Kj+vIvh9WKAsIIdtKOQQ0lj6ms+l76/gzpdInak8n+t294wSfzhIzp
         9LFRdJleNwvpUBR3gO+INdCFznD5s2kcHwhBCI/vO4hFPaezyZXH5D8/PSjcb5F3SE/T
         wr19QzJFiPfDHzRcxsNkiAoJtjSmJOsG+/zWRmAiHr52jRCh3Q+l0XPDArPgu+D31G7o
         7PDeOsTspMbbz/hRqhK+bLP/ljlAFTlugw60+TLBFAiUnOQUtlKUzoNDghGjHgKqVQt5
         lO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=R6h4BIGVJvtptsMKNVwQQt+BusPG5TRUU4VLnQNwELQ=;
        b=JcZ2UCO9sLQ6tKdf+e/4g0ct+2jamG2qKY87hQdw0tNZ31xOg6ZXloFT1U7yUgnm/W
         GD4ktwKaax5Up1BcQxWsBrXj1hiBEKOYLMpjgljuZuMbhLd3AJqdUhCDRyeoVBmPq73w
         QMFI3ZQWMcZIn8bwBGQwl4OxQsQbakds1uSRpVY22K2OMTKDhkqVCuI4YlCCCoJnxwx1
         8CSYGetyoEsnWJbT6WOUktlUgRREMTHwsCP5eZEL2DFFqGaGhJVKQeqBFf9zgWeVLn/I
         LvK1kfpb1u6XVTmN4jT6Fl4ByjyL0HftpzFzwEIKXx3WzisQLsF9jOVnKLxfJGMsKBFT
         m7LA==
X-Gm-Message-State: APjAAAUv3axs4FtYXBDXXXmepikMhoiaV9jcOsTMYJ/nzYBh0d/NNOvo
        KBStYhWs/JQ1ynMJfQM7l3MjONeqQHT5WQQTOltJPU9jeoM=
X-Google-Smtp-Source: APXvYqy+A9PMPyt+5pt/NETBnH0DklAJpHcttH+h5aH5JVJ1yG/BcU9Rj8b/D8WE9hBtJosIry+ZPQu2gkbfhMcbhM4=
X-Received: by 2002:a9d:340a:: with SMTP id v10mr16046662otb.104.1558009591589;
 Thu, 16 May 2019 05:26:31 -0700 (PDT)
MIME-Version: 1.0
From:   Alibek Amaev <alibek.a@gmail.com>
Date:   Thu, 16 May 2019 15:26:20 +0300
Message-ID: <CA+TYKz1o=uOn0m3tPGqmNZtw7mGdZ7_BGX0C0RH9f3wnFDpO6Q@mail.gmail.com>
Subject: Block device naming
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

I want to address the following problem:
On the system with hot-attached new storage volume, such as FC-switch
update configuration for connected FC-HBA on servers, linux kernel
reorder block devices and change names of block devices. Becouse
scsi-id, wwn-id and other is a symbol links to block device names than
on change block device name change path to device.
This causes the server to stop working.

For example, on server present ZFS pool with attached device by scsi-id
# zpool status
  pool: pool
 state: ONLINE
  scan: scrub repaired 0 in 1h39m with 0 errors on Sun Oct  8 02:03:34 2017
config:

    NAME                                      STATE     READ WRITE CKSUM
    pool                                      ONLINE       0     0     0
      scsi-3600144f0c7a5bc61000058d3b96d001d  ONLINE       0     0     0

Before export new block device from storage to hba, scsi-id have next
path to device:
/dev/disk/by-id/scsi-3600144f0c7a5bc61000058d3b96d001d -> ../../sdd

When added new block device by FC-switch, FC-HBA kernel change block
device names:
/dev/disk/by-id/scsi-3600144f0c7a5bc61000058d3b96d001d -> ../../sdf

and ZFS can't access to device until reboot (partprobe, zpool online
-e pool scsi-3600144f0c7a5bc61000058d3b96d001d - may help or may not
help)

Is there any way to fix or change this behavior of the kernel?

It may be more reasonable to immediately assign an unique persistent
identifier of device and linking other identifiers with it?

Also I think this is not specific problem of ZFS. And can occur with other
file system modules.Moreover, I had previously encountered a similar
problem - NetAPP
storage attached to servers by FC and export multiple LUN - suddenly
decided to change the order of LUNs and Ext4 on servers is switch to
readonly mode because driver detect changes of magic number in
superblocks of partitions.

With regards, Alibek!
