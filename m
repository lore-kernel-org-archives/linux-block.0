Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F070C433DF
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 09:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EBB20738
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 09:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgH0Joe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:44:34 -0400
Received: from verein.lst.de ([213.95.11.211]:37529 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgH0Joe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 05:44:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 583E768B02; Thu, 27 Aug 2020 11:44:32 +0200 (CEST)
Date:   Thu, 27 Aug 2020 11:44:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] block: Remove blk_mq_attempt_merge() function
Message-ID: <20200827094432.GB16058@lst.de>
References: <cover.1597727255.git.baolin.wang@linux.alibaba.com> <5fa8de665d398cf49fd7c70fb427bb066556c764.1597727255.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa8de665d398cf49fd7c70fb427bb066556c764.1597727255.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18, 2020 at 01:45:30PM +0800, Baolin Wang wrote:
> The small blk_mq_attempt_merge() function is only called by
> __blk_mq_sched_bio_merge(), just open code it.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
