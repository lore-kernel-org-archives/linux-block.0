Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C57257821
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195616; cv=none; b=Q/IJD8sttAcUEspCQu6vLACoihdk1j27UrU8/FMEEEIpIfJtoC6olJ46KwjskgCWOdDLqEtACS3QkTfYx8BzMKHL2rsgasVAmq0GAXeFaOIF2yXohldNhjiadcBKjwvXtWuVZtBlDwGusv997YVli8mkyxbq8b5PVNd5vVryZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195616; c=relaxed/simple;
	bh=ei7DYrD07jrq7cGqpvmcOPAFV1dR9HP4wffMQM0s2pM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E2GA39Z+BLs92PgcJQ3QncHtQW4luaDSbPB3yLGPuoGwOFghZo8sx4Wa/HADZRB3SKRoWKRRRE9/Yd9n9V173Q1Of8PhTu4eB/tTZ2a+hKyKt0dDtiu4aU7R2FVTN84bEUkIpmyrwoSW31y4To52L9v+6J7hbHYs3w5JkNQV2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3Tdoq4I7; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3Tdoq4I7"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-45c9fdf2a06so1811372b6e.2
        for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 11:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769195614; x=1769800414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSQrxZr5arLcWV7OM/midWhqm0tb5bPbnOYlUYukNv0=;
        b=3Tdoq4I7aNC8u7GDhe0n0USLjvJ6rtj7dMy68aPN7wSb5tdXTab8LALyYaW8+31mp9
         LPS13TbPjEBvqngzPnrgvpPLMqpddrsb0RjJE8wXOmhaRomuZUlWM8y8tE9mxp28VroB
         0rI+KYM41TU304cMJkzQKQyXuhg1R9hgdLt/XOcziDlWrN3Ypa5znXGCABiZ0lsZZLDx
         h5yaX/nNmHmxiWpdWszVA4OI9W15GsD/v23arQKQHhsqqWA0NLuMkx8YaFdFlPduJlGf
         JeZ/tHrsFOYxzpkgaQAgfm3hA8ApYHiJxtfJ+DPh/oFhNJx/ghzqt1XVViKAGu46iMOX
         7u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769195614; x=1769800414;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iSQrxZr5arLcWV7OM/midWhqm0tb5bPbnOYlUYukNv0=;
        b=PQ9+mF1b3gAqpjtgTWVePHu59WGzrzFPjJkLlU0tANiMH6aA/K7FDEhzEBQldSOsYC
         60d3uAcV/XSqHY4vvtlzAABW6rBJCbRHDDJ9TGHN3qbCJ5sVo9t28ZG1ASK1FrvEmxKC
         vGitmSf8bFoHRvZJgM43miGR+GnlyjN/wySSzj0VHxhx76oIW7fABWrse1CvzDTy0T4L
         x7Za10NhFlfbrPVbMDE1h0L8AtG3DDpiSBatUYIkhGG2wVPqVLZe8VxWBSxxptgCRYOR
         EdHqeQiJAai/j2k5dhQViMaBgKum70cEZBBptKt9wbhX5g3BloEkgXMg6MwPH+2sTl6z
         8AKA==
X-Gm-Message-State: AOJu0Yxx+EQ8uXsXUbudjMeY9Zvv30zUzGjmciIquuFGz2uW9/5C5ixx
	5H1HAlBhkxe+8+/JZXL52shYq631cFA8tW8wR9UDIAGhSt1HBBafy4O1Lgt6vdeZhN/TyWnB39B
	dAxVJU0UKMg==
X-Gm-Gg: AZuq6aLd7paGmb+SVtEN/Hs6dAHMiX63gWD9zm2FKB5T6zmrwY2ME5+xVyXvx0CUMyZ
	8Dh+GggGzaACDBTGFguxuKJWRlRgBxaOBREzVi4DBOAEWjk9GYzxaqN2rlbKZ4a8o5Mam2q0I7G
	tKAsgv+IWmXfiV82l7zCai6EK2nhWZpJC928iVMEwLYaevUBd6DUJGYSxq3bfoib+RNeStmKOIX
	+BBPNGP4c2xUrX7gNVb92JkgrdnSuAWCHXU6Hc4omaS1NNsHsrc0EpE1o8bXcSuo9bze2zgdVZi
	TPJ31Q4NR2kpZclu2GddC8mznbtQj4P5VaaDpiV/Ntf4WaFbQk6+tGacMxzjd53LhlqwnObN6nz
	i+N836oEWRnyVBsnrhswDhesI6Rl8lzNJ1dvHTbS0+3Wf5gOIMVJ130DkpDtnCOHTi4ECBEY9+R
	+Sz4d1vXDC8ojycR1i/M1pcVEGEktKVQ5EX020N2zWcgjRSy05gAra091IBETItbM=
X-Received: by 2002:a05:6830:6609:b0:7c7:61e0:a4ee with SMTP id 46e09a7af769-7d160b3afa6mr1408952a34.11.1769195613947;
        Fri, 23 Jan 2026 11:13:33 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b35cbe1sm2390582a34.8.2026.01.23.11.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:13:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20260123135205.2202474-1-ming.lei@redhat.com>
References: <20260123135205.2202474-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/2] ublk: auto buffer helpers rename & document io
 reference
Message-Id: <176919561293.731063.8947763808975933270.b4-ty@kernel.dk>
Date: Fri, 23 Jan 2026 12:13:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 23 Jan 2026 21:51:57 +0800, Ming Lei wrote:
> The 1st patch improves auto buffer helpers naming, and improve
> documentation.
> 
> The 2nd patch documents ublk io reference counting design, given it isn't
> very straightforward.
> 
> Thanks,
> 
> [...]

Applied, thanks!

[1/2] ublk: rename auto buffer registration helpers
      commit: f50af896932f5edb1ff7b407753ecfa285c30b7a
[2/2] ublk: document IO reference counting design
      commit: 420bcbf67b4575d6455a4fa0de06695d98d340b1

Best regards,
-- 
Jens Axboe



