Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C77C43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 09:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32AB224F8
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 09:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfLEJwn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:52:43 -0500
Received: from verein.lst.de ([213.95.11.211]:54325 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbfLEJwn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Dec 2019 04:52:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A670668B05; Thu,  5 Dec 2019 10:52:40 +0100 (CET)
Date:   Thu, 5 Dec 2019 10:52:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Justin Tee <justin.tee@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: fix memleak of bio integrity data
Message-ID: <20191205095240.GA21803@lst.de>
References: <20191205020901.18737-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205020901.18737-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
