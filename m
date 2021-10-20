Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4EBC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6F36113D
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJTG2k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTG2j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:28:39 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B13C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r/4NrmgLufruJvCNr2tOOnzQvNHKZEcSU8zxwTnVEUg=; b=OqW5NPOK4oARUm2RupMnJgbgW5
        Y3vB+UCXYUHuJdErhrbTk6hSAF2Jf0qN1lF2+TLHg6AnSbAxCqdW8Z5McTdQYrvtitR4cMu2XEEuf
        seicxWtK80uW31nI7e163PdG32EUb48E93wmzbfY0WbaIzFfwA3WEG3z54AcTcnY5TwY3hOOARpJQ
        m5i0WMejOGKiDiMhoew22UAfn+Aj102zkBMwNPiGcmqptcIoVXSCaJcqvBzYTrjFLr4dFdDAszhud
        YiOPCzIpHLNeWSpGS96DOp0NDIZeESjopGVWa//1e5K7PxNCL1NE7OcpyPVyU1sRP5Dqv9nq8tsy9
        GS7llMsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md53R-003Thp-V9; Wed, 20 Oct 2021 06:26:25 +0000
Date:   Tue, 19 Oct 2021 23:26:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 16/16] block: optimise submit_bio_checks for normal rw
Message-ID: <YW+2kexriMgXSIXP@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <c53849108e8c2b831e78cd58b44244b27df43ab6.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c53849108e8c2b831e78cd58b44244b27df43ab6.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:25PM +0100, Pavel Begunkov wrote:
> Optimise the switch in submit_bio_checks() for reads, writes and
> flushes. REQ_OP_READ/WRITE/FLUSH take numbers from 0 to 2, so the added
> checks are compiled into a single condition:
> 
> if (op <= REQ_OP_FLUSH) {} else { switch() ... };

Same comment as for the previous one.
