Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3674502F
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 02:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117085; cv=pass; b=Ua1yrjTZocM4e4fuDid/RxpsXoj5XKaK0zz3jEqZ/gKzhqW82fM/aSnFAutTOS46sRMAhOgkcxPtqsBJfsgD26XHe4jzluUBKb3hyDQT5b9quEfVwV4qsbcB6YMSGlsIs/7X4n618Ahume7QM85e8UkYZXEN+Co2xU0vlJkAp+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117085; c=relaxed/simple;
	bh=WMoaHnDN0Y06ITTfRIbQrAFTUkyQpyCsDLwooGLQ7rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cx3DgluOGuMHawqjyuFuUh7bww1tM5A5EBmqZp6n99nWKOjRYPd3A4aems7xyE3vzLI6ouIMAWoSn2L/gRc+PEzTXt8Z46VmTIVAHOHBdjvhsU4A2kNDLW4qxZ1/KCRT+FMlxZOXiPLrOMAFxRcRrDANz4GYdYT4WVxDOFPygSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvYRNRUg; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvYRNRUg"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6dddc514bcdso1844664eaf.3
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 19:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792117083; cv=none;
        d=google.com; s=arc-20260327;
        b=s+IqDCChP6fPPMvP0oK+emf3HM96CTLLdUWTRCplEistKlL78D29ysZi0BX4jGmXnK
         eufQMuK7vel79QZpBwZuws0f6ZAaOOgSueoJ7y2+IRYAA8ACU1fSKalPCmfwYEdwiWX/
         HDuzkvSVioY1FvRktYdM8RpGbd1gVmst3jaM4ovDFQDwUOmm53waNCA8JKnE01JeIq9d
         cHfQFxyUzgTVhO+VW3EznZdfYALcoNnXl80+6vzu0CrdQUYNID+sol1d0RLJyARQ37RP
         e95MEr1lOU2SApDWyTutxmLnn+0jYlrYuvZ/GjD4pE1oZFkCnHIToIdOZnoYdEQvP7j5
         EOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I8J+MbQGeSC2E2cIQrbkQR0RrcGScgMLwxEU9E2XMPU=;
        fh=HeJOJqRRZm5WMOGWqIOWzSEFT+9iamM/pc3z5lor20w=;
        b=rJvP8P2hbEulJzL7M5O+1ahuW/tQKr3HSJv+2b7t4R16n5a9EbHBWMg4obi2PsaXhK
         +NAruiTjMJPUMPjJEr8KBbb8V8uFhZNQ/CJZz0vOTsqGNWPqq6b6De9FEuY2ZX15rVlf
         PAIv5QDBmPonXNJseCpWqZmtVhxj4yO6YaVblCy8MMCWS8RGHmudUvIWTukFXP6R0QYL
         gUKTYejcD0E3KDF7FVUybyz67P/Kem38Qinl2j7AmMgbQeWCpuiEOrdCTuzWW0e5BZsG
         I+7g/nlYgevthz/M1V9PQRvrZcKvytoFOOKpAi2O6EJqkpEFUhF/UYicwfd3ztdirG0O
         RwRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792117083; x=1792721883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I8J+MbQGeSC2E2cIQrbkQR0RrcGScgMLwxEU9E2XMPU=;
        b=CvYRNRUgqITnYdxa3GUa/JUT83QbbsI67Q2k+aDHB5dWQ8cO7uP3iJT17EDbEPoCt3
         CPQ6loVrAkmwyyAjL8iD1WyX+un4uXGZVriDDPegn9Bp5DF81j7IGkMtSRBaxjnzM0Vr
         A4cSZUZ1LQd5dQ6mQ+wFsyrkiZJlDn3yaxT1z9ZGPGS+XE7WfFs+E8Z4yO0v/xYXRAFt
         hoIvX8p1jEPLpeM3mdWQcx4YTudzOB7FuFe8UmeUyaOsXz23zZkAKc5Bnn8C07VVCB7B
         9GF3ePb5XYz+iKFqN+TGJVDp3IBOkWZYtfDYFgfYDpdWWs571mZfgyaJQPCyGd7RteRF
         x7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117083; x=1792721883;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8J+MbQGeSC2E2cIQrbkQR0RrcGScgMLwxEU9E2XMPU=;
        b=AGDQIxcApy9x9FtNfByXWgtZZfuzaMAxilM+R8nhXkFsJSkB3w6HIdzs2tLdhDaZAO
         CPTbny7/k9udemAt4oMfcoMFdjHL4cxyLk20XdjbdPgxmU27wbq7HYrW2r7FYDD3jcSD
         +HtCxhjZm5BnvEzqQk/M99EBZbEuxJEbH5ivBGe9eQL6kXTFiPcdmOkSsC+f49wBiekz
         25KJ3OW8eBOHtDYNppT3lBq9ltxSDUZvHdyVVA7dgUSpz05u0iH+952diQa6d/1+LKvb
         SpIyKcTTK0cQmXOx/B8uKkS4NM5TWHY4Eqb0kCCzTtd4eFCisg5ofFybwV2/9PohGNdW
         X18Q==
X-Forwarded-Encrypted: i=1; AKwUvBw/K7PnzB1cuHybv2UoB7cSUugZTV3prHMBiHiSwtxgYOqrJ9ITXK6gYQUioDfn3Y8Oxf89lSbk8MMgcg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKZdoCJn8qOerNuIPeOaBqMMuRqMh8Ykukyx6ISjkyuWwQoBzaN
	JkDHaDzGrmyx/emHXLgI8/oPZgL4+iQBoPF15gGn1/p9gobyJ3d7yGQPhf81A0svf5TNMAEm2cU
	6HK3fUrKkAPX9uP8yPQ94c2oroUP0Vg4=
X-Gm-Gg: AYBFou0QdilgREm9O8/8oYrpKUsxSDYzt+OcGQk8tQc3UHwMCTRu0NSvk51oOndhASU
	VtWQuv6M5JEEGyZcvpZpkVrV7qVbgfIicuDjzJTtVBnyGWT/Ljyqb7756vrykSxxczMly34VKWV
	jOjKzINEpYdOSBYpC7X67O4C7FwxzblS8J0m6GucLPSsnu0DQOlm8Q7dCkGnEiX07PipgViTnZr
	oAYMJ79wDuygJ9kHLoE6gyQssDx64o6NYilcNbfjq56c3NBKh3ocMp3UWN5nJy46s5fz2F9BPF8
	IpUcpKacPXusE0BUe7VoMDTa5DPnk8XUDnYTuCynbfS1xu+kVi92molVCfhZOozVL/0n3G1omvo
	LXfV4UlZ0SY1YkfivwkEg0vt/dSYdy47jym+0DXxWlgKGgsbwd8ShKP4=
X-Received: by 2002:a4a:ee10:0:b0:6d8:4e2e:9978 with SMTP id
 006d021491bc7-6ef0f7afeb5mr15006342eaf.21.1792117082607; Thu, 15 Oct 2026
 19:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015120654.241354-1-sono7ri@gmail.com>
In-Reply-To: <20261015120654.241354-1-sono7ri@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 15 Oct 2026 21:17:51 -0500
X-Gm-Features: AclHuK80oQQQEs0WnePVYvVi2mzpo5E302hrIEVEp9c_Zj1kKcbWADJ0Eg4LJ1s
Message-ID: <CACVXFVP5KQ3=cxKsJJ1ktqVdGa281kZ88SVxPgW5C=Yws7a=-g@mail.gmail.com>
Subject: Re: [PATCH] ublk: pin module while release work is pending
To: sonotri <sono7ri@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:07=E2=80=AFAM sonotri <sono7ri@gmail.com> wrote:
>
> ublk_ch_release() takes a device reference and queues exit_work.  The VFS
> module reference held through the file operations is dropped after
> ->release() returns.  A queued work item does not acquire its own module
> reference for the callback.
>
> Consequently, normal module removal can start while exit_work is pending =
or
> executing.  In addition to the worker callback itself, the final device p=
ut
> can invoke ublk_cdev_rel(), which is also module code.
>
> Take a module reference while ->release() is still covered by the file
> operations reference and drop it only after the worker has completed its
> final device put.  A rearming worker retains the same reference.
>
> Merely canceling exit_work during module exit is insufficient.  The worke=
r
> is the terminal path for the device reference taken by ublk_ch_release(),
> so its cancellation would strand that reference and skip the associated
> cleanup.
>
> Fixes: c5c5eb24ed61 ("ublk: avoid ublk_io_release() called after ublk cha=
r dev is closed")
> Cc: stable@vger.kernel.org
> Signed-off-by: sonotri <sono7ri@gmail.com>
> ---
>  drivers/block/ublk_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 66eb55e71..71556c34a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2613,6 +2613,7 @@ static void ublk_ch_release_work_fn(struct work_str=
uct *work)
>
>         /* put the reference grabbed in ublk_ch_release() */
>         ublk_put_device(ub);
> +       module_put(THIS_MODULE);
>  }
>
>  static int ublk_ch_release(struct inode *inode, struct file *filp)
> @@ -2625,6 +2626,8 @@ static int ublk_ch_release(struct inode *inode, str=
uct file *filp)
>          */
>         ublk_get_device(ub);
>
> +       /* Keep the worker's callback and final device release code resid=
ent. */
> +       __module_get(THIS_MODULE);
>         INIT_DELAYED_WORK(&ub->exit_work, ublk_ch_release_work_fn);
>         schedule_delayed_work(&ub->exit_work, 0);
>         return 0;

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming Lei
