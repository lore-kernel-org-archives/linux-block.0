Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1332239937C
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166206; cv=pass; b=oAPPMV7ym0gtv0wSY2siSGn+aM/U5aLfBndq9oR/a1GZltPZX3/c+s2SsZFCyKtgIZTNIipGVjZirwU+GjF+0Uo7m2MXWTGG3OUkzNpoWHLoebJOVPnh9c2cFGCHlJ8Eq4N5OhFFdASgvv4Skg3A8BO9/HhYtgxv5nxfi5dMr4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166206; c=relaxed/simple;
	bh=KMguZ7AVQEmAtXUkdgP4AMIA4pmOukTAaFsuTXrTTgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdhVE38rdXZbhnBg2u6Co+lWPVTUqE+GIpt9s6yJXipOMTzoCWS+sgoGBmVmXAKBOnLwGCfqTvTAf9RMbadyR+2Ktn4+WKg8Ph9yDHzISkUyQcxeF8lvAwoqlZ7HngDGyMDohC/e5+djBRlG1nJ0xai8uZLildjhSv3QGwrXkTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EOE57eoe; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EOE57eoe"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4485b31257fso210495fac.0
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 08:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785166203; cv=none;
        d=google.com; s=arc-20260327;
        b=s4sX8nTSCLbc83TXhDCjLJBoaQB4OwbikjTzFzUn5UUhsqin219UxC8HrLfX30reSO
         qHne8MKjoux1fCZt4SXrMcpwN/z6ST6ng8N+ZmX2bwne8kB+R2V/vqKNISkeKHofkmlw
         dqY1hLRk/4QphjYoW0hGcLaAo6oHbsA6hxPd+Qe3Q2Azx3tdGsEYr30mui1vcS3M9GW1
         keAzNBGtFyWYrXECfybDxEUpnnLD86brND3fl/2A5PgnlEak4nEY9jDH0J668m8CTB49
         sfNOIPnfmcpO7CgN4fBAuvt4wLiUT2Bv3Ma6A/VpxuDrLUM/8QwJh2wT0KL4AS98M560
         HX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2aNw+I7ysKX1IKI/G2FfmFMuAGEfwm/hbtrWFVd8MHA=;
        fh=2o3XoCVn/lpdq6/XdrqwlXT8mKkXZO0hq6ri18tt504=;
        b=oFBbZZsIc9vNmb3rEAMoSzdmMwLd8sbxougj8p1LmRCCDlFSKA4gscv8VyQ6RlNFrz
         KoOI/R5643vEHcCGnlStYV7s8rULAyFllS0sjUsfxJHtDkqH6CRH9TKAp2z4BeCG9Wbj
         W5yK/MFxNHYRP2bFk4h6vGYXN07yPvMwCjea11VP1jbtgfyjOPENLVPIESYTUPp1r6Mn
         u9vmpe/zqcSsZVLRSGdAffDEHvfgGJ80aG580wnlbUchWBGIjp/XaCI9OFaJKPN+HIIl
         1dF68KsoUTO39CaaaMnJ+cieCiSELjDdGGcf3jswuOG5URjcbC1eo74OBwwBKuY06xcJ
         D4IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785166203; x=1785771003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2aNw+I7ysKX1IKI/G2FfmFMuAGEfwm/hbtrWFVd8MHA=;
        b=EOE57eoeNmD5lt7GvS7wdQruqz1JvXYVkkkKLqR0hJPi0TUCUjWI/NgXgn/TqSt+oY
         ABMajo/tBYw1NC5Z6V5rLR8bb8ye3RMgLYPp+g/+oP+IU07DBoyUBHh29zShovHuAMxo
         sDwymuKe70m3M+vpIYMKDqKHpgERpNsc6l7l3ug+GyZR8obXfFHQ4lo0J5oKnC7oMy+2
         JhS7KZOJZVw1CPdGAKQMxdP5WQ790yVoqfWSUaFmdg7fxCen60Y6CVGZj8Ki8GQRwGtG
         BRJ0eBjm1oj9V5DEniNS5TblGdScpub1YMaNg3T0AXIfS5XU8cASKc8T5m2WvnzPhEeQ
         ECpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166203; x=1785771003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aNw+I7ysKX1IKI/G2FfmFMuAGEfwm/hbtrWFVd8MHA=;
        b=rei6AWk4beUvY7SRmnOwRbFb9dfeIib8B1EnEXrh2bbYsCXk4JbDoXmV36aw6GHpq/
         I+hYtiRuMJSBO++Zugk+AuaO8Zs1Pn5erxjr8w1MfuVtm3tesWey3CHtnMJo4VpmpCzZ
         bTktqNf3Ocbo3xpgaZt0rHQ4fWj22lsoBmroBykqS/Wig9/OjQSD6JV9dMCGV1z6yCYe
         9xZHJOvbdwpOog8yZQjf/stsDTSqWH8bCnf+KD1dbBurPOmqRCjMDJ97s8xpHyvDrkYH
         vUKJnhYhktX3i+e4FnbY/sfjpDn++tF7GxX0b7hqsWJ+kfVpSSh35f9x9nCUbwh8PgGx
         zztg==
X-Forwarded-Encrypted: i=1; AHgh+RqaiJMB9yDspef3Shw1LW5trDd6rBdeagm7gnNARXYCRMb3mPf5JLoRV4vxnUR7+6HPQhgc2MRNol+vHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsHH8fsZtXRIgo7URDs+L7pPRUxj0pGwmrNQTordWibhU3inq
	nzzpTUa/O97eCZBr4kzS8c68gM7AVW1tHE7/xH0xe39WrDgDW3aQxlSaZGaJ2rI2hWnmPcyEL7N
	MBRU8JzVYWoQmPtdI2bTocRrKpNaZuBtb2ltUKqf16g==
X-Gm-Gg: AR+sD123IMeDBYQipW1xuFqG4Z5187vIBYw/8pJ/cxUh0lgUEnvbeY6mnce7IuE2Qvi
	HbIvQPl3Cm2akJmCmlAThM0XYat/BYmexm0b61EdudeOc3isGhYpYTMCpeiHGqoOEmv5MU50agx
	69dwMfdGmJWjGBEc4j3nds9tNrwLSLQWF83KYt0pC7QQuV6Jza4bvlOnQNYRW4RjcOWOIushdhd
	ClYnEamxwXKddWFgXSmaZEEbouzXmGA9663PmoY0A3l5S2kU8Wconcz0JsGiA==
X-Received: by 2002:a05:6870:7091:b0:452:112:77bf with SMTP id
 586e51a60fabf-45858d0f099mr420820fac.6.1785166202726; Mon, 27 Jul 2026
 08:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726145025.1507383-1-tom.leiming@gmail.com>
In-Reply-To: <20260726145025.1507383-1-tom.leiming@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 27 Jul 2026 08:29:50 -0700
X-Gm-Features: AUfX_mwXrHK1kp2MH8JecsMREFrjHgs2ZEb-wIDc9x-ApCKJiMQoIb5IjLNQxtA
Message-ID: <CADUfDZr9Rpz6BNrVLtEysJWCgPxb6C-3tj6O6VL0e1ZQWG_wyA@mail.gmail.com>
Subject: Re: [PATCH] ublk: reset kernel-owned dev_info fields in ublk_ctrl_add_dev()
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 7:50=E2=80=AFAM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> ublk_ctrl_add_dev() memcpy()s the userspace ublksrv_ctrl_dev_info into
> ub->dev_info and then fixes up the fields the driver owns, but misses
> ->state and ->ublksrv_pid.
>
> A device added with ->state =3D UBLK_S_DEV_LIVE passes the
> "->state !=3D UBLK_S_DEV_DEAD" test that ublk_stop_dev_unlocked() uses as=
 its
> proxy for "a disk is attached", while ->ub_disk is still NULL, so DEL_DEV
> right after ADD_DEV oopses in del_gendisk().  UBLK_S_DEV_QUIESCED plus
> UBLK_F_USER_RECOVERY dies one step earlier, in ublk_force_abort_dev().  A
> poisoned ->state also gets START_USER_RECOVERY and the char device
> read/write path onto a device that was never started, and wedges START_DE=
V
> at -EEXIST.  A poisoned ->ublksrv_pid just makes GET_DEV_INFO report an
> unrelated task as the ublk server.
>
> Reset both after the memcpy(), as ublk_detach_disk() does.  Userspace onl=
y
> ever reads these back, so correcting them silently breaks nothing.
>
> ADD_DEV has copied ->state in unsanitized since ublk was merged, but back
> then it was harmless: the gendisk was allocated during ADD_DEV, and both
> teardown and the START_DEV -EEXIST check keyed off disk_live() rather tha=
n
> ->state.  The oops became reachable once the disk allocation moved to
> START_DEV and those checks switched to ->state.
>
> Fixes: 6d9e6dfdf3b2 ("ublk: defer disk allocation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4ca6ec738c93..2a22f9dc1f2f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -4764,6 +4764,15 @@ static int ublk_ctrl_add_dev(const struct ublksrv_=
ctrl_cmd *header)
>         /* update device id */
>         ub->dev_info.dev_id =3D ub->ub_number;
>
> +       /*
> +        * ->state and ->ublksrv_pid are owned by the driver and only rea=
d back
> +        * by userspace, but they come from the copied-in dev_info, so re=
set
> +        * them. Otherwise a device added with ->state !=3D DEAD looks li=
ve while
> +        * ->ub_disk is still NULL.
> +        */
> +       ub->dev_info.state =3D UBLK_S_DEV_DEAD;
> +       ub->dev_info.ublksrv_pid =3D -1;
> +
>         /*
>          * 64bit flags will be copied back to userspace as feature
>          * negotiation result, so have to clear flags which driver
> --
> 2.55.0
>
