Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03C944F
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101485; cv=none; b=PRtYnyee0WcueFG9YRvKxlDCTJ2+crXTdNEhJzcPLgU8xLpsS4vnQQkx9bp4c5wuPiwCfaG3ZIIUdlOntTnu+1u16PaBjQT73W0hxEVTyVtNPgneng3wcOqQus0Bh2RBspQ1W56/TNzB7048fHY0/m0OtgfuLPeB8+bCxwXlUX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101485; c=relaxed/simple;
	bh=rrggvFzTKf71d726gmomOvvxRIYdGY7+rR8j9BpC9HU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sAmLZITdGDq0aevURPKP+NMpH492CSkAiJfGZq6CXavYKhUYG5Wj/lm7Z8r6Qp4YnKK7VlNLa4KIKbffUy0ilD2zGLEnoLORvOpYinPimWip/VSf5zh4DoD5ANr0geCI8l99+UeGQD3M1VUNHfwOTBRABrJXY1Xl6QrWMlffDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B2guoNXQ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B2guoNXQ"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df2e7cdc64so3041215ab.1
        for <linux-block@vger.kernel.org>; Wed, 09 Jul 2025 15:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752101479; x=1752706279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLjN7k8Nb+pKx8iR0qvK0pBES2cbjfkP0zWhh5s0+6Y=;
        b=B2guoNXQfSBVcu27yswPS8PeFT2C5gUkinXul6ga0KUyQ9tsrT7xZVPsq4ZnaXkntb
         SCcTv2i2xKA2j/LTY1Sy5zZPGHKCjR6wE/xTvkSeOMegwNNKyaq9DOsPJAdmLZTUU8Zm
         yYgZ62/Tn9UL2w1WNKb8fzSwT4Pu2ClVDBcGWysDkx3j/he+V5xqny5JH8LP1lU2OOsu
         b1KQA+Fgjd75LPFbpiB6sVoJgMvc1tUjHSjETelcGO/IEmmwa5BRAhplGphrkkwDlJfC
         CSZuCyK7/EoFRGEyaHQvoDGTdcAyfEDzN80cyw2JfdIzobRNj5jjNo8+Qxmk+Ha8HwqZ
         HzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101479; x=1752706279;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLjN7k8Nb+pKx8iR0qvK0pBES2cbjfkP0zWhh5s0+6Y=;
        b=pv2kGalq/S1dwIaStj7HGv8GO5Z4imDwCUwFrg08zAb2y145BUCOqqnl45ztvFwXY3
         xhaUq+YgH3ZABtUCKt4uODgxe6NjO+L+8/mTHGnxErCdfdbzTLu5dyTHOBb2x8eeD26n
         1hL6azg70G/Pe0eruyE5csIKLsddTWP6TMdw+xfJ1+7wCMUvhN+nekuOeg9JUf+rwn+A
         dDPfdALJ9pfz4qsd7qVOXh/woCNceVOOj7ifPMvIpO8CAQI4HqJYfSdC1d4iNl8QxsSg
         MB8+7oafM/KGBmqWTfmONQmtPkT2fVochhjAqtP4t/XXPz7T8JO6eQrPkY9bx3wI9U1k
         1S+Q==
X-Gm-Message-State: AOJu0YxYjNJ7yDOFYnM6evPKfRMYQTX/G9R17T6qPDGVf6alGkyNkQsC
	GQyYfBPkTyjmFwSqPIfzQhKf2LUp7AIGhxh0B5mKLdEJoBkOVtpqlB4OVHPoyI4sTZLH16a6OoA
	GvaK2
X-Gm-Gg: ASbGncsBjndpFGE4Yi0+2dEEK6kgHc1QOYKWT740CWPl41w0qQJfhV6CA87EchNCNhH
	hrHtyylJNSkRCQEaCEnjqdZgOpjc4l/AqmA7WuEI4Y920tnL6PJRl1w7kXoFCZ2vHGe/YZDL5Yl
	BSIWhDThKHKLK0AbvvZrJ1v81/ZBwRL4p4RBAlZ8Onvg+/30bk7uziUbGMzxnIusXQgzsZp7GTR
	HpjnE+ZEjUaxhvMR+vVLPstOxIuHYK1FunpeJqEskvgPRJj7lLlx3pSfTbaiScYhbbN06NC8ct/
	xOlWjQ0zLmdSSez/UGJ86kzk1thw8o1mkCXOfbUZgUgEVetwbW8pgw==
X-Google-Smtp-Source: AGHT+IHCD3YCAj80HmB++fqysfkj73vEEJzSfUIU4jB1XRvknj07xLgtwy9jehsxm1YN89/KqSg00A==
X-Received: by 2002:a05:6e02:1c2d:b0:3df:3a4f:c884 with SMTP id e9e14a558f8ab-3e1670190bemr43111895ab.8.1752101478596;
        Wed, 09 Jul 2025 15:51:18 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e246134dd3sm1000435ab.21.2025.07.09.15.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:51:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com, 
 Yu Kuai <yukuai3@huawei.com>, Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250709111744.2353050-1-ming.lei@redhat.com>
References: <20250709111744.2353050-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] nbd: fix lockdep deadlock warning
Message-Id: <175210147757.1343379.13770714524265499576.b4-ty@kernel.dk>
Date: Wed, 09 Jul 2025 16:51:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 09 Jul 2025 19:17:44 +0800, Ming Lei wrote:
> nbd grabs device lock nbd->config_lock for updating nr_hw_queues, this
> ways cause the following lock dependency:
> 
> -> #2 (&disk->open_mutex){+.+.}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5871 [inline]
>        lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
>        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>        __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
>        mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
>        __del_gendisk+0x132/0xac6 block/genhd.c:706
>        del_gendisk+0xf6/0x19a block/genhd.c:819
>        nbd_dev_remove+0x3c/0xf2 drivers/block/nbd.c:268
>        nbd_dev_remove_work+0x1c/0x26 drivers/block/nbd.c:284
>        process_one_work+0x96a/0x1f32 kernel/workqueue.c:3238
>        process_scheduled_works kernel/workqueue.c:3321 [inline]
>        worker_thread+0x5ce/0xde8 kernel/workqueue.c:3402
>        kthread+0x39c/0x7d4 kernel/kthread.c:464
>        ret_from_fork_kernel+0x2a/0xbb2 arch/riscv/kernel/process.c:214
>        ret_from_fork_kernel_asm+0x16/0x18 arch/riscv/kernel/entry.S:327
> 
> [...]

Applied, thanks!

[1/1] nbd: fix lockdep deadlock warning
      commit: 8b428f42f3edfd62422aa7ad87049ab232a2eaa9

Best regards,
-- 
Jens Axboe



