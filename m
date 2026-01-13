Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236B1D432D
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272380; cv=none; b=Q7XpuLzFuBGZFXiQszQGR2lPYRo2ENw+ceTwqWSlUTHjQyjzw7sdHMVntCK8yd+1jLuGmoWUKrcdD8LG4qGx5YDqKd+k2KLlDjcusPDX3+XTGCi6uAB/Qf0i2CM08xB1K3VJOffRC4elKRNIZHAEHVIre4GcjoiDGZE3CZ9l//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272380; c=relaxed/simple;
	bh=1pv0ifN+y4KohSBSsuHfJBfb7hYYC0i2vwMleV0uGMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smEDpcuPxXqJNMDBTowYuAPTkpUDnbbztt17xHwTX8NaBWKpt/PT0AGuazX94/impgJAvVWf5dtM0mL1TSNHjFcbOuazIlcewTxmxTq2jPRmCXTlubdDKTA6qtjtYwjYrHkGjyjpYN0OFI4oYQSIy+IDBfR1UAn2R6yy+eM7nuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dXurHRPJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dXurHRPJ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b87281dbdbcso191408266b.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 18:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768272377; x=1768877177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1pv0ifN+y4KohSBSsuHfJBfb7hYYC0i2vwMleV0uGMk=;
        b=dXurHRPJzQY8b8YbKjRII3xX/Q8xMyfllchXfaLHpaS/ticQry3QjbWZprjKWIPrfS
         B8hozTFMYLFLAunDgIV97KSM3myny1z9Vj0IohFO9NbTEjK9pb8REkj8oleUauGxc6hm
         LbyBOe0au4+QGYI79TI9jXP3CgjWYUHg6ZiSNIUASyDFBuKtJ2aysSFc86rYYIMVbqSG
         aijiZtm6WzXF+skmVzmyM9yZzdV3/fpBZHXtEtSjadldec8qzw7WDd6RQhBnNrcuKLs+
         H8eYM22HP9Yqz6FGrURB/OjJGTRPjd9AWgZZkCnlGXKwq78uCbaZQOio32y+a8VK18p0
         h1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768272377; x=1768877177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pv0ifN+y4KohSBSsuHfJBfb7hYYC0i2vwMleV0uGMk=;
        b=blrDP7w3a7Xn0LDxhLuBEEMAIYUs93Ekc8JPRj67Kf3KX6d0n9g6TyYu3c55gJNjKv
         Ibf13sYSJLqRtWabZ81M1+gsesDhnDpj7DuKkmEloF+6gBsthjtfN83/tdo289qnyakK
         RLwe9US31CXTALmufIsKUJuXxgOVxSsUiuBLhLqSKstve+7zdxJ1AxfmCG8W6BuoQZnE
         negx22kvH6+0FLgiqf+GVsJhyFludB+HYRQ1XmGxqNiJuGD56bbSrZgbTNHgALTHaviV
         ZW8aqAWl3ALo6Y+v1Wo4ozjcm2lk2b0e/lwv6IXvDHeGS3O13JqqkQLZ7E1YvrV85mZE
         s69g==
X-Forwarded-Encrypted: i=1; AJvYcCUqqcVtFM8jB7LFllD7PfzW3h3vlisj48bGbE9teoa4HnWu/BkU/IZXJZM+bX1famlEfAk4OHYIU7nc8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkVRbpfwJ0lxlEH4pP21sgB2CLOQjmNfrTRNmBWG2hD3UE8LX
	SP5HivFTkSQuQewrpVDaP7tI9BWSCvP9dwg6jWU4dxg20FuAPUB19mYKVOiPODhyv1Cexa235FC
	gQUfBVcly5L0ogHSuX1oLDZBMoPPci1o8OP2dSuPAmjcNTwSeP5OTLNU=
X-Gm-Gg: AY/fxX7pvBUp/pVXxZuIo9kOzZrIbVOBu2if5Ju5l3w+0JQPDVuU9Ze5K4hzUyyAhnH
	Nr7vAydYDGNOmOR+SWtpBufvxZqSEO5bIWmvs253ATi+tKfoj+ZDO9PJ2WTsFPLi0FWTnYN/R6Z
	eBAhONRdyYTs2ccDWBTWCPJH7UZa/pq4a+r/5CFWMekistvWI7zVMoIZlt6OJbN8MnuzkS/6vvG
	pJBG3E/oYerXETtI9gZRtunrT2KV8AVWyKHb4T2a6WTfRja00YLLpUDsbvPTh1vCxdoY7Tt0Stx
	he3bGhR/wijjlg9E18qPe/MXBSXmCKYBEQQnh6P1eKBvQ7CDFoQ=
X-Google-Smtp-Source: AGHT+IFNTK6Acg3z2wvPH9YuXm9EJl8jr9Jkf8WQmzULc9ObyIv+uJAwQoWpe+Y0EmAmXCg+7lgiMrT1F3aWxXH6H4Q=
X-Received: by 2002:a17:907:6e90:b0:b87:1b2b:3312 with SMTP id
 a640c23a62f3a-b871b2b3e14mr473180466b.16.1768272377094; Mon, 12 Jan 2026
 18:46:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
 <20260112225614.1817055-1-sconnor@purestorage.com> <aWWnhX7h3m9w2wc6@fedora>
In-Reply-To: <aWWnhX7h3m9w2wc6@fedora>
From: Seamus Connor <sconnor@purestorage.com>
Date: Mon, 12 Jan 2026 18:46:06 -0800
X-Gm-Features: AZwV_QgSAp7FbvwmrBq3S9mJeEYL_vHbnxTvidVppDY3tvZCq27krSAWAYLzJn4
Message-ID: <CAB5MrP5mezn9rWZmykXTcc5-kLRPScu79xQsd_4Q7L=X=hn6dQ@mail.gmail.com>
Subject: Re: [PATCH v2] ublk: fix ublksrv pid handling for pid namespaces
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Caleb Sander Mateos <csander@purestorage.com>
Content-Type: text/plain; charset="UTF-8"

> `ublksrv_pid` is from userspace, so it may be invalid, then you may have to
> check result of find_vpid().

find_vpid() returns either a valid struct pid* or NULL as far as I
understand, and pid_nr handles the case where the provided struct pid*
is NULL. Is there another case to handle that I am missing?

Thanks,
Seamus
