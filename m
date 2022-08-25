Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CD7C3F6B0
	for <linux-block@archiver.kernel.org>; Thu, 25 Aug 2022 12:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiHYM7I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHYM7H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 08:59:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05CD94EF3
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 05:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2398B82919
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 12:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3911FC433D6;
        Thu, 25 Aug 2022 12:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661432343;
        bh=5pWdd8f26d74KDWS8IJTLZHkjbt5RJK/BhPhPvHf8cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9bl3rCASakMqKUh32ZKkkVXIVsBG6v0cnH5ZI3r2Eu4cDhd0X3n2g/t4D4Sd/Zdh
         PduBhjX0uWRZsvKtrR7w5yRdCkZ0my8UoMWdbtIcIKdHmm9pFAY/8asR8i2ad4bbEq
         T7BB8hlpEoNz2LR8zjveISbDyoqZydPwux3OlIeM56vVfTWv3guTAejjbd/j7rjrBl
         TFN4YZZxVge8waUvKTzkJMnAWDdH3tz2kMpLufjpwA1bxflvpV1VM+fqMIkSVKL19a
         1OCCwcmgTV74p8c0JBJPh9PqMjRli7dsUFGLoqgPskPx/P6Bi9Oi993wLzxlV0TkwG
         tHMSqurjp7I0g==
Date:   Thu, 25 Aug 2022 06:59:00 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Keith Busch <kbusch@fb.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCHv2] sbitmap: fix batched wait_cnt accounting
Message-ID: <YwdyFLxBHDXzbg3P@kbusch-mbp.dhcp.thefacebook.com>
References: <20220824201440.127782-1-kbusch@fb.com>
 <bda24921-8fcb-8e22-6685-2614ce1bec5f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda24921-8fcb-8e22-6685-2614ce1bec5f@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 25, 2022 at 08:09:50AM +0200, Hannes Reinecke wrote:
> > +static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
> 
> Why is '*nr' a pointer? It's always used as a value, so what does promoting
> it to a point buys you?

Not quite, see below:
 
> >   {
> >   	struct sbq_wait_state *ws;
> > -	unsigned int wake_batch;
> > -	int wait_cnt;
> > +	int wake_batch, wait_cnt, sub, cur;
> >   	ws = sbq_wake_ptr(sbq);
> >   	if (!ws)
> >   		return false;
> > -	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> > +	wake_batch = READ_ONCE(sbq->wake_batch);
> > +	do {
> > +		cur = atomic_read(&ws->wait_cnt);
> > +		sub = min3(wake_batch, *nr, cur);
> > +		wait_cnt = cur - sub;
> > +	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
> > +
> > +	*nr -= sub;

Dereferenced here to account for how many bits were considered for this wake
cycle.
