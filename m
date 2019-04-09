Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85C6C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0402084C
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fz6LU0al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfDIJhb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:37:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfDIJha (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 05:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=op+L4NAIEip0r58yPjKmf3F8G9uO01A+HqsRyJmhuOk=; b=fz6LU0alZO7FY5Utkhh712m5n
        vLFvh0i40N94cWI4HjYxVK/+7ojT8bU5W3w8N6fuG3SMebYzAEP8CdzYQ/8dJYIYBPA36ebrnOgmq
        I7++msO2QV+8run0z2TO4JhWkJiDtrRILoCrNazz8/Hg6nYvhTf38+YsYfcE2yo/aNrfnCrLT73AF
        qPaQoYs/jmxDFjMhHYU2dpYfeD50KjglonTDz4QKon9otNgJzqCNblJrzJd4vaTFkJpHIYgXdFW+d
        h9S0Jpjx5jzE0cwuztGXrJNlua26EPVpAIxASJW1l1O0x43RF7Ti18iPbLh9TT4rIV6eURgGN5Fy1
        qplfJMChA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDnBt-00046Y-Nt; Tue, 09 Apr 2019 09:37:17 +0000
Date:   Tue, 9 Apr 2019 02:37:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] io_uring: introduce inline reqs for
 IORING_SETUP_IOPOLL
Message-ID: <20190409093717.GA15391@infradead.org>
References: <1554787314-27179-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554787314-27179-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 09, 2019 at 01:21:54PM +0800, Jianchao Wang wrote:
> For the IORING_SETUP_IOPOLL case, all of the submission and
> completion are handled under ctx->uring_lock or in SQ poll thread
> context, so io_get_req and io_put_req has been serialized well.
> The only exception is the asynchronous workqueue context where could
> free the io_kiocb for error. To overcome this, we allocate a new
> io_kiocb and free the previous inlined one.
> 
> Based on this, we introduce the preallocated reqs list per ctx and
> needn't to provide any lock to serialize the updating of list. The
> performacne benefits from this. The test result of following fio
> command

I really don't like the idea of exposing this to userspace.  Is
there any good reason to not simply always allocate inline request
up to a certain ring size?
