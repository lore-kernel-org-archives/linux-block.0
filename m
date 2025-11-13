Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270D357A21
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050616; cv=none; b=LLXNyx5vAEg4Ac5dtwrtR7s0+CvjGufEY6TP6EsyYxFnTnrx+xAhBkUBFohp+aaFiuvFrP/+60NRQFfIt+rVwqmZLZS0FvnA/taIvUorZp0upYO16yOdmRr87AS8AHB1fVTUuWdppA7sLGMBGU/2JNrNN0TfSPnHnQPAhoDutUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050616; c=relaxed/simple;
	bh=LCEnkrzPI+ncNZO5UjlkO5gcfjzN2s9UEJySF7Oivrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZhEs8wRyRmqan+iLr8G7BuaR8jHlpQL6Gz/IcobRM5+9Hzbe0gczbsbc0DUdpdgXlOlmD0c1l5SA3wNuTOpBQUhn1C8PFIbf5HTiMCVqn5wWSmGDC/MnsLxdV6dD5RHNip1zGlg/oiswi4R4Ft1WeFiMe0BYAX8KIH9cU2b/C0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CySV7fUk; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CySV7fUk"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-434709e7cc9so5351715ab.1
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763050612; x=1763655412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5wmj9b8bVfJhiYqd/npthWdjomcoo1iyYqke3KVQ4s=;
        b=CySV7fUkDUmf2YAHzjRFmM8zzkfCGrx+9ZFYfLgcse+NsDpt4PLfDZJAtEFLB30QmR
         D5TfMquqasTjadjTzy6mZGu79306M3Y9UWR6w9WbW7ltLSR7fdt1J7WmwEoOLVBj7taL
         poUsOd9O8c+7vBCACNLRWPQ9y09f5UWAaqUlpTY+jcpBgwBqY/sFE8eave9vumjfjNBd
         CZKzk3ZY+Wf+8bind8CVzaKB7/IilmbftmMjJBC4L3zZcDst1GvwyDywS7P6y7Sg/lPc
         hae73wsbeJmhrLXujyJXz9QydCi/eCBye6AV1SyNYb+GDq5ohtD118UyRwE6I19mmiUx
         IOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050612; x=1763655412;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5wmj9b8bVfJhiYqd/npthWdjomcoo1iyYqke3KVQ4s=;
        b=b8SijIPozqxSZ3JtgxBhVlXrsXDeY6m/+nWWkp7fqUzRE3sDNexuYqbuBvt0U1Q0rp
         edeGigaO/KjjUTEgYH6T5s97b7VWr+q++dFvJ/kz+B+DwIMW8N1ZqOjvf/XyiVbYJljp
         vSdZJYa4nglyFgPaTZGVOIT5qPALBbYqfSOs1nqoOhvOJcRq3RvzI6bl6L09sQCc1OfI
         JNSHHrojjlRnEz2R5hIaFVSVIE+jG+0jnlEHnCU81R/PYX9wtkZPeZd4ogue2PEBSW6B
         UYpyH7g/Mj10y3XaQ7s/4fv0dW0uda0mJW6JM+PTqsWHlhXyfw3b5uhQg/k0tITciOhp
         fGDQ==
X-Gm-Message-State: AOJu0Yzi0jf38Zu0GXh1C2S+MnafJOfbY9ko5pvX8gRjDUJibcjsDtT/
	jp88/kcLYxKYCq8KbgnF//RlJXYx44TLG9O519ktPscBp8mEZhgcWY2LnOb846VMkdU=
X-Gm-Gg: ASbGncvbIdbKYgynHiEhjBHOH8PkvuWa7VuuHmSVU+/PcVXzhEL51ZW3yj8o3L27VOq
	Y+dnkFz0eYpw3/DVlw0OcGSBMNLwO3Jy6uO2KHzB1Rtl2jP5qeA7Vb1Ijtb9FMU+31a4qW5l9hj
	nSthXsHBcRa+D/5u2DRCggOMrTS7C6PDQi4rNwzel46fJUYkgG5GtGI/xTQhVPw4EZjhHbslkJ6
	gnw8YIAAQ6ZvufovlFUW2w6FT9C0X/ajKHPLZZrCRYFcYXhovDKLG+DidW9amJIZ6AwuMIs+uwn
	fF/pURjKkT73TxCU5uHKVzEfyrZeRmahQlI309Vwy0uUednbhwxQX2NfGrrf3o2i0D/zC4YC3At
	b88lfrgUnCw2zK80iR9jtxuBIxu59adipbJ9c7tT4ut/ko6q/OVFtYHey20kXHYxKeUyepDfjqc
	mHhg==
X-Google-Smtp-Source: AGHT+IHBuu5o8SJecG0eaoif9FdXidc47quIT/ek3csZTJiru5E5W9mwXmIFQvn4AYndk3M0J/8l8w==
X-Received: by 2002:a05:6e02:3d86:b0:433:7964:d83a with SMTP id e9e14a558f8ab-4348c8652b1mr987805ab.8.1763050612315;
        Thu, 13 Nov 2025 08:16:52 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434839cdae6sm8243025ab.33.2025.11.13.08.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:16:51 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <20251113134028.890166-1-dlemoal@kernel.org>
References: <20251113134028.890166-1-dlemoal@kernel.org>
Subject: Re: [PATCH 0/3] Fixes for zoned changes in block/for-next
Message-Id: <176305061163.127984.6991977211571159696.b4-ty@kernel.dk>
Date: Thu, 13 Nov 2025 09:16:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 13 Nov 2025 22:40:25 +0900, Damien Le Moal wrote:
> Jens,
> 
> Here are 3 patches to fix 2 oops (NULL pointer dereference) and a device
> mapper regression all introduced by the recent changes to blk-zoned.c
> that are in block/for-next.
> 
> These are relatively simple problems that should have been discovered
> right away during development. I overlooked them due to some issues (now
> fixed) with my test VM environment which was not always running the
> correct kernel.
> 
> [...]

Applied, thanks!

[1/3] block: fix NULL pointer dereference in blk_zone_reset_all_bio_endio()
      (no commit info)
[2/3] block: fix NULL pointer dereference in disk_report_zones()
      (no commit info)
[3/3] dm: fix zone reset all operation processing
      (no commit info)

Best regards,
-- 
Jens Axboe



