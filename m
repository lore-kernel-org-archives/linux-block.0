Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF7FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0CE61151
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 17:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhJORfG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhJORfF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 13:35:05 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C96EC061570
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q+cpk68oP20LmU/hEqaOAEyM+jw7UMCxtprUI16/t30=; b=SVy+I1SNP6Qy7iIIUpbnRmwrFo
        Wsr+EsgP/bMEqczrdd8cauZ6qxjIpeb+ItdebXA/oC8nOa2c2+j3B5b0q6IoMwa9pWD+/Q2YJuzdP
        PeeJo3hVBh5RZcf/h6waPdlqkNz9MmBhdv+PBzuwOltoES2szdcBsrzNqW9HY/WjtlP5LgTBuitvw
        tzh7X3fqsHA7Jt6t8CCuAQkabjfClumOOafDhJOulyZO5BexknFoeLcJnfcAQb9urxTA/8GKYpInM
        wraJWbChWZ1hGxG6IxHhPOMnn8RD1F0ir4+A+GAP2dwRCwLwPmVCxzbPY+yHTCr+4+Cu2hmScYkKd
        KBE+O7SQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbR4k-008LB6-6m; Fri, 15 Oct 2021 17:32:58 +0000
Date:   Fri, 15 Oct 2021 10:32:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/3] zram: fix two races
Message-ID: <YWm7SkL4TZXTw/a3@bombadil.infradead.org>
References: <20211015121652.2024287-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015121652.2024287-1-ming.lei@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 15, 2021 at 08:16:49PM +0800, Ming Lei wrote:
> Hello,
> 
> Fixes the following two issues reported by Luis Chamberlain by simpler
> approach, meantime it is sort of simplification of handling resetting/removing
> device vs. open().
> 
> - zram leak during unloading module, which is one race between resetting
> and removing device
> 
> - zram resource leak in case that disksize_store is done after resetting
> and before deleting gendisk in zram_remove()

As noted in the other thread, unfortunately this is not enough, and can
leave the driver in a bad state. So either more work is needed or my
alternative patch can be considered. But I do understand the desire to
avoid the mutex on removal, if we can do that great.

  Luis
