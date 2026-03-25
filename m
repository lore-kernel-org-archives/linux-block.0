Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79653A75B2
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452175; cv=pass; b=JjFKofes1KF7+f/O1xBmVdj50JYd1ePrzqd4jFQbk7qAAX1NlvztxZlszKVyEZLOqG8ZHDwZ/GURRO8tCKQfemkd8CckU/dnFZSQHhyXA7aHyjROBcOtllR0otY/A19hdD3c+O8ovvv1ea6nQhrN8nwmRfKV7j1INiRNFVtLdXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452175; c=relaxed/simple;
	bh=RUJDFl6Gban5iD0F66YO21DeJVocE58P9DeIsTNEYu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UW3fLOg1OycM9W3MVejFJcx2ngYJ9jVWu6pVEjyzSP0uKC/B4YZ/peWSFItbYJT7W1mj8O0wE6Du+E7qJ/TlHgKJ11Km3gKIGrebuhtcQM1SXgWaiqfRYU5frQRQOCiG061PYaqFG/hI1ZKcKnNs1EgDczJEVhyiSAnyASJ9yNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yqph32wb; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yqph32wb"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a12c19affeso1890195e87.1
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 08:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774452172; cv=none;
        d=google.com; s=arc-20240605;
        b=K435ImeGT7t8VsFcJmYpbpjF1+hiNPl0pgKb0v/oytZeKAhc5ChOXfq/YqheUAYO85
         6NSmtsBgP0MH2VZvYIAsEEN1F7vjmgWHKjfLK7B9U0CUTx7kh1G6LJSJKcnUM2j1+URF
         6FacQfp/03uec2P3LCIBubjyrNCgWKxrUOHckN+g2iowIJpJRoK0VPqwwIH1kJ0V5riZ
         z1aLaTaKXOyzWYksbqpgmYhWiDB3E+ZsqogofLmOW7jiaPdvPWpZ/NirU0PP75IhIZUT
         ANmKAxRfOe4OM2Xoz7L0ZcwlHrhX8ejuGO+nTkFC/W+SqYHQv2YPVbGUDwHAvPlBMChS
         lRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Voi57QZb4DLbcW1Q8dUVtdAWGCKnIvlCceAEVq0+sg4=;
        fh=w22f7Xw1Z81EfNB9EI8d+o2tpP5U99vUd6STgdEcrfw=;
        b=kfNEDynvGIbsnJDrbMOhFCLn/2cgEgnlLDj50TKBce//wf4p0nh9arMHPNziT+3Ke/
         pIKbIstoW+JX3vqAim7oWbCjJVE57zf05Oc9DUrXx9PAVTLHJpuhQvHQq0biI0WFhj+H
         kXRK5tPPapDydQjXLGbsxPznFJR665BI+l+rpl/OIVUs9qtnbHQb7AOfiA9Kaax2xN6z
         EknOTyzagtPPe/mI+b4yZOrNp5UvAvanR2l/4I3QQTNXUR9DMHmFYFoaZeeiGlQTxax7
         /wuYJRZdsKZm4bAgeO8/rnanPYdb2pfAtIbcBxAHwKz7w2jwAQMgkeMPiet6xEvG7On9
         NmPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774452172; x=1775056972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Voi57QZb4DLbcW1Q8dUVtdAWGCKnIvlCceAEVq0+sg4=;
        b=yqph32wbSIb4yHcFm4pgpz9R4qFWRjZZra8jq4nBWbilvY5aF/WYei7ZhlSdO8pu0b
         dxCD8zhoc9juF+u+9XA48GYt+Eb9HFlaAJ/9la12AzStvtL97rbC1dxO8vBKg/jjUSdM
         d+KWDb2h1eGyYuSBXpO+/hFG5ovp9eTis+wLcO+V/0SD0IBTajFotNACiPshbzef8KdM
         F5WTm0Vlog2CdjhepceQY4Aw1LfeeKhxNMsNQ3H7Dvw3rd+PuMHaNfcUZc6apI+RNQyO
         02GkOFmwCzQgnzgp4cz2HyIMQvBVmRLEpmLjKNnuZqB0fq9RmaMA0ZLhBjG0KOZgtNRG
         z5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774452172; x=1775056972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Voi57QZb4DLbcW1Q8dUVtdAWGCKnIvlCceAEVq0+sg4=;
        b=ZAsSRnkLm9aC5+1jLEMJe8ywia8Hro53p3X7PHcy+Up/0dPX8ZGVNkXWE6mKU1ACjG
         fQuvcnR/b1CAGtGarBwZdfves8sseTWjF6ZkguJ3uLt7kxkLs6chuqGhE0z81WhNeIqW
         Bk7MICQQtpCHz+1bk70jRyqzTw+8jIam9ACmCGP3M/tp/NYVtSxav2OwOX0ceIX/WfpD
         92+moU6+lvjAPcR6XsvkOxeup1lbKfdeZ+QIxVBVTZTHNgc9Z9Cd1Q1fAOw1VyXkpQsa
         Swn2axZdaWT771ZNcXxe5m2mCefyaU4PA2LT7eCIjzT9vEDPPY/qDgLFTnGeA7huDQkJ
         +J0A==
X-Forwarded-Encrypted: i=1; AJvYcCXYfBtA4VbgL0L7iC+5glwuboKD1dCAC4EY3WXS1ESYxeVBHrUxkDhkmG39Yfj1yiWy3IpzG/CRAlaZDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY9HmjIIOFLNrzv4wixiqcahvJxqive8gXG6nX2Hs9jKndIiP2
	JV4CgjV3o/35ooFhZQj2s+JJdUy5PrG54MYpxpI90AgXTNSMjR5JHn3illavSoGXN3NY15jL73w
	CShtHa26yk6vKj/dZ0klYjTLXK/0SCHpqyV6DtnZfvQ==
X-Gm-Gg: ATEYQzwkEfbxCPz/NtJRfYlYDqAT3LGoLXc9OE56HJk8OFKfBY42u+TOEIWOCP0u9+T
	63Cf35/Uz7/cK2WRYdHvjbtwdE8h8MFnhBBfbpaNeKctC+wyo4wn7s8UpbfJbZ4GRV+ZzXWs6jY
	l8ydi/bFAZEAgH3IsaPVGfUIdp5XzpUySe0Mxr2SU8YdpIlpXw9AD1iUKv6LWoQgLA55LX57oOZ
	tk19zob+XD0g+b9dz+Gd6k6bjBq7R8V4qrL01mIf/ODArPFnTzON+j1z4Q7TX2gVXQ1JfhFbP+s
	jzmo5/Ec
X-Received: by 2002:a05:6512:220f:b0:5a2:7901:a513 with SMTP id
 2adb3069b0e04-5a2961fd1a1mr2666933e87.7.1774452172016; Wed, 25 Mar 2026
 08:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324143448.2631888-1-b-liu@ti.com> <20260325134947.2799552-1-b-liu@ti.com>
 <b4c84630-ff69-4d1c-8b82-815679d3fa72@kernel.dk> <20260325142106.j2uiurbkgac6xw52@iaqt7>
 <91fffaac-587b-46bd-9ce9-f3c354d89b6d@kernel.dk> <20260325142759.gnwhbnnffgyppu7l@iaqt7>
In-Reply-To: <20260325142759.gnwhbnnffgyppu7l@iaqt7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 25 Mar 2026 16:22:15 +0100
X-Gm-Features: AQROBzCWYR9Y7EaVEdVe96tudlobOWrTDVpPwwPWxo0sxiy9Z24mT9JI_TwfnLE
Message-ID: <CAPDyKFpWL3HPnZOxrhZYni2Hc23LySqxu12tq2ee9wOkm_=KLQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
	shawn.lin@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 15:28, Bin Liu <b-liu@ti.com> wrote:
>
> On Wed, Mar 25, 2026 at 08:23:29AM -0600, Jens Axboe wrote:
> > On 3/25/26 8:21 AM, Bin Liu wrote:
> > > On Wed, Mar 25, 2026 at 08:12:36AM -0600, Jens Axboe wrote:
> > >> On 3/25/26 7:49 AM, Bin Liu wrote:
> > >>> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> > >>> index 1498840a4ea0..c254e6580afd 100644
> > >>> --- a/drivers/mmc/core/queue.h
> > >>> +++ b/drivers/mmc/core/queue.h
> > >>> @@ -61,6 +61,8 @@ enum mmc_drv_op {
> > >>>   MMC_DRV_OP_GET_EXT_CSD,
> > >>>  };
> > >>>
> > >>> +#define  MQRQ_XFER_SINGLE_BLOCK          BIT(0)
> > >>> +
> > >>>  struct mmc_queue_req {
> > >>>   struct mmc_blk_request  brq;
> > >>>   struct scatterlist      *sg;
> > >>> @@ -69,6 +71,7 @@ struct mmc_queue_req {
> > >>>   void                    *drv_op_data;
> > >>>   unsigned int            ioc_count;
> > >>>   int                     retries;
> > >>> + u32                     flags;
> > >>>  };
> > >>>
> > >>>  struct mmc_queue {
> > >>
> > >> I'm assuming retries is a pretty small number (didn't check), so if you
> > >> care about layout/space in mmc_queue_req, you could make this:
> > >>
> > >>    u16 retries;
> > >>    u16 flags;
> > >
> > > I quickly went throught block.c, it appears retries would be only a
> > > single digit number. I will update the patch to use u16.
> >
> > Note that this is just my suggestion, it's down to Ulf. But what I would
> > do is a prep patch that makes retries u16 and ensures that's sane, then
> > do your flags patch on top of that. I think that's better than making
> > that unrelated size change for retries in your patch that isn't related
> > to that at all. It just sets you up to not grow the struct after your
> > change.
>
> Okay I will wait for Ulf's decision to make the u16 change or not.

I have no strong opinion, before or after works for me, while I
certainly thinks it makes sense to do the optimization.

Even ioc_count can be changed. From a brief analyze it looks like this
(needs to be double checked).
ioc_count <= 255
retries <= max 5

So maybe u8 is good enough :-)

Kind regards
Uffe
