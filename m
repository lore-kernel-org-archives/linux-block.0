Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA977C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 11:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbhLWLfS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 06:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLWLfR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 06:35:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFBBC061401
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 03:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=06tBP8xgBR9K04ykCfWA7PyNTufqRYjyBBoKEngUwmU=; b=kr54j0eaPxW3s1ujAmUUc8bmGd
        ZQ+rFWjwnLFIeQjb5TERu+F+R+WWQOhmMTRsa/hI5TgYqlCjIpN9OyiKpCsq4N6eTkcr6f7QyurkD
        tWF9L9MmkhfEn0bxrP+++JIvRqDnA+HjNcqh02xZg/1Z9DCMrn0oPscgClIx2dSeR937AH8/HtH3u
        IQ1bwf+fwJQAfBDYvZF5KdMpCasZ5I7CZjaSJayiOvts79Eo0hUOOygKnYyVljRPxl6Vw/tbKiAY4
        yiJ/gNP4UdTLVyrXmQ3m1VEQvWRiM8huaYesdX+7CQ9Vq7TN4aoUzgbHi+TSJLhh1TDR7mxAeyOIw
        C/mWMv/A==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0MNI-00Caz4-KA; Thu, 23 Dec 2021 11:35:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>,
        Ondrej Zary <linux@rainbow-software.org>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org
Subject: [RFC] remove the paride driver
Date:   Thu, 23 Dec 2021 12:35:03 +0100
Message-Id: <20211223113504.1117836-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

the paride driver has been unmaintained for a while and is a significant
maintainance burden, including the fact that it is one of the last
users of the block layer bounce buffering code.  This patch suggest
to remove it assuming no users complain loduly.

Ondrej: you're the last known users, so please speak up if you still
have a use case!
