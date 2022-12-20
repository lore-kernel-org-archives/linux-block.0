Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C13C4332F
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 23:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiLTXxi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 18:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLTXxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 18:53:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D511EACF
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 15:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=O3J4PyVK/6ZoQB5VQwmKWSNVtIS3mViy+FnjoHZaKZ4=; b=O/XHugaKTNr4pZVDoIDVReeEEh
        zp4XLbCElF63GJLTRoluLz3cSsAWZdpvJ4dFwShw/A4gMyozgPNk3nq8hnE0/EHDvgGBa+xC/Xzs2
        R7Pbr1yB9kIu21ux9F3Co1Iur7N9w1oRidk7KtM6zF4ym7jSzoum0kj4+/4f6uI7UFi1VlJoj3sIf
        t09pUFSpaXUdOhKzVieJQZ6aLnrubYfgDf90kC0LaQGxGPIHIKeOAaK7CnWkDRYohurypTDihEb2K
        Ed8kYMu0zGv9FFPT9ZEWmwsplrbDTyQYKqoTOy8ER8zOrdCaE1uGYi0RlAvacG6TaryjDbLqo3Y0n
        /tH7SQIQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7mQK-00642Y-4k; Tue, 20 Dec 2022 23:53:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, bvanassche@acm.org, mcgrof@kernel.org
Cc:     kch@nvidia.com, linux-block@vger.kernel.org
Subject: [PATCH v3 0/2] blktests: use patient module remover
Date:   Tue, 20 Dec 2022 15:53:22 -0800
Message-Id: <20221220235324.1445248-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This v3 has the following changes since v2:

  - Split out srp changes as requested by Bart
  - Removed usage of undocumented -1 as we don't need it
  - Fixed typos spotted by Bart
  - Tested against linux-next tag next-20221207
  - Tested against shellchecked
  - Embraces _unload_module() sanity check to not run
    if module is not used:
    [ ! -e "/sys/module/$module_sys" ] && return 0
  - Enhanced commit log with baseline proof on kdevops
  - Added documentation for why we do the substitution of "-" to "_"
    when using the sysfs refcnt variable

Luis Chamberlain (2):
  blktests: replace module removal with patient module removal
  tests/srp/rc: replace module removal with patient module removal

 common/multipath-over-rdma |  11 +--
 common/null_blk            |   9 ++-
 common/rc                  | 134 +++++++++++++++++++++++++++++++++++++
 common/scsi_debug          |   9 +--
 tests/nvme/rc              |   8 +--
 tests/nvmeof-mp/rc         |  15 +++--
 tests/srp/rc               |  19 ++----
 7 files changed, 163 insertions(+), 42 deletions(-)

-- 
2.35.1

