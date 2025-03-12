Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFB924E00B
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789632; cv=none; b=P7JiUruFyuklys3NHjjYg7XFPNRYF4vRRp758AC11fpIJxmjGI9CyXPNadr4JzTEznQJeEUJASq46hHaljaTKfeb/KCnfMJ9RuT88szgBhf2wxuEdA6VyklxgplyNXwFxCKJuv0MIraP7Ondzi5QDHoWkCmqFF96P0hW78P8JDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789632; c=relaxed/simple;
	bh=6wEw943lHtUwgN72AWkOL4YoRnHBKa4yCZaGZNFhZHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U6uTxapR55qlsKbv07Sywg3fSoBjTvFrduz7UPgiRDThz945mTNq4koLB84YfPEKkG9n6IuBHZ0/TRxiWgr6CFZa4VT73WbraRERXcGvoFMJso5AQDkb176+i7j6C1ja6OH2ZuNS10Ow4VOMwDTmaEBcIlpItr0/HS6ze05iUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q0rTJv3t; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q0rTJv3t"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85da5a3667bso53991339f.1
        for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741789629; x=1742394429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMRSODIOsXT6T/CkSVqfJgUMfMK90GHSbIvmyb9xhYA=;
        b=Q0rTJv3tKzdmYw9/cvPohLHLKhTDBkrYT2lk1jteTmsk2JftBwLzCyLC67QLENEwmR
         3/OHbOpiwDlCA2+eEJkvXvwOCuKNFhTpdHEnBsYlsPFtTCy1c4Yq7HZEWGle1hP/heRr
         MQTvKBPVLVgMEqom/0rBUw4CQV1VDCj+B7UPAm7cX7nczs1rl669WslKZbYd0MROFGSo
         +terA9/EINlVH3qjX7DT6MW2BAkB/sQPuzZpGc9hgroX4DlFESBsWGkhIDKqZHs0X1O+
         4o306JlibMk88pTyz81r4fZSJXOSiga6+FRVkOYYcJLxMzMG2NGUL4T/5s2kKU/jXO3Z
         9spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789629; x=1742394429;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMRSODIOsXT6T/CkSVqfJgUMfMK90GHSbIvmyb9xhYA=;
        b=PUNzFa4vJnYGIEt9OqgsYh9UaWWcPlcYlPDSeTpm4EFii7MEPr1AcsZxyFaZa0PRwE
         /BVIX5u6SaQ5VoRjTI8s0SSh55Ly2ESUB83eSLowXULszXXtAQaSMH0q326Dk/wYqV9F
         +TSnzjK0yOMOd3Yvjupcc04GVoQFdHaudKyatnpqrrpJ9HqIQA++oSpWOvD6Ii2ci7U7
         nHxw9HqMWgZH4f99SwGKtnwzCnqbhmD9KJl7zjQFarqbJOLWEytbrdfFvjAwtQhPhUNU
         7nOB9J4nodKiitGvK4/JIxzthlLUhWkZ2B7WHMzbcnATyiJaeS9mJX4CNOwJqbai2FDr
         lYRA==
X-Gm-Message-State: AOJu0YzfaeK+2KQtGe8RKoEIoks0a5eb7EOyQJkFycQSEpQnU9ReD8tQ
	vSMh0g58baqjGJVF+0sjeK6qpCc28944hIQvUYRskMVjWiWAvoINXd6hzeWDzi1+G+o1lN/6sh3
	B
X-Gm-Gg: ASbGncvFCKHP18SKYHujh9+Q2nxif8SOzvsLWJOskD/WKo5a3cSdx7o5Z330pL4dHFE
	4HWwXD7DrGwdqTOehBukHnEWrUVyaN9nqvKhH80yXKI84RIfjI3wlpu2jnSZN62/KW4QY6UydDK
	+OEvq5gqSY/jtqnjATaMuXGcpG5oumFLdeEAUZzjIlk0K4J1O+h2XKmST8lajpA4Gvk0EERMvi2
	gyVF0qn/ZjXDnkpe9M9bQCljHm2YZil9ABtjSkt57FCtnpEkzbVH+CXACESCBe0zHvpQI8ddplB
	sNKuo+ArZie//NlMZgyK3K2GAF7U2ErvJZI=
X-Google-Smtp-Source: AGHT+IETiWExYtTjc+IcNeMYGVYuARHuyOBl7KeQ4OjHqMRUj+ySwepYn6hAb6JGdNvJbtZ2dew0NA==
X-Received: by 2002:a05:6602:36c4:b0:85b:41cc:f709 with SMTP id ca18e2360f4ac-85b41ccf72dmr1724403739f.14.1741789629083;
        Wed, 12 Mar 2025 07:27:09 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f23db8f8d0sm1335734173.45.2025.03.12.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:27:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20250312072712.1777580-1-shinichiro.kawasaki@wdc.com>
References: <20250312072712.1777580-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: improve kerneldoc of blk_mq_add_to_batch()
Message-Id: <174178962785.513960.8480899138080580036.b4-ty@kernel.dk>
Date: Wed, 12 Mar 2025 08:27:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 12 Mar 2025 16:27:12 +0900, Shin'ichiro Kawasaki wrote:
> Commit f00baf2eac78 ("block: change blk_mq_add_to_batch() third argument
> type to bool") added kerneldoc style comment of blk_mq_add_to_batch().
> However, it did not follow the kerneldoc format and was incomplete.
> Improve the comment to follow the format.
> 
> 

Applied, thanks!

[1/1] block: improve kerneldoc of blk_mq_add_to_batch()
      (no commit info)

Best regards,
-- 
Jens Axboe



