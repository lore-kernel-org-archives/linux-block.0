Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C153939BD
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802634; cv=pass; b=Z5jNbLfWKvzEfJz1dqXcyzr8N4Yz6ANQwsthMBe1Jab4Yg6mRALly9ZT9zvbgqM/d8L4As7dNCTrYyL0xnx7xKuq286Om4rmmGWHGfIc1h/TlAoh7auzHv4CYj7iLx3AITUPBNarRmiY/d7rWXDjeg3cqvjgF9pKYPBpd4fN7KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802634; c=relaxed/simple;
	bh=Nr4k2laMyCsFOgqbALYHiH+eKRASZu9DTP62NTtnu2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMmeyJZmxKbRBTLgKVJeW0RfvWolXzxr/HNtLYIn5Gwhiyp/4inaTl5IG2EWcXtetS7BK46KpyIqrZa/ti7zFPzrp+xfrSxnGpfVF4tVtfpQuB3wJOljh880AmmCekG3Ws4LL40Ov9xJOzM+gXAlbbq8F/g3VcOFWau0J+qP/N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzHZ5TQt; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzHZ5TQt"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1271257ae53so11136592c88.1
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2026 05:10:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772802632; cv=none;
        d=google.com; s=arc-20240605;
        b=JNzNr9lA8DBDXFbdhNUjTOgJM+SxlLjRZ79/prbXKnOH5U6rZAcGqF+XSz7EF4xiT6
         9ZFELYAN+oDhkLBmWgmpCN7bnuHQN0w+S1Or8sv3gxi2oGqaX+2hU9YxbYcXDTt3lHO7
         KdHLK0Qi+/N17heK3F9KBA1ICsh7ee3adVKdjpDKbtN7zdQ47EhbeqXQfeayQsguZN0f
         ue6pWk7T3wXxmxmDuqVwg0nx+WtWLjWmu5V1ft4mNEwyHzu2uwj4KSvIhgak7anX4Nl1
         gzKve9BbtSto6NDYkf7abPVzSVWhbjDUjuElwOEY2IZvojgu375cK50dB7eRwikVPtfL
         SwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/dg6fTAb+yLY8umPcAWZBhtX+H1Eeb3uAg1/u+VX+T4=;
        fh=HGPYq4a9zWEUBVUU2Z90UGd/GcWyDgqUXX6Uu+po1jY=;
        b=aQdo5GTbkWwXgshJKad2RuoFHfO3faIbaBw0sfR9k2CCoWEBWz7ki3oWktVq2WT7Sr
         JttmAXrpwWa1DGilxSGBAOHi0yQurpis+KvK7VNkE0xDSvQ0my4mgQnSIfnZa0GXIwDF
         C6GreUWgAXLm1HpnxU4TLG1KMd6t/Yz0RJ1kEPvKpLtl18XSdwWlTpJbZXXHXXcHuI5V
         hMH5MdzNV0E4n2/2RfLyOiRO8RSig8p0egzRxq65jx9wU8FRRABNfNPdcyZ9wopcHO8n
         p5FGitp7aW/COOWry0rsvn0/uMEzkt2rnMovtZf4eTWNqTKiageijqV9/p4zkk0Z3j8j
         Ta7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772802632; x=1773407432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/dg6fTAb+yLY8umPcAWZBhtX+H1Eeb3uAg1/u+VX+T4=;
        b=PzHZ5TQtt/Z7SawTo0Ov8nQNIIXYzk9Kx5w9p0aEdtGRYGPqatewSKIT4nlbjTVZAP
         +JiI80Os+X0warRv7ct6k7IylWd9ZjqRpPxi38B4S3miY5ztFgPLL6gr+vi5cvfReiLn
         2GIGpMl5K6Hky14sOUiQQ9I5J8N+4r8v2j0PxCp/7zuv0ZAnWTr6bvr5pg0z1Wezb1CF
         Fqi1QbxaA5ncWq2/Ml8OdkUlBe7lYRpXbpnS1A14tIr9hkpAr5VcatGGO2X5Zwt6sV+Q
         +NjYna5NMghsqh80iqim7WWCE+3zeo+CSgcQ89V98zCgzEJBzdDIDyH8wwh0shaAfrHk
         ZYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772802632; x=1773407432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dg6fTAb+yLY8umPcAWZBhtX+H1Eeb3uAg1/u+VX+T4=;
        b=lbtV7bL+YLnpxjk+YNhx3K4pcc0DBngrNtJaytjgyfxkqDnRyyGkQnTW4p6gAvBBAV
         jtTl1IzuCA+4J1JXRJVmsLHCeo/odfBxymLSyh+ClfVwHr/jEguc4S2C9HPY0JRyL8kz
         6IhpP/42FWY8uHSuv6qXaatOjR+y+kUehhZqyvAgB6ArHKgDcfyRgDLCpePiGwx6uPgO
         /oWxQZciqKCOr1/pmc0vEoNLt6cVZgVs/+X/zyD25g8EAQLFAgQJX7hdXcKfCF1Vr1es
         m0Ocu8kSjjol/4GrqCiqKmbanLlNNhUajGlJp/pkQdX/H/CoH8EWPk87DVfDeTweWYIB
         Bi2g==
X-Forwarded-Encrypted: i=1; AJvYcCUe3u7+cBjQiugjnTtN6W4A6pb1RgaA71dpXonhPe1/9VTPhGm/I+eHvqd4kaSR7H0M8Gki7bYZA+dRtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAuYbA18fOu2kXgQTF/cPmkdOD73GMkXe3X/2db8Q/9ihygPLQ
	ggFxdO/ZgGQbyycWjitc/KZB+6OBRiMNHSh1UCmqfuBTFt8oNdKYmSNQiX4eDdkgjNP4Qxs+9Cf
	ahKEWxFjXr5wTlD+XmQ01vjPCq9F+OPvfQhCyP9Nx
X-Gm-Gg: ATEYQzyOW9XCix/HNtAqGcy/GpXpAgPqokwrV0TMsCx+UmJUCo4bszbCKyN9/MVdhul
	IFJh2RQAb0d+FVTWZyxwLCRVQ6xaqoQRhqxSQU/dnDnqGH9cfl3NRiiONjjHfUd0q+uTGyMWpdA
	Mynb2jbCVseU9e4x3bEE8lrqkryFXA9SSo69Lbm9uLu9p9qDh/yVsOIZj2nTHOz5BkZhQaAWpip
	t5H+3R2NG+FhnpEHPdvVdXczxnqXhyTZhBNgZhbdKntbQNrivQBufiQ0s55b4sW0hMvPnyjc2VZ
	Y2CI+Zb+9+EB4t9P08zjwWZ+PUHo5mpe+jVQjg==
X-Received: by 2002:a05:7022:219:b0:127:5cd6:fa45 with SMTP id
 a92af1059eb24-128c2db9e4amr873498c88.14.1772802631173; Fri, 06 Mar 2026
 05:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304194843.760669-1-bvanassche@acm.org> <20260304194843.760669-11-bvanassche@acm.org>
In-Reply-To: <20260304194843.760669-11-bvanassche@acm.org>
From: Marco Elver <elver@google.com>
Date: Fri, 6 Mar 2026 14:09:54 +0100
X-Gm-Features: AaiRm50OxjwUhnexPZXPTKOklL9o9_FIROR_o-mVmTt2oDjTgZIy08vb2r3174o
Message-ID: <CANpmjNNF4wjZout_zz9rW2eoH4nAHQy9YURmn1hNtiuSsk+9fQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] rnbd: Add more lock context annotations
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, 
	linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jack Wang <jinpu.wang@ionos.com>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 20:49, Bart Van Assche <bvanassche@acm.org> wrote:
>
> Prepare for enabling lock context analysis by adding the lock context
> annotations required by Clang.
>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 4d6725a0035e..7f0f29b8e75a 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -833,6 +833,7 @@ static int wait_for_rtrs_connection(struct rnbd_clt_session *sess)
>  static void wait_for_rtrs_disconnection(struct rnbd_clt_session *sess)
>         __releases(&sess_lock)
>         __acquires(&sess_lock)
> +       __must_hold(sess_lock)
>  {
>         DEFINE_WAIT(wait);
>
> @@ -855,6 +856,7 @@ static void wait_for_rtrs_disconnection(struct rnbd_clt_session *sess)
>  static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
>         __releases(&sess_lock)
>         __acquires(&sess_lock)
> +       __must_hold(sess_lock)
>  {
>         struct rnbd_clt_session *sess, *sn;
>         int err;

This has all 3: __releases, __acquires, __must_hold. Only either
__releases + __acquires OR __must_hold is sufficient. __must_hold
implies that the lock must be both held on entry and exit - if that
lock is released and re-acquired within the function is irrelevant.
For documentation purposes it might be that one or the other is
clearer (e.g. I've used both __release+__acquires in some cases where
I felt it's clearer).
