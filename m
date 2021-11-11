Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6F9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 06:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03F961212
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 06:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhKKGX7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 01:23:59 -0500
Received: from verein.lst.de ([213.95.11.211]:57121 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhKKGX4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 01:23:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2AE167373; Thu, 11 Nov 2021 07:21:05 +0100 (CET)
Date:   Thu, 11 Nov 2021 07:21:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, czhong@redhat.com
Subject: Re: [PATCH V2 1/1] block: avoid to touch unloaded module instance
 when opening bdev
Message-ID: <20211111062105.GA29362@lst.de>
References: <20211111020343.316126-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111020343.316126-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
