Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7DBC636CC
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 15:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjAaPNi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjAaPNT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 10:13:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0495926C;
        Tue, 31 Jan 2023 07:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M0NuK3BqCxrm1hvDFKgidQ69sL72ceicw1jaANPf97Y=; b=oT76y8fLlCjmSpI+FpgzxYBSeO
        QPktthkSJRwextvp/E+5rQGIEUm6tHL3B43iC1F6FBhKrUdoWc/2zSHUQNAwcBy7YYz0eij0SmAT8
        gErBoFp2Vq305WN3Li2PaWAOS1AVFXsqfyHnmuH/VW3n5RMAveDQ6u6ICFvP5h5IptUKouWfPdIU+
        T1rTX+aa6okn0uwBqLxibGfUoNhPmJ/EQQX83EUS+XcnhgSXBKvaevtwEC0KB7FvBqMhFIxky7rap
        groA6I+ScX9gHqX8EgOF1JJ3zuKazCP9HcweHNvWQdrsKoRBeXyIcJfYbwAp+H2Gwm6TOJW/VXh8+
        ai/B1pDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMsHn-008Rce-Ru; Tue, 31 Jan 2023 15:11:03 +0000
Date:   Tue, 31 Jan 2023 07:11:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
Message-ID: <Y9kvh42/T9rdqDH9@infradead.org>
References: <20230131084742.1038135-1-linus.walleij@linaro.org>
 <Y9jY2zsNbSCWluZG@infradead.org>
 <CACRpkda3mk8wkdxWQFev9PrK6bPsxR6qLJo_gXnK+_jaTCFfjg@mail.gmail.com>
 <Y9kVrh9VEz4/T76f@infradead.org>
 <CACRpkdbd73PEAaNYr2cz=pmw7guHK0-hiPCYXgpgQfy-d9TTTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbd73PEAaNYr2cz=pmw7guHK0-hiPCYXgpgQfy-d9TTTQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 31, 2023 at 03:05:20PM +0100, Linus Walleij wrote:
> To be clear, "works better" in this context means, solving a problem
> for the interactive user, preventing random freezing of the UI on
> resource-limited (memory, disk throughput) systems under high
> I/O load.

Which already has nothing to do with the mmc driver.  And the rest
of your mail makes this even more clear.  You want bfq for interactive
systems with little resources and really shitty storage device, which
just happen to use mmc in your use case.

My use case for sd cards OTOH is extremely resource constrained systems
where I absolutely do not want a bloated I/O scheduler.  In fact I'd
love to be able to even compile the infrastructure for them away.

In other words:  you want distro policy to use bfq for your use case,
but that has no business being in the Kconfig.
