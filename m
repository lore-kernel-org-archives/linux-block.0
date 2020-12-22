Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1519C433DB
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 15:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F146230FC
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 15:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgLVPUA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Dec 2020 10:20:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727731AbgLVPUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Dec 2020 10:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608650313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uGQXz7EjCUOAMril8Wws9YsLnDf1hCsIoLziBOE/WAk=;
        b=HwYe9fCLIQl/MrJsRay94lEGBAJUInRnI3w11H4cJPWCtJdkfm1yCOXs+Qana3Cw1r6aMu
        T4iHpzXuB9l7WWPLv+TMToTdjup7RrxSAA3ra6n2y8L2V6uwRu6QcqpYC9Gk5WntYJH4OH
        gIEVL2swOO4MpTNrxLU3wCBVWdftIqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-rPQg_BxMNyyySmkmb40NKw-1; Tue, 22 Dec 2020 10:18:28 -0500
X-MC-Unique: rPQg_BxMNyyySmkmb40NKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00CB459;
        Tue, 22 Dec 2020 15:18:26 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7C285D6A8;
        Tue, 22 Dec 2020 15:18:24 +0000 (UTC)
Date:   Tue, 22 Dec 2020 10:18:24 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Antonio Quartulli <a@unstable.cc>,
        Hyeongseok Kim <hyeongseok@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mike Christie <michael.christie@oracle.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [git pull] device mapper changes for 5.11
Message-ID: <20201222151823.GA17999@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 65f33b35722952fa076811d5686bfd8a611a80fa:

  block: fix incorrect branching in blk_max_size_offset() (2020-12-04 17:27:42 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-changes

for you to fetch changes up to b77709237e72d6467fb27bfbad163f7221ecd648:

  dm cache: simplify the return expression of load_mapping() (2020-12-22 09:54:48 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Add DM verity support for signature verification with 2nd keyring.

- Fix DM verity to skip verity work if IO completes with error while
  system is shutting down.

- Add new DM multipath "IO affinity" path selector that maps IO
  destined to a given path to a specific CPU based on user provided
  mapping.

- Rename DM multipath path selector source files to have "dm-ps"
  prefix.

- Add REQ_NOWAIT support to some other simple DM targets that don't
  block in more elaborate ways waiting for IO.

- Export DM crypt's kcryptd workqueue via sysfs (WQ_SYSFS).

- Fix error return code in DM's target_message() if empty message is
  received.

- A handful of other small cleanups.

----------------------------------------------------------------
Antonio Quartulli (1):
      dm ebs: avoid double unlikely() notation when using IS_ERR()

Hyeongseok Kim (1):
      dm verity: skip verity work if I/O error when system is shutting down

Jeffle Xu (3):
      dm: remove unnecessary current->bio_list check when submitting split bio
      dm: add support for REQ_NOWAIT to various targets
      dm crypt: export sysfs of kcryptd workqueue

Mickaël Salaün (1):
      dm verity: Add support for signature verification with 2nd keyring

Mike Christie (1):
      dm mpath: add IO affinity path selector

Mike Snitzer (1):
      dm: rename multipath path selector source files to have "dm-ps" prefix

Qinglang Miao (1):
      dm ioctl: fix error return code in target_message

Rikard Falkeborn (1):
      dm crypt: Constify static crypt_iv_operations

Zheng Yongjun (1):
      dm cache: simplify the return expression of load_mapping()

 Documentation/admin-guide/device-mapper/verity.rst |   7 +-
 drivers/md/Kconfig                                 |  22 +-
 drivers/md/Makefile                                |  20 +-
 drivers/md/dm-cache-target.c                       |   7 +-
 drivers/md/dm-crypt.c                              |  13 +-
 drivers/md/dm-ebs-target.c                         |   2 +-
 drivers/md/dm-ioctl.c                              |   1 +
 ...vice-time.c => dm-ps-historical-service-time.c} |   0
 drivers/md/dm-ps-io-affinity.c                     | 272 +++++++++++++++++++++
 .../md/{dm-queue-length.c => dm-ps-queue-length.c} |   0
 .../md/{dm-round-robin.c => dm-ps-round-robin.c}   |   0
 .../md/{dm-service-time.c => dm-ps-service-time.c} |   0
 drivers/md/dm-stripe.c                             |   2 +-
 drivers/md/dm-switch.c                             |   1 +
 drivers/md/dm-unstripe.c                           |   1 +
 drivers/md/dm-verity-target.c                      |  12 +-
 drivers/md/dm-verity-verify-sig.c                  |   9 +-
 drivers/md/dm-zero.c                               |   1 +
 drivers/md/dm.c                                    |   2 +-
 19 files changed, 345 insertions(+), 27 deletions(-)
 rename drivers/md/{dm-historical-service-time.c => dm-ps-historical-service-time.c} (100%)
 create mode 100644 drivers/md/dm-ps-io-affinity.c
 rename drivers/md/{dm-queue-length.c => dm-ps-queue-length.c} (100%)
 rename drivers/md/{dm-round-robin.c => dm-ps-round-robin.c} (100%)
 rename drivers/md/{dm-service-time.c => dm-ps-service-time.c} (100%)

