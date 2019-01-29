Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432E6C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 06:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4312177E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 06:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfA2Gpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:45:50 -0500
Received: from verein.lst.de ([213.95.11.211]:44355 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfA2Gpu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 01:45:50 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4A35D68CEB; Tue, 29 Jan 2019 07:45:48 +0100 (CET)
Date:   Tue, 29 Jan 2019 07:45:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
Message-ID: <20190129064548.GA3280@lst.de>
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-6-axboe@kernel.dk> <20190128145700.GA9795@lst.de> <CALCETrV30uN2qOUEf+kNGWdphBtps7K3rEk8_8+VAwdtPomRkQ@mail.gmail.com> <dab3fa32-3887-3264-9fe1-bc3b7abc58b3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dab3fa32-3887-3264-9fe1-bc3b7abc58b3@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 06:20:08PM -0700, Jens Axboe wrote:
> Sure, that would be straight forward. Is there a strong reason to do
> so outside of "that would be nice"? It's not like it's a huge amount
> of code.

And it would be really painful for userspace.  Because now you
can't pass struct iovec through from a higher level, but will instead
of to copy the iovec to a different type in the submission path.
