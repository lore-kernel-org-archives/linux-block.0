Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD5EC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 16:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ACD20883
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 16:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ocmxM37r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfAIQAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:00:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfAIQAj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 11:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UPk/iOLLC9p85oXAeIrHHGKs3Rd56l4gyA6SUo9cARY=; b=ocmxM37ryHGqbAafSdYhU9ikT
        UEZiGtoZ0EbAu3oqKYqAn5AVZsNW+0ioLFkp4WsnmWMdXSn8RSLVy3ULQKyIZY07famDqRtGl5q0b
        duT8aQruQiqFIwZvNCEid85HBZeIc9v1sGqFMuTofTBno2YSJZONXx+MXk00CYt1BDzYGx5HzvtT2
        sVsfnh9V/PrBbmKc1JFf5Jp5J1wokj/3GzeKXpojIrNZImkEB0Yv89ELolEK5ZtS8++IJ21HSpj3G
        I7sXpUyzQ4cUlePMRIn6j8DeHxKn7Aad1OoZ4A3AEvsLUJTPAytP/X8fenXyHNFcNbzBHUcOsupEz
        zeb4EIrNg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghGHU-0000WJ-Rv; Wed, 09 Jan 2019 16:00:36 +0000
Date:   Wed, 9 Jan 2019 08:00:36 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCHSET v1] io_uring IO interface
Message-ID: <20190109160036.GK6310@bombadil.infradead.org>
References: <20190108165645.19311-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 08, 2019 at 09:56:29AM -0700, Jens Axboe wrote:
> After some arm twisting from Christoph, I finally caved and divorced the
> aio-poll patches from aio/libaio itself. The io_uring interface itself
> is useful and efficient, and after rebasing all the new goodies on top
> of that, there was little reason to retail the aio connection.
> 
> Hence io_uring was born. This is what I previously called scqring for
> aio, but now as a standalone entity. Patch #5 adds the core of this
> interface, but in short, it has two main data structures:

Please can we call it something that looks a little less like io_urine?
aio_ring?  io_ring?  ring_io?
