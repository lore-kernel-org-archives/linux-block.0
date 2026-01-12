Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5330C35E
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237669; cv=pass; b=cwa7hco962Z9iAxwk6greAhVui0mHAvqRUZZ7e84YvfGus0HSsSrN6YmP+zObxemUQDkAGDwYIPzpcJjTaWcWh6dCNQV8AVXBX+D0NrI4tgpVeggEIE+RTeQkbQ+Kky4kRrCA54fVnw6mZSWA8cApOQ6oAX1Z1vWPYnlbFvef0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237669; c=relaxed/simple;
	bh=aWsTt/KJRgkPFGxk6Mnc5BHmuYHnkqX2MOBx28jMWF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fg3C9RWXIprpNSP601CRofuU2FJ0fCQ2BTZjTya7EA0hsxJGvA9Vzh6z57HpwIoZuzyXXin7q+sj5PwxjkTlqf0v0DNa61wyM5LEOPx5jnx2CmFNoqfh/uyChn56GCGt3wk1MrKjn63ughLM1gDT/LOX7MlH7lIbI7OvimwCBQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XPz27NWS; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XPz27NWS"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-11f42e9733fso315663c88.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 09:07:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768237667; cv=none;
        d=google.com; s=arc-20240605;
        b=ez8XhZH0jSIOk21d4Z6IRFZnn4Uk1AOuhK156mxsp/jyHJP+lHo19yGNGtLbSMoVwV
         eJbnQET7al71lXdVBx+ktCm4J/7WtC0UJqWt9qYLRKxVep0uo3GlXhKkml+w4i4nbhT0
         uVX0vSQDK0vgfCvxIjNOlOuBLRicDf5po7DUqnq6Blwtfg9M0wgOJ7Ca+kFemAXdiSGE
         uJ4cmYGBDAZznUqhtOoexbp1j+4H8kYyKEvootP1Vz5FEW0yocGctNsYaHCpnYXXKufi
         5E74dpWIR+6ozYYGIBDHrBqjY7LdNVT7iL1fRB5KWZ8WUv8pIYUbyvfhVF8pob0kKJJZ
         a0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ihUHGZwLbRTOi4jtAjauZbYgq5g9pI20xsnYtMLrEy8=;
        fh=PLrMKlVNNvTLCHOCdhHwY6Qb/Oq0XzB1otdBd/ifnmY=;
        b=EcWOkj1JcfVCLZa/SSGdQtFj8Ui+XqDP17ASikRES3hYQBFqpB1+TevB7Z8303zHlw
         zWmFUGByDwqOBECMdh3RAHK3I/fIGEmVUT44GTOl+ypHy/Lsh88iiojrNcYaZejtKF1/
         o8cRW/h11cXG0sh15cwaxwq7xwvrsQqlr3l05hgvLQQ+CTcVWQh61eq5S90+CKzvbXBo
         zhEzfBSrbm9eRHyD2sLVYX6mC7EuEFKvxnoKDoZmfFiHtJBAyurr8yBzwtaE+HEi8HYZ
         bTJBt0oqiFgHdZT+VqgH5mUjxdwPDMlnSVqN7pNZjHK7J8ys76Tg57fZCcp6vx/awDgA
         hiDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768237667; x=1768842467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihUHGZwLbRTOi4jtAjauZbYgq5g9pI20xsnYtMLrEy8=;
        b=XPz27NWSQf/8QPyVHrqpR9TEcCLeJW0EkFLdv5XFPeeh6TOt5RMoBsfwMU84y7C1/Y
         NIdge3pVGgehCmOzONGj16bbtLt6iBoOma/FEZcLYSh+EC1vyyCYvFJzReAwQDaJWUsz
         mUUGWzt9b1idD69wznit34bNkAgsuugVSPykSVE3aiysdrksS5EAT7AuO3lC68EY0jPr
         24K9N9T+RUUSok/RV/m9w8RPgx7Vo58PHV5t/zST5m2UTFyRJtXneV7pr0VoTNq7zIm/
         wSVWQIDkv3vLhTOLft7Pcrei/bzfi0uX7UABeNG9fmJlBtSvZ7Mjpr7Kh3S8Zxr05Ndn
         82LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237667; x=1768842467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihUHGZwLbRTOi4jtAjauZbYgq5g9pI20xsnYtMLrEy8=;
        b=dXcgvMAwQsOtQHqdVskoD5Aaxh9Xb30s/dgcdYwQ94aS2Cwpsi3/5Yd6LQ+8AdOZ3m
         8klEc/6Rz0+Qlop020ACBBkSAYnx4TAHB2sg4Y6p8kjMcUeQ5RqH3vrLmBLzZiuuGif/
         3gheO1rgSITHvQ4qxUHPrqUzbZ+o9JxM/k0dNvS+0FwUoEzs/Uq3NxX4/1Og33edkK/v
         TBwxhzWWSZBcspBYf9Th9gFU8CKRPj6bpyZe7hMzQa6BM5D5h2PsoN3lgNr9ceafPaip
         PrmuNe6Dzb+3zcC8IbsagRwE/VtLr4uxY6JrcvRRjVe3GICWKx0x9cdrtLDCe1zZlEsW
         g0Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUerjihb8sW/76n8OibRGic0hNnOF39VgetPu+yxV25K6DKIqn7HEv+JGfpqgI3rHxkdlF3jELc+DhXTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwF9oWCYZTYmP5ZNtRor8T38M4nMiO23wU6qmd4innGDo1ZpFon
	NhSJFiy/UJUpmWWJIb8gVUJphtmYH95hGqTK3Mdqk/zv6UjD1DJUL0nKqmzgIU5te3pSC3dKDi9
	Lt5UJfh83saGhRreQLVUQgaXGTEleLtE8SAHN5bQHsQ==
X-Gm-Gg: AY/fxX5MIhfEl9ZBOi2Tb1y/UDX4t+8X8uXDCyHpD6Aw1X5ZKrDj+QSyUkfrtFGXEon
	XcWNvZh0am67m+4YMT+7AW9dhxFPkpAF98jikDIL85dgQ2cfw+z5DTTf5FaxTle/qqm9AW6XEmZ
	AupeDMbxoGu8TpYbCeQmEZoTV1NfoUhJV2LdnnDD5cEFQnbAWXd9OvgS5FUqrEyZNnIZOhG13hl
	NvYqB4Rncgvi7D1fuvN+CI1Wl2/NWj2WYpW/o8zPsaptINJmiUVFv8LaLKhXEVI5rvtnaZp
X-Google-Smtp-Source: AGHT+IHiAWcX/1/Q3cPl5CWQIlsYV0ExSyWckL+NfZIiIRmEQSG5lmRsPlkGyRWIFkHHQIkK5xpNImCX9ASqSi2zjk4=
X-Received: by 2002:a05:7022:619c:b0:119:e55a:95a3 with SMTP id
 a92af1059eb24-121f8b92076mr9793049c88.5.1768237666857; Mon, 12 Jan 2026
 09:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112133648.51722-1-yoav@nvidia.com> <b784bf25-78aa-42cf-bf3b-0687d9138139@kernel.dk>
 <CADUfDZrzAdjf3PT0M7Gh0jQshKKRdAmb8Ce39dNUfj378vvDTQ@mail.gmail.com> <5447c8c4-da12-4497-8d74-4942101ba412@kernel.dk>
In-Reply-To: <5447c8c4-da12-4497-8d74-4942101ba412@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 12 Jan 2026 09:07:34 -0800
X-Gm-Features: AZwV_QjAr2bE-mfzS3QZ6YxW1ZTvIXcC9wnYT1Pe-PXGJBhDbDuX7PNyAxb04IQ
Message-ID: <CADUfDZr-NP5q04K+ypZLXGrdG6MRNbO=xkjbdkj027vhwPOL3Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] ublk: introduce UBLK_CMD_TRY_STOP_DEV
To: Jens Axboe <axboe@kernel.dk>
Cc: Yoav Cohen <yoav@nvidia.com>, Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	alex@zazolabs.com, jholzman@nvidia.com, omril@nvidia.com, 
	Yoav Cohen <yoav@example.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 8:33=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/12/26 9:28 AM, Caleb Sander Mateos wrote:
> > On Mon, Jan 12, 2026 at 8:22?AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> Please rebase this on the current for-7.0/block tree. It doesn't
> >> apply at all, and hunks like:
> >>
> >> @@ -311,6 +312,12 @@
> >>   */
> >>  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
> >>
> >> +/*
> >> + * The device supports the UBLK_CMD_TRY_STOP_DEV command, which
> >> + * allows stopping the device only if there are no openers.
> >> + */
> >> +#define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
> >> +
> >>  /* device state */
> >>  #define UBLK_S_DEV_DEAD        0
> >>  #define UBLK_S_DEV_LIVE        1
> >>
> >> is a clear sign that your way off base at this point. Why else would
> >> STOP_DEV be 1 << 17, with the previous one at 1 << 14?
> >
> > This is due to being developed in parallel with other ublk patch sets
> > which are using feature flags 15 (UBLK_F_BATCH_IO) and 16
> > (UBLK_F_INTEGRITY). UBLK_F_BATCH_IO is still in development and
> > UBLK_F_INTEGRITY was just applied. So I don't think it's fair to blame
> > Yoav for not having rebased on commits that didn't exist yet when this
> > version of the patch series was sent out :) Should be a trivial
> > rebase, though, since the value of 17 was already chosen to avoid
> > conflicting with the other patch sets.
>
> At the time v6 was posted, it did not apply to the current branches. So

I just tried it, and v6 applies just fine at commit 5df832ba5f9d
("Merge branch 'block-6.19' into for-7.0/block") prior to the "ublk:
add support for integrity data" patch set. And v6 was sent at 13:36
UTC, while the integrity patch set was applied at 16:22 UTC. So It
looks like v6 in fact did apply to for-7.0/block when posted.

> regardless of how it was developed, that's not a very useful approach as
> it means I have to hand apply it. Which isn't too difficult for patches
> 1-2. But now we have the integrity bits in, which means the selftest
> bits take more work. At that point I just threw my hands up.
>
> Hence please repost against the current tree.

Yes, completely agree it makes sense to resend the patch set rebased
on top of for-7.0/block with the integrity changes.

Best,
Caleb
