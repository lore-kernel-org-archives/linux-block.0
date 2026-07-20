Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE74396567;
	Mon, 20 Jul 2026 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574748; cv=none; b=TQEyb1Y69C/f1UhIxUfj/BglHE8mwY/NSer2LV1bREOTvj+HOoo2zj6uh5QTlJpxQknMJvlBVUwYZT+gt8mhJP+NbxoLoMlDE/jglZclt9DTG6bF79jUpk/iQBAkPRI6DPaB/9GYbkxevQ16uS4HvXQU57KQb/2WlG/MgePITIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574748; c=relaxed/simple;
	bh=6wAJ8lls2nHYZWpUcNoYiQO0OgthprAJyJpEdFdQpyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLY9PpEAg3/Bxses2XCb9qUVNV4xxCjRri/Zij6TGPh/OnzAC+ulBueYpBnmuaeITGIvFBtZKJExguFBip2+flQZzGc80kIAk6BkHJSbpByeUiQShOn+NXiQ0MRSMGbTxqwAWbrcwCNV3MxjunTQb7Mc/bWCThniTi+ghV4UAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=aOlzgJ8K; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="aOlzgJ8K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1784574736; x=1785179536; i=laurent@vivier.eu;
	bh=WmWPDRHLZ19Elg/gGVg/Cr+rZRjCUgTa+XUFLemJEgI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aOlzgJ8KoxJ2DS2y7aJejSgLT4lb766fTGPWPAtdHMn7PTumOtwsrjGPUjHFULcQ
	 /oRDedM8rskPhdkJTgbFEHtzXtwp6e1Fz39wun472NFxIona/qtn4nKL3MzmkgQVS
	 OzAPUS8LgNN6yQMaaNF7t/qWe12Z/pyK0TOjMVYZjqSsewTd8lG0t+Wm3azKm6SZK
	 LsbBhb0VryArS1vVc6zWctBay2B4HQ9VcbP1nEQ2lvevgiB8I4tPkcd+VwFnd/Zee
	 8PVIxouMuAka9TF3Yefimx2YBMaea7Pejybwrw1hoE8yo6IMZv8JyUaTvjsD0ySev
	 3ztHY8VQcNwSl+tpwA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1N33AR-1x9JUb2xXJ-00ud2w; Mon, 20
 Jul 2026 21:12:16 +0200
Message-ID: <dea3f394-7640-4554-bd0a-0d9cd50e4fea@vivier.eu>
Date: Mon, 20 Jul 2026 21:12:16 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/31] swim: Recalibrate when drive is probed
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <c6a525e6f5bf4cf93c69535a68be842a95b902db.1784196135.git.fthain@linux-m68k.org>
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
In-Reply-To: <c6a525e6f5bf4cf93c69535a68be842a95b902db.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FKtMtVMxMO7fy9ph9gAbc9b1Xl5m5RhrT1Qm05uP3HBgE3+X3xf
 8ymfDa8UF7TqpVyQF+bwYXOOuAfKLzcAbnOgHPQhvNcSt9tGgsewKDdy7mYbLoBtdQVCm5w
 o3b/4uWOg8Lg3W5PpGfbOTAy4f8w97krRPDh3GTOdw/MMU2ilrLJFyaLdBvQ3pmtgsgyzct
 Fn9E/o/ggiC2Esw7x9JFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AYVwARixytU=;zCW5xwcmyPFeVcaiFRdXxmz0Gq2
 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
 =

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> Track zero recalibration can be slow and is normally done only once i.e.
> during system POST or boot-up. Recalibrate once after the drive is probe=
d
> rather than every time the device is opened. Don't register the drive if
> recalibration fails. Move the heads to the edge of the disk before
> ejecting so that recalibration happens quickly.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 03a89916d4ed..76f6cfa68432 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -412,6 +412,7 @@ static inline int swim_track00(struct swim __iomem *=
base)
>   	if (swim_readbit(base, TRACK_ZERO))
>   		return 0;
>  =20
> +	pr_err("swim: track zero recalibration failed\n");
>   	return -1;
>   }
>  =20
> @@ -456,6 +457,7 @@ static int floppy_eject(struct floppy_state *fs)
>   	struct swim __iomem *base =3D fs->swd->base;
>  =20
>   	swim_drive(base, fs->location);
> +	swim_track(fs, 1);
>   	swim_motor(base, OFF);
>   	swim_eject(base);
>   	swim_drive(base, NO_DRIVE);
> @@ -596,13 +598,6 @@ static void setup_medium(struct floppy_state *fs)
>   		struct floppy_struct *g;
>   		fs->disk_in =3D 1;
>   		fs->write_protected =3D swim_readbit(base, WRITE_PROT);
> -
> -		if (swim_track00(base))
> -			printk(KERN_ERR
> -				"SWIM: cannot move floppy head to track 0\n");
> -
> -		swim_track00(base);
> -
>   		fs->type =3D swim_readbit(base, TWOMEG_MEDIA) ?
>   			HD_MEDIA : DD_MEDIA;
>   		fs->head_number =3D swim_readbit(base, SINGLE_SIDED) ? 1 : 2;
> @@ -610,7 +605,6 @@ static void setup_medium(struct floppy_state *fs)
>   		fs->total_secs =3D g->size;
>   		fs->secpercyl =3D g->head * g->sect;
>   		fs->secpertrack =3D g->sect;
> -		fs->track =3D 0;
>   	} else {
>   		fs->disk_in =3D 0;
>   	}
> @@ -773,6 +767,7 @@ static int swim_add_floppy(struct swim_priv *swd, en=
um drive_location location)
>  =20
>   	fs->ref_count =3D 0;
>   	fs->ejected =3D 1;
> +	fs->track =3D 0;
>  =20
>   	swd->floppy_count++;
>  =20
> @@ -827,11 +822,11 @@ static int swim_floppy_init(struct platform_device=
 *pdev)
>  =20
>   	swim_drive(base, INTERNAL_DRIVE);
>   	if (swim_readbit(base, DRIVE_PRESENT) &&
> -	    !swim_readbit(base, ONEMEG_DRIVE))
> +	    !swim_readbit(base, ONEMEG_DRIVE) && !swim_track00(base))
>   		swim_add_floppy(swd, INTERNAL_DRIVE);
>   	swim_drive(base, EXTERNAL_DRIVE);
>   	if (swim_readbit(base, DRIVE_PRESENT) &&
> -	    !swim_readbit(base, ONEMEG_DRIVE))
> +	    !swim_readbit(base, ONEMEG_DRIVE) && !swim_track00(base))
>   		swim_add_floppy(swd, EXTERNAL_DRIVE);
>   	swim_drive(base, NO_DRIVE);
>  =20

