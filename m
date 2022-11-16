Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F95C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 07:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiKPHn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 02:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKPHn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 02:43:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E58FE5
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 23:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0iM/K7mf/amSNC2IoVBnznB/hJH3Een9UGVC6zV6NeY=; b=k9qgv7dCMwgThlEFgDFYl1C7nP
        xktfsb96FTW+PNu6Js8DvJ6TB4p4sDTzTRReWRyMRWA0/PJYz0S5MmDXuVpzUZu+ZMaV9qWxojoa+
        PUTQ4Nrtw0jixRrm5HBmxx5ug7t5+JRr81/8Prjw6VxIuuvMAL4J+iFLixxbhHezrGD7lfv5PAM0Z
        BZTAVpmpBpph0qbY6EC34jJpRJog+UDa8fVrcwTG5+nzGqbEbuLbFhlq4yag00eRdiMbbFDE+WROR
        6q+zg8dVVCCVhG7mOp9mzLtuaZYcwojlUcuUcXEvQ/QdYH4WRE/TITI3PAhRSVkpyz80DpvXhfL3P
        +4CqTIkg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovD4w-000wcU-Kn; Wed, 16 Nov 2022 07:43:26 +0000
Date:   Tue, 15 Nov 2022 23:43:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        "Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH] tests/nvme: Add admin-passthru+reset race test
Message-ID: <Y3SUnt6uuPoMiAVE@infradead.org>
References: <20221114203412.383-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114203412.383-1-jonathan.derrick@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 14, 2022 at 01:34:12PM -0700, Jonathan Derrick wrote:
> Adds a test which runs many formats and reset_controllers in parallel.
> The intent is to expose timing holes in the controller state machine
> which will lead to hung task timing and the controller becoming
> unavailable.

This passes just fine for me both on qemu and a thunderbolt attached
m.2 SSD.  So it seems to be hardware / timing dependent.
