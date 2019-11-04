Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C1CA9EC9
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 22:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CF920663
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 22:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfKDW5j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:57:39 -0500
Received: from verein.lst.de ([213.95.11.211]:41762 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbfKDW5j (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 17:57:39 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A4B768BE1; Mon,  4 Nov 2019 23:57:36 +0100 (CET)
Date:   Mon, 4 Nov 2019 23:57:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: avoid blk_bio_segment_split for small I/O
 operations
Message-ID: <20191104225736.GA25569@lst.de>
References: <20191104180543.23123-1-hch@lst.de> <20191104193002.GA21075@redsun51.ssa.fujisawa.hgst.com> <f1050949-31b1-a9cf-02d6-00c94f505290@kernel.dk> <20191104225036.GA21282@redsun51.ssa.fujisawa.hgst.com> <2822bfe1-5d9d-ec87-9607-36617e528985@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2822bfe1-5d9d-ec87-9607-36617e528985@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 04, 2019 at 03:55:41PM -0700, Jens Axboe wrote:
> > All existing ones I'm aware of are 128k, so 4k aligned, but if the LBA
> > format is 512B, you could start a 4k IO at a 126k offset to straddle the
> > boundary. Hm, maybe we don't care about the split penalty in that case
> > since unaligned access is already going to be slower for other reasons ...
> 
> Yeah, not sure that's a huge concern for that particular case. If you
> think it's a real world issue, it should be possible to set aside a
> queue bit for this and always have them hit the slower split path.

Well, we use that field for zoned devices also, in which case it is an
issue.  I think I'll need to send a patch to skip the fast path if
we have chunk_sectors set.
