Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED015ADB4
	for <linux-block@vger.kernel.org>; Thu,  5 Sep 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559531; cv=none; b=L0TdHQcZAOJoBPXovblHvgRsX2bpJDBqEMKpvPLNrlsz6UEeOcdVpBLp2w99BHKiIas4UXbedkVUrUHXcPDnn9zkpdCmgpL+qFPpwnxNFIDL++3y2D46wE7Uhjdi+fEr6Haxi8I08O0Y+5ZjQtdDRHS0yspNFSJovOONklSHvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559531; c=relaxed/simple;
	bh=MZI2JoQqPT+1TUyvBMAYj2Fy1b8YO66CPBsCxJc32ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FusPN0Cbl9w75uvI/NCjmqYqST0p6awJJhz/DdNizmn5f7Xj46kjRrZk+nn0i4gNnBEk9usFLRCoVpmbrI3Sjbn+YeaIXlh3vkJPHurt0EI3+2YetdfIilb/xImrl0AqKKk2Q7NWWMo3Kz5Dfii8vm963gfUojxrVHu7xABMA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lFclhB5E; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lFclhB5E"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5334a8a1b07so1257749e87.1
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2024 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725559527; x=1726164327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZI2JoQqPT+1TUyvBMAYj2Fy1b8YO66CPBsCxJc32ZE=;
        b=lFclhB5EhQuTMcYdU+rcIAszTYkP6fo5Eqsmzjtk9GmSCaGYsZ8vi6tL+3Osx3RCEO
         5K0s8YAVc96+UjjwwQVseIKhaUGnjpOIkHfpHVf2aGTfzNCLno0iQfJQXyuF5Rcvtk04
         vBrqNwgbvtzoj9Xd2o2G9Ut+pcvtcRE53FbvSu7EOmNZ6hz4+ffAd8sUWu5CSYqnQnju
         6Q4QG5rtMQ3TiCHBV9kdAhAifSkbS3j2VjzfVlRsZFwufcbIpyScoIvqAjJwW1ZdYuEk
         T1+vh2xoYtTtOWsJaUDf91c7V195xcwPBtMl//A3yXjbGG2IupgOGBwWAS9KVd1Beo2A
         XnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559527; x=1726164327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZI2JoQqPT+1TUyvBMAYj2Fy1b8YO66CPBsCxJc32ZE=;
        b=ad0yjRISNHkXtPQKWecTc+LKAEb3D4xjSDvK2op6roeeIPDtBYhukszmlvyj0DA/94
         izA4NLjLfN81g5py3YIQwBCaxwFB52YQtb5m/Gnkz4oQ7J+Ub8Eiia4GxUjVVLY47z8A
         qvZH6iBBcAkT4IjPDyDFCFek3Zxl5cpLDmec6W9cFBGuPMs3TdcNKQgP43dTpA02S/4I
         98YBG8V3VjUXBSXaGt+K1+dDTBDLm3f4xmVWxxS1I9mKAH1TRoWPP9LGmkYPMkYZFLfg
         IVQCanQ950Xqge210pbs7/mA6Qdtd3ostvGXTG2LCNCPweOuGzzhfvVU8x1/OKj7f8uL
         /gJw==
X-Forwarded-Encrypted: i=1; AJvYcCVgYHqZBGONA/dzhqpQcKjH6r+A3mkkVWd1c27sk4HKk2Jjm8oJmJSrpWOJErRM6QnqqCJgj0Y3puIA0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKmDbEit2Eepwf1xdqn47dFyUSofvusrXd978bEHqAkT/B/+S
	I8lFBHi7mgO3CEwccW8wwYMOfcNXBkk+yVScy0KoDhHzRc+KApkgzflqWTXeRzDo6ldgrZeo2gl
	6cStXRctZ8cVelPDphfnSJRe4joUoBEyuwRFi2pUnjMrN2kcq0yo=
X-Google-Smtp-Source: AGHT+IGZUKX7OgGlN064R1QZBCjQITkoD+1UUL8i7hAnKBdubgpLorhSG0aB4gxrDNf29kJqsAzBUzsmOdpABNjvh1M=
X-Received: by 2002:a05:6512:ba4:b0:533:d28:b9d9 with SMTP id
 2adb3069b0e04-53546bc1e58mr15015882e87.58.1725559526495; Thu, 05 Sep 2024
 11:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
 <CAPDyKFoo1m5VXd529cGbAHY24w8hXpA6C9zYh-WU2m2RYXjyYw@mail.gmail.com>
 <d8d1758d-b653-41e3-9d98-d3e6619a85e9@kernel.dk> <CAPDyKFp4aPXF6xuuQf6EhGgndv_=91wsT33DgCDZzG6tyqG9ow@mail.gmail.com>
 <dea642a2-85f8-445b-ab84-a07d41acf2e2@kernel.dk> <CACRpkdZnc_6T6tQtCDZvWh_QMFqm6OJm+7Dk5A5W8UC5hV95rA@mail.gmail.com>
 <805c9f7b-49fb-444e-a81d-5b9d457bf262@kernel.dk>
In-Reply-To: <805c9f7b-49fb-444e-a81d-5b9d457bf262@kernel.dk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Sep 2024 20:05:15 +0200
Message-ID: <CACRpkdYr=baNp9n2GDtyw9zH5yzi5psbBWHu9jCitby2rS-fhw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: move the BFQ io scheduler to orphan state
To: Jens Axboe <axboe@kernel.dk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@unimore.it>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 4:58=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
> On 9/5/24 7:03 AM, Linus Walleij wrote:

> > Which production? For singlequeue devices it is pretty widespread.
>
> We tried it at one point internally at Meta, and it was not pretty.

I didn't know you used any singlequeue devices.

If you used it on multiqueue devices, well that can't be recommended.

> > Maybe we should propose these rules to the main udev repository
> > so that they also go into Debian and we get even wider use?
>
> I know you like to push for it to be the default, and I always push back
> because I don't think it's stable enough for that, and now we have the
> added complication that it hasn't been maintained for quite a while.
> So no, I don't think so.

The reason I like it personally is that it has actually saved me from
crashing my machine by preserving interactivity on a (single queue)
device:
https://people.kernel.org/linusw/bfq-saved-me-from-thrashing

For Androids and chromebooks it keeps the device interactive
during heavy disk (eMMC) activity, such as when Android
updates a pile of apps (.apk files).

> There are some bugzilla entries too that never got resolved or moved
> very far. Some of those may now be invalid, maybe not. Impossible to
> know.

OK fair enough, I hear there is a maintainer that will look after
it now.

Yours,
Linus Walleij
