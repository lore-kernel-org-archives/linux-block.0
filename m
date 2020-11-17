Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37BAC2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 16:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57ED221F8
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 16:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VN4pFUyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgKQQLK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:11:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbgKQQLJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Nov 2020 11:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605629468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ty0piOqP3uWEyX4doTunEiMBz0nVw//TvJV0Jd8m6io=;
        b=VN4pFUyX4cWbMVbPjFZSLnd+23MElbDzS7vPdmuWOljrgV5S9cnrONxzVqflBZorutNBXo
        TW/R5vGbcG0yy5ksLNGOBdkeVQw6+Qie397A4Ov3YVVoI8OC/YSZ1urbeXZhcqgvT5tZzw
        +DA5XiG0QBtFkDp2XKkW0ylsbKTe9CI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-6WDa9stpNEeWZxsCn66_Yw-1; Tue, 17 Nov 2020 11:11:04 -0500
X-MC-Unique: 6WDa9stpNEeWZxsCn66_Yw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CD841054F8A;
        Tue, 17 Nov 2020 16:11:03 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01E091001901;
        Tue, 17 Nov 2020 16:10:59 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:10:59 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 5/6] dm: simplify flush_bio initialization in
 __send_empty_flush
Message-ID: <20201117161059.GA27209@redhat.com>
References: <20201116212020.1099154-1-hch@lst.de>
 <20201116212020.1099154-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116212020.1099154-6-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 16 2020 at  4:20pm -0500,
Christoph Hellwig <hch@lst.de> wrote:

> We don't really need the struct block_device to initialize a bio.  So
> switch from using bio_set_dev to manually setting up bi_disk (bi_partno
> will always be zero and has been cleared by bio_init already).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

