Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E1D1DE887
	for <linux-block@vger.kernel.org>; Fri, 19 Dec 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163161; cv=none; b=cZ/Vib3tM5OC/wpIInujTiv0bX9S7r6MPRtWvLbLTGKlao1g7bhJDNQXgRDsFdvv8xoIutGb3gEdB8496Q/v7gEBaJpoTVHRuoHMNZcRWVywHTjsIUocDuiJOfzbt9FLQu1Enq2X0eEc2rC92EnMWuOZuw5/X+d11tgI8+Trj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163161; c=relaxed/simple;
	bh=cLjnMT4E/in9HiVhPkIgJMDpj5msEYKrTZ3dTWcyOU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSm+NM1KeqeNZuAcyiMmccq5rXqm3cD+mEWqIAs1H34RWnOjlrg4aYQtldnYyB0Ju3CT77Vfld4Fe+ueiRUNj6JW8qDvk26/cOMzLvbjYbsjZzcNk0ZO2uP5UIWCxzCfhO5X6y8358fZ7oVAHZy1G28x4s/J9ZxA09gVhOdh+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TxNhI2MF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TxNhI2MF"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a08ced9a36so4008435ad.2
        for <linux-block@vger.kernel.org>; Fri, 19 Dec 2025 08:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766163158; x=1766767958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5oGt18SgcSlHN50urKsISXzoz9Idfv3x7i/gArhxOQ=;
        b=TxNhI2MFl+mY12rovyzbE68DQouJzGKojcJ0jHa/TL4dDucj45nAy/OLW+RGXHj1WG
         xcP2i/BtovROQ84D0dFQK88sVV3mXM/5WTRsB9e/20Tcu+gdd5k0NygMwZNMyIrGCcGB
         dGwtE5tuiQm5JiRI71GlVL0rFjpjdDHHqrbh5ea/k2e8MzEemUlgY3pgAUv+RoVzMUw5
         F5MA69Kv+CIVGft73E3XxfqW76quhSXZdRF7JX09I4aSy0Q+FOPayTZJkzXYjGOyJ0fJ
         jraPODAbo5mGi2/LqZQ8DVzU1dg9x5L8bbTt9shaUcjDSak1w1g0K0wugOwsWxA8HN3C
         Fynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766163158; x=1766767958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g5oGt18SgcSlHN50urKsISXzoz9Idfv3x7i/gArhxOQ=;
        b=o4x9T//ImC7MsBRZzOolvKL2sf7sg24ANyhQ7IrgncmJtNhW0KL3xs63Xqpu65NPW4
         lqcXTZS0AuIgPjLB3CaStoh/pG0XZAvpIUsrky7StdPBYam0qPUwvbeuHqkIWv8Fk606
         AxVeWduy18j3s5f1VXp8egirACPCXGaC+bofyr5k2wk8IMsA9Jl+IVfy0xKScaoK64fd
         o0AkQggpEx+rEOLs+mlMQwqbyZdLofA2Qw+nAi1hAS7XUmSvYrKFKEtaLLi+5PPepuKP
         fSTTWWbIiSRIGJq5y6VCmA342Avkb1sTQ0HSHN9YzclYCZwi8Ftvj8F2RSHIkbbzoRVl
         d1kA==
X-Forwarded-Encrypted: i=1; AJvYcCVsrcrC7zzCPpwOOeHo3SGXiK0sIbhNZuXX3H6uFc81N8VPuqSNlY1yemeY4iuVG8UBl35gVxifq+/wgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8nwgvroYea5dSSsziRjlzO7AuKFOOt55rDw/5bstr526mqo5
	otvEMWNZDycFHPzS87L51icgV9FBJZwTTbd/FGX9hltTYuqzl8SRp14qnyUIKrzipkwwe1cAW5R
	Rt12RYCDlJW5kKfkOQ/+lU5ScU/F0bIgUqrAe+7RScA==
X-Gm-Gg: AY/fxX7398ShIfxdEI7mRuxSUHGIy1Mkciln1NxSsfIK1klf4texnzDbLNp3xzni0Zm
	kijxd0oXhT0vW6VLHBzrEXOFtUAYIH6bgI1VRNwcVz7n80XnkgYa/ncOhc/u+QFd4eaq04LRI+n
	h0pu84CKn1PGn5GOZotDzipDTrC9e5n8KiG6ziYItRpkkZLRGDM6yzznghvKMcKnNaZGXtowLqr
	ey8LQ9vmxdpp2oBAllCZLzoaZtxTju09+voyzxM2xYiQSAUt8Uy0MlSWyltpKKMIGnU1f8=
X-Google-Smtp-Source: AGHT+IHiVz+M3JKqQe3ZPDWmLPNEryjDlevEIELB6ium6uEogRlOuoh4Dvds83YPpsYZuOW3+q+WkOKanHfeN5A6u2o=
X-Received: by 2002:a05:7022:3718:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-121722efb56mr1460941c88.4.1766163157478; Fri, 19 Dec 2025
 08:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213001950.2103303-1-csander@purestorage.com>
In-Reply-To: <20251213001950.2103303-1-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 19 Dec 2025 11:52:23 -0500
X-Gm-Features: AQt7F2oAPptCtgU10YVzHXAFxnNKianNyXcKemG1gjArNdNZjRPkUpJm5Gd8TLI
Message-ID: <CADUfDZqKLvt+uJXSgkwiE3CSew0C5xc6Ft1OfjPdGVQZs3rG-A@mail.gmail.com>
Subject: Re: [PATCH] ublk: clean up user copy references on ublk server exit
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ming, would you mind taking a (hopefully quick) look at this fix? The
warning reproduces easily with the ublk user copy selftests I recently
added.

Thanks,
Caleb

On Fri, Dec 12, 2025 at 7:19=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> If a ublk server process releases a ublk char device file, any requests
> dispatched to the ublk server but not yet completed will retain a ref
> value of UBLK_REFCOUNT_INIT. Before commit e63d2228ef83 ("ublk: simplify
> aborting ublk request"), __ublk_fail_req() would decrement the reference
> count before completing the failed request. However, that commit
> optimized __ublk_fail_req() to call __ublk_complete_rq() directly
> without decrementing the request reference count.
> The leaked reference count incorrectly allows user copy and zero copy
> operations on the completed ublk request. It also triggers the
> WARN_ON_ONCE(refcount_read(&io->ref)) warnings in ublk_queue_reinit()
> and ublk_deinit_queue().
> Commit c5c5eb24ed61 ("ublk: avoid ublk_io_release() called after ublk
> char dev is closed") already fixed the issue for ublk devices using
> UBLK_F_SUPPORT_ZERO_COPY or UBLK_F_AUTO_BUF_REG. However, the reference
> count leak also affects UBLK_F_USER_COPY, the other reference-counted
> data copy mode. Fix the condition in ublk_check_and_reset_active_ref()
> to include all reference-counted data copy modes. This ensures that any
> ublk requests still owned by the ublk server when it exits have their
> reference counts reset to 0.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: e63d2228ef83 ("ublk: simplify aborting ublk request")
> ---
>  drivers/block/ublk_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index df9831783a13..78f3e22151b9 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1581,12 +1581,11 @@ static void ublk_set_canceling(struct ublk_device=
 *ub, bool canceling)
>
>  static bool ublk_check_and_reset_active_ref(struct ublk_device *ub)
>  {
>         int i, j;
>
> -       if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
> -                                       UBLK_F_AUTO_BUF_REG)))
> +       if (!ublk_dev_need_req_ref(ub))
>                 return false;
>
>         for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
>                 struct ublk_queue *ubq =3D ublk_get_queue(ub, i);
>
> --
> 2.45.2
>
