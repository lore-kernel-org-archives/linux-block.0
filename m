Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6732938C
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092477; cv=none; b=qjfgofG9uTra5X8f+sYVcn2EjF1+pDT50mh7ytpX7GB5d1bNkIJZWNGj4bLnJlACWz4kDDTHKXR1PTgOd/Ravfcmsm6yGFF86Khv68LxmXnj/2ZLU4AEtEGAc9BG9mkCn/7ERSQO2EEfKK9aYebRVWAK1zaukcUEC3jyiufWqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092477; c=relaxed/simple;
	bh=729oAacXucWLLZlw+WBNXo42sA+l470bSycVoUMuziQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L4vnADzPSHxMlKDKX4SYVWXYEw0evkY519FaGxg+RfE7nGt8fQkE9g92ZH7zg8jdoBmcAHrklz3I9vB43vJ5TEGArpqRzJHn3IRKE+HQKUAWUWxWGm1GZr/vgyBsRgrZflDoy1AjFYn6h8K1dGp6DmsVzJKUypdC6jzFZmJfnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kgx08PG5; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kgx08PG5"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-43376624a8fso26828145ab.0
        for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 09:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764092474; x=1764697274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LPXoAS9xQZjuh8BS7bP/lvg4M7hlz9YXYh5+cCKWMI=;
        b=kgx08PG5tfdq+n7wEukx01IzG1XpwCSp8qlYeWXE5y9pY2aY30vPQRrRdP2dQh0nUX
         c2JzMJALn9x4tOqRCE2m5XRA0sVBkAWWS0DaJv1u864Miy6d7PEGECtiqRRXYNTaVrnu
         BuIahe/MSax/HGGRgO9zh3KOzlv3dN5jmgHPg6Lhm6398KT1YUZ4K6pAammn5vWzi87K
         ISmCMq5DzK2OK0OpDewu2pxHvjl6fAwFsGYaR/nGwBf9ddh2gWhq0JnK+yu1o7LphS4D
         F8Eab3Jj7MnpPXKgUtbSVm6PyN5NJX49qbkr+P1SdTj/2n9k5wS6O/T6zXSaewgyeYtW
         VUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764092474; x=1764697274;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LPXoAS9xQZjuh8BS7bP/lvg4M7hlz9YXYh5+cCKWMI=;
        b=RG+B7eynb5JzSLFixh9RW1iSodvtEgVibzqTkT20tTfZtw8+NbgnFBHOGrU1Z13Veo
         /67T5X5MH6K0ThN1mnlh7+yeAwCVCihINwOFC+ePLbm39syW9wB4ATcHeijlQL9K+9pc
         Go2WcEaZdUy8psVCLNKl4Q1ZDyUJhBDIZ8St77mF02EzvW6X7IbkcSPMcyZ51deeL85C
         eH/ScRk/v+DLX/pGJCejLphrY27gxl3cUK0RtLLT0l5wtg0xlZUGZqLT2TPdALjVUY77
         5dM86rG9IeL4OI6cC6XjZqUIZVmtt0h9UzNqcefu2bUt0TVcOlUpuyDS9mggx/5gFIld
         pwQA==
X-Gm-Message-State: AOJu0YwobCyA4oud64zgy5YwTVRstFf9xn0KoQIHAssQNFhnNpl6Kr5H
	qGmqRpARoBU6oEYNgVjGXztdwi41Y5jB6BjBdfZLT3ZzHDIa4tc8MU5MW0uOnDXpcHY=
X-Gm-Gg: ASbGnctksyf7w2Lemh/2VhJeZRuo/LvelHhGY5+7o0ymYuCS61U7kJOZZlA5VUCgbY/
	oT4JjBeRUqJj87HwQ8fuXToWVqyn12uXUYj5pFiT6B+qMnY6PPo+Ph2faVUWnUf/hQXxwIfWUYT
	zzUeQdRVH5kX8+HD8Oz6oSXn55xf/lgTeatexVqlG+rMSjRlV2blWIttxlODBiT8xhGeTfU7qHE
	SPmRjASPKLqCEIv760hptkNBzpS1yQX96O+5Rmblhn+KLicQnO80L2CsPNi1x44wjhmTNCFc4GP
	zA+HQqFc2aCewAUGuJU05qbuEzMb2Q47P4Rz8v5GDKp+mDHJSOIvIqmvjf4Bnksj1N7JST9vscs
	6sHtbUKoWeJg0oFnhlPutcd/l1QqICQoZTzxaPOFwsLVdi73V/xO5UkFuYcSsBcA=
X-Google-Smtp-Source: AGHT+IGCKmTZVO/vv5LqBss3keHoi0dtCcZJpbVSir5WeR9fGU3bw9M61bcC8FgUalopKoZGKLEbCA==
X-Received: by 2002:a05:6e02:1567:b0:434:77cf:9e2 with SMTP id e9e14a558f8ab-435dd117e01mr38945565ab.31.1764092473935;
        Tue, 25 Nov 2025 09:41:13 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a9056ba8sm79356335ab.7.2025.11.25.09.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 09:41:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20251125161113.2923343-1-john.g.garry@oracle.com>
References: <20251125161113.2923343-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] block: Remove references to __device_add_disk()
Message-Id: <176409247282.26472.13016750760654513497.b4-ty@kernel.dk>
Date: Tue, 25 Nov 2025 10:41:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 25 Nov 2025 16:11:13 +0000, John Garry wrote:
> Since commit d1254a874971 ("block: remove support for delayed queue
> registrations"), function __device_add_disk() has been replaced with
> device_add_disk(), so fix up comments.
> 
> 

Applied, thanks!

[1/1] block: Remove references to __device_add_disk()
      commit: a74de0c3663cf5cf568025e964524a5f875e4bfc

Best regards,
-- 
Jens Axboe



