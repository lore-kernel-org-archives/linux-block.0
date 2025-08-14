Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD11C9DE5
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210917; cv=none; b=FHybmAo7VYIhRq5BBhrcMZiOmfOttZWnotFmC5Y7Qo/cuVzgJQ3/OY/5wDt4988HDwKwjNY0bb0U9sjGZKIGcAxN51CqZGKyy7rI+MAi0H4b4Jnn2NY1Yehz1pc2yZKi9ciDfkYEuY1qs36bx78s+1UoVQm5yK3n+e4ObawqQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210917; c=relaxed/simple;
	bh=H+FEBbWNGCd3jMnbM9NhsMA2h2WcyoSYo+D0V1gMNZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWJb2jN9Zq3amODgD2lQGIPrhSnxDgkZFlDtS9In6jeFddEa5+T0NSybuixmTmUiXftw70vh3ZXZ2n4fCifSpeg7hj8igTNfJAZwYJ6WOYvVfNYJWsppbG2M+L3eBHm4MbAoIqjq8jnVQJZXS13wISoKtIpLGbfQXNPk48KWrUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxmoWyfR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxmoWyfR"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78d5e74so233873866b.1
        for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755210914; x=1755815714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd3k6sT8uXkZnf31+csOG+Akc2j0o8UNuxgVHaXqfGc=;
        b=QxmoWyfR7TMwZgf3BdC+5iH9zmH6RMdPnwVCK+W+UyLS307F1hYehzxbCyL0UbHjyi
         DJBreVVWVgBRhBMNtCZhZIuGNoYln8cPPllMxbUZku6qCyq/c01fpQPIIOHpFHSQBeD3
         KRTHv5BI7NNDKBn1219QNMniln4Ve9p06S1EnpK1t6MVv/mk1nFldZob/dvlqGiiUK5W
         zSy9FqqvHR7pLvO8erp7FahynmCrPY73nfUUj8BJN+zXHG9g/oi+1BggJFBSIYvoFwdY
         +7jr5wS9SPbxTgf1d3T2O859QA6AUK1RL9ztBGuDSzRDfKYt6Tt6ZpIan7H6Z7XajfuT
         z9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755210914; x=1755815714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd3k6sT8uXkZnf31+csOG+Akc2j0o8UNuxgVHaXqfGc=;
        b=Lm07c1GbiMD4dYHQ95p1gkZgvKeVPF92ecGR/Bb5ES3rJf3CVsOblnOL3M/2pAl0h9
         SH7mulw5Nd14NtwrFGU0sRK2wa9pjPSKtAQen06gdCYXJ5zIZULz6Fm/pnzRQJEgtmus
         Rjx1CQrHQ2I+ZZ4l3JPwhCS1ly9X6o1I+lmtb2gr+pgB9N/651+galSO6PeL1EeXA7AR
         pII8c4mwLYrBh7eV0HQMEUUArtJQt9QCpTWyROgtdgW+QM74TjyT6VNtz3GuabJdDPIL
         sOqCjEKXlJDGaNM5ve9LjWQGrh2hcIspbMHzg3EFmpDiY/u+1TBn7/m0AQOT5RI62BKp
         FbzA==
X-Forwarded-Encrypted: i=1; AJvYcCWN+ZKJeN8Jl4qXHsfOEjQ3JSR6Q96mKkvMxhcggfg4YxZvp1gmH3EN0EX0lKTPgz5dzFnis/LNfhvEtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsJWvJcKJlhKBTnIGoj5GkVM3pvZZ4IEvH47pbk3Qc56Tjm1K
	zBvyyTR57xdJnugGVI4xJdvMRZA9607tFpTuHRVAaS391kM4HZWeVAoFjS2M4iwiY5cnc6fQURb
	ECtag+nlojgJowFBYKomVr4P6BeRar80=
X-Gm-Gg: ASbGncvBtozp3PnIem12vMeiqgqxGqXUN9sw3A1tx2vPu3ZXF8lgadyMVIiRBwSWv0q
	4rBvvWu+H0BvIswhU7RieST+pP9hYfqeb3YBn1tJ9HMmr9mVriYjnvsQzBhhOUNJl/gTzur96BC
	HkgaPSQnzWb5ssypEOGWfXSUIx8wcmN6KRc3yHQaEPt/zZlTkXqB0nYmZZOMmJamTBbqP9d3//J
	rWYq9UR
X-Google-Smtp-Source: AGHT+IHQJ0nZv9ZlUQM3huQCK3igjXe0i02mkwa3OlSyeMA7reFrWNI2gArWn4YPRDyZ2w4NsNDQcTmLkfRUBsuYk+Q=
X-Received: by 2002:a17:907:1c14:b0:af9:709f:970b with SMTP id
 a640c23a62f3a-afcbe24770emr432719966b.46.1755210913738; Thu, 14 Aug 2025
 15:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHumS0BE_28D47d3Ls5PJBONTzVUCA54QwTV5UhJdDhnfCEi4A@mail.gmail.com>
 <36eb61d6-971a-4177-aa62-75197460c33d@huaweicloud.com>
In-Reply-To: <36eb61d6-971a-4177-aa62-75197460c33d@huaweicloud.com>
From: Teng Qin <palmtenor@gmail.com>
Date: Thu, 14 Aug 2025 18:35:01 -0400
X-Gm-Features: Ac12FXwmBQ08ugM8mSulymg8dreoWRsjeQahdrQvChtdZhcwE-1pTtG-Qg35eDo
Message-ID: <CAHumS0Ddg7wj50jvoR1Z9dJrXeizz+=4k7Az0qB_9QH-tAhvQA@mail.gmail.com>
Subject: Re: Question on setting IO polling behavior and documentations
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:31=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2025/08/14 13:14, Teng Qin =E5=86=99=E9=81=93:
>> Moreover, the block layer documentation at
>>    Documentation/ABI/stable/sysfs-block
>> still documents the legacy behavior of the io_poll sysfs file. This is
>> confusing for users trying to figure out reason of the failed or
>> unexpected behavior after writing to the file and seeing the dmesg,
>> particularly because there are many articles on the Internet describing
>> the legacy behavior.
>> If the maintainers agree, I can help update these documentations.
>
> Feel free to update the documentations, AFAIK, there are some out of
> date descriptions and it's welcome to fix them

Thanks a lot for the information. Before writing anything, I just
want to confirm there is indeed no more per-device control for
polling behavior? Is io_uring and driver-specific features like
nvme passthrough the only ways to go right now?

For users who have legacy applications that could benefit from
polling but still make traditional IO calls, would it still
make sense to add a per-device override? I can think of some
ways of adding a config for a specific device so it would
tag all bio-s for that device as polling (if queue capable).
But I'm not sure if that has been discussed before or maybe
that was intentionally discouraged? Would love to hear from
the maintainers for opinion.

>
>
> Thanks,
> Kuai
>
