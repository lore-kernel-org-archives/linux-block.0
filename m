Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCF6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 15:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiCJPar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbiCJPar (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 10:30:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4905159EA8;
        Thu, 10 Mar 2022 07:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MtFPNUJOKihK1AuLv4ZBIl0Bz4OcJZ6RUVMYCdOXqgQ=; b=RAQL1AaEp/b8GSIkEy8r45ozgC
        nyWQnnHRgqBEY2b5NhwRj0sRE6jUHJAHoNgKc8lEXMXfbxZtpqSqCj3frnsMLHdgGrendhw9z31di
        tEMpBy/f8IebZ/FRy9LJiWOGiWurDk9rmXLy4YooFUxKDyqXgvX3mTQgdUPcUMSMd03R8VgWUoMbS
        esIFSiuE3iEfs2Kucm6o4uiBMIgd3I9Xys4KyDuyn9AATYwHTF2STYmcObDxR4I+y8C0eJ/IPMCBa
        XdiPmCX+gjPlP/Bf+PfGs/llzqF6Dlq6Xt9uqBIGAFDEmbfVk7F9v0OIm+aqPfaRcQ9111bSHIdsW
        bBnAQCvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSKjY-00DLde-PC; Thu, 10 Mar 2022 15:29:44 +0000
Date:   Thu, 10 Mar 2022 07:29:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Valentin Kleibel <valentin@vrvis.at>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Sanders <justin@coraid.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: aoe: handle device timeouts atomic-safe
Message-ID: <YioZaO21yingv0nD@infradead.org>
References: <07bafc71-a6d2-ad6d-4706-7c99047b3228@vrvis.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07bafc71-a6d2-ad6d-4706-7c99047b3228@vrvis.at>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 04:17:37PM +0100, Valentin Kleibel wrote:
> If an aoe device does not respond to any packet on the network layer within
> aoe_deadsecs, the driver tries to mark the device as down, fail all I/O and
> clean out the queue.

I think the problem is that aoe even tries to queue up request
internally. It really needs to switch to use BLK_MQ_F_BLOCKING and
stop queuing up the requests internall at all.
