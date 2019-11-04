Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4991CA9EC9
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 22:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A11E2080F
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 22:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572907843;
	bh=blrlGH0qI5gvz+1heHUFs1cOEGXBwHEvYJn89j0vnUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ioe2faZDN477NLaa0blpZ1x3rcnR7UId7vi+n3RhDoweB/3M4X26EvTuSMsONfu9d
	 pc9QRl6MLfq2n7zn7CA+pFZj6+6gpykrw6RCStUoxEiUXk5nO+3zmtAPU140zwPALk
	 stVUhFCuprlbLa1UcKbW7Ob0WjZ/ln7l9J1L5B7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfKDWun (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:50:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbfKDWun (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 17:50:43 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7AD520663;
        Mon,  4 Nov 2019 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572907842;
        bh=blrlGH0qI5gvz+1heHUFs1cOEGXBwHEvYJn89j0vnUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huCk8sHm80qTZkGgr7JPRbDtCGzrQAguxCD4UQl40CWBPDuMKAO2d8hX4C0WDxu31
         Tlsd50uMuRnDmTA9vOX90fZs54Iwef9ntqAXGjT//vMvvXTUriWl20wsFXU7v1SJSe
         QC9kxQ9lX616F6SzZXcubDw64hxZcknCsrTXIq1w=
Date:   Tue, 5 Nov 2019 07:50:36 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: avoid blk_bio_segment_split for small I/O
 operations
Message-ID: <20191104225036.GA21282@redsun51.ssa.fujisawa.hgst.com>
References: <20191104180543.23123-1-hch@lst.de>
 <20191104193002.GA21075@redsun51.ssa.fujisawa.hgst.com>
 <f1050949-31b1-a9cf-02d6-00c94f505290@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1050949-31b1-a9cf-02d6-00c94f505290@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 04, 2019 at 01:13:53PM -0700, Jens Axboe wrote:
> > If the device advertises a chunk boundary and this small IO happens to
> > cross it, skipping the split is going to harm performance.
> 
> Does anyone do that, that isn't the first gen intel weirdness? Honest question,
> but always seemed to me that this spec addition was driven entirely by that
> one device.

There are at least 3 generations of Intel DC P-series that use this,
maybe more. I'm not sure if any other available vendor devices report
this feature, though.
 
> And if they do, do they align on non-4k?

All existing ones I'm aware of are 128k, so 4k aligned, but if the LBA
format is 512B, you could start a 4k IO at a 126k offset to straddle the
boundary. Hm, maybe we don't care about the split penalty in that case
since unaligned access is already going to be slower for other reasons ...
