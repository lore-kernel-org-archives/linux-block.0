Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63315B133
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924186; cv=none; b=fMUe9fdyGA+npsHgxrWerIQ7qCp2MJswta+8HoO0wla31rbVehaD1eJ5/iF3Sa0UGzijKo6FPUfIruTASCFlM8+IH5A4TZZ/v6M7L9Fnfo6IpOBHdojCpB89sbNWys/U5gTA5XE7A1Y0SpQF4tsLEyZCF5CEgzjSr+M5cSWAFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924186; c=relaxed/simple;
	bh=ZVNxFfAxddW28bpkZh09s1cz3uTvKrdBt21m/s9qoac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cM+k/h0a3JXHVtxVtfMDU7qqNE++Z7oRq7R7WxCS7x2TX2xrPH+JeE1RzJg2p8ohGvX3Mk9hjWBe9k8wbDyUDP2wi/J+Vi9A61PSJo+laq4ZJ8cpMD6Y+zJS7shYdj6dL6vgWpw2FI/XNJJeiualJom3FrVjmTLJ75znZadJatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5fa9q9r; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5fa9q9r"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4ef59e2c61aso1289118e0c.0
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2024 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719924184; x=1720528984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqoHsyet7g9FPYbh4rED3DJAZd8AHscvdsRMvkuzoYQ=;
        b=a5fa9q9rKYWM8MKXMcGJOGRWQU31kfvYLVVnQE/XD+7i9GcutYcO+qYJnmguyJSQOz
         t5XoqdzNYjKvx9mLFaDK6GH4iJKCANI4xeUNnKfOtWAYaQZwHw3FN40T89/5iT5bLq3b
         YG8wVoViIYyhMq1gHVLi7b9pKp2y6SLGgI61eIVddd+UryuUZd6ECnAZqO9DQ7ysiH7e
         8JcHzYdYguyNP2Zub2qLNhHU7GASKSEEhqeUvnQdKd1EQ98PazHUbk5iyG2DZg9DAtby
         21ToOahQ05pOW4fLm9It3yk6qCX1SiQhQ8auSaBgMFGiEqnHtW2uRK4sK1YloOiHuqjl
         IXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719924184; x=1720528984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqoHsyet7g9FPYbh4rED3DJAZd8AHscvdsRMvkuzoYQ=;
        b=vyY7jqL8DAXfanOkygeuQ0ipf8k4fI5ReHAtwmCzPtajlAlu+aSQHtTRD9FBXv2M62
         iavXfK48tYGvUtJX9hOeDyqho2LT5LZ2yoPnRd7N4DuLPH9ArS5rWVxwfqHg2ANdMJkO
         kBV2AC4WgK1O5DLM54z4KO8QnZN6f3RMdshhWIrdHEp/kWM55oaRdbVGmkWhxCdSBisX
         9ajnc77vf7nwGPXu1SuMao5yPzgpBdOjnpWIjT40z+rNflll7jathWpvigBmRTJLTrX9
         KoFq49awJkyjB7jqBtByiVshtQhkB+tT4VXdtzLJC1KfYtRmKTu0gdOAVh2CC7Vy78R6
         Ub2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLaP4DuUZsjFv06LkZD4TU0g0dxMNjRBktwM7Vsz7iEQJaTJUs7vR2vDqzb7LFm3jhz9eGiOhpcctzGSlZ27TyTnHfvc7fs1XZh0A=
X-Gm-Message-State: AOJu0YzAbC7apHZccfXyatj3WBfU91J18lw98f/cig/frVzQCL6EnYzD
	x0UcA42bsNoQNYI0mRqo87VdgvUloNmAILT0pZ96Xr66et/XSHFdxhAH//SbeKmN4N0Z7gIRfNa
	JoYCRqt+24MutOcJtIbt33CkSgw==
X-Google-Smtp-Source: AGHT+IGqPocLOp7rrbOzlQABbjQsMFPNk8/1bNw9mq+0rX/83MnBKmUv6ziHV05LZps0dG4T8dNJlD7c5xhzgkVXwQk=
X-Received: by 2002:a05:6122:608b:b0:4ef:281f:84d7 with SMTP id
 71dfb90a1353d-4f2a566ed87mr6946758e0c.2.1719924183466; Tue, 02 Jul 2024
 05:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701050918.1244264-1-hch@lst.de> <CGME20240701050934epcas5p4b2a829697ea9e0f90bf510f511abf19d@epcas5p4.samsung.com>
 <20240701050918.1244264-5-hch@lst.de> <a4c7b88a-7dca-c443-15c0-a0699976f057@samsung.com>
 <20240701151720.GA1820@lst.de>
In-Reply-To: <20240701151720.GA1820@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 2 Jul 2024 18:12:25 +0530
Message-ID: <CACzX3AtF9Q97KtaOWCY6pcoyDzoWsu+MgBFBWVrKSowOe8f+kA@mail.gmail.com>
Subject: Re: [PATCH 4/5] block: don't free submitter owned integrity payload
 on I/O completion
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 8:50=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Mon, Jul 01, 2024 at 06:30:34PM +0530, Kanchan Joshi wrote:
> > The patch will cause regression for nvme-passthrough. For that
> > completion order is:
> > (a) bio_endio()
> > (b) req->end_io
> > (c) blk_rq_unmap_user.
> >
> > And current code ensures that integrity is freed explicitly only after
> > (a) and (b).
> > With the patch, integrity will get freed during (a) itself.
>
> It is supposed to be freed from (c), specifically from
> blk_mq_map_bio_put.
> >
> > There are two places in bio_endio() that can free the integrity.
> > It first calls bio_integrity_endio() - which is handled fine above.
> > But it also calls bio_uninit() - which will free the integrity. We don'=
t
> > want that to happen before passthrough gets the chance to unpin/copy-ba=
ck.
>
> But yes, that messed it up.  I'm kinda curious why it didn't trip up
> during my testing of the passthrough metadata code.

Yeah, it didn't trigger any errors in my tests either. It's just that
integrity vecs
were not unpinned during completion.
