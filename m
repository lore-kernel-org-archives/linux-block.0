Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2B221FCA
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756871235; cv=none; b=EMfNFbjVVcKfN9px8oMZkUqHcSoIDkcmq8qPFIBg1sLZaH5YwA0U7DgBMqfgsj4IfePdybFyWr+IlxW4uiSB6zHAWe34Nossk3cRoFTKX5KRM6ht8YUEmGDYwWfDBk/5+bEk2+HtCnTWZYy2CKqVt4zql6po57lcEBzi4nMlo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756871235; c=relaxed/simple;
	bh=2pQ8jDzZasIWA5+gZ8m0h0ujwZ/qawrxqftq2PEbKqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXSjiKuZ1CEYN3Q2QzZVbll/Rna0bL+9nV35b+ykJk/95FKj5AS4Z78tnOfM9KbL+64ReS8EewBbLLqT0Fx841HuKdPOy524l05R7RT2o+HG4xX7n5yIVwmkCd31gHwdIoJUBbjW69B7AncdLCDCtOh+LhxSvcNgy+4YKHs0onE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QHuLdsNT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QHuLdsNT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24aacdf40a2so8665195ad.1
        for <linux-block@vger.kernel.org>; Tue, 02 Sep 2025 20:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756871232; x=1757476032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pQ8jDzZasIWA5+gZ8m0h0ujwZ/qawrxqftq2PEbKqw=;
        b=QHuLdsNTna8OmqCK2rBoW370F91Jmjg6px/pcbxDAbYSWu6lg3BXGYNigIQbhY6pN1
         kGmD4d/YMkBrLBAe9g0CHCadfyDOjc4olP1t/UaEqjhUWw4LTiwok5i6+hFOWmBEoy0E
         2/xeW2iijZ9Q1gOnlY6s4BwjiaDmH96EXgGy7gGELgb6QhLhD3YgmgqClv2y9M9xqkZd
         S+exWLOcG7EwhQcaIwgCvtdPZb+hLxwKQrNzcad4PMn4FsqFZmaLbnsRD7Z063LxAfYY
         szWjAumJYFoIC2H3Vi28WDz6Jj1NUNFB6KukKPOXK4dm/tzNrNPJnJtCbJk1UT50Ckj1
         qjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756871232; x=1757476032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pQ8jDzZasIWA5+gZ8m0h0ujwZ/qawrxqftq2PEbKqw=;
        b=BXSrHvOHeqZhLWAVvwPzy0osR5Qh2bsh8kwUMT0khD0dDBzYu2TzbThCW6dfoXWnyt
         QmQNCjExemZ0L3WljAhlEoGK1WvOFbIe5lEZIq7aMmDCg2/GMM2a5M8IejuGx4dge9nN
         vgWlDj4hBk8n7Xxza2zHae11KjjEuCMEKDzuZjB7qqostSlch0t1zDhbsG6cmG/BxqlX
         uhDSzaPxvdnMCxQtoeAYQU2oIFp8hVSXZ3GEza9WIDgpvvHsZWx5/4M4HyHj2w4WNQUO
         JWVBD7FHFAX/Z8XNRyzjsb3mP3DVPE5K5zjwPrbq0S+sdQbFaT4+Jj4twS8bf6QJLKlw
         96Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWs8IG6oed5CvsMWAGwfxHltREmRaUm3wvjtU+Bq08JNkRKatT+nSBitcYNvv/hwIM10Z2mJrb73UFijw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynjwFlXxmWi9r2bA/LmNcu475oT4CEZaWfKIUJwrrCAU6JhuGc
	R+HMGaRrvaSIDquoBo1p3Jp5LrhOREY0GTnBiCHKQsCfgzM8MfDPv9IolV7//3WEU74ul7euBjI
	eY8DgmMPA9620wMTk/HtyzbKr4jT/pWmR+uD1XoqH/A==
X-Gm-Gg: ASbGnct0O4PSBkHRb76o5EyiQrocEoiOIeCuhZg0OtMBzHs8XISE3NA1JY2awhIZ0cV
	Vg4aArSgVWZL7dQyikn7AgzKxnkIqdYOBemzSuc2mImtbhisx9n/aY2WTZgGgP94PC3eQqkVm40
	sj4imb+vYcPo+wXW4n/RqF89W5SkKwkIrxQ0+l26/5PRpl0aIe9BvWmKKzFO8VwIKB/OXyOAdwE
	QtAUZ5vHOnAua286Q7/8GPAzHlpNe2zSQ==
X-Google-Smtp-Source: AGHT+IFeVBJ/Z5E9XZsB3C3xPIRC+M1KZv9BteaXEzfzJqEPOwFV3blAzzS3ngvmlLPBTmnEKi4X7Pac7tdUMdZjTbg=
X-Received: by 2002:a17:902:c943:b0:248:bac6:4fc6 with SMTP id
 d9443c01a7336-2490f6bc65cmr122195635ad.1.1756871232173; Tue, 02 Sep 2025
 20:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901100242.3231000-1-ming.lei@redhat.com> <20250901100242.3231000-2-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 2 Sep 2025 20:47:00 -0700
X-Gm-Features: Ac12FXzAk-8v2R4QEHKE5ou60KmwJ8ugXfW4I9uM-9LvWv8OHjxBXAYVhQ7WU-o
Message-ID: <CADUfDZoQkD8sqAAsYb5_-xDkjqcZtabZ4jVrfWJ3-3LXVvApBA@mail.gmail.com>
Subject: Re: [PATCH 01/23] ublk: add parameter `struct io_uring_cmd *` to ublk_prep_auto_buf_reg()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:03=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Add parameter `struct io_uring_cmd *` to ublk_prep_auto_buf_reg() and
> prepare for reusing this helper for the coming UBLK_BATCH_IO feature,
> which can fetch & commit one batch of io commands via single uring_cmd.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
