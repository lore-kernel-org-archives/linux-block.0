Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4C13B2AF
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945776; cv=none; b=W4xns6OP5FulwlW0TZd9XcodC06RGfaEY3Jm5G67oKgJN7W1fl0mk/JV5eFee1HFwsJdr+6TvtEVdROPsLIdpkpr3gse48IB1RD7k4g4yQ8e48e19STGGZJHgvmMnp4MsOG36bloSNZBXeGQsZCixymzthGUkSCIALP0BzPFkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945776; c=relaxed/simple;
	bh=f1sF1IVv1YfneWWINvVSOX0ulNWuhoXRDXA/M762bI4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NbnZR9TbTed7IppU4n3QPMZ77ClWLBaAbphVMlL6kI/MpgqsSzX4yPLk7O91D4vrU/CnAq/2fwM6/2Yrw5phU8WbubZ8w2jRL2DTUnVQQcpJXfakE8hK3HEhELrDOFq9u76IVyRAxzTsN9WjlDFdoUhZ2Mmhv4D242Py+N+Tiv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f457DM7N; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f457DM7N"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e091682cfbso559677a91.0
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 01:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727945775; x=1728550575; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1mheCeTrWI2P4BzcBRwN1haKsBGTe9vyxDgvbLHdKc=;
        b=f457DM7NYAvoginEP1+1EGVGi/hoVS+DCUx4sXbraDN9bLqr0Vf9utF6sxsPnU1Plo
         oJaivKl7nDdUeHUpaOD5nLsdbvy6QlrnhKeG0S1IlvgnkRTPzmZrYgFn/8xMrXWjgMAF
         rF7IYXUeajbl+TxD2NiddwXTih9g3V4v98GWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945775; x=1728550575;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1mheCeTrWI2P4BzcBRwN1haKsBGTe9vyxDgvbLHdKc=;
        b=X/VOjqgL3UsBznOavcPLG360PjDhSvHA5CSf7FvrNacYGHF+CvEtLAHNxOG2OHmtuz
         MnBg4F4pWEbdcPM37IwenkszBOtVSPssKrWp9gROBMbQaiL4kkYLEls9oh3GoALKe2lr
         Eh8F9s7AVi9TWA9T5o02JLy1FAK4MYjpULgyO60QIAN/n/rSIURnUArf4Rra5BM5tGQi
         VBRRtk5DivZ1i0PxvX1BieQ8PH8181a5pRYumxOV1uE8BL7AyefbXv032W1tdw6FheWw
         pPk16axqDdt4S5+FMz/EhOgGZ3aCPxlAnbb8YjktbCaVtMb5ijhzpe+/a+ycgc0I0tdA
         XrrA==
X-Gm-Message-State: AOJu0YzZL95umCO4iyOYfC6+gBbzab/BcwScvS4CjuyH+4ioXkVk3kBB
	FanIIFYoQBWAbKzlwh2CvEsZjJQa/EKWkrz+nZlgjdJtSf8baNykGz64fnZJ9g==
X-Google-Smtp-Source: AGHT+IFzSEP2yQTZZWZZlud4vjVRFkOR13RlK0XIRIJ9ywMcdkB6lIpSwzz8iVgaRHvQxTQ8uBHjHw==
X-Received: by 2002:a17:90b:141:b0:2c9:b72:7a1f with SMTP id 98e67ed59e1d1-2e184900890mr7020268a91.28.1727945774820;
        Thu, 03 Oct 2024 01:56:14 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6c:4e9b:4272:1036])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18fa05087sm3135827a91.39.2024.10.03.01.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:56:14 -0700 (PDT)
Date: Thu, 3 Oct 2024 17:56:10 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241003085610.GK11458@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I'm looking at a report from the fleet (don't have a reproducer)
and wondering what you and block folks might think / suggest.

The problem is basically as follows

CPU0

do_syscall
 sys_close
  __fput
   blkdev_release
    blkdev_put              grabs ->open_mutex
     sr_block_release
      scsi_set_medium_removal
       ioctl_internal_command
        scsi_execute_cmd
         scsi_alloc_request
          blk_mq_alloc_request
           blk_queue_enter
            schedule

at the same time:

CPU1

usb_disconnect
 usb_disable_device
  device_del
   usb_unbind_interface
    usb_stor_disconnect
     scsi_remove_host
      scsi_forget_host
       __scsi_remove_device
        device_del
         bus_remove_device
          device_release_driver_internal
           sr_remove
            del_gendisk
             mutex_lock     attempts to grab ->open_mutex
              schedule

blk_queue_enter() sleeps forever, under ->open_mutex, there is no
way for it to be woken up and to detect blk_queue_dying().  del_gendisk()
sleeps forever because it attempts to grab ->open_mutex before it calls
__blk_mark_disk_dead(), which would mark the queue QUEUE_FLAG_DYING and
wake up ->mq_freeze_wq (which is blk_queue_enter() in this case).

I wonder how to fix it.  My current "patch" is to set QUEUE_FLAG_DYING
and "kick" ->mq_freeze_wq early on in del_gendisk(), before it attempts
to grab ->open_mutex for the first time.

Any suggestions?
