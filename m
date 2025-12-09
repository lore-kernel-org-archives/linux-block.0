Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811C329E6E
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300895; cv=none; b=p7P5/TWTB3TKaDK6T6wZ9VCk/488h8DsoKzWuv2qxMDFdBjS6iaAaPa5VPkD7E8bR/Dktj2OGy3W80hzqFDRGmqcY5+1IL+bwgxp54SlaA8LRr03ekYbRyE1WkG1pKd+OyjNl6KcMssllZ/SO52lui1W7NQ1MvZpbHu8rDUDiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300895; c=relaxed/simple;
	bh=MCW3vFe/rHCVt1VsjfYj58bBs01I9LZR7YOnzkj4474=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SeSkkWEbHxqwgTQkoqVptBrxiX98Dnmk4pfPBEgy62JNm2lZ7ywmTfY4FklSlJD/D7k/MNDFix5SiLH2AOXahULcD2kaz3RHMUBs14sj9X0TtuYkslLXnn3jQ4xOzDbl+RgoCYx8LC6/vctb3rDJbdT/zo1UFXP72L6eeKGUCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bGovVEd1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bGovVEd1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29812589890so81658295ad.3
        for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 09:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765300891; x=1765905691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAgPi/FoX2rT03UDFaRERjzlWh6wXMi2wuOp2oMH7JM=;
        b=bGovVEd16VyGp9JHCCdFYKk+nMHXZ0CRpyMvGpLihmXnzXQRdEdITPhaDREkY9uQb6
         Wg//4q4ICQ2P2L2r2oJ/C1BsUxnZqpJFhPIcWcshXOCUOgXARYoT2agdleCn0+q+SEdI
         39+q08YN84uVObSNAqEPMK18l6XppIeSjy4DcEwK3GNhM872kSna/fJUlKXmL3mZr1Cr
         CUl1MsrLkou3atgkLNVaA4o2xhRrnank0sQ20Ez42hmoqRYL6JXpgH6w8Udr2GwFqVPt
         NgnGQd3aeYf/5dCCvP7QSuIvgavyT2sVqZPJCEitjDyoA+l1rYXF230iWw3UvlEbm1nH
         s93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765300891; x=1765905691;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAgPi/FoX2rT03UDFaRERjzlWh6wXMi2wuOp2oMH7JM=;
        b=TduKzo9S4XSzM69Mue+5PoCE3hSxrn3FpzZ72QT31vBjlz+JkUUrxFxFZifDkXHTHw
         LyA42kDpD9OZ73WfZrEUZSNa9DC/wZCXXXrvlFp+gCL+NNRenxj3QEcc9hAStgStuYeq
         Nlcf7VKGcOXl5mTbxgmIspZ9J75yuVwAEetvrtrHlvZY9hJ0D0c2b7jbdElfXKRXMW8s
         KsHs0hhAv9bxc+vbBeDUimGAsxyhOqZNxPCoti4UUKVb3LJ2wPfFs/cYePM73VzZKS3r
         Q415iCqgKIK6tgXw6felFxHq+L6cTckoiS44pbRsPEl8x0UgdeVLRrq4CuSWCCwuZ0+A
         ki2w==
X-Gm-Message-State: AOJu0YzenGkZZJiFeSgJBMDnUTDB2vsyiNN1tBO6Kx6mZzaN3hjX4Lsm
	1N8VkmARhfnEHIunxPTc2usKmMs4EwZ3td1r5W7CYaaax2TSEbrB/Hibe3cBJMCSR/Y=
X-Gm-Gg: ASbGncuEv4BNc546qI/+OTpRpSn2wUQk+rt9HwF0UY2fYwY9XUQuYm4PTUmbtvG2gXf
	AVTJ7Hribzq/4K5fbP7qrrYr1trXf8w//ZNlvGiD238m6BdbwdcedWU3FxYugQkQcjptIFkXlOk
	tqv8xqC1CvvMyPbiH+dJC1zols1h9pOeK499WWGZfgm/tcQt+lytnoxJQo/UQBQtwkrOGTF3oHv
	1hW8U74L0mmIxpJEHaGSnP+6G58BhtwllojiUEuOLNAIejMLmXvVjEgEBAP1Ja/EF0Hg2Bv1v+u
	su4eCFGRpSa3iR18LSgQzzwGiTT+IihvXlrvzL9xJuHhYWYGMEPMnBWxT82Hdp6kAJPg1ry9kdj
	27jn7LRU06YHvl7TQynpqtXBCufGWuPhmh7YBlbB/ZDEblxTYYi0FOhXhOMiqCkAADFG8ARm2jV
	pk6cMdQ6XaClx25e3poGPLU+lKDD+nxP4c9BeCTM9+o3K7oA==
X-Google-Smtp-Source: AGHT+IH2N4S4MYogc3UTuDeyAMXMfTllgWv/8hm33I55C+oA9tgQ6BUCnLFJP9uCdnKOSkJ7g8bvLw==
X-Received: by 2002:a05:7022:6199:b0:11e:3e9:3e8a with SMTP id a92af1059eb24-11e03e94439mr11045757c88.49.1765300891300;
        Tue, 09 Dec 2025 09:21:31 -0800 (PST)
Received: from [127.0.0.1] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f283d4733sm994549c88.17.2025.12.09.09.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:21:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251201214145.3183381-1-csander@purestorage.com>
References: <20251201214145.3183381-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: allow non-blocking ctrl cmds in
 IO_URING_F_NONBLOCK issue
Message-Id: <176530089007.83150.7264093177786219301.b4-ty@kernel.dk>
Date: Tue, 09 Dec 2025 10:21:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 01 Dec 2025 14:41:44 -0700, Caleb Sander Mateos wrote:
> Handling most of the ublksrv_ctrl_cmd opcodes require locking a mutex,
> so ublk_ctrl_uring_cmd() bails out with EAGAIN when called with the
> IO_URING_F_NONBLOCK issue flag. However, several opcodes can be handled
> without blocking:
> - UBLK_CMD_GET_QUEUE_AFFINITY
> - UBLK_CMD_GET_DEV_INFO
> - UBLK_CMD_GET_DEV_INFO2
> - UBLK_U_CMD_GET_FEATURES
> 
> [...]

Applied, thanks!

[1/1] ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK issue
      commit: 87213b0d847cd300285b5545598e0548baeb5208

Best regards,
-- 
Jens Axboe



