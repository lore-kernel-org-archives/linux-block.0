Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376645;
	b=0rWEOD9D51AQKL2em8dXUPMziPXdUwphVMfznN6NVmFq0+qaLxWzEqpQPLxoIdWzTDXR
	 4/eKkrYwETyHpfewhg1M3yLBy4zEQoNHmwkSWNWDqzqpMN6UeWnLM9HOqMHOBVGsmJrHb
	 PYBpebBAJ42+dWEZZCGcyIuFY92z0xHYdWjh7JdUPpBMHfKu3C0RHJVklVKCW4TeTSllq
	 CmAOUywge7fR1A8xWZhmPLld8P866CwunPlTPp1CL4FtehX7LF/MC8otWqI3TvmegezdM
	 AhClLBwFUO25zsJqb5n+4hf0/4zUgZCp9Qswry4mGNftbhohK1eqtu7Jm2N7QXQqZrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376645;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=z02xL6rhzWs1+mp5ZR35iPApHnvpXIYD37Zbf7HihCk=;
	b=ClsDjAV4JRnxhAlidc26D09xVvPhkPojR0KE9C+nJivVFfqw3ib3DoeVsnYVYBTF0qGV
	 S9K/q80WSxRkmAfou3yRbx3yNxRW5wJvgdvMtPSqt7roDvSvkLaqGkX8fl3ApbN46irfI
	 La9N5XDzl+0OCwa+PZTnV7/qD9LVpaMBIlHcMSDp1D5RPC87JUL7dX2I5jUeH1+4N2YXW
	 MS0t7dpYSLiS9/dfHdViAU7QrNVDScmCPpEekgzShfgmE2nJVUo3VfCWBYCwiF7/8juPB
	 XYW9VEl788wDS2O7MtzA/t/UajwCI6f36qbkiV4okfzOL+rlBOQSYjxUj2GKEFqr/nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dPsD8zaz;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7624606A31A
	for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 19:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7624606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dPsD8zaz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795376643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z02xL6rhzWs1+mp5ZR35iPApHnvpXIYD37Zbf7HihCk=;
	b=dPsD8zazn/ZhhiwS5KqmSx7Loc8otjoiRoJBB+lV2u42nbhSj4x9i5ni38KWK2AeNfLxxT
	lR3Uvjw0al7PruC5pYWgfJwwRVH6lvTLDjA0m5h5MflNK4hKB0C9jK5e8uF9F6lznL5W7h
	bPeZtzZPrPfO60ODHau3nXHja/j6EBc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-17unz2fnOhWuvboYSM5Fww-1; Sun,
 22 Nov 2026 19:43:59 +0000
X-MC-Unique: 17unz2fnOhWuvboYSM5Fww-1
X-Mimecast-MFC-AGG-ID: 17unz2fnOhWuvboYSM5Fww_1795376637
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEAF81956064;
	Sun, 22 Nov 2026 19:43:56 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 480711800550;
	Sun, 22 Nov 2026 19:43:55 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6AMJhs8G2805339
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 14:43:54 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6AMJhrRd2805338;
	Sun, 22 Nov 2026 14:43:53 -0500
Date: Sun, 22 Nov 2026 14:43:53 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K . Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: stack max_user_discard_sectors
Message-ID: <awNF-dV2TacxpUqf@redhat.com>
References: <20261109193927.595104-1-bmarzins@redhat.com>
 <20261120154040.GB28611@lst.de>
 <awCi_9_Xykc_Mmk-@redhat.com>
 <20261121001334.GA13058@lst.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121001334.GA13058@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Nov 21, 2026 at 01:13:34AM +0100, Christoph Hellwig wrote:
> On Fri, Nov 20, 2026 at 02:43:59PM -0500, Benjamin Marzinski wrote:
> > > I don't think we should take the underlying max_user_discard_sectors
> > > into account here, just max_discard_sectors.
> > 
> > Is that to handle devices that call blk_queue_disable_discard()? I
> > didn't think about that. Makes sense.
> 
> That too.  But also because user limits on lower devices shouldn't
> really affect upper devices for consistency, as new updates on the
> lower device after the upper one was created don't get picked up
> either.

Um... Now it doesn't make sense again. 

If I do something like:

t->max_user_discard_sectors = min(t->max_user_discard_sectors,
                                  b->max_discard_sectors);

That mean that changes to underlying device user limits can effect upper
device user limits (since adjusting max_user_discard_sectors
via sysfs automatically adjusts max_discard_sectors).

Also, while this does make blk_stack_limits() disable discards on upper
devices that have a lower device that dissabled discards with
blk_queue_disable_discard(), it doesn't disable discards on upper
devices that have lower devices that have discards disabled normally
(since blk_validate_limits() sets discard_granularity to 0 for devices
that set max_discard_sectors to 0, and this part of blk_stack_limits()
only runs if the bottom device has discard_granularity != 0). That
seems wrong. So perhaps handling blk_queue_disable_discard() isn't the
right answer. Alternatively, blk_stack_limits() could disable discards
on upper device is any of the lower device has max_discard_sectors. But
I assume there's a good reason why it currently doesn't.

Additionally, if we use max_user_discard_sectors to clamp the upper
device's max_discard_sectors to the lower device's. It allows users to
just override it by changing max_user_discard_sectors to something that
doesn't work with the underlying device. That also seems wrong.

So what do you think about doing this instead:

t->max_hw_discard_sectors = min(t->max_hw_discard_sectors,
                                b->max_discard_sectors);

This doesn't handle blk_queue_disable_discard(), but like I said, the
other patch didn't handle it well either. It also keep users from being
able to send too large discards by setting max_user_discard_sectors too
high on stacked devices. I'll send a v2 that does this.

-Ben

