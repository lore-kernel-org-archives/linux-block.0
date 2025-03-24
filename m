Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71E1DDE9
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831494; cv=none; b=HLErDsiu2GSdeCDm8HVAO/ce8ukd6N5eer/uYNOQ/vD3vK3UT6tLJuxNiOyEirMgZXm7SXBGe/oIjkdSAXESifBchfYeUkpiR5gkWmdJ+BD45b1O0m+CMoIg6cmvqjVSyw7MVSweiuWr4radX4IZfwT8q7v9NM27+nmVvtaRbu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831494; c=relaxed/simple;
	bh=UC9qP++KYutE5fxpVScBFvd2iV/rnOQ/eUlOJtQvanI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7lGKfoGpueRiQ2J5UE8i1OWxlXCGRtv3x6nglwXaf13TtSLo3l/vxLRdAiUUxOMQOcM+ghcR5cxwFtkY4gb3AJ2M9rZc7LAWtz1Lr1qYA+2rODpWvjvz4TIOYIbXQ70lBGFIb/ChnpDLl6CqOwsjKa7FUvmRJZqstVad382nw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CYavKkp1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CYavKkp1"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so1275971a91.1
        for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742831492; x=1743436292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw3RqrPSNysk14V2vzRCDtlphewnhp3wsyb5adI1NYA=;
        b=CYavKkp1dsNxA/2vH29pXtv7kjRlB89++0eXXQmfPwtBJ5C+FKSt7HfIuivkmSM8u+
         535xxNPBsYZHurXVZtQHUqZig8H+XVKYtOZEKEkYzwkrYoUoBtsTdoEiM3WEJDo5gUhK
         dPju/H4s1y0/pebsv7vYTOaHO+RZj+SyKgt9UNU2rXp7+3SvWELkUPH6AmTRL87+gOHl
         4WpJuWhQrkHJj2KDIvzqwsS1CRrCY/cBgHuoJ31zkhk1v/Ow/1rLAzWxX8e5UYoyH42e
         sjLWBK89ZQZKRbiowVFV4UCMBNE14z7vfgD/+M19C4Y/rKvJ7wmJ9PlYh8lOnA9V5UxF
         loaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742831492; x=1743436292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aw3RqrPSNysk14V2vzRCDtlphewnhp3wsyb5adI1NYA=;
        b=cMpZahbZq07adkDUXyENM087goZSiYzjEALpirSat9s8AgS4AKLIcZ6VnBM+/WyZ7K
         mPgkqVecJ23UnrLPxHL9DxTurNHCr+0b/B3Mml4icND0BbaefnDC+dC5S+8PlllpVNtH
         FcGN91vp8x2SPO0EXi3zSOPmraMiw73whG8Y06oei4zW3exaaLbjTzVeekNG7TTdpI00
         5nO7xWt2AGE4QbI6vTL7MyM/KckW5MDi95U0PQ18u+yBphRZLfYdk1BKqOHXOo7PocXM
         ifntfL0SugI1s5lRTYccFIbM7i1PYnXGy4HLybzfNP3kH4nIs8yJcbieFpbPxO+gjLA8
         5wjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXQ38cM0lShIfvoXAvUKgCypiawb65eUz3YU6jz+MEXOabbv70VNHgicdp8RxUHk2BIy65WDUDeysLXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9T0slNJ54RXNeJqW3Z47eiqPhTdRrGZQWCTCLVNBo8Kej6t4
	GleOEVd0g6BkVnDp1PsJSuJGRzJylkFham16mwBUF/ppJgiL0OkYVkpI82wqhlrwc8S9aYIIwrp
	7ZpQPb70i1J0JK2uNTTcP4nCzGalBmXbkzCO5kA==
X-Gm-Gg: ASbGncuciHhZIpchl7wvhA4bhteWIy7xBzOedDfNymUv7iHdPsLyeewzH4Oh1pabtVb
	abw1SaqOqH0ZQqTPh3aCVrmvc9MSVtpShdtAKMzuWyE34GowVoiwqYKvnl+x/AwywiyDoIX1J7k
	nxFwEwB9YbeO86QbiOOY8za4DJfw==
X-Google-Smtp-Source: AGHT+IHgZ02XnGiMyCyC6jQAXtFqcl4awhcQpN1lrF9IctitNJkh8vq5aasf3Gqsz5/Jhqg1HxLYDcBG1HXq5dE750I=
X-Received: by 2002:a17:90b:3e8d:b0:2fc:1845:9f68 with SMTP id
 98e67ed59e1d1-3030ff157f2mr6359996a91.6.1742831491790; Mon, 24 Mar 2025
 08:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324134905.766777-1-ming.lei@redhat.com> <20250324134905.766777-4-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 24 Mar 2025 08:51:20 -0700
X-Gm-Features: AQ5f1Jp1AWYY8nfD6FWBFWKZtYl8ZZmzaem4v6IitNgHvs5vXgcIky5E-EmwyFo
Message-ID: <CADUfDZrRqyPkG2cQdsfvjXBS9Y4aU7ETPv3T1t=K4NGqvRzH2Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] ublk: truncate io command result
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> If io command result is bigger than request bytes, truncate it to request
> bytes. This way is more reliable, and avoids potential risk, even though
> both blk_update_request() and ublk_copy_user_pages() works fine in this
> way.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6fa1384c6436..acb6aed7be75 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1071,6 +1071,10 @@ static inline void __ublk_complete_rq(struct reque=
st *req)
>                 goto exit;
>         }
>
> +       /* truncate result in case it is bigger than request bytes */
> +       if (io->res > blk_rq_bytes(req))
> +               io->res =3D blk_rq_bytes(req);

Is this not already handled by the code below that caps io->res?

unmapped_bytes =3D ublk_unmap_io(ubq, req, io);
// ...
if (unlikely(unmapped_bytes < io->res))
        io->res =3D unmapped_bytes;

ublk_unmap_io() returns either blk_rq_bytes(req) or the result of
ublk_copy_user_pages(), which should be at most blk_rq_bytes(req)?

Best,
Caleb
