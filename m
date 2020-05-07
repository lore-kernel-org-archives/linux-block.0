Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCBFC38A2A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 14:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D2D2075E
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 14:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oFLCsUUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEGORA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 10:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgEGORA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 10:17:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FB7C05BD43
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qaC2F6MLhtVP7Lf25I61/roMu6XuvtMXGQk5GKBz7VY=; b=oFLCsUUtu5B4VGPiH4XuN8oHtp
        qr0XIDj0lSp7I/OqpgCxKSU7EGqNalJ0Qcrg4HYo1djMJc5x8az9WQOTAVgA0WkIVnBqc4Nu8JE9w
        yjibqecvdW/XOsH4ecU3mOGma+HHPnKx9p0h2D+vgJ+aKQM7U1+zZYT8TIjaqVJcMYzwnGwOiUh6h
        K1WZ0nGvl6kk3Vx8DsZW1hkBewQj6hJjavm6AphWkEdMHhhBHr68NZZC39cH3bXNy7MhQcWD+uS/R
        cJyLwzns/jNHpYb0CB1CIYhuDesuJYMnKc8WBOGN9BBw2hcrxrs2sL/7kdWOzTCVY6KeNUOHvsCZL
        GgKn6/hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWhKd-0002Dm-FQ; Thu, 07 May 2020 14:16:59 +0000
Date:   Thu, 7 May 2020 07:16:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 3/4] block: re-organize fields of 'struct hd_part'
Message-ID: <20200507141659.GC11551@infradead.org>
References: <20200507085239.1354854-1-ming.lei@redhat.com>
 <20200507085239.1354854-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507085239.1354854-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 04:52:38PM +0800, Ming Lei wrote:
> Put all fields accessed in IO path together at the beginning
> of the struct, so that all can be fetched in single cacheline.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
