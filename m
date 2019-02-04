Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD3AC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 23:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7DF2087C
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 23:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfBDXWu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:22:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfBDXWt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Feb 2019 18:22:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BABBCC058CBA;
        Mon,  4 Feb 2019 23:22:49 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4E93450F;
        Mon,  4 Feb 2019 23:22:48 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        jannh@google.com
Subject: Re: [PATCH 05/18] Add io_uring IO interface
References: <20190201152414.23296-1-axboe@kernel.dk>
        <20190201152414.23296-6-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 04 Feb 2019 18:22:48 -0500
In-Reply-To: <20190201152414.23296-6-axboe@kernel.dk> (Jens Axboe's message of
        "Fri, 1 Feb 2019 08:24:01 -0700")
Message-ID: <x49sgx3t9yv.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 04 Feb 2019 23:22:49 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Jens,

Jens Axboe <axboe@kernel.dk> writes:

> +static void io_ring_ctx_free(struct io_ring_ctx *ctx)
> +{
> +	destroy_workqueue(ctx->sqo_wq);

You need to make sure sqo_wq is non-null before calling
destroy_workqueue.

-Jeff
