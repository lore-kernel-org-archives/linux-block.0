Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE44C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 12:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C4620855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 12:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfAQMCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:02:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:55592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbfAQMCX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 07:02:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC68DAF96;
        Thu, 17 Jan 2019 12:02:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Jan 2019 13:02:21 +0100
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
Message-ID: <362738449bd3f83d18cb1056acc9b875@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On 2019-01-16 18:49, Jens Axboe wrote:

[...]

> +static void *io_mem_alloc(size_t size)
> +{
> +	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP 
> |
> +				__GFP_NORETRY;
> +
> +	return (void *) __get_free_pages(gfp_flags, get_order(size));

Since these pages are shared between kernel and userspace, do we need
to care about d-cache aliasing on armv6 (or other "strange" archs
which I've never seen) with vivt or vipt cpu caches?

E.g. vmalloc_user() targets this problem by aligning kernel address
on SHMLBA, so no flush_dcache_page() is required.

--
Roman
