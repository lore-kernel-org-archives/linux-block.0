Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958633985
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364794; cv=none; b=IqZkV8YtbxOup35rw8aXco0Fdp7H/y+M0wL6G7+BBX0rjAQ20ADpJhjHMk3X5gsJkECP8aLRbxfBzeAPJdyz2MXWKlo0E1WbjZoyO11b1Gx2ynC2Tme6MYB134ifWliuUxHI5ZmymHdC9hk9guddioEhFsvkGuSTMhTrDI0yEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364794; c=relaxed/simple;
	bh=JA2iahs23wFuB6n5SgM4w65K1eM5E4R4fnLmwciAJyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyvpkavJzg5QnGjzyWrlNQpDvLcQYcQkBpTl8za5c0wExuqNNzsff31tQXEiJfAZuAEP5lrAUt84Zu/gAV/EHDj9i4o27q8wOrvdRrGwXECjO3VqnNPuzdv9jdzaKoNP2qQA4q25ZxHObCNnacwjLc5CDOVF9jgd3l4E6OiYj1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ORzp2ZFj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ORzp2ZFj"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71dfc1124cdso1622226b3a.1
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 22:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728364792; x=1728969592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wy4gigeGQLDhsWSe2w6BkdGw7bAjQ9fLnWndvoLo1bg=;
        b=ORzp2ZFjmXHFBHwjHjoRCbGOTCN1ZasLoCwo36k1P/yIi19C/vKkF1egHHlf7P8985
         MVHBq4Zgoldic1kWOTXWF7jWWcDimux+Uv+Zp+taXMZ3FJacvvPaiHz2Bt7R89SGPzgX
         ZmMVgvKM8eBu1rNYlxop8QcwkpIY7xJCMoZIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728364792; x=1728969592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy4gigeGQLDhsWSe2w6BkdGw7bAjQ9fLnWndvoLo1bg=;
        b=fA8se3M4T4FIFWXvj67jZ0TmQJRuUaH/aNlLs3kUi4hj4GdE62LWT4ytm13+alf+dS
         o10c0mazWEIBCD6NUd2dSE3SAxj7p0LOdO9DN81Owiv4lJpLwTmOXgQJ5BhviE8hpd6j
         HasFJ0Z2BOCxS/OsRqKscxhe4wIAmDpceuurdzWdKTFfDOmiqkq22IeJlYB8o29xHXar
         gEntew6z5B61n0hOQ/qdmsHC++K+UrtptX0CHojQUBYKNoITNfvkJ47FrvXYArLSKog9
         IDkn8zUve5d9SbSXB2+hAjQjxkkBBH/vKQIKsMDKJqKEtqsVwmljg5NWEk2bnJ9+zEqO
         NE9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbvgvKNFaDpL2S379KAZa+RRHdz6pqtPNE3re+Ql3PYjjF2jY09WXEyGSe6m0DYk4DooKMJtrocnOGeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLWhrVmmoJ6ya1oOrKwKNMJbPy3ntcDDFcekD7LZxzMjKcJphq
	oUIoQwZrepsbMElSEbiQG4o6zm6n2XngqAbJ/f8Lcq2oyIMsJKwQ8Q61rPQtiqJvaH3W2plLvqn
	ZXA==
X-Google-Smtp-Source: AGHT+IG5t4Hw63I4vZzZTOX7XNAQ7XbymaS9sbhdLWFue4INcz80EF5Y9wEMjl5cXFYkleNoo1pkEA==
X-Received: by 2002:a05:6a00:8c17:b0:71d:ee22:8e43 with SMTP id d2e1a72fcca58-71e10529ddcmr2647911b3a.11.1728364792440;
        Mon, 07 Oct 2024 22:19:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e05b:ffee:c9cf:bdec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d47ed4sm5326150b3a.133.2024.10.07.22.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 22:19:52 -0700 (PDT)
Date: Tue, 8 Oct 2024 14:19:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: YangYang <yang.yang@vivo.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241008051948.GB10794@google.com>
References: <20241003085610.GK11458@google.com>
 <b3690d1b-3c4f-4ec0-9d74-e09addc322ff@vivo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3690d1b-3c4f-4ec0-9d74-e09addc322ff@vivo.com>

On (24/10/08 12:02), YangYang wrote:
> On 2024/10/3 16:56, Sergey Senozhatsky wrote:
> > Hello,
> >
> > I'm looking at a report from the fleet (don't have a reproducer)
> > and wondering what you and block folks might think / suggest.
> >
> > The problem is basically as follows
> >
> > CPU0
> >
> > do_syscall
> >   sys_close
> >    __fput
> >     blkdev_release
> >      blkdev_put              grabs ->open_mutex
> >       sr_block_release
> >        scsi_set_medium_removal
> >         ioctl_internal_command
> >          scsi_execute_cmd
> >           scsi_alloc_request
> >            blk_mq_alloc_request
> >             blk_queue_enter
> >              schedule
> >
> > at the same time:
> >
> > CPU1
> >
> > usb_disconnect
> >   usb_disable_device
> >    device_del
> >     usb_unbind_interface
> >      usb_stor_disconnect
> >       scsi_remove_host
> >        scsi_forget_host
> >         __scsi_remove_device
> >          device_del
> >           bus_remove_device
> >            device_release_driver_internal
> >             sr_remove
> >              del_gendisk
> >               mutex_lock     attempts to grab ->open_mutex
> >                schedule
> >
>
> I'm a little confused here. How is the queue getting frozen in this
> scenario?

I don't know.  Could it be that it's PM not frozen queue that falsifies
wait_event() condition? (if that's what you are pointing at).

I have several reports (various devices, various use-cases) and the ones
that I looked at so far have the same pattern:

	usb_disconnect() vs blk_queue_enter()

E.g. one of the reports:

...
 sd 1:0:0:0: [sdb] Attached SCSI removable disk
 usb 3-4: USB disconnect, device number 29
 sd 1:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=15s
 sd 1:0:0:0: [sdb] tag#0 CDB: Read(10) 28 00 07 47 af fd 00 00 01 00
 I/O error, dev sdb, sector 122138621 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
 device offline error, dev sdb, sector 122138616 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
 Buffer I/O error on dev sdb, logical block 15267327, async page read
...

  schedule+0x4f4/0x1540
  del_gendisk+0x136/0x370
  sd_remove+0x30/0x60
  device_release_driver_internal+0x1a2/0x2a0
  bus_remove_device+0x154/0x180
  device_del+0x207/0x370
  __scsi_remove_device+0xc0/0x170
  scsi_forget_host+0x45/0x60
  scsi_remove_host+0x87/0x170
  usb_stor_disconnect+0x63/0xb0
  usb_unbind_interface+0xbe/0x250
  device_release_driver_internal+0x1a2/0x2a0
  bus_remove_device+0x154/0x180
  device_del+0x207/0x370
  ? kobject_release+0x56/0xb0
  usb_disable_device+0x72/0x170
  usb_disconnect+0xeb/0x280

  schedule+0x4f4/0x1540
  blk_queue_enter+0x172/0x250
  blk_mq_alloc_request+0x167/0x210
  scsi_execute_cmd+0x65/0x240
  ioctl_internal_command+0x6c/0x150
  scsi_set_medium_removal+0x63/0xc0
  sd_release+0x42/0x50
  blkdev_put+0x13b/0x1f0
  blkdev_release+0x2b/0x40
  __fput_sync+0x9b/0x2c0
  __se_sys_close+0x69/0xc0
  do_syscall_64+0x60/0x90


Or another report:

 sr 1:0:0:0: Power-on or device reset occurred
 sr 1:0:0:0: [sr0] scsi3-mmc drive: 8x/24x writer dvd-ram cd/rw xa/form2 cdda tray
 usb 1-1.3.1: USB disconnect, device number 27

  schedule+0x554/0x1218
  schedule_preempt_disabled+0x30/0x50
  mutex_lock+0x3c/0x70
  del_gendisk+0xe8/0x370
  sr_remove+0x30/0x58 [sr_mod (HASH:d5f2 4)]
  device_release_driver_internal+0x1a0/0x278
  device_release_driver+0x24/0x38
  bus_remove_device+0x150/0x170
  device_del+0x1d0/0x348
  __scsi_remove_device+0xb4/0x198
  scsi_forget_host+0x5c/0x80
  scsi_remove_host+0x98/0x1c8
  usb_stor_disconnect+0x74/0x110
  usb_unbind_interface+0xcc/0x250
  device_release_driver_internal+0x1a0/0x278
  device_release_driver+0x24/0x38
  bus_remove_device+0x150/0x170
  device_del+0x1d0/0x348
  usb_disable_device+0x88/0x190
  usb_disconnect+0xf8/0x318

  schedule+0x554/0x1218
  blk_queue_enter+0xd0/0x170
  blk_mq_alloc_request+0x138/0x1e8
  scsi_execute_cmd+0x88/0x258
  scsi_test_unit_ready+0x88/0x118
  sr_drive_status+0x5c/0x160 [sr_mod (HASH:d5f2 4)]
  cdrom_ioctl+0x7d4/0x2730 [cdrom (HASH:37c3 5)]
  sr_block_ioctl+0xa8/0x110 [sr_mod (HASH:d5f2 4)]
  blkdev_ioctl+0x468/0xbf0
  __arm64_sys_ioctl+0x254/0x6d0

