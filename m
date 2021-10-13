Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959E4C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D43660F21
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhJMPPF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhJMPPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:15:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BE2C061749
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=INJOCXO1UwtHd8vKKDCRoPGfd7PoqD/RbsqReQv2DdQ=; b=pPmDoqNg3dvl/rOS6V9pKM9x6H
        tCWc7YqdSZYcVjwbekDErbmn4kH+cBnpdIQDQ0CYKwC6mjjhjDeYArWMP/wLwe4GxYiTlqvAPyjp3
        xf8t61pD1V8C7watpDM1F68ZwjtQ2qYJWP2UkiynL7UBMbbaCOcxUinxeiM6mYAWamD8nwbuLxm3f
        H4E/mYn/PTwXs11PsVzXEbP+qpPtErK+ev6iuCY8JTQh9lOukOystjXAQ2/PuARQ7K+VnJP+UtZPi
        OgPNe7usuFb7IEvYw+W0Yc0Q4DTNxMGDAmFEddn0JXi56kBZta8AzDMdg1j+3X46H/ZfcLygo0exf
        j0+cfv4A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mafuO-007Xq2-A6; Wed, 13 Oct 2021 15:11:22 +0000
Date:   Wed, 13 Oct 2021 16:11:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme: move the fast path nvme error and disposition
 helpers
Message-ID: <YWb3DATaQtAhJUFt@infradead.org>
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-6-axboe@kernel.dk>
 <YWaDQiwoo/vjNXxZ@infradead.org>
 <044549fd-b3eb-cfa8-b687-42726c2ed08e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044549fd-b3eb-cfa8-b687-42726c2ed08e@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 08:41:27AM -0600, Jens Axboe wrote:
> I think I'll just kill this patch and check nvme_req(req)->status in the
> caller. If it's non-zero, just do the normal completion path and skip
> the batch list.

Yes, that sounds like a better approach.
