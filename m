Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FDFC282D0
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 06:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A6B20989
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 06:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfA2Gaq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:30:46 -0500
Received: from verein.lst.de ([213.95.11.211]:44313 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfA2Gaq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 01:30:46 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1B5F868CEB; Tue, 29 Jan 2019 07:30:44 +0100 (CET)
Date:   Tue, 29 Jan 2019 07:30:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH 05/18] Add io_uring IO interface
Message-ID: <20190129063043.GC2996@lst.de>
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-6-axboe@kernel.dk> <20190128145700.GA9795@lst.de> <2729ab43-b2bf-44b0-d41d-dbb495ddffbf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2729ab43-b2bf-44b0-d41d-dbb495ddffbf@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 11:25:12AM -0700, Jens Axboe wrote:
> > Especially with poll support now in the series, don't we need a ѕigmask
> > argument similar to pselect/ppoll/io_pgetevents now to deal with signal
> > blocking during waiting for events?
> 
> Is there any way to avoid passing in the sigset_t size? If it's just a
> 32-bit/64-bit thing, surely the in_compat_syscall() could cover it? Or
> are there other cases that need to be catered to?

As far as I can tell we never look at it, never looked at it and don't
have any plans to look at it anytime soon.  But when I tried to omit
it for io_pgetevents I got stong pushback and thus had to add the
crazy double indirection calling convention.
