Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFED143754
	for <linux-block@vger.kernel.org>; Thu, 16 May 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855076; cv=none; b=VhNXnfo9uP2Sv6lyvxYfj2GEKZI2iJlvMMrt2aKTqCJzyYlo6aQWkkyK/mRqitKdh8xDCE2mM0segr1sJLvp1sCaS9V8aqwQAkJLoPZAfMxoj8kNhKYGdUg5EyqC+mDLp2W5PLk0B/LMoQ9cNCUR+75bSpmKfoma/q0WXUUAwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855076; c=relaxed/simple;
	bh=RD5V8RDqSXMjEA4r5LxWJNOC5YV+4x6Px2Tot5ucipM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NDXm42+NfY0bld95/mfV4+zSf+Rd8MWf60y/vbl/HvphU/fISMgIdruiXfuHORwo4Rjm9j9YZ+bN3YIHn81S16+Zf3L4ZRVh0P5coUBjTT1oy9eV4TnhKmkKSVL1HTEVnFfKCnfdkuyikDutOoFp3+lwQIX3P52jhBxScW/eHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmLXK+7o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmLXK+7o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715855073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Nr+LPyuu6SL/cao/iNcCYGOTg07ixNojYqLNQvdHjk4=;
	b=QmLXK+7oo25Zwg3PS16Q/CTpJCEpfHgpgdK3HPy0ajxijik96wSrHVsPiAlZGjU0DrZHzc
	cfqdCtcqi1J1GX2OIu2xKa53yE6oHk2cuy3KaOEIwwfDIRDJbih/1kcErq27RuHHDoeqmQ
	+EeNubz02Hfgeivtzg+i4+6LsPWN2t4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-ndPO_agmPQuSDslw86o-hQ-1; Thu, 16 May 2024 06:24:32 -0400
X-MC-Unique: ndPO_agmPQuSDslw86o-hQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b38f3e2919so6892453a91.0
        for <linux-block@vger.kernel.org>; Thu, 16 May 2024 03:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715855070; x=1716459870;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nr+LPyuu6SL/cao/iNcCYGOTg07ixNojYqLNQvdHjk4=;
        b=Fx8qGQOJSXgd+hqszPa6tcxfOPJv/0tGxz7D5z6AspnslhtqR9lWQrzPrlQv0Nqk2P
         uIno/HvBOIYjuBkxzoh4O+T8KhOhgAS5GK/UbtWM8kEGbA5RB0Zp9697DGtmFaIdzqnj
         nnb9HUtOx9KO0CcXI8nI34P8QIAN5c5YniefMOGFPh0jlvZYSpfyG4TRuopr8IWTJmgb
         jZCizI5dq1ErFIChf5kslu6pGOP66H+7w4ZWx8XQWJWfcb3Zqh+ms5J/Eh3giiWtqi+O
         Oe0rtX9gSZCX0VH21NYa27ICUebbYaxg1032beqC+NHvqC/OipjbZ3eYU43j0aYSzRQC
         UbcA==
X-Gm-Message-State: AOJu0YyKEqWROld+tk3wDOg7qK8Ec1iNrvs2MlGJcfSc/exuH2nQ8KiL
	0ayFeK56R515skZmnsziPnJHiBpQ5E0Rv4Pt7qEnyZSm4uU8zIHLAqsFW5eUu+LVdz7mE0Z4H/9
	54AS2p6tnP00DZjf4QFcl3ASzDiBwGYtouT4o8kPBFH31N0AZDvhr1KVuoy0gUomQHNXgEM4Vuq
	UT5HpqKHZvg6xZhbnvEVKnvNSgzOt7oYUdQTo6GGmRp7OF54Ea
X-Received: by 2002:a17:90a:aa12:b0:2b4:1396:6d3d with SMTP id 98e67ed59e1d1-2b6c710ff79mr28106139a91.11.1715855070508;
        Thu, 16 May 2024 03:24:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE156kxGHBZXo2mQdO38dEkWwvoo3mSpi8nxsMdwuE9G0U2IKm8xL5hPdSjbkStfKz+scOEqk3sZKzCgzQEfzc=
X-Received: by 2002:a17:90a:aa12:b0:2b4:1396:6d3d with SMTP id
 98e67ed59e1d1-2b6c710ff79mr28106114a91.11.1715855070039; Thu, 16 May 2024
 03:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Thu, 16 May 2024 18:24:18 +0800
Message-ID: <CAGVVp+Xsmzy2G9YuEatfMT6qv1M--YdOCQ0g7z7OVmcTbBxQAg@mail.gmail.com>
Subject: [bug report] INFO: task mdX_resync:42168 blocked for more than 122 seconds
To: Linux Block Devices <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

when create lvm raid1, the command hang on for a long time.
please help check it and let me know if you need any info/testing for
it, thanks.

repo:https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
branch:for-next
commit: 59ef8180748269837975c9656b586daa16bb9def

reproducer:
dd if=/dev/zero bs=1M count=2000 of=file0.img
dd if=/dev/zero bs=1M count=2000 of=file1.img
dd if=/dev/zero bs=1M count=2000 of=file2.img
dd if=/dev/zero bs=1M count=2000 of=file4.img
losetup -fP --show file0.img
losetup -fP --show file1.img
losetup -fP --show file2.img
losetup -fP --show file3.img
pvcreate -y  /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
vgcreate  black_bird  /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
lvcreate --type raid1 -m 3 -n non_synced_primary_raid_3legs_1   -L 1G
black_bird        /dev/loop0:0-300     /dev/loop1:0-300
/dev/loop2:0-300  /dev/loop3:0-300


console log:
May 21 21:57:41 dell-per640-04 journal: Create raid1
May 21 21:57:41 dell-per640-04 kernel: device-mapper: raid:
Superblocks created for new raid set
May 21 21:57:42 dell-per640-04 kernel: md/raid1:mdX: not clean --
starting background reconstruction
May 21 21:57:42 dell-per640-04 kernel: md/raid1:mdX: active with 4 out
of 4 mirrors
May 21 21:57:42 dell-per640-04 kernel: mdX: bitmap file is out of
date, doing full recovery
May 21 21:57:42 dell-per640-04 kernel: md: resync of RAID array mdX
May 21 21:57:42 dell-per640-04 systemd[1]: Started Device-mapper event daemon.
May 21 21:57:42 dell-per640-04 dmeventd[42170]: dmeventd ready for processing.
May 21 21:57:42 dell-per640-04 dmeventd[42170]: Monitoring RAID device
black_bird-non_synced_primary_raid_3legs_1 for events.
May 21 21:57:45 dell-per640-04 restraintd[1446]: *** Current Time: Tue
May 21 21:57:45 2024  Localwatchdog at: Tue May 21 22:56:45 2024
May 21 21:58:45 dell-per640-04 restraintd[1446]: *** Current Time: Tue
May 21 21:58:45 2024  Localwatchdog at: Tue May 21 22:56:45 2024
May 21 21:59:45 dell-per640-04 restraintd[1446]: *** Current Time: Tue
May 21 21:59:45 2024  Localwatchdog at: Tue May 21 22:56:45 2024
May 21 21:59:53 dell-per640-04 kernel: INFO: task mdX_resync:42168
blocked for more than 122 seconds.
May 21 21:59:53 dell-per640-04 kernel:      Not tainted 6.9.0+ #1
May 21 21:59:53 dell-per640-04 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 21:59:53 dell-per640-04 kernel: task:mdX_resync      state:D
stack:0     pid:42168 tgid:42168 ppid:2      flags:0x00004000
May 21 21:59:53 dell-per640-04 kernel: Call Trace:
May 21 21:59:53 dell-per640-04 kernel: <TASK>
May 21 21:59:53 dell-per640-04 kernel: __schedule+0x222/0x670
May 21 21:59:53 dell-per640-04 kernel: ? blk_mq_flush_plug_list+0x5/0x20
May 21 21:59:53 dell-per640-04 kernel: schedule+0x2c/0xb0
May 21 21:59:53 dell-per640-04 kernel: raise_barrier+0x107/0x200 [raid1]
May 21 21:59:53 dell-per640-04 kernel: ?
__pfx_autoremove_wake_function+0x10/0x10
May 21 21:59:53 dell-per640-04 kernel: raid1_sync_request+0x12d/0xa50 [raid1]
May 21 21:59:53 dell-per640-04 kernel: ?
__pfx_raid1_sync_request+0x10/0x10 [raid1]
May 21 21:59:53 dell-per640-04 kernel: md_do_sync+0x660/0x1040
May 21 21:59:53 dell-per640-04 kernel: ?
__pfx_autoremove_wake_function+0x10/0x10
May 21 21:59:53 dell-per640-04 kernel: md_thread+0xad/0x160
May 21 21:59:53 dell-per640-04 kernel: ? __pfx_md_thread+0x10/0x10
May 21 21:59:53 dell-per640-04 kernel: kthread+0xdc/0x110
May 21 21:59:53 dell-per640-04 kernel: ? __pfx_kthread+0x10/0x10
May 21 21:59:53 dell-per640-04 kernel: ret_from_fork+0x2d/0x50
May 21 21:59:53 dell-per640-04 kernel: ? __pfx_kthread+0x10/0x10
May 21 21:59:53 dell-per640-04 kernel: ret_from_fork_asm+0x1a/0x30
May 21 21:59:53 dell-per640-04 kernel: </TASK>


--
Best Regards,
     Changhui

