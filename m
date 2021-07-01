Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FDBC11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F75D61480
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 08:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhGAITd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 04:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhGAITd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jul 2021 04:19:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C2AC061756
        for <linux-block@vger.kernel.org>; Thu,  1 Jul 2021 01:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=d03GnJ2op0t3QcmJiXwXMRUg92R8HMcOrnEYS+WtUi4=; b=eJh3NcB96Fdf/9/8fCV5Cwu5E/
        FQ3LcKeR0HRmvAJiLbWezFGze0E0dsoqZJIGL2Aytz0OUvHP/Wf+QKrtsdotbCJS3bQZH0CfZCxhI
        GNp47S5ikJWtG10mrREqK/SqIvZvn0Q6L6o0ThKqR4fj8lQZ8cOEuxp6vGNpGlkEma/JkgqstG+5J
        xFxZ4iAY3abC2CsQS+EEOTO27VmvbvH15KsANVEMpuC3NISCH5MDQJ6Qp8YNRSoSbKK+3y1pE6cnc
        gIuqLu0JYUMwzN0qqIxignK5vHdGY553JrogbB8pRuud4AoVRoQkCezsuCkxXr4VVlrwnLHw+WNSS
        Mr5i9wYQ==;
Received: from [2001:4bb8:180:285:b614:ad7e:3c44:605c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyrsG-006Kq1-K9; Thu, 01 Jul 2021 08:16:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: two fixup for the block_device / hd_struct merge
Date:   Thu,  1 Jul 2021 10:16:36 +0200
Message-Id: <20210701081638.246552-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

find two fixes for the block_device / hd_struct merge series attached.


