Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B37EC433E3
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12CB207DF
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="tlbXgpuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgH0TtV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:49:21 -0400
Received: from ale.deltatee.com ([204.191.154.188]:54822 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgH0TtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 15:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d0XbbvcOMS5yMWmc8GIJwISeLvNXDpaPGgjKPlPsT2M=; b=tlbXgpukKJ99pAENhapaGS1l0t
        O5KNYtZXgufWvbVoVwklIRlA10aAc3A+yd56hQR8dCKgTmYYImpwK1ac8ZGxF2lVj0awoNjic0ZOZ
        5PkZYQtrvZ2x/Hz57qLN8G4uhiiBJ4NA5MsyyC2L52w4lmOMSdcOj3wjqZSXWbLpLQSHHNjOvIO2l
        LVvp1PARyE4VSEc+h0rkgHT70wk9VTvJaJq2nAKqVI3su46+LOO6wemlA0E9GPvaBOm/qqAaJ5hrZ
        8XM6Z9d41Pf96Ub6+mlry+b34bC4UjZcgm6N+/Pxw73Kq+OkJPcKpOY0mzpIA94256d1LZeY2ZYJS
        o16AE3gw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNtb-0000Cc-3R; Thu, 27 Aug 2020 13:49:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNtZ-0001br-JJ; Thu, 27 Aug 2020 13:49:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logan.gunthorpe@eideticom.com>
Date:   Thu, 27 Aug 2020 13:49:01 -0600
Message-Id: <20200827194912.6135-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logan.gunthorpe@eideticom.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 00/11] NVMe Target Passthru Block Tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Logan Gunthorpe <logan.gunthorpe@eideticom.com>

Hi,

Now that the passthru patches are in Linus's tree, I wanted to get
the blktest changes that test them out there for some review.

I know that Sagi has a series in progress to allow for running tests
with other transports. These two patch sets will need to be reconciled
at some point.

This series is based off of the current blktests master and a git repo is
available for this here:

https://github.com/Eideticom/blktests nvmet_passthru

Thanks,

Logan

--

Logan Gunthorpe (11):
  common/fio: Remove state file in common helper
  common/xfs: Create common helper to check for XFS support
  common/xfs: Create common helper to verify block device with xfs
  nvme: Search for specific subsysnqn in _find_nvme_loop_dev
  nvme: Add common helpers for passthru tests
  nvme/033: Simple test to create and connect to a passthru target
  nvme/034: Add test for passthru data verification
  nvme/035: Add test to verify passthru controller with a filesystem
  nvme/036: Add test for testing reset command on nvme-passthru
  nvme/037: Add test which loops passthru connect and disconnect
  nvme/038: Test removal of un-enabled subsystem and ports

 common/fio         |  1 +
 common/rc          |  8 +++++
 common/xfs         | 33 +++++++++++++++++
 tests/nvme/004     |  2 +-
 tests/nvme/005     |  2 +-
 tests/nvme/008     |  2 +-
 tests/nvme/009     |  2 +-
 tests/nvme/010     |  3 +-
 tests/nvme/011     |  3 +-
 tests/nvme/012     | 20 +++--------
 tests/nvme/013     | 20 +++--------
 tests/nvme/014     |  2 +-
 tests/nvme/015     |  2 +-
 tests/nvme/018     |  2 +-
 tests/nvme/019     |  2 +-
 tests/nvme/020     |  2 +-
 tests/nvme/021     |  2 +-
 tests/nvme/022     |  2 +-
 tests/nvme/023     |  2 +-
 tests/nvme/024     |  2 +-
 tests/nvme/025     |  2 +-
 tests/nvme/026     |  2 +-
 tests/nvme/027     |  2 +-
 tests/nvme/028     |  2 +-
 tests/nvme/029     |  2 +-
 tests/nvme/033     | 69 ++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  6 ++++
 tests/nvme/034     | 37 +++++++++++++++++++
 tests/nvme/034.out |  2 ++
 tests/nvme/035     | 39 ++++++++++++++++++++
 tests/nvme/035.out |  2 ++
 tests/nvme/036     | 39 ++++++++++++++++++++
 tests/nvme/036.out |  2 ++
 tests/nvme/037     | 36 +++++++++++++++++++
 tests/nvme/037.out |  2 ++
 tests/nvme/038     | 38 ++++++++++++++++++++
 tests/nvme/038.out |  2 ++
 tests/nvme/rc      | 88 ++++++++++++++++++++++++++++++++++++++++++++--
 38 files changed, 429 insertions(+), 57 deletions(-)
 create mode 100644 common/xfs
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out
 create mode 100755 tests/nvme/034
 create mode 100644 tests/nvme/034.out
 create mode 100755 tests/nvme/035
 create mode 100644 tests/nvme/035.out
 create mode 100755 tests/nvme/036
 create mode 100644 tests/nvme/036.out
 create mode 100755 tests/nvme/037
 create mode 100644 tests/nvme/037.out
 create mode 100755 tests/nvme/038
 create mode 100644 tests/nvme/038.out


base-commit: 8a75bed5b0044615f4aedad8ea74aa20e6961851
--
2.20.1
