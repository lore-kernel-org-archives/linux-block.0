Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED973ACEE5
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290819; cv=pass; b=VbknP19V5PlP6K8hJ8xuI5Sf2qgjFi/yEM4yGW48INsxq6OnTuYXsg3yXtn+nGrr9csrWRfA3uk9ikE+u/JoBn8i9HrZDCVnQLYSzYNLWEfqvP5Iqh4WUw1IXD2o+2TFIiFRnBu2f01wcYz0vxilzJEMvBPmvOSUX+IVnvIx70U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290819; c=relaxed/simple;
	bh=mGTIDf7ATEDXLxYZ2BPNG7jAnvGsS/6ibRxfNlu9lN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhyQXa1aoMbSG17G7Iw8RUQ2fTXYEexiMn8iHPu30rC7nanUljPz+IDQTQ6KcTDqVvqtkWXeim33bh1jiW8DTt44hoAEzKT0kPup2k2jo0zofJSuS23FeUYc841LAb6LvBSaOVxJ4mOV8EFyZR8knl1Ld0Kbcg2Xl9sWG+0OWqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GnCs2IJz; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnCs2IJz"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b9fee282dso684721e87.3
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 03:26:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770290817; cv=none;
        d=google.com; s=arc-20240605;
        b=UGJAmGA0OPa43EarnpnTS/2OzRJDnwI9ArY20Tg4MWcZFpEfCtZHFyi1S5Irn0kv4A
         eicz40pAMbFeayLbfdFyDNQNITukRPH8ZG+RVFsB6CiRVvfVv8VA1mBO4PlL92hyirBW
         pxO2cBG4x/oTK3uOVrJlq1y/erFj64t30Vt4PzeRHkefBLqoIjw0Ccq3AXGGbCAfB+sr
         tBThCa/3lIVvnWrzpGFvpUFQAKLYkXLyrV6PgcUXYTnvrkMy4q7q6GYhRasX48slKNC8
         3gxWNnf1/TSWhX9Q9WDSlko/39f8lUQCSZJDSOMUHZBx0W8JrOPZtSiL0pdycNCNDviu
         NRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mGTIDf7ATEDXLxYZ2BPNG7jAnvGsS/6ibRxfNlu9lN4=;
        fh=ekHNL67rVkXMqBec37/E7H7JZo1mUyQzJ5gRNpCEATc=;
        b=TewA6f3QKuVaf9Pge2U74AGvGG9Aj/NaCTM1VztC+FCFbvT2IFhikWjgvYe2ckUCbT
         T3v7WaAqKgwW+Vq81tYOihaaPCCm6zNaam9nf/21I7+w+dCuah9ZJ5FJR9mBez9DbJkg
         jYA9Sq+W19vNvChhmgH+xRly/S6AU4GiDUnTWXcdYKVEQB1wUtm5/k2KF9KzuhtMq7xf
         g35bl59jCHicGxSqnr1IWTRFLfTNwixzr0C4YNTmCeRHsZvmsDELYIZzpfwpjBEolXXK
         OCBIs90bATJa920e5SIlrbOsBsBd3wg4Rjvctu/Zy5OAeg+yoZYWYBSayQy71csXqD5h
         APtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770290817; x=1770895617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mGTIDf7ATEDXLxYZ2BPNG7jAnvGsS/6ibRxfNlu9lN4=;
        b=GnCs2IJzwiFZxSGo1spMMprploUI5Ycn6teJay6bf07fY3/STpL7tYdGAB4ktLHE9d
         oi4W/GyJaPgKYc0jdLAgjsPjeOApixPkKhV+9m5lrYPlXsgzl1CZRAX2QXt/+Is3PlBY
         6x93OnQg9G9RIABVddFNDerS36ECWjJ7sMC/ybYzuti7favK8EiTuwG+JRW709u2sKdq
         r9KQLOm+2bGoylvQJ+E/6aZHaILTuJJ7JTa9lbt5v9uJr2xZnbZLn6rZhgjsBRrkrNEW
         lkXg9jmtcMHw6BOksr3DgS4nt9316EuuVE6gbeTZlQhmgKOHRCQGYDrTqID34wUk5fXp
         nmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290817; x=1770895617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGTIDf7ATEDXLxYZ2BPNG7jAnvGsS/6ibRxfNlu9lN4=;
        b=pO+KdEtEys2d6/99LalEY51AGqVrVWWwyMiGlbLsSlmMrNJD+mktbSTqe8/vP95JSz
         zlm7qHL86qcd0Mr4ANvKhVeG7YRcLGRnmNDmcru/JQDcXiuev4UznbtKM7jod725Tkt3
         EvmD6RluD0TdygW/ajDFkH+3At+G5rUumMM2UxRa1QdilS6QlttbI0NjtMhpO0Wsb1zj
         mxmXYVJt9NSEI8gfBNkr9LdgE3mtTvME8CK3V6bEKMSdiBdgoz+ysymtACLOkIwVaebl
         FaZEQxgbFfhua8TTzap59k9mTKGJ5aLr+xMuLrp2KS4+mrA0wEn1kcA6D5CsQMuVlPlM
         XIUg==
X-Forwarded-Encrypted: i=1; AJvYcCVCr8IVTY69Minic+In9C3LuETNiJr22WAOTQfuL5ztnwxkzxL72aTQC/z0XSbjivceybnIQhsy3JcSDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2BwXKReM3xjeJPGwWVhM3ApSLovkQo0f9klu9a0roexMeROAI
	S/WI6ZyDTpszisd7TJzWqz1kOTQjNmOtxadPXQa27eD/Kf4Z8/nZAUNmE30XAyA+Hi1ycEk4U4E
	ruQFISzugnoyjprImE8J14lZs+LWw6g3t32ibgH5Eig==
X-Gm-Gg: AZuq6aL0eoaVdKbS6o4nzWXpXYr7uOzFCAoO0m7z9tL52nPh88xE0KkQcnlnPkhxPGV
	bjWGPTR0z0YmPafGYulab/oivVPT3TRGd0Zq9GJBU1ps6Cu2+lSzToWgn68UZB+hpKJJiOU9ZA1
	EEm70ACSUt/LLiMDIIpSPbGCfCTko6QCZ536wK5ZILpNH5YeWa1C89jI4GtdsEFDK1YucGVK8ys
	0XaLkXjBh/+Gw/uLbD/g2QSD9QH/4cqSbhtrG4urt/zhe7IFyyTR4q34cNePbjYEWzKHH30
X-Received: by 2002:a05:6512:b25:b0:59e:49a:1eaf with SMTP id
 2adb3069b0e04-59e38c431f2mr2304967e87.40.1770290816974; Thu, 05 Feb 2026
 03:26:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev> <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com> <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
 <380f75c7adc04cbab38cfd2f82bd0c6d@realtek.com> <d46dcebe-ca58-44c4-87ee-cade2e478572@linux.dev>
 <4205fde06ecd4a7489b03ef25e5e4011@realtek.com> <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
 <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org> <CAPDyKFqic-rFe95g657MdZHtdPXTmFmYQG4ZSBV56S3DhMEF-A@mail.gmail.com>
 <dc1ac2e5-1db1-49b5-847d-a10a611027ae@acm.org> <CAPDyKFrNHc4FexuTbdWM-Kvo0mn9C51nJN5b=e0jZR8miFho+g@mail.gmail.com>
 <2d3b720c-5637-45e7-887d-077b1e9b3c23@acm.org>
In-Reply-To: <2d3b720c-5637-45e7-887d-077b1e9b3c23@acm.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Feb 2026 12:26:20 +0100
X-Gm-Features: AZwV_QidTK3-LL5BRcsQOANx3I9-wfMadBNJN25RW-bBgNYtc6cvI_SW9Xk-ml0
Message-ID: <CAPDyKFqQCtXzRruVSy0RLfWw11=TB+HAqN=+0P7St=aovZOoEg@mail.gmail.com>
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ricky WU <ricky_wu@realtek.com>, 
	Matthew Schwartz <matthew.schwartz@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Feb 2026 at 19:10, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/3/26 3:28 AM, Ulf Hansson wrote:
> > I guess the question then is, do we always want zero latency, which I
> > assume must be costly from a power savings point of view. At least
> > during the idle period, while not serving I/O and waiting for the
> > device to be runtime suspended.
>
> Block I/O latency suffers if a CPU core enters a lower power state while
> waiting for an I/O completion. Hence the choice in the UFS driver for
> not allowing CPU cores to enter a lower power state while any block I/O
> is in progress.

Right, this seems reasonable to me too. Although, in a way it is a
policy decision, as it means favoring block I/O performance, above
trusting the cpuidle governor to pick an optimal low power state (from
performance and power point of view) for the CPUs.

The other concern I was trying to point out, is that using the runtime
PM suspend/resume callbacks for managing the QoS constraint isn't
really a good fit in my opinion, because of the potential idle period
beyond the point when I/O was completed and when we may be waiting for
the device to be runtime suspended (especially when runtime PM
autosuspend is used).

More precisely, during this idle period there is no point in keeping
the QoS constraint as it would mean potentially wasting unnecessary
energy by preventing low power states for CPUs. Ideally, I think it
would be better if we could monitor the I/O request queue to manage
the QoS constraint directly. Perhaps that is what you suggested too, I
just didn't get it. :-)

That said, speaking about runtime suspend for UFS. Is runtime PM
enabled for the UFS card too or is it just the UFS host controller
that supports it?

Kind regards
Uffe
