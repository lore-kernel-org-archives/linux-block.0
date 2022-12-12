Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79953C4332F
	for <linux-block@archiver.kernel.org>; Mon, 12 Dec 2022 08:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiLLI6U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Dec 2022 03:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLLI6T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Dec 2022 03:58:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DD5BFC
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 00:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V+pBqAygIztynzK0IhZXZdB40rHtzcrb+jt5Q2ve3wM=; b=4Ro0P4zfbbDDPhhIx9t1PGogAJ
        csMsWFLmogj1F1zfBrzxIyQmkXZ8H7DhiTBXZdvz4+N4+DICvdlNSB+CLcJfdiOHNVoNK7sn3QNwq
        oxj5+NVEe2vvDMhDJDNCzZPPnCZAOoKfZrYjeClh5ONFHD04wQGMEY+c8qeC9LLw+YnDdGh2y/5Oi
        7mQRsRa3DLLX+VcerWw7ndg1IdNavyJGQJB5Q83JQ/l9UNoxD8XYTRrTSkWRyHv5So+DvGl7V7tph
        VNYSY86qE1ufWav71TDt7ONibKCpNtohurDnAKyod/RvqAjC3724McUKeY3+GMhVfG6XdXnGIaH6H
        eOdQP46A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4edd-00Agqa-Nz; Mon, 12 Dec 2022 08:58:17 +0000
Date:   Mon, 12 Dec 2022 00:58:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org
Subject: Re: can queue_virt_boundary() exceed PAGE_SIZE?
Message-ID: <Y5btKTZTP9MTQHSo@infradead.org>
References: <Y5TSvDH3kadijZhT@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5TSvDH3kadijZhT@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 10, 2022 at 06:41:00PM +0000, Al Viro wrote:
> 	I'd always assumed that to be impossible, but...

I think that's everyones assumptions, so we'd better reject setting
too large masks.
