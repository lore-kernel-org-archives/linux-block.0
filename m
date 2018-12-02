Return-Path: <SRS0=EAuX=OL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376A5C64EB4
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 07:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFEE20834
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 07:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF3TVDQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFEE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbeLBHcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:32:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbeLBHcT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 2 Dec 2018 02:32:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F4582080A;
        Sun,  2 Dec 2018 07:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543735937;
        bh=uR5cT35/qVoRfN4cVh1k5IQOJj+JYBU84/oumy/tbAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jF3TVDQUJy7lXP+2DtYO0znY847fAB1P+NMgLIRFkD3NMioGxSRQHHKQNYZViOzOc
         DBZlLN7CSBNiHz5oYUsJ4zVTj8hD/YFaaOlYnJYpAuT5FsMOXLM8gPddIXLM26hgzP
         mTe3X70FyIOxCe76gnFjQ1ZJ2/sK2qiHgVUln2qA=
Date:   Sun, 2 Dec 2018 08:32:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] block: fix single range discard merge
Message-ID: <20181202073214.GB31761@kroah.com>
References: <20181130163818.6540-1-ming.lei@redhat.com>
 <1543598309.4347.5.camel@acm.org>
 <9ebec24a-103c-2ea8-49e1-2f927eb8a4f8@kernel.dk>
 <1543599056.4347.11.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543599056.4347.11.camel@acm.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 09:30:56AM -0800, Bart Van Assche wrote:
> On Fri, 2018-11-30 at 10:20 -0700, Jens Axboe wrote:
> > On 11/30/18 10:18 AM, Bart Van Assche wrote:
> > > On Sat, 2018-12-01 at 00:38 +0800, Ming Lei wrote:
> > > > Fixes: 445251d0f4d329a ("blk-mq: fix discard merge with scheduler attached")
> > > 
> > > Since this patch fixes a bug introduced in kernel v4.16, does it need
> > > a "Cc: stable" tag?
> > 
> > Like the other one, isn't stable implied with Fixes in there? You'd want
> > a stable backport for any kernel that has that patchset. I think that's
> > a stronger hint than stable cc.
> 
> (+Greg KH)
> 
> Hi Greg,
> 
> Would it be possible to clarify what your preferences are for adding a
> "Cc: stable" tag?

Doesn't:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
describe it well enough?

Hint, putting a "Fixes:" only tag on a patch is nice, but will not
guarantee it will end up in the stable tree.  Only a "Cc: stable@..."
tag will.  Putting both on, if you know the fixes commit, is the best.

thanks,

greg k-h
