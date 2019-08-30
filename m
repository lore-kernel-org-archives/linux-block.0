Return-Path: <SRS0=imVF=W2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A127C3A59B
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 15:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2215023427
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 15:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uPARJ3or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfH3PuZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:50:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3PuZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 11:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jKLZ9AV4Cad35GVTWRj4qMk4Kj0vjxf5uuMYmkOMgQM=; b=uPARJ3orrGsiJB42mMqVRNTsi
        FtVgdPrcmYDIkLdtdrY4xxPet7vxfI/PykXneJ2pU0g6sa3nLsdJKYasFzWIR70lznoOyfa392xvu
        31OSlpr+tw6B3k3bid7RQ5aK8NMT75HZmZ7HFYh2ICUT7fkg//detK0CdHqpJ7edFi/k/dLahx4Df
        TcjIJ15HMTpO4r6qQawJE7fc3fk3wgL8pkWKSzizo3lmZKs00HchVxR6/nhXRQbA1PhGiUV9mXkvo
        Glw7gZOLpfDCmmfoDzyg1NXnBTJ8SH78miIfY+Jp/dfw2+nTK7V+vVz8WUoXommnSXw0cQ1R4sH+3
        SU8oEYHDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3jAO-0007o7-H4; Fri, 30 Aug 2019 15:50:24 +0000
Date:   Fri, 30 Aug 2019 08:50:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundatio.org,
        kernel-team@android.com, narayan@google.com, dariofreni@google.com,
        ioffe@google.com, jiyong@google.com, maco@google.com
Subject: Re: [PATCH] loop: change queue block size to match when using DIO.
Message-ID: <20190830155024.GA23882@infradead.org>
References: <20190828103229.191853-1-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828103229.191853-1-maco@android.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 28, 2019 at 12:32:29PM +0200, Martijn Coenen wrote:
> The loop driver assumes that if the passed in fd is opened with
> O_DIRECT, the caller wants to use direct I/O on the loop device.
> However, if the underlying filesystem has a different block size than
> the loop block queue, direct I/O can't be enabled. Instead of requiring
> userspace to manually change the blocksize and re-enable direct I/O,
> just change the queue block size to match.

Why can't we enable the block device in that case?  All the usual
block filesystems support 512 byte aligned direct I/O with a 4k
file system block size (as long as the underlying block device
sector size is also 512 bytes).
