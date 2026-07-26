Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19593CB918;
	Sun, 26 Jul 2026 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080882; cv=none; b=d1i+lzhm4k3EYPM477L13j+nXrLamcXXpNUvt1r80xSivCJ6oavzpGkJxt6qMPXfmj6t75H9vM1nP/uN/uOgCRm9/+Kt3vmX67YnD9LVJLJc4QZ9XCBnyENAaf9m7YzqUTidwNLn0s6OWoCaDLl7Sos6V7E8grkZTBbghk6y1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080882; c=relaxed/simple;
	bh=m6DxSiIK9ZxpN/SQrQNbUND39ISaCovRCYXi9OruYfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hm+TgtgTYRytiidxWztpeP8EPlhErQ5Ovwn+3aLzLdNz4fAEXGQF+cR6FjLMUhvXwcbeQwlFKMsLGq3Q4nsZTUvw7uMGqZFKo0RBUE9PuSw/99ft0+rPXgy4gcKZBlD2jhOfFbwO2F+juQzmHbNGvGqi41g0yhHum29Kw3UxZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=BfvJJykU; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="BfvJJykU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785080873; x=1785685673; i=laurent@vivier.eu;
	bh=yLWqWlwL+SqsRubuhuRqLorhNRBwwIhoDqGUkKY18qs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BfvJJykU1qbLR8UmPtMxzi0aZfC6O/7XvrUb8Z0JkLbqa/UN9wz1uur0tPLT5A4J
	 4jTsGBja7zmiBpqvROVVvxF0+alI7SJAdNjQ2WbiB4Y9dVg0p6uHJlWAr1uzgVt7E
	 /2Gc+FO5B79qYpratz8BpVNaVSSQAtII7+aT4EkAjBUoW8ev1eOTpC+mleXJT5ujc
	 F5ZIS6/wNCYDOYKCI+Zz4w83wkGVnqm2kvgJnoMPQe3IgoFf/laFDn4l/KR2O+ZRQ
	 XLtnqIXcmeiTPjtC8aSi/8EDlUZ3yM9h4Clv+hWEj46hs/9rDJru1KScRXqGlsRg0
	 BINlHWUaF2MgxQxltg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1Mspu2-1x80u10F6O-0121WH; Sun, 26
 Jul 2026 17:47:53 +0200
Message-ID: <14cee4e9-bf7c-4bab-b769-8e464bf8f328@vivier.eu>
Date: Sun, 26 Jul 2026 17:47:52 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/31] swim: Define symbols for constants
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <c88ebe0f2d3d51bdab346451442b69b206845792.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <c88ebe0f2d3d51bdab346451442b69b206845792.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mHCb4BR9Kkp/IwgTlL7YawSOVnXcBh8XmDAZtlL8UnPqeVACrDT
 OLjlaU/HBGf17UVgzqPCzcU1NduidG86jZHzCXSylUGahIonjPWPm5HQ8PZrfP22UbS0I3K
 S5npNV8SVtye9ajqnSfSaPqxbCxOOkdyxX94KXQGwrAYZufCQo8Pu6XaRi6yGKqHa2R4ndh
 MwpMEeJnroI4Fzo0gUU/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6qs7nZDnudY=;VkUhKMHPGfYwzP+h7A9lHTQz0Ob
 NbT5Fqi+iTViXbBtqzpJK4UM4HY1SK++pNOtI9mIhtzvlBBp2x3PCcrHjE+aUgLA9UpY0yZLH
 od7E6ltw/NwvhH8TV9xaownurvNLkJ5auM8uueewpiQoW2Eo6/uDiEyBYp7xJczoPtccNOOjE
 BJb81dfS+DVuZujjhP2o8NIH75KWwKtR2NRQMEM1gQnc5MKNoJ5ABQ17ML4wFeqy2SLTSvukr
 m7ZasMbxH1v9a8J3qd+gFUFONBqacsPM8YPwIt7ezVVJiIMxu6JKvZUgIYUj9wmIUKG4G+4aK
 Xbkv3G+JIQEEQ8AyVPTCnVMk0S6qhu8TyEY+Op7r416Z5Gm0eSsaHodWIfNiDfMUyBai6/MmB
 aokzJdXGiA0L1EOnaLEuxMhZ0LGtoDu0zR27+KmC/Dm3F2w/svZZfKcQUDd8KXiYvv+zOR7HX
 VSupEHNrEMLNZwVE2nJKE75xSq9d/nzXxSbEdKi+JjPos0DJA1eGVLoHEtERdXWB+Qci8mbSw
 wFSq4yvNkhi+M38scJsuhPHJkoD64HV6plWyph3LKQy6/6drmKRhxtPsxGQuMwnYIl1uRkDDo
 KvkC8Ht0RR5CEy62rrMZ2j5XO9DG3Xwz0p27Az9qbET62WDKig/P9KohxSVvbBvv+lDH4DTI8
 oes1cSk2vSOclF+f2onbs8PTDCVwJsz/vrO4ZuKh9QHKU17SBArWNLHs3IQQz0tBNvF+CkIc4
 djbqFnJ3rZC4Quf+YVt+ftHaP8ondHqXXx2yJF+A+9xoj5I7mqxgr+GLxY/yfDGGYBgLHreii
 CvWUkjFmPvI+jRHrgI3bnt/uTX5XZpEG5UVtc45uHo2a/JcAXtiLIYSpbD5RtIIAJTOe5yNeF
 qcgKNNzKKRL0mbH+bUIhkHPD+GXumK4DQRNOSUz/cDYj0J2RiEICb4e5UMIPs5em6SurTiFS0
 G1GOTHVDS713SHZEbwVA9NluhHvtwZiFWh2ptjHPLeAmNd8EwilPcCeJbXjPXASdoTtnm4ibr
 Tk00t/x94IY2vTKyRIPCUl2oqXPjun+LYeBi5EgkkXtZ2e26AHoKzMgGAPQdMe5WemsCQyIO1
 VGSGtETVn/Oorl6wppprr+vNWxPGAbVuuplYpnhR0jQfw5uNKCDFreQhYEGnBjQrBkslz1HPF
 sDM+kip2V3yG8N0WodWOl7QKuFEEPrPTNy8LkVCnV6HtSCFKWdnt1bNarK5YfqjFAhbMBVfDZ
 qnu556Bk406RFrpykpf9NT1McN69rIr33gWcRLTcocwZoKmpPqKg6a0JXRoKXi+Bm0sC2ZBCA
 8RgAs32EexOxABcqjHaeoQoDC68QImXO3ohMa7Jh+TIHBLCLQDbOHzCio0TwzlzJ26+cxh+ei
 IbE9DuRADQDdj4Q0428M1LFhFyA9u5Qugo4qoJx+h+B9eX9jZfiYkDGji6rxLNEW0EMxW1uth
 hGtuTyfZFi/VfWbiqrKycjXTQUun8jtGA/Zx7Xapuwu1Q2eNhdRgC7Rhqibx3OFnjxyhtJNA/
 17IMv6aH/byvA9t8aohLTS8XvEmQP++xTqTwTdqMVIyHVFqV49+Kyp8nTVuGwZ75+2Q7zPHnM
 SxQGWU6Qn8NQMTYsWNfU55Q3cvoVomvOKo4rKf4e7Na51xa6HFQm09i4xys/A1AhjF0oivoyK
 V6jy06yspHexnd8P7Y6LD8L32KHfKkfLfeMqk9Q8GwwJ+BIPZcgBbdmQ1fakh2wPrLe95zR/X
 jYbiy2uDrg6n5UPI62jk8Y1ecA3CcIFPBDPxAtbFDgmWpt9fqhfnS8vznI2qWbtwpHCb126so
 GNosDQF5oUVLs1/woryOfk85xSSc60qQ/L+mvH0uJeqyc4gLX+1n3kF10Dlk43R1T9xsCx+W0
 eN6l5eX5+5lqJmJO29nyBtWUZ6MYAkZCOPTOkg06dhvXtdXPfoVsWgcnt+1ffmR5XjwtJ81c+
 VgGJnyOOm+P1u0TLXoSu+iX1242M/0ohMZNB3NNFNRPhIdMNBM

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> Define local symbols to give some meaning to anonymous constants.
> No functional change.
>=20
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim_asm.S | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
> index 3d5ad525ccde..c17a25e1cd33 100644
> --- a/drivers/block/swim_asm.S
> +++ b/drivers/block/swim_asm.S
> @@ -42,6 +42,10 @@
>   	.equ	max_retry, 40
>   	.equ	sector_size, 512
>  =20
> +	.equ	.Lmr_clear_fifo,	0x01
> +	.equ	.Lmr_action,		0x08
> +	.equ	.Lmr_write_action,	0x18
> +
>   	.equ	.Lhr_crc_error,		0x02
>   	.equ	.Lhr_fifo_2bytes,	0x40
>   	.equ	.Lhr_fifo_1byte,	0x80
> @@ -70,11 +74,11 @@ mfm_read_addrmark:
>   	movew	#seek_time, %d2
>  =20
>   wait_header_init:
> -	moveb	#0x18, %a3@(write_mode0 - read_mark)
> -	moveb	#0x01, %a3@(write_mode1 - read_mark)
> -	moveb	#0x01, %a3@(write_mode0 - read_mark)
> +	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
> +	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
> +	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
>   	tstb	%a3@(read_error - read_mark)
> -	moveb	#0x08, %a3@(write_mode1 - read_mark)
> +	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
>  =20
>   	lea	sector_address_mark, %a0
>   	moveq	#3, %d1
> @@ -136,7 +140,7 @@ crc1:	moveb	%a2@, %d5
>  =20
>   	moveq	#0, %d0
>   signal_nonyb:
> -	moveb	#0x18, %a3@(write_mode0 - read_mark)
> +	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
>   	rts
>  =20
>   	.global swim_read_sector_data
> @@ -158,11 +162,11 @@ mfm_read_data:
>   	movew	#seek_time, %d2
>  =20
>   wait_data_init:
> -	moveb	#0x18, %a3@(write_mode0 - read_mark)
> -	moveb	#0x01, %a3@(write_mode1 - read_mark)
> -	moveb	#0x01, %a3@(write_mode0 - read_mark)
> +	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
> +	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
> +	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
>   	tstb	%a3@(read_error - read_mark)
> -	moveb	#0x08, %a3@(write_mode1 - read_mark)
> +	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
>  =20
>   	lea	sector_data_mark, %a0
>   	moveq	#3, %d1
> @@ -226,5 +230,5 @@ data_crc1:
>   	subl	%d4, %d0
>  =20
>   data_exit:
> -	moveb	#0x18, %a3@(write_mode0 - read_mark)
> +	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
>   	rts

