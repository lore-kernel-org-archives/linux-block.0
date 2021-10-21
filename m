Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419BDC433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 07:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A306109F
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 07:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhJUHfU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 03:35:20 -0400
Received: from verein.lst.de ([213.95.11.211]:45206 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhJUHfR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 03:35:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F06B368BEB; Thu, 21 Oct 2021 09:33:00 +0200 (CEST)
Date:   Thu, 21 Oct 2021 09:33:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     axboe@kernel.dk, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] scsi: bsg: fix errno when scsi_bsg_register_queue
 fails
Message-ID: <20211021073300.GB29460@lst.de>
References: <20211021071344.1600362-1-liu.yun@linux.dev> <20211021071344.1600362-2-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021071344.1600362-2-liu.yun@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
