Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172642C512
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348363; cv=pass; b=K3jLbWXXaJrygcriSDJl9qP09+PcTjiV/zLHfM3zkzL8SQPoJj0A7CsEFdvM+XThUfUakDmPaZkxoUu4psA/ajrBKO6FQy6r4+LtSVR5HNFPcCcgUf8qdSxRuTVMtua09OZbHtL94y0LAntxtQx8E7SBX3NAjMc5Wy0ERp7jVb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348363; c=relaxed/simple;
	bh=l2s49actFJXxa2n9yDBNLkid62Ol+lb08pUlkwv6hM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6vqFAD4RMYlWayoGEk8VJNQg1PzISyzpEWaQYgAC7nKqQY5zxCgPMrvthCzquL+a3LWa1GHw7mes6hAP1dWlBuSBrHyk4LiofUP65/pteFo69vbr7hRTkDDpKz6Pjj0xqr3C28hmd2PuiePzwoSgMU/H/3qBrviqnTdqayCYJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY4HvWp/; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY4HvWp/"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69fdcb13fdbso337931a12.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 11:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785348353; cv=none;
        d=google.com; s=arc-20260327;
        b=o2h3uQrf/0PofG9S+RoFl8lCXjfvyaLdh6ZTLMwJbOZ5K7mb6hG3nN2HFJ+xA2xwj4
         PisazsWIzR9wXd1Fk3gZ7tXXVU49rJmWIuQePqZVNnNx1qyBhcz1RgJrOpyJTWJ6rzwf
         CL3IXB6hPOTGNHOUDcwZmutwqw7d86hwF2nsjbuyy6Ia0UycSJALp6Yb1AtQX1xPR1ko
         JjWxC10tKH1v4fwSrGpJ3Isx7iGJb/3+gHJLdETH8al5Bf6TX5XGD1dTmwHwLwUZuSQy
         VorekRSOh74cHchuCJiNwj2MUqBIHTXiaAOF6feTUlxKewwvvPQ316tEse1VoMCAYYKM
         m5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=49lFXvTq+sDchsjaqszQLQWrDbstBqsIDQjrotBwPC0=;
        fh=g+tTyfy5XQOUpct0Q1xxU+5JoB9m3eqhnBGP/VRwUs8=;
        b=UdywC2LQ4uJOAQiJSvSactqXiIgoQmF12hxSd7zNSdKdci4U+d3j4g7XpXpX+5OAX0
         MAjYHoTPuTU86mfmZGT9u2GSziTUJc2mKexoh/pyJbH/pEQQF1WqGqYQcs0xS0ElH9Cb
         blZL0amj3U/9br/xEHEwPGmWlieSvYw+mr7Y21b0SQmvi6Z/lcCgB+jYPmBL8WDyR6hv
         JRvvL/COY4dKRpazULxpvUxcXzp/myIvzmpiHDm2fysdDFUpPF3AS6OQA3fNX9ymivAL
         rG9XAajpPLpQaxSG/KwU2uUTaAnSjKjOK2ueHyrBPTHxDdMGVzhwHLsRnPoY2my7tsrc
         Iq6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785348353; x=1785953153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=49lFXvTq+sDchsjaqszQLQWrDbstBqsIDQjrotBwPC0=;
        b=aY4HvWp/8IG6y7np20fpXdh1zz66Ves2eFyY6BUsigNZvf1nyo4pekyf2lRQOZijzb
         qvy3GT0DqeqckD4y5BK1s0+G1sWkrJ5eKvZxdoM6b2vM8oH45YYaP14RGDGLy4r8XLO1
         eApUD/qun7UEPhSDRHTwJwIuLHllPNmKWy/XwylddkA5thsyaU/GCPfL/hVqGf7YdANU
         xeZR/PFyP1EOswHfDC2s7TpBozhtGKKnZtHWNd589RBlq8H7Z1yJbEl1RHk5CzZMkACO
         5iYtGEbokGrvZkd3fvRTFqB+F388iqOLo/TI7Xwlf/gupDAKAyjjYG6Ti8bMZbhFoGAq
         9SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785348353; x=1785953153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=49lFXvTq+sDchsjaqszQLQWrDbstBqsIDQjrotBwPC0=;
        b=ixKIlgexC7cYrAI0UCJLrFXUc6KLbfGoBUx2eZZoz02GFr1rKu7aqsd9HpHEa4KlkG
         o0XGMQyr9M8x3WBgyUvoMDrjchebcs8VW/JHN3DULyzJ0pqnN9GJXbSK9ITD2avmC77c
         1GdpoBWIy41/G4AQyDcJQROjpaFmTNvgbpuc41U3PBIiQ22DFVcwmgpbFDApLu0gg2IU
         wifomlhSC81iUquIdkU5uGMqyh9tR2gAOIvdwjZEBjXfWJcv2ia2WL0SocEwo4dUQIU1
         S0e1UY7kl4awUdsou9jSeQlb4nVZoCmVBeURTbVSSK+j8lcqC5kmwHyjEkpSkqK4UIda
         YMFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJrz+RJZBZDaQBDh+UoVTdUMmU8LEm5BgSzhgUxOW9CwE6b6xYZMvF4eIxJhW3pcvkHRZfnECjj1k5Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0ne8F+dXTyb+OkKgbPPFjlNwTVBh/Sc+MX6HRMmMyt6BoqdA
	mVoHRYJCU2MzC4wjnY52bPiJAyysxd1onSVU898ryzaP5qL0c4eVbYHlzilk1oAc4cjIskfOBGX
	9ZSFm/PIBmOod652ddCKuwOybos1Bt/U=
X-Gm-Gg: AR+sD11sBUCGDps7m9s7SXmaq4k7J8KU9D8mR9B5Pu+mZw6jq1MAglaOlLdw6AXtKPO
	j8DlnE/EaXVYeZ1forQbTcZhzd3O3CqTlzPXpHZR+DNRyJkS0wzL0JbWmOpHxV2m3xY/Ms6sIS6
	VBQoaTluFO3stzg31IeTlq00TAJYhWKFYIwVrt1887mQQumtKXnJnqKMSW3x/7eU0Ri5i3ItU25
	Kz7vkRtcBIDXQiuHqNLPWRhAxGHcih0fAKhm/xYLcb4rTcDPovd590Do2FkWFG1W62M91nmniqr
	Rosz0Av7urhD1n3DQqi6gOtg8A3LEZ7ADCRP/11wmEDE
X-Received: by 2002:aa7:d045:0:b0:6a0:4bdb:2232 with SMTP id
 4fb4d7f45d1cf-6a052fd7b7emr1486891a12.12.1785348352453; Wed, 29 Jul 2026
 11:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727201257.211635-1-coshi036@gmail.com> <178532422849.2568853.3142469605707392497.b4-ty@b4>
In-Reply-To: <178532422849.2568853.3142469605707392497.b4-ty@b4>
From: Chris S <coshi036@gmail.com>
Date: Wed, 29 Jul 2026 14:05:41 -0400
X-Gm-Features: AUfX_myCfEqTt2vnp1u4w8aDpspSL6ueI6W81g7qGqLPZryGhb4Ech1gv1U8ZKE
Message-ID: <CACd_6n1Jy69wew4AdF+J5=kpYus9VZgOpv9OVsA+uASrBObuYg@mail.gmail.com>
Subject: Re: [PATCH] block: stop the timeout timer when releasing a never
 added disk
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Weidong Zhu <weizhu@fiu.edu>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you so much!

Best,
Chao

On Wed, Jul 29, 2026 at 7:23=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
>
> On Mon, 27 Jul 2026 16:12:57 -0400, Chao Shi wrote:
> > disk_release() undoes blk_mq_init_allocated_queue() for a disk whose
> > probe failed before add_disk(), but it only calls blk_mq_exit_queue().
> > Nothing there stops q->timeout, and that timer rolls forward: it stays
> > pending until it next expires, not until the last request completes.
> > So if the driver issued any I/O before adding the disk, the
> > request_queue is freed while still linked into a timer wheel bucket.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] block: stop the timeout timer when releasing a never added disk
>       commit: 26cb8ebbfaf713c82e142d08828d4d765057633b
>
> Best regards,
> --
> Jens Axboe
>
>
>
