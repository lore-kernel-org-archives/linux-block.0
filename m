Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04751B3924
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731673200; cv=none; b=Wr0oQFv6lahC2l5kPArUAnJn58lCisSl8gDZrgxMNO21epKJdt9pTuNYmSAauFywTvsewfg/TCATAWOlzs72+Pe+raj4Cf/6rUc1r3OjUEW7JZC1Dt6sa+FEk4CQqIpuLt8dP8ceUfSwin/Q8oNFb2sIaRt64J6EKyfL+l16kn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731673200; c=relaxed/simple;
	bh=uN2T0hKnqxB4NWs/1gfOc+22eYGA6JVtajykVUMCbdg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZP560aMLhvc0mFi0pCTpZ8oHVKhvTP+5mZEFfGtZqoDmmoVSkZKd7XDWqWiv5arPSJD6Cfp0rvyfe9e38Eytmm1KGvIjeT60fRWXuYe61pgswq99VJYeuRuKCAmPRWsZeGU9iKDTrjgGF1bJEbbtrSwEoWAaDDhQ9QNOSIzc01E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tEGYwmg4; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEGYwmg4"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d4a333a87so818004e0c.1
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 04:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731673198; x=1732277998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BrmgfHiQVdWt3bBrDk5codO30Y6e5vUnxjycTHd1oVY=;
        b=tEGYwmg4UHx3ee7x6NnAzdwbzGfryFf3nvlZHnmN4lHWivtpsvFlI32fckJaDZ6nq3
         zV8C1PFrBIj6sR93oER3ZXQ4plNwA0sHY+Fc2zpa5IGDIFvZdwpm0ED5tp2rwuY97XdM
         xEsG17zUlmZmc8uMMGjYn0GrkhVZURsT33MYA8iRhGlMkVv3FU1wx2nETL8gkGJcH0cB
         lFZC/0F2JZqmMng3dJQppN1Xc1e0d0n5LCRqEMxRl88kSz+tTkVrlE4ugxpyOZnGYs3N
         sVuknhbgacpMKzgVGDFJ3WRnkIZ9glN5DC+TivDfgGuMyEAv5P2PXfY7cQvPaGxAsXUB
         yFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731673198; x=1732277998;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BrmgfHiQVdWt3bBrDk5codO30Y6e5vUnxjycTHd1oVY=;
        b=F6aRpMAU19tSZeB1g72EDTdbNzFri+ANPkaPEVVHDyJ+ytJVJ2tBd7YbeTfpjC7zlF
         MdFzIm9HddBEmk8JFHr+/F2iJMzvZDp04EzuyQRwym/1m19KOHZYqg2uT4LmprVN4rPg
         4JyYP6J9X8+5P/Dp+t4T0PyOqiDzES8ZyxdI3qYEogjRl81DQirRJvOlfNzI1LiWLmWG
         sSPz9dzqgACFaBa3LlnFutJ9RidhG4BekQmmBz0JWJKcxAl593rs3ffgPSV96VLe8iWP
         r/YHwEYDCj9ljcRqPflgiE/uzZJG10QGjx4DxgtMXvFVEgztP1gbPy9bErAf1C6eT/dO
         V8ug==
X-Forwarded-Encrypted: i=1; AJvYcCX9TUeI45xr5PcaaIJopqnnrAOZrrEMCb+56yDGX7Tot2JLZpOMoL37BULkCq8XnGqX5n6cajTlDTx6cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQqCMZCuBF5auRPYP+XP/JcFts1kZNZGQRAu9pAVJAn6edqSi
	x6Vi7MRjMzIQxYN6a6TQnZ2TgnKTxfH76H6JAYoQ0zTwZoV1ubFCEaV9HTASeRnSZXVqvkpSUPQ
	5YelJnes+MTqKpgqcWC04wxyU/aNr0V3pqfvBdA==
X-Google-Smtp-Source: AGHT+IHDI7wr6k8bNzIN8dP+INAqSB/KifXxi0/sCOrtTa5mU7qUxRv4jWPQh+5k7/tidliCeLz9YCf87oIZixyf+pI=
X-Received: by 2002:a05:6122:3c4d:b0:4f5:199b:2a61 with SMTP id
 71dfb90a1353d-51477f99aa8mr2714614e0c.9.1731673197759; Fri, 15 Nov 2024
 04:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 15 Nov 2024 17:49:45 +0530
Message-ID: <CA+G9fYtPQ=L8g5i=3vzBOW4dPSPYviKGR0xP-gR=2Ta_FZFBPQ@mail.gmail.com>
Subject: Tinyconfig: include/linux/blkdev.h:1692:17: error: field has
 incomplete type 'struct rq_list'
To: open list <linux-kernel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"

The tinyconfig builds failed with clang-19 and gcc-13 on the Linux
next-20241114 tag
for the listed architectures,
 - arm
 - arm64
 - i386
 - powerpc
 - riscv
 - s390
 - x86_64

First seen on Linux next-20241114 tag.
  Good: next-20241113
  Bad:  next-20241114

build:
  * gcc-13-tinyconfig
  * clang-19-tinyconfig
  * clang-nightly-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
In file included from init/main.c:85:
include/linux/blkdev.h:1692:17: error: field has incomplete type
'struct rq_list'
 1692 |         struct rq_list req_list;
      |                        ^
include/linux/blkdev.h:1692:9: note: forward declaration of 'struct rq_list'
 1692 |         struct rq_list req_list;
      |                ^
1 error generated.
make[4]: *** [scripts/Makefile.build:229: init/main.o] Error 1
In file included from kernel/sched/core.c:41:
include/linux/blkdev.h:1692:17: error: field has incomplete type
'struct rq_list'
 1692 |         struct rq_list req_list;
      |                        ^
include/linux/blkdev.h:1692:9: note: forward declaration of 'struct rq_list'
 1692 |         struct rq_list req_list;
      |                ^
1 error generated.
make[5]: *** [scripts/Makefile.build:229: kernel/sched/core.o] Error 1


Build image:
-----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241115/testrun/25823523/suite/build/test/clang-19-tinyconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241115/testrun/25823523/suite/build/test/clang-19-tinyconfig/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241114/testrun/25810736/suite/build/test/gcc-13-tinyconfig/details/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2osJibjMRLtDUebXPN6WOC65CLb/

Steps to reproduce:
------------
- # tuxmake --runtime podman --target-arch arm64 --toolchain clang-19
--kconfig tinyconfig LLVM=1 LLVM_IAS=1

metadata:
----
  git describe: next-20241114
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: 37c5695cb37a20403947062be8cb7e00f6bed353
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2osJibjMRLtDUebXPN6WOC65CLb/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2osJibjMRLtDUebXPN6WOC65CLb/
  toolchain: clang-19 and gcc-13
  config: tinyconfig
  arch: arm, arm64, i386, powerpc, riscv, s390, x86_64

--
Linaro LKFT
https://lkft.linaro.org
