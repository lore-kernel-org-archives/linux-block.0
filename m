Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F66BCA62;
	Tue, 14 May 2024 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715652337; cv=none; b=OA6aFA6ZwRYQ+CsTfNdD/c0LfjkxQxSD86jRUTSNgoIJU0r0hdKqaV7LxY2DPc4n3kkpZEXlUAYdkrH8aROYtxr3eGknsXPIRYFzured7AH8pNmx7ypM7EG1u+jfZpK7nY+W0xxIqoECsAiaZJJ2rJukPw8DhP2nZkijTz7ek/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715652337; c=relaxed/simple;
	bh=NhsZ+C2CYcpDtcwpIljnQcDjOLmdu+fZF7+ROHY/32M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enuwlan/q0g3TmJb4F5fIqdgvDY/rcMqwLDvhA/picR6L4GrIzpKq5TB0AqQWU50pysUWB22luMIxwcqxRmc/YiHrW+5JG0lmyVw9oIDjVgX1wLgGD2EVUiu1gVqU8Rhp/qQ5Q6jPYjiRZ+D4MY/XwIMPmMEZtgKu9OBG8LO7Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5rQJR98; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5rQJR98"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so5641716e87.2;
        Mon, 13 May 2024 19:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715652333; x=1716257133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxFA2X6IJt65tETPWjtrRru5w3XzoCwgMRsrmd+S4lU=;
        b=Z5rQJR98CJVccS7cUkVlC3TtMD9fHOAa+bmnrkMya3P9ArlPk8VsabJUUGO8ansULN
         /oF/+YSLImwdPbH769woSwdTYYY06f9gvx/xi3UCFaiC8NU3KW+EuLiS2/QbhQ/yDYu+
         yCyK68E5tik0ML2M+3RY3Il1ww7S1UbjyLQAaPQFctYYy1CaK/9pCG98Wso34lXJgw5+
         IyRVYQJoKIOrWdVuKilCBdy5uQJaJlmPQt5Rn8hl2+WzlUKANTh9wfjinENwFqJ2dqAr
         sDBL5ZFFhsMyLLeF0WjsZNmvTjCyU9uvK5tXN1wtAYQs9H3uaiK8l1Cl76nsGWmzn6zD
         +fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715652333; x=1716257133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxFA2X6IJt65tETPWjtrRru5w3XzoCwgMRsrmd+S4lU=;
        b=HMMrkkQUvbM5DFD6RAPMGflGxQeFjkLKP9B8aZ1x3ZIK57JUjaKrp789OTIcp4PMMC
         GpSM/Is3F6okViAhipthjVUxWhuCpVh7Z6DEZZBd2D3962J7nNB5drIcLKVBBCfTcCN0
         djXkwUfUhUcALVgS1k76C6kEiNaKOcrTQR20/EZ0NIr+DWpgFtT3jPee98+SQvWrswiW
         0XeStqesFHLsy5dytlJYgOTEVbxhxMeRRzTaYpjUvzOHVeEV1krIh1f8WHKBv11hyW20
         Z/wT9MmI4BEHbII7kpVuNgsuBRbEYY5s/DB2bBdyJ61D2CyV4l1GTolYaEiGa4hH+HT+
         0JrA==
X-Forwarded-Encrypted: i=1; AJvYcCXOXFnarzm7eT6CUunEoWSao2kxJ4G0jhard7by0lG/sgO2c3GzZkJHEk5bsNK6nt3IEhpLVPlte9JA62adyy3obENV4n4qgB451JU=
X-Gm-Message-State: AOJu0Yx5eIWuxZsDEUup5dSNl/k/HRM/K5PEAp1/T5yTg+DswJHJiB8M
	nRgWo11Mjnk9VzIWrCp7N+fyf0zOgNhUKmG7RNZPy5mX/+MdQZKl1rfar3DP6SM+yZSdOpWJWDL
	OQ787XYrrjqhDTWMewZi8CqpA4ek=
X-Google-Smtp-Source: AGHT+IEEpX8txEQ2kh0R+wJnLXEGVaauqZJdg6f5TnWvPdFjZHEBtUpvYvfS68tNCK/5/jMWRWQWIIerHFZudGqxoQQ=
X-Received: by 2002:a05:6512:b1a:b0:51d:a4e3:4cb8 with SMTP id
 2adb3069b0e04-5220ff70b64mr9038580e87.49.1715652333236; Mon, 13 May 2024
 19:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYPxWBfEnuKeCGEsscVTYy8MrNxCJwdbxS=c2-B0H+HfTA@mail.gmail.com>
 <20240513225409.3025-1-hdanton@sina.com>
In-Reply-To: <20240513225409.3025-1-hdanton@sina.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 14 May 2024 10:05:21 +0800
Message-ID: <CAEkJfYMhv8AxxHSVdPT9bCX1cJZXw39+bMFh=2N9uNOB4Hcr=w@mail.gmail.com>
Subject: Re: [Linux kernel bug] INFO: task hung in blk_mq_get_tag
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller-bugs@googlegroups.com, 
	xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 6:54=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Mon, 13 May 2024 20:57:44 +0800 Sam Sun <samsun1006219@gmail.com>
> >
> > I applied this patch and tried using the C repro, but it still crashed
> > with the same task hang kernel dump log.
>
> Oh low-hanging pear is sour, and try again seeing if there is missing
> wakeup due to wake batch.
>
> --- x/lib/sbitmap.c
> +++ y/lib/sbitmap.c
> @@ -579,6 +579,8 @@ void sbitmap_queue_wake_up(struct sbitma
>         unsigned int wake_batch =3D READ_ONCE(sbq->wake_batch);
>         unsigned int wakeups;
>
> +       __sbitmap_queue_wake_up(sbq, nr);
> +
>         if (!atomic_read(&sbq->ws_active))
>                 return;
>
> --


I applied this patch together with the last patch. Unfortunately it
still crashed.

Pointed out by Tetsuo, this kernel panic might be caused by sending
NMI between cpus. As dump log shows:
```
[  429.046960][   T32] NMI backtrace for cpu 0
[  429.047499][   T32] CPU: 0 PID: 32 Comm: khungtaskd Not tainted
6.9.0-dirty #6
[  429.048417][   T32] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[  429.049873][   T32] Call Trace:
[  429.050299][   T32]  <TASK>
[  429.050672][   T32]  dump_stack_lvl+0x201/0x300
...
[  429.063133][   T32]  ret_from_fork_asm+0x11/0x20
[  429.063735][   T32]  </TASK>
[  429.064168][   T32] Sending NMI from CPU 0 to CPUs 1:
[  429.064833][   T32] BUG: unable to handle page fault for address:
ffffffff813d4cf1
[  429.065765][   T32] #PF: supervisor write access in kernel mode
[  429.066502][   T32] #PF: error_code(0x0003) - permissions violation
[  429.067274][   T32] PGD db38067 P4D db38067 PUD db39063 PMD 12001a1
[  429.068068][   T32] Oops: 0003 [#1] PREEMPT SMP KASAN NOPTI
[  429.068767][   T32] CPU: 0 PID: 32 Comm: khungtaskd Not tainted
6.9.0-dirty #6
[  429.069666][   T32] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[  429.071142][   T32] RIP: 0010:__send_ipi_mask+0x541/0x690
```
Should I add them to cc list?

Best,
Yue
