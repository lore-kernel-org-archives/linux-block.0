Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE855C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 14:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983A32082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 14:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983A32082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeLDOud (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:50:33 -0500
Received: from verein.lst.de ([213.95.11.211]:44232 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeLDOud (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 09:50:33 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 771AF68BDB; Tue,  4 Dec 2018 15:50:32 +0100 (CET)
Date:   Tue, 4 Dec 2018 15:50:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 12/27] aio: use iocb_put() instead of open coding it
Message-ID: <20181204145032.GG3180@lst.de>
References: <20181130165646.27341-1-axboe@kernel.dk> <20181130165646.27341-13-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130165646.27341-13-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 09:56:31AM -0700, Jens Axboe wrote:
> Replace the percpu_ref_put() + kmem_cache_free() with a call to
> iocb_put() instead.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
