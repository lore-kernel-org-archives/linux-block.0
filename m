Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099522CBD8
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438419; cv=none; b=F75WkR4gl9nHzsAQRWPVrviAj6UZb8A4CDkN7lSw92gwJySvHUPA/Q823KRnXzx+zN/UGZxbBz+AJ79POFRf7lfcxtVQcqfO7JpKisPwXOA5FBOeN+5eyHNM/C2gGcG9uvguVS8RW7g2yIy76fmn26BkzdxrO4GmvkuqTxV8qTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438419; c=relaxed/simple;
	bh=4bbi7NDy07wMJzw64qGfm2Jbjv847+MXgGQv5hf6eH4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s1LGWRvjJdgAJFrjqZMahvSpb+texmyIHCFVbRr4K9hPqf7tFHWiB6Jwzj+GMoOTWSMj7wOovPH8Z6cE4WATwdKSXt6isI5HgXDOwCXvZ7yK/DIoKMO1y6oylVpyUu7Iadd6YnnRsBuG0qbyNeTCJYl+XjSLia1I/EOGJKzoH3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uLBqstVa; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uLBqstVa"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso7214039f.1
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745438417; x=1746043217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KIIo1bqEG5SvgHN69g3RJUY47BgOVsVAm290Lkm7Hc=;
        b=uLBqstVan6ocfnh/nXT3zrNfcMKc2zR8OcpVK83HEpiep9txyeSt7MHJMoi0KRhHgj
         Gzd5QDjeV+SBC4aUZeKy9nQn2JXu3SocygmQHnot8wIgvxLSOlP7LrGDHL6fBFiG5L8g
         Aa90jtRl3EHlreb+sD6pLh4/mgcIg3PHYpCXgmio5tW9Xa4Sq+9ONMA7Phje1b+AIIKm
         zRczVUQleO2DdUgfaiIcbR3MOihc3wGAY8T9mTfYk1pHXPenRS/nZZWkS+DTr3OhBPhH
         Wtc5etJBaLkLzLgPwp5A4gPARyJizp9vSbn6PbhGoY4YBkmfHtz0wMERNXGCGGi2iYhK
         amig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745438417; x=1746043217;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KIIo1bqEG5SvgHN69g3RJUY47BgOVsVAm290Lkm7Hc=;
        b=wrzkxcVXySiiewdMMep8IVRjecQIDhJJfr/FQvKJ7d1o0iTpgMvpNHJNlC4Jpcg7l7
         1abWCmptzR3+2/UsQBcK0rCAf6FV2ejpV0Ltn1E0gYRAYvCGfzlTL0bNvO0ujVjOmekf
         FLmR9d83vfSwWezZ8pHGr+g5Mp9zVvhb0HNO41rt9eT/IyQluDXDDvppf4EQG5Y89kSG
         U+TxnlFDk/4ECTjDpMutNT1anYA7sX6obLWhm3i8IcEtrhG15JCMXCjhqRFKJRa1CL79
         Dyzd1BCS8CFXH7yYfDleLO7+b1rKFbi0jvD6OI85Kk2PmkN8JRrCVfFSU44q2pG50Gue
         KITg==
X-Gm-Message-State: AOJu0YwRoJrbQ12MhcQwzb8kDvW1L2jtEIXMrZBAb5++dOlI+wNeYQX0
	bcANdbVSnHn6TWhQ5F3wSjTkFgFI5c5uidO6Zr+t7S50G9va8Hkoj/995hYxY2w=
X-Gm-Gg: ASbGnct2r3NfAgLz1l+SzNtmf7T4A5SXl9NQFjPrjBV+CRtxKPoQsr7SnW4wdwrGnly
	o3eFGyqPOQQrRjhvh3wDE8l5wy0vQgPgvfiyE4cOhf6PmnGfkWojnasTyv773WQ/MyK/IOTev9e
	w8UIrIzrxAMViPCndvSdmiZq/zvb3r/+WYnwUPAdx7IP3ALo4t6LE4ZQOIsURshrlduOVQack0U
	epkcE7PiXpPxbeXm9JHNcoBp/aDv0xTzS5GHOV2URwr3qEJOx4PmqIEgVDQnWzLunAz2HOGMxJ9
	giUC/pMXdGOmWC2ScOV8cNZXIVDGz2QUGrxoYoYyxw==
X-Google-Smtp-Source: AGHT+IF+WbABm2eh4a1u03UF9HXXMuRB+RXlNNiix90Qo818dM8h3AVHlLwzvjtG8Qm98lqCR4uyEg==
X-Received: by 2002:a05:6602:485:b0:85b:476e:ede2 with SMTP id ca18e2360f4ac-8644fa6e62fmr30229539f.13.1745438416711;
        Wed, 23 Apr 2025 13:00:16 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a37cbb91sm2953925173.18.2025.04.23.13.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:00:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20250421235947.715272-1-ming.lei@redhat.com>
References: <20250421235947.715272-1-ming.lei@redhat.com>
Subject: Re: [PATCH 6.15 0/2] selftests: ublk: two fixes
Message-Id: <174543841586.540172.7321390733661548928.b4-ty@kernel.dk>
Date: Wed, 23 Apr 2025 14:00:15 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 22 Apr 2025 07:59:40 +0800, Ming Lei wrote:
> The 1st patch fixes recover test & ublk utility, and the 2nd patch removes
> one useless variable from 'struct dev_ctx', both are introduced recently.
> 
> Thanks,
> 
> Ming Lei (2):
>   selftests: ublk: fix recover test
>   selftests: ublk: remove useless 'delay_us' from 'struct dev_ctx'
> 
> [...]

Applied, thanks!

[1/2] selftests: ublk: fix recover test
      commit: 5533bc70aedc7c9872841ac8649344f8cbc6bc4c
[2/2] selftests: ublk: remove useless 'delay_us' from 'struct dev_ctx'
      commit: 8f503637898313c048bf21e386e09be90e30cc31

Best regards,
-- 
Jens Axboe



