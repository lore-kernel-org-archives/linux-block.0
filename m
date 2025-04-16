Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734DE10E9
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829416; cv=none; b=OCmmIByt8w4m3E5X6QUkpj9DwsIJUO3MMktSQs/jr5EjKXGpEmfBX43AZrSBaHKB2zUJ2zrvir3Tx2axVZO4tG5kKa55WxK2auVIp61pQdS3cCl5Bbqurh5efIpLprQUeuXqScCPXw4fGE7m2l+d+nrTrwgV/9IYk9xVmrSz2MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829416; c=relaxed/simple;
	bh=h36nxeJS7+e5+KXgXM/7hnRS9OTumi3xvvKJ+Oaapaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N08QNy+3XiTku2Pq+SBeAN0yf895Z50ePpRG3LoNziJHVEJ8hTl7KI9PSOacZgdV9Tgsfi+yMB1wdLDwX2iHqRlee+Io9s0g4snKe+kET0SqTNcVPVBvZtgiZPNsjgGqvADcHKSXOGCkTkCHrYgbM+dWsik0ptaMsq+3VfFo43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RC1+J1Jq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RC1+J1Jq"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301a8b7398cso1186677a91.1
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744829414; x=1745434214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h36nxeJS7+e5+KXgXM/7hnRS9OTumi3xvvKJ+Oaapaw=;
        b=RC1+J1JqgcRQ43YKxs07m+vlxDQIc1fQOFZmqQOqSN3ioEC/+fCojevJIyAir2rEx3
         kzd/N7bx0f2E9W/C9ChrcFrmWRnGOVhoqLRoAl5kg5NSq2SXhvR7LvqhyJmScYAilSL4
         Li1XNK30CXBl6IbZljUMbrWrZhQoaoujsELEWOE5gcryuIHQiWNhmWYy7D5L/XwF5th1
         pwUUVWCANc/xXfODmFh67UwHDkZdsHvRmkcB+nEGeGbav5g3SlhFaDI2K08Rj71bPLsA
         /+1xuw1S2APjGyjWF0eBu9AEFY5X3qj3WsIad8b6Nif18GGB12sov9YYX08HXcDRcMIj
         LJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744829414; x=1745434214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h36nxeJS7+e5+KXgXM/7hnRS9OTumi3xvvKJ+Oaapaw=;
        b=lDD1CfH5xOU3hn6qookTTDksredfevo1kq1BZlKoUgIGgIxQLXug42Fi8uSrb/oOpm
         U/lV5MsJJ2gXIHuvjKQ0bV2uA4Nnw/W8u5B59IOzyAU94fFh1DKdP7UEhS60YlBwCQQE
         StxkNGe7C05Qu5RmL5+iQn1DGyDMTlEZPg1g7OlGVKCsl0LnVLcIJFduahkxrFCX7l0m
         iSW9wvWc18Q8qmKpOu6AdhqcOSr8Lu1UZTFGznYJi/o2vFf14fRcrnqYM7qJUtjK+4hx
         0a5Qz/FmCmOmc2K9nir97FfG96e+OhvgTJO3PjEp+Y6oHI3nUwKL4ldqzKCigFmk95Lm
         6FCw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5UgoeTLsBAPTP4CpkJwYIplXqLBeCmDfR5SbWNKhKTs6TZoDF460GGOoX7I95bU1atdBF9NFBMGhNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyeUX79j7LX+/I+JWLmTrECVSLsURusRtev3gb0EvZNMnovVK
	pypAQHI/wCvPKUaVAvN9By+ZGmS6w56xtqlyvmGwnAAQwOOHeA0mMgjXm/fD6wJ/QoejutLdMcA
	lr3QIH8MZk9PomXokdwK11fObDxhHLpSaqgdHhA==
X-Gm-Gg: ASbGnctKJk2t4qJAt4GYm2O7l6deyP5mEZGqlErnvu3z7r2eJQhgHPh9OQWa5iJFWBL
	ciWnwlbBml1CdPHOi5Oy4T2GuohY4CSk8IHrCkHfNhZ3Wy+1tkB8DQbxr8myrVwRGMPIupHb7QS
	hmMYLLwWujyLzknsFraH+T7DRIsslbNsbBTDk=
X-Google-Smtp-Source: AGHT+IFNVLouPuTdR9txLY+lbppx58sp7frzHLO33b43YS9nsLB6D+0mYiiF97X/id+PCYzsWGBlvViMyHFluLHbpcw=
X-Received: by 2002:a17:90b:3906:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-3086d3dd440mr483957a91.1.1744829413820; Wed, 16 Apr 2025
 11:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416171934.3632673-1-csander@purestorage.com> <Z//yJApTjXvfVnga@dev-ushankar.dev.purestorage.com>
In-Reply-To: <Z//yJApTjXvfVnga@dev-ushankar.dev.purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 16 Apr 2025 11:50:00 -0700
X-Gm-Features: ATxdqUHTqrlv47_Rxh4oWznVmpNwqFylQxf_YaMWzBKEGCHIp49yYhjElGMaqho
Message-ID: <CADUfDZpH=EpCBtO0zuETcARpQ1pYy3w3ES2O6J89MH+15eOPgA@mail.gmail.com>
Subject: Re: [PATCH] ublk: pass ubq, req, and io to ublk_commit_completion()
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 11:08=E2=80=AFAM Uday Shankar <ushankar@purestorage=
.com> wrote:
>
> On Wed, Apr 16, 2025 at 11:19:33AM -0600, Caleb Sander Mateos wrote:
> > __ublk_ch_uring_cmd() already computes struct ublk_queue *ubq,
> > struct request *req, and struct ublk_io *io. Pass them to
> > ublk_commit_completion() to avoid repeating the lookups.
>
> I think this is rolled into https://lore.kernel.org/linux-block/20250415-=
ublk_task_per_io-v4-2-54210b91a46f@purestorage.com/

Yup, it sure is. Thanks for already doing this.

Best,
Caleb
