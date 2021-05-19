Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791A0C433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED6261244
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbhESH6Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 03:58:24 -0400
Received: from verein.lst.de ([213.95.11.211]:37157 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234405AbhESH6Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 03:58:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1202A67373; Wed, 19 May 2021 09:57:03 +0200 (CEST)
Date:   Wed, 19 May 2021 09:57:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org, jasowang@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] virtio-blk: limit seg_max to a safe value
Message-ID: <20210519075702.GA4225@lst.de>
References: <20210518150415.152730-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518150415.152730-1-stefanha@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 18, 2021 at 04:04:15PM +0100, Stefan Hajnoczi wrote:
> +	/* Prevent integer overflows and excessive blk-mq req cmd_size */
> +	sg_elems = min_t(u32, sg_elems, SG_MAX_SEGMENTS);

Please pick your own constant here instead of abusing some kernel
implementation detail (that is fairly SCSI specific to start with).

It might be useful to also document such limits, even if just advisory,
in the virtio spec.
