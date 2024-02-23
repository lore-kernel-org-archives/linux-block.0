Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9082CA5
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659120; cv=none; b=Apy/9ekEwCD8oQvDk4ynyVloG4aYahhDQDOpAbIo1sovOiQK4M7s9eSijkXqcJr8VLlhQQj4tc7Cb7hJxkKo6zJwjudb1110bVnbGOeFSYFjokacrvw7ADF2JW0WntCW6Zr3znkEG29OzPdpLZL8qaF643S7Q2cZ1HaJOoeASu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659120; c=relaxed/simple;
	bh=lHuaSWhDR6kAJ8Ml1lqortESYbdtZsahgJoQKaK0ppo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsRniUwzgDHhicou6bUZJK00ypDNgEKRmoC1IG9UWMMKR7dKD+yqPY8ex7qfX6VvJQghDZR7kA/ubTH44DYW1yjDwgnHaGrfKKtsbVU3gTs9EZcRNUOUuD4UZ4IhL4rVu3sJH71A65qev/rf2VBB9T1S2abSEXAwjM7ntDl8q+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3DYNsYT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3DYNsYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708659117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHuaSWhDR6kAJ8Ml1lqortESYbdtZsahgJoQKaK0ppo=;
	b=E3DYNsYTq9oZNWvQ9ZXpUVTzlyk3DYbNVA5eu8VFRFnjOSTW5M1WkCaXnljXNtBCFwMB8h
	WtqVC7XbYw2ryItMJpS5ekU+Rx6JRrRC71Fyi9yE9S2aRteg0zHAqKaIp5z4bACM4xZE5Z
	Owi4KH9ytNAFM0a7gONfq3UR1QpGLFA=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-QYN-KZjBPfWpp_JQng5BEg-1; Thu, 22 Feb 2024 22:31:56 -0500
X-MC-Unique: QYN-KZjBPfWpp_JQng5BEg-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-47054e3c8d9so2657137.0
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 19:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708659115; x=1709263915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHuaSWhDR6kAJ8Ml1lqortESYbdtZsahgJoQKaK0ppo=;
        b=fN6cdb01iFHYXWAIwn3dutig+qWO1cM2fOcuey4fArLixGS2yG7hXe3VO/PrQBmQfL
         27iUmO6n6KKfByyq3b6zh48LB/g0pX8t4P8l4d/iLl6T2SdGBxxdWTeTBoEC96+tXdD8
         leCmoenmD56CQz8kvAX+xhDZ4Fe9ldF8+ITBO9VaGF5qNmHswrHXkL+DlihxvPuUwCQ0
         33I7H4SKt2SWyDjMjT4K5lTJjkvUHfYUJprr1zEUQYBupCu8QK8Ercg4HvN6wxdODoYN
         LebomPnGMZLQboh+lMVK1vROX2Ds0olnf6gYnnxhcA4MJePUFazfmkNoEfwQEe+w4E7N
         cEbQ==
X-Gm-Message-State: AOJu0YzbGfGVgD3sb79DG+zvec0mLWOaWj2wTcxsyL+y38OTxafltlA0
	SWAJcCSYa2B/dYPl+Bh1EZFyNGmqsoXEsGSK+0ep1IT950C6VgE+rqZ3DMo8WsHpDaqwliDkNJZ
	SPDqycIFU7ut5UVg9BSMvWjAiug8RzLRF0kA7vJxLOKAQIRde+0MguJPLmH+uN+cDThGU9nCi7h
	1OF9fAvYt25SMPV1GJ9/RmbiwxT7gy6ONHakfRAHMTpLHHRG/H
X-Received: by 2002:a05:6102:2431:b0:470:3f0f:9e68 with SMTP id l17-20020a056102243100b004703f0f9e68mr771451vsi.0.1708659115423;
        Thu, 22 Feb 2024 19:31:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhZpTnKdyBE02Th2xU8OFUt38MTzgdY0MVc3gSRyFbwWuRT1NcVzxmUH8LrPjJu38YvUgnctY/nRkctOFp8gA=
X-Received: by 2002:a05:6102:2431:b0:470:3f0f:9e68 with SMTP id
 l17-20020a056102243100b004703f0f9e68mr771444vsi.0.1708659115195; Thu, 22 Feb
 2024 19:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222191922.2130580-1-kbusch@meta.com> <20240222191922.2130580-4-kbusch@meta.com>
In-Reply-To: <20240222191922.2130580-4-kbusch@meta.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 23 Feb 2024 11:31:44 +0800
Message-ID: <CAFj5m9+46VnnYNiFRgM2gn-bb14S4_Vsf9MN65K7j4kL5M00jQ@mail.gmail.com>
Subject: Re: [PATCHv3 3/4] block: introduce io wait hang check helper
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org, nilay@linux.ibm.com, 
	chaitanyak@nvidia.com, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:20=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> This is the same in two places, and another will be added soon.
> Create a helper for it.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

On Fri, Feb 23, 2024 at 3:21=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Use consistent coding style in this file. All the other loops for the
> same purpose use "while (nr_sects)", so they win.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

