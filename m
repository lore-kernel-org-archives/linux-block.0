Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6325774
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315373; cv=none; b=dmcL7Vcj1xdemARrga52Fky0vhcEPJ89B63aomPYVNyW3KDg4w++LinWXhbwBfF1W9rYBUp6wQ6kUNO/cLnASOC8QDaGqWLJcAt0tyevl1LgDRIzz9jTj3Iro8j/Sr3KvVyFdByOe+Fhht6s2A9AUpvdEZ96FCWDV8PUlzCXxrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315373; c=relaxed/simple;
	bh=3Kfd/2bBG+9m6YdGPfYqvk11VMAMEB6oRvYyD5/z8F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdap8FdVLfYTN4vpS6GvbHqXRqAClkKWlKmHPWc1i2RvIwrSB1ioZYOWjKMQRiFSVb6B7xeypNAH7g19vVI2SSHRzvV2Jgn8bH3/pltwe9Ed8IyrXJpchQ8n2VptLPIPvhx2Xw1mSMgT2NWnPbHEQBeLZ3eZvV1c0r18FNluM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS50nO1F; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS50nO1F"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3566c0309fso85044466b.1
        for <linux-block@vger.kernel.org>; Wed, 07 Feb 2024 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707315369; x=1707920169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i4/C1wCVuGCMjccmtHe8e+z44LAnep868ewJTquIF9Y=;
        b=aS50nO1F6vZYSE+Hvjl4sW8533pQYQ2abyDJWD+AUGZEZzIsjhBZSgS/G+wFhXIutZ
         YS50X4qXBIOilgbRXTyO6AcpbS7BeAIH1cjORSl9Oh/icK1t8KFJAf0B2S+MLTqEpRNj
         0Aj0hBEpHmVBspCHewhIn178wliQSINucXmr8thpQVktBUMqLxgTvAYrQxdXF6/51bZb
         1LTonQzoPvqdjnI0hp4mp3AUH9/FAXlj7t9M5hA0o25S71qeF7k1c/XRDQFS6bpIHAU4
         FQqmrzy+AgjRp1T4PkB1PqIY2yHQqd72H1JUfz2Daz8l1XzxMkKszMGOew5b23UcI9Da
         BUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315369; x=1707920169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4/C1wCVuGCMjccmtHe8e+z44LAnep868ewJTquIF9Y=;
        b=e4s96waQK7mo1E03xyd7GPrzMptjnBYmdzd7JIAj5MiyC3yQ8QlZ7ZKlnjtIPSfJ2B
         g/KMObA7/g0BiPkZiXM3KTfBfKWpdx43jlHUaIgPdp3rgPaugviLENcBjahPqxcCYXFm
         MCHq99FE3aBytTjj4ZurYN1mjC0N2MKcilHBnxIsUyZOQ8b3YtzY50CBpjJkkmlVamcc
         wsgX2ftXfdmwt3aMlYsLYy6uE1xlk4CpEg3fjPi0U3j25hHgnstNPFiYhzjtPp1cV8Pd
         sIuKhhEp8/xu3oeXczzXSE/Sw3L0XF6pzP+eWIAh04O8UTj9itY4spEW3l3DkTMaYt7G
         0MPQ==
X-Gm-Message-State: AOJu0YxPH0vUsSJo9fpDDJhvZF9/WnKMkXRAG6MZHK7PRCm68dTVSYLi
	iKqy4RMgxdkz3ayCaUjB3MHud9Yw/eMXbCRaA7ZFqJK3PqujxZArHkt7Zvhf
X-Google-Smtp-Source: AGHT+IHiVGRXpikEZj5Vhd8g6jVV9NSxkPU6CmGAQoYSJ24O1FsEL30dQo31qNLnMGyBTxmTDrGXPg==
X-Received: by 2002:a17:906:30c7:b0:a38:215c:89b with SMTP id b7-20020a17090630c700b00a38215c089bmr3026035ejb.73.1707315369130;
        Wed, 07 Feb 2024 06:16:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlcud1SX9sMIOXEgnhGgjMXP+0i/3IdsIaRqp18+fVRENOMpmsiQmLnk4wdvSjJaRyHsNgmHcksZoMVurfEbbNc2EDJ6gIu+k2SEc9CzKlHZzX
Received: from 127.com ([2620:10d:c092:600::1:f25e])
        by smtp.gmail.com with ESMTPSA id un1-20020a170907cb8100b00a3758a1ca48sm791895ejc.218.2024.02.07.06.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:16:08 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	asml.silence@gmail.com,
	hch@lst.de
Subject: [PATCH v2 0/2] bio put in-IRQ caching optimisation
Date: Wed,  7 Feb 2024 14:14:27 +0000
Message-ID: <cover.1707314970.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is a preparation patch, which enables caching of !IOPOLL bios
for the task context execution.

Patch 2 optimise out local_irq_{save,restore}() from bio_put_percpu_cache()
for in-IRQ completions.

v2: Extend caching to the task context

    Move error path to the end of bio_put_percpu_cache(). It looks uglier,
    but I'm happy to make the change as long as it aligns with the community
    standards and helps folks around.

Pavel Begunkov (2):
  block: extend bio caching to task context
  block: optimise in irq bio put caching

 block/bio.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
2.43.0

