Return-Path: <SRS0=SUnH=3S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9E4C2D0DB
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C67D206D5
	for <linux-block@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H9IQZNQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgA2X3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:29:25 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24315 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2X3Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jan 2020 18:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580340564; x=1611876564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=smzJ9aLrfZQAYLsAFApydMD2EtHWMA2/FV/r3qlGdVQ=;
  b=H9IQZNQEfIPr4/RZ2nfS0VDQsnFFpnUEKKVxX2dC7g0/amTt8P3d00xc
   F20TnE7XoTO8gWHonuxuX1sQ8kLrEHGTY2YO83zkdlrqlmlyilOOD04Iz
   uON395db82m5joOBoA5jVihmpruol6pWvPugIuSM6molx3z+q90F8K1d/
   4IjsGjVlimHMPHfY1SUxRSDiXqCIa8F8dJpB3klunV8EPkwA9ujd+cJ22
   8Nro9l5wcGfaBjawY0uvOZtyuGrWhaZ/zaAp/pNUUXilR5goFD5qf+HrF
   8EvfZ0sLtRl8silyEA7C3RUGEYjYBZSHxSUS6sPI3x+dqh8yERkLb0tBr
   w==;
IronPort-SDR: fzY+EEAYnXTRPqTtQndMlZXAR5RsP+lB7SNdo7POF/4P3FPaDYoFtIEuPCf4I0tbyRETf5so8a
 jVQ5363qFBgq6pjH//ob67EwORpMMVrN1OXuuiIFWyuSh5Xv4YaV2FftqJmnjanNkd2QPz0osY
 59Np51ory+m63kKkRE739WWB9oZwnUubpbr7CPYJkTj5WZIfiqR0TuLKECLAfhJjWXpuOq/h59
 lRJ95A0HMr1yx0HOObvCRFrTFiSTzRze/12OyuuhEhFIRskizULGUhvDIUZfHy+1eXmz5qfmO1
 9DQ=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; 
   d="scan'208";a="128691689"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:29:23 +0800
IronPort-SDR: y6Zh5eheB/TCh3q9SoBtqy68X3eyvMODXrKD9trIGn6Xk3vB4riBHizhmernqzWqHFFjculgL1
 Ub7S83mCLoVn6ypkwtQGMu+Lc1GXZbYJ2CBHxaVjT6JR8YbFw89kVXZEStpy6i3iWIqayexJsV
 LQkgzJfcsF+rKBTfMW0s1Pmq6MkrEFCca3vGbn4rDwx4OhC9prTDOK7dD8Yb3ZpDMLRwBpMpc/
 v/pVp/A9R/D8iLKD7+F6YjnhR6adNjYrAJU/YbDTy56UnsTvs8nYmzaL/XpK4EBPq+sMtjlDNn
 av8kdP/p4E0u8cTL+fgM3Zg1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 15:22:36 -0800
IronPort-SDR: liBZ+o5bt2p6wTYvaZcxXBghRE4XJlqf98IhZuF8dDoPxuEMVI0jeCl63SHUJySWZsOkPxT3XH
 7QjiaXBZd0nSazaK5yZ9JamH0N8zviNAzVkOQpQ8ZTMd6G9zaeTERnHZWQ7on8czrnn61gIIER
 AZhvyK7TdsC5hugdqRWQ1HNpURnqs0zWNMCgcsOag4jAXkZtBmyf/PYPLLVu5x+9DWezSnHmqg
 BD6qMpNZP6JelVSwJxP5nNy0Rc0H1/RWqq4K1zFCRzze9WDyUyCb5dwdHKRO5skdAYqV/i/UyU
 87Y=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 15:29:24 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Date:   Wed, 29 Jan 2020 15:29:16 -0800
Message-Id: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a small patch-series which adds two new testcases for
setting up controller IDs and model from configfs.

Regards,
Chaitanya


Chaitanya Kulkarni (5):
  nvme: allow target subsys set cntlid min/max
  nvme: test target cntlid min cntlid max
  nvme: allow target subsys set model
  nvme: test target model attribute
  nvme: make new testcases backward compatible

 tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  4 +++
 tests/nvme/034     | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/034.out |  3 +++
 tests/nvme/rc      | 24 ++++++++++++++++++
 5 files changed, 155 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out
 create mode 100755 tests/nvme/034
 create mode 100644 tests/nvme/034.out

Test Log :-

Without cntlid_min/max and model patches :-

nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  15.246s  ...  15.053s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.057s  ...  10.063s
./check: no group or test named nvme/0004
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.057s  ...  0.065s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.036s  ...  0.038s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.233s  ...  1.240s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.203s  ...  1.208s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  14.572s  ...  16.051s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  13.584s  ...  13.948s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  9.877s  ...  10.750s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  18.902s  ...  15.584s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.217s  ...  1.237s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.204s  ...  1.193s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.204s  ...  1.195s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime    ...  1.334s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.218s  ...  1.231s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.207s  ...  1.196s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.191s  ...  1.195s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.192s  ...  1.196s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.211s  ...  1.191s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.204s  ...  1.211s
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]
    attr_cntlid_[min|max] not found
nvme/034 (Test NVMeOF target model attribute)                [not run]
    attr_cntlid_model not found

With cntlid_min/max and model patches :-

nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  15.053s  ...  11.918s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.063s  ...  10.058s
./check: no group or test named nvme/0004
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.065s  ...  0.065s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.038s  ...  0.036s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.240s  ...  1.239s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.208s  ...  1.207s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  16.051s  ...  15.345s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  13.948s  ...  13.977s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  10.750s  ...  9.698s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  15.584s  ...  15.514s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.237s  ...  1.232s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.193s  ...  1.192s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.195s  ...  1.195s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.334s  ...  1.340s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.231s  ...  1.218s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.196s  ...  1.205s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.195s  ...  1.191s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.196s  ...  1.186s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.191s  ...  1.192s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.211s  ...  1.187s
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [passed]
    runtime  1.213s  ...  1.200s
nvme/034 (Test NVMeOF target model attribute)                [passed]
    runtime  1.223s  ...  1.204s


-- 
2.22.1

