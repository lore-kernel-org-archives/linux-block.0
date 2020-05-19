Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1776EC433DF
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01FE20809
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgESPV3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 11:21:29 -0400
Received: from verein.lst.de ([213.95.11.211]:44553 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgESPV3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 11:21:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3A9768B02; Tue, 19 May 2020 17:21:26 +0200 (CEST)
Date:   Tue, 19 May 2020 17:21:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 3/4] block: Document the bio_vec properties
Message-ID: <20200519152126.GA22286@lst.de>
References: <20200519040737.4531-1-bvanassche@acm.org> <20200519040737.4531-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519040737.4531-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 18, 2020 at 09:07:36PM -0700, Bart Van Assche wrote:
> Since it is nontrivial that nth_page() does not have to be used for a
> bio_vec, document this.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
