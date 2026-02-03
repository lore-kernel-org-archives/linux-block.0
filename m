Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637F35FF78
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141873; cv=pass; b=cPfb+IyCObknDzZu1PD/6l6s4tC53PxH97+FU0AOc5PxeoNwFN7YmiG9Idk4WAv5l+s9boPv1oySLllcbo8usQ8jniamQel0XkKvtkbcpBekYadxsYlAf9SFtO/TQ7T2Sg+SLfUbvotgI3GkiUdWDQYZLVmgYyJGShTUyuHgLOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141873; c=relaxed/simple;
	bh=ytYwCidcj1ZfxhMTQ4AXoidrc2phSDiOOcBrtygsdqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SO7v91/7FtuLHTfP72m2h9yr4/sqVKJcpxhO6R3G63mFQWwjoxLrtTY+OBCd6YiHN1s8ZveUO04FGZaOx6zQRZkW+8wps8ng28QLuyl4kUwdis+QKJHAti+SjczqB94QJF+zZP/kSHTNos8/ib0KborOIy37a7DLltDB54PUSnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eXE0cyES; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eXE0cyES"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-382fb275271so57367771fa.0
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 10:04:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770141869; cv=none;
        d=google.com; s=arc-20240605;
        b=AQBBZuwp9R2BVR7wVzaD0JBVrzo0qNNXNFiXG2J953NTpdk0sFvReW15Ym2ETSC4iw
         j+etdPpr2rDD5IzSG9JDMyjVXKektz1wkYlQt1pdHq0hPGNPzTz1qRirBkC+pvK/a7Mk
         Pn0bQGBfEjd4Ykhitd+f9+fSPuchn6cEEupQsaBopWBkUajaeaPnBSpLfr6EUk8AzVV9
         iButhFewBB2IJMkBIx652kHHsUPDGFjgAmubmIpH8W5PrlQY0IzSJevkyFOLjkFgOi5c
         WvJkuOaxN8TQ/UB34pCTawG+7THW5OqC8Q9pT5IkZ3Q5JzPZXt0IoUQ/dNp/aPP9FD7I
         gOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ytYwCidcj1ZfxhMTQ4AXoidrc2phSDiOOcBrtygsdqg=;
        fh=sylfRndl5+cmJhXDbEybHSfw41dpe7C2j367TT2WsSA=;
        b=WlN1PxoT9LX6bNlwjW/1MUlcgMLKh5v3KmDadEj46GfqVxC9dp7dMpskirJPafSmDm
         lS6G3LjBVutVvnB+6YpJxm+zKT07Fzm39FCUB34SaC7t3M7bCN9t1VZg1V7etsLn7HiR
         DrbXwgis68WN348mTBHoR+sjyAFPV6JNpt4cHg3z72QfjMR27wk3+x6ufXFwT9utbp5B
         YaDhrfj3jQKBY2YGJ7B6uXzh/bLyC320xXHGF7LIv2RzH1g9/NVhGBLcm/Gb5JqQ/sOq
         FDtPw8KbhjnDNKeEl2UYkUAe/rSVj2pogzRF6zIkPWLfTDJjRx98ec7oJXRDHjiR206P
         tTBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1770141869; x=1770746669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytYwCidcj1ZfxhMTQ4AXoidrc2phSDiOOcBrtygsdqg=;
        b=eXE0cyESIsWMLvh9/TMioISFLNMHjO32UKvZ/fgELX4dHg1FPtilGJ40Tvv8IGcYWV
         Zwccu9fiKWsmpMP6tP1AP16OMYqCqfB2god07DmKAol/Jj6uxRij2ArQwWaenmOk1Zq/
         Gtg13XibC3hCcBuS+KhKUqjHN7TaraSAHdFP8k5hdkX4SMquXMgEO32U55eZ9iPUUeOy
         7aQbWbfanUmQ+JXKZDsE+fdImCF7f160guWhaQ7fMMrTbbS9ksS0MUlgOt+FAR75ztOQ
         l6Pz3nRDESamuNgj6ORYEGOAaWKr+HhsbPhJrCmMXfOoLO9lhcHohe0zfQpzOZ1zdDlp
         Xlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770141869; x=1770746669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ytYwCidcj1ZfxhMTQ4AXoidrc2phSDiOOcBrtygsdqg=;
        b=OmkgEseT1lJ3dgYxKaweB8/sUkbFDrcq38/hx2fL3LEwcpmyWDdAPQDuxM3X2+hQqW
         q/ek+36nwe/D5pPkQvlc7KNbGVaBhZrCv1E3vQX2YMYrFxqn75gsWVO6EpHZ8TOALP1x
         KVjE4uOZDU5U/Hzno4Kr7FpuOJcWFBeEmvwp54ZfB8cOGzlDZstVb3kacw2cE4qQN6Wk
         o/o46sN4ueE87QBdEp2UvsQTt0g4CF2tiNgEHjant9zWRv7NdDrdO42Gp7/NT2UTq9b8
         RO/YfPrWfpV2VwAyjCbuv1nxxHHwL1GmD98Y2V5FzP7v5yt78kZNJEqYT+Gzd82HPcZB
         6n/g==
X-Forwarded-Encrypted: i=1; AJvYcCW/mIEJPJyL4slOM1gZbda1kk2uAkebYOZvFWOrCc5GI9LlosmgYgjSg6A4H7TX79slDT2fq+yYMmu7EA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbOpmx4mt1czysdr5ktjoPAGUwKdb1+FWA3oUznBYzJLzUfLsv
	prMfLQJjffVTByYZE9srgiRyG30kI2iTqkbQgBlP0aVPbw4OJkx+i6xjVjh8igdvMTiGmgB1Sq/
	iUlU9LmBVAAoQQs0y6omGvMu7Jsky9JG794XqbKIBzA==
X-Gm-Gg: AZuq6aLoXvOiuMlZMGPtxP7ftBWv1np432vrSKnlGaVXunr0fO4JUipBxU65jSoS2kw
	0YtpjLewDUKv8cNuAE8znCpfmQ05JXQPb9rv/in7/kR3X9iUv9ppKJfE1huHDfQ6FROJxhEWCDm
	utwW1bLJjs4CeVH0ja5j5kjVUOpqyxiX7yJKtklDyOoar8TxUkkkvYzfY7q5nn/sCViryTMKA4h
	tXHopDbnPaDtAPFlIhmd4JlW7LoGoxXuJ6o1FOvnB1c1xs6sZFXHGBKTtPQYA4x0XDTNI7oABcZ
	89rG7/FrehAGJen0ghWA7/FYdvW55JJCl3SEJ1Uc8Ce/TMOq8AjqRH73KwUQeQF/EpI=
X-Received: by 2002:a2e:a781:0:b0:333:e590:1bc9 with SMTP id
 38308e7fff4ca-38691d5a3efmr1687251fa.24.1770141869274; Tue, 03 Feb 2026
 10:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
 <0ea1530f-31d0-43b6-b35b-1286fc58fd19@acm.org>
In-Reply-To: <0ea1530f-31d0-43b6-b35b-1286fc58fd19@acm.org>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 3 Feb 2026 19:04:16 +0100
X-Gm-Features: AZwV_Qjg8SmH7Ay4zCR1POFb3pPHDAJcZFKMacTZvBFF9JokfkAj_W9kOXL14Wg
Message-ID: <CAJpMwygcLdvWNSwj0uy=FBwZyu+DhQSPCvc=CJfiLRvmbfwsKw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication solution
To: Bart Van Assche <bvanassche@acm.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	Jia Li <jia.li@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 7:01=E2=80=AFPM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 2/3/26 7:09 AM, Haris Iqbal wrote:
> > We would like to present the idea and internal workings of the
> > solution, and also discuss design and some benchmarking results
> > (comparison with RAID1 over RNBD/NVMeOF devices, or DRBD) during
> > LSF/MM/BPF. We also want to get feedback, and potentially get more
> > people involved in the project.
>
> Please include data about the time needed to recover after a network
> disconnect. Is this time proportional to the size of the replicated
> volumes or is this time proportional to the amount of data that has
> to be resynchronized?

It is proportional to the amount of data to be resynchronized.
RMR divides the disk space into chunks, which are then tracked through
a dirty map in case write IOs are missed for a particular leg during
an outage.

>
> Thanks,
>
> Bart.
