Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B91DE4FB
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052366; cv=pass; b=l9KOz6DpbSxNMSt451DVfQayFB4Pl41/L2/j5Db6a8Kj898sUVG5VjCIVeTFsDF0GR7fznuyayLJOWRBzD0cCI9CVF7cTP9tgiQxjh54WUbviv8UIOtKpwDJSEKosSYXRUruXY6Qb7UHHBgp2jv3t6gtaUcxhHU9skai1Vf1F08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052366; c=relaxed/simple;
	bh=j6Xx27hPTlccEC22DYmtRMq6gdGktQRCb/LAVqXfVC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAoupiWBlpOUDuvmtXt9mP8Gs/yId6HpoltI/8OBbr+lwR89Vp8NJV2y6zPMglqlgluBe4Z92XOdUqCJWowwKzy3tkq937xWgrrkhegZnf0jfvXFxrQ7OMXM2wcp24qvqSyIRmA1/HSlxvlKSe6xbRshVu6HQH/GlgxyMej5IFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exI1G1aQ; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exI1G1aQ"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ff14dd9be4so560423137.1
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 12:46:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772052364; cv=none;
        d=google.com; s=arc-20240605;
        b=e0radAhjhWUtXHJsWqzLYQjtADTrNjjQTK00CNGlBETSxrrrAUx34sJVE641MEvBin
         AGbgAjh9BBZ1ksrVvwlttMh+w4xd5MzquOs5B0rgOqwDgPHDTKBFgiMAoc0kLh+oOx0z
         C9D8CGAYE00YqvsyLb5x82oD0LP7AyB3op2Su+ofBCUdxVfHyu5jZV5v5HTWIdN3/hAF
         xS8drggRCvo3NbLz7dF7AZ5b6aMYnZymcC7LigeAlfEJYDd2P+s5ZSoTZNg0qQtzbtQv
         /NG3DIuGmwCunpzScTcQJYjW5755hO9Q65MnnyWZl2cQLLHVeBdu5x09APH+ssCKa5Q6
         L3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j6Xx27hPTlccEC22DYmtRMq6gdGktQRCb/LAVqXfVC4=;
        fh=6aTRnNYy+2ZhPkOo3gIATOpV5f/iffkqI3lNRTGxN3A=;
        b=iX6L2JBH5u5EBmZItMDZQTm8JL7tOKYEYm8HVXJcDucyfh0Yj4Cy0g2c3VUe8SRh/U
         Zm/r8ms9qIth0/Tv8A+cv0nk8keOS415UF+MrgwZ88RTBpB6RPhztVxm8k+gYt14Jvkm
         ECwEIMTbDM3GayhxFdZ31u5A+qobwDmIUPzpi0hTtCGHZmuL0z0dyerhKg/xIR2liKSl
         KD4poFdAh3hHB6xXma6EDizUeMyvq6Sq9Z1wlzw/7xLaDZgucOSRtl0NdMb4k+4bEqWm
         6NlvoJ6s8n2EQ8POLnX4o5N1BU59fzxSjb15hk6AO5zrb0qU96vZDTHeud766JNyaOwt
         cLdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772052364; x=1772657164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6Xx27hPTlccEC22DYmtRMq6gdGktQRCb/LAVqXfVC4=;
        b=exI1G1aQQcSJkZ/PAlC57As2ruTq1l/zb6/mmNZ/3G59A9afgNgeJCtlisE687NXDn
         hiFfULAszdpEdRGtm1BbBX+Vmw8XJuSjD2iD19d8Ujt73RfXN4MfLZTb33ZOQAjpiuUr
         PgjgX+Ut/GQah7FvcGIa4i4SwjXP8V4qs1P4d/4l6WX0jKJjoSBLC5z6yEu3P/w/IGfr
         0ZiCi0fFl7o2/o8PafhjnwMcj1PzBT28Sr8cpJtonTsB3j5I796mT1duyKJ4QQyboNZI
         9yiSop/ei5Dzxyk3lXAGdLX49SOzTiFX+GFG+X83oEFbAfHcO3hCg97T72GcNQsjFQ3I
         pfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772052364; x=1772657164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j6Xx27hPTlccEC22DYmtRMq6gdGktQRCb/LAVqXfVC4=;
        b=H7i9inNq/fp6XkSVyU1gZxPzxMxZiGJDZCRpwbV9WCF1Lr0eUb6Bax/CgYXTbPZhmp
         12HxE8nATZZA/UiHKk2Me6YiiFW7VPn8t1qOXUHxpMoViUEIpBE6mDXTTsH2mkwUvz4z
         z0K+o1jVymL/4b+nQM/duDlL9J+ZzqCaJlQ9NVKTTYzcilT8LqgoDK5rX65gsKqU9cPJ
         FsYQm0F9OqZButdtegXqi+zUnxaNPlOrzkw7D8x4Un7I9AK9xtDjVxb9T9wdowTrqilm
         yugYWbNkZFXYNwFLAto5Ts1V+g8wneRMYOXxEgFueeAXpih9U81Dqzev/T2F7hEuc3rL
         VQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcPGf6dtlQCOqIDMipDoTPwlFn+b/uWZE35qqyFNm732NBV7lhJJU8kfQqx3JpdoKzwRaQPofvh0GB4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMkXeGY05RA+RqnKl2K1pAOiGKHVBfhyU8p052HjVXroLlkns
	7Bg1vhFxfrnrUUWc2/AXpKx5qUIqn+LT9+NNMOXB0B3j9Jqaxh30nICn4PBxIvJy5onAfI0N6z0
	K/rkf7rNH6GCpY+c6WG58twfJSa7uRwlHEysAatw=
X-Gm-Gg: ATEYQzwkn+0Vc5UaGse4dBUOfccegB0HBncZG330BmEC2IB/ESCjz4zIidoC9R/VDTu
	MqQyiTg/1+iobusEuED6RX4pAg+WXuBi5XrnX+VRYMq4i4+g2lZXeh48lBJrPRuyPIrl2DmIcc7
	LxeOpoJU2Ge57EwqlSUeTp4GoXGJwnXPCO5f5CkqbtvVEGZTPAFmvOMgm02eBw4aQIMeVkI6xUO
	q2vsdUulCr5mUN9/iSgw8JlsUSwlv8Q+mWskyB2zB81VT6zLbBt8YmKa9zi8DDFh3bgYx/+tS+n
	nSP2FY9kI0hSvPegoyPSAJyjzeSJpPHOsFblV/MQF974FZx+0GjsIJs8uys5qa0wPc2GBQ91dVj
	ypYM9H+PxvC4U5vM=
X-Received: by 2002:a05:6102:c0c:b0:5f7:307e:80d9 with SMTP id
 ada2fe7eead31-5feb30fa8c8mr9667021137.28.1772052363469; Wed, 25 Feb 2026
 12:46:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219004940.2594201-1-morbo@google.com> <9b7a107e-bc07-4a75-86b0-2685d4c78bb9@flourine.local>
 <CAGG=3QXcA7et9LmZ+Cu8zn1yBXrPizL7BhYFvfFZpWA7aUR3xw@mail.gmail.com>
 <e3c0a209-56f7-4ac2-b089-e0600672cf25@flourine.local> <CAGG=3QVHKmZzL=C808qnigYDC1jiNSdwCODYdU6_2_yXSLAaSQ@mail.gmail.com>
 <466dd888-0910-4e39-8946-004ac7cd91d5@flourine.local> <CAGG=3QW22piyPN6ZCAEiNDHyrRg18OqqyYsy-2s6m2ois=Rorg@mail.gmail.com>
 <43fedaa5-b5b5-4c65-8048-48ffe01e9b15@kernel.dk>
In-Reply-To: <43fedaa5-b5b5-4c65-8048-48ffe01e9b15@kernel.dk>
From: Bill Wendling <morbo@google.com>
Date: Wed, 25 Feb 2026 12:45:47 -0800
X-Gm-Features: AaiRm53SuA0mHCDV7AXqHnyM3kiM-txndX8xTU8ImCgFCgcM1QzIPGVNSqJxuoA
Message-ID: <CAGG=3QW0CXN=6WMbWxh=_pddzDe1hG5vrS-+EEJYAgScmFc22g@mail.gmail.com>
Subject: Re: [PATCH] blkdev: Annotate struct request_queue with __counted_by_ptr
To: Jens Axboe <axboe@kernel.dk>
Cc: Daniel Wagner <dwagner@suse.de>, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Gogul Balakrishnan <bgogul@google.com>, 
	Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 10:54=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
> On 2/25/26 11:26 AM, Bill Wendling wrote:
> > On Tue, Feb 24, 2026 at 12:55=E2=80=AFAM Daniel Wagner <dwagner@suse.de=
> wrote:
> >>
> >> On Mon, Feb 23, 2026 at 02:47:47PM -0800, Bill Wendling wrote:
> >>> Okay. I successfully ran the tests you indicated above and they passe=
d.
> >>
> >> Ah great. Thanks a lot!
> >>
> >> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> >
> > Daniel,
> >
> > Could you please change "Gemini" to "CodeMender" in the patch commit
> > message? If you like, I can send a v2.
>
> Not sure how you think this works, but since Daniel isn't the one
> applying the patch, not sure how he'd change your patch for you.
> Just send a v2 if you want some random name change done in it.
>
I wasn't aware that Daniel wasn't the person applying the patch. I'll send =
a v2.

-bw
