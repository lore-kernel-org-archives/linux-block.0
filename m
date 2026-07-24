Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755212E1DC
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900537; cv=none; b=dbGYCnKNZKxxi5p4Wfupi1QfY+T0cHmBjGvhQGL6lRcRZV+Ze+ZkJL5YI+KYcr/cnUP4P4AddthnUmDYJr6Q5CMgN8RnAVyj/D//jxzkbBzip+QDjbxPLeZwgyC9pXVJCWJfdeLF/mrCq6xL8VRBJiICyiHXVV4HQj9Gbn6Ed70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900537; c=relaxed/simple;
	bh=PLkBCO7IMxNvJ/KmysadWVzPU3HCVHbPfuXQqT8pR1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTRq6+8vs0iDB0CJwPwODj5ziJAgycu4mZ5SyvtNnKzGODAjRZDJ59dUhrpaGQem7inahA3yuh2fQ+95IDVru2gZs9ggV9JVWsR7jiiF+HhOGX0KN4oqX6gTQSEgGYRGpB+div3Ce1L1wLqIKJwiIE56SFBogsysf2q4MXiT8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so228652f8f.2
        for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 06:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784900534; x=1785505334;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eV7NacM7zz8dD71BscPxtfUEUlFKKkiOun0ZEBZ5n2A=;
        b=Zt0S/2UAAQEFMMxffV7rEZQGKjtlQRoXDOAGgl9rR0ecpHEe+azQ517cwuCabGEKLf
         M8x8ImQcL0sGmINPT7mYwiYHW47lGDdR979vtZiTG99eXrX/v2AnM0q4zC6yHQev39nk
         t+ebFCNANIvtd0bFacLuM03sOI2J0tNb2EoCtwMrK5BhaHqKUwfqa90h7wXkPlTrEpQk
         hS5u6Whl3xp0YQvZ4aXw5Fnvp85xgm5t3YxvZhzjdktd1ehnzDjjhOmAnnJap/vXDGM/
         RJcDeuARErSxRTpi5TPjXwa6pKxLbPVPSxRD0CwGdMXQdA/T4DgY4i0W/Fj3vjcu97dD
         bnqQ==
X-Gm-Message-State: AOJu0Yzn46SNt8Uf6iJqCoQ6r9x37Oa7LYrAnIWx+5wkPzaeVFTsU6CL
	k8luJNNmuoH2Y/LcC2s2RXIECLKtcpZgjqdTOek8Va47D4ska1nVQHPT
X-Gm-Gg: AR+sD1192rEypo1STzr3QRdivXBtXjbzCS1wl0c81TD1b1cLcZQCbA1upZiN/aqQUIb
	YpAd6c1jLGr0cJm97S6OFaNmlDhWd01UMNj/ENehDecdsKbA2f6CmrXtWtm4c8o5ZNVr8H3TY9y
	FvIQqQZ1tDgXtU0YkjqOVz7w4TUWjcQE4cuwqFaH8LyZArjv7CyyjNQ+z5zS4QdJb11Ys2taNXa
	wOYj61PcVjn1UUU/7ksyP0h++SyomzfMgeW7O8Jv93Y1YZWssegZCrUOduXS2caiutGKGVm1stJ
	IZtMi9vsZ4dCy/gFo+GxDmtibz8AND0VD/qK4dUJltW7sDQzoBfi296sQeCII7kCeLbem+Tdux5
	cGuOHMLel2Sqo+xb/bhbeG8qfpesoN/MY64n6ZRpZRk+Q/MYF4gx9Zf/8L+pSAXk0Qhvy2j7lAA
	==
X-Received: by 2002:a05:6000:2dc5:b0:46e:1815:6a83 with SMTP id ffacd0b85a97d-47f8dc8cfd4mr9396273f8f.29.1784900533455;
        Fri, 24 Jul 2026 06:42:13 -0700 (PDT)
Received: from [10.68.32.41] ([5.194.84.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63678sm23076091f8f.29.2026.07.24.06.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 06:42:13 -0700 (PDT)
Message-ID: <27146f5c-5e57-44a6-bbe9-d910d8bbdfcf@linux.com>
Date: Fri, 24 Jul 2026 17:42:11 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: avoid NULL deref in reset_interrupt when cont is
 cleared
To: Yang Xiuwei <yangxiuwei@kylinos.cn>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
 syzbot+619e27617b2abe6b9b72@syzkaller.appspotmail.com
References: <20260723073512.11120-1-yangxiuwei@kylinos.cn>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20260723073512.11120-1-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Thank you for the patch.

On 23/07/2026 11:35, Yang Xiuwei wrote:
> reset_fdc() arms do_floppy = reset_interrupt; the IRQ handler then
> queues that function via schedule_bh(). If unlock_fdc() or do_wakeup()
> clears cont before the work runs, reset_interrupt() dereferences a NULL
> cont and oopses.
> 
> Example crash excerpt:
> 
> [ 1070.468148] status=80
> [ 1070.468152] fdc_busy=1
> [ 1070.468158] cont=          (null)
> [ 1070.468161] current_req=          (null)
> [ 1070.468162] command_status=-1
> [ 1070.468163]
> [ 1070.557051] floppy0: floppy timeout called
> [ 1070.557053] no cont in shutdown!
> [ 1070.557056] floppy0: floppy_shutdown: timeout handler died.
> [ 1074.419509] floppy0: FDC access conflict!
> [ 1074.419782] BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000008
> [ 1074.421969] PGD 0 P4D 0
> [ 1074.422320] Oops: 0000 [#1] SMP NOPTI
> [ 1074.422648] CPU: 10 PID: 3269 Comm: kworker/u256:4 Kdump: loaded
> [ 1074.423830] Hardware name: inspur Standard PC (i440FX + PIIX, 1996),
> BIOS 0.0.0 02/06/2015
> [ 1074.424284] Workqueue: floppy floppy_work_workfn [floppy]
> [ 1074.424757] RIP: 0010:reset_interrupt+0x3a/0xa0 [floppy]
> 
> The same NULL deref has also been reported by syzbot on upstream.
> 
> Return early if cont is already NULL after result(). The hardware reset
> has completed; result() still drains the FDC. A later request can lock
> the FDC and reset again. This is a defensive fix for stale work, not a
> rewrite of the floppy continuation state machine.
> 
> Reported-by: syzbot+619e27617b2abe6b9b72@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=619e27617b2abe6b9b72
> Link: https://lore.kernel.org/linux-block/00000000000093c4d105f9aa34d6@google.com/
> Link: https://lists.openwall.net/linux-kernel/2021/10/27/56
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
> ---
>  drivers/block/floppy.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index f04397b8e381..3d2df99dbb29 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -1784,6 +1784,9 @@ static void reset_interrupt(void)
>  {
>  	debugt(__func__, "");
>  	result(current_fdc);		/* get the status ready for set_fdc */
> +	/* Stale work: unlock_fdc()/do_wakeup() may have cleared cont. */
> +	if (!cont)
> +		return;

It looks to me that this check closes the exact reported crash, but it doesn't
fix the root cause of the problem. I think cont can be set here with a valid
but unrelated continuation while stale reset work is inside result(). We need
a more generic solution to close the bug here.


>  	if (fdc_state[current_fdc].reset) {
>  		pr_info("reset set in interrupt, calling %ps\n", cont->error);
>  		cont->error();	/* a reset just after a reset. BAD! */


Thanks,
Denis
