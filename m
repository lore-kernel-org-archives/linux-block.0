Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AF5C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 08:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiBVIVT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 03:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBVIVS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 03:21:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C481567A9;
        Tue, 22 Feb 2022 00:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Zz+8qcAEHHGrcPR+hPHiExinkN
        IhkPEwC2/0jIVZJ7VTNY1OorpPmqnhaidHwqL+qhlS7r2Pj1pteKo6XraISDnRMYoA7I3KGXp7SR6
        Z0p7Cy9uKwPihXhdebr0j4NVbYpxE/s8CnNycGplaP2vudN1dYinXn+onRHFQ77wBJV73zOh4o7g9
        vgHJsdcLOYgrvavOYbwQPlnXKkfMvZDEZW9lTAujMJmAOwMA79gSngpSkxYulStFfKbQvJ8My+Y+Y
        R+xzggAdoqi3cn9SwqMBd2UscFmfrkEMZ0nERphQv1DzeIl8BCMyxE+Cbaonv9rUjZA9QZkyx1Vxu
        CNsbP5xg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMQPl-008Up6-CD; Tue, 22 Feb 2022 08:20:53 +0000
Date:   Tue, 22 Feb 2022 00:20:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: block/diskstats: update function names
Message-ID: <YhSc5cw3PWnOfunS@infradead.org>
References: <20220222012751.1933194-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222012751.1933194-1-naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
