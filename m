Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263943921ED
	for <linux-block@vger.kernel.org>; Mon,  9 Mar 2026 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072233; cv=pass; b=OlgixrWu1c8kqRELNfNz6LkRsLDTHKrxKOM9wCu4wolme1VJKDzR5VLsfiu6sYxUE2SwbqGQZ0LbSmA1W1K6mUwcQrB5koJSlNjUcu86SS8A1fnpqtW2fa6tJeotmFcd+xA9IbMG4yRQkDlb3uebplXfeRFXLJ+BR26XQl4aThQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072233; c=relaxed/simple;
	bh=NQvqvKOGW96HAPIU8J0MIWlgq0AT5gUFyoIguzMm9yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4tzLpRc9IqBmrWdmzj17HPbmnZ3gotEwOUtSN1rnFyCNP6lLYkPeEK5EvOur8XgUsPNmQn+SwG11HDSrbGtBI9zy+8CfazXSQQkpO//KNM68HVCXGrdf4pPWae4mEABLATarSn7x9VM2mxMgB1pqhZtVWJWIlhPrb46uC2LnGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BLhmrD81; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BLhmrD81"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4170dc73280so245663fac.0
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 09:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773072231; cv=none;
        d=google.com; s=arc-20240605;
        b=YWK6x8JPXpZDzFzlEce90z7Uu6cQlgHUb+QW3dwBY4zEaXHzTaumb8BMCxiUWbyzga
         rvRgMCmxl/oIJNpxFI1bpSOZUdZAa/TTWpbamQuPPwRoiM5TX6b7h3tRlUH5g7o0hwkc
         sL3ugS5UiCa+zAykC5ogoq81Fbf97fQfHs+2XiEIz4sXBR9vxQdcWL/+TcvlDQTfpqP2
         wIYWfMR9f9FsVNDViCq6qUXwneRg2lcOOXkdUOIZgTSJ9cLHycZAjEH0w6BDV4V/25tF
         dhLCuTzs60ULCojhhNzyJD5hPKM2EUfkifEmRUd5Pg1zGOGKhsdOi++cn9zvZJdzAY6G
         Hvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0gey3qaRhe9Prl8t/c226rpSUV7VipRuVJoYNhEoSf4=;
        fh=CBiB/CiGMDvAKeL82fzEaukCPeewrY8JUurFn9VwGts=;
        b=BPAlGrrwwC4jSRCaIKlZ2fQc/vQjytHf3eFwSKWhbJoXxadhKhEBa/QCFyGYpYjaHn
         c0AFkCJzZ2tHtToRv3UQJ2dRW8tAflsVD4/XmRJEJkCejWiEEzP1+iaaR0nF9MX+73Qg
         B7/qDnwGl5dHPuksxV9hmJ9HCwv2PALypfVZcXF7bXVOUQ2z9R3ppc8U5OkwTnVAKrEi
         zf61e/2O8d+aZrAeZeMNU1ND0fixLPI80COZ5bokZAkis+azHuVm73fT1U4NVht9S1Le
         gdVQqBSIGgIuVpe1KT+z84AoCYZzCOBsdg8yb0u3U8Ib7TtshWwKXFmn6gIxBBxvWYha
         0+yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773072231; x=1773677031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gey3qaRhe9Prl8t/c226rpSUV7VipRuVJoYNhEoSf4=;
        b=BLhmrD81zaPOsPa96CnAWUYxxHh+gtGuGU5qSZI33fbXN5X03deI0R7rCDgucmG3pl
         6X6XhbHtu9F06DWmekKajYmY9AytEVMAO6jODCR1aIJGdpINpytxs+zwsV+4Q//SbKy4
         o/u5qBOPNyRmPpk/fyTklZ7a8kQEBgPwasjb6EtkdFOtBQloECllGuRHahhkfnPSaWGn
         Bsyv/0Fr8NlT2grqG7sEdoOlE8TvVt4y4kAL4XZwgjDQscfKspP0QSKD/V5d99d+Tn9M
         K7vL31+fCpLcWVwzj8cOzXuhDP2rIWd+hXd0VV5zFqH/zXALcLcCIQHofV4t6jaFB2Ud
         yTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773072231; x=1773677031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0gey3qaRhe9Prl8t/c226rpSUV7VipRuVJoYNhEoSf4=;
        b=vCTDelYjw62voP//DiVtueXUC6mYIO3Me/PqkmTp2qESa774KcOEHz94VnMppuaQuj
         wANs8Hv5wOPzJ5xb5uGimJrB45bGMG+PEmUDIlgE0hvZIPA+yo3jsubKyLO6jCEKySI9
         cb+RbTO/Runb+G7AEBWcpndg7CkW4QzQisYAiDcvVrFa9IWSvoekAigcrLI3n0IdGQb0
         Nzz07zqlCN6/4JG01rdTZsu6PUI0lij3sap/nKJ/srUUYKbzbkhfVUqJSeULWHu7uBHG
         FRexLwpPmT9trDZGjqK4VN9sON5ywzZIMpM5Rda9HFvm7eXb/2kt+RRMcU6KhMV+ouo+
         JosQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpfTrMn02kUsmVRCRoDY3uZaDm4YlpQcmp3SFMb/6+7w4rUaqgdUKZRff6BzQjKXk9OOvj3X2s1PVvww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjN3o98LdeUpxNUolFUmPuSCHZ74/7CkfVnZo6bsm/sbSKx7W
	v1eaQIejpB+mr2kZvbspVzjEIg3jQ/oh5nwdyIi/9YokUAJsTVrmRVZ1qeUpgXUMXMbGoO8w0Kd
	3NQAkDa+F/h1cN/Qi+Yotr8CgGdvc7lpTFVb3fg4Qug==
X-Gm-Gg: ATEYQzwGOcHn4P0/2q+PQoYlFTzNMSybbSF9qOa2fynmQrP68ERUlkXv0zlG055ccwY
	3Rx/+0wv5XVmc80phrrPJFZEMScFqTYjayBKWVNBXfTdVOSqxYPOjePY2Ng5dQHlt+M65mZCt4V
	XOtc/S4mnpzoHH7TX4jU2pHln7iIy9u/QkXgUFqY+UJH+zqCx417II5c2iEWv4lzq4IrcWkjjK4
	U/sI0EWhzULmZ4lNHFkQ/nJpgn/pr8+KCj6Z4CcJBGH66JG89456E5ETCJ840kd1ITF6tRNzvAi
	ZW3OTtCAlYwqRGGWUA==
X-Received: by 2002:a05:6871:6084:b0:3fd:9958:1cb4 with SMTP id
 586e51a60fabf-416e39a4eafmr5699999fac.0.1773072230701; Mon, 09 Mar 2026
 09:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308143902.1643155-1-ming.lei@redhat.com>
In-Reply-To: <20260308143902.1643155-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 9 Mar 2026 09:03:39 -0700
X-Gm-Features: AaiRm522QC33-pn6ypfj1HraosDgIOCcxzFxbavX0PwQYmw1LIpMVrouwly1L8M
Message-ID: <CADUfDZriujeKOexHfJr6ZGFq1z-OQAfBCH+QYrHFn5G=fLyeWQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: don't clear GD_SUPPRESS_PART_SCAN for unprivileged daemons
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Alexander Atanasov <alex@zazolabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 7:39=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> When UBLK_F_NO_AUTO_PART_SCAN is set, GD_SUPPRESS_PART_SCAN is cleared
> unconditionally, including for unprivileged daemons. Keep it consistent
> with the code block for setting GD_SUPPRESS_PART_SCAN by not clearing
> it for unprivileged daemons.
>
> In reality this isn't a problem because ioctl(BLKRRPART) requires
> CAP_SYS_ADMIN, but it is more reliable to not clear the bit.
>
> Cc: Alexander Atanasov <alex@zazolabs.com>
> Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 004f367243b6..9573a46d0ef4 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -4443,7 +4443,9 @@ static int ublk_ctrl_start_dev(struct ublk_device *=
ub,
>
>         /* Skip partition scan if disabled by user */
>         if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> -               clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> +               /* Not clear for unprivileged daemons, see comment above =
*/
> +               if (!ub->unprivileged_daemons)
> +                       clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>         } else {
>                 /* Schedule async partition scan for trusted daemons */
>                 if (!ub->unprivileged_daemons)

Looks like the two if (!ub->unprivileged_daemons) checks could be
moved outside the if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN)
to reduce repetition. But the logic looks fine to me.

Best,
Caleb

> --
> 2.47.1
>
