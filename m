Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2B1DA0FD
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458420; cv=none; b=ElVtgmN8zhLlP+Sx7x0VO3PkAzb29OlrU21TXr2T+Bfm9hEZFLlCRg7xu4EmXX2DixKSPsEhQkuVDG1iWtdigPWToh6ujOHqU3Y5eXDLXCnjMeX6y+khpib95PXvi2DyR2Tb5fdE6+5fklFJbeNQwG0Iyox70XVPytZnodt2+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458420; c=relaxed/simple;
	bh=/0AkdYUv5XBmaFze86qGFhmV+GizWa3kalOfnAxUW1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvi3V540WCbhPkTLEMXGL0oljVL1fps2uHB9L/diQdGxS4goy+okPbka1fPurU2e/xBaX9kU00ne5XceULQ7lt51gM+MAdqaemusbxqJsZFBDd7bWbv2EA0mXKbz4pvPT9f4MfkbABe3t+qTIbjqJIq8UQK/PUmRW/pdFq0QEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P7taTWwf; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7taTWwf"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1a989bd17aso4199554276.1
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725458418; x=1726063218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/0AkdYUv5XBmaFze86qGFhmV+GizWa3kalOfnAxUW1Y=;
        b=P7taTWwfoQKZIop58nW+DblvpIovxPuDwxlCaiu8/+60BfTUanb9lPU0/sZ9SwqpT5
         F1jxjQUeazokNc2nwbf2uCir9cR2dEd27aLy0J4AxXwQzV0zHeVdeH4gC6fKxgN3C/ZD
         V50QKqubfmS/LhSOsDspE9/ZHEk4ccK+7f7TEhdThRJleB7R9lhVL8nl6ObRIolE8gzN
         mc01rF38NCfGw8G6XgbRlP+7KU3dsruhSWB2BuV18oS4tQsTnh4/63/tIyAOPpLPWIkL
         SATyusCdcVgkEeM4iW+d9YVkfkm+c29uwUVJHcbYeENF9CcQNGUA3hj5Jt0Ebo5bhNle
         oSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458418; x=1726063218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0AkdYUv5XBmaFze86qGFhmV+GizWa3kalOfnAxUW1Y=;
        b=fToz8CzKoD3WNDIBJxkLUcEztb8AuijGhwK5tYtdITks9FlAdtK01nxrdIioq+L5Z4
         5GuwMQBo9X5FU08LAGpIvyVD7Wj1qV+WewTc47SF1BeqJZaxnJJnlp7NYkdb2GmKF4tO
         3MO/36jzx2BbZgpjlOtGI1mcpWXKAm2bvvTITDhOmpHnI7aVUDRZBEZ+zsLBJOdIaL5/
         CipZ7gykkpul5lsemww99y5/bzoMBQ2S3tJcgYkusgl5PFRw/a18y77ZIAHN7pnhfnRO
         d9sPXeqV4XRZr73WBuG0Q81mIByrZURVSGzKRl7DCWxFzliZfHuihC4yhmB09TyHyfuw
         BJbQ==
X-Gm-Message-State: AOJu0YwlunHCpjq9Qli3uqRj6ZkHRs9EiAKbxOJAW+j1qcSLPDhLE2G4
	eUKizQNfBvzOZeCW5VcY86zBZYw/gNmm8hFMjMLuvHqzsqQIi2SuPInSVFGSivB3U2816Rkl3U6
	MgvdTDRmicYxtbpXRkJzJFoFrHYAO6aQATBj97Q==
X-Google-Smtp-Source: AGHT+IG2Ay/b0HmrTxLJjB4igZgccnpa/ELXz+Rm5lcyqDINOa7uHksSBxS/emSU1waSi2zYuT3BkKo+44xklwVGx5k=
X-Received: by 2002:a05:6902:1687:b0:e1a:92e6:e063 with SMTP id
 3f1490d57ef6-e1a92e6e48amr15270484276.54.1725458417728; Wed, 04 Sep 2024
 07:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
 <CAPDyKFoo1m5VXd529cGbAHY24w8hXpA6C9zYh-WU2m2RYXjyYw@mail.gmail.com> <d8d1758d-b653-41e3-9d98-d3e6619a85e9@kernel.dk>
In-Reply-To: <d8d1758d-b653-41e3-9d98-d3e6619a85e9@kernel.dk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Sep 2024 15:59:41 +0200
Message-ID: <CAPDyKFp4aPXF6xuuQf6EhGgndv_=91wsT33DgCDZzG6tyqG9ow@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: move the BFQ io scheduler to orphan state
To: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@unimore.it>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

+ Paolo

On Wed, 4 Sept 2024 at 15:47, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/4/24 7:27 AM, Ulf Hansson wrote:
> > On Tue, 3 Sept 2024 at 17:54, Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> Nobody is maintaining this code, and it just falls under the umbrella
> >> of block layer code. But at least mark it as such, in case anyone wants
> >> to care more deeply about it and assume the responsibility of doing so.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >
> > I haven't spoken to Paolo recently (just dropped him an email), but I
> > was under the impression that he intended to keep an eye on the BFQ
> > scheduler.
>
> But he hasn't, it's been a long time since he was involved. I've been
> applying patches on an as-needed basis, but effectively nobody has
> been maintaining it for probably 2 years at this point.

I don't think we should expect him to do active development, but
rather just to keep an eye on it from maintenance point of view.

Let me try to get in contact with him for an update.

>
> > BTW, why didn't you cc him?
>
> That was an oversight, I think because I haven't seen anything from
> him in a long time to assumed he was awol.

I looked at the last year or so at the linux-block mailing-list and it
seems most patches for bfq aren't being sent to his email. :-(

Ohh well, let's see what we can do about this. Surely BFQ is being
used out there, so it would really be a pity if nobody takes good care
of it.

Kind regards
Uffe
