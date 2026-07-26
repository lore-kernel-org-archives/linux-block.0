Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F3526C3BD;
	Sun, 26 Jul 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077037; cv=none; b=F/6T1OlHKbe/6U3qt/gEiqUK2/AgrZyqVtwKwgEY52PyWEilbcaidz/dvXZjg1QyHis3xH3FyseNlqJxjuSc49dtB9k8PtsnttPAsG1lXY1VNUDaF1jBgHuffGe1QJwsSMIllDcofDYIRrR1adQfGiFcVUMv50Na6vAbVBzsuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077037; c=relaxed/simple;
	bh=/Fe8UybNm9iVBYSjs91ZbLiPdEXI7i11aJgmVta0l2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eamMqxZmQbhUkvtse0tqtnZ/KRUu99MVFJ5pyC7CQpk0aRrKvurrYNssQoyXpKv413onqPIZW2w/9nJ2mnctJLHnWr2wbIfi1YKYrtckhYX1I3WP0/ev3kGU8dVQofbTC1Vx9LvM7tnBZiIK10EYSVzUBVvp2CSNkYY7sn/2c0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b=Zg3xyOKi; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivier.eu header.i=laurent@vivier.eu header.b="Zg3xyOKi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
	s=s1-ionos; t=1785077019; x=1785681819; i=laurent@vivier.eu;
	bh=iD1UXMsuVfMtnaeLHGcW7YF1GFuo713k3r5a6Boisp0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zg3xyOKiHN4w762ZmWyrVnQxaf9k/0FuTqvibQQ99j+Fhuxzfph1vPksFLDVRveh
	 ksThh+U0aYp+yDcjHxDoidUn/8I/1t2O8XSPEQWsbNGCh4SpmclZEvSP1KCJS10aa
	 LAyNH/PRoMeKBsiMmlVIIDUyO92qWOv/FuJIHvBLRGigEhji6cLLutMTFgso3tvuS
	 4ApvkaRV0aOgseVTYEvgOhEIzsK7sCDZeHQwruHgVr2HkIRNbzop9NWb5yNKtG0Ue
	 UujEJ7/RD40lGquZdhEdU8Ju/IRZgnLSiwpslwZ0s055AEdn9KcZH9kI651phguBT
	 c0eGe9SJOpD6WsVEOw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1M8hR1-1wselv44XZ-00DUJM; Sun, 26
 Jul 2026 16:43:39 +0200
Message-ID: <ff1b3b6e-b69f-4081-b98e-ebd2fa31185f@vivier.eu>
Date: Sun, 26 Jul 2026 16:43:38 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/31] swim: Deduplicate polling loops
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1784196135.git.fthain@linux-m68k.org>
 <7f0be2470206f78fb64d7df72e4d6948a21ec2ab.1784196135.git.fthain@linux-m68k.org>
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
In-Reply-To: <7f0be2470206f78fb64d7df72e4d6948a21ec2ab.1784196135.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mjSghRSvBOnkNn4zFmU55ace/ZnwegR53EVNjzhKXmHnIpUWfHa
 aeFzkq9+QXpr3+z+Qjm8G0780fqq2pt56zFJNSSYgD7aRCNXQlm4fSlR52W4atU1S9jxW0S
 1P6RbskwdCYngcgDvDVFnp+f8tIEzxGowgPjvTAf6+qQWDD7jCNQrWxYnYanLvrD4hyvbHv
 4t+aTfgZ3p5xPcr/9thcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YDHs+EWiynQ=;XXJylcCxpq8J9C3D8QSReFuxbjb
 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

Le 16/07/2026 =C3=A0 12:02, Finn Thain a =C3=A9crit=C2=A0:
> Replace duplicated polling loops with poll_timeout_us(). Change the
> interruptible sleep to uninterruptible because signal delivery shouldn't
> be allowed to shorten delays required by the drive hardware.
>=20
> Change the timeout for the !STEP transition to 20 ms in accordance with
> the maximum interval required by the UPD72070 spec. The existing 1 secon=
d
> timeout is impractical considering the number of steps in a typical seek=
.
>=20
> Change the return type of swim_readbit() to bool because that way the
> bit names make sense i.e. the reader doesn't have to remember to invert
> the active-low logic used for drive signals.
>=20
> Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/block/swim.c | 42 +++++++++++-------------------------------
>   1 file changed, 11 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index b4bf96a788db..c10ad1266c3b 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -19,6 +19,7 @@
>   #include <linux/major.h>
>   #include <linux/mutex.h>
>   #include <linux/hdreg.h>
> +#include <linux/iopoll.h>
>   #include <linux/kernel.h>
>   #include <linux/delay.h>
>   #include <linux/platform_device.h>
> @@ -296,7 +297,7 @@ static inline void swim_action(struct swim __iomem *=
base, int action)
>   	local_irq_restore(flags);
>   }
>  =20
> -static inline int swim_readbit(struct swim __iomem *base, int bit)
> +static inline bool swim_readbit(struct swim __iomem *base, int bit)
>   {
>   	int stat;
>  =20
> @@ -309,6 +310,12 @@ static inline int swim_readbit(struct swim __iomem =
*base, int bit)
>   	return (stat & SENSE) =3D=3D 0;
>   }
>  =20
> +#define swim_readbit_timeout(base, bit, val, timeout_us) \
> +	poll_timeout_us(, swim_readbit(base, bit) =3D=3D val, 1000, timeout_us=
, false)
> +
> +#define swim_readbit_timeout_atomic(base, bit, val, timeout_us) \
> +	poll_timeout_us_atomic(, swim_readbit(base, bit) =3D=3D val, 1, timeou=
t_us, false)
> +
>   static inline void swim_drive(struct swim __iomem *base,
>   			      enum drive_location location)
>   {
> @@ -331,16 +338,8 @@ static inline void swim_motor(struct swim __iomem *=
base,
>   			      enum motor_action action)
>   {
>   	if (action =3D=3D ON) {
> -		int i;
> -
>   		swim_action(base, MOTOR_ON);
> -
> -		for (i =3D 0; i < 2*HZ; i++) {
> -			if (swim_readbit(base, MOTOR_ON))
> -				break;
> -			set_current_state(TASK_INTERRUPTIBLE);
> -			schedule_timeout(1);
> -		}
> +		swim_readbit_timeout(base, MOTOR_ON, true, 2000 * 1000);
>   	} else if (action =3D=3D OFF) {
>   		swim_action(base, MOTOR_OFF);
>   		swim_write(base, phase, RELAX);
> @@ -349,16 +348,8 @@ static inline void swim_motor(struct swim __iomem *=
base,
>  =20
>   static inline void swim_eject(struct swim __iomem *base)
>   {
> -	int i;
> -
>   	swim_action(base, EJECT);
> -
> -	for (i =3D 0; i < 2*HZ; i++) {
> -		if (!swim_readbit(base, DISK_IN))
> -			break;
> -		set_current_state(TASK_INTERRUPTIBLE);
> -		schedule_timeout(1);
> -	}
> +	swim_readbit_timeout(base, DISK_IN, false, 2000 * 1000);
>   }
>  =20
>   static inline void swim_head(struct swim __iomem *base, enum head head=
)
> @@ -373,19 +364,8 @@ static inline void swim_head(struct swim __iomem *b=
ase, enum head head)
>  =20
>   static inline int swim_step(struct swim __iomem *base)
>   {
> -	int wait;
> -
>   	swim_action(base, STEP);
> -
> -	for (wait =3D 0; wait < HZ; wait++) {
> -
> -		set_current_state(TASK_INTERRUPTIBLE);
> -		schedule_timeout(1);
> -
> -		if (!swim_readbit(base, STEP))
> -			return 0;
> -	}
> -	return -1;
> +	return swim_readbit_timeout_atomic(base, STEP, false, 20 * 1000);

I don't understand why we need _atomic() here.

Anyway:
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

>   }
>  =20
>   static inline int swim_track00(struct swim __iomem *base)

