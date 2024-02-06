Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740FC1EA80
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224215; cv=none; b=Jm139WAP1EbCxOtSAVeb5dxcS5B6q6TBwGUVZvIH31o5v0OdMJGhsNevgIbnl7JyiLLTVhlLQ9j9kPxrrs04gZxniNdVzHUSP5Nn1MTO3Sw27sPAKc4fmuXjiak2iAS4JqIH2wtxe7qFi74dQCewVzUeiH6c63TMAaBUGhTmAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224215; c=relaxed/simple;
	bh=5nc+dSrwAnzE25GipJSV9pefmc4RGp+04RrqQWJYpRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5ixSRaSVpeNd1br0hk5AmPfGLkioChXvb20BoAZJPH1daNdLGdAUo1vhQBYQuGv238COJ0rJDwXnIueo6ghI9p5FzLjJDR6l8XAsV7z9H13erIHKGCY5vgsU4z1d4Iwu4q/oZcpPla1Z0q2zZaNcXsQs/jL6oAytQzGHfh8UOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MVKFo0G5; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVKFo0G5"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-46d1bebe946so720349137.2
        for <linux-block@vger.kernel.org>; Tue, 06 Feb 2024 04:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707224212; x=1707829012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AGJfUloIH7xui8NFEtstIa05IECpt+Jab8Vg6t76P4w=;
        b=MVKFo0G5yWZsFjQnbNwhW98ZKBxSlpbKPOE2/9YwgJNutprtBjxNG0dwyzYGjQBF8V
         7LozfmDeLgLRWvC0XHjVvKmPmuTJJVxPeNIp03Uv+LaPjowziqE+Fk8TBtFBsPfSeFTW
         rG7ir/W6LElanTcwyBUtMVMz0R+/zgtuKPOuUHWJzKUZ3b4iAkTGwlg07N7B2Ft4oHpb
         wrBl3Ld9Lw6kBuphNyb7YHw4JDdmkBAcaHoZieOFbvusmiqMHp37TMvzTsYmR63ISyK9
         2qC1073eEH8ffHATaXSGliClRYOxzGEueQW4XO3DN/2ylkJ19CDJDXSezfwYo55Wujmv
         5YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224212; x=1707829012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGJfUloIH7xui8NFEtstIa05IECpt+Jab8Vg6t76P4w=;
        b=aXSfMF0swLrjzE6gIcBgvtc5AURAUUmjyhXMGtn8FPN94OTPTJefi6TdOkClgCo9ER
         XW3cShZ1LegZgWnw92zwhtT8HZ0ghzdnOEkgTHUfOnnetfKW6WF+skZycR6nK/8Ef0QH
         Sx3msXLjurumOeAKFyaTDRqtBVIPQk2DmvwR/4ebiRQLbhxQ06Ube12kmBkqjQVvUS7v
         agWMFOfxN1pvWB7Rnr83pksKqD6QbXMTyllihOjeiNZgR9ZwHfyVjtLrf4KWy5Lc+D1v
         Skjf6WJ+RrmWaT9EXMYbxv3pUVL31Qm0gG4byvGkcMY26tLnMjNg89LAvRK2bjl9qqO5
         N62g==
X-Gm-Message-State: AOJu0YycCUM+q5fejJBpnEYTjKdgFE+ezUQ+MaYscSFKoiJox172NQHF
	yzi9gh+celiFwN0W3S9s9IpZnpIOkV0o0RpevF14HuErqRxMqO+F6kktAh60IzvSskN2C0+ZZA0
	69Vm5euMG5bmyaP8RxsO76LSe9JpGsxLDD2rwyQ==
X-Google-Smtp-Source: AGHT+IFS1PZd7e63zNC9r8KPu6xCRNyWYmZqFgNbrdl0EFkTq/aO1Lm+I9bc80TlV88R1TjdJ7cY5RYVnQe3pc/jcBs=
X-Received: by 2002:a05:6102:303c:b0:46d:2f1e:3d15 with SMTP id
 v28-20020a056102303c00b0046d2f1e3d15mr2561235vsa.35.1707224212310; Tue, 06
 Feb 2024 04:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYttTwsbFuVq10igbSvP5xC6bf_XijM=mpUqrJV=uvUirQ@mail.gmail.com>
 <20240206101529.orwe3ofwwcaghqvz@quack3> <CA+G9fYup=QzTAhV2Bh_p8tujUGYNzGYKBHXkcW7jhhG6QFUo_g@mail.gmail.com>
 <20240206122857.svm2ptz2hsvk4sco@quack3>
In-Reply-To: <20240206122857.svm2ptz2hsvk4sco@quack3>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 6 Feb 2024 18:26:41 +0530
Message-ID: <CA+G9fYvKfeRHfY3d_Df+9V+4tE_ZcvMGVJ-acewmgfjxb1qtpg@mail.gmail.com>
Subject: Re: next: /dev/root: Can't open blockdev
To: Jan Kara <jack@suse.cz>
Cc: linux-block <linux-block@vger.kernel.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 17:58, Jan Kara <jack@suse.cz> wrote:
>
> On Tue 06-02-24 15:53:34, Naresh Kamboju wrote:
> > On Tue, 6 Feb 2024 at 15:45, Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 06-02-24 14:41:17, Naresh Kamboju wrote:
> > > > All qemu's mount rootfs failed on Linux next-20230206 tag due to the following
> > > > kernel crash.
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
> > > > Crash log:
> > > > ---------
> > > > <3>[    3.257960] /dev/root: Can't open blockdev
> > > > <4>[    3.258940] VFS: Cannot open root device "/dev/sda" or
> > > > unknown-block(8,0): error -16
> > >
> > > Uhuh, -16 is EBUSY so it seems Christian's block device opening changes are
> > > suspect? Do you have some sample kconfig available somewhere?
> >
> > All build information is in this url,
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2byqguFVp7MYAEjKo6nJGba2FcP/
>
> Thanks! So for record the config has:
>
> CONFIG_BLK_DEV_WRITE_MOUNTED=y
>
> So we are not hitting any weird corner case with blocking writes to mounted
> filesystems. It must be something else.

As per Anders bisection results the first bad commit pointing to
   ba858e55b205 ("bdev: open block device as files")

- Naresh
