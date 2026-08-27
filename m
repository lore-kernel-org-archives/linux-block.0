Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C135A376A03
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787861133; cv=pass; b=kHD1CQ/Uer6BB3+CVn3My5LzsC4kL7zH/Ti45sds9NsuyyN+9EO19sIva2ykLNpButu68w4AX1DSVT7DsNlxr1Rtai9dhXviqg9SdhhrVfEW2Q1ntCjSCYECc8ZVJbvp7N5ITwiY/1k05jkEBYBpOE0zVElajWbeHlfXN/3YLCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787861133; c=relaxed/simple;
	bh=Amq2Nq7g4Rvhi+A8MmnZy28GeuV84bebu12tbajvslg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5SX3VlaLp2Maz082PGcuvfLQ16cas/soh5dkdhuau0YI/SuCO5qxRXJvsLu19tXSGxPWN8uFnFeExX2ksdVcNWZtuKSz8iYN17TU4+EYNdoi0R2KxXOvTfoRrfPOUry0Lu5b7egBhKvOL7SezXlPH4HT1VEEuyf4/m5nFrczLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBTcaEmd; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBTcaEmd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b8f86c6deso922365e9.0
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 13:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787861128; cv=none;
        d=google.com; s=arc-20260327;
        b=MlIqyrnAc8SH4ltqoptdN5mHu7StPKnR1tbYY7Gj9xymKRBM/7T/bb/EySvDArq0M7
         cN8ZQ175XvRiQLojf2nFfzgdfAzb0Zhdpqe+NW8DmuxLbooMTxn5Gz20vy50CsjoiK/C
         zinRd3LvCH6liu7vBAb3zQVuZqf8s3OhgHhsdIkwGVAWrn5SLf34RnHj3NE6yEO4Cbmw
         HLh52fbAiRm637+pR+dwARb712ElUnltZUB8gwl0mRtePPDl48wf94mFzqML1UhDAO8A
         9TAfacu+96bSnBA0+jEj1Lmbi+zghvNqY3jqf9uwr+gtowaC99aqnk0m+1cXGILzUgcA
         tCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIsnd6xgeWrgcQT3jCCMdd8DVWxNR+Gr3QkvZG2o5wQ=;
        fh=zn5eBtk2kHTniCef1JSV8L6cCbdewf+2KKTgH1zlIqU=;
        b=jVnDyV6CrEtMurO8gS7E50tBiGrYnFy1VI2tYhv6SF4W9bgzHJEGZ7YEY5jXkGInlJ
         +RV6sKsmMdX7nRucOndvgUYQ4sZW2+XI9VrGOb5w5U8LyjfsrVskpxqbQeCyNyA8kokr
         NynbmecXDpw0lSdbM4dTdxp0VUVTLsYRn2E+VIBIQo56kB85mAxITrZeU2us1HxUX95B
         vCHlb2HFHNlIDh9x/whZEBTHRFQCESRkCCSVj5SqOXNijUtllRfSraCe9/RYlepZQr9X
         cZPy2MzcfbWLm9LZnBqBaCCfJ3Jk/GNxQ+nVa9jqbvybtNxyYNiRyqoScFbXCuM8mvVS
         1aEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787861128; x=1788465928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BIsnd6xgeWrgcQT3jCCMdd8DVWxNR+Gr3QkvZG2o5wQ=;
        b=jBTcaEmdwdW1DRedprV3w9bCe6/SEJs/DHjsy+D+PHot4C/PbHh5tD3BM6AzYCRCi6
         pWnhe7FihJi7qfBJNS+BVYisD9dMsX12faXTjzTw/9IRGDEtAaH35EU+ihqp2Uu33ynq
         uhZIwC3LG35wBKRoLsXUPWgEl4QAOtGU46rOl9i566IVSK9phMB5SNzdSqaXtnnPIoqQ
         H9sy42ymjOdy+f63Je0waSafi6q1BeCdb6uW23+Y+Sv6XzOv32pHLYs+qlaK6knAMBza
         CkfyYJEVtbS/VyPG1h9ao2I1/CL4JxF13UInCu9/qA+jqeRjk3uNvG3ELapCPsDwbqta
         iJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787861128; x=1788465928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIsnd6xgeWrgcQT3jCCMdd8DVWxNR+Gr3QkvZG2o5wQ=;
        b=NXCLGBijsiaNyEUe6WN9Nqrh7rDpkQtKOKM9YoOiA62nkDV/Q9pKM2gwZKReRo4GHV
         gIsYWm4czIP/SMgOVGHmA7yeRark14XyjKQG+VVkGNddPNJCFpj7WcQnP1iEySI/Tnex
         Hb3RjIIcpu8uxYhIc+TD8ttpuyks4JOyy6wHQJKRT8MgzYjGrM6znpBIxTljycat9exV
         coOie4LGI+pLWRFusp5UJcRWOi9QkQNDTjFkrn4x4NNuoyVJkHLgWVi5+eH2N6vn734x
         UUWmMesNIpnlxavjP/CuaODhmGrkgutPIUP1mzJ7f3p//F0q+X5bkH3J0PGTPaOx+sMr
         rEsg==
X-Forwarded-Encrypted: i=1; AHgh+RovKocC5er3jy+Evztn+b3ISYU9SDcKDnUBP1H7Xxil1X0xTxrISLfEUGsWqn9IpFAR071PPpMH33SrWQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kVwDRI2t7E0qQO9J8f5dETkNxAFH54R6lCziX2VDrb5MwfZTPF
	vTB2aqCfbrVdnUpXyBst2hHl8oQxPp1Vv2Km6v5w2Mw0zU5WT6vLK/7dqFlhgo37YW/Wzoc/Mji
	yRIaed03r/VynCbtoqIvyW5W0dvlcBIs=
X-Gm-Gg: AR+sD13Ir1bahguiLy8EvZOJGCZSR+yubt/fTdcXzZJLBlXABgKz9tQSyIUZkAYF5wx
	dzgkZTPWO8MPpBaksSawstm9ZEC0HznXkFkeGlzpawbmSxPBd3AF2QKwN854xMjO1nI8jqg7mEn
	uah6pdCwomeoNQAxfRWZnn8Xkmxx0/VfjuAdzpNffbUJ8anQ8KxurLps0QD24MbkepLNdQT9KJm
	G22u8eggyOSIAfvT62oZm3Q95++Ycmaf8f2v6nUBxJiSm1nlEE6Ans0fejrPgEBCGZtw34s1ETX
	yJCn0QiS1XSHU+awdNJimLMOeR+l7JaBk+7tILuJoc9HqPuCsqOVOsHug/QNdaZEc3DrCon8QTe
	O9MRbtGe5mLiXU7/h6/TqmMXb4/s=
X-Received: by 2002:a05:600c:c4aa:b0:499:d513:e507 with SMTP id
 5b1f17b1804b1-49b91c17d72mr16962265e9.2.1787861127504; Thu, 27 Aug 2026
 13:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827185722.3234622-1-csander@purestorage.com> <20260827185722.3234622-2-csander@purestorage.com>
In-Reply-To: <20260827185722.3234622-2-csander@purestorage.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 27 Aug 2026 13:05:15 -0700
X-Gm-Features: AcwNN1UExlY2vL2SpJh0tNQapsYMiZcr3z5sWaZZFYGrbWrJd63x35h50FR6wzE
Message-ID: <CAJnrk1YfTg-Lz+TmM+c=Asc8N4QGuY9_g8zUXtaNr4O7hG1Djw@mail.gmail.com>
Subject: Re: [PATCH 1/2] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, fuse-devel@lists.linux.dev, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Caleb,

On Thu, Aug 27, 2026 at 11:57=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> In preparation for setting the io_uring NVMe passthru CQE results from
> the blk-mq request completion rather than the task work callback, split
> out functions io_uring_cmd_set_res{,32}() from io_uring_cmd_done{,32}().
> This allows io_uring_cmd_done{,32}() and __io_uring_cmd_done() to be
> consolidated into a single CQE-size-agnostic function with 3 fewer
> arguments than __io_uring_cmd_done().
>

The conversion looks logically correct to me but the interface feels a
bit annoying / fragile on the caller side.

Is there a way nvme can get what it needs without changing the other
callers? Would it work to just keep the existing
io_uring_cmd_done{,32}() as is and add a separate API for special
callers like nvme, eg:

  void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64 res2);
  void __io_uring_cmd_done(struct io_uring_cmd *cmd, unsigned issue_flags);

where io_uring_cmd_done{,32} would then just be inline wrappers over
those? afaict, then only the nvme callsite would have to change and
fuse, btrfs, block, ublk, and scsi_bsg could just stay as is. Do you
think something like that makes sense to do?

Thanks,
Joanne
