Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9DEC352A4
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 20:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AD5217F4
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 20:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OhznjUHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBLUAn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:00:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgBLUAn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 15:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n9TNUxtVhclVjuWXrx0pTG8cFTkJ1NbXWqDCvr6uAN8=; b=OhznjUHCZsPjj5kn9KcN6oEqz4
        8g1wGfzCbrFXoZWTsvTpvRP3Ac0g5D9RixFX+JoPObU1cPyTfMEhHliwtSfLZUVDLJBP13XoiBT+M
        sR86FM0LoiSy7HDNnZ4lmg7M+MpLgA8tIZQIMOvvocR+EjepUwlRciNsDwA41imAHlxzzz0ZfUT+L
        H7PleQNG3P3qgYXmAaK97qn0WVFyIon2dGTwBZBxQPnz/hbtdB3+Sw3tZ3Ypvo+uwV1S/xaiADkW2
        RqnD2VxESs3Gjp/75x4sK4Lh/5cOXipTur3aKKTuy+YgHJ5xpjS6GtOGtXN+HT9NOhI25kRzMrMl+
        kYovNGGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1yBc-0007Pg-Ao; Wed, 12 Feb 2020 20:00:40 +0000
Date:   Wed, 12 Feb 2020 12:00:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, damien.lemoal@wdc.com
Subject: Re: [PATCH v2] block: support arbitrary zone size
Message-ID: <20200212200040.GA21661@infradead.org>
References: <20200210220816.GA7769@avx2>
 <20200210222045.GA1495@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210222045.GA1495@avx2>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 11, 2020 at 01:20:45AM +0300, Alexey Dobriyan wrote:
> SK hynix is going to ship ZNS device with zone size not being power of 2.

NAK.  We clearly stated we require power of two zone sizes in Linux.
(Not Zone Capacities for ZNS, though - which is the whole point the
zone capacity concept was added).
