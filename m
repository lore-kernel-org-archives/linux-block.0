Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A410CC433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 19:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D97E61181
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 19:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhJVTJC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbhJVTIz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 15:08:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B623CC061766;
        Fri, 22 Oct 2021 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=czZn4VgqgqNJZ5Ppv/JT4RKi26ol2gC5wRXk/+FQiV8=; b=pggwe4kTbZvPnmJLNjyp+NhKxp
        sMZBaZ1QWGY9jcKawWjPON02h7ERgshn8veGx2RRHV7Ar3Pg1OUhQLJhpljtLQMmn//nyoQU3CL9E
        lgf3W0Ep7sW4SA6hN1mmuj2sJj0uuD/8OGS9Dh075xzzyAuwY1G9LgslFCOEafGKQ7MKUAK0iuhMS
        ylWeDgCopcyFaxMrGpKvKoO1/K5sLWW0E30CXHJUd1+A4ddp9p+pEcxUIYY1mvZiQ+2Pu1bod5uSH
        vdb39+JYmlvEHvk0g5BDxVATI+0FPZPFSwdrXMag419rZY9v3z0pfDBf86L7KP3kAYMPIaJygsbBh
        6jnfoCjQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdzsC-00BoDf-LG; Fri, 22 Oct 2021 19:06:36 +0000
Date:   Fri, 22 Oct 2021 12:06:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/4] zram: replace fsync_bdev with sync_blockdev
Message-ID: <YXMLvK6U4uPba/oL@bombadil.infradead.org>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
 <20211020015548.2374568-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020015548.2374568-5-ming.lei@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 09:55:48AM +0800, Ming Lei wrote:
> When calling fsync_bdev(), zram driver guarantees that the bdev won't be
> opened by anyone, then there can't be one active fs/superblock over the
> zram bdev, so replace fsync_bdev with sync_blockdev.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
