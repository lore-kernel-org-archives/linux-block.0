Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1E237F8CC
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606509; cv=pass; b=CZ3OWbY3zOCwPxsssDp4FSN1En0OXOcbSUGw89x+m8K6F87orOq65WU+EBt3KjIh9Kymm4+nDf36u5os8gQWUQlJnw8OvEOfm7Dhf5LiOvD9FnIrQRgKDqp3BKRw3y0Er3M1/jlQoGOz7AsZxnkc85xCJNE8EK7yW7p9yonN1wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606509; c=relaxed/simple;
	bh=x/1AQIzKqy3eeGcRuT6KpUmiqylazmvdAnXXk9TfUJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uurGLeVQ7ihPnw7mmvJtJWfqR9FCf0DkrfTB1UJh0fPgH8fYdrNFx6S98+P2189Ilp7CMHl4YTXx0XPLdSkMWq9pEvO++C6lQO4cheRyEmTDYL+rTiVqohXSH3WnDam0WZlrR3wciQfXB3SoBgKd2hO5ukl3Y+296y3vlxNOQp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Izzjk3h1; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Izzjk3h1"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506a321cc53so74676131cf.3
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 22:41:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772606507; cv=none;
        d=google.com; s=arc-20240605;
        b=Suhsr4ufe+D84gh6azEdFRXqequaf3ubJ/k4YNIlZ8E368nYoD1lL0LPtvEs/DGjbL
         Y4qnVyogJRmylaxifZeC8IIBWyo+gCRg+0XbT76+uuoK7jQwSVL/9rKVvzumoYp8qiHH
         MwQtFp/aoSQYnZZGCoAwQTNvjp5f1ekNOz6+Rhy6GJA+4m47cQUW2YQjZFFqdjOqdDK+
         z5ppz4jO1YxEXE3f74CuO+9CO2Vrn8BBdFWxVyHA12vPFYEbrwVh6j2e0/rxBYTzSPA3
         sNVIsLkUY1eKCKKgCUgsFgeze93L4KaW9V8sUnjl07dvFr6vJRkEwRdgAj1m54UdMwHq
         +0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fY5RR3f2cBt4YkmJTXjStwDUAMcp57BFkt8Mktxrb0w=;
        fh=0jJr4C4FbHoRFkMm+upMCCUJ+4PKI604T45NDvzk7Gs=;
        b=DrU+rjtXZUPcggL/cTfPGTHdl4fUj4f/FD9aP5G5qIv+ofU1JOODaxGldQkb2Fm0gl
         4fpGShymYuCfK4Mg6ZUxjzntssyA2viHSHoI59RqaT5q4UsxpdZdylwDx6ry6E9mXyHU
         iUC2AiWcaLXl6k4hFAsRyCtyXW9fhrGQGeFxFceyp+sIYDs53Jh3+qW/QCDRNWMBa6C4
         C/rcYoytAkDhRd69559QgaUwrC/MulOrgnXRyUKu4HjSUSGL+KkCpPGnMu2/bCugSQBc
         VlPNUZiPXuuVQSzGx5BRWS4FD/yoyxtpTkNxcAgPnCimm2FL0hB40som97oes9IDI/LJ
         /mGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772606507; x=1773211307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY5RR3f2cBt4YkmJTXjStwDUAMcp57BFkt8Mktxrb0w=;
        b=Izzjk3h1cixtDsbVl43RD+4DcYQiY+2FCz5O9UEYUqeX8F5N47MWh6BF56uiM6O3Iy
         37IJcGQ/4SVg5bYEM6JHezJPRXHliwGocZEwGfV9aEfaT3yJ/O4amznXE/GYtDknSJu8
         toua3y9QplyRV33C9HAPIP2jFJnvErJ5uIgsnV3fH9wbD1aPXX7qeujJNbPhixbEoZRF
         cm3LFfNGY/HnlS1L8L1760TLpFmQUrdskytgjRO/lo3h+DBGuclYBFCDVcsU3Li7Zsb6
         QACm/+b8i1wvM1Gm+btaY+DMj2VVU1G4M0nRgW0jd+jGnzPKMtHlrJkdPFcnNnwXILg4
         p09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772606507; x=1773211307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fY5RR3f2cBt4YkmJTXjStwDUAMcp57BFkt8Mktxrb0w=;
        b=RyE+fOvhNt5TjUiajHjmdcVogXy1MEBSg8LSRzzyWKDNG6SYVCf3bvmEg1AmpPgeI7
         YxXN/xwrm9gO9M4n3kh8Eg97vxHuAB40mXqDkiLOzRfdR7JSeibwBO2Ag/X0FbQYiJF5
         cBBFDJkqY63oltnsVeCcl42S0+MX+FJAznS5uGJeAwKgeaaZi5NnlsK7Hz5QgU/A6oJF
         vGfnInnDEVOOkwOCVfB/XyeGD6HAo7I5Zc4xUc5ZBxYSfGytmYqoqQYf9rmIUMZ3PKjG
         ePo06G+xqLALahfucKAvlWq6PZw7mItUL+NuVS2DoqVCTEgQ9QghfCzx5Z/55QIgP71+
         dyag==
X-Forwarded-Encrypted: i=1; AJvYcCWK4DjHP2zmKMFAwEbmi1OBM8n3MSilnOpkMuUu/iiolO+z+5cUCt2UJ1FQnA6p+OaJmq9/eQqgKrCrMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4k2rqOL0R2JQVJmBR+6dLonSwIyhFTLjst2rtdDBKUGW+l38l
	4Un52EVbAiOz3r+QHETovFJRzBw9YoZSqtLzCXBwsirGYPPd72o1uwiULFPs+x/vBKdjNQE2KDZ
	t1XFk4FzgavQmUsurtZRdCgkPXBcJY5Q=
X-Gm-Gg: ATEYQzzdrn0o5+xbk3VdTNW5FF5grxA7YXSTniIyQcoqMZ/U5erkwT/EsTvRnOLqZkB
	RCIAp0DGYKH+bTGbB9/SZ0Rnhw9pDqom/fCOTpK+KJ8NcLMo99RJ+0prqIMHG83NGk/s7zppeJf
	NhYKs10yBr2nrkXKaA2DNJ7IwhqVhzDMNKbZS1kMTuwgiBgw0J2ZCGU8ybZiZZp3vbm68YNI0uc
	o3PTPCVMoo3qoJ+HaVXR1MnszmXTJDC6UzgS44iQKLy4dPBgQ5Xlx1pj2BE+Yxs7dQqQEqvFAH2
	amSILw==
X-Received: by 2002:a05:622a:11d0:b0:4f4:c104:8e9f with SMTP id
 d75a77b69052e-508db41c1fdmr12539911cf.75.1772606506980; Tue, 03 Mar 2026
 22:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212-bcache-v4-0-215f3fde1c84@suse.de> <37e2c5a5-d797-4176-98c7-0e43abaa1af8@flourine.local>
 <aaYwWwGHdoc1uMCu@shinmob> <f7cff08f-a3e8-4b2e-ac7a-a56d8ed3f2d5@flourine.local>
In-Reply-To: <f7cff08f-a3e8-4b2e-ac7a-a56d8ed3f2d5@flourine.local>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Wed, 4 Mar 2026 14:41:11 +0800
X-Gm-Features: AaiRm53iNAp6g1g2jz5IP61Qal0wvsHlURp_wIEZA5Nd2eRgAa8MqeGIj0LN7AA
Message-ID: <CANubcdU92Uv7wNdZH357LLTnfwPouekXNTPSjHnzYzK99-eZ9w@mail.gmail.com>
Subject: Re: [PATCH blktests v4 0/3] bcache: add initial test cases
To: Daniel Wagner <dwagner@suse.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "hch@infradead.org" <hch@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Coly Li <colyli@fnnas.com>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Daniel Wagner <dwagner@suse.de> =E4=BA=8E2026=E5=B9=B43=E6=9C=883=E6=97=A5=
=E5=91=A8=E4=BA=8C 16:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Shinichiro,
>
> On Tue, Mar 03, 2026 at 12:57:18AM +0000, Shinichiro Kawasaki wrote:
> > On Mar 02, 2026 / 14:54, Daniel Wagner wrote:
> > > On Thu, Feb 12, 2026 at 04:23:30PM +0100, Daniel Wagner wrote:
> > > > I've updated the v3 version with the feedback from Shinichiro for v=
2.
> > > > Shinichiro, please note I did rewrite some of the logic in v3, thus=
 some of your
> > > > comments didn't apply. But hopefully I don't made a big mess :)
> > >
> > > ping
> >
> > Daniel, I wonder if my replies [1][2] reached your mail box.
>
> Sorry, no, they didn't. Yet another hickup with our mail server...
>
> > [1] https://lore.kernel.org/linux-block/aZQZkjEUw9VnVauX@shinmob/
> > [2] https://lore.kernel.org/linux-block/aZQcH-d-ZcgtMoJb@shinmob/
>
> I'll work on this then.
>
> > Today, I tried this patch series again on v7.0-rc2 kernel with the
> > TEST_CASE_DEV_ARRAY below:
> >
> >   TEST_CASE_DEV_ARRAY[bcache/*]=3D"/dev/nvme0n1 /dev/nvme1n1 /dev/nvme2=
n1 /dev/nvme4n1"
> >
> > And found that new files named "nvme?n1" are created in the current dir=
ectory.
> > Do you see the files created in your environment?
>
> Will check.
>
> > Also I saw the failure with the message "ERROR: Accounting leak detecte=
d!" as I
> > noted in [2].
>
> I am not really sure if this test case should go in the current form.
> I've just used Stephen's test case as input for figuring out what kind
> of API is useful. I also see the leak error with v7.0-rc1 which has
> 3ef825dfd4e4 ("bcache: use bio cloning for detached device requests").
> I might have done something wrong here.
>

Hi,
I noticed an issue with the test. The 100% utilization shown by iostat
during active I/O is NORMAL! The test is flawed - it's checking
utilization while fio is still running.
The test does:
1. Start fio in background with --runtime=3D30
2. Sleep only 5 seconds
3. Check iostat immediately (while fio is still active!)
A real leak would show persistent utilization AFTER all I/O completes.
During active I/O, 100% utilization is expected behavior.
To properly detect a leak, the test should:
1. Wait for fio to complete (wait $fio_pid)
2. Wait a few seconds for I/O to drain
3. Then check iostat
If utilization is still > 0% after I/O completes, then there's a real
accounting leak.

Thanks,
Shida


> BTW, iostat could be replaced by reading directly from sysfs,
> e.g. /sys/block/nvme0n1/stat
>
> Thanks,
> Daniel
