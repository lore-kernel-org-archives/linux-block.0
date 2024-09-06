Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7514AD02
	for <linux-block@vger.kernel.org>; Fri,  6 Sep 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613581; cv=none; b=r2H08cjfWBmYdGCOx5DTJbrIVVC7qRvVti4LtdNhTnBiELz2oN4rlr03zr3P1Nk/PsU/0c5NG2fvifosAtaCxuOIsGVTBpytSK22xq0ndbmADWAyvy1MrFuJMxQU+r0Tr6FhykQI5FSDqpgAEfci9SO14+JzgJGotJmrQsNjROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613581; c=relaxed/simple;
	bh=zlgEGvaO0mwBm9Y0cviQJdOiB/Hd76XGYSIn/QNgOPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PT7E7+JELlxSsHd+NKDMAF7+P2WX+tV7MQ1DYTO0NzORgY9e6hDcg+rcWk8pqzrVwf5PfohX+c8WFf4WADF2xXrmb4qWlkHL5KzZSwZbl1jApKJavFIs3ikjp/tPR7mfVuHh3Mvj0JuUE7NK7Lp2lVaa7N91Zg4KsBuxGm+88R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYIyLU9U; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYIyLU9U"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso1901529276.1
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2024 02:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725613579; x=1726218379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlgEGvaO0mwBm9Y0cviQJdOiB/Hd76XGYSIn/QNgOPU=;
        b=JYIyLU9U6hU54nUIAXO/eHH+NeLA24qsGAAsfrolcq9U87OHMU7IgfE9dqqLx+UPJR
         N5yWLvmJyQMr19vBxaqhhqa70kEDtkFevwgFdk+pr2k5enUvt/HzAFX/5IHXpd+d7u9P
         vZHiPTLjpAShU7zkFZViLgIVWPvkB8rGQVOf2lgl+0Cr1xPM6pCjIBfEw+Rfl/POoNPp
         c1PD4Q2/DRZNSkNBZTkO8peslEnK1ESvshfNqWjyxDnkdKbCn3+DDHYmJURfY59aYiU9
         2XHWIErGE33IKRfGhI6J5lXHJJsLccCJQDcLDTaphTwaIZGvouxCuojufVksdswg6cOd
         0QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613579; x=1726218379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlgEGvaO0mwBm9Y0cviQJdOiB/Hd76XGYSIn/QNgOPU=;
        b=D76e3SwKwqmk8PwlrpoiqWn/SPZuTVHD8F6nkxmeHbbHoKlJyLkbPlaOci6YXU0Nux
         gG8+GccC4mt6qL7r51yfpSpZFXhRTV0tnZUFm5oGrbF4CPgAGQAbJ8JuGICnOoQDbdU3
         fQ9kIMCpnX8meJ2RZkP+qSA+A/iQOWG2gT80G0Vtc6dKBFiEfgO4VYb6RK/CgS+i9E7m
         0OWQlh2L3IqYBBuGN69R3PgG0rz9/eHf6Sg/VRgA+4VtmNEOQ5XgYsOcbGwggNZfNWso
         hXOSKuGuEBpM6cDoNDp7JoBLJyTP9xS/Kdj3xNz0AfAt9AoTLEXy5EXCyi0Y1kjwEmtJ
         2h+A==
X-Forwarded-Encrypted: i=1; AJvYcCVP/0H3fmaCo2oXDaW46BrdaaKTa0Sv+47FnegfOU2LHDa91+Q9QQ+DjEkp7dny6I1KqiTMrdNEx8e1+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1iGHXEtswZR7moiV9SGJyw1k1dsmxPZ7ENXL3ruMfWWgfvnr
	HHUPWvoggXlXE7dkqX1XIhNuQIpFWUlSdynkfllkfXGzjlwrk6UgzGXthVyqKsNPdF1CO9wmYoD
	ntlKrKJDZsZ5vdjR2Tf5DCaiG4LWPg/imIgX8bg==
X-Google-Smtp-Source: AGHT+IEQhveipLe0kgAFzEV+OcUI/LgMXEd1VtfHS12t97hEIT4q5sW5xGf2x1tlGWQTK88dSL0ODPpNSyiMgItcjlc=
X-Received: by 2002:a05:6902:230b:b0:e11:6ae6:1bde with SMTP id
 3f1490d57ef6-e1d3489d816mr2400004276.31.1725613578877; Fri, 06 Sep 2024
 02:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905164344.186880-1-ulf.hansson@linaro.org>
 <b748a4aa-504b-4e58-9988-170e462401eb@kernel.dk> <CAPDyKFrgzuuDBMWjBDVFAzwTP30JeD+zP2mVo+E=P0MZwUepHA@mail.gmail.com>
 <2f2bd13d-933b-da9d-7ea0-5f875dec574b@huaweicloud.com>
In-Reply-To: <2f2bd13d-933b-da9d-7ea0-5f875dec574b@huaweicloud.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Sep 2024 11:05:43 +0200
Message-ID: <CAPDyKFrpbgWmHyk2HPP11dA5To9PTwdBLVLyHTVfUOVKYzTUeQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, Paolo Valente <paolo.valente@unimore.it>, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Sept 2024 at 03:15, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2024/09/06 0:56, Ulf Hansson =E5=86=99=E9=81=93:
> > On Thu, 5 Sept 2024 at 18:49, Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 9/5/24 10:43 AM, Ulf Hansson wrote:
> >>> To not give up entirely on maintenance of BFQ, add myself and Linus W=
alleij
> >>> as maintainers for BFQ. Although, as both of us has limited bandwidth=
 for
> >>> this, let's reflect that by changing the state to Odd Fixes. If there=
 are
> >>> anybody else that would be interested to help with maintenance of BFQ=
,
> >>> please let us know.
> >>
> >> We don't add maintainers that haven't actually worked on the code. As =
it
> >> so happens, we already have a good candidate for this, who knows the
> >> block layer code and does many fixes there, Yu Kuai. And they recently
> >> sent in real fixes too. So that's likely the way the needle will swing=
.
> >
> > I would certainly appreciate it if Yu Kuai could step in and help,
> > that's why I cced him too.
> >
> > Although, me and Linus were thinking that helping with "Odd Fixes" is
> > better than nothing. Ohh, well, let's see what Yu Kuai thinks, then.
>
> I appreciate the opportunity and am willing to help with maintaining
> BFQ.
>
> Thank you for considering me for this role.
> Kuai

That's really great news! Looking forward to seeing a patch from you
to MAINTAINERS and I will do my best as a community citizen to support
you!

Kind regards
Uffe
