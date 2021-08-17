Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64055C4338F
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 04:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5F960F41
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 04:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhHQEx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 00:53:29 -0400
Received: from verein.lst.de ([213.95.11.211]:57022 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhHQEx3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 00:53:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 680206736F; Tue, 17 Aug 2021 06:52:55 +0200 (CEST)
Date:   Tue, 17 Aug 2021 06:52:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/7] lib/group_cpus: allow to group cpus in case of
 !CONFIG_SMP
Message-ID: <20210817045255.GF3874@lst.de>
References: <20210814123532.229494-1-ming.lei@redhat.com> <20210814123532.229494-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814123532.229494-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 14, 2021 at 08:35:31PM +0800, Ming Lei wrote:
> Allows group_cpus_evenly() to be called in case of !CONFIG_SMP by simply
> assigning all CPUs into the 1st group.

Looks good, but almost too large for an inline function.
