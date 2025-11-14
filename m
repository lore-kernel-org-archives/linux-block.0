Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE334679A
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151980; cv=none; b=FC5DutVWBAxMj1PAPOJSNVRZ/z9WiPatE8vNGFW4QiqBWJHgLWMJgSNCP9MBwREeF5DRSk6xSkecNS1pCN9kV1GDLi7rlJkdZTTEIHrea3qJNF0/nD4QmaPYW+hqKV/159ge51QQiULz7agmKri3SEMXZDkYRRDNAYTwjuqzWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151980; c=relaxed/simple;
	bh=UBXKy1JsF+c00Tx+eyE82c66VPELlnaIipoBvhQAyvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMJIUQDz8XwKsjDii8wppnYRcQ+3vRYqb5knXHDhAuR6NtoK7dHw07JkXfLy7erEUd6RPA88E9EtA/KlBMoRa8hclpmJ2PnaJQyar0eqaJkp5/7fRHy7rYolECMVpn+ZDPQ8z4sH6S6/ho8RhTnap6Xleh2a1heEl0kKD7466vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IwWZvdQc; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IwWZvdQc"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-882379c0b14so20172436d6.1
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 12:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763151976; x=1763756776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBXKy1JsF+c00Tx+eyE82c66VPELlnaIipoBvhQAyvw=;
        b=IwWZvdQcKol3rK+5x1RKUMO4o7nNAlxl8xawS8NzHoDiYHjTkOpgtk28Xvb1CUgT6N
         HGlsEsLySJkuQvey4zLL4UYW6eGfM7aQWcml8w1YXi8rI96hkvEjW50AW1cI584jyrGT
         ifkfiWdg2y03xBc4LYl60DYu3diSnM7hU5NnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151976; x=1763756776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBXKy1JsF+c00Tx+eyE82c66VPELlnaIipoBvhQAyvw=;
        b=PPuK2wB8ZrTvBdlcN5oLnJ238o2gV1e7zX9Q3wduNrrSNliiBUE5SaLeM19rR3YEDm
         X8DyayWzxYD9wGEXv7K6yl1AhHG63kGbHptHJdz3/E2VUgJCNd8qJgPdWTneFccV87nZ
         WyAHP6G1F4uYmwi18SgX6TrvDoO9jac5L7u48cQCB/rXGwKg1R+Ej6jGbOfMKiZyPew8
         guTFOssbrHX3gvala+uwHWJf/3zOJLjhz9UQflp/aE0iti8Jcu6mSuN34LuzGbQ23xcj
         5FyBzJW+zfiNRFTZjk1irviHy2bScPrgb9JFmdQZcWj5ah+X0KYCvmQWYZEPLHjVZLzg
         G3FA==
X-Forwarded-Encrypted: i=1; AJvYcCWTHXzMttGlwgTpHuzpHlVhOJfPULLAT1GO7ayzaVEut26YGsIVa+fyOJvI6PG+qqVsMxf6hd2v8Hu7fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/pBPdh2hCkK4ZJG1WXqiWIlR1FDdkzRQka94q45zu+zpEx6b
	hMIbtHlWduRmsevzRy+4a4JqmYzPH71+7oVnj91ukmjKY2Q2MRvh1i9Uz1Uiq5m/Z6iWAr+YUxc
	9ErQ=
X-Gm-Gg: ASbGncvwB8PqxI2RqCuRkKvuLAwsLkW2vU4ylqHFNXSexUrV2bV0MvEwZJ4wRPCCQko
	fkiM9fwjQJYt8qsXj5yNzO1x928GmR8//TXymMMC4You+Ss2CD7UT549JHnxwj2dpOoI/d7EwHu
	Dd2dFrOR8FNb0liFqcg2D7HgRf+kg5wZqUGfAq0ugyiKRZSGsObpMfDtIueCvTL4p9ow5giWhmj
	ZgcXheiahZQmTWRRpSuUTu+yOd1lfY9x/aX5is6BaluJNunfV4h82Vjc8WFEY2ZYt8utvWoJrn1
	5yFr8O6CF1Mtspdj+CDALtWT2H3oyUllSk3+kc3Z5kKEL8+kPkLFb5oSr6GsUg167i0ZAcECO9l
	5QvqeE/39lJ2XjlVG+yFGGM5qGmTjbnDJydQDu6305TRsDTphshwqm71MSlt0fR930QSkm1JB2/
	ToU9KMFv3ltvKHHjD5dztm2PyooxkVhY6PIXGU+gfFssuxLsnDf6ge0QsedDTUG1yb39SR6Fe9
X-Google-Smtp-Source: AGHT+IEuFzV2dbsTsNnbV0vAMSvCkx+23K4R3lrCzcCLdrxtGCrK354xgyuF694kjDfpaNKfYDKdKw==
X-Received: by 2002:a05:6214:5009:b0:880:4cfb:ab5d with SMTP id 6a1803df08f44-882924477a1mr47655946d6.0.1763151976172;
        Fri, 14 Nov 2025 12:26:16 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828656931bsm38386166d6.44.2025.11.14.12.26.14
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 12:26:14 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ed67a143c5so67671cf.0
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 12:26:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWq5yIfZbVjPahyLO79Jo0PQTeqP9w2vR/Gf5x/mHEB06UN/7CPyckvDUUGBZK32mf5w+t+HOJ4aYPmvA==@vger.kernel.org
X-Received: by 2002:ac8:5893:0:b0:4ed:341a:5499 with SMTP id
 d75a77b69052e-4ee02c20affmr644891cf.11.1763151974060; Fri, 14 Nov 2025
 12:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730164832.1468375-1-linux@roeck-us.net> <20250730164832.1468375-2-linux@roeck-us.net>
 <1a1fe348-9ae5-4f3e-be9e-19fa88af513c@kernel.org> <2919c400-9626-4cf7-a889-63ab50e989af@roeck-us.net>
In-Reply-To: <2919c400-9626-4cf7-a889-63ab50e989af@roeck-us.net>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Fri, 14 Nov 2025 12:26:02 -0800
X-Gmail-Original-Message-ID: <CACGdZYKFxdF5sv3RY19_ZafgwVSy35E0JmUvL-B95CskHUC2Yw@mail.gmail.com>
X-Gm-Features: AWmQ_bnp-FrH81LO9wZI0yv8eE_oTDu_DOH8Z8kJMW2op_FnlMZESx-1cXuPw40
Message-ID: <CACGdZYKFxdF5sv3RY19_ZafgwVSy35E0JmUvL-B95CskHUC2Yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] block/blk-throttle: Fix throttle slice time for SSDs
To: Tejun Heo <tj@kernel.org>
Cc: yukuai@kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 4:19=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 7/30/25 11:30, Yu Kuai wrote:
> I had combined it because it is another left-over from bf20ab538c81 and
> I don't know if enabling statistics has other side effects. But, sure,
> I can split it out if that is preferred. Let's wait for feedback from
> Jens and/or Tejun; I'll follow their guidance.
>
> Thanks,
> Guenter
>
noticed this one in our carry queue... any further guidance here? If
my opinion counts, since this is a fixup for a "remove feature X"
commit... I would have done it in one commit as well :)
