Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABC1EA7C4
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736866; cv=none; b=sxhJr+6m9DukGh+gu4ya4ChUnh9OxN2n7rUfQis/qVK30m7O4unRkRxIU45v2KY2TdmL3vzLHXt4XaNylCzbeytWPDk+62U1QRhJ/CsEoRm3kperMtN/6HehWZ3YcMzyXTiw/utLEjTWG0ZDpsfKddpVGRh2CSn7saobicBeLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736866; c=relaxed/simple;
	bh=BnVTI5IWmkYb64d8ClKjXQD5FfTg+jbU2ZRDVVyZcTY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I9JokhbyrHGpEA1Nz0x4tOgGliGd6DBtzZ7Mye/z35zZMq17RJb8Bm1IuhTCOCUjf6MX1qJW0d4LGtGycPWVpdvfwb0DWgQvl+rF2KDXo690mwBoA9QjUwvQr/rug9x71EPrlUd1kQZNCbDaDE+Ug43TTEi8hQIEm3oG//MBPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjgsNGLS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjgsNGLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752736858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ACVwW5MpE8yc20tQvFWdOafzGoHO3/7OpxtRWjnsE6s=;
	b=HjgsNGLSTDM+Iqfa6nGcTzMQM/WjlN9YViKDisNk9ftU6ZCG8TJY/bpxatRJmqpmWuOknd
	p4at94IjTSNJY4FJfuGS0xBBEIapxpv5HwIk5yo3Ifl6hzCFF3GxLRjGNax5qnc5YJtC05
	wwruqn9/iiNk+/4C155gfCO/007zL6M=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-hTFkS83IO-OldBHqsR42QQ-1; Thu, 17 Jul 2025 03:20:51 -0400
X-MC-Unique: hTFkS83IO-OldBHqsR42QQ-1
X-Mimecast-MFC-AGG-ID: hTFkS83IO-OldBHqsR42QQ_1752736845
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32b93fa2e51so2934901fa.3
        for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 00:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752736845; x=1753341645;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACVwW5MpE8yc20tQvFWdOafzGoHO3/7OpxtRWjnsE6s=;
        b=e6TZ9ZVcX4Ivey4TSFCPrvZTQtPv9CoRrFhVbsyxluHAyEV6BBVdLocubfMV7dBuBq
         9mIDyFEVGJdjwLwpw7c8tgUOCYQRh01aiMKgOOezgvzqcbGfKK/oMW3oY5GUBRyWqETv
         qZ6+PGidrsZQhHuGKNOhcUlx8Ih2M9sniFRE06AE4s9BkzMXcdr4hfxIFPsgOJ4ySMXm
         S/gmJDYFsby9Jv0edcjJQ5Ijca5gdqXdz8eedKnvh014YcbzJdNkMIFseUieUX7TBTRO
         YK7HMuP8yutI5z3U+wosCY6h3RS9iUCRekMq276AzNd7DQf2Pxrrs61i1fbHMrv8wj42
         iXtA==
X-Forwarded-Encrypted: i=1; AJvYcCU/XTYVj/bdvk+cyYczyZGbPyHYs7o1p2l5PcNkOuy28WN182257gUVlr+jGgL1HHSlf/XLrvZwcvumyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZWJPzAWD2ZmLnNFMDtARUqsZAnxtOX9S7oabnsBagaNSVg0n
	7hoTBjXnxgB9Am4ywZK71BxTIIxgYYyOPwQj8tEEFP/oelf37Ukk7IlIcYf+6FcYxgbqMB7gj1a
	fgpRxlPQWd4qZIfD5VQJ/jux/2a706MZesIctVNzegr/pg939tBroOKAY0Bwoq0cMAx7UoSJQIR
	MJnO3K21MMYMuwcQyuI/eIl+uShCm1JMmh+mlWgrM=
X-Gm-Gg: ASbGnct/2P1VhA50RSyjPuMSreq4KxJOE5k1knD6k/QCvsnq98E8j4Os0Y0u2pt1U89
	/DwzFHrwhlC14ygk56D246vIfScmiaY8IQeOpGV0M2azzaoFuC2k6Doyh7Lis6i/Y+Jlms093ux
	4AdPZX702O0f4z2t9unBMKdA==
X-Received: by 2002:a05:651c:2117:b0:330:8c4a:4749 with SMTP id 38308e7fff4ca-3308f6519damr16011051fa.37.1752736845074;
        Thu, 17 Jul 2025 00:20:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkOedYfw5ltLulMAyHRR5GkHQGxPhN0D96vxoP/IOAWeaICtbjmcS/DkLzrjIOgiXDZYXPjTgc/7I4Ynl2wIA=
X-Received: by 2002:a05:651c:2117:b0:330:8c4a:4749 with SMTP id
 38308e7fff4ca-3308f6519damr16010941fa.37.1752736844605; Thu, 17 Jul 2025
 00:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 17 Jul 2025 15:20:32 +0800
X-Gm-Features: Ac12FXyO1Bie3QxqedyWvPdhKWVg0eEmhrZRapS6HemxeqIZocNvF91Sgk9owqI
Message-ID: <CAHj4cs9wqRvxxTVMYxPcaCQoedeRNn6CHJ_K5GsqS6YKMHeXiA@mail.gmail.com>
Subject: [bug report] blktests md/001 failed with "buffer overflow detected"
To: linux-raid@vger.kernel.org
Cc: Xiao Ni <xni@redhat.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi
I reproduced this failure on the latest linux-block/for-next, please
help check it and let me know if you need any infor/test, thanks.

Environment:
mdadm-4.3-7.fc43.x86_64
linux-block/for-next: 522390782310 (HEAD -> for-next, origin/for-next)
Merge branch 'for-6.17/io_uring' into for-next

Reproducer steps
# ./check md/001
md/001 (Raid with bitmap on tcp nvmet with opt-io-size over bitmap
size) [failed]
    runtime  3.511s  ...  5.924s
    --- tests/md/001.out 2025-07-15 06:27:41.496610277 -0400
    +++ /root/blktests/results/nodev/md/001.out.bad 2025-07-17
03:10:50.718820367 -0400
    @@ -1,3 +1,9 @@
     Running md/001
    ++ mdadm --quiet --create /dev/md/blktests_md --level=1
--bitmap=internal --bitmap-chunk=1024K --assume-clean --run
--raid-devices=2 /dev/nvme0n1 missing
    +*** buffer overflow detected ***: terminated
    +tests/md/001: line 69:  1835 Aborted                 (core
dumped) mdadm --quiet --create /dev/md/blktests_md --level=1
--bitmap=internal --bitmap-chunk=1024K --assume-clean --run
--raid-devices=2 /dev/"${ns}" missing
    ++ mdadm --quiet --stop /dev/md/blktests_md
    +mdadm: error opening /dev/md/blktests_md: No such file or directory
    ++ set +x
    ...
    (Run 'diff -u tests/md/001.out
/root/blktests/results/nodev/md/001.out.bad' to see the entire diff)

-- 
Best Regards,
  Yi Zhang

