Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AB1C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 06:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B3320989
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 06:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfA2G1r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:27:47 -0500
Received: from verein.lst.de ([213.95.11.211]:44276 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbfA2G1r (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 01:27:47 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A780068CEB; Tue, 29 Jan 2019 07:27:42 +0100 (CET)
Date:   Tue, 29 Jan 2019 07:27:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
Message-ID: <20190129062742.GA2996@lst.de>
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-9-axboe@kernel.dk> <20190128150240.GA10110@lst.de> <faca4aec-bf73-bece-6509-46137c7b7b44@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faca4aec-bf73-bece-6509-46137c7b7b44@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 09:46:17AM -0700, Jens Axboe wrote:
> I think that can go both ways. If we create it early, it'll just be a
> pointless helper. Don't really care too much about this particular case.

Without the no-op locking fix we don't really need the current
__io_cqring_add_event anymore, so we'd still have two somewhat
reasonably defined helpers.
