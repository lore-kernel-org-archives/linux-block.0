Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970CD157480
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766244800; cv=none; b=n7wrU6U0Ui2gynGYgyPxDfs468hAhvYcb7Ow20IvuezABW46MLWHDTpZZ2UXGVzDckQX4x14ArPbLGXZA3K0QIVrgp+78+CWOciGa5Gy/OVCi5cy1LTs5pz4s85hgBRCF+1y/kk8tHNCiZR7wBC0nkeDzqFKclFPcND6vz6gvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766244800; c=relaxed/simple;
	bh=DtJmE/Xj4Eh5hXwOOjUGRK4kKHb/8vxbMAUwruW12xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMTc9TuUHwigLlBU8+qI4Xlllk12qsRpl3iogr8cacvndyMzX8IqqoDDtFju65eEhnky3H/pzFNhI/o2AUTqcTAmoAIJQ5MrjqK1gpY8MsQukQDfO0LKUtucVtHXxz6AI+o740PfT5H+eYLkZQgiQsIcEMtyEy6mMMEijh1bAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOGkTRjO; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOGkTRjO"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37b99da107cso27241061fa.1
        for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 07:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766244796; x=1766849596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl/cdRp1y81VP+t4Wtk4iRNQzSmALctEG5vDaqc5Y0Y=;
        b=VOGkTRjOvbtPExh3Xr0n4n9WZq1NlQaG97SJGmtFCQd78ksvRZA4wNYum2uC+KapME
         myRDZHS0BYFP927FlbJ7UIklUS1RdbzPYfV2nQKcIgVhKdLxLI6H7qt1fDi+NCP0+uI8
         kCcsGjYBZi8kQN0jmBLQizbJUlTIjep3ofLW9YKbJoU/VMUzdFzhscaV4ZuNlCB0W+/E
         U+mxsomLLNm41pBoLG44E3FPb2zzwlBxLi2+p7ipF2XAwSmVgWg31nnZf1r0f+Puje2R
         j6LcOY+MeX8OzbLhcory2GXKRqXz7BU7D2kVUQml0Z2Crs2avMnK6YHNQ17uWHQNxlvH
         6Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766244796; x=1766849596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl/cdRp1y81VP+t4Wtk4iRNQzSmALctEG5vDaqc5Y0Y=;
        b=fgWvcm4kLGfLlT5N4hfJvJW2Gtna1ul6JwQT7MpKRjA7BUvsKgsJj7zSqbaKItsBQ0
         sLPlaXAKsFOFHXe3z2tMlChHBAdc3IrppZddR7VXmW7+t8kdOpRfA/wuHrEQnpiZlS+U
         /C2a05Lb0WbkB8j8KrfeOUCRAFn+cX2GnVB1Tz7dWJ7GB+UpwYaAyoZp5gx0Yw9LS45E
         ScfzEMNbW5Sx/SqTUtWgk+rQhl0auZLUdUTN5kWzvYrri0VaT97LOfwU9JfBQ6hlMOxu
         wG9znBGbfAKCwIrbxbOnDbeVEeE5gA9FPRMLxc75r0Mu2zqqNSiy20DWiDEOMU6Wib1+
         18Ww==
X-Gm-Message-State: AOJu0YwFMw8uvCsOHZ2En2yck+mXBROunCYTRT4jXRq2fWzqp7xGCCh5
	ubOnU6Mjkpokwnbe0OsBwsJRYdM98NIJJOVqNdZ5Gb7P4wyYNLS9mV37hqSTlA==
X-Gm-Gg: AY/fxX5wFgTeQlmdXI9nkWYUpGwHOLfaadm8I1Vk0IDID7h1SZgUu+4EjlsH1ZIATN7
	4ftgLXxXTFt/FCo1KCaLhusnLyU+b6kh5d3O6sKtObrOk4uLjPLcGBeJhDGJ6aBo95NAM07VLO3
	IaoR/zqV6XFLS1NOPJWwyiINX7YpCjIWY3Mmo+r9uSnSR1/90EWIw7JK9jUc7Et/3WOq3yE9QVe
	s0ahmTkGc0BZkj79ASqRm5zB3Ckt29j0WdSw066OxCHEchgtNcW8xC3QNZuLMTo8rx9PNuLgy8h
	uf6HQPf3BuflEjLGbNj0fMwALpCu3zFZ/jPRe7YIfnvAgbnq2hYNrB5KZfiJenEL/QQt1tpl2UP
	ppPFrf0PLqwT3A1g24yf+q2UmgitJmxmwrlRHZFlBXxziJhs8vCMOedelTUM0nmbw/w25Zn5RxO
	/YFpAioZv9Q8/wkaSr66eCQldWW0TTloiOpw/HfBb0iKKZ
X-Google-Smtp-Source: AGHT+IGFck0sC2mUDq+uqV8Z0McbE43dobf0OggKIZLizcF1/IAoZaEAHSkSyiiw7ex1nDcvnqe+EA==
X-Received: by 2002:a2e:a587:0:b0:37f:c5ca:b737 with SMTP id 38308e7fff4ca-3812156a054mr19327601fa.1.1766244796232;
        Sat, 20 Dec 2025 07:33:16 -0800 (PST)
Received: from mismas.lan ([176.62.179.109])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812262b36dsm13003961fa.30.2025.12.20.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 07:33:15 -0800 (PST)
From: Vitaliy Filippov <vitalifster@gmail.com>
To: linux-block@vger.kernel.org
Cc: Vitaliy Filippov <vitalifster@gmail.com>
Subject: [PATCH] Do not require atomic writes to be aligned on length boundary.
Date: Sat, 20 Dec 2025 18:33:07 +0300
Message-ID: <20251220153307.56994-1-vitalifster@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It directly violates NVMe specification where alignment is only required
when atomic write boundary is set.

Signed-off-by: Vitaliy Filippov <vitalifster@gmail.com>
---
 fs/read_write.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..babd95e7096e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1810,9 +1810,6 @@ int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 	if (!is_power_of_2(len))
 		return -EINVAL;
 
-	if (!IS_ALIGNED(iocb->ki_pos, len))
-		return -EINVAL;
-
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return -EOPNOTSUPP;
 
-- 
2.51.0

