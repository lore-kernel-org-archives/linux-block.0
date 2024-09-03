Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9A1AACA
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378842; cv=none; b=VhXP3g1JMSr2Zy3S/9kJnUFEQR+CBjhvP+ZvPGIs7sCV3wRPksxfFvSJkwWjITjSvT+dyJ/PGU0YR2wORf2C8Wjvz1cVCVH3JD94+jYWfvjrtgw7B77qnD9zM6Dg7VxsyHX3PXTlmuiR4lrAlVse0ixcbA3cXptBubrM0W4ZIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378842; c=relaxed/simple;
	bh=xXZgcYaTlUdbAaSip8H2m78mAT2+F/b9oJmzJ3y9juk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GP/N3Kl1//XO+AL0lwbb76uI9BdyKDgjPrLQx/Y4WlFid0jk09ZkKAPLoNcQRrImw6pRW/j/Qvu41twcQ96I5epncLkKOQPHpYbcv86SC5vQuB1lwRbA1YlbMCVVeetHpHPIK6lzwkvNGzCCwIYq1m/ASFFr4/1d6u+OqBJ47p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yTMCAZfP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yTMCAZfP"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3289609a12.2
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725378839; x=1725983639; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knMRs2X2wxIU+51PWJvKuJzOA3ogy5J9ExYIsIXe4Gk=;
        b=yTMCAZfPYbBMJyDUJZcQORDmiJfl5SmZJAb//y7b7/kBPF5CaeyLnVHSoHbjN5YsuP
         UKrB7uQ+gt75eiUnLD8yaPu/f2h+slDQUicazH1+1wteE+g32MIc6V8IhDrCggO0sso9
         Z5uEoMTsbla1Z3Wb+6ZYsSNyh2iV1U2Hg0cNpuNeVaR7SVJSXjimfkXUqEBYMyEyg8mJ
         vNqZvgcMGAdScRvXnMdiPmdW6NRZyqR8WALpQ+qyaEDBqNJuCcc24vtuobhkptrJ+Y7k
         vplpibj0/EIDk5JAHDcoPm+XPvYcq9f/7WPAmI5GVXMh7E7sQNCNRYCRY5vvYikTYGEk
         MWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378839; x=1725983639;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=knMRs2X2wxIU+51PWJvKuJzOA3ogy5J9ExYIsIXe4Gk=;
        b=w/PAbO5FLczuxhGynsIN7u0cvVZ2JRYRaJLaUlLWWlLQx6hdYQ/Eq21iZmClgCrlV4
         hsyvGPiCAvCspMlm+fr+sZl+Yiq7zKByBUzI4kOyCImls0Yvxy9bbSJ21A6X7lkdKbSR
         jtUEx4TjgTrHmVvLXZ71w1MMTIchXNRGxRLx2/sSySOffBr5r3W7ZhyfN9w5joiAQeNN
         S/XI3f8p6gBkx7eI4rJIj/qsuxWcXHuZOuXdhAwCzkJ5IkwMsCCzQ8G3/1HpjfvzEp+a
         v43MGG5nWGTQBZavXgapXv1kN5YQP+eu12BD9559If/HQaZOHXlQOL1ZYI8P9358PN/W
         OX0g==
X-Gm-Message-State: AOJu0YyLgoLO8OZ/WuBUMWMWnNS5EQ+NQilnTSZhu+xTHJppjfe0ocTw
	hBYx4hB5tUd3W26x45HX9diKmUuYHaGFajvlUADz56HW/wXdRJ3/qig7DnGefBFbc1Bi+h37c53
	C
X-Google-Smtp-Source: AGHT+IHxV4hWa1J2rld1YEyejuLvHiRSTnUcf2goenSQ7goBD0WWsUTmCQquxoLuRvE7aXVE7XszsQ==
X-Received: by 2002:a17:902:c947:b0:1f9:f906:9088 with SMTP id d9443c01a7336-2054bcde069mr111126705ad.22.1725378839502;
        Tue, 03 Sep 2024 08:53:59 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea39368sm155805ad.152.2024.09.03.08.53.58
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 08:53:59 -0700 (PDT)
Message-ID: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
Date: Tue, 3 Sep 2024 09:53:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] MAINTAINERS: move the BFQ io scheduler to orphan state
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Nobody is maintaining this code, and it just falls under the umbrella
of block layer code. But at least mark it as such, in case anyone wants
to care more deeply about it and assume the responsibility of doing so.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..4a857a125d6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3781,10 +3781,8 @@ F:	Documentation/filesystems/befs.rst
 F:	fs/befs/
 
 BFQ I/O SCHEDULER
-M:	Paolo Valente <paolo.valente@unimore.it>
-M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/block/bfq-iosched.rst
 F:	block/bfq-*
 
-- 
Jens Axboe

