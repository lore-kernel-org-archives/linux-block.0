Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8826BC43331
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 06:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494EE2073B
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 06:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J/S/FyyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbgDCGiW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 02:38:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgDCGiW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 02:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Z5ffwMMyQr5fqyL8STIVdTLMUXC8KbAaSDUy2T0pCM=; b=J/S/FyyRUH3nEENg3mXGxEAyVd
        DIPDNoF6QcGSzqA7rIIVgHjjB83oqEsD8CsIFwOFJ1cf9U3angZb3/cUVbObAD9ETYitrVgBHqeHJ
        d1yFp29Mrg4vhLxQz7fIbi1jycY30ea/b8sXNlKBAlwRpPB7dg8RXqT/r4ohGC7Jf+kwwZbw1erlh
        w5uFnfr2OJLdrtx2Fk7sElWYms7mZYjGGJly+FHG2YthtuzS9MLKryXvzEyTj8sCvsk6UNK8JEH0+
        CWR9w3jAfaXFytAZC0dHN/FJhgjK4/B50phtjtHz7ITal5pEg4OKUQVrZTqkv/FAX7+90YDHzFpJT
        0xbs4RhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKFy8-0007X9-79; Fri, 03 Apr 2020 06:38:20 +0000
Date:   Thu, 2 Apr 2020 23:38:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     evgreen@chromium.org, asavery@chromium.org, axboe@kernel.dk,
        bvanassche@acm.org, darrick.wong@oracle.com, dianders@chromium.org,
        gwendal@chromium.org, hch@infradead.org,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        ming.lei@redhat.com, kernel@collabora.com
Subject: Re: [PATCH v8 1/2] loop: Report EOPNOTSUPP properly
Message-ID: <20200403063820.GA28875@infradead.org>
References: <20200402170603.19649-1-andrzej.p@collabora.com>
 <20200402170603.19649-2-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402170603.19649-2-andrzej.p@collabora.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 02, 2020 at 07:06:02PM +0200, Andrzej Pietrasiewicz wrote:
> From: Evan Green <evgreen@chromium.org>
> 
> Properly plumb out EOPNOTSUPP from loop driver operations, which may
> get returned when for instance a discard operation is attempted but not
> supported by the underlying block device. Before this change, everything
> was reported in the log as an I/O error, which is scary and not
> helpful in debugging.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
