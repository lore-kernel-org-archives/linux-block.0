Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7AEC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342FF60F9C
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhJYHbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhJYHbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 03:31:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D267AC061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 00:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+hfq0egDz2nr/GIJKdKWWifl/5Ec/xGVN1LVDDRQx3A=; b=1K6+L77Jk9AuEM9sD3oZRVL6rV
        kOC7+wUWjCPgTlC6aCAGxkjr9eV1IccsVcIuYoODLut+MrQKLMvT6/++ALhMcH+zcfSWPlRI8+nGT
        m3Qj4lGaUXqfkvZZCx8b60oWEVzyApwN957FY2200ujgC+aYauEldjKDl8qPzJgcIwyLGjJ6DaaI7
        rrzHehrBpB5JFNbfuNmA8DZG5lDUA1uo9+fTRAGIbw9PM6IkR1RqcAQcJmg6a8YJXjjkLonbnYsdX
        eNYFNOxx7nsFs3eroKM/iGSKDZoghTOdR6HYF/x1SgHCKujgncAbCkEd+yoOPEaCr9l6URmK6ieWv
        s21TPLIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1meuPX-00FclP-FM; Mon, 25 Oct 2021 07:28:47 +0000
Date:   Mon, 25 Oct 2021 00:28:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/5] block optimisations
Message-ID: <YXZcr8Asu31RKgRN@infradead.org>
References: <cover.1635006010.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1635006010.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 23, 2021 at 05:21:31PM +0100, Pavel Begunkov wrote:
> I don't find a good way how to deduplicate __blkdev_direct_IO_async(),
> there are small differences in implementation. If that's fine I'd
> suggest to do it afterwards, anyway I want to brush up
> __blkdev_direct_IO(), e.g. remove effectively unnecessary DIO_MULTI_BIO
> flag.

If we add another code path we should at last drop the DIO_MULTI_BIO
code to keep the complexity down in that function.
