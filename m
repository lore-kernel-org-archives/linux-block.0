Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187985C74
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924409; cv=none; b=ue7I9LKmaZgsJ4IlB2jb/k+LbVPll4W7FzQKZv03twZGNPXw4p6HLisvzT/J7jrp0ckkMrznzuQ5045doRxLM1LINO5hOrJWCztMIZJScncj/VHi9c+CwyELaDAjGefbEDgtCPDgRn9IpgF/UzIUswIDCtPwfiSWioarN5HmlPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924409; c=relaxed/simple;
	bh=h7j8TJiNbtj7+2QchrwMqZ412OeiJHeaB27ukrxLc8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2QVhkz3g5N/gNeVXCZjbHBgLzYezA2K+G0jw0uVmyA+GLRyKGlswHTyLa9PPtJfRqki3PrpS2LpXX2wgA3s46U8Pl2nveFeP8lkhM3yXdoVcNB8MS6GOy/+Y/lMrAh5yOCqergu+q9S3fnmQHst+clhG4KQyYJH84axUpCzTmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlFhjBUX; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlFhjBUX"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4ef5c772f7bso1525103e0c.3
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2024 05:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719924407; x=1720529207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h7j8TJiNbtj7+2QchrwMqZ412OeiJHeaB27ukrxLc8s=;
        b=KlFhjBUXUsJFadYeT13aHa8Qdrpvbdzoy+BOy4vz00TZdApw0LDLJTOjTPIApBULRW
         MP1CE2x9Bu4wm6DE4CVc/6i21uFC1MTdgopSnkBaax1JRLG8n+mZKaGToycZD9mi+evF
         ChPykTh/HmYJr1ZhR8PJNP6T4AwC2Qm9AlyWDkv9E7MziKJV4EmZkE16bvWfdADemPjU
         bh7dKvqJJDQM1CeFkdqH7mIWSQ0x2TLbisiGCSdv2BIiFNpfn+VTG13TlBI+ZkI+pP+b
         l+Ab8vnNSWP9dqWJuBYvKaUpmZcMlCSS6ihxxEG5nvp6+Eh5mo/jLWh9HcErzaYc9CL8
         esNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719924407; x=1720529207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7j8TJiNbtj7+2QchrwMqZ412OeiJHeaB27ukrxLc8s=;
        b=am4xu/lfbrOX3WFGDjUqhM+cVBwt8HqNvTe1/kUVsN211j0AXTgjY9DpGBPq28w/8h
         RnDBDuHgX13xDK4QFHptaZMP7EuQcYs1a+ldIQGt0TUTlsAwLmtGp5zmlLnu4pIKfUSp
         qu8WcL2juqghYjYlh/0iabFWfhKvwt0rFiH8t0/nrLqBPHTa6aJsHPdt+ogJKVY2eghx
         YYAHwF9qf2sQ/0Ne64YigG1aFGLMRjRHu63Gj7eDq5yFXTKYU2y7v6Bk4JvPRwO7xgH7
         NA8tDvorbuZpexpq9ez++rNiALrYKpTJm5u+WN3RmzzHYO5+P3oufbr6zd5dWpJHb6dQ
         4gXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzqBO5stkohoIYQjtBhwcU5MK++z9k6RyhN9jCnuj4TB5BFXrDA9VOB7xJP2LIx6ezt0VKLhZr8j+prZgPfj48DPhaIC5mDmxcqbg=
X-Gm-Message-State: AOJu0YyRLqlqE0ZqiBHkajQzvA8lV2hrZb7932hTZAUGL6cjwxp0uSFq
	QCVOyxOEa5ZdoNBhZ0dqUaDuU+CS0vuRxWmJKafVMdEqouCddwihu3ZS5fv5yU/pGF/J8DRAvO9
	NCfU9b5OcNYKayTAVETjIyt2XzA==
X-Google-Smtp-Source: AGHT+IFvfb5U5geI1+XSqlNrtW1tk3qeNmBXXF4VkyKjbYo/Y0TITGKEQuVVbBXcQzS4VQ5hdTuxJUMbExZz6R0gutI=
X-Received: by 2002:a05:6122:4f9b:b0:4eb:5d30:3fad with SMTP id
 71dfb90a1353d-4f2a56e43bamr11716364e0c.10.1719924407048; Tue, 02 Jul 2024
 05:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701050918.1244264-1-hch@lst.de> <20240701050918.1244264-3-hch@lst.de>
In-Reply-To: <20240701050918.1244264-3-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 2 Jul 2024 18:16:10 +0530
Message-ID: <CACzX3AvPhiz_zAw5jSzKZW3tTK1CF4V=4F7PWnGQApz89Zc+3A@mail.gmail.com>
Subject: Re: [PATCH 2/5] block: also return bio_integrity_payload * from stubs
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Looks good.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
--
Anuj Gupta
