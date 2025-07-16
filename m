Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06D2F531B
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669294; cv=none; b=C0JDwUfvhelRGX+f8X02x4tx8pjZxeYGWRCPxTc0vNFaleCodScrhY2tohuZopAr4epAj0JSjgUl0rJR52tVs8tA5m0YH4kY+i56HNpO4tTkHhyunip8fvg6YkhTpBGa+mzjbjZCoRyl633jBmGWI6QTnhE9oBUlqK7Q5aHrKSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669294; c=relaxed/simple;
	bh=wEfoSmEHl+mrR/waJTsvBhRrS3LkaE+KspdTLqx5Mzk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rMeJbVay4M2MDc3TPlss43km/pmmuEpze1muIwYgGiAtXNGILvRBlPRQ1PgKFbrLEQXx9OkcJ3fmP7uxlLPuk2MigzQ3m7B6rD8lfQomu5DcySciODUYyMXOa/H8oVKtfMazvF8vA4R536tDgPfKOqFH6Mg/opy20Zk3cYfHCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Sqb7k81d; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Sqb7k81d"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-875dd57d63bso25136439f.0
        for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752669287; x=1753274087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUfmoFDnC/6I49xDJDHX28rJiNQf3bkxoP9AvOt1IwY=;
        b=Sqb7k81dxyW+A0yErKpUKV+nWpxs4QIadQfQ4S1c3WnhT1yQVsXqCoUaEux9wmBBXC
         sMohpEg9QN8ksz9gYS5623dkpoUZ47DKKDKaz3mrRdo+f4wIQV80rBixn4aosQ/Kvo/Z
         8W6Qcoaj/WgrI2WgQRxLl1jaiCH9lick+tm5B8/0lIcNgpo0PZfdy5jCxmCBrCIg0ZYc
         nyqrE3RcE2bL3EnPrp9hkvejK9l+zINmnzjZczSvKOtT0zde+eskUtNF8JsHWL70pht3
         MkTJ8lUXgqwCEWB9RzMMVFowQSWU+assuIOwO1FFn4y4lGKKB3pFp38Ih3bHZtSavMut
         6kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669287; x=1753274087;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUfmoFDnC/6I49xDJDHX28rJiNQf3bkxoP9AvOt1IwY=;
        b=cyKutbsrsvt4q+HFGr8o9RhwzOCiwsAxSpQZZIB2tQoBLpexSnEQP9SopN4PrFaysw
         4qXdUmwpS3/vk9GBYYCzARHx2ANaBIzjbouSdJFAMBw26tzGSOUFSz3zut9D3aE/rC3w
         9koKFBe4mmAiZtllLvbHgeSFKK/D/dGRAGXWlziSBLbrd6PXZsaSVJkOj3L07Myj+zMX
         EnC/Ui17I0bBeGRN+DfJX7Z0y6YFN0l6wm5NLbvM8ZnRcCAkFEKceLZXeUksg4WJNu7I
         3+3j9ylEMzBSMX+sll2unMxmCSuuIdXAXsZq5cp671uwzbrsIbzAlAhofjiUI/CHDqd0
         fRrA==
X-Gm-Message-State: AOJu0Yz1Z/9US1GLyexPf6rCBZAkU+SBHUYOCLfNAmtPsaLzqSOtCjRz
	2Zylm5YWoDTFJLIq2wyREjX9atAgLh9ui+hR24+P0Kj8wtjwnpIc1rOQgFlSQMW58ThLCm/Qs6x
	R13Wp
X-Gm-Gg: ASbGncvllBvLHahjCXmw+BI9tzK+59NxdF2g5i3kDScndZUKngnMA59tYsR8KtXBuYW
	KDY+/JbrdPOwhCHK/smbqO6l4M0oyREKPmE9IDe35UJtefAqXXGV+InXcLhwXVnq1Knw74jrymS
	k/HC5mc1WGKIx0A8CW1L1velYv2xUf3glaZOMYa+FcmFAjACPQ/RMCM446p64XTSwkTfr7/ZnPU
	JXWUSlaC5fW7etZplXmyOfbi8n3Jqc7HoaJYVNRrIYDlr9KM0k7VuxLh4W0fA0lMi4n9qkUCc0q
	eoMslxUdL3sOGbzVnGEb2x8HTo/ya2QWozNWE4m80Uwp3jH564iwGVED243B9DSrkOk2U2FtRqn
	Fhd98Y1HbqwK/YW3qfG2nGGY4
X-Google-Smtp-Source: AGHT+IHmiK8NlQ7hrPDSXsXhX9SRRO/t/y1P8R5puqICkyZ0sVRgsgaeay2RCwL67vsj24N2Xxfh0A==
X-Received: by 2002:a05:6602:a005:b0:876:4204:b63d with SMTP id ca18e2360f4ac-879af1159f4mr767801039f.8.1752669287254;
        Wed, 16 Jul 2025 05:34:47 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556b14173sm2928493173.130.2025.07.16.05.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:34:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Changhui Zhong <czhong@redhat.com>
In-Reply-To: <20250716114808.3159657-1-ming.lei@redhat.com>
References: <20250716114808.3159657-1-ming.lei@redhat.com>
Subject: Re: [PATCH] loop: use kiocb helpers to fix lockdep warning
Message-Id: <175266928564.266324.4332211753512549130.b4-ty@kernel.dk>
Date: Wed, 16 Jul 2025 06:34:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 16 Jul 2025 19:48:08 +0800, Ming Lei wrote:
> The lockdep tool can report a circular lock dependency warning in the loop
> driver's AIO read/write path:
> 
> ```
> [ 6540.587728] kworker/u96:5/72779 is trying to acquire lock:
> [ 6540.593856] ff110001b5968440 (sb_writers#9){.+.+}-{0:0}, at: loop_process_work+0x11a/0xf70 [loop]
> [ 6540.603786]
> [ 6540.603786] but task is already holding lock:
> [ 6540.610291] ff110001b5968440 (sb_writers#9){.+.+}-{0:0}, at: loop_process_work+0x11a/0xf70 [loop]
> [ 6540.620210]
> [ 6540.620210] other info that might help us debug this:
> [ 6540.627499]  Possible unsafe locking scenario:
> [ 6540.627499]
> [ 6540.634110]        CPU0
> [ 6540.636841]        ----
> [ 6540.639574]   lock(sb_writers#9);
> [ 6540.643281]   lock(sb_writers#9);
> [ 6540.646988]
> [ 6540.646988]  *** DEADLOCK ***
> ```
> 
> [...]

Applied, thanks!

[1/1] loop: use kiocb helpers to fix lockdep warning
      commit: c4706c5058a7bd7d7c20f3b24a8f523ecad44e83

Best regards,
-- 
Jens Axboe



