Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84B37C0F8
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772431362; cv=pass; b=F81F/eT5Sa0JUbS4SC/qaiTV9K7T7o2FnIhxUtrnkZfCya9h4ruVRnPNCtTftLpbtqo7G8Ja4sw34t6dnKwGaYWY6CZuXVNGj7PiZ2iKH4xCh/3NW7iifnKA4sTx/z1brO5hrbPFilLU1wsqcgtI/KbGbCbN7JQZGCZ3EF9wmiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772431362; c=relaxed/simple;
	bh=DnsZppuatu3gSfhyQneomEL62GRSWB4+vnT/LVj/eWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYldnEBIIWKEs0PnaIpNwHfpQoHazfKZXLK1J4ioxQfRsRTc+KEvzUC4kI6XfzIyLEekgifGLiFeoCLe8SsFWu/cOtNOaRmyRnYPqFAgWraTaS2IvxPRSSt74JQI3HBXSb6IA6zB7IMOU5oTC8oQtZgo74BkvJkzT3wAELkWNU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JNqmYRkE; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JNqmYRkE"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdc47747e2so3006818eec.0
        for <linux-block@vger.kernel.org>; Sun, 01 Mar 2026 22:02:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772431354; cv=none;
        d=google.com; s=arc-20240605;
        b=UCRh8nXf/6BKVjXH4hGuC8OKrZ5fu7IoAqxYfhVIsW9kj7FOa7oMAIx3XZBe6+UOOp
         d6BdZDnPmXu8gD91a0iMu2dCrirjxyz2ynhrXNPuCt8hzeaOMOLoZY+4SWIcbuFpIEnA
         VLJnkYrBxHnW4Bxzl1msUP36gq0GVzV8MUwGyQx9WygiO+IHEXxWuEZ08PLjX+wuUMd/
         3J9xPJ5MRw60XIjuo/9dzDoCVGLHXKvy6e1SzSco9Lojf0uZuLvyUg4/CEzX5ff8eHEa
         3abB5LsZgvWWbdsSTVjpLmbAlsPYqmxSk7qHQbnRpSTjFDdWjmMxXduBXhgwD4HA+lgH
         Tpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DnsZppuatu3gSfhyQneomEL62GRSWB4+vnT/LVj/eWU=;
        fh=it9Tl9E0kVxdwGCeedR0XC+JPx4sv3+7ezMpHs4eM9E=;
        b=cCaCm985txjlvCX8CshL+IfrVW6WqkH5c+Q2lXd1c7y5yHRZZbHrdJJ2vCridZ05j5
         U3RYquBBJv8BhiuAtGPQaIu8X6JbfKUc1IIgWi4P5O/P5gSuL9WdUDW2hvR4Zjcm5onj
         z/2r/8j/8fwNxl+SslemOuLfRau/UIlRAWoZebijY57YXQiat1Uvwif9F4VzwjwkN4ni
         3Fa4vEQrW+BY/d/wu1ZbZPAg6CIGPhW28C2tt/A00WPCh+J3mIOpggP8y1sZUa6aq772
         E3r9DGawHBvBOduGLaP9VNvdBjvPTtg3qtoxN9Egj4CobxbOLW7+t3Q73wYkJPpakusa
         oWfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772431354; x=1773036154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DnsZppuatu3gSfhyQneomEL62GRSWB4+vnT/LVj/eWU=;
        b=JNqmYRkEqX0bev5ZtyCq2ZhWTXrynvV9z1AhVO6s1tjrVZ1IVD+y8BKm1FoZlO9nb/
         CkMJDUgHS+mUvMbZNR+bu3KqPQDc1ufJ5xWrDmVOG5S5JHwwMWgPFp4qPPY35jpSihdV
         GsXPyQbQ/Mf2hlmjXCCF3VzZweTHLlX4h3Usqb0zZfSs1cHWPVWxVq9BY69NBJ6VYBp2
         4SAKoaRkKtNZErTvgN/Dc8kojmpU8v9EGc7c8raqcopRQPSn3jagSHnxBFQ87MxeLxNt
         Ol34550Yb8hhz8AIVH+rf9sWwd4Lm/FRnvEl+8bdeEJRaMQ/OtI/rP2+vKPwragU0zs/
         PCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772431354; x=1773036154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnsZppuatu3gSfhyQneomEL62GRSWB4+vnT/LVj/eWU=;
        b=o/XeDI0C3lIV6/tY8bhAA1QV/az5L/Dto7u/EVAO2GVMoAlcnTwRU844S2CxFkPa/d
         ivhZJO1JlGeC2QUgJnN54OJq3vaHmBDKvd+NYgwdf0VwXCyW8o/cdQDal3PF9dJyv3oJ
         595JX/rGU4hF+QWv2RO5bv4WoUpYpu7oNmWEd3EAxdvk464JwIsv0RdDmD00RVllhnSB
         53ziW18rRio4Qemr8lKohHTQypNXba836NNq/S/x3cuedBv7XJbZaqbKGrscN87ddppj
         EvPjRsf4nrnerrJ7rokoxPvb4GGAsv00b4SvAJQ8tNNzsQCl8rjB/qg3E3A0km050h/U
         SKPg==
X-Forwarded-Encrypted: i=1; AJvYcCXXA3Sh7UAIFHeUJUrq9MWMqI5WzJI7AYMcKrKWA1QYUM5SY4HjQw8iJM1xh2gLq2nLNGqtGwNyrUu/9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YybQToF8r11hg/nnTDOuezR4Dmx5z4eTf2gfjwESA6pmGSLEg8S
	zfAVcub0SzX2Uj3t+wGW8JejvUe9SuaMxl5noPs+Z3BYoeIbl/tqpVY5QwHtYaSPxKvv/Y8TyeQ
	8FMCIcS+tWByBFCptQKsN5GWRu6ksf10RWXrXXimX2NeImLoPIcaWNjA=
X-Gm-Gg: ATEYQzy4EQ/X4fIc8Rk74ctbXvxB8SsUb2Oho/hg2E7pKL8OovZ6620qk6Te4PfCXn/
	u+4USeDG1ekl0MbJLG3QRr/yCdk/J+I9LEYwfTIXxZ4fwTRg8asQZHB+NzOm/oaEMKgI2rKlaKj
	18vhhWgC17MefAU5tRLDQzElkB2qVhAVZcBP4DuZBv/5Bb+P4OMQHUb3p5AFR+SA2ug1jFNBWYF
	Cl+rU6hRz66RXxRKeik0mWw53MMwSZXuNvGeAsJ0PHd/F/dFMuZV2GtkoVV+TqdhAl+qfpK/pHv
	nTAscd5JR0cci+27FG2L8TEk/tHkslo5hQrYDo+9NjMoFYaL9JhigVKjnEL0wogvfnhH7WZeSs3
	ZWw==
X-Received: by 2002:a05:7300:214f:b0:2ba:7069:686c with SMTP id
 5a478bee46e88-2bde1be2e31mr3755376eec.17.1772431354342; Sun, 01 Mar 2026
 22:02:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302002207.12165-1-kch@nvidia.com>
In-Reply-To: <20260302002207.12165-1-kch@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
Date: Sun, 1 Mar 2026 23:02:22 -0700
X-Gm-Features: AaiRm52BMKBF_6fnIy2o9_Eq51EwXNhN6II0seQLIeXaZHlpvQk2HcLdy7tiHTQ
Message-ID: <CAKb3OG_1yUUhLK8uHUxrYtnpph8jNr_j1kjivEWQ9VtkP-fRpQ@mail.gmail.com>
Subject: Re: [PATCH V2] blktrace: fix __this_cpu_read/write in preemptible context
To: Chaitanya Kulkarni <kch@nvidia.com>, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 3/1/26 5:22 PM, Chaitanya Kulkarni wrote:
> Fixes: 7ffbd48d5cab ("tracing: Cache comms only after an event occurred")

I don't understand, this dates back to 2012?

--
Jens Axboe
