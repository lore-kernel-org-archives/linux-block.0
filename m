Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2482EDD58
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000473; cv=pass; b=j0xXOZ7g81NP4opDYm3oT9EHDJKcT/OnyHPXInE6ocmuWMCctUONWd3bn9IU0EzP09mxPl+fXxKESTlVNFX/YDBmzuDHzphWIjbj4CTnDlvMVR34hGZWjJNoYNMkUOXSVPci05qaSSHKJj7LP0mnpgXCk/PDX2gv5u2FbZxqbhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000473; c=relaxed/simple;
	bh=zBapVJPklVtbwGQx+QM1x+AmrbhtwJmrdN+kavM2RPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTVjI80o8WeDzwPQCqket/X2KfI0l2574JZKZCsNGmbBP4L+w8o0Ni6U/sqvmxV4jrxdjg8C/gula8OwCUCTTngsTkB1ouHztGUPH358Wb2k/lIQIXj98c1UEaWegduDTkCUWAKtAKpiXS7mlbZpOVEzaU4Ub3EBMVbkBHossak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVvUQUVs; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVvUQUVs"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651d692e833so7599551d50.3
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 20:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777000471; cv=none;
        d=google.com; s=arc-20240605;
        b=aHrWhKSEKDPEzYW3pAViWoApZ2zs2RmObEjAv11QUQw+FbeJUwaQLkyd7QdwseuzCB
         sPOVLm9uuhOFQkYAwxJP6m/PXBoI+uipRHovZEuct7r9Gs/qDkLXfMthoSyuMl1HCVDL
         EjE87IpTDsDIphgaQQjdmwh5lHLxDT4uRvmUShsdpHfs+gMFoF3/Ye55XE0rXcpAE607
         y/obdOdlKxqtas+PLc1TNGnTVzDh8T76ARh1wKYEVvdbnELqqQX1vdwnzZMVysadsdhr
         tFg9ZZRyq06tsuvpvo+MpGLK6eCg9c7awRzGavU+wGw8O8+/iFrI106Jbp9cha6tv5Tj
         cskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zBapVJPklVtbwGQx+QM1x+AmrbhtwJmrdN+kavM2RPU=;
        fh=Y+G/RrTUoAp5gFnx6LvORJNyR0Jpf75qObDp2WdUxec=;
        b=HaTyLq5UweWLUucaMapqoNJPavQpNCmjXedG8S5dqSJOQ51GpkhJtO1J0sZ5VSl97l
         axO0WmtoxMQ5cEEeunfJUS6jjjAi2JzFNUXwkyN402RF1MHY0bbomfupmehGyy3YCtxl
         5MRPbWntcpl1D2nff8+R/a51MfPVpApkksZjbkB3ZSkV39gv7OxkPwR15Yu+WTzq8/n6
         Wm9wXaMaN8h7Nx1ZBqVK1pna/lL5uwgms9Gb2fA9tN3d1lrhJV4Pbj0MGTrayspioQhm
         mAKFZcrK507q3z3eJ47yK/wIl2AVrSQow4GsKIUsCPilh0nP3/AUV9mCEXgnRTrhKipO
         rxmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777000471; x=1777605271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zBapVJPklVtbwGQx+QM1x+AmrbhtwJmrdN+kavM2RPU=;
        b=dVvUQUVs41nK3qQ1/LNjnk+QlAz/MKHMZ/i1txgvwDNurhThyEn8TCMBwpcOpsr2PH
         YK+PyMkD0yZyksqA73pmYv54Gw8hIWCrGifdU3MRVhjqbAZ7hoS8tKPPnnSJyYzkhk7S
         paukSPEzMszBMmQoWwT5icIQzaw6pvbmmxo3rfYsE+d+rXMtPSXhA0Y/4AAUPXb5CU3t
         HYTIdJBHWlxM2rtXRMKMl+6M3toqc4V06nKf+/SgbeEdLiJBr2mqoE4FcKe2mr13mkp7
         2LxpHNyjk24tg1/HorncPN5pvuFFR2mK1IwzTEwJQRhhOapggmp8bSzd3SP9rEWk6XQt
         vWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777000471; x=1777605271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBapVJPklVtbwGQx+QM1x+AmrbhtwJmrdN+kavM2RPU=;
        b=P2MxCheXdwZxUY3igWn5og23yMhB9YXc+rBAaf6AYZVoJSyPH9aOPEt9oMwPSE/A5A
         mpZ5m0xNMUP8UlSskWPduO1KzJ/VrLiSw2kVX6TH0kVR3veyMU8C2bzaqO02ooShn+iO
         VuIZ8GQ9AHZWsmV3Kw8biXufQrlykgzO31RFhlS3wuFjq/eBTIiye7FgJusIHXxwPNAj
         W1Ow2IZVgjFCmP0KoD3VP700iFRP+Lh37s5D1zoxd0VTGMmrQjP/PVtJXwkX2+Gsbbsl
         A9wSUIbBaQzbIAxtnNfUEeOfLn20sG2ntxtoU0DNTazWjvgDGIh/eArNYqV1kQbIPwfR
         TsPw==
X-Forwarded-Encrypted: i=1; AFNElJ99JK2+1PW/wG18XIFqQ/3CjV8hH+mXX6de+9u7qxdSKZyMP0lmMoKCifeNdKNS4V46YSWDnAfaxFkCMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwe05gbTHJpEhVeBmsxbGmoH90SJU0YGq6yaOnUPOusmgcC6p9
	RfvOAau1Hc0BoqEtlDZVyimfGNukta4jUzdlxtjOUJNmo50/O97+qWacE1WHEQcv+9JBabQSeZV
	GCluaiuAfnKkcztjdE+rqwvSAewOC+9SmoT0M8mU=
X-Gm-Gg: AeBDies1a18GSNXpA2+/BMCqzXl71uMPdTg64z5rHUf93HosIk2pboMaVX+VKk9RA1+
	f4OfX9vf+7svXCSnEXXlH1thnY0VA4FGXbT/l1ZVa+HLuIC/20jQlgHKGK6feMeEUY9dvnFqVrU
	Alx6ep2Du3wYp19eIUgOLjqe5M7+sWt9caCXOUgqMEJY5XKJrys3M5H1hriYLAVH/zEVHJmFLnp
	0yR0/fp/R99dpwMktwXYwOH+VMWeWaBmd8Wx0oVVHPiyAGb60hLzjPYg5GHL+SF44fEfU0cymhb
	pX7zEDJh7007swaUA0ff
X-Received: by 2002:a53:dad2:0:b0:64c:f395:c19 with SMTP id
 956f58d0204a3-65310bb4980mr21401458d50.64.1777000471270; Thu, 23 Apr 2026
 20:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415145708.3331818-1-lgs201920130244@gmail.com>
 <177645836617.906013.5675762942401997007.b4-ty@b4> <897f442d-4e04-4b70-b716-38fd10b8af36@kernel.org>
 <f661cf47-18bb-44f2-8764-c9f0b4fb68b1@kernel.dk>
In-Reply-To: <f661cf47-18bb-44f2-8764-c9f0b4fb68b1@kernel.dk>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 11:14:17 +0800
X-Gm-Features: AQROBzCjis2FGx9xMR9_OK9MG4iG5DCEoaPMwiGenSDi9BetnMmD33B6U1yLaEs
Message-ID: <CANUHTR8W7tz0me90GDci97ee6N+3MpB7uVYYFN0dtTf9u_Ui2g@mail.gmail.com>
Subject: Re: [PATCH v2] floppy: fix reference leak on platform_device_register()
 failure
To: Jens Axboe <axboe@kernel.dk>
Cc: Jiri Slaby <jirislaby@kernel.org>, Denis Efremov <efremov@linux.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jiri, Jens,

Thanks for the review and for catching this.

On Thu, 23 Apr 2026 at 19:06, Jens Axboe <axboe@kernel.dk> wrote:
>
> > The patch is likely wrong. Given the pdev is static, the struct device
> > has no ->release, so releasing it will trigger a warning. AFAIR, the
> > consensus was to fix platform_device_register() proper.
>
> Thanks for letting me know, I'll revert this change for now.
>

You are right that this fix is not appropriate for this case. Since the
platform device is static and the embedded struct device has no release
callback, calling platform_device_put() / releasing it here is wrong and
can trigger warnings.

Please disregard this patch. I will drop it and not pursue it further in
its current form.

Sorry for the noise, and thanks again for the clarification.

Best regards,
Guangshuo Li
