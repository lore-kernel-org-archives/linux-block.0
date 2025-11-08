Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC172602
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762613594; cv=none; b=V60Qi9tGVUiwNCmniF4C5nFp88UjWReq7H6lGqa+tt4aorWoAPp3So/jqMDKZ4gCNwQcW6ZZCO4yXKqyuly92XKFL9E4b/+90uqv9jSm87NLXKXScLmpUrJRRzbzDFPUKnsRosvle/8OAFfAFd0ozkR3EfiRqgTT9d5wJf4Jjbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762613594; c=relaxed/simple;
	bh=M/pvfdvLz2kekRf1KXJQIhxor6Ncywo3beSJvOhSq/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8KvdkMapP79dPfgxxPqd5ZKb30kHzdjn0ZytTIiqgpEmDI6r2cJNxJOEVuwvDJ192zkZmooBANsMTNyLSdXjph/sTa+onPxun1zzPD1NPeeSRfZsz3L9MXpgZL+wYgpL9bpZ6XSJLo6/OS1+AHZlZkvgMtuvmP+xiHH5MI+gus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGU4k/AU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFaNJfJa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGU4k/AU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFaNJfJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762613590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/pvfdvLz2kekRf1KXJQIhxor6Ncywo3beSJvOhSq/s=;
	b=OGU4k/AUecfpDGRcrcXJsKS7z3Ux/jQhof3Jiz9y9H+Ggj+k/K79dCnXrgNmE1UQ9EGuES
	lLn7Q0hQiTzSQrWGWaJbKK4mB/1LHszUtIo5q/GH3ROv0nDOlZqbpAUKKRSOuC4fVKvi80
	NiXoVZkJGMLqHr/HACfLOhDB6cbhxuY=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-4WpReZQyPe-uP8bz8Jc23Q-1; Sat, 08 Nov 2025 09:53:08 -0500
X-MC-Unique: 4WpReZQyPe-uP8bz8Jc23Q-1
X-Mimecast-MFC-AGG-ID: 4WpReZQyPe-uP8bz8Jc23Q_1762613588
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-557e2f8039aso1216533e0c.0
        for <linux-block@vger.kernel.org>; Sat, 08 Nov 2025 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762613588; x=1763218388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/pvfdvLz2kekRf1KXJQIhxor6Ncywo3beSJvOhSq/s=;
        b=hFaNJfJaOfiYJakUF6UJf8OL0wN8Ah/lg8PALKRTQBS+jJaMoE6EyBo+/uapfwk89C
         rXiGTUUNCx7vjSCXCF7tVue4qANVqns2wrTWpq/Zym3eQ5/M/PzxqpuxvLIDa4BvukST
         WPZ59CpXgntVjce+UHp0IgbmxgEDHOMs0YENyOiL8gW/cn3eksBus+82ghC9pTN6b1+M
         uIoV4xBwAGE6OhJGgyvSFDY6qW1sBEzE9H5SyAGzXfzJPczULzzRi79RtY836bsnZq4U
         5ZcESq4L33CNqf1vTz1cObXADav4EXsnoJsYLH8bMeTdi2A91k31+Ezod3aGL5ehX+k+
         bjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762613588; x=1763218388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/pvfdvLz2kekRf1KXJQIhxor6Ncywo3beSJvOhSq/s=;
        b=FGcChJbHHxFGu6bqU+lXzjNgbGKcMNXOQ2V9Mp0lnEr+96RVHKxkMT2JsGRMMKwGaJ
         DAyImcRzvw8ycsrvQK+/Kz2qiNJf8YyCwcZM3m9lUxVrOKdxOj/pQ1Q5d3F7uNNXxbOd
         zJdjtZv5oajCHg2fxchjP6kGCnGkDKQOyFpouV7ll/CTeaOlKHyhxBa6jfFYPAeqEQGi
         7UyWU3ke3sGD9YMGjKI0PDtnMcBz7WqqvO/QjcZlL0BAPUC04EXFYvK1mqhOOyrmveWd
         Ete46qiInl1WHSIRExOjYi6RgQJWuWFQkRTeAkiWMOf+ERjuC3836ajqr2f6LKFnXxrG
         XAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeweovUeEAOmGZAnWNd4ZBj+RZ5e8LSsmLdfvK5Orcbfc/jZGLAzn3V0spXT3tWiASTXvvSOiGKYx3Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qaTjM4MwyiPnI5ORxh5gJvFG0ArEpO57M42DLQSzY3RCNwus
	A6HFUM8iKTF0gsYgGmREQF1d2UwluD/ewSr9P3TsWIOaxwkEuGSdUY8GO4m0mNq8yMWY4g6zgJ4
	lqrJnzu78mw4nLYJ/V0XB1fUcoPcZ/6YUtB9W4lnWcXc7kQ9fEKwVGdAsUsFLdTbYtlzwK8jBh/
	Mlh3V6UW5w+lzJexFrJvmE+Xcp363GEDkyCebmgxA=
X-Gm-Gg: ASbGncs60Nf70MAx3JQHssl4c/Fc/my90EO3LQ8B5bqkqsjUN1RkIJ0fvtMaLVX+seh
	dCz/3tfJsxxJB0SOsPu/uX83YwBNqhSsEhj0nDa2V3pi/6708r1aG+x+RqT5+YlszzjNxCt0+md
	U4BpF8gIU0MZc1xnWv/3X/1LyJIXEbAHOl4Xa7bm4GVpQ8QCj24kkEqZWy
X-Received: by 2002:a05:6122:2a0e:b0:559:65d6:1674 with SMTP id 71dfb90a1353d-559b32ecfc1mr781019e0c.14.1762613588134;
        Sat, 08 Nov 2025 06:53:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpfXbjTTSMaE4v8qrE291tFIS6TN2LcX8U6LtZK6fslNq6XbOw/4b7sE2PjVGHDcg2ww2yKZ6a9/OifUdY/Ng=
X-Received: by 2002:a05:6122:2a0e:b0:559:65d6:1674 with SMTP id
 71dfb90a1353d-559b32ecfc1mr781005e0c.14.1762613587832; Sat, 08 Nov 2025
 06:53:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108042317.3569682-1-csander@purestorage.com>
In-Reply-To: <20251108042317.3569682-1-csander@purestorage.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 8 Nov 2025 22:52:55 +0800
X-Gm-Features: AWmQ_bn54L_mrL-XH2_W-7fM1t6V8FDDbIvOrhBipY_MR5DvmqHYfqpmmtoUoy8
Message-ID: <CAFj5m9+P9FmNk6kQb6GUgFvTwGm9orGF1ycnvSxGk5QiYx7Lpw@mail.gmail.com>
Subject: Re: [PATCH] ublk: return unsigned from ublk_{,un}map_io()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 12:23=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> ublk_map_io() and ublk_unmap_io() never return negative values, and
> their return values are stored in variables of type unsigned. Clarify
> that they can't fail by making their return types unsigned.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

