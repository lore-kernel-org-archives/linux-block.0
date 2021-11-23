Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CF6C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhKWQHy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbhKWQHy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:07:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DECCC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=djW/qdZ3Sgk4+5+RxipOwD9i6p4U5T+mpsKcYt4yccc=; b=KDuqFHOYaSFcpT2oYtgM1lEGAB
        oBp59AXFmaFryndJhObAjZIF+oLUWEqZhTiHrGgK2fpRYOSdM7jGhlWfnpRn+YGCyMBFoPVNqY3oC
        FFCn55u1ouDnsTqCNovmsZkn5o9/uCCphsrJk5EkW6TnWT6OtF1vUtLzIcy1RbfrN2ObP58LybWOP
        GgIdbWOc2WqD03rDcymy0FoMQnp8G/3J5PF1XAvsEf1CngP1TYq0my9VNQeXN2MzVTLkCN7Xuknvf
        SoaJUVBz5mnVw+jA6BNDvnQW4Z1XnD2CXOTL3cKcTy/2zN7mZuQhQ1kM7uPKW51p0WQEPNpE3UWL3
        iGez34kw==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpYHj-00FRhe-GU; Tue, 23 Nov 2021 16:04:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: cleanup blk_mq_submit_bio
Date:   Tue, 23 Nov 2021 17:04:40 +0100
Message-Id: <20211123160443.1315598-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series refactors and cleans up the blk_mq_submit_bio path.
