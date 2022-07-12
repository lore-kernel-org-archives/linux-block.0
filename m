Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17CEC43334
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 06:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiGLGcv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 02:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGLGcu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 02:32:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569D3DE9C;
        Mon, 11 Jul 2022 23:32:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A00468AA6; Tue, 12 Jul 2022 08:32:45 +0200 (CEST)
Date:   Tue, 12 Jul 2022 08:32:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, asml.silence@gmail.com,
        joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH for-next 2/4] nvme: compact nvme_uring_cmd_pdu struct
Message-ID: <20220712063245.GA5908@lst.de>
References: <20220711110155.649153-1-joshi.k@samsung.com> <CGME20220711110812epcas5p33aa90b23aa62fb11722aa8195754becf@epcas5p3.samsung.com> <20220711110155.649153-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711110155.649153-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 11, 2022 at 04:31:53PM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Mark this packed so that we can create bit more space in its container
> i.e. io_uring_cmd. This is in preparation to support multipathing on
> uring-passthrough.
> Move its definition to nvme.h as well.

I do not like this.  packed structures that contain pointers are
inherently dangerous as that will get us into unaligned accesses
very quickly.  I also do not think we should expose it any more widely
than absolutely required.

In fact if possible I'd really like to figure out how we can remove
this pdu concept entirely an just have a small number of well typed
field directly in the uring cmd.  This will involved some rework
of the passthrough I/O completions so that we can get at the
metadata biovecs and integrity data.
