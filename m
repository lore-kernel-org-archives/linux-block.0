Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27E4C433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Dec 2021 06:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhLJGTi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Dec 2021 01:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhLJGTh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Dec 2021 01:19:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB28C061746
        for <linux-block@vger.kernel.org>; Thu,  9 Dec 2021 22:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=y1GifFop1lI4anosO8Rh54/FVEpscbbAal1X0GxOX/E=; b=f83fmZYOyCH+kyHIV84Z1CXEkB
        PIr0SKo3YUtgfpikWRQpu+h5GDvHcdnVoucaHJntVyGySz0y7M8PYCI/uKUeSnyaMzsVGI2+UiJne
        Adg3c8W2VuQ7dfkBi+uMAPNKjgV3dSl+NcKywLIorMmFosR5OA26B4JxwG4ZZde+OohviDqAPgnfw
        dt8W/L3MyJJfxGSGeByUUqOuOdwlbo69Q/b1l3dneirHeuKtyvYHIj0R+FZHrlj44sgArIcKpAvk/
        BecJT/r5x1EYnO23Q8Jyd8CbiK1U1aFlQSpg958h+fDItiVuAbKQ+MkNcfl1ULcAgnZgW1RT9AL/Z
        nLP1n0og==;
Received: from [2001:4bb8:180:a1c8:de14:d573:bcd:1136] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvZCE-00A4qW-RU; Fri, 10 Dec 2021 06:15:55 +0000
Date:   Fri, 10 Dec 2021 07:15:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.16
Message-ID: <YbLwmaLqilKEW0Q/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit e3f9387aea67742b9d1f4de8e5bb2fd08a8a4584:

  loop: Use pr_warn_once() for loop_control_remove() warning (2021-11-29 06:44:45 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.16-2021-12-10

for you to fetch changes up to 30e32f300be6d0160fd1b3fc6d0f62917acd9be2:

  nvmet-tcp: fix possible list corruption for unexpected command failure (2021-12-08 16:36:58 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.16

 - set ana_log_size to 0 after freeing ana_log_buf (Hou Tao)
 - show subsys nqn for duplicate cntlids (Keith Busch)
 - disable namespace access for unsupported metadata (Keith Busch)
 - report write pointer for a full zone as zone start + zone len
   (Niklas Cassel)
 - fix use after free when disconnecting a reconnecting ctrl
   (Ruozhu Li)
 - fix a list corruption in nvmet-tcp (Sagi Grimberg)

----------------------------------------------------------------
Hou Tao (1):
      nvme-multipath: set ana_log_size to 0 after free ana_log_buf

Keith Busch (2):
      nvme: show subsys nqn for duplicate cntlids
      nvme: disable namespace access for unsupported metadata

Niklas Cassel (1):
      nvme: report write pointer for a full zone as zone start + zone len

Ruozhu Li (1):
      nvme: fix use after free when disconnecting a reconnecting ctrl

Sagi Grimberg (1):
      nvmet-tcp: fix possible list corruption for unexpected command failure

 drivers/nvme/host/core.c      | 23 ++++++++++++++++++-----
 drivers/nvme/host/multipath.c |  3 ++-
 drivers/nvme/host/nvme.h      |  2 +-
 drivers/nvme/host/zns.c       |  5 ++++-
 drivers/nvme/target/tcp.c     |  9 ++++++++-
 5 files changed, 33 insertions(+), 9 deletions(-)
