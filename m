Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED22C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 15:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346849AbiBKP5V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 10:57:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbiBKP5V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 10:57:21 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D1A1A8
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 07:57:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 76C0A68AFE; Fri, 11 Feb 2022 16:57:17 +0100 (CET)
Date:   Fri, 11 Feb 2022 16:57:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 3/3] block: partition include/linux/blk-cgroup.h
Message-ID: <20220211155717.GB4167@lst.de>
References: <20220211101149.2368042-1-ming.lei@redhat.com> <20220211101149.2368042-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211101149.2368042-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 11, 2022 at 06:11:49PM +0800, Ming Lei wrote:
> Partition include/linux/blk-cgroup.h into two parts: one is public part,
> the other is block layer private part.

I'd say split instead of partition, but the actual patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
