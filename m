Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02C2459EA;
	Sun, 26 Jul 2026 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785081678; cv=none; b=Q3AIvdK5w+rElrznbvJL7asLfWxXjvewbPhhaeipBgfQKd1F9phSLrrbCPrfxpDdjfcxuGA/bfYpIuNWOQt/FfuODyrVS4JCMHbN/7wWsX9iy9qIOike35+WbPm8OdwkkrlAgMCvLvvTnc5ixbh+czpk4h80BkY/lVeh/G3npAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785081678; c=relaxed/simple;
	bh=LG4NBulOfhVDIbKT4ZYNgS5L+v8Z1HW9Ybf53gys5bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHzd+eBYZyliCnE8VzGMo8cwQajq2vSbdOEFtAKMr/ZMcP7q2qa0UnMRTMbXWEpLueGBhonOx+BHNYvK+/EmEhtTTXzTfwb592O/GpUnlcZJAQwve1EMdnzO2e3XaGp0C47yz01fFK1Kgqe1U7U0vYGfWyP9puhY2HKxxNcumkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=zekX67lX; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="zekX67lX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785081669; x=1785686469; i=laurent@vivier.eu;
	bh=j0VIoPnu00Ui+69dGy9DoF8+QPsjkXApg3Vr1A1Bbig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=zekX67lXW+mVb/PFdi1kCNxlCAPpmIXsbFvHxlLKCEThOa1Stad7abd5gqPPldIC
	 aMQx9mPaWtPCOzSN1G+BBC+GLVuZPKE5n0vVV8T7gLW73pTuUVgQh7npsWJI0CMBm
	 UuSnERHp0J8Ajy6a+9wcugVR3mCSUjJTdunY7IprKnDUX/h9aXyZ9gZ/dtVBPchYt
	 MCNek6SKAkYq4PbUm5X3qhEcujZlFcRUes0WKCrd4+aqLhZIbCfsSZPrsejcIEHn9
	 xX2f28Kr2AAyK0BO4wWninYEnSUqT7/h9/tdhENATQ/RbAkAutjLcAIolyqGankw+
	 LI4Bfse7M3iBe6jvyA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1N18I8-1wydA71h9O-015P2e; Sun, 26
 Jul 2026 18:01:09 +0200
Message-ID: <34364739-9153-4538-aed3-7c71860bdf08@vivier.eu>
Date: Sun, 26 Jul 2026 18:01:08 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/31] swim: Don't needlessly re-read sectors
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <740e314f4ff30796afa466c6a3d8cfa42e9b1af8.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+wsF4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +c7BTQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAcLBXwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
In-Reply-To: <740e314f4ff30796afa466c6a3d8cfa42e9b1af8.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2aNvs9EF5G+RiPsHTxKCAHT86yO3D910Rq+12Ic1DS0nO7wlU4l
 V5+imRhWJNyCP9VsdXYGNzCXLFXf/LVCjoRfhLsCWmJP9dIxGwYjAnFYGXj3G1Lh+5V6qyU
 we6WvXcc0APRXFmE6BWCuhwmz+sd7ZHwQWDgZ8A03NlafrYcHv4BeHxswHb4/ocYi4XM5Ao
 NUZPiQwBYOzFRpqwHEj7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C70VQ9f9Yxw=;Hbz1CkvBrXegcam+hAZUrpHYc/W
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> floppy_read_sectors() is confusing because variable names seem to confla=
te
> tracks and cylinders. Rename the track variable, eliminate a division
> operation and adopt suitable integer types.
>=20
> For readahead to work effectively, small sequential reads should not
> require waiting for spindle rotation. Unfortunately, the present algorit=
hm
> is very inefficient and does a lot of unnecessary waiting.
>=20
> E.g. if the device is asked to read sectors 1 thru 18, and if sector 9
> happens to be under the heads, the driver will proceed to read sectors 9
> thru 18, but discard the results, while it waits for sector 1 to arrive.
>=20
> If sector 1 couldn't be read on the first attempt, and needs a retry, th=
e
> driver will proceed to read sectors 2 thru 18, but discard the results,
> while it waits for sector 1 to come around again.
>=20
> In between reading sector 1 and sector 2, the driver needlessly calls
> swim_track() and swim_head() again. But what's worse is that, on a 68030
> system, re-enabling interrupts after each sector read can result in a fu=
ll
> rotation between sectors (that is a 3 ms wait).
>=20
> Floppy drivers often implement a track cache, that can be filled in a
> single rotation, to solve problems like these. But I think this solution
> is much simpler.
>=20
> For each request, use a sector bitmap to keep a record of sectors read
> successfully. Read or retry, as necessary, the requested sectors in
> whatever sequence they arrive in. Keep interrupts disabled until the
> whole track has passed under the read head.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 91 +++++++++++++++++++++++++-------------------
>   1 file changed, 52 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 0bab7ed3daa8..dae401e649d7 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -180,9 +180,9 @@ struct floppy_state {
>   	enum media_type	 type;
>   	int		 write_protected;
>  =20
> -	int		 total_secs;
> -	int		 secpercyl;
> -	int		 secpertrack;
> +	unsigned int	 total_secs;
> +	unsigned int	 secpercyl;
> +	unsigned int	 secpertrack;
>  =20
>   	/* in-use information */
>  =20
> @@ -455,68 +455,81 @@ static int floppy_eject(struct floppy_state *fs)
>   	return 0;
>   }
>  =20
> -static inline int swim_read_sector(struct floppy_state *fs,
> -				   int side, int track,
> -				   int sector, unsigned char *buffer)
> +static unsigned int swim_read_sector_range(struct floppy_state *fs,
> +					unsigned int side, unsigned int track,
> +					unsigned int start, unsigned int count,
> +					unsigned char *buffer)
>   {
>   	struct swim __iomem *base =3D fs->swd->base;
>   	unsigned long flags;
>   	struct sector_header header;
> -	int ret =3D -1;
> -	short i;
> +	int i, bits =3D 0;
>  =20
> -	swim_track(fs, track);
> -	swim_head(base, side);
> +	for (i =3D 0; i < 18; i++) { /* A track has at most 18 sectors */
> +		if (i >=3D count)
> +			break;
> +		bits |=3D BIT(i);
> +	}
>  =20
>   	local_irq_save(flags);
>   	for (i =3D 0; i < 36; i++) {
> +		if (bits =3D=3D 0) /* All count sectors were read ok */
> +			break;
> +
>   		if (swim_read_sector_header(base, &header) ||
>   		    swim_read(base, error) || header.track !=3D track ||
>   		    header.side !=3D side || header.size !=3D 2)
>   			continue;
> -		if (header.sector =3D=3D sector) {
> -			/* found */
>  =20
> -			ret =3D swim_read_sector_data(base, buffer);
> -			if (swim_read(base, error))
> -				ret =3D -EIO;
> -			break;
> +		if (header.sector >=3D start && header.sector < start + count) {
> +			unsigned int offset =3D header.sector - start;
> +			int ret;
> +
> +			if ((bits & BIT(offset)) =3D=3D 0)
> +				continue; /* This sector was already read ok */
> +
> +			ret =3D swim_read_sector_data(base, buffer + 512 * offset);
> +			if (ret =3D=3D 512 && swim_read(base, error) =3D=3D 0)
> +				bits &=3D ~BIT(offset);
>   		}
>   	}
>   	local_irq_restore(flags);
>  =20
> -	return ret;
> +	return bits ? ffs(bits) - 1 : count; /* No. of contiguous ok sectors *=
/
>   }
>  =20
>   static blk_status_t floppy_read_sectors(struct floppy_state *fs,
> -			       int req_sector, int sectors_nb,
> -			       unsigned char *buffer)
> +					unsigned int req_sector,
> +					unsigned int sectors_nb,
> +					unsigned char *buffer)
>   {
>   	struct swim __iomem *base =3D fs->swd->base;
> -	int ret;
> -	int side, track, sector;
> -	int i, try;
> -
> +	unsigned int failures =3D 0;
>  =20
>   	swim_drive(base, fs->location);
>   	swim_READY_timeout(base);
>  =20
> -	for (i =3D req_sector; i < req_sector + sectors_nb; i++) {
> -		int x;
> -		track =3D i / fs->secpercyl;
> -		x =3D i % fs->secpercyl;
> -		side =3D x / fs->secpertrack;
> -		sector =3D x % fs->secpertrack + 1;
> -
> -		try =3D 5;
> -		do {
> -			ret =3D swim_read_sector(fs, side, track, sector,
> -						buffer);
> -			if (try-- =3D=3D 0)
> -				return BLK_STS_IOERR;
> -		} while (ret !=3D 512);
> -
> -		buffer +=3D ret;
> +	while (sectors_nb) {
> +		unsigned int cyl, x, head, sector, n, ret;
> +
> +		cyl =3D req_sector / fs->secpercyl;
> +		x =3D req_sector % fs->secpercyl;
> +		head =3D (x >=3D fs->secpertrack) ? 1 : 0;
> +		sector =3D x % fs->secpertrack;
> +		n =3D min(sectors_nb, fs->secpertrack - sector);
> +
> +		swim_track(fs, cyl);
> +		swim_head(base, head);
> +
> +		ret =3D swim_read_sector_range(fs, head, cyl, sector + 1, n, buffer);
> +		if (ret !=3D n)
> +			++failures;
> +		if (failures >=3D 5)
> +			return BLK_STS_IOERR;

Old code failed after 5 retries on the same sector, new code fails after 5=
 incomplete ranges=20
anywhere in it, even if earlier errors were recovered and request made pro=
gress.

Is this what you want?

Thanks,
Laurent

> +
> +		buffer +=3D 512 * ret;
> +		sectors_nb -=3D ret;
> +		req_sector +=3D ret;
>   	}
>  =20
>   	return 0;

