Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB878C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 10:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJ3KH1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3KH1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 06:07:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB79E1A0
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MpzuCxcRJ6twvBJsoJZoHsX0KJzNhn328IFFwKJo2/Q=; b=BttTxBVDmM+l3l8UBQ4FjNZRuc
        gCvPJv5Po02Xp5HOTYBSjh2EO7pn4SGiZpX+OM12sUcMRovfPik2+VzpB49A+4ZvFA77nMrx0jdot
        IHmg2FVLrSBhJwqx9gHNspzQ7NrIzIPN1yBuLhxK9r4ikYObBMfvUEImelGks7HTYOmEUCDaccncW
        soXBTzlGE0AqICWrbPTvIMBfSHexxyNgPVBZpHGw4N3yoV4quMxRM35VZdeEL49jzb+4OMm9PdakQ
        q2U2ZwcHDrP6tD6N7NCmX+0LP6x9PO3TrZKx5V9B7EX23JzyfTnW9v2ehnCkHQA27iUXx+kNhMQCi
        twMn56dw==;
Received: from [2001:4bb8:199:6818:1c2a:5f62:2eb:6092] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op5Dx-00F8I8-32; Sun, 30 Oct 2022 10:07:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: misc elevator code cleanups
Date:   Sun, 30 Oct 2022 11:07:07 +0100
Message-Id: <20221030100714.876891-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series has a bunch of random elevator cleanups.

Diffstat:
 blk-mq-sched.c |    7 --
 blk-mq.c       |    2 
 blk.h          |    1 
 elevator.c     |  175 +++++++++++++++++++++++----------------------------------
 4 files changed, 73 insertions(+), 112 deletions(-)
