Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:51855 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdEBOpG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 May 2017 10:45:06 -0400
Date: Tue, 2 May 2017 07:45:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Treat REQ_FUA and REQ_PREFLUSH as synchronous
Message-ID: <20170502144505.GA29623@infradead.org>
References: <20170502102123.GE13916@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170502102123.GE13916@quack2.suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 02, 2017 at 12:21:23PM +0200, Jan Kara wrote:
> it makes sense to treat REQ_FUA and REQ_PREFLUSH ops as synchronous in
> op_is_sync() since callers cannot rely on this anyway... Thoughts?

I'm fine with treating them as sync.
