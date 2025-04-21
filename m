Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863A20B80E
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745225605; cv=none; b=nzMkIq+V2ik5Gf6jsfB3z4QClgjqFq3bCJ5q2ifgF/xjVVjfqBtLvNbn1NUBMEaD0WoKgRd0EObapaNgZPzZSfCfM1/SwZqIK09oflp10MFRAvqwEX/SHxevyb7f1xTnRXvIm+v+UwCEMkUy6aGGrLx7qM4JU+A8MbDcK5gSWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745225605; c=relaxed/simple;
	bh=gtTIBC3Q0QQGcFu2q4J0SR9kkM1GoIUuQgVywB2Xm4Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FIyUQtEukSVucvp48FjHmtCO/seFyS7fI/ERtBs903+caWr7VQFuunK6fFPfWb0hEY72OdFWH+5ZMi8NP3UBd/bFzRKrCz+hv039L9Q85hpr40tupVukJh2yN01kZnCtdVy2SRMJg28tXHMguiJmiuGFAMkahvwhe2krKS2VHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=APoi7mvv; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="APoi7mvv"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f0ad74483fso44502806d6.1
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1745225603; x=1745830403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eost/be25fPZpDXj7+CKmcbdoPmFkSJH4e4lTEubNDE=;
        b=APoi7mvv/BH/zxnddt4130JohqyWgrJWBOQt39Ji4Nz+Wf3UlnHjvkernW7KRIhiiV
         l9LXvwZIQa3wP/2Endg3JWKUG+e9tG3X1jDQ/GR6l03AMxDuRI1KEqWZj+y0Pgt1JOsg
         ByWsFHXOi3JmJ22lFVAXARHI3oJiu8m70RX8s8zxycJdmTN2n1DDu6WwwH4kw239SLCR
         iadQDWN51ZpIZ2U4bnB3Qy/uxR7kbBAnS9QXlyzoEih1sVplzRyZIk6/3fAPFPtz91BN
         Azn6nrxdEXtOkNENRT+Ks/PhuRUtPzwAZY/4vNjUrnOG9lx96oSSDTRhqX9jAG91KXEf
         LKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745225603; x=1745830403;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eost/be25fPZpDXj7+CKmcbdoPmFkSJH4e4lTEubNDE=;
        b=Od1LA1GtEgqrkNCczJWdIF35fVlt9LOUQJeMTnN2ipw0RBz21sT0tv4Ck/uC7duYrE
         g68qt9n6YvOlbrh2PGOxBKQDFqPfDl+F2XxjPwQ1RLuZqsiu7x559ErtdS1/3r3DnRMJ
         FEXcqtoaYu1+rnsRV4b2DGx8gD27eL7ZAuNGEE3Hta6CiOSYbo6xA1DjtoqGf3/Lx0U/
         lgW29eD7NloddUCf5HVrolmzhu7al7hUSI+tStypzADR+xqXl6FZcNX2yelwKJBxa5Mc
         JstbaKvoOMkQPFuvqhZzKW649h/gxBTuW0w1Jt5J/B0qXZdnnuyKwo0oVRxBhq4AZncB
         jzWQ==
X-Gm-Message-State: AOJu0Yz+u9iyE1jjnntHGwhT+Kw6Aqy8+HCpZDcZtOQZuocbkWXHHYqz
	XEK97KKYCN+Lk4ecdvzfW2EwrAPS1bDYs5MLDL6XUN2BAODD5Q2ELQzt+8t1cylHytFzoqzfnuF
	AxObrO6fW4dqAo9+uGhnIvIFJlejFzkWVnzsvbA==
X-Gm-Gg: ASbGncvpJXwdEwUsjnM5Ev3COugr/BnblVi0PeCTS2k1yd69pGRsYzuibCIuZu+OU8O
	oJwb9D1/re1QLz0azF5vcyg86vAJUsmsHfKepuzDM4BRK7ELF192p8avhwwRD3FwtHP9+wGJ4Nj
	KaSKF627/w8xYbOsu5F0u2Dec5PbUbEym7903yvA==
X-Google-Smtp-Source: AGHT+IFTXLFiHer36IIFOWiiN9O7eVQGpX9NVs4SsqjUj1WLyMeUJsEgUuoy2uu7qC1VOo1sFR3meKw1188fTPpCJ/Q=
X-Received: by 2002:a05:6214:c88:b0:6ed:df6:cdcd with SMTP id
 6a1803df08f44-6f2c45701ecmr201847936d6.21.1745225603134; Mon, 21 Apr 2025
 01:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matt Fleming <mfleming@cloudflare.com>
Date: Mon, 21 Apr 2025 09:53:10 +0100
X-Gm-Features: ATxdqUEI-DjXLEjTsWXDLoFAcw_0tI_MLiWA4ak0uvSP_dcRAK-NMpaRY9Ngsl4
Message-ID: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
Subject: 10x I/O await times in 6.12
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

Hey there,

We're moving to 6.12 at Cloudflare and noticed that write await times
in iostat are 10x what they were in 6.6. After a bit of bpftracing
(script to find all plug times above 10ms below), it seems like this
is an accounting error caused by the plug->cur_ktime optimisation
rather than anything more material.

It appears as though a task can enter __submit_bio() with ->plug set
and a very stale cur_ktime value on the order of milliseconds. Is this
expected behaviour? It looks like it leads to inaccurate I/O times.

Thanks,
Matt

---->8----
$ sudo bpftrace -e 'k:__submit_bio { $p = curtask->plug; if ($p != 0)
{ if (((nsecs - $p->cur_ktime) / 1000) > 10000) { @[kstack] =
count();}}}'
Attaching 1 probe...
^C

@[
    __submit_bio+1
    submit_bio_noacct_nocheck+390
    submit_bio_wait+92
    swap_writepage_bdev_sync+262
    swap_writepage+315
    pageout+291
    shrink_folio_list+1835
    shrink_lruvec+1683
    shrink_node+784
    balance_pgdat+877
    kswapd+496
    kthread+207
    ret_from_fork+49
    ret_from_fork_asm+26
]: 184
@[
    __submit_bio+1
    submit_bio_noacct_nocheck+390
    _xfs_buf_ioapply+599
    __xfs_buf_submit+110
    xfs_buf_delwri_submit_buffers+399
    xfsaild+691
    kthread+207
    ret_from_fork+49
    ret_from_fork_asm+26
]: 28123
