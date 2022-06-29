Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CDCC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 06:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiF2GUV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiF2GUU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 02:20:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC851E3DA
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 23:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZqWRLZfidUhsZjQkVJN4oJEfM0stHyHoLoyeGctjKsE=; b=ppfo+3+zPjfltkPyHIYU9tzfRC
        naTt/L8Z0x6TgDP2O87i+hTnmFGh2deRxW+/zXi50w/wkEBN/KUUs8F+VbniMT1c7ta6ifGuF6G3w
        j6pqRiVx+F2w0X1xeJM+odzTdVcy5gGuZAyh/4cMkYSle3CIpHOfAzltVJfgQmdZ8PWMXwejmZqnx
        Gj00Hs0FNyORKo0jCI7EuTizIWVvdb8Kc9Q0rXydpq3E6tk7GsfKL2aVm7AeJ95EZiRaA6Tomgi1R
        mmsbyssQzsibDPKuiifYYShMoujAVF4XsGiobjZztzpB8F6QVMV1e9W/BT4LjLmMcxpSu8wDxoTds
        0PxVZ/dg==;
Received: from [2001:4bb8:199:3788:6e38:f996:aa54:7e1e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6R3i-009kn0-4T; Wed, 29 Jun 2022 06:20:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: clean up the blk-ia-ranges.c code a bit
Date:   Wed, 29 Jun 2022 08:20:11 +0200
Message-Id: <20220629062013.1331068-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, hi Damien,

this is a little drive by cleanup for the ia-ranges code, including
moving the data structure to the gendisk as it is only used for
non-passthrough access.

I don't have hardware to test this on, so it would be good to make this
go through Damien's rig.

Diffstat:
 block/blk-ia-ranges.c  |   65 +++++++++++++++----------------------------------
 block/blk-sysfs.c      |    2 -
 block/blk.h            |    3 --
 include/linux/blkdev.h |   12 ++++-----
 4 files changed, 28 insertions(+), 54 deletions(-)
