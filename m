Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABBC1898F8
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764379206; cv=none; b=SSNw6owN28aYIJ00dqYtefHxQO4kzOkA/6zr8kHO2va70cvCPkSrLMjrbMZyQivlU7vTn0OvUFG6e9MJmM38B7uaohO+D+jD8tJaRw0ilX1yRwMUjq4LHapIvFVBVaxQTcQBQOmUjkKndsbdWgT7DpV5sNhXGhnvcDK5IPeZxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764379206; c=relaxed/simple;
	bh=CQ4gu5qwHISanFuymuvKH3qflMdaqJ/uuGBrjJ6tlTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwqH3Biia6oTk9M7d5OZx2NeHqaPS6vJOvEgqSx1cVVMt6zsxVfb8RkgN6krLeXIi97jLhemjkOtsJJiIrns3eVrbtQnDdK+/EKFSM1qHTM3YmL1Av6v7a3S02dGcQxrufTuIVCDXX7Hr+/E6Hfc+8GbVYvo4jz3c7Ew5EqestA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx1oiJ55; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx1oiJ55"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee19b1fe5dso28497911cf.0
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 17:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764379204; x=1764984004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs0ohHvC2dybiBLIXiSQxGJyUXrOOQGSRM7UOWCS5dA=;
        b=Mx1oiJ55XOPXMyCAiN/Br5JFA3l1n2xcoNVlmgHTqEMYK+hrtl5bY6f7CurTScUiUz
         yRo6zDSIsPseHekpeKZlMJEnTeZPKLEVk4bJUHMUeeGWtVjHwyxC7NfzstE02D7PhQZe
         cUuVXgAensM9BqOkyuN1JmUc+x478me9YpEmKsW8oEB7sX37qyXCjNPI6QqGdmS8YiAt
         XoUo5REunWFNrEbtzHsRTuJftl5Z85x4meYDc4yQLp8zvQ4WPoq39zoCDnx41WOhWYTL
         uiZ6qVuE4mtikutYXDXrISPMG5kIpN1XYJqGpye5MMY1HxFHrPfiH+fLJzpajKKWwxsD
         oP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764379204; x=1764984004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fs0ohHvC2dybiBLIXiSQxGJyUXrOOQGSRM7UOWCS5dA=;
        b=EEPiYccQjJ8k+VjwwlDO0UXyqQ3akyBYRRVj0qdwpBj2XiDNflrJv0xIvD54VavYvw
         8TgO5GSS7nuTw22LCzY4QPWDlw4G2OL8ELhAeYuYqmgwgJ1ckuOYvMtFsGQPnmNLIt57
         roxO6kT2JSouIvkfQ+aiMn22NZ8H+6jQnNTV9xw8MKwDLT1EJluSUlnedE+lDf2mo8ku
         +bfOyDske8Emxl/Am2h4HTMbXpnIwXor5pJHfUP42S+bH0i8/G+BTkT4MwP01VQGfWlL
         OfgmwvGE0zYxtH9CSsUjgsVfNOvQ4TIgyBRVC7F9W0/WTv80hB+/+oBVz0651QKwS5Mk
         MLWQ==
X-Gm-Message-State: AOJu0YxbxqsdFyca4M2t6PhRCiofkIWGtwc5NKcD4RLuubFRiKU81v/e
	+8LMP9muLTWSqlSlAZ5rhYJ/mfQxh7PJZ0zuGOIPXDkKDeRPvKHIlzF5J/7SJH4gE2NVr0eGrV1
	LGwUp2IX7KfpU2woNnxYG/aeD0zdEU2U=
X-Gm-Gg: ASbGncsqvuEwz0lD0ion27gHs59ObXibH2lPmLbEIUXhUAQU+a5RAGV3L+e3VKkb1Za
	v0ZEmQgkOQx53Dla0uzzgIrHdjXca8YnMs38gPAHU+wdgorOS/6FOB4PsdXSLMdNkM1pvNDgj+w
	TMUPWW1chUwHyYKFam8z3miLQXolhHePrmU0TSrl/gO+3z1oa/XPQ4D63rz8xwfJFs7IPpnPCKb
	YCHZOxftAMJdmrH/EKAQ68gBrH60lpssWXVUSGXitm9hOGpJ/YsgtAhh5YAqGZvoK2QWQ==
X-Google-Smtp-Source: AGHT+IGvVajIc41VyAxCuPyxqWUXb2OrVTIXZXouCyBBkNWEtauVL8pGUlccoVwLRAWDPyhKgINw+5nh517v8WUU60c=
X-Received: by 2002:ac8:7c43:0:b0:4ed:b1fe:f87f with SMTP id
 d75a77b69052e-4efbda3957amr254551091cf.20.1764379203672; Fri, 28 Nov 2025
 17:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-13-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-13-zhangshida@kylinos.cn>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 29 Nov 2025 09:19:27 +0800
X-Gm-Features: AWmQ_bn06KtcfeC8pChk4HEBjz19bArSXx8IRJxxttyX3p2OYoBSLr0JgGawFZU
Message-ID: <CANubcdXJyE6Y5J3C5Zgc1jA7qSXk+_Hb0pm8Q-8cTb3Z_eM4sA@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio chaining
To: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 16:33=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Replace repetitive bio chaining patterns with bio_chain_and_submit.
> Note that while the parameter order (prev vs new) differs from the
> original code, the chaining order does not affect bio chain
> functionality.
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  drivers/nvme/target/io-cmd-bdev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
> index 8d246b8ca60..4af45659bd2 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -312,8 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>                                         opf, GFP_KERNEL);
>                         bio->bi_iter.bi_sector =3D sector;
>
> -                       bio_chain(bio, prev);
> -                       submit_bio(prev);
> +                       bio_chain_and_submit(prev, bio);
>                 }
>

My apologies.  I think the order really matters here, will drop this patch.

Thanks,
shida

>                 sector +=3D sg->length >> 9;
> --
> 2.34.1
>
