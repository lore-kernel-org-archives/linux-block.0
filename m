Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67BBFA3741
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 00:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKAAyQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 20:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKAAyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 20:54:16 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA0F21
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 17:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MGowF6BaVuI+i6PnbZUi1C2P4RLaCnWorDzqRCWMsHU=; b=aStRy0aTus7eBLbvCtoH/yGuTO
        lIq0T2O5GfMRFqY3Vm3OrdanzDOguPsJ1AXfuo72en2lApIzcqMwnXlunoW3FK1mSRu2OA74X67gz
        IMP/5s/43wE9ba4mmVCfdrj94Hl83IZSF0ElVE+T/D43n2R7RgDp9ljs3lTYwf1ZsGkQ0s29V/OeL
        6nKoPu5jbWCkAD8EQXbH+PscxW7VSdIVkWHLYTxHfe4bw7Fnb9FzRuGtF/HZfEE3LFXYUIIWJGTaN
        xgg4qgfikBCZ5mdCHoMLM0OuYuoDJW6KgtdLXsRkT5Lil2miXmdYzbxPxdbKRz0GOlP4VecoKQ/t2
        OhTz+8ng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1opfXh-00Gpba-0Q;
        Tue, 01 Nov 2022 00:54:13 +0000
Date:   Tue, 1 Nov 2022 00:54:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: UAF in blk_add_rq_to_plug()?
Message-ID: <Y2BuNekc14t35SpO@ZenIV>
References: <Y2BIad98er4QsbZY@ZenIV>
 <1a46585b-878b-a3b7-3090-36bddba86dbd@kernel.dk>
 <Y2BbvIdYGM/4L66H@ZenIV>
 <8ae6352c-7880-b51c-004c-06835858a349@kernel.dk>
 <67fa977f-a490-4201-f56b-1e20d37c3863@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67fa977f-a490-4201-f56b-1e20d37c3863@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 31, 2022 at 06:06:34PM -0600, Jens Axboe wrote:

> >> Am I missing something subtle here?  It's been a long time since
> >> I've read through that area - as the matter of fact, I'm trying
> >> to refresh my memories of the bio_submit()-related code paths
> >> at the moment...
> > 
> > With blk-mq, which all drivers are these days, the request memory is
> > statically allocated when the driver is setup. I'm not denying that you
> > could very well have issued AND completed the request which 'last'
> > points to by the time we dereference it, but that won't be a UAF unless
> > the device has also been quiesced and removed in between. Which I guess
> > could indeed be a possibility since it is by definition on a different
> > queue (->multiple_queues would be true, however, but that's also what
> > would be required to reach that far into that statement).
> > 
> > This is different from the older days of a request being literally freed
> > when it completes, which is what I initially reacted to.

Got it (and my memories of struct request lifetime rules had been stale,
indeed).  

> > As mentioned in the original reply, I do think we should just clear
> > 'last' as you suggest. But it's not something we've seen on the FB fleet
> > of servers, even with the majority of hosts running this code (and on
> > VMs).
> 
> Forgot to ask - do you want to send a patch for that, or do you just
> want me to cook one up with a reported-by for you?

You mean, try and put together a commit message for that one-liner? ;-)

[PATCH] blk_add_rq_to_plug(): 'last' is stale after flush, if we end up doing one

blk_mq_flush_plug_list() empties ->mq_list and request we'd peeked there
before that call is gone; in any case, we are not dealing with a mix
of requests for different queues now - there's no requests left in the
plug.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..a0e044a645b3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1257,6 +1257,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 		   (!blk_queue_nomerges(rq->q) &&
 		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
 		blk_mq_flush_plug_list(plug, false);
+		last = NULL;
 		trace_block_plug(rq->q);
 	}
 
