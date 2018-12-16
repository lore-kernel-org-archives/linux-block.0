Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC4EC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074592082F
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeLPQMA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:12:00 -0500
Received: from verein.lst.de ([213.95.11.211]:57787 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbeLPQMA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:12:00 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3A2F268DD3; Sun, 16 Dec 2018 17:11:59 +0100 (CET)
Date:   Sun, 16 Dec 2018 17:11:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] nvme-pci: correct mapping for poll queue(s)
Message-ID: <20181216161159.GB9957@lst.de>
References: <20181216022517.26650-1-ming.lei@redhat.com> <20181216022517.26650-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216022517.26650-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 16, 2018 at 10:25:14AM +0800, Ming Lei wrote:
> If we don't have poll queue, its mapping should share default type's,
> instead of setting up one new mapping via blk_mq_map_queues().

No, if we don't have poll queues nr_maps should be 2.  I've already
posted a patch for that for nvme-pci which got it wrong (my fault..)
