Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D506C43444
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 15:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B4F2070B
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 15:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeLNPnh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:43:37 -0500
Received: from verein.lst.de ([213.95.11.211]:48230 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbeLNPnh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 10:43:37 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BCD2A68DF1; Fri, 14 Dec 2018 16:43:35 +0100 (CET)
Date:   Fri, 14 Dec 2018 16:43:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 2/6] block: make request_to_qc_t public
Message-ID: <20181214154335.GA24417@lst.de>
References: <20181213213410.9841-1-sagi@grimberg.me> <20181213213410.9841-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213213410.9841-3-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 01:34:06PM -0800, Sagi Grimberg wrote:
> block consumers will need it for polling requests that
> are sent with blk_execute_rq_nowait. Also, get rid of
> blk_tag_to_qc_t and open-code it instead.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
