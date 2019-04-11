Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEF1C10F14
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A412083E
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N8RybsO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDKPQ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:16:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKPQ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 11:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wKwOB2Ybr11LBtm3jrfN2/fyf8u2LIsDBXeKa1OaB6Y=; b=N8RybsO6f87GSHpBr05VzzJoP
        taDOAdbhX/tpk3SfRLizZOCqfTomZiAAlnyEi876B2M7iTly+WFPudAI4hvsp21upDJ+5o62FSaqp
        /ShB9p77sfCoJUBO3RnzlMA54Iua2cgn/afrrUHbsC6ycWLTrrRJLF6829A0iICGDtTBodqsrnUDI
        FVVl0txToogKJQT4Y7gvOsmot09up/74vGKkWYm2mshfPXUWqZE1DUdBGmaRu17QDxsW5evWi0N7E
        6tC1yj5Ov9wK3FCAu0eD/fP1vKBty7mcxK0C/+4rYIqWEDst4BUvEhN5EHimJ04Gc/HIctZ5howl8
        Izn29MA+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEbRi-0004J6-2b; Thu, 11 Apr 2019 15:16:58 +0000
Date:   Thu, 11 Apr 2019 08:16:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        hch@infradead.org, clm@fb.com
Subject: Re: [PATCHSET 0/3] io_uring: add sync_file_range and drains
Message-ID: <20190411151657.GD22763@bombadil.infradead.org>
References: <20190411150657.18480-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411150657.18480-1-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 11, 2019 at 09:06:54AM -0600, Jens Axboe wrote:
> In continuation of the fsync barrier patch from the other day, I
> reworked that patch to turn it into a general primitive instead. This
> means that any command can be flagged with IOSQE_IO_DRAIN, which will
> insert a sequence point in the queue. If a request is marked with
> IOSQE_IO_DRAIN, then previous commands must complete before this one
> is issued. Subsequent requests are not started until the drain has
> completed. The latter is a necessity since we track this through the
> CQ index. If we allow later commands, then they could complete before
> earlier commands and we'd mistakenly think that we have satisfied the
> sequence point.

That's potentially going to cause quite the bubble in the pipeline of
commands being sent.

Do consumers know which writes they are going to want to fence?  We could
do something like tag each command with a stream ID and then fence a
particular stream.  We'd need one nr_pending counter per stream, but
that should be pretty cheap.
