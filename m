Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4825F975
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536932; cv=none; b=g/ljazY+ZXTbE0UlTtbcpoTLCKjUfzxfm1MzRyCIbI758VqkwSay3SBqrojnxqh1l3FejnUCxhT27ExUwbV0Q494SR6Kcpd+H+a6z3wtsn+FBemzaiKaOCVvBLodt0Gb7pfyOoHeWUtplZIZejB5D907kY9cUXHhg89dgavqQxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536932; c=relaxed/simple;
	bh=4vxOlGFvgzbPwPEa2qIvHrGnLISiSv0yBiplH5Yp+sM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gb2iC6o0zEC1yZv9rzKn+nraYtDHEk+UImscC0u6kFCH2w9ULPQBS8vxJYNvSJGJcYbY12YMbZp+5tolrX9cu+0hMPk/5xRrI1TYxBuij5IazaxX6/QsNLnwKpNHxBaKs6nBCGaACX9khh2t//eaJ+yvYmYmQnxPqCULBhSpFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0oso2S1g; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0oso2S1g"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-430a4322b12so13875615ab.0
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760536928; x=1761141728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnH07IcS8OWDMvmbNlSiwXd5a1yXIenbHz2+fAqgxlE=;
        b=0oso2S1gfNJM9qSSGWO6f1UoepZx5oTpSj9o09ot+xqfYOVLIzI+7IKgWP/6VdFjlQ
         Qw+dGYL2aZfexYOpFCYy1MOFxj4l/9QKjxi37kzWZAQxnWrQ/pJJ43jX8Aa2Y1uuq8Oh
         HmYRLVLMF39hnqiHso/R6VauE6GrTIEElWgu2RG3DWoyi/pFXbk7B9wkRdQPk4b/zH2M
         906HY4XQGpByt3ckI7wKAmyZ6G8VyPoiTXwXh4A654VojgHyczbFsgL3W+4nautM65ew
         c8pp3tJBG4jTmUSHgMbry1Cu8OMJBAdNT1kFuj5qxXC287xc1jwKt5J9EEYZgRWfSbxe
         2vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760536928; x=1761141728;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnH07IcS8OWDMvmbNlSiwXd5a1yXIenbHz2+fAqgxlE=;
        b=j5MMD1lsMDieKFihvQkV6qGe5QnDCnffpQKeHBGUYvGZAm2IdfPVEOCSpbRsoIKC9B
         uE2+qREe2f/E/N5rcObHZOPJthYB2vOoA87zSAzaDfetYZajSMEYYR9ULIJcFOZSsozR
         Ho62dnTDK3Ho0kCLZP52N/7e536mCtc0aeW38TeaptUL+JgBNobi80J2heOLBXdkv18Z
         U+EcbogSrsb8A3tIrnVfw/buIBFMCvHyR3bbjPF1+FLMidt40u42Kt3eOVe4AL1/sn5q
         eDUk4NnSe4XUEzCRQIwbOVa1jRALVyjV0n08hh+r0q9vGyOdGmFLSW5/O8VHBFyPdGt3
         Yw/Q==
X-Gm-Message-State: AOJu0YyzJC/Iw+o3mGEU7Ya8c0vvj3/9sf1/FLp3SrLuH3sI035Rp1sh
	HCPKRg2pvOxYNIrkUhAeooTwEarn1ZRTFeDU3iNWTQpUamJ5KngdWeS7jWkWCz9fbi0=
X-Gm-Gg: ASbGncvwgH74Q70nwJNMsUFxkfwZUgzPRSqUQlbP/iTlkoh004a4eighjvCUPbg+RNX
	drBgF7vD5pzQUWyFhnbPepOofvd0Uw/ojDLhKsqBydv99vuebKlIKOcA9mvrsNTCJN+gpbalUWD
	s8g+TRvoUoKJi46u1rC0LdhCTDXKDHdKtMwdIWyA+wZ1i/unRCKzyrjDbTPjTojDh3nMV4LjJRn
	x23QUMT5VyvOT31GNV81DJOO7OkFf0rhWTRrTYup6ciQgndP8n82EK0lNUkLnCUHKnybQ3pfBl8
	TsRIkdvnUUDoRBuMY6pjxuwZslpHas5M4C5zXxjwxudEcPR+FjLoGnXlP2/9Fg2sZUfBExQEdae
	AS5B58Ua/6RwYVhxw0dH4ek6L/JBIfbdDx1nHRsY3uIU=
X-Google-Smtp-Source: AGHT+IFnR0YGuTy8ZQQebSiHJYw4iw4tytn+EFk/kS64DWHNB8Z18c4Z6JJHNJe8ECxUuwLg1iXEjg==
X-Received: by 2002:a05:6e02:18cf:b0:430:a432:28cd with SMTP id e9e14a558f8ab-430a4322c27mr77783105ab.32.1760536927720;
        Wed, 15 Oct 2025 07:02:07 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f90386a49sm71031005ab.35.2025.10.15.07.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:02:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai3@huawei.com>
In-Reply-To: <20251015103055.1357105-1-ming.lei@redhat.com>
References: <20251015103055.1357105-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: Remove elevator_lock usage from blkg_conf
 frozen operations
Message-Id: <176053692074.32600.3947055208704784999.b4-ty@kernel.dk>
Date: Wed, 15 Oct 2025 08:02:00 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 15 Oct 2025 18:30:39 +0800, Ming Lei wrote:
> Remove the acquisition and release of q->elevator_lock in the
> blkg_conf_open_bdev_frozen() and blkg_conf_exit_frozen() functions. The
> elevator lock is no longer needed in these code paths since commit
> 78c271344b6f ("block: move wbt_enable_default() out of queue freezing
> from sched ->exit()") which introduces `disk->rqos_state_mutex` for
> protecting wbt state change, and not necessary to abuse elevator_lock
> for this purpose.
> 
> [...]

Applied, thanks!

[1/1] block: Remove elevator_lock usage from blkg_conf frozen operations
      commit: 08823e89e3e269bf4c4a20b4c24a8119920cc7a4

Best regards,
-- 
Jens Axboe



