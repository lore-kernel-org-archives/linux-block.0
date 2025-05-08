Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA327A111
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716791; cv=none; b=Idjooyv6H12Q9qVfBLa0TN76OnRm/5/fAIXVXXnWnewuWjEFtS5VRdRlZFI02J5yd8fqwq+6GblqHVV3OkRu0Utg+jBbb7KwzBN7e9Si5lTy5tdACeUfezD4TYgqLJ+JD5y01W9DjWyoWUM593rOf4TmMjRi1LJUESMLjJRmDZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716791; c=relaxed/simple;
	bh=AxzJbGhbNxYAe4vV9jyDdg+rQhnM6Lc9uZl4cPNtXdk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UyPe/3JVEkF6dEoxOT3HSrupIDTRT3xAkckoF5/8UPbqQlJOWJEXDSgE1yPgN7UD1L/vme+zmk3041mKbMUqXCs3SNhaTiR/VNUGUKqyXzSjx9zDNLa3+jfoSQ+Cuah8xHWd695bd+dT40pgAlphfIbh3mpaOFwap+VFSLjHGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AoI1YP13; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AoI1YP13"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85dac9729c3so84820339f.2
        for <linux-block@vger.kernel.org>; Thu, 08 May 2025 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746716788; x=1747321588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNJIyW/CfEbXxZfNHc1vGr/ApUaUIU7r563Ant0+nTI=;
        b=AoI1YP13f5aQzfIjScExVSC4KIbHPVZ8H4bAyDLWyclEC/aeVt1eqOOx8v5Du1MTFH
         UruVlEVuORVyEyYasJ8d2iBdZQ8JD/Jr7Oj97CR+2pplbhh8bdxpo5eWwH+Qc+8NHrV4
         Za2dgALBXDuCo9ZKW8kP2FJD087dSc+IuTlX4Uevlr8PKwV6FKDaWKyDSwn7V6G7jvUR
         7hxOLNp5Bfv6qTQWKn06zlBfsW2LUkLrkEgPbP/6K/ECq/yTJ7Z4mtcV0HqXUdrnBVi/
         +w5qgKSQlZTJE3z0RIGT2tRICUG1eQ5YHFhacyUnL43wqg/PLeo+UujT2XzTo7PWXm8X
         DR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716788; x=1747321588;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNJIyW/CfEbXxZfNHc1vGr/ApUaUIU7r563Ant0+nTI=;
        b=adumr2ob4A1gPI0VBj5KZ3+CTLEOcSUih0ojfhHtBsHGFn418NEUuP6AlE1rgLZOT1
         lUX2oWMOuaxW9MHIVpyliTgiW9795ay/zf9pHkPm/7okiobQM9j3LNH2tB5+R60g4bKv
         Bya/WwyWxLpx4plz7eDQeKKtgpZ5GonvVobp5szmOTIByjF3+n+NzbESoj1sooGVr1hi
         Fv6zlmrlLzS+bdtTOPqFm+gEhbO3bJivBap2zPQEm+d0Cakgj+U6Mckmd4ZMB3DbYF0I
         srT07zRg+yS8POzewUsLUn4jcs5eKUsgcMNc7/h4uJ9DzgWKufdP5ZHqeg9mF/5NKzdr
         a4lw==
X-Gm-Message-State: AOJu0YzcqPN70fG0IrgiXWpdADc84pIKIqDwDwNxPUW4gwHDp2o/PIP6
	VRRGyJ0mKj0gMNTtx0Ilbi/Pjh7wnxBL7EP2FaZ7rJzslgPjprXhxsYOiGLMVLI=
X-Gm-Gg: ASbGnctmCssFP6SD1wYj2+9GG+2QTKQOiSrJ6XiuRWqe6H4gLO9/LmpwgqBPs8Gmn9I
	RsnN4IvN+DIKPka/RcOJV2Z+XEKPrNrqD3ynG5GLU4xAIIBKbrGC61/3nn6xoekedSLYlnfLP1K
	b5jPZ7V8SdIrYMRhSpISgPqyauGoVFZzelYSo09FauGa+1Etw9nIu2+gxO681LDs6E2OHhP35HV
	5h9mniQWp/Kzvop1TbdRpLQVSnoeN0SVZfS+LikhGA6pFm9egdUPGfNwqMt+Hw+KlC+IKWLuEyZ
	QVDOghb2hbzfdIZDJ9bW2VZ8gmS8EBI=
X-Google-Smtp-Source: AGHT+IHAKG5oeQaYHrRpRAmfGyN6U/Rj7EaHlokh/LXannASrrvgH1Pm7uPRGzivyHyHG0qNyffo7g==
X-Received: by 2002:a05:6602:6d83:b0:85b:482b:8530 with SMTP id ca18e2360f4ac-8676350f379mr2849039f.2.1746716788316;
        Thu, 08 May 2025 08:06:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a9418d8sm3110872173.63.2025.05.08.08.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 08:06:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <20250508085807.3175112-1-ming.lei@redhat.com>
References: <20250508085807.3175112-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/2] block: two fixes on recent elevator change
Message-Id: <174671678756.2122953.15943335415064134974.b4-ty@kernel.dk>
Date: Thu, 08 May 2025 09:06:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 08 May 2025 16:58:03 +0800, Ming Lei wrote:
> The 1st patch fixes one hang in del_gendisk().
> 
> The 2nd patch fixes one race in case that add_disk() fails.
> 
> Thanks,
> Ming
> 
> [...]

Applied, thanks!

[1/2] block: don't quiesce queue for calling elevator_set_none()
      commit: 8336d18c6b57a603aaa4db76bbf4f8cb08acfa5e
[2/2] block: move removing elevator after deleting disk->queue_kobj
      commit: 824afb9b04648ea11531fc9047923ec07e7a943d

Best regards,
-- 
Jens Axboe



