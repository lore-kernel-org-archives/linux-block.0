Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC95C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 05:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiDOFYj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbiDOFYi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 01:24:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C7E029
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 22:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5TjZ8Zn05j/7HLCXA871Ze8Zg7Vkdz9h9Wy4xiZ3bCU=; b=AXKATZK+HgorZbQSDl+phHUrEY
        M3CWbhGlYkE1fePonhAMlsXdi9afAuHEQAQ6Mv2VxkNyR/3Aa5I1aqHv+n37oxD+d2bCtnLbFEz9f
        F8U5w5od60bMuTg+9qEhK45tgX38VIDCjwr4Bb27IkFtFId2xzqfeFl80HEXVDY09GvjxBTPH88Hb
        Icdx7TtyuBlSd9il0eVj7c3oW6Gzfx7f685omLDxnFyOzD3CW0Z8ikm3X8CDF8q2GWgnozNSkejac
        hU4beKDBjIsGOfnqHCF6Tpr41wJxlIml7h7GTxDwXpKITZuMvlWjronVeJBKuU/DYicTNsOn4HIuE
        I3rPaR5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfEPI-008emO-Kp; Fri, 15 Apr 2022 05:22:08 +0000
Date:   Thu, 14 Apr 2022 22:22:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        yi.zhang@redhat.com, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlkBAKBec6BULlE+@infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
 <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <YlcSiszuNqVZMsb5@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlcSiszuNqVZMsb5@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 11:12:26AM -0700, Luis Chamberlain wrote:
> OK so CONFIG_NVME_MULTIPATH will be nuked, but the module parameter
> will remain, and if the module parameter is used with multipath=N you'll
> end up with a single namespace once the phase out of
> CONFIG_NVME_MULTIPATH is complete.

The other way around.  The plan is that CONFIG_NVME_MULTIPATH will
stay around forever - for deeply embedded devices that only have
a soldered on or sd-card nvme device with a single path there is no
need to carry the multipathing code around.  But the code to support
multiple controllers in a subsystem without CONFIG_NVME_MULTIPATH
will go away.
