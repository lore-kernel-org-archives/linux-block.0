Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD766C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 14:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B765F20880
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 14:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfA1ObL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:31:11 -0500
Received: from verein.lst.de ([213.95.11.211]:39964 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfA1ObL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 09:31:11 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D371B68DCF; Mon, 28 Jan 2019 15:31:09 +0100 (CET)
Date:   Mon, 28 Jan 2019 15:31:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com
Subject: Re: [PATCH 11/18] block: implement bio helper to add iter bvec
 pages to bio
Message-ID: <20190128143109.GD9563@lst.de>
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-16-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123153536.7081-16-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +#define BIO_HOLD_PAGES	0	/* don't put O_DIRECT pages */

They don't really have to be O_DIRECT pages, just something with
a permanent reference.  Maybe rename this to something BIO_NO_PAGE_REF?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
