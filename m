Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D313C13EC;
	Sun, 26 Jul 2026 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080532; cv=none; b=nN2tuwIP0LBNolD0WmP8JGTH+HHiA6H0PbxkgXVJwp9MUdpy7LweTQBAPhxzEHlr1NUCXcdY/3DXlAe/mlWlJv0aVRRvBZGa5tmbp2sOlwKK2htEx5o067zh4r9mzmRRi6V7reJxQMom1Q+9+6tIPIVZOrrNh3Smp2+aT1X3f7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080532; c=relaxed/simple;
	bh=FX65BaMzWUnU4BPXJf+wKCJZi2jppDJFIIcHUjATDso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckWA/h9mkQnxt0mwKDa3v9a2ynViyoSHJq6B/pXOhPGDZ5ONf4eF67RplrXeMviK8P2OE7WcP30ErfAmganf0K7/1vyi0nZCpciyBTpLJJVQHFL/iuNr356rvH3gaByEKtMdPiliPE6DBkDVqtdD+MGKhaM57/1jyLl/ySfD8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=wp8EpxDp; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="wp8EpxDp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785080520; x=1785685320; i=laurent@vivier.eu;
	bh=vHWCKMiXP538LOCvSvvDB8TcYgCIqRrT4vfdCNoZUXQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wp8EpxDpKDYvydNFNhLg9kFTGdCGz3/qGSoW3Yzqx0+yjDXGk9QW4UmHbiBBkpmk
	 Ut0tvcCw2BjxPZprZiRfIJGUMHVF8/6EWrqGvMjvA0SQF9anKMVeOUY0NyqO1f+lg
	 Yd8yTjHnz5SiBIe2xUqZyxIPNsUoBbQyIzxrdJzc8hch+jQuD/dKuBr8rygIzpLVU
	 XDMZ3EoDwAIeiDtAUCd7rESsAf/4RuGi3wddWnhQM+q/LFpybZNRg3nMHdCKou+JP
	 3lP6FzFYQ6qXxnQz0vff9e0QtY3nZAiKqIgxv9Y2QICXEcEn+RPyeiRAGHHpL39FK
	 u8LR8RDmxd+GCzMy1Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MKszj-1wXr9B2PrZ-00SmVp; Sun, 26
 Jul 2026 17:42:00 +0200
Message-ID: <e13f5625-e7d6-4fc5-aa26-cf2cfc4c2a24@vivier.eu>
Date: Sun, 26 Jul 2026 17:41:59 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/31] swim: Add some helpful references
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <60cdb6ab6079c8372b05040978d0da7fa2b216a6.1784196135.git.fthain@linux-m68k.org>
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
In-Reply-To: <60cdb6ab6079c8372b05040978d0da7fa2b216a6.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d1iJzTcLjaJ9lxOpgCaYob5+wGxJVGckAFhS7JIW8ALlK3pHJOj
 BNdbCUUhlw4MLvbn25thSiaNrambeCkKeIsY3RQVhGWLtu6VjEcazIau1hHEOze274W0fHy
 fWx389XNtYyMgMx3Hf2tgZbfAl7e1eNEK7/mNMM6xdDFEs6OXWUM47XiDYRcRDrlLXIG3du
 cXlMDaRfCDGVaNS/YqI7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QolayHrzfkU=;YogVo5sgnYADcq8BhESHVqPyJXF
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> These documents relate to the IWM, ISM, SWIM 1, 2, 3 and associated
> disk drives. No functional change.
>=20
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index c41d56ab6c04..444c3f31ba48 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -8,6 +8,14 @@
>    * based on SWIM3 driver (c) Paul Mackerras, 1996
>    * based on netBSD IWM driver (c) 1997, 1998 Hauke Fath.
>    *
> + * See also:
> + * Inside Macintosh, vol. III, ch. 2
> + * https://archive.org/details/SWIMDesignDocs
> + * NEC uPD72070 FDC datasheet
> + * mkLinux source file swimiiicommonhal.c
> + * http://www.mac.linux-m68k.org/devel/iwm.php.html
> + * MAME source file sonydriv.cpp
> + *
>    * 2004-08-21 (lv) - Initial implementation
>    * 2008-10-30 (lv) - Port to 2.6
>    */

