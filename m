Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E945C07E96
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 05:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052E76197F
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 05:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhGFF53 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 01:57:29 -0400
Received: from verein.lst.de ([213.95.11.211]:59223 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhGFF53 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 01:57:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 19B5168BEB; Tue,  6 Jul 2021 07:54:47 +0200 (CEST)
Date:   Tue, 6 Jul 2021 07:54:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH 4/6] loop: improve loop_process_work
Message-ID: <20210706055447.GA18621@lst.de>
References: <20210705102607.127810-1-ming.lei@redhat.com> <20210705102607.127810-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705102607.127810-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 05, 2021 at 06:26:05PM +0800, Ming Lei wrote:
> Avoid to acquire the spinlock for handling every loop command, and hold
> lock once for taking all commands.

I think the proper answer is to stop using this badly reimplement workqueue
that can't even get basic things right.
