Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635D2C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 14:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5D82171F
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 14:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfA1O0T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:26:19 -0500
Received: from verein.lst.de ([213.95.11.211]:39918 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfA1O0T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 09:26:19 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7F49468DCF; Mon, 28 Jan 2019 15:26:18 +0100 (CET)
Date:   Mon, 28 Jan 2019 15:26:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com
Subject: Re: [PATCH 03/18] block: add bio_set_polled() helper
Message-ID: <20190128142618.GB9563@lst.de>
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123153536.7081-4-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 23, 2019 at 08:35:14AM -0700, Jens Axboe wrote:
> For the upcoming async polled IO, we can't sleep allocating requests.
> If we do, then we introduce a deadlock where the submitter already
> has async polled IO in-flight, but can't wait for them to complete
> since polled requests must be active found and reaped.
> 
> Utilize the helper in the blockdev DIRECT_IO code.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
