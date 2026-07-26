Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310212405EB;
	Sun, 26 Jul 2026 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785081089; cv=none; b=jPGUSaz+6al3TUv1jOtq6Bf3tEwVUjSh8C9gqf0W2coMN6kQTv8uIg338R8QVZGTCOaV7uUasgc8iqMFJXlf3fdeyNRqZeyqyfgbMBkPQ2wvpXbwYXCIFCLWz+fVcjnIVMVjIjGBYTILGRAvva0bD88F+a+VY3uLW6kN+eZhyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785081089; c=relaxed/simple;
	bh=H3F+p5i1MImsAYgmhpx641LsancnQJgeOBYKeT/R/C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2XiYyF7kb7bD+1yM/q3aq0TVE1IaA7tgtXbyCqPT6ug1x1UWPiCO6VO0F26p2ly1R6VydwRXbotU1kpKzGVjWgLcfQYjhY92fKqYkiBT9D5LEDCm1aOapSs6sPDkf3UpWgJIKylPduV3yJIVpyFkJAc1MDfY+Qj6UVsuvki7bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=LmX90APd; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="LmX90APd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785081080; x=1785685880; i=laurent@vivier.eu;
	bh=Dpl5JW1rkP4pObqL/FcXPHbETqRkrvSHzK3bzbqpPIU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LmX90APdl6ZgJQ+44RYWyTwrbTB3oZOfk4cIoMublW1cx9IsaNqw0syqsSuREXhv
	 uH6yHixezwCY4IK+tRa/CrIT2CPUe4qDiKdarJPqBrJ9/Y3AAtZJt+ePws5P/XBES
	 Z0e+NlCT0xVwzPFKeLXL0tSpm4oSbc3AvSJnB95Ieue7CQ7C/9BMStwLRGaUhj7lO
	 yT1Wz9QAS9TFpu0dJO6LQCW9hk11bogPu8U0gt2lRXkBkjctRcBs3VaDgz9d2161e
	 eqbDQi4zTyhDaAG9PkPeJHB/38g7H02xTnDLSlImrl3q66mnPTMfcden4UmjqxQd4
	 CZw48i1x2I4P+hWBDw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MG9wg-1wkgfb3eqS-009qXu; Sun, 26
 Jul 2026 17:51:19 +0200
Message-ID: <33b70275-7642-48a6-9be5-0354d0e09217@vivier.eu>
Date: Sun, 26 Jul 2026 17:51:19 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/31] swim: Unexport global symbols
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <b1193c2e8e8850922bec72f7ea2b07710d9f0fdd.1784196135.git.fthain@linux-m68k.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <b1193c2e8e8850922bec72f7ea2b07710d9f0fdd.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g4/Abcto6ivGdW49HVkDfUOHP8DsotIBx+Ibvy613+sed3xVBTc
 qW6qEsO0fzN7yc0nfItKo3FSTSBTwVoMXvKqmthsLXClnL2m0LQ7o290j10LkRfkEBHcX2L
 LgSUCZS2NFdBOxA3r1hNQvUxHQQE+kEytPPh9gHaTkAT0ogG4AsDQkrSgoKDZeMVWYjOap5
 VQWr48+DBIKQU38HkPrkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SgTRYBRY774=;N2bvybOuZySMoPccgnbmBMv3iev
 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
 =

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> These symbols aren't used outside of this file so use local ones.
> No functional change.
>=20
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim_asm.S | 251 ++++++++++++++++++++-------------------
>   1 file changed, 128 insertions(+), 123 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
> index c17a25e1cd33..65b4e4658e10 100644
> --- a/drivers/block/swim_asm.S
> +++ b/drivers/block/swim_asm.S
> @@ -14,33 +14,33 @@
>    * 2008-11-05 (lv) - add get_swim_mode
>    */
>  =20
> -	.equ	write_data,	0x0000
> -	.equ	write_mark,	0x0200
> -	.equ	write_CRC,	0x0400
> -	.equ	write_parameter,0x0600
> -	.equ	write_phase,	0x0800
> -	.equ	write_setup,	0x0a00
> -	.equ	write_mode0,	0x0c00
> -	.equ	write_mode1,	0x0e00
> -	.equ	read_data,	0x1000
> -	.equ	read_mark,	0x1200
> -	.equ	read_error,	0x1400
> -	.equ	read_parameter,	0x1600
> -	.equ	read_phase,	0x1800
> -	.equ	read_setup,	0x1a00
> -	.equ	read_status,	0x1c00
> -	.equ	read_handshake,	0x1e00
> -
> -	.equ	o_side, 0
> -	.equ	o_track, 1
> -	.equ	o_sector, 2
> -	.equ	o_size, 3
> -	.equ	o_crc0, 4
> -	.equ	o_crc1, 5
> -
> -	.equ	seek_time, 30000
> -	.equ	max_retry, 40
> -	.equ	sector_size, 512
> +	.equ	.Lwrite_data,		0x0000
> +	.equ	.Lwrite_mark,		0x0200
> +	.equ	.Lwrite_CRC,		0x0400
> +	.equ	.Lwrite_parameter,	0x0600
> +	.equ	.Lwrite_phase,		0x0800
> +	.equ	.Lwrite_setup,		0x0a00
> +	.equ	.Lwrite_mode0,		0x0c00
> +	.equ	.Lwrite_mode1,		0x0e00
> +	.equ	.Lread_data,		0x1000
> +	.equ	.Lread_mark,		0x1200
> +	.equ	.Lread_error,		0x1400
> +	.equ	.Lread_parameter,	0x1600
> +	.equ	.Lread_phase,		0x1800
> +	.equ	.Lread_setup,		0x1a00
> +	.equ	.Lread_status,		0x1c00
> +	.equ	.Lread_handshake,	0x1e00
> +
> +	.equ	.Lo_side,		0
> +	.equ	.Lo_track,		1
> +	.equ	.Lo_sector,		2
> +	.equ	.Lo_size,		3
> +	.equ	.Lo_crc0,		4
> +	.equ	.Lo_crc1,		5
> +
> +	.equ	.Lseek_time,		30000
> +	.equ	.Lmax_retry,		40
> +	.equ	.Lsector_size,		512
>  =20
>   	.equ	.Lmr_clear_fifo,	0x01
>   	.equ	.Lmr_action,		0x08
> @@ -56,91 +56,96 @@ swim_read_sector_header:
>   	moveml	%d1-%d5/%a0-%a5,%sp@-
>   	movel	%a6@(0x0c), %a4
>   	moveq	#-1, %d0
> -	bsr	mfm_read_addrmark
> +	bsr	.Lmfm_read_addrmark
>   	moveml	%sp@+, %d1-%d5/%a0-%a5
>   	unlk	%a6
>   	rts
>  =20
> -sector_address_mark:
> +.Lsector_address_mark:
>   	.byte	0xa1, 0xa1, 0xa1, 0xfe
> -sector_data_mark:
> +.Lsector_data_mark:
>   	.byte	0xa1, 0xa1, 0xa1, 0xfb
>  =20
> -mfm_read_addrmark:
> +.Lmfm_read_addrmark:
>   	movel	%a6@(0x08), %a3
> -	lea	%a3@(read_handshake), %a2
> -	lea	%a3@(read_data), %a5
> -	lea	%a3@(read_mark), %a3
> -	movew	#seek_time, %d2
> -
> -wait_header_init:
> -	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
> -	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
> -	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
> -	tstb	%a3@(read_error - read_mark)
> -	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
> -
> -	lea	sector_address_mark, %a0
> +	lea	%a3@(.Lread_handshake), %a2
> +	lea	%a3@(.Lread_data), %a5
> +	lea	%a3@(.Lread_mark), %a3
> +	movew	#.Lseek_time, %d2
> +
> +.Lwait_header_init:
> +	moveb	#.Lmr_write_action, %a3@(.Lwrite_mode0 - .Lread_mark)
> +	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode1 - .Lread_mark)
> +	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode0 - .Lread_mark)
> +	tstb	%a3@(.Lread_error - .Lread_mark)
> +	moveb	#.Lmr_action, %a3@(.Lwrite_mode1 - .Lread_mark)
> +
> +	lea	.Lsector_address_mark, %a0
>   	moveq	#3, %d1
>  =20
> -wait_addr_mark_byte:
> +.Lwait_addr_mark_byte:
>   	tstb	%a2@
> -	dbmi	%d2, wait_addr_mark_byte
> -	bpl	signal_nonyb
> +	dbmi	%d2, .Lwait_addr_mark_byte
> +	bpl	.Lsignal_nonyb
>  =20
>   	moveb	%a3@, %d3
>   	cmpb	%a0@+, %d3
> -	dbne	%d1, wait_addr_mark_byte
> -	bne	wait_header_init
> +	dbne	%d1, .Lwait_addr_mark_byte
> +	bne	.Lwait_header_init
>  =20
> -	moveq	#max_retry, %d2
> -amark0:	tstb	%a2@
> -	dbmi	%d2, amark0
> -	bpl	signal_nonyb
> +	moveq	#.Lmax_retry, %d2
> +.Lamark0:
> +	tstb	%a2@
> +	dbmi	%d2, .Lamark0
> +	bpl	.Lsignal_nonyb
>  =20
> -	moveb	%a5@, %a4@(o_track)
> +	moveb	%a5@, %a4@(.Lo_track)
>  =20
> -	moveq	#max_retry, %d2
> -amark1:	tstb	%a2@
> -	dbmi	%d2, amark1
> -	bpl	signal_nonyb
> +	moveq	#.Lmax_retry, %d2
> +.Lamark1:
> +	tstb	%a2@
> +	dbmi	%d2, .Lamark1
> +	bpl	.Lsignal_nonyb
>  =20
> -	moveb	%a5@, %a4@(o_side)
> +	moveb	%a5@, %a4@(.Lo_side)
>  =20
> -	moveq	#max_retry, %d2
> -amark2:	tstb	%a2@
> -	dbmi	%d2, amark2
> -	bpl	signal_nonyb
> +	moveq	#.Lmax_retry, %d2
> +.Lamark2:
> +	tstb	%a2@
> +	dbmi	%d2, .Lamark2
> +	bpl	.Lsignal_nonyb
>  =20
> -	moveb	%a5@, %a4@(o_sector)
> +	moveb	%a5@, %a4@(.Lo_sector)
>  =20
> -	moveq	#max_retry, %d2
> -amark3:	tstb	%a2@
> -	dbmi	%d2, amark3
> -	bpl	signal_nonyb
> +	moveq	#.Lmax_retry, %d2
> +.Lamark3:
> +	tstb	%a2@
> +	dbmi	%d2, .Lamark3
> +	bpl	.Lsignal_nonyb
>  =20
> -	moveb	%a5@, %a4@(o_size)
> +	moveb	%a5@, %a4@(.Lo_size)
>  =20
> -	moveq	#max_retry, %d2
> -crc0:	tstb	%a2@
> -	dbmi	%d2, crc0
> -	bpl	signal_nonyb
> +	moveq	#.Lmax_retry, %d2
> +.Lcrc0:
> +	tstb	%a2@
> +	dbmi	%d2, .Lcrc0
> +	bpl	.Lsignal_nonyb
>  =20
> -	moveb	%a5@, %a4@(o_crc0)
> +	moveb	%a5@, %a4@(.Lo_crc0)
>  =20
> -	moveq	#max_retry, %d2
> -crc1:	moveb	%a2@, %d5
> -	dbmi	%d2, crc1
> -	bpl	signal_nonyb
> +	moveq	#.Lmax_retry, %d2
> +.Lcrc1:	moveb	%a2@, %d5
> +	dbmi	%d2, .Lcrc1
> +	bpl	.Lsignal_nonyb
>  =20
> -	moveb	%a5@, %a4@(o_crc1)
> +	moveb	%a5@, %a4@(.Lo_crc1)
>  =20
>   	andb	#.Lhr_crc_error, %d5
> -	bne	signal_nonyb
> +	bne	.Lsignal_nonyb
>  =20
>   	moveq	#0, %d0
> -signal_nonyb:
> -	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
> +.Lsignal_nonyb:
> +	moveb	#.Lmr_write_action, %a3@(.Lwrite_mode0 - .Lread_mark)
>   	rts
>  =20
>   	.global swim_read_sector_data
> @@ -149,86 +154,86 @@ swim_read_sector_data:
>   	moveml	%d1-%d5/%a0-%a5,%sp@-
>   	movel	%a6@(0x0c), %a4
>   	moveq	#-1, %d0
> -	bsr	mfm_read_data
> +	bsr	.Lmfm_read_data
>   	moveml	%sp@+, %d1-%d5/%a0-%a5
>   	unlk	%a6
>   	rts
>  =20
> -mfm_read_data:
> +.Lmfm_read_data:
>   	movel	%a6@(0x08), %a3
> -	lea	%a3@(read_handshake), %a2
> -	lea	%a3@(read_data), %a5
> -	lea	%a3@(read_mark), %a3
> -	movew	#seek_time, %d2
> -
> -wait_data_init:
> -	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
> -	moveb	#.Lmr_clear_fifo, %a3@(write_mode1 - read_mark)
> -	moveb	#.Lmr_clear_fifo, %a3@(write_mode0 - read_mark)
> -	tstb	%a3@(read_error - read_mark)
> -	moveb	#.Lmr_action, %a3@(write_mode1 - read_mark)
> -
> -	lea	sector_data_mark, %a0
> +	lea	%a3@(.Lread_handshake), %a2
> +	lea	%a3@(.Lread_data), %a5
> +	lea	%a3@(.Lread_mark), %a3
> +	movew	#.Lseek_time, %d2
> +
> +.Lwait_data_init:
> +	moveb	#.Lmr_write_action, %a3@(.Lwrite_mode0 - .Lread_mark)
> +	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode1 - .Lread_mark)
> +	moveb	#.Lmr_clear_fifo, %a3@(.Lwrite_mode0 - .Lread_mark)
> +	tstb	%a3@(.Lread_error - .Lread_mark)
> +	moveb	#.Lmr_action, %a3@(.Lwrite_mode1 - .Lread_mark)
> +
> +	lea	.Lsector_data_mark, %a0
>   	moveq	#3, %d1
>  =20
>   	/* wait data address mark */
>  =20
> -wait_data_mark_byte:
> +.Lwait_data_mark_byte:
>   	tstb	%a2@
> -	dbmi	%d2, wait_data_mark_byte
> -	bpl	data_exit
> +	dbmi	%d2, .Lwait_data_mark_byte
> +	bpl	.Ldata_exit
>  =20
>   	moveb	%a3@, %d3
>   	cmpb	%a0@+, %d3
> -	dbne	%d1, wait_data_mark_byte
> -	bne	wait_data_init
> +	dbne	%d1, .Lwait_data_mark_byte
> +	bne	.Lwait_data_init
>  =20
>   	/* read data */
>  =20
> -	movel	#sector_size - 1, %d4		/* sector size */
> -read_new_data:
> -	movew	#max_retry, %d2
> -read_data_loop:
> +	movel	#.Lsector_size - 1, %d4		/* sector size */
> +.Lread_new_data:
> +	movew	#.Lmax_retry, %d2
> +.Lread_data_loop:
>   	moveb	%a2@, %d5
>   	andb	#(.Lhr_fifo_2bytes + .Lhr_fifo_1byte), %d5
>   	beq	1f
> -	movew	#max_retry, %d2
> +	movew	#.Lmax_retry, %d2
>   	moveb	%a5@, %a4@+
>   	dbra	%d4, 1f
> -	bra	data_crc0
> +	bra	.Ldata_crc0
>   1:	andb	#.Lhr_fifo_2bytes, %d5
> -	dbne	%d2, read_data_loop
> -	beq	data_exit
> +	dbne	%d2, .Lread_data_loop
> +	beq	.Ldata_exit
>   	moveb	%a5@, %a4@+
> -	dbra	%d4, read_new_data
> +	dbra	%d4, .Lread_new_data
>  =20
>   	/* read CRC */
>  =20
> -	movew	#max_retry, %d2
> -data_crc0:
> +	movew	#.Lmax_retry, %d2
> +.Ldata_crc0:
>   	tstb	%a2@
> -	dbmi	%d2, data_crc0
> -	bpl	data_exit
> +	dbmi	%d2, .Ldata_crc0
> +	bpl	.Ldata_exit
>  =20
>   	moveb	%a5@, %d2
>  =20
> -	moveq	#max_retry, %d2
> -data_crc1:
> +	moveq	#.Lmax_retry, %d2
> +.Ldata_crc1:
>   	moveb	%a2@, %d5
> -	dbmi	%d2, data_crc1
> -	bpl	data_exit
> +	dbmi	%d2, .Ldata_crc1
> +	bpl	.Ldata_exit
>  =20
>   	moveb	%a5@, %d2
>  =20
>   	andb	#.Lhr_crc_error, %d5
> -	bne	data_exit
> +	bne	.Ldata_exit
>  =20
>   	/* return number of bytes read */
>  =20
> -	movel	#sector_size, %d0
> +	movel	#.Lsector_size, %d0
>   	addw	#1, %d4
>   	subl	%d4, %d0
>  =20
> -data_exit:
> -	moveb	#.Lmr_write_action, %a3@(write_mode0 - read_mark)
> +.Ldata_exit:
> +	moveb	#.Lmr_write_action, %a3@(.Lwrite_mode0 - .Lread_mark)
>   	rts

