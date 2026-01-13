Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728A1D432D
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345398; cv=none; b=QxenMvb29zi5Zeft7jjZuhaJiwHUqp2Ll7VLzpNPHJ5uZ0Ei8hI/wD2/BPBDiHmmqgnTXSsL3MkIX1MeeSuFSKUmlM4fEV+p28/bKxmHO2lAuycEmSbdm3bAJhk28uYXEJG6/sV3uMNL2OToL3C7gGzRLemKaZQN4B/FJCXiFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345398; c=relaxed/simple;
	bh=DLUQtLERLNwRaPN33UK1ZJMcDt9B4T3wAuLNTkTLACg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxklXK2R/aIeQjuowCYyiRz2UjmqyhZwGVyzlvp6c6zvY1HcKAJ78vbcCQjSULzoOxg6oAMse1x6/iyTLgaMUJ36pIPwPe0qu9krkxQoTfP9DDwPRmZWc0cU/0RUTz1nkVegazEMFhd+hXrtL8CERmn5bxw3FEDJ5HNGnXJLw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Uqhplque; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Uqhplque"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ba3ffd54dbso1187112985a.1
        for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 15:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768345396; x=1768950196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sBtfVDhWECKW65J8QkyAk1WDlR0IiK/4xy6P70mGgs=;
        b=UqhplquecFMPoZcebUpiNd5I72xbHa0ALoSnQIW1iAab3ZCM+1/fCC/xhD7xWdjqmi
         7wuyBN3f9a5jCj6nubvfp3ULjoqXhZGky7WC3yN5R+HwQ8HKhXHWv6eoDQUIS4TAv9J8
         xNdrMGRY53CeNXGka/QBkC+XmfR1BlWzn1yV8a7kkn+NC1iRMS6eDrIYcyWieQJCyn/r
         VTGct9luGgwPvADDxKy/RQbg6VYsvE4+SUeM6QX+lmHA3DgdS4LSz7D09L3rcLc7Z+5S
         YoGqaoqL4JgzGfQn2X+gAZgvEVXhcFuKkCD6yGer6IbKKK0t7CNOjZCcafUoM59VLhWn
         BWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768345396; x=1768950196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sBtfVDhWECKW65J8QkyAk1WDlR0IiK/4xy6P70mGgs=;
        b=iPXE5O/MBz76rJ093nHS8eydXNGX22jKLDKpUoDqeHksryyT65aXgQkNTw+bkTfhrr
         ekE7jLtsBHY0WbxQasvGAHOvR8xpEcJpbSr+VTVSvybdRbkMM/J5JHpPxltO5ziDypHd
         S0zB/4P14ecF2LqSkVAU5wg6j9vvJiS5VaBQzAsC4iUQ6ymR04ekTr/LZBpaoD+Pb/Li
         svTus9tdYg6/vUo78Z7kqn3XzRXjmjOxQEx+5dyX8VadQivdZXHO/QrQW8IJ71ISf83N
         b0ERzPsIY/nJ3+7jZTHeGuBY/skp7idctdk6otGMYwbY9rd8ts2j5G0NlV/SC38qxKNM
         koCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTUKEHqlxwF9mE93XqENJ5L7WFffeU2iDdJEHs0/nF/5tZCtX2ij3QJShEuD35k297E0CSYPFOVfTCMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCmsMfE4LkLY00/M6zyvzosp/C+AKgGqAhHKVC976NRhxdU3lo
	2kdbG+ne3eqlzGqeV67GZbzXjy4/5Wy77RijvLxSe19MsVKELsn7N4O7RcWlRIPhkvFKrUAFoAm
	74f3eWNQG3Ztk/LXe/XODhyL+GwYAqJPQWAvlbYLXxw==
X-Gm-Gg: AY/fxX4ePMKyJuNOqsTKx/pAs6gQyqnd3KWx26jfjoaYm49Gw2930roQO9me9PYyfiy
	G3pMsJi54M4dlsLJfD7hkR5IQ499N5qhic8KwLUAspWcraKrpniPyO66JnL92cu8drIkQxSFcpJ
	B+XcjHgesikysnwjPlpkX/dNGbris1G3sRKiOPPrCBIS8e03eP+KjQZCLfUbPR81VTryrd/b4Ds
	8tHhRvcOkE2b1xpMYjPahS1NaU/TdAUdcjB3y8EaZkd5eBrds0jIM442WgQ6oLH9kzxAVBJCfMe
	ihfuSm6BsvugpT7k
X-Received: by 2002:a05:620a:7085:b0:8b2:730f:134b with SMTP id
 af79cd13be357-8c52fbe2509mr130212785a.50.1768345395573; Tue, 13 Jan 2026
 15:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
 <20260112225614.1817055-1-sconnor@purestorage.com> <aWWnhX7h3m9w2wc6@fedora>
 <CAB5MrP5mezn9rWZmykXTcc5-kLRPScu79xQsd_4Q7L=X=hn6dQ@mail.gmail.com> <aWXAbhyzVvyCuqBQ@fedora>
In-Reply-To: <aWXAbhyzVvyCuqBQ@fedora>
From: Seamus Connor <sconnor@purestorage.com>
Date: Tue, 13 Jan 2026 15:03:04 -0800
X-Gm-Features: AZwV_QixCy1fqrfXozymGCFhk4A0QTTDDUZjwpq0Kd9R882WVlZmiMw9nq3uJMw
Message-ID: <CAB5MrP7M4TU+Y87QyM25kcqWX-mCzkdgWMn_CrB0oT=1aA1AJA@mail.gmail.com>
Subject: Re: [PATCH v2] ublk: fix ublksrv pid handling for pid namespaces
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Caleb Sander Mateos <csander@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ming,

I did the following test. I updated kublk.c so that getpid() could be
overridden with arbitrary values. I then added probes around the code
change. I tested the behavior of the change with arbitrary negative,
and positive pids, confirming that I covered both pids that do exist,
and pids that do not exist. The behavior of
`pid_nr(find_vpid(ublksrv_pid));` is correct under these
circumstances.

Of course, I am happy to add explicit checks, move to a helper, or add
the tests I mentioned to the suite. Let me know.

Thank you!

-Seamus

On Mon, Jan 12, 2026 at 7:48=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Jan 12, 2026 at 06:46:06PM -0800, Seamus Connor wrote:
> > > `ublksrv_pid` is from userspace, so it may be invalid, then you may h=
ave to
> > > check result of find_vpid().
> >
> > find_vpid() returns either a valid struct pid* or NULL as far as I
> > understand, and pid_nr handles the case where the provided struct pid*
> > is NULL. Is there another case to handle that I am missing?
>
> pid_nr(NULL) returns 0, but the stored ->ublksrv_pid can't be zero, so th=
is
> bad condition is always covered?  If yes, looks it is fine to not check
> NULL `pid*` explicitly.
>
>
> Thanks,
> Ming
>
