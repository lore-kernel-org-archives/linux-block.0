Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD1FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 10 Dec 2021 03:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhLJD4y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:56:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35894 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhLJD4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 22:56:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 501251F37E;
        Fri, 10 Dec 2021 03:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639108398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0Pj8MPY8xOhbLu5E4uoZoxX26RofVlQevXBp7C1QFw=;
        b=qz60UKWcV9Qpnmr3PxrRRaQs3gJXDTFuoatIZ1jJZj/1A7EURLcf3fIB7wxfrzxKGqD8wl
        b6vysP4oD6iKm35N9GcbLJmz97FrPMxH2aB2QgxBeM2cNhdM+dKoGbz/5XUgRHvnRUqWp1
        vuxuT6gglJWkrRdsSe8itjX+/cZ4Fbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639108398;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0Pj8MPY8xOhbLu5E4uoZoxX26RofVlQevXBp7C1QFw=;
        b=TYV6HFnWngETc0jluDyI4W93mST2L5P4qjByFmYJz8B/mP5ecThedYjx6rGlXm6FW+OP7x
        N8pzc3c8pKHxKRBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CD2513463;
        Fri, 10 Dec 2021 03:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7QSkNSzPsmHAQwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 10 Dec 2021 03:53:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Jens Axboe" <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktdvd: stop using bdi congestion framework.
In-reply-to: <YZTx/93/9cjYW4zI@infradead.org>
References: <163712340344.13692.2840899631949534137@noble.neil.brown.name>,
 <YZTx/93/9cjYW4zI@infradead.org>
Date:   Fri, 10 Dec 2021 14:53:14 +1100
Message-id: <163910839418.9928.16399258868028694519@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 17 Nov 2021, Christoph Hellwig wrote:
> > -		set_bdi_congested(bio->bi_bdev->bd_disk->bdi, BLK_RW_ASYNC);
> > -		do {
> > -			spin_unlock(&pd->lock);
> > -			congestion_wait(BLK_RW_ASYNC, HZ);
> > -			spin_lock(&pd->lock);
> > -		} while(pd->bio_queue_size > pd->write_congestion_off);
> > +		___wait_var_event(&pd->congested,
> > +				  pd->bio_queue_size <= pd->write_congestion_off,
> > +				  TASK_UNINTERRUPTIBLE, 0, 0,
> > +				  ({pd->congested = true;
> > +				    spin_unlock(&pd->lock);
> > +				    schedule();
> > +				    spin_lock(&pd->lock);
> > +				  })
> 
> I'd be tempted to open code the ___wait_var_event here as this is pretty
> unreadable.  But otherwise this change looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the review.  I'm comfortable with eiuther __wait_var_event()
or an open-coded version.  I'll follow-up with the latter.

Jens: I don't see this in linux-next.  Are you happy to take one version
or the other?

Thanks,
NeilBrown

