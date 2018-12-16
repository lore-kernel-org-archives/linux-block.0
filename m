Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63539C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8CE2082F
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeLPQqV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:46:21 -0500
Received: from verein.lst.de ([213.95.11.211]:57958 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbeLPQqV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:46:21 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9071068DD3; Sun, 16 Dec 2018 17:46:20 +0100 (CET)
Date:   Sun, 16 Dec 2018 17:46:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de, jmoyer@redhat.com, clm@fb.com
Subject: Re: [PATCH 12/26] aio: abstract out io_event filler helper
Message-ID: <20181216164620.GB14281@lst.de>
References: <20181213175645.22181-1-axboe@kernel.dk> <20181213175645.22181-13-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213175645.22181-13-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 10:56:31AM -0700, Jens Axboe wrote:
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
