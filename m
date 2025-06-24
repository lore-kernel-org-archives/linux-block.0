Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684617A31C
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757632; cv=none; b=CoZkzwz7hxKk6/W3DBY969uijcw4ZBhD40xSVT13JdCV67lJmbL2+k9VkYay/aDnfOHnxMoMtMxqeWJVVSnNNeZ9eBifUorJxSwaGfioKNzHO1N3+0qEdz4mzZVqdhpDO1LwuJg27QwMcxTvUnCdum4yGm8jlwfa4ev27GOLxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757632; c=relaxed/simple;
	bh=mrTpQtDhHMRn9F/VM25OmLivlUusN+nmdGZNJmbDZ38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxldkWHAruWAE9/KzaUlmQdKUTfkZXB7yzcfvlQh74RrAU9gUIjwe+xrnYAwmByI10Fl3LhQv3KQ+9KEDUHc/x+Fh4J7+ayQfXvZNhjycqEga4F/mNLJBTtZksqjJM3Xgc6AijMWRJ7sbuabrCUNexZok1nyH0VS9X87YbWec8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HYTv0ve4; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HYTv0ve4"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-60634f82c77so1288658eaf.1
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750757629; x=1751362429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrTpQtDhHMRn9F/VM25OmLivlUusN+nmdGZNJmbDZ38=;
        b=HYTv0ve4mZDlxXv7Ph/aXvsmbpiZHsebMcj0wFK6fFMlt7uCoVn/RuwWmEGYfC21xX
         TWHd5jeuG/8T8YFG8sPyT4xQhnjRfKm1on37SpIM04VZf4iwhB0qL46KxPUjXMuGmsnZ
         DcUuRHqgh5759SLikNTTm9/WLLf2/sPul1l1QTDjU/APE5goozTVqbWMx3zFXfkFBlpb
         tYUGqGbW8H5nuCADeUmzXRs1VmEKCVPpJA/0q5ZVJeQ5ZirbDzD4DO1nVwnLlYJGizmU
         cr0VSFhVFS5h5w9De2gVog5JalgUDv7HOu3Tckbhbj/q68sabmHQs/iTby2t71HCvRoY
         bUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750757629; x=1751362429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrTpQtDhHMRn9F/VM25OmLivlUusN+nmdGZNJmbDZ38=;
        b=oOYORzP/JFKVcYnWSqZaWZiP7gMkkZ3fw2XthfhAWYy7fGD6PT+PCQgchfBkWb7aMU
         o1rKu0CmOkl5VjyvszVqP/AOlGOkjf7ugeC4Wa7dlcvVAzNwxHxw0FaNzIofXIjaHgZJ
         aQzycC+8UvvaDZeWcpSn7PXd+B0pDyTp6pe0uEe6c9yJM5n08tXiBwQ3YPToHiVJXfub
         iBUcSgoivc+CCu8cIZ2RZy1xxhLKsEDL3Oc3g67KxB7NNYzZ652/u0o2fe/lG7lkm0ka
         193UgQtNSoBSZHuHQ0jtRgELZ3V3dOxGynJ83/0I6ZIKCFMJ3v7QUS01PInJQh4W1IOM
         S+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVdi8Kw574pHF0e0bZRRXiEzXo7/GblPdob2Y9odFFWmGNi5KsMCx4ykHmdktKjpJEjm2Y+R/QFJWlQig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RzJ689FEGdD68SjzmX2JkbvrPU32/dWYaB9lgzFBPSObQNp0
	artAxf3U3bzsl7vgBMnBq92BmMbm37U9GfOvmvzQVhtsHR+6zf5lMCGPgvP96u5MbDSphOmnExy
	X7HlEtlTHZsrHt8MuRUsYkdQaOjiKfJyzVuPEXEGQ9g==
X-Gm-Gg: ASbGncvHbHcR8/PfWdVS7qaHkSwz00w1OWaSpN6xm+7sQm4UZuluEEjEL+Kklc+vaQj
	qCsFlvWNY97Xpo02Ae4nlZcKfJuMgPGwXtMivB5SO8WWtdQiVsTpJiIMtnoJh8NN1cKHA2O0M7x
	9H/q17bps11M1MHBzFF9yjO/4byEgVOX5JnPEVn58JAkDn
X-Google-Smtp-Source: AGHT+IFZ7BwR+XKiOMietB00FrkLfhfR0D6wAW7dBgAeVwLlOXGvxdaEYJJ+lfHH2odYUJVMZzzRjTGJxWzWKv7MmcE=
X-Received: by 2002:a05:6870:af0a:b0:2e8:f5d6:2247 with SMTP id
 586e51a60fabf-2eeee5dfa61mr9939937fac.32.1750757629271; Tue, 24 Jun 2025
 02:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623111021.64094-1-changfengnan@bytedance.com>
 <aFluCdqZ-QYXOKf_@kbusch-mbp> <ab941c5e-43da-4421-a90c-c7efb73ed8ce@acm.org>
In-Reply-To: <ab941c5e-43da-4421-a90c-c7efb73ed8ce@acm.org>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Tue, 24 Jun 2025 17:33:38 +0800
X-Gm-Features: AX0GCFupQ9-8cDA07VMgrpzESoLL0mS74WC1-fgXtWbxnWfiE4KOrwX1usG9uDA
Message-ID: <CAPFOzZsk_vXkvrimOEj-5e5u0F4YukCNO9WhPB3kT27Buk6bpg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] block: Add a workaround for the miss
 wakeup problem
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I didn't explain clearly that this patch is not meant to solve a kno=
wn
problem, but to have a workaround in case something like miss wakeup
comes up in the future.

There have been some miss wakeup issues in the past, and I wanted to
provide a way to alleviate the problem.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/blo=
ck?h=3Dlinux-6.15.y&id=3D5266caaf5660529e3da53004b8b7174cab6374ed
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/blo=
ck?h=3Dlinux-6.15.y&id=3Dabab13b5c4fd1fec4f9a61622548012d93dc2831
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/blo=
ck?h=3Dlinux-6.15.y&id=3D98b99e9412d0cde8c7b442bf5efb09528a2ede8b

Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2025=E5=B9=B46=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=80 23:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On 6/23/25 8:08 AM, Keith Busch wrote:
> > On Mon, Jun 23, 2025 at 07:10:21PM +0800, Fengnan Chang wrote:
> >> Some io hang problems are caused by miss wakeup, and these cases could
> >
> > Wait a second, what's the cause of the missed wakeup? I don't think tha=
t
> > should ever happen, so let's get the details on that first.
>
> +1
>
> Additionally, there is not enough information in the patch description
> to conclude whether the root cause is in the block layer core or in an
> (out-of-tree?) block driver.
>
> Bart.
>
>
