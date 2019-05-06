Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22CCC04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 22:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6045D2082F
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 22:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCfDCpO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfEFWmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 18:42:22 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:37618 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEFWmW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 18:42:22 -0400
Received: by mail-qt1-f202.google.com with SMTP id s46so6539873qtj.4
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HDQgsnfMdYj2HzAh+6ZKVkk4GAFoPt2zIEZOsu0qMIU=;
        b=wCfDCpO4iwQ8hM3pS4WghaopX9OaZw7S2s2pTYHSwTSzHwuGPvStk8RQDoVx+YV2pc
         qgnKeomPe77Vcy3FFjVYTRmifdcB60+Gc7J3PFHQ4aUvu2T4jdlGwFp+jOvzqXYCVaXc
         YSnHMYF9+4ykKg28N41l/erKi55iAyZMcJUFZZSGFDo8Yfhk1ozwmcEk2PCJuH9bb9fS
         V65i43xZSrYa3zgcaLYvWwQnmiQRf+n6iv03QdS3oMjU4xQ+Z+KMpQ7zxEFlSqAP63qf
         Yp3HvJ5nzXdFxshzoOiykpBvSe/FQ6DOSGUTmrWEAY5r9a+KPWYuW/TuL0CZesVvnhAg
         Om+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HDQgsnfMdYj2HzAh+6ZKVkk4GAFoPt2zIEZOsu0qMIU=;
        b=H0qg602cuK5v1hgxotx9QJiMft5nrT6Hkwv/Qj1VSUz2hKID9y2seABYZRngEvcFmM
         KVDkB+tLBJ4waafZJYqozliHdMbruw3xiFKB3XBDtHCJBonson2YbxSUbMCFnaEkPPQW
         WIdwkGv3Ml6APNo7G69lYnPEFcLL3096Wzh0aeCCE5vHXl6uw5R7jcRDxiYuRhQNF0Lh
         Df2tq/DhDs+cokR62DZzLvetcjgR2cpGcSnmeRMV+kC/1t6w79D4UEkvdEwppQyo3tij
         4KH9TVfqNA/FsUm5sYgIP4OMtp+gJtgtrdw71SHOIe1OtpWXEw+4H3vJZDt4fhFOWHIE
         1AvA==
X-Gm-Message-State: APjAAAWv9h+Pt21RiUd66VWnqguJobnok6K/R3bjZEW3/LIp2tsJyy69
        aYZshbuRBO/bPq1kiR4RpuEgQkELCu7ltlE9XZHBqTpEVkmis3qWkBqEKVkMoUlwt1SYUfEv1Z/
        YBKPZiFJp+mItSM3XGBPxs4v2iwFZdNV2kZCrEqZhw/190EoCG6earsyV+tymsPIniGW6
X-Google-Smtp-Source: APXvYqxwA5++xM6gxezRNh+erunt1hddnW/QI/qj9Iu7UOgd0D8UkctzXLxKtJg+FWmw0YdKUWa/J4QBF1w=
X-Received: by 2002:a0c:b50d:: with SMTP id d13mr22650815qve.222.1557182541362;
 Mon, 06 May 2019 15:42:21 -0700 (PDT)
Date:   Mon,  6 May 2019 15:35:40 -0700
Message-Id: <20190506223544.195371-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC PATCH 0/4] Inline Encryption Support
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series adds support for Inline Encryption to the block layer,
fscrypt and f2fs.

Inline Encryption hardware allows software to specify an encryption context
(an encryption key, crypto algorithm, data unit num, data unit size, etc.)
along with a data transfer request to a storage device, and the inline
encryption hardware will use that context to en/decrypt the data. The
inline encryption hardware is part of the storage device, and it
conceptually sits on the data path between system memory and the storage
device. Inline Encryption hardware has become increasingly common, and we
want to support it in the kernel.

Inline Encryption hardware implementations often function around the
concept of a limited number of "keyslots", which can hold an encryption
context each. The storage device can be directed to en/decrypt any
particular request with the encryption context stored in any particular
keyslot.

Patch 1 introduces a Keyslot Manager to efficiently manage keyslots.
The keyslot manager also functions as the interface that upper layers will
use to program keys into inline encryption hardware. For more information
on the Keyslot Manager, refer to documentation found in
block/keyslot-manager.c and linux/keyslot-manager.h.

We also want to be able to make use of inline encryption hardware with
layered devices like device mapper. To this end, Patch 1 also introduces
blk-crypto. Blk-crypto delegates crypto operations to inline encryption
hardware when available, and also contains a software fallback to the
kernel crypto API. Given that blk-crypto works as a software fallback,
we are considering removing file content en/decryption from fscrypt and
simply using blk-crypto in a future patch. For more details on blk-crypto,
refer to Documentation/block/blk-crypto.txt.

Patch 2 adds support for inline encryption into the UFS driver according
to the JEDEC UFS HCI v2.1 specification. Inline encryption support for
other drivers (like eMMC) may be added in the same way - the device driver
should set up a Keyslot Manager in the device's request_queue (refer to
the UFS crypto additions in ufshcd-crypto.c for an example).

Patches 3 and 4 add support to fscrypt and f2fs, so that we have
a complete stack that can make use of inline encryption.

There have been a few patch sets addressing Inline Encryption Support in
the past. Briefly, this patch set differs from those as follows:

1) https://lkml.org/lkml/2018/10/17/1022
"crypto: qce: ice: Add support for Inline Crypto Engine"
is specific to certain hardware, while our patch set's Inline
Encryption support for UFS is implemented according to the JEDEC UFS
specification.

2) https://lkml.org/lkml/2018/5/28/1187
"scsi: ufs: UFS Host Controller crypto changes" registers inline
encryption support as a kernel crypto algorithm. Our patch set views
inline encryption as being fundamentally different from a generic crypto
provider (in that inline encryption is tied to a device), and so does
not use the kernel crypto API to represent inline encryption hardware.

3) https://lkml.org/lkml/2018/12/11/190
"scsi: ufs: add real time/inline crypto support to UFS HCD" requires
the device mapper to work - our patch does not.

Satya Tangirala (4):
  block: Block Layer changes for Inline Encryption Support
  scsi: ufs: UFS driver v2.1 crypto support
  fscrypt: wire up fscrypt to use blk-crypto
  f2fs: Wire up f2fs to use inline encryption via fscrypt

 Documentation/block/blk-crypto.txt | 185 ++++++++++
 block/Kconfig                      |  16 +
 block/Makefile                     |   3 +
 block/bio.c                        |  45 +++
 block/blk-core.c                   |  14 +-
 block/blk-crypto.c                 | 572 +++++++++++++++++++++++++++++
 block/blk-merge.c                  |  87 ++++-
 block/bounce.c                     |   1 +
 block/keyslot-manager.c            | 314 ++++++++++++++++
 drivers/scsi/ufs/Kconfig           |  10 +
 drivers/scsi/ufs/Makefile          |   1 +
 drivers/scsi/ufs/ufshcd-crypto.c   | 449 ++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h   |  92 +++++
 drivers/scsi/ufs/ufshcd.c          |  85 ++++-
 drivers/scsi/ufs/ufshcd.h          |  23 ++
 drivers/scsi/ufs/ufshci.h          |  67 +++-
 fs/crypto/Kconfig                  |   7 +
 fs/crypto/bio.c                    | 156 ++++++--
 fs/crypto/crypto.c                 |   9 +
 fs/crypto/fscrypt_private.h        |  10 +
 fs/crypto/keyinfo.c                |  69 ++--
 fs/crypto/policy.c                 |  10 +
 fs/f2fs/data.c                     |  69 +++-
 fs/f2fs/super.c                    |   1 +
 include/linux/bio.h                | 166 +++++++++
 include/linux/blk-crypto.h         |  40 ++
 include/linux/blk_types.h          |  49 +++
 include/linux/blkdev.h             |   9 +
 include/linux/fscrypt.h            |  58 +++
 include/linux/keyslot-manager.h    | 131 +++++++
 include/uapi/linux/fs.h            |  12 +-
 31 files changed, 2701 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/block/blk-crypto.txt
 create mode 100644 block/blk-crypto.c
 create mode 100644 block/keyslot-manager.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h
 create mode 100644 include/linux/blk-crypto.h
 create mode 100644 include/linux/keyslot-manager.h

-- 
2.21.0.1020.gf2820cf01a-goog

