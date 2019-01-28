Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F705C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D3C2148E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfA1Vxk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:53:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfA1Vxk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:53:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C488C074EE2;
        Mon, 28 Jan 2019 21:53:40 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C1AC5C6B8;
        Mon, 28 Jan 2019 21:53:39 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
        avi@scylladb.com
Subject: Re: [PATCH 05/18] Add io_uring IO interface
References: <20190128213538.13486-1-axboe@kernel.dk>
        <20190128213538.13486-6-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 28 Jan 2019 16:53:38 -0500
In-Reply-To: <20190128213538.13486-6-axboe@kernel.dk> (Jens Axboe's message of
        "Mon, 28 Jan 2019 14:35:25 -0700")
Message-ID: <x498sz4wisd.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 28 Jan 2019 21:53:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> +static int __io_uring_enter(struct io_ring_ctx *ctx, unsigned to_submit,
> +			    unsigned min_complete, unsigned flags,
> +			    const sigset_t __user *sig, size_t sigsz)
> +{
> +	int submitted, ret;
> +
> +	submitted = ret = 0;
> +	if (to_submit) {
> +		submitted = io_ring_submit(ctx, to_submit);
> +		if (submitted < 0)
> +			return submitted;
> +	}
> +	if (flags & IORING_ENTER_GETEVENTS) {

Do we want to disallow any unsupported flags?

-Jeff
