Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9F14A4E4
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157040; cv=none; b=eAT+lsOHxZVKCIjzjoPgmlED4RqduzJC/EVLBumqL776/RPssXFAks1nHD6RmBBJ0thzQvVEvVMPsvLsAFxvJLCYzPw2PhcpP31Y8KWthH6z9wBy+WqhiR0QigU3S6woVyCZguUxi8THogPLexFaoVtfqlq3AJPK706iYL07oDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157040; c=relaxed/simple;
	bh=4pccwfKIwAZjvve757Kufq4O1RjmSc4bUlW7zMIDJEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iezAljhmhVPtVCSTdK9ITokADfORn+A2E44AP/pFvVkVTBYVpK2663emDLwMg5z19b333lzcpmfjS2Hehd3d9GugcU6Zj43znesblp/DkpJm+C36IzcmS2zPHjPkdFOFVRdizb80JwI2CaRCI58rINPdMR4eI3K+lj6JFGlDRp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PUghbqQw; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PUghbqQw"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3688f1b7848so4003975ab.0
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2024 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712157037; x=1712761837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkA0PZLPzKfTvRPY5HH9LVnUdbwNe5ON1P8PZx76WKk=;
        b=PUghbqQwF2U8EcySg9S2eQAsIizslb01WIXx/T5wQcTfba5VoUjmR75/qUwk9ZW59a
         C1cM1FSG6bT3Wq6rwa4IO4PoTYdrDMa4ufoCBFsUHurEjATeU70lAi6pkljW4SeV/JrY
         uYhGDeFruRiTZuz4E5GFwc/mN1g0pr12FdAdk928v3qCFTP75/h1n6rkMP6s0xR77AxD
         yrHanVBN4/lIq2qbBY9swINQkdJy0D+oEbb+53DG1qZThxWSrkgQv55f1D78kR3WOjzi
         57DPW69t+bj9j5sC7JczCG0E0poFhWdVaBfh0ZR0OfXZxdq+XztaYHBMEENiULGxoz/n
         pL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712157037; x=1712761837;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkA0PZLPzKfTvRPY5HH9LVnUdbwNe5ON1P8PZx76WKk=;
        b=EFu2yhfhPpDeERiMsn1XCPGg8Sg9JAlOh5ZR0MZOaTNxPsoVWCMXaFosffpmy8mjTk
         x98vI/ySyb9Kn7/FZH0+fkG8BRb7t40HwHOReeaj57kymOTmFm7xPpanF+UIgSkPE3/5
         J0ARfqZfzutqZHMrXFg8chc4HBxRrBXKRfAxQfiVzl5vGQD+nOnJHPNgmSs8q121n0M2
         1RJMHF3JPiNzrIzq67o6+3gFVvFNaOMMIjJqgl07s8YAXy3k9s3P7CDUhO3fHAFnqgRk
         Jb1W9ivXRbRjAJz4HBumXoGN8t7bB3w1V7Q94Ba9ONrQ7j0EOGQ2J2J4XZc32LIihoBa
         aoGA==
X-Gm-Message-State: AOJu0YwsxYxJ+D3IUnH7rBF5hm4bgSk0x8LvR1bpID7CmXkUIfyiGWq+
	H+MVyRkFw7/ixchdoYJpxO02x7g7TC/mvFuwfWvRyxT1Gu4ixHZO4n0re2Q87QPWyFhwV6PilCn
	B
X-Google-Smtp-Source: AGHT+IH4HonClHHy5ws59iRqY7pJVqOUGArkkK1AxrU+TJ0HNTbNB+e7NlW/K96jAy70km8K4SQR1g==
X-Received: by 2002:a5e:9914:0:b0:7d3:433a:d33d with SMTP id t20-20020a5e9914000000b007d3433ad33dmr3190632ioj.2.1712157037219;
        Wed, 03 Apr 2024 08:10:37 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id fw3-20020a0566381d8300b0047bf7a10f23sm3876481jab.170.2024.04.03.08.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:10:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Dennis Zhou <dennis@kernel.org>, 
 Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240325035955.50019-1-wangkefeng.wang@huawei.com>
References: <20240325035955.50019-1-wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] blk-cgroup: use group allocation/free of per-cpu
 counters API
Message-Id: <171215703577.1626129.13267736499147414645.b4-ty@kernel.dk>
Date: Wed, 03 Apr 2024 09:10:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 25 Mar 2024 11:59:55 +0800, Kefeng Wang wrote:
> Use group allocation/free of per-cpu counters api to accelerate
> blkg_rwstat_init/exit() and simplify code.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: use group allocation/free of per-cpu counters API
      commit: 688c8b9208356eb5c3fa8047f3e35666f3049a4d

Best regards,
-- 
Jens Axboe



