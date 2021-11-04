Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792CEC433FE
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 08:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBB46121F
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 08:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhKDIsh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 04:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKDIsh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 04:48:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1CC061714;
        Thu,  4 Nov 2021 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7iBaCS/d5Ua+JXj2sb0aBgjdhf9t0ks4cVnD/dhnPg4=; b=Sy5caejkHBqEJWat87JYiV2E7o
        xN4fxNuQKUvqlyxn6l1GhS1C7p33kyp3840sWv3zhJuhDGsXoRvA/Mw/rZU3ABeZtIOoZEvZbytPk
        n/OYlVPyHwmIFU4Ki3tznXCLdjxwhZp9volR61ca5wREAvov7bY8KtagwljKtGJb7gz3uXcXr/nCR
        sufmpRJ1jnqKNwHdePPi3qOK4owftb78lFrGGfevUTkB6KLTY3iqIKTydLYSBKBqCXAJRp0kKZJHx
        o6NP8px+a2CBekep80n5kbSQalD9Z9MUQ+0f+fcmoF88piQcXd3ZTj/bpMbYJP7nQEU2M5hjGN9wl
        mg3q4gsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miYNg-008MAt-Uo; Thu, 04 Nov 2021 08:45:56 +0000
Date:   Thu, 4 Nov 2021 01:45:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wu Bo <wubo40@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
Subject: Re: [PATCH 0/2] add error handling support for add_disk()
Message-ID: <YYOdxHEklLAIwNwo@infradead.org>
References: <1636014799-20156-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636014799-20156-1-git-send-email-wubo40@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Luis has an outstanding series that also covers these two drivers.
