Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A37C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B0E21907
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfBGWMv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:12:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBGWMv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 17:12:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7639C0495BB;
        Thu,  7 Feb 2019 22:12:50 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCA1C600D7;
        Thu,  7 Feb 2019 22:12:49 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        jannh@google.com, viro@ZenIV.linux.org.uk
Subject: Re: [PATCH 16/18] io_uring: add support for IORING_OP_POLL
References: <20190207195552.22770-1-axboe@kernel.dk>
        <20190207195552.22770-17-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 07 Feb 2019 17:12:49 -0500
In-Reply-To: <20190207195552.22770-17-axboe@kernel.dk> (Jens Axboe's message
        of "Thu, 7 Feb 2019 12:55:50 -0700")
Message-ID: <x497eeb5jtq.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 07 Feb 2019 22:12:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Jens,

> +static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> +{

[...]

> +	/* one for removal from waitqueue, one for this function */
> +	refcount_set(&req->refs, 2);
> +
> +	mask = vfs_poll(poll->file, &ipt.pt) & poll->events;
> +	if (unlikely(!poll->head)) {
> +		/* we did not manage to set up a waitqueue, done */
> +		goto out;
> +	}
> +
> +	spin_lock_irq(&ctx->completion_lock);
> +	spin_lock(&poll->head->lock);
> +	if (poll->woken) {
> +		/* wake_up context handles the rest */
> +		mask = 0;
> +		ipt.error = 0;
> +	} else if (mask || ipt.error) {
> +		/* if we get an error or a mask we are done */
> +		WARN_ON_ONCE(list_empty(&poll->wait.entry));
> +		list_del_init(&poll->wait.entry);
> +	} else {
> +		/* actually waiting for an event */
> +		list_add_tail(&req->list, &ctx->cancel_list);
> +	}
> +	spin_unlock(&poll->head->lock);
> +	spin_unlock_irq(&ctx->completion_lock);
> +
> +out:
> +	if (unlikely(ipt.error)) {
> +		if (!(flags & IOSQE_FIXED_FILE))
> +			fput(poll->file);
> +		return ipt.error;
> +	}

You need to drop the reference count on the req inside that if block.

-Jeff

> +
> +	if (mask)
> +		io_poll_complete(req, mask);
> +	io_free_req(req);
> +	return 0;
> +}
