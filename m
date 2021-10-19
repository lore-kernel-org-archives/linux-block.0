Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCBBC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 07:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1146137D
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 07:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJSHbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJSHbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 03:31:09 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAB2C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 00:28:54 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 59286E80F06;
        Tue, 19 Oct 2021 09:28:50 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 7AA4D160DBD; Tue, 19 Oct 2021 09:28:48 +0200 (CEST)
Date:   Tue, 19 Oct 2021 09:28:48 +0200
From:   Lennart Poettering <lennart@poettering.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Martijn Coenen <maco@android.com>, linux-block@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>, Karel Zak <kzak@redhat.com>
Subject: Re: Is LO_FLAGS_DIRECT_IO by default a good idea?
Message-ID: <YW5zsImhomMNmII7@gardel-login>
References: <YW2CaJHYbw244l+V@gardel-login>
 <20211018150550.GA29993@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018150550.GA29993@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mo, 18.10.21 17:05, Christoph Hellwig (hch@lst.de) wrote:

> On Mon, Oct 18, 2021 at 04:19:20PM +0200, Lennart Poettering wrote:
> > A brief answer like "yes, please, enable by default" would already
> > make me happy.
>
> I thikn enabling it by default is a good idea.  The only good use
> case I can think of for using buffered I/O is when the image has
> a smaller block size than supported on the host file.

Excellent! Thanks for the answer!

Lennart

--
Lennart Poettering, Berlin
