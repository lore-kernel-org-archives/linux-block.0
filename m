Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ECB2620DE
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261278; cv=pass; b=i9X4yhEJmj7Y2jphmZUznt0UGLtrA2yQtFUcpaD2u3v2XNXLRlqhIUZocyDTRGaxrQ9y8O4eHHXUCQFjeWBGsaBvGyZoXCvJJY2DTA+yIAlHpo5sDDa9xhNW61b7F73KKt7dLt2qbq0Geb/YVKEFoRLEqYZOMcIeaT3NRjMYBOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261278; c=relaxed/simple;
	bh=jjLEeyfM7aLe72MtknknZ7JoDQX1kZPS4u5VhFIwQr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PziRSROHR39kcsSzkKFL7Swk2gYdzkCSMszfbEHsRn3CSOfIkOXPcgYfa7qUYcGs0MbSX+5yn69hklS3mJRjoZvtNmBd6nNgswlYxIssr01M9TSVxqUAoFaVi2PjMvXQXfM75cSFru5qdfI7mJVeKZCmioPeOVNbnpySDmposPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9wON2fC; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9wON2fC"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-651cfaa21e6so3056164d50.0
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 06:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776261276; cv=none;
        d=google.com; s=arc-20240605;
        b=IVbzn3O3cK86fViYuHgIggXoxeOPCveeES1WdTbQD822bXc2Sh3pKry/TUSSSO5Y0A
         M7clJ4YClY5f8i4gIr8caL+nBCFFMvFEf+O+5s5mi+j9yqsNCRSvTBsZjbdV0TDabqEJ
         PxpMEb/Lt87zkKTpJz7U4WPkpmwiLU2GAR0CqL6mD8pASoXcavTM2/oSE3r4O6kNaoIW
         M8GmK0uvuO6AS+XlrQyXHPGRRRdIVEPmBeZXtkgHij7zSV3lYfkVtsUj7rOLQLu/Hf1D
         OEVZIDPY76s30jCNzcvQctV3Ty+WWSkzZNnZAOZwtZ654S6kCJ+yjG58qSmvixoENp7T
         QnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eiU5+/o+Dy2k6wBYHFotkArhw04FNZIcBj1PufHtM34=;
        fh=FPmerjXhDCWrF3amy/V8OPjYkJFS/7xzpIiZxXwnEmI=;
        b=V1SJxKFLrylO8X36Zjw6y2/LuCSovcwdp7Mg4PHX8QFmeQId9dw3ItR0sk8qZgn/k/
         YV91PFqbv4NMLUYr/bx308WTEO8ALEO/6GqtGFDou+i7URtFN9oJDWS1bD4QGwePQc22
         gQAf0cZ+bCngszd2LRX6E6oI0WVrxU1Of2SY9IT2boIYYvQzJVrBNlXKnl6IdUMk6VAL
         VietcSdG7/U+M9sQPIE2pcsGcZ+JOtil+VPlSqp53TBuh3FhRnj0871nJnwnJFTpa727
         n4LeaAxs2rxmwfPaEHbwEQ9u2FlnO6ek1Vh2taOjcxEnsqIxL4EXfJMCDEciXHVjDXea
         yjJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776261276; x=1776866076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eiU5+/o+Dy2k6wBYHFotkArhw04FNZIcBj1PufHtM34=;
        b=T9wON2fCDPGw9DksWKXifsoSol4P1ve9Qeo8Q/3XaynYrD69yJOQiWDOa1QXujuVNP
         RVrnZ7CFU4vf8FILQMXZO6OMK4skmaQ4K4Nnj7oEr5TodBylZVJDGPREhn23u7Cfc7Ud
         udq1NCY/mDLSBYnYLx9x6yFvOMYyuXvUzwcDr7sb6cMygCb7rCEFOMMZ1bZTTCSyhPMO
         PaIUq6KJklraoXCygtGp23pCDKWltZ8No2aNMIXvc6hhYOIOEMt7G4nujMEGR4wFfSeF
         Ge2BXVDmNny5O8K53Ybkdc16iXnohJty0+LfzCFX1PwFBD0W4MTPqTkWFxl66kCplqVS
         NH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776261276; x=1776866076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiU5+/o+Dy2k6wBYHFotkArhw04FNZIcBj1PufHtM34=;
        b=TwVSF7Q3h+ITDu7fbPsenHaYUtK+Vr/lt5OzA4bQ6cc7fIUm5K8+uOVwuItMU2kUjD
         WiJhcwCFETSGFcHyumVj9ZdtsKs3SKt9t75USrJjBXICHgNzb3OhnQ2k6Il7Wcd2jE0d
         1ICo+z7R6R+tb0ceOzKkotelHBXZN/u39rfakSpznZ/Mq5PG8le7wQaThszSWoBQUESY
         mtKh5Yhd3b8PQRPYLCbXUFixJojLWmfvvFz0Tu7K52mG9S9vi8KWqix4YbKhtEH+p9vn
         kscJgBK0hi7DgZxv4c1URS0wuBf25+NtErTEUoOYnKLFMJL4w+nCs28fse7Y/v2u/DOB
         bJQA==
X-Forwarded-Encrypted: i=1; AFNElJ8ty/L/T+05O/ItX+ydEntXRf9K3svsXM+ZRPZK6/tfO8qA8pMuN9yEvGUPkfMYsvM2WA3jUQOKxVqoqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVaJ/cl/m5cKPcDNJUSGbtOMmHvK3UwTxD6pvVJ/mHfpCkgrW
	Vs405T31pcqGQ8u77Ac2mixEraDXbV4pKEvwxBbxLwEgf8k0fhlUo1Vi2rH+rB2dNkuXeAhSZtH
	w3aZA/BPBuWDy2SQA4+cqAIuWSv1/gAE=
X-Gm-Gg: AeBDiesEWUaoetOuEYexWp3fITbCOteXx3cxg1pN1KTn2At7TgPjKd2hcjDsxTM4xgc
	AR5se9xRInmPu5jhsmBK56dV148oHd8q0Jt3BIfaZwJxEIhhNNagtW3FyBYkgn5A1RM8p+xLFxh
	4V2EOg+/IaNL3szZ5LIiDVil9dGxsqqHj36OEIEBWUzo+snMpMkfUxKDROg9BsCp9q9b0ZjIvbw
	Rva5v1+Ugbc+x3FuigXqDoWoR3HPR62djArfaLIsoF2my6gryDzwPGQaj9o1SGNMaSa1xUDyppD
	+lsiF/R6S9GZTasP7VEZ
X-Received: by 2002:a05:690e:11cc:b0:64a:d3b2:d3a2 with SMTP id
 956f58d0204a3-65199096b59mr16518933d50.27.1776261276068; Wed, 15 Apr 2026
 06:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413153114.3040093-1-lgs201920130244@gmail.com> <8afc6b6b-399e-4f77-82e8-3c0e717f765e@linux.com>
In-Reply-To: <8afc6b6b-399e-4f77-82e8-3c0e717f765e@linux.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 15 Apr 2026 21:54:21 +0800
X-Gm-Features: AQROBzDx705EQfjAt7PwyLxjDvSpfcDpFcg8DPIUUm7RnvZjSrOx98S0HD6UZyA
Message-ID: <CANUHTR9MQ8GGpgtGDgRCmjQL_D0jW4E-2OER4Q784xbGd+nJSw@mail.gmail.com>
Subject: Re: [PATCH] floppy: fix reference leak on platform_device_register() failure
To: efremov@linux.com
Cc: Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@suse.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Denis,

Thank you for the review.

On Wed, 15 Apr 2026 at 21:00, Denis Efremov (Oracle) <efremov@linux.com> wrote:
>
> 1. Let's use platform_device_put()
>
> >                       goto out_remove_drives;
> > +             }
> >
> >               registered[drive] = true;
> >

My understanding is:

For the platform_device_register() failure case, we should use
platform_device_put() instead of put_device(), so the failure path
would look like:

err = platform_device_register(&floppy_device[drive]);
if (err) {
        platform_device_put(&floppy_device[drive]);
        goto out_remove_drives;
}
registered[drive] = true;

>                 err = device_add_disk(&floppy_device[drive].dev,
>                                       disks[drive][0], NULL);
>                 if (err)
>                         goto out_remove_drives;
>
> 2. We also need to fix this case.
>
> platform_device_unregister()
> registered[drive] = false;
> goto ...
>
> Thanks,
> Denis
We also need to handle the device_add_disk() failure case for the
current drive, since out_remove_drives only cleans up previously
registered drives. So this path should explicitly unregister the
current platform device before jumping to the common cleanup path, for
example:

err = device_add_disk(&floppy_device[drive].dev, disks[drive][0], NULL);
if (err) {
        platform_device_unregister(&floppy_device[drive]);
        registered[drive] = false;
        goto out_remove_drives;
}


Is my understanding correct? If so, I will prepare and send a v2
following this pattern.

Thanks,
Guangshuo
