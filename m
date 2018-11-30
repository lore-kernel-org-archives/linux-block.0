Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0D8C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 19:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5554C2082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 19:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5554C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbeLAG2G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:28:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51030 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeLAG2G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 01:28:06 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gSoIN-00089p-CW; Fri, 30 Nov 2018 19:17:47 +0000
Date:   Fri, 30 Nov 2018 19:17:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 26/27] iov_iter: add import_kvec()
Message-ID: <20181130191747.GO2217@ZenIV.linux.org.uk>
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-27-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130165646.27341-27-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 09:56:45AM -0700, Jens Axboe wrote:
> This explicitly sets up an ITER_KVEC from an iovec with kernel ranges
> mapped.

> +int import_kvec(int type, const struct kvec *kvecs, unsigned nr_segs,
> +		size_t bytes, struct iov_iter *iter)
> +{
> +	const struct iovec *p = (const struct iovec *) kvecs;
> +
> +	iov_iter_init_type(iter, ITER_KVEC, type, p, nr_segs, bytes);
> +	return 0;
> +}

What the hell is wrong with existing iov_iter_kvec()?
