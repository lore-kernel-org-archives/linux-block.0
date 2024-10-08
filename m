Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7825779
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365183; cv=none; b=Hf4x6xaTZsLtMDVpvLHqFt7HtIyCVXthDMes3F/qtJr0xB+JvdExsnD4x1K5YAkutYtpSL0chtw6mLN2VTqQXhRun+iLFjsaDkS7YMAiqFMdFPq3l5U3HZz+oK19cR63sPq5sgRdOm5cIrJDYxVbDYAKxpP+0OZMR2EcgCBF3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365183; c=relaxed/simple;
	bh=v/9r7ols2TxdYJqHCQir4YTWbVf0r4kJUmBexzjd3nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiPuy1Vu9EFxjbIN1wCnaR9y82RLboOfm1OvG3OGWY/RAu3XwEim/ZhOAyxVpXofPNoJIMjEKDAzNgD3/q2ez3F364z2sNFydIacx+Spm5ists3QN7mw3tkJZfo1LATisbzUiXKY0Bfy2z3chsQkgyvQZ9hZppNawffJ4viv/qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d8oF1Ygi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d8oF1Ygi"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b6458ee37so60912715ad.1
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 22:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728365181; x=1728969981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=85iRtR/VvUGnVZPW5BZSacpjiorlTGlLtEtlkXInyoU=;
        b=d8oF1YgiLf5Y9du4OTkY/RHzIe4xuZ3SsmNtpE8dFxpLGb8HSfBsMqytN8sPUF3pBI
         2SujMrPK22I1f/q4KU/YfiYuwIftQZwjxTsAUN23vv28FbcB7nvewsE2UXNs84ojrRGt
         JgdmrVcKdfxbrMVHji+t2IFCPIsPPIyyOSmd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728365181; x=1728969981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85iRtR/VvUGnVZPW5BZSacpjiorlTGlLtEtlkXInyoU=;
        b=NoznVnYhY31A5oYdU4xgZoybarllHJe0bMqk992mZiWrwdBc0uBZtpid+i/lhQa50n
         RLDRCoYmp7wP53hS+McJv6xu2t8YFcpgNbBzP3chhEVkfJpWOa3QpfkpgJVKTQhD/YET
         1troPu5LRrQliiZN6cRdGDuxh4OAdtE+8br1CUhBcH0UKYuMPXy+yhvbKUbgZKW/jD7x
         3Ywi9SMQn6AIQb8FZxKsUqwa9Mt6nqDNmcsuG7lB7M6S0x9UijYK+BBIW6XtPDHkEqFN
         dHBtsGx97IfRDMRM/qoyJwJQT+g6u6yRHqEXArkXJ4Q0BFrdlf6QHI2nQi0GzyV0Ko/7
         secQ==
X-Gm-Message-State: AOJu0YyMB5b5zLYYV1p9qPWuBVzkJ+xKB5oZXQqQ+pZXiwHey4oYdIjo
	w2riSQlacCBR8o7gVE/YaC9trLGeNU5fUo7szve8DGGH6luOhhCb8IqMh2tMuw==
X-Google-Smtp-Source: AGHT+IGBZHyS+kiGf7hBhUN/4XBcRT9e43sw0u4npmHKAB7lPWfH8oQJHoHBjFzrenxD82Z8k20bYw==
X-Received: by 2002:a17:902:d0d1:b0:20b:9680:d5b8 with SMTP id d9443c01a7336-20bfde59668mr118143595ad.3.1728365181479;
        Mon, 07 Oct 2024 22:26:21 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e05b:ffee:c9cf:bdec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139a329dsm48421175ad.305.2024.10.07.22.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 22:26:21 -0700 (PDT)
Date: Tue, 8 Oct 2024 14:26:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: YangYang <yang.yang@vivo.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241008052617.GC10794@google.com>
References: <20241003085610.GK11458@google.com>
 <b3690d1b-3c4f-4ec0-9d74-e09addc322ff@vivo.com>
 <20241008051948.GB10794@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008051948.GB10794@google.com>

On (24/10/08 14:19), Sergey Senozhatsky wrote:
[..]
> Or another report:
>
>  sr 1:0:0:0: Power-on or device reset occurred
>  sr 1:0:0:0: [sr0] scsi3-mmc drive: 8x/24x writer dvd-ram cd/rw xa/form2 cdda tray
>  usb 1-1.3.1: USB disconnect, device number 27
>
>   schedule+0x554/0x1218
>   schedule_preempt_disabled+0x30/0x50
>   mutex_lock+0x3c/0x70
>   del_gendisk+0xe8/0x370
>   sr_remove+0x30/0x58 [sr_mod (HASH:d5f2 4)]
>   device_release_driver_internal+0x1a0/0x278
>   device_release_driver+0x24/0x38
>   bus_remove_device+0x150/0x170
>   device_del+0x1d0/0x348
>   __scsi_remove_device+0xb4/0x198
>   scsi_forget_host+0x5c/0x80
>   scsi_remove_host+0x98/0x1c8
>   usb_stor_disconnect+0x74/0x110
>   usb_unbind_interface+0xcc/0x250
>   device_release_driver_internal+0x1a0/0x278
>   device_release_driver+0x24/0x38
>   bus_remove_device+0x150/0x170
>   device_del+0x1d0/0x348
>   usb_disable_device+0x88/0x190
>   usb_disconnect+0xf8/0x318
>
>   schedule+0x554/0x1218
>   blk_queue_enter+0xd0/0x170
>   blk_mq_alloc_request+0x138/0x1e8
>   scsi_execute_cmd+0x88/0x258
>   scsi_test_unit_ready+0x88/0x118
>   sr_drive_status+0x5c/0x160 [sr_mod (HASH:d5f2 4)]
>   cdrom_ioctl+0x7d4/0x2730 [cdrom (HASH:37c3 5)]
>   sr_block_ioctl+0xa8/0x110 [sr_mod (HASH:d5f2 4)]
>   blkdev_ioctl+0x468/0xbf0
>   __arm64_sys_ioctl+0x254/0x6d0

Didn't copy one more backtrace here, there are two mutexes involved.

  schedule+0x554/0x1218
  schedule_preempt_disabled+0x30/0x50
  mutex_lock+0x3c/0x70
  sr_block_release+0x2c/0x60 [sr_mod (HASH:d5f2 4)]
  blkdev_put+0x184/0x290
  blkdev_release+0x34/0x50
  __fput_sync+0xa8/0x2d8
  __arm64_sys_close+0x6c/0xd8
  invoke_syscall+0x78/0xf0

So process A holds cd->lock and sleeps in blk_queue_enter()
   process B holds ->open_mutex and sleeps on cd->lock, which is owned by A
   process C sleeps on ->open_mutex, which is owned by B.
