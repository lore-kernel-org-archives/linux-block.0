Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003B4C43444
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 12:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC98A20859
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 12:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfAQMsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:48:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:37526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfAQMsS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 07:48:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5C4EAD7F;
        Thu, 17 Jan 2019 12:48:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Jan 2019 13:48:16 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
Subject: Re: [PATCH 05/15] Add io_uring IO interface
In-Reply-To: <20190116175003.17880-6-axboe@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
Message-ID: <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-01-16 18:49, Jens Axboe wrote:

[...]

> +static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
> +				  struct io_uring_params *p)
> +{
> +	struct io_sq_ring *sq_ring;
> +	struct io_cq_ring *cq_ring;
> +	size_t size;
> +	int ret;
> +
> +	sq_ring = io_mem_alloc(struct_size(sq_ring, array, p->sq_entries));

It seems that sq_entries, cq_entries are not limited at all.  Can nasty
app consume a lot of kernel pages calling io_setup_uring() from a loop
passing random entries number? (or even better: decreasing entries 
number,
in order to consume all pages orders with min number of loops).

--
Roman

