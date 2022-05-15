Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970BBC4332F
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 20:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiEOU6n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 16:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiEOU6l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 16:58:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C3C2C108
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j24so2830746wrb.1
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzWYnzR5DitOZzkYTOMPHOcR1Svm9co17qXIK6ZPIYY=;
        b=Pj0O85d51ofD/JrTYdYR+FtivnWPY5vizMBtZvzLGUFErgT/wbh150YCfQ7aDzLVZb
         FtddbPrApipJxn4PWLsH35oAI3OPcD6ibKKH3aOVmOiPx0gr0EY19qS4nQ7co/nVxr5e
         BNGkjJdI0JMlm2beZ0UmCTH5mw26PDscQ/fwzWZi3VT6Ry5X56KiTVcz4ElUEC+RZHn/
         +EZRAfkS45xiBVY/FBVICii7jkprEl/gUtAn0HNL+WVhioeb/6rjhcEQBDo4Q34R+Vwa
         RkSpi8kufkEfVTfM/BlXfrmqru2xQiXTAwRMXfbtRGZupoPfUeYaMJdCNPsMMzF7JmAl
         zUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzWYnzR5DitOZzkYTOMPHOcR1Svm9co17qXIK6ZPIYY=;
        b=yexVWELPZ0xEZwcKigkxWcdFWbdVRlrGvw/Xtz17L0faSM32q0iiACBW+Pg0nlJhtS
         L8M4fhRTTZB2h6/oXzV8lZ82YNkqcKqkqVmmJT+1+azJoabS2h6PVpIXmQ8S75imhXhf
         Pp8h1IiQ6Z7LegrSI4ke1J8jleOChpoHdklWw1Chrs2cVAkcocKD7f4L5pfSIhtMpMtE
         Pgs0qmmUz7UCLycSfhcIOtkjspSIcgp6JdUitYX6JaYtfkdcbFfjpA1o2BHsekHXu4ps
         9aPsKJKkX9VmVhJcWiE0QrDb/aKcNcur6fm4TRP916q6+yTx/xaaTQryDHFVaVEd3P7v
         +Xlw==
X-Gm-Message-State: AOAM5324BsYprz6IjcgLfowQ4tQw/yIU5y5SEhh1ZmI54oyRCeQANknX
        9YPiJgGJutv9Jh5fQoRvXoABfA==
X-Google-Smtp-Source: ABdhPJwltSNMKlGjZXqMMKfW4y9VhnARvk4nv0X6RooTgy1XA7ffJDSkpnedUugk66FVicx+jbZHrw==
X-Received: by 2002:a5d:4e0d:0:b0:20d:88e:c8b1 with SMTP id p13-20020a5d4e0d000000b0020d088ec8b1mr1698802wrt.18.1652648318252;
        Sun, 15 May 2022 13:58:38 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id r17-20020adfbb11000000b0020c5253d920sm8922074wrg.108.2022.05.15.13.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:58:37 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/5] block: remove last remaining traces of IDE documentation
Date:   Sun, 15 May 2022 21:58:32 +0100
Message-Id: <20220515205833.944139-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220515205833.944139-4-phil@philpotter.co.uk>
References: <20220515205833.944139-1-phil@philpotter.co.uk>
 <20220515205833.944139-2-phil@philpotter.co.uk>
 <20220515205833.944139-3-phil@philpotter.co.uk>
 <20220515205833.944139-4-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

The last traces of the IDE driver went away in commit b7fb14d3ac63
("ide: remove the legacy ide driver") but it left behind some traces
of old documentation.

As luck would have it Randy and I would submit similar changes within
a week of each other to address this.  As Randy's commit is in the doc
tree already - this delta is just the stuff my removal contained that
was not in Randy's IDE doc removal.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Link: https://lore.kernel.org/all/20220427165917.GE12977@windriver.com
[phil@philpotter.co.uk: removed diffs already added by others]
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 Documentation/filesystems/proc.rst | 92 +++---------------------------
 drivers/block/pktcdvd.c            |  2 +-
 2 files changed, 8 insertions(+), 86 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index cfec3cab0f9a..1bc91fb8c321 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1225,85 +1225,7 @@ Provides counts of softirq handlers serviced since boot time, for each CPU.
     HRTIMER:         0          0          0          0
 	RCU:      1678       1769       2178       2250
 
-
-1.3 IDE devices in /proc/ide
-----------------------------
-
-The subdirectory /proc/ide contains information about all IDE devices of which
-the kernel  is  aware.  There is one subdirectory for each IDE controller, the
-file drivers  and a link for each IDE device, pointing to the device directory
-in the controller specific subtree.
-
-The file 'drivers' contains general information about the drivers used for the
-IDE devices::
-
-  > cat /proc/ide/drivers
-  ide-cdrom version 4.53
-  ide-disk version 1.08
-
-More detailed  information  can  be  found  in  the  controller  specific
-subdirectories. These  are  named  ide0,  ide1  and  so  on.  Each  of  these
-directories contains the files shown in table 1-6.
-
-
-.. table:: Table 1-6: IDE controller info in  /proc/ide/ide?
-
- ======= =======================================
- File    Content
- ======= =======================================
- channel IDE channel (0 or 1)
- config  Configuration (only for PCI/IDE bridge)
- mate    Mate name
- model   Type/Chipset of IDE controller
- ======= =======================================
-
-Each device  connected  to  a  controller  has  a separate subdirectory in the
-controllers directory.  The  files  listed in table 1-7 are contained in these
-directories.
-
-
-.. table:: Table 1-7: IDE device information
-
- ================ ==========================================
- File             Content
- ================ ==========================================
- cache            The cache
- capacity         Capacity of the medium (in 512Byte blocks)
- driver           driver and version
- geometry         physical and logical geometry
- identify         device identify block
- media            media type
- model            device identifier
- settings         device setup
- smart_thresholds IDE disk management thresholds
- smart_values     IDE disk management values
- ================ ==========================================
-
-The most  interesting  file is ``settings``. This file contains a nice
-overview of the drive parameters::
-
-  # cat /proc/ide/ide0/hda/settings
-  name                    value           min             max             mode
-  ----                    -----           ---             ---             ----
-  bios_cyl                526             0               65535           rw
-  bios_head               255             0               255             rw
-  bios_sect               63              0               63              rw
-  breada_readahead        4               0               127             rw
-  bswap                   0               0               1               r
-  file_readahead          72              0               2097151         rw
-  io_32bit                0               0               3               rw
-  keepsettings            0               0               1               rw
-  max_kb_per_request      122             1               127             rw
-  multcount               0               0               8               rw
-  nice1                   1               0               1               rw
-  nowerr                  0               0               1               rw
-  pio_mode                write-only      0               255             w
-  slow                    0               0               1               rw
-  unmaskirq               0               0               1               rw
-  using_dma               0               0               1               rw
-
-
-1.4 Networking info in /proc/net
+1.3 Networking info in /proc/net
 --------------------------------
 
 The subdirectory  /proc/net  follows  the  usual  pattern. Table 1-8 shows the
@@ -1382,7 +1304,7 @@ It will contain information that is specific to that bond, such as the
 current slaves of the bond, the link status of the slaves, and how
 many times the slaves link has failed.
 
-1.5 SCSI info
+1.4 SCSI info
 -------------
 
 If you  have  a  SCSI  host adapter in your system, you'll find a subdirectory
@@ -1445,7 +1367,7 @@ AHA-2940 SCSI adapter::
     Total transfers 0 (0 reads and 0 writes)
 
 
-1.6 Parallel port info in /proc/parport
+1.5 Parallel port info in /proc/parport
 ---------------------------------------
 
 The directory  /proc/parport  contains information about the parallel ports of
@@ -1470,7 +1392,7 @@ These directories contain the four files shown in Table 1-10.
            number or none).
  ========= ====================================================================
 
-1.7 TTY info in /proc/tty
+1.6 TTY info in /proc/tty
 -------------------------
 
 Information about  the  available  and actually used tty's can be found in the
@@ -1505,7 +1427,7 @@ To see  which  tty's  are  currently in use, you can simply look into the file
   unknown              /dev/tty        4    1-63 console
 
 
-1.8 Miscellaneous kernel statistics in /proc/stat
+1.7 Miscellaneous kernel statistics in /proc/stat
 -------------------------------------------------
 
 Various pieces   of  information about  kernel activity  are  available in the
@@ -1578,7 +1500,7 @@ softirqs serviced; each subsequent column is the total for that particular
 softirq.
 
 
-1.9 Ext4 file system parameters
+1.8 Ext4 file system parameters
 -------------------------------
 
 Information about mounted ext4 file systems can be found in
@@ -1594,7 +1516,7 @@ in Table 1-12, below.
  mb_groups       details of multiblock allocator buddy cache of free blocks
  ==============  ==========================================================
 
-1.10 /proc/consoles
+1.9 /proc/consoles
 -------------------
 Shows registered system console lines.
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index f270080f1478..789093375344 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -12,7 +12,7 @@
  * Theory of operation:
  *
  * At the lowest level, there is the standard driver for the CD/DVD device,
- * typically ide-cd.c or sr.c. This driver can handle read and write requests,
+ * such as drivers/scsi/sr.c. This driver can handle read and write requests,
  * but it doesn't know anything about the special restrictions that apply to
  * packet writing. One restriction is that write requests must be aligned to
  * packet boundaries on the physical media, and the size of a write request
-- 
2.35.3

