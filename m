Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD8EC10F1B
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiLUKf3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiLUKe5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:34:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C967CB84E
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=omzie7vp0LFSNldSUbnfuc20Zcg9BbtMYQIpWUZ/Brc=; b=KFp4ZyTEhRj6+ePH2kVqxiw6CS
        L/jdp3EjvJdJGU4JnTFLPWx2IZU6KTxuV4SzNHX/MbF4ZTLjFise1u13/GgbQE1q77lwXkuN+Tfq4
        LrBJgPsZxywWH5e1XIeSegSYeY9uS/2LonI0uKjNEiCp+3cqr+jMKrLRoA9VLIoKzIU0xAzCOUphD
        nqKfw9z2JXOxDs/8/9kFRk6Jyzxit3jAXjQTwALSxgoA5SOFfX0l6C2wzMgGQwvDCMyawTPKZvlNS
        efx293UW6ueFKmHXZ/SfpGnmZKDEUU0Dp5Q6yXKlij9wZotPAM1m6972mWuYlBVmTfKNF5n63cHYF
        W7d9w3KQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7wQw-00DUqK-OG; Wed, 21 Dec 2022 10:34:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, mcgrof@kernel.org
Cc:     joshi.k@samsung.com, j.granados@samsung.com, anuj20.g@samsung.com,
        ankit.kumar@samsung.com, vincent.fu@samsung.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 0/6] blktests: char device tests with iouring-cmd fio
Date:   Wed, 21 Dec 2022 02:34:35 -0800
Message-Id: <20221221103441.3216600-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As io-uring cmd grows there's a desire to do a bit more funky things
with it. Add basic support with fio and add a few simple tests to
tests the NVMe conventional drives character device as well as the
ZNS character device.

These tests are perhaps a bit *too* basic to merge, not sure, let
me know. But I figured that this would provide example to let us
grow this with more complex things later as folks add support for
more features.

Luis Chamberlain (6):
  common/fio: add helpers using io-uring cmd engine
  tests/nvme: add new test for rand-read on the nvme character device
  tests/nvme: add new test for rand-write on the nvme character device
  tests/nvme: add new test for optimal write on the nvme character
    device
  tests/zbd: add new basic test for reading zone character device
  tests/zbd: add new basic test for reading zone character device

 common/fio         | 47 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046     | 42 +++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |  2 ++
 tests/nvme/047     | 41 ++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |  2 ++
 tests/nvme/048     | 41 ++++++++++++++++++++++++++++++++++++
 tests/nvme/048.out |  2 ++
 tests/zbd/011      | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/011.out  |  2 ++
 tests/zbd/012      | 50 ++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/012.out  |  2 ++
 11 files changed, 283 insertions(+)
 create mode 100755 tests/nvme/046
 create mode 100644 tests/nvme/046.out
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out
 create mode 100755 tests/nvme/048
 create mode 100644 tests/nvme/048.out
 create mode 100755 tests/zbd/011
 create mode 100644 tests/zbd/011.out
 create mode 100755 tests/zbd/012
 create mode 100644 tests/zbd/012.out

-- 
2.35.1

