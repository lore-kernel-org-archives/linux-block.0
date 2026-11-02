Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793600082;
	b=bb3htY5N646LxaP/EDtTxKlnqM6h6nw+0g3AzhTpImkqEW0JMJH1FitpiKIYF83E3/wI
	 zoKSuiLMwi2ycwtre+khKEd9lX8nnKalVFpDT/aHPd04I9H8yBufm5x86Kw9+kv63KfZu
	 BeD9aUh2waNRu5buMfl++b2lRET8aHcT94fSl3Bnd59NvHp+EXXBBSCuIWwBK1KYsbR3j
	 //yfohEc7ERJXdukhdnAhpM2LXyj0cS8/1HxcMzc7ICAXxp3GCsQFK2u3VmozByoJLinz
	 V33mssh/5Xptqu7Hy6UUK3kSBHEzj6ytIRkSooP3Uq+F87XNh7l69fTlQWpTjjNGZmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=LTUJ0JEm67/O1NvvxTlwEEPb8oRFqpA1lbxsVjiMSpc=;
	b=Z3Z2yUYRhznzrwxTDNXs13U9NIwiVPD8K3s2V6A2GmjuwcAxjf3BCq4R4J8R1+rZcL9Z
	 r0ozf92m+FWObpnmBTUc4V4iTOWWaCdo2ldGWKAPqnmUO4s9nRZpSJ5P43eWVmPsA/bJl
	 cmRjaKM7e+AS3b1ktS5/+xAQ+E4fPxB9Gx4yrZ67/MbdsxPp7Epq1A4CRdmxxNDhnCfZC
	 5hPzYFI1kvmDia1hK8W6maNUcOT9UDxhBDDnsYIkNhSR9kzrfgbfIA2Qu61W4BuBE6vLm
	 jsgOQhNzrcrVi0BvjdAvvXqpzkK3Sx5jtSJ670CudO4oeey3cQ+M7eHqXCL7YWIZmGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0LiQdi71;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D8606A326
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 06:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E8D8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0LiQdi71
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15ea896ddc8so4522406c88.0
        for <linux-block@vger.kernel.org>; Sun, 01 Nov 2026 22:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793600081; x=1794204881; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LTUJ0JEm67/O1NvvxTlwEEPb8oRFqpA1lbxsVjiMSpc=;
        b=0LiQdi71ry6UnOYAb/AWYDEDHzAl2m/whEmqaRLTdIRqgKCtnkPqIfbQ3P8ZqOj/Ml
         j5VqjNarkoXEp8hh3lq57eHDDtlqd9DDMbCtczdKIY1mvv99Bn/Z3pSSRgC+IhR2DIik
         PvaTiQaEyMyB0deiKydRO9oPn/WFcLkX5icsOXC2nz/IoGiooOyihDso43W/2/5ZeOPy
         MW7lyRmdEokBsA0DngyCehsm2g2ARQzRIJb9BA2Zn1jBGYGzdyRCOF+Ve5N3qQkcTJD9
         mH9gqCAST4gL5m5/URFBQcEVJTy4fPATb2Ey5HAsZ9h0rpkhjdIUo4p44T8/Gxu75lxh
         Yj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600081; x=1794204881;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LTUJ0JEm67/O1NvvxTlwEEPb8oRFqpA1lbxsVjiMSpc=;
        b=llxNkxrdIgFfjjRCZ1/gkv6LO7aLdfaRtpIm4dKojg2aq2tg0dnGpGNwAf+r8K00mh
         o5ePifNTaJsLT9PvJvddUKLoAfmW9MkltlK+LqVT0xnrfljwLb9rwpHAoqGkgSU3cx8k
         VqdTMEN1qAcdT0JsMKDrALWtD85gZqB4ynQaAwgQb9TprKYP/EXh3Ar821Yo+bdVycOW
         P03y5E0AaEXVnz6VzzfzMbFfRgrQIsQih9Zg646s5rR559EUxm301sL9nGiOYt+KykPq
         yfi9uDb6KET5iGqp60YhEwQ9UZg5O6Vr3neEI+CaDkkFL9KS8DJGjiYTsNTDOshS+4D2
         V5Fw==
X-Forwarded-Encrypted: i=1; AKwUvBzKV7p1zf+8gtvU8dEQ7theONoCyEUIvVVJ54NpWwe0HxZvC4sjXpCnKOlm9yBkYztJL4Aqc+0E4jUO9A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6d+menPrAeYH4o08PQ8uQHK7mv5qHe+yCLfwlJ5Ie3FOSXIea
	LsCrZNj+UMiXrwVSLyxYBTNY8JiGQCbcU424ZUPF4OREOuxMqharbOCR
X-Gm-Gg: AYBFou0f8ZPPD90gzb377hG4PwxIza9rRMIb/FiEATeUxXI9KnUWvu/tM8SMQN9sN8F
	aDvSDFJgBpqzLpnfTxPmNLOaKTON78pAS6e4JZ261h+26IfEBKiKu0fY5gYG8iidFeMNiES1c9U
	fq3lX+W2VTlCk+fWRjH3gWMm5ADMXxzM8wDzKPE/gIaNVB0jNXZ+ISaBjrWNYeiSZ3nFOslEXvN
	7buM9UKuyyoiKCj8k55a8UWYn8gQgIThcySoSxpjxnJjU5ZEOuHBBF+IuE62UaIMFrKQ+EuML6w
	4wBCgXUNFOziwc2lijexwKQdM8BBV4ev4FZ77MaSpDmIaZrXctXwJkYRDXPRH2z59XAze0NTReI
	gRxiadCXDpEv7BTQYsgdyLNTiYBt/fqk6ENVzs3KAxRP6L2X1e3lipLjPU6deMftPinjYrPavQw
	tPby/G/0QQvCB3xe3sVd0doy8vt43I2WdAKKXivbGNLAuSW/e0xgLnKlH8X87O9H6X31fYqul8P
	P2YHnbJQCOY1gBjMutPdVGNJtTvg4VhjS/vWLt512zZR8mSADyYUIRuy6x9yb5+Z43UcmlLx6li
	mUIQ0LIDMRlok0allw5IPxrwfQ==
X-Received: by 2002:a05:7022:294:20b0:17d:7b45:f91f with SMTP id a92af1059eb24-1ac5c273f92mr13942725c88.32.1793600081035;
        Sun, 01 Nov 2026 22:14:41 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm30288043c88.14.2026.11.01.22.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:14:40 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH 0/2] nvme: delete controllers with many namespaces faster
Date: Mon, 02 Nov 2026 01:14:35 -0500
Message-Id: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEsq6GoC/x3MMQ6DMAxG4asgz1giGUDiKlUHN/yAB0wVq1ER4
 u5EjN/w3kmOrHAam5MyirruVhHahtIqtoB1qqbYxT6ELvLnt7CVDZyx7QVszuKHJU4QkYBJehm
 o5t+MWf/P+vW+rhvadFaBagAAAA==
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Stuart Hayes <stuart.w.hayes@gmail.com>, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

Deleting an nvme controller removes its namespaces one after another,
about 20 ms each, so disconnecting from a fabrics target with 64
namespaces takes over a second.

Patch 1 removes the namespaces in parallel, as scanning already adds
them. Patch 2 drops the write lock that del_gendisk() takes on the tag
set, which would otherwise serialize the parallel removals again.

Disconnecting from a tcp target on the same host with 64 namespaces
drops from 1201-1308 ms to 115-124 ms. Details are in each patch.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (2):
      nvme: remove namespaces in parallel
      block: set QUEUE_FLAG_NO_ELV_SWITCH under the read lock in del_gendisk()

 block/genhd.c            | 17 +++++------------
 drivers/nvme/host/core.c | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 13 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-bug-nvme-remove-ns-async-ceaaa1eda6a7

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

