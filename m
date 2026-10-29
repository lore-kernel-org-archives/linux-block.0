Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793298640;
	b=MhSuOTCo+6f108QBigTM9PSG6oj8c0hCQdmkPw2rJ7oLtCcPEVwF0+IMvtmzBZMycVHT
	 uv64Q5sj1iNIASgFMlLaDlOoc4DsdMhRx+xACLJq2EQyC2q68su2X9H9+B2Mueetiedqq
	 +VLULVe57ucgy2BlDNhcSV1gB077C8zAdZ61UWaHBiRCtCD9JPPYJRlnONNDsEY7dF7cJ
	 yBgMmdu4bhf/DQUAJ0lPrpZsc2NweZt99f9vyURbUDPuwZXbwUfvHArUOv4AWsgw5nhA5
	 BMPbEk0+k8H1wtS+VdvB1gE505zEByJNtDlpFrPnNzc/fdv9r8AevziCJ/NcSF9T8QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298640;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7cXZTVE1hFKWPBgqy/0wFbFMZQKQUKo9lOQBzSZYXhw=;
	b=xGMoac1QlxnhUHlTzcY8nAoMqYQ1vYzEfnXAJjfFYdKN8C5CKAIw2ZjPnUL+YcXN5V7h
	 VgrCjcC4qhStFP65lWG6IY2gx8shpgCjlIKF2s7ZCO2UHwLAszK8n2dPpI2wRjF/bQnMU
	 aiY8XE8GnbzjW44CarmXWT/0KX7x/J6fy88n4iViMOr6JjLh+tiU8eZI5heLijggmAypx
	 g4Me4cTxhV5Bdr8Cl7fLbNAIqGfmf5MCt7cAWR7IdnNmEBfjGgBWkPnc40+U08Eh2Co5R
	 +dNT77t87OKTXnouhFm9WPZlHrWID0GqigfxgqI1A3ry8tFgUXx1yWEYDXuOmQ4GGrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kk7u19sg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90222606A31E
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kk7u19sg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6871F01816;
	Thu, 29 Oct 2026 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793298638;
	bh=7cXZTVE1hFKWPBgqy/0wFbFMZQKQUKo9lOQBzSZYXhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kk7u19sg9WHsEozZF/49jqPp6dOAxM8veCVAf/Q9rBZ/58TF3XIhHvzyGT0A9dJiY
	 ns97/5TDz9HyVq1VOfuQXab8TwxTEutPi/yi29SjpHmkC6kviDu+WUIMamFduYmUK4
	 SpsGj9oLonhIH51SBguUW7eOzMMUzoK4FLUqlySunba03XERlofONT19iyJO3cIdVA
	 dZREmhay54P382oXDVnGbWjYRvAwGbX4sfySYTZgajQjOPrXCMpQIuQwymHablNC2E
	 qv+75QgjNUS3isk07gUO+SMm/f1VGLa57Ugvr7ElaNTtxbzukAAfhJbi4jmsrb9sjF
	 Ew2WVr75bWaDw==
Date: Thu, 29 Oct 2026 11:30:33 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 09/98] blk-mq: end the request if getting a keyslot fails
Message-ID: <20261029183033.GF1862@quark>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-10-axboe@kernel.dk>
 <auNBSoa3vscdnr9_@infradead.org>
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
In-Reply-To: <auNBSoa3vscdnr9_@infradead.org>

On Thu, Oct 29, 2026 at 05:51:22AM -0700, Christoph Hellwig wrote:
> Adding Eric for the blk-crypto code.
> 
> On Wed, Oct 28, 2026 at 10:41:12AM -0600, Jens Axboe wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> > 
> > When blk_crypto_rq_get_keyslot() fails, blk_mq_submit_bio() ends the bio
> > by hand and frees the request. By then blk_mq_bio_to_request() has done
> > the IO accounting, which blk_mq_free_request() doesn't undo, so the
> > in_flight counter never drops and iostat shows a device that is 100%
> > busy. If the bio went through zone write plugging the zone stays plugged
> > as well, and every later write to it waits forever.
> > 
> > Use blk_mq_end_request() like the dispatch path does for a request the
> > driver rejected, after marking it for zone write plugging.
> > 
> > Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > ---
> >  block/blk-mq.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 7400f678258e..c91306f8156f 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -3195,8 +3195,9 @@ void blk_mq_submit_bio(struct bio *bio)
> >  
> >  	ret = blk_crypto_rq_get_keyslot(rq);
> >  	if (ret != BLK_STS_OK) {
> > -		bio_endio_status(bio, ret);
> > -		blk_mq_free_request(rq);
> > +		if (bio_zone_write_plugging(bio))
> > +			blk_zone_write_plug_init_request(rq);
> > +		blk_mq_end_request(rq, ret);
> 
> If blk_mq_end_request does the right thing (it looks like that to
> me, but I'd rather rely on Eric and Jens for that), we should
> reorder the blk_crypto_rq_get_keyslot and
> blk_zone_write_plug_init_request calls so that the extra copy
> of the blk_zone_write_plug_init_request call is not needed.

I don't know the blk-mq code super well.  But yes,
blk_zone_write_plug_init_request() has no dependency on the keyslot; in
particular the back-merging relies on crypt_ctx, not crypt_keyslot.  So
calling it before blk_crypto_rq_get_keyslot() would be simpler than
duplicating it in the success and failure cases.

And yes, blk_mq_end_request() doesn't assume blk_crypto_rq_get_keyslot()
has succeeded.  On failure crypt_keyslot just remains NULL.

Josef and Jens, what are your expectations about this patch?  Sending it
as part of a 98-patch series (that didn't get picked up by Sashiko) is
kind of awkward.  If you need help I'd be glad to send a revised version
as a standalone patch.  Or you can handle it: up to you.

- Eric
