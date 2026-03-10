Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD67391E41
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151327; cv=pass; b=V8O1Zl98YUm4aVU7UBZMedhRMgrUrbIRCz7Zfgof3ZbFSdTRK8g3Ly1tJiC7PG5NvVOzgzBzQLOTxQYdzs74Eo+UHpPeopDNcE76irs8VSwgp71NfgZKV01lIFk0t4HOwkHTJgqpGoYwEVGNC96kFQRYbwvNZGvmKxYmhbQtqkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151327; c=relaxed/simple;
	bh=dd3EstQo+zNasXLsiNV4Gyjfpv5dt5Y+KFyZZK+NJnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBljZD8DYrTnsjOuQp60lDi2uIU9oGUgKYu9njZi3Z+9vpgxiUu6mSQP5Y0vPnMesfP32qTAUSJC2XoTzFD/ItMDt6RpX7Oxe/XGpHY4/dbNT4G4DcLR/Srg5gsbWh5ssLnlGIuOy8oxGcSmXddLN3E9WjtZ2565il6Ro1LtkWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1hxCQbZ; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1hxCQbZ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50906a98ffeso572731cf.0
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 07:02:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773151325; cv=none;
        d=google.com; s=arc-20240605;
        b=YepNi/tFH/RpbcgrPbWE80NcAxgb8AfzQuTN5KuiX9BVgiAAcKAclR8quoXY+KPwxs
         6iv8ScNum1ZvZ3dI7ztAQZlaz+OCawngKrJeNlZuF/VnE2R9muuPfk8MzpSF0Qrkb4TS
         J88DzaXO7i/kKiDqq7NRwviE85tMTwqawxPP8eHa/ezEKMzxc7IyZEtENR1/zioomp57
         1ztttvGgUkZ3y50S/ELmiar6LWkaeobjZ7GUwsYUJnYDpK9bY4nNUruQ1gtP6I32cHPK
         g/asB4AqeQSn/Inwp0xBWaAtHLhCtyEzAJoHxgHakFNEEyP64GN4rXpgVF7H4t42g+xD
         OfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4wLELxQud3htXSosde/zL0GloFPfZfR+i/6R3NCGqSE=;
        fh=5TwvtoJyf5fRUk3bvyW0zVVHuXRqhIA8OC9OEuP18mU=;
        b=EamsONtqwQkykZ76D3xid7bappTYMLDIH+rIyes5i1hSal4vsqTFWZLrqlddlhlxuU
         K8g5VgdyWPyH7KfxlZ1TAZhPTvFiSMbno/CQZ16bnNCRtRMyszpHql2UXTaYxlfvdovb
         FnXXiMwrH/L7vSyGI71GZVqBtHuudJkMknOwo8Npynwu2s3mzSpH/VYoBOJJyVWm3mdw
         gfy4NkrABove62OKJ8lyu3P3DDktOYbLBYl2kADLBUzY5TlaGHMIj9K6ofwF6oE32Kaj
         UHvMdMlkM2qSUCX10alvm/pMbxkefW2qmsAq2+Xib1vBpnsQ/Idqk+hDzjvj+yYwgJV9
         oLCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773151325; x=1773756125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wLELxQud3htXSosde/zL0GloFPfZfR+i/6R3NCGqSE=;
        b=p1hxCQbZP5HURZgrda7FEYO4UNQmaryo9QS3KQBHiq9JKZSmZNlbaLNe/S8wjZ767C
         eNbMqt+jbBHyaoIPmvbqi5RBkNH7OgE2yhFgCWGCBwiuaGs12FDPUJxwOSREvkFDj0iF
         ZaWn/04HbuiZCvZLf7LotWhWMEC3mQw0E26OzJFdM5NutNVNwigC6Fx+vQUKkI1rZ/8t
         viTIuc/J+iETSL+IR1h7ehcU8hfH8Su/Hwo/QszxwnEYfU65ETcgTX/pVr3fCvvtN9Zd
         BmS1+qh2kVpMXUuxoKDINW8DRgWGLO7IuY31NorZ1AmcuBtNZIeju0e8WrkJTbzcquGc
         TtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151325; x=1773756125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4wLELxQud3htXSosde/zL0GloFPfZfR+i/6R3NCGqSE=;
        b=vaGL14hO0/ipj7afDAVnvsnNh3qFoAkd4Zoj5OV5NiIQjockRCQjiy0re4sVgkbKXa
         DBf07/whhfkuEa/JgYas3FaQL9qzwH+lcb50FBmkwsBL3dAs3pF98ke8i1MhnjTROlSS
         amRf8jJN+ntW9KUHFhiDfb8cQkVnZ100Lzh9smRJIK9Uz1s1qfwfdYfhQ0176TmBa/Ex
         w1UIb9uTnxmY6zd966WMNF2fs0/A4qzJANKfT3i4VGk4el0tNpZXfzSwPdaQiikw7okg
         +YWyIuD0cfGemIIeiTu5FufoTbLM0yAKollpKAgmoRBEGdDHpMCRzFYwSZWglkYEqxj4
         +pSg==
X-Forwarded-Encrypted: i=1; AJvYcCWt5VbMlO8pGK76J1ZbvLEHfpD8axagVqLtw0xERL/Sl1rGLjaaHLla3/zSI7yYQm9tTqbBAunohh5sjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKl5YcGlSK5siNkk8Y/Bm4Z6sjgv+GmMTySWw3qwPJufEuMxGk
	Lfkm0PTxWWioAOHGW9P7YGo8FDhSJ/REWlqtRtPloXd0mzl9dkzoVYmiILVYzjs/Z3oarcyZWOC
	z+L2S8jzIgVstx40o4hedfcJemF/WJRQ/5wM/VK0T
X-Gm-Gg: ATEYQzyuh4Rr30O+cllIWUo5YErJfxRNSV8iN1sJVVTkF9vawj2jqbcH/rmVEvXTEWR
	jgL3vnOkd9UdtqqCeRB7TUx5NcFBKfcImIY2jC91s8LqPL/LqPalU/KWE5OURWxaVpTiiw5zTYT
	6m9HMcqvogvc9SICMXEfblICPNSKXwYG3IznzML0rS/yQ8WLFvTFE5RB9Aoysx6nrWGWj76pX8p
	ds1sVjF7IYsxg3PwCV+K1ThFsx6xSiu8DUEf+W1ALBxkNmUUtZqLbs+xP9EUN08YndSutzg7nF5
	r7ymm1wXhqX5OLX/MIj5porh+gLw77GtExOZ4EoOzm4Zt550kP5emJKvhAj6geMMcZCE2PoK0Pr
	NiCg0eeUsmCOSU7oFQmuFo42p
X-Received: by 2002:a05:622a:1786:b0:506:a3c8:d44d with SMTP id
 d75a77b69052e-50927ff52cdmr11664521cf.9.1773151323418; Tue, 10 Mar 2026
 07:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310060407.1133800-1-senozhatsky@chromium.org>
In-Reply-To: <20260310060407.1133800-1-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Tue, 10 Mar 2026 10:01:27 -0400
X-Gm-Features: AaiRm53oXK-y_X72MbDBnlVPnKuN7PrK0OkebVAEP3R7Ae_eXpwB4ioa6ZhtZZQ
Message-ID: <CADyq12zF3cwzSFcKYiGAdJ_G-NVnydBRQn+x0fgNq1kVgof4Vg@mail.gmail.com>
Subject: Re: [PATCH] zram: do not permit params change after init
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, gao xu <gaoxu2@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 2:04=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> First, algorithm_params_store(), like any sysfs handler,
> should grab device init lock.
>
> Second, like any write() sysfs handler, it should grab
> device init lock in exclusive mode.

comp_algorithm_store() and recomp_algorithm_store()?

>
> Third, it should not permit change of algos' parameters
> after device init, as this doesn't make sense - we cannot
> compress with one C/D dict and then just change C/D dict
> to a different one, for example.
>
> Fixes: 4eac932103a5d ("zram: introduce algorithm_params device attribute"=
)
> Cc: gao xu <gaoxu2@honor.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index c41e1257243f..7551c5e664a9 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1769,6 +1769,10 @@ static ssize_t algorithm_params_store(struct devic=
e *dev,
>         if (prio < ZRAM_PRIMARY_COMP || prio >=3D ZRAM_MAX_COMPS)
>                 return -EINVAL;
>
> +       guard(rwsem_write)(&zram->dev_lock);
> +       if (init_done(zram))
> +               return -EBUSY;
> +
>         ret =3D comp_params_store(zram, prio, level, dict_path, &deflate_=
params);
>         return ret ? ret : len;
>  }
> --
> 2.53.0.473.g4a7958ca14-goog
>
