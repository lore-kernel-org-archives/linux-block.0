Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AD6C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 06:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA12F208DB
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 06:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgE0GFi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 02:05:38 -0400
Received: from verein.lst.de ([213.95.11.211]:48429 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0GFi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 02:05:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 468D568B02; Wed, 27 May 2020 08:05:35 +0200 (CEST)
Date:   Wed, 27 May 2020 08:05:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 5/6] blk-mq: add blk_mq_all_tag_iter
Message-ID: <20200527060535.GA17957@lst.de>
References: <20200520170635.2094101-1-hch@lst.de> <20200520170635.2094101-6-hch@lst.de> <a9b8686b-e3f8-bbd9-7dc8-fc55bd9b7f14@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b8686b-e3f8-bbd9-7dc8-fc55bd9b7f14@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 20, 2020 at 01:24:02PM -0700, Bart Van Assche wrote:
> Adding /*reserved=*/ and /*iterate_all=*/ comments in front of the
> boolean arguments would make this code easier to read.

Actually, flags values would be much more understandable, and allow to
consolidate more code.  I've switched the implementation over to that.
