Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04F38AC87
	for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776060083; cv=pass; b=RcGty/gQekaJveSPRzrtpMJr1fUxHjeBJllnqh6tCgRPCKRUOricWakSlu/WzdIvvgCc7gghjHAFxWM6xDiONiZ7ev3+KdkA58OMwtjdaIM7bxEX+O8dX122didooHE22Y/OvZnivqKrOugDjcLlTNLxHP96P+EfzPxQlxoMxv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776060083; c=relaxed/simple;
	bh=MikU4MeYJ5nsBp/H128zTTtYC4D0DP2Kc9+jTVjGu/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGsUjTeLfEWf6UfZ5QHEG9PcJhc6NqWy2YSQ5ynZM7d0+qbajFV8ggy+Uk9Z3ywbzk8CVvRDNT3tKGcir7ZoCeOROvVdDAhRxlldVI7twRT6F1xkjaSi5420V6zJ6++wXeWcQTphhZTYnJey6ExWRhNx+TuKk+vJOYrnv6tDYh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VC2Qfs+X; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VC2Qfs+X"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c1fcce8f8so6727818c88.1
        for <linux-block@vger.kernel.org>; Sun, 12 Apr 2026 23:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776060081; cv=none;
        d=google.com; s=arc-20240605;
        b=XD4VNoBEzQ1joaNs2la+nJpckH95Z54nOP3n20XW5WfB94D8SGEBSvxFU9zv6HIkfE
         VyuAB0NcSRnUUv9r+aWw2PPTriqvnvFJnVObDRNceQVSMB3PM0RRUuDksmVbcFbKNv4Y
         w3kCVwsec8+h7DmOB3LWk3U0Lm7+Tg+2awpmDS9ZvAjMxT2wBEm+8Z1i/hcc+Eg6Pjtf
         He9EERAczDUpfHXy1mENR75e1MfsNMkVgzmci0jlH264iLuwaWZCIP/q5tt6p0qqZ6zW
         auiE2Bu2SDfzH+8MUXmJFnnL9jYCEEL7D/N+bjfHGjimmcSNguuzyl1ByqgCTbXBukSu
         T1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MikU4MeYJ5nsBp/H128zTTtYC4D0DP2Kc9+jTVjGu/o=;
        fh=Wmw2uS/DaHNSLjUvpdDtBbZAQ5YwSNu3cAE7ky+S2gg=;
        b=e3w4wqQgBKd/XPXMnw876hxF52E8lnymYv41SrZrv1yz3ZF1Oa956yKJot6us5DGgC
         WV+3J0W5maaKjDBmaqSK1Jo/4MsxD2EyWLtAOvTuoq3YiYjL5GLN/DnhoXbxdmxFvU+S
         RVjQ+EPgRDufFL1Iez1SkiLp23hc3Eh/eEAsopjaTLsTAlzWG1ox8fECzGWA7htgB/8f
         0KP1bhlG8vMFPP/RgFdIq8Ea/s7Kq225DFvCGSVyaCi8NTQvTu+EE4odR6wmRvQHOZv9
         LkVNJrRYcJgB6KEudSlVLbZwaSjZE5cqK91FkGhimwZmqRwIRwjmb9GQZN6aBAcsReW7
         sY4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776060081; x=1776664881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MikU4MeYJ5nsBp/H128zTTtYC4D0DP2Kc9+jTVjGu/o=;
        b=VC2Qfs+Xxjmn7+7Qw/LSxn5tlqpRRFONwIiHmjueAPv1D6kGC8iopaRDzKYKp5uqPM
         qrq+MaOs5sCKzIWtFAuj0AONpmiAkQaiJil3Sz3EtIpefBn/YErfYYE+SJbyRlwq0gGF
         58YOdQfI8YQLku7FP/laxv5V1xAlSZKzemzsHcxmyddbpDIsKG4Oq6ucyMhgAaBMRS79
         X6XAQivKzFbB6WZVlELHiGd7FL9NInJ95JUBdXQoaNre4A7f6rjVyH8HPoX8a3ULNhY9
         QyXj44cY81fG3Yr36yhccccy9ZENxa75spwgkeC4IEk2kkmZxJd7lGKh4KpbqFnUElEA
         ZBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776060081; x=1776664881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MikU4MeYJ5nsBp/H128zTTtYC4D0DP2Kc9+jTVjGu/o=;
        b=jq+S1b0NYm0yBYYU6prYmQUZT4DYDEXASKItp3qe/1aFasoLplSaPIVjP1h+9CGJK9
         dXLwwPSAMmvuBbyWSngXKJV67JnpPHQdZtXns2G6GZrc1gaX7YFOuF2ZkUGStPWcvfhr
         +LNFzviS2G1Jd+qIl/I0BsOXqtPCckm1syBN3Xqv7dmNy1QyGyaQIyZu4tqULALhnk6o
         nLv8uiUbaiiL9Rszy6Ra9I+lf+butlVJOmKx0hLS4FJ4pHGHYz56VNv3U3h5I8Hsr37o
         YxLLsazyNUb8wLmN4s1WX4Ga4NVypEJL2vOHIguw/gGpN4r5/SD3hTyiKEJbqReErbEc
         ujWw==
X-Forwarded-Encrypted: i=1; AFNElJ9kw9RgdQYFR0+vOSLEJiyKEw5bV9SpaigHfy+Lsg1rRBDbVTz4ZjY6cyV5cb2tFhxL65RiLN24hFprwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAX1dM9TZf7z4Ixx/jnM4kMntKSUWm77qxGOAV1Bx1nIfEKf/V
	2OTRoiTBmrlYao4WY+PuXDa23SFrEBfkMv7xLGOHtV5FJcU6/wNA3U6/suK6doU38n9/MKVu67O
	wQ0runL28nK4DPqOYiUdW6g+0+UguVdJ1YrI+eudA
X-Gm-Gg: AeBDievAuAM/nQfUC6SP7ioHKeoPYUtlHlge7cXEXQBUFw+u3GDIFOy4wvyxmL69ryz
	kCf6IYo1OkdYlQjQw3CMZyXhmVkDp3Qz//OwwdwbcubnxiOdC/FVaMApqUFB/Uvk71UR3bhpBZz
	4o8tYo/WFVJglIx3H9+zvbg81wcuVC7zx3tQafWZtOl43XkZ2ns9DLwTKCyRi9jWvpHcS28AQdb
	MiexHoVdw7sr6GsaEDcMet6/dUAPDVWBvJf9+QPm7ebDxkSLeX/yZrNbYPhZmGNdLfIPTqJzFGE
	mEX6UQSbC3xgA+a921BFnbkNoMc607d47YMw9iv+pH3BnXYTx/lScODimG71
X-Received: by 2002:a05:7022:439f:b0:128:d5f1:d594 with SMTP id
 a92af1059eb24-12c34e7b83amr6598081c88.10.1776060079922; Sun, 12 Apr 2026
 23:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402183950.3626956-1-bvanassche@acm.org> <20260402183950.3626956-3-bvanassche@acm.org>
 <20260409064221.GA8378@lst.de> <CANpmjNMUv5n2VrWGPBOzGg7-r6gf3hH6ZoJYtRsrntY8+_=fQg@mail.gmail.com>
 <2e09806a-d5fe-4581-8024-906be7dca4de@acm.org> <CANpmjNPJPz7qruFw8S=4qoF32snPW-RYrd_BZK6skR_y86CUZg@mail.gmail.com>
 <08078df0-d3e6-4860-b22b-937035d45857@acm.org>
In-Reply-To: <08078df0-d3e6-4860-b22b-937035d45857@acm.org>
From: Marco Elver <elver@google.com>
Date: Mon, 13 Apr 2026 08:00:00 +0200
X-Gm-Features: AQROBzCDoNkZTqMClZimyPVwZeToWlq6FBYW0x4gFjEiVqG-Q1HDSO-u6JQlwU0
Message-ID: <CANpmjNONpHgSzavkbqdbM2N0oCtt2_2+UqBCMWjMaWEcWrCy4w@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] block/bdev: Annotate the blk_holder_ops callback invocations
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Apr 2026 at 01:44, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/10/26 3:43 PM, Marco Elver wrote:
> > Can you retry? Thanks!
>
> Thanks, this works much better! However, I think there is still an issue
> with this new version: no compiler warning is emitted if one function
> pointer is assigned to another function pointer and the lock context
> annotations of the two pointers differ.

For now, that's intended - focus is on getting rid of false positives.
Doing what you suggest above would require abusing the attributes to
effectively become type qualifiers; that's generally questionable,
because that's not what attributes are meant to do (and reworking TSA
to provide real type-qualifiers is an intrusion into the type system
that's also a hard sell). So for now, I'll try to do the simpler
change, and later may look into adding -Wthread-safety specific
warnings that points out such mismatches.
