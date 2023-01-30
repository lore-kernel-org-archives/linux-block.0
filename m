Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BAAC54EAA
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 08:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjA3ILc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 03:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbjA3IL3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 03:11:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B1C1350C;
        Mon, 30 Jan 2023 00:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+x7xiTZnb/t+E+V8c1YK52vGu7KQ5nEzQVNyDu5/HwU=; b=U0NuYPPtft0mw0zeSz4GYZfefL
        jdyyDtXXRYotHe+FWv2REUISNKdf7FhFadpsDr3CbKxeodlW6kda6moDNvR6L6c3ygabVN1dJL1yl
        ZAUHPgEOYF4MM7Vh71jaCUkfStTKIul732c0/HyCjl+NmA9q0zy44z2r1E2DtbApXpLqiYu+bA3Z6
        mRwkJdhLQkP0Ev8p/QHQmtSvVV3zL5xGyfA9Mr92fQv8ngRN3SeZLaf39lOKztBuITQJeEP8ufuP+
        Sb33WZkGS5sVfW/qsCK9FdKQWe1tAqnCJAXDrE9EYh9hxKQpr7IPK337+5pRefE6hcqa5+aFppC1c
        3CRoNW1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMPEQ-002cE8-TK; Mon, 30 Jan 2023 08:09:38 +0000
Date:   Mon, 30 Jan 2023 00:09:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] Increment diskseq when releasing a loop device
Message-ID: <Y9d7QqLQnCuN/bUN@infradead.org>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <20230126033358.1880-5-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126033358.1880-5-demi@invisiblethingslab.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 25, 2023 at 10:33:56PM -0500, Demi Marie Obenour wrote:
> This ensures that userspace is aware that the device may now point to
> something else.

The subject is wong, this also does two things to two different
subystems, not of which is mentioned in the subject.
