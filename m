Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <44670077-46FF-44C0-85DD-CA52BE2EB2E6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0691E170-358F-4621-A68C-36C254281512";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 02/11] block: add definition for support data write life
 times
Date: Tue, 13 Jun 2017 13:07:39 -0600
In-Reply-To: <1497374123-15286-3-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-3-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_0691E170-358F-4621-A68C-36C254281512
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> include/linux/blk_types.h | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 1940876a7fa7..16c4e657807f 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -314,6 +314,19 @@ struct blk_rq_stat {
> 	u64 batch;
> };
> 
> +/*
> + * Data life time definitions for writes. These are relative within a
> + * given device, no absolute meaning is attached to them.
> + */
> +enum {
> +	WRITE_LIFE_UNKNOWN	= 0,
> +	WRITE_LIFE_SHORT,
> +	WRITE_LIFE_MEDIUM,
> +	WRITE_LIFE_LONG,
> +	WRITE_LIFE_EXTREME,
> +	WRITE_LIFE_NR,
> +};

With the exception of these enums, there is actually enough space in the
various structures to pass at least a 4-bit stream ID through the whole
stack (actually, a full 32-bit stream ID, except for the debugfs stats).

I'm not necessarily against having some pre-defined meanings for these
values, but with a few trivial changes to the code it would be possible
to make this functionality much more flexible.

Comments inline on each of the patches where this matters.

Cheers, Andreas

> +
> static inline void bio_set_streamid(struct bio *bio, unsigned int stream)
> {
> 	bio->bi_stream = stream;
> --
> 2.7.4
> 


Cheers, Andreas






--Apple-Mail=_0691E170-358F-4621-A68C-36C254281512
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQDf7pIg59Q01vtYRAjxpAJ9nKd8nhwuGyzimHdkz1r9ntYBWrACgl+VO
o4hgmRNk7eSq2vVYKcQRSrw=
=t4Is
-----END PGP SIGNATURE-----

--Apple-Mail=_0691E170-358F-4621-A68C-36C254281512--
