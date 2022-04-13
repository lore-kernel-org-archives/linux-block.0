Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC8EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 17:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiDMRlQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiDMRlQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 13:41:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697366C973
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HAtM1/zqtZZjPBy9u8kxxP+Y/hVwz6Dsu9594IH55L0=; b=ZN9LOZkS0xdgLp7Km3rPYqF4+N
        Q2QxoatACzXpI1Kz9n9OuY6nA8LFBvNE0DSBlDQkkPVNLxBvScoGgiGXR8jh2ApPt6rnSpXnGfwUI
        YUwkNcSQviBWO1yon4jRqGtERsxTPUhRwu7t5FzIGVhIO7q/RhnhbQSJbGnlzEMDMgv1kyTtT9mL5
        iffTiM22hGAGoHfp76P7cybvi0S7eSJtarotYp1XZizYBcXIsil+y41D/8H7oVbzriRPmn6jtt/kK
        w2bKdCgwh2jny46WSyEQlYBPlpg9uRjc7nnw0wXZdZoQ1Fdo/Cp4yRgHCqLQmMQLrqXs5L8XjuGW9
        HMZ3Wr5A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1negx8-001y5C-5p; Wed, 13 Apr 2022 17:38:50 +0000
Date:   Wed, 13 Apr 2022 10:38:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     bvanassche@acm.org, yi.zhang@redhat.com, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlcKqu3roZQSxZe8@bombadil.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlZXOC4VgmDrUGIP@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12, 2022 at 09:53:12PM -0700, Christoph Hellwig wrote:
> On Tue, Apr 12, 2022 at 05:24:04PM -0700, Luis Chamberlain wrote:
> > I do have CONFIG_NVME_MULTIPATH=y but I also have:
> 
> I'd suggest to ignore broken tests that require a deprecated option
> that will eventually be removed.

CONFIG_NVME_MULTIPATH will eventually be nuked?

  Luis
