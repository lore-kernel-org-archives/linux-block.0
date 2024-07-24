Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1A15AD9C
	for <linux-block@vger.kernel.org>; Wed, 24 Jul 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836350; cv=none; b=BENWkqBCmePzmrZaCLtH1FKpM0LOfGzcxWRBNg6JWISP0oQRn0ymADoWCH0IfJPXNlL68wpGxi+1nXIY5jfWnBTKUmrzaR31HdDpqQyMXTsUJVaN1aR1DGdqD2QGRzzlqxAKBXomEQW2MtpTAfWHBh2dvcPbpXdZYxWTDK0ao8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836350; c=relaxed/simple;
	bh=oXMqqEMsp7x6I81WLvLtP2quemWBXDJ7W25gdHeZR0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nNEf5EXdFY7GWxg0hIrUTuH9xPNcS6PE6ZEV9w1vRMBl3yvmLn1GHZpqHezQjk9DCVBOD4EOny5738g12fpwwgBrV7gSrbIeJkWoR/rfWHB6jaSKjQ7dA0OlpR0uoP44izQKOIxK26issPbmA7pTek/uHNseifc4gY0+Onzdp/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gI3Otiie; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gI3Otiie"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d1b5f32065so465420b6e.2
        for <linux-block@vger.kernel.org>; Wed, 24 Jul 2024 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721836347; x=1722441147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAmsfTYGo9xEd+QujFq7log30ZoAgL/wsP5rT8JJE4M=;
        b=gI3OtiieQMji9GkQ6PTXU5mexiwnyR/bvLMCVauUilga2AXbluGbeRQsBP8kiWxU9B
         rxITbdpeh6XLdEN9TNDfJ8G/TfeoMGVnYkrMfqTpEBIKsrim6nGSOc/KgNonsJW81mZq
         Tn3tj/ZHhPd4mz6BSrqnUvh5uA8+UoELqmUhY7TSyoT6yY1OH/daEDG2Kh9xS++aqfPN
         mzHymXIFonsRrlvHA6/e7UebnGSouhzeomXqxpKmaWBWvspptPiqRU6HJ3GmklcFsiCq
         7+XtHEk4iT+/YlHTPkHbThEohQ4PtmmsNH2EVXPv7FimDD292+M0T0t3yrBNBAoKx/i+
         m2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721836347; x=1722441147;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAmsfTYGo9xEd+QujFq7log30ZoAgL/wsP5rT8JJE4M=;
        b=SOKmS/YOvZLGW9beiqGHcrEnSHmc7+jzHyWUzi1O2A4LQlaO+9mbmlW9qtLd6GpW2t
         3yRza6OsJ6jxmgk9EMZuYFPYt4pw3NbHHzg952R70EVXtx/Fkes2VU3hUbYJHgMxydP0
         Uy41ppRgYbbcecxKFv9vHSTePKHx7x18CnaC7phjN36bWcLwJcwukIHCOysJUmNQO6w7
         ffafcYMutZ1PjgM9FQYterjSGM+E8jnnS+uxh60XNHPVy0iA0fUIU07d5YOH3vIcxjaa
         x0A0Hj+W3CLR8I8dqex2Iz5IbRY3zyKBcFCwBFEg5teVwulsjZNY1gVj+cV7BQkYMfIP
         +wdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWxIAtxLage4SOOxNiuC+xeokYX236EideBb8t0kwCBSke1Vx1zy+YtZdAm7m8RTrKEakGsqBeB9h2mA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7oicedu8DkmL6ELWDdeXHKfK/7NOM0rrJwemxv+TUNvclCNB
	qdtRBcaoRrYUYhOUGtnMV6FUPjccUb6MtQpnyzIcE/GNOW1In6DF8ooA5dfQJuw=
X-Google-Smtp-Source: AGHT+IH6SCZaNq+dyWbt5LIPpeO2KaUalwBo6MwokyQ5WTepABhxT4QS12zYfcnK4UpgXeQAtdHBaQ==
X-Received: by 2002:a05:6830:1104:b0:703:5c2d:6d30 with SMTP id 46e09a7af769-7092e5b37f7mr112366a34.0.1721836347384;
        Wed, 24 Jul 2024 08:52:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60bf24csm2463281a34.18.2024.07.24.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:52:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Yang <yang.yang@vivo.com>
Cc: stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>, 
 Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240724070412.22521-1-yang.yang@vivo.com>
References: <20240724070412.22521-1-yang.yang@vivo.com>
Subject: Re: [PATCH v3] block: fix deadlock between sd_remove & sd_release
Message-Id: <172183634626.7375.12424397192746760093.b4-ty@kernel.dk>
Date: Wed, 24 Jul 2024 09:52:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 24 Jul 2024 15:04:12 +0800, Yang Yang wrote:
> Our test report the following hung task:
> 
> [ 2538.459400] INFO: task "kworker/0:0":7 blocked for more than 188 seconds.
> [ 2538.459427] Call trace:
> [ 2538.459430]  __switch_to+0x174/0x338
> [ 2538.459436]  __schedule+0x628/0x9c4
> [ 2538.459442]  schedule+0x7c/0xe8
> [ 2538.459447]  schedule_preempt_disabled+0x24/0x40
> [ 2538.459453]  __mutex_lock+0x3ec/0xf04
> [ 2538.459456]  __mutex_lock_slowpath+0x14/0x24
> [ 2538.459459]  mutex_lock+0x30/0xd8
> [ 2538.459462]  del_gendisk+0xdc/0x350
> [ 2538.459466]  sd_remove+0x30/0x60
> [ 2538.459470]  device_release_driver_internal+0x1c4/0x2c4
> [ 2538.459474]  device_release_driver+0x18/0x28
> [ 2538.459478]  bus_remove_device+0x15c/0x174
> [ 2538.459483]  device_del+0x1d0/0x358
> [ 2538.459488]  __scsi_remove_device+0xa8/0x198
> [ 2538.459493]  scsi_forget_host+0x50/0x70
> [ 2538.459497]  scsi_remove_host+0x80/0x180
> [ 2538.459502]  usb_stor_disconnect+0x68/0xf4
> [ 2538.459506]  usb_unbind_interface+0xd4/0x280
> [ 2538.459510]  device_release_driver_internal+0x1c4/0x2c4
> [ 2538.459514]  device_release_driver+0x18/0x28
> [ 2538.459518]  bus_remove_device+0x15c/0x174
> [ 2538.459523]  device_del+0x1d0/0x358
> [ 2538.459528]  usb_disable_device+0x84/0x194
> [ 2538.459532]  usb_disconnect+0xec/0x300
> [ 2538.459537]  hub_event+0xb80/0x1870
> [ 2538.459541]  process_scheduled_works+0x248/0x4dc
> [ 2538.459545]  worker_thread+0x244/0x334
> [ 2538.459549]  kthread+0x114/0x1bc
> 
> [...]

Applied, thanks!

[1/1] block: fix deadlock between sd_remove & sd_release
      commit: 7e04da2dc7013af50ed3a2beb698d5168d1e594b

Best regards,
-- 
Jens Axboe



