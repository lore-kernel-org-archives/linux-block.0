Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884BE39FF3
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817106; cv=none; b=UaLFWKi8/EMr3y6Ifv2mTpi285Frx7tv0xZvsZKYJLMKxfpxg+EGU28W/+OQ9YIN6BkKaKHHfdamuGywfE1c0uZSk7JdoJQdHWsc8TYgWy51Gx64VT1Xr1Fd9hOmHsKYGnSvh1lLqWIoUEr9lq6vLzDTu5fnCr9QBrs5AQpTAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817106; c=relaxed/simple;
	bh=w9zO/AJqmVvvTYN4ypHe/MnJ5awvf3kGxTDSyriqxms=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dW1leDtbyx3RlCoexxZ7FhQsjg54XkBVY3TAwfZ3fWurty/KO5AO+dG1s7fGZg709jwx1q4kmJ6BgyzIdq/B5jiZyiMuuJsm6sYt70Lz1MFXS8g5JUIpFRpwGG1EfDALdxLtFVfzfoH7nF5SXMmMQsi81RfGWj2P8iOpjFQzjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIuITEkj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIuITEkj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730817103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9AxBS4AgzGj59YVTCUYvd42ihdYP8pHXV5d+NntJdng=;
	b=LIuITEkjJMFpa024Q8l+Lc7cEEI3gjsAGLFxsJkX3PX6mYTwUd3ph3JkZET1RYsCWY75fe
	V2qz9DX6toevW9NzNNh7HYTIXeL0X9I2DeD2u8FF5JT6/81cA33KIePoz1yWJIwq2un8zT
	bOv3M/gulXV+U0NFDwFNAQ4dh+YpYJI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-M7xpihXJPD65r41kChs_oQ-1; Tue, 05 Nov 2024 09:31:41 -0500
X-MC-Unique: M7xpihXJPD65r41kChs_oQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fb56e144abso27682881fa.0
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2024 06:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730817099; x=1731421899;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9AxBS4AgzGj59YVTCUYvd42ihdYP8pHXV5d+NntJdng=;
        b=QtH8JPM6QloKljNIcekBIz4/ChE0avwsLwKhyd4oqCCCsPbAIQ/QMexVLlOpU/BtJj
         FKKEKJWzh5YbLqBpa+KCrxKtlCsjJb2joZ4o+syv+G/vb7YPvbhDPm3LZ9Wa4smJAOUt
         97TJpzF7EQaOIkTVXgkduEMyC8h507g+lyWgFEYs/4twzFQ3VY2syGljid2Q3tVyVdcN
         GXF5NkW3Piy+Nd81xxopIprgoLGmz1qWdf5hEEQtPeTMEm6+8Iur2PdMnfgc1LCRY4v+
         XFN6BL5oyWwhft9wjkcwk0jVecr2qVU6Ka4EIiiqMF8Wn9yv5gHjiYrwefwy/8Yny0Cx
         UA+w==
X-Gm-Message-State: AOJu0YxHY7KYOdSYI/ZH+g3gHKceaobzuGTs59tSXBqlPJyFDc1FlgOy
	u+JK1pFSRroX7qpK4UUsy28POVWsaoiR4WDCjz1dTS/vjyZlWCnOKZUcALuKBzqv2Vm6if+Bwv1
	pX3u3Z++QAODI+bA4b81W3wNOb2yh2fzvhJywAEoqio3RdIu+UDH2EgoDi9Ghwb/eQNDFzNusLN
	+lHNwrIZbkTrF3nlq4bawRuJuQKxFVG6Vo+0Wyw30hDpMIRwJl
X-Received: by 2002:a2e:a0cd:0:b0:2f7:4c9d:7a83 with SMTP id 38308e7fff4ca-2fcbe078a64mr140014891fa.40.1730817098757;
        Tue, 05 Nov 2024 06:31:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBMMD9kyToQ1azdoNbQU4z56w4HwHj2/Pa9kptejonb2KaCEb1LctswZitYWOOMCk+y+/R1Hi6xo+/Gc7uR2w=
X-Received: by 2002:a2e:a0cd:0:b0:2f7:4c9d:7a83 with SMTP id
 38308e7fff4ca-2fcbe078a64mr140014721fa.40.1730817098328; Tue, 05 Nov 2024
 06:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 5 Nov 2024 22:31:26 +0800
Message-ID: <CAHj4cs9yHr_ONWJ6NaSH4=0yNjqWUV8PVYsk7RiKQ5c5fsUVmw@mail.gmail.com>
Subject: [bug report] most blktests nvme/ failed on the latest linux-block/for-next
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

Hi
CKI reported this new failure on the latest linux-block/for-next,
please help check it and let me know if you need any info/test for it.

b872afe6c5f2 (HEAD -> for-next, origin/for-next) Merge branch
'for-6.13/io_uring' into for-next

# ./check nvme/004
nvme/004 (tr=loop) (test nvme and nvmet UUID NS descriptors) [failed]
    runtime  0.686s  ...  0.677s
    --- tests/nvme/004.out 2024-11-05 09:06:01.282151811 -0500
    +++ /root/blktests/results/nodev_tr_loop/nvme/004.out.bad
2024-11-05 09:26:01.244341975 -0500
    @@ -1,3 +1,4 @@
     Running nvme/004
    +No namespaces found
     disconnected 1 controller(s)
     Test complete
# ./check nvme/008
nvme/008 (tr=loop bd=device) (create an NVMeOF host)         [failed]
    runtime    ...  0.682s
    --- tests/nvme/008.out 2024-11-05 09:06:01.283151898 -0500
    +++ /root/blktests/results/nodev_tr_loop_bd_device/nvme/008.out.bad
2024-11-05 09:27:07.886096187 -0500
    @@ -1,3 +1,4 @@
     Running nvme/008
    +No namespaces found
     disconnected 1 controller(s)
     Test complete
nvme/008 (tr=loop bd=file) (create an NVMeOF host)           [failed]
    runtime    ...  0.660s
    --- tests/nvme/008.out 2024-11-05 09:06:01.283151898 -0500
    +++ /root/blktests/results/nodev_tr_loop_bd_file/nvme/008.out.bad
2024-11-05 09:27:08.984191003 -0500
    @@ -1,3 +1,4 @@
     Running nvme/008
    +No namespaces found
     disconnected 1 controller(s)
     Test complete

dmesg:
[ 1291.643684] loop: module loaded
[ 1291.664637] run blktests nvme/004 at 2024-11-05 09:26:00
[ 1291.700419] loop0: detected capacity change from 0 to 2097152
[ 1291.709104] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1291.749398] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1291.749673] nvme nvme0: creating 48 I/O queues.
[ 1291.756499] nvme nvme0: new ctrl: "blktests-subsystem-1"
[ 1291.805460] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 1292.536602] Key type psk unregistered
[ 1358.244570] Key type psk registered
[ 1358.279580] loop: module loaded
[ 1358.297947] run blktests nvme/008 at 2024-11-05 09:27:07
[ 1358.330793] loop0: detected capacity change from 0 to 2097152
[ 1358.337292] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1358.374101] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1358.374488] nvme nvme0: creating 48 I/O queues.
[ 1358.382225] nvme nvme0: new ctrl: "blktests-subsystem-1"
[ 1358.428686] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 1359.185821] Key type psk unregistered
[ 1359.369213] Key type psk registered
[ 1359.415584] run blktests nvme/008 at 2024-11-05 09:27:08
[ 1359.453797] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1359.492642] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1359.493086] nvme nvme0: creating 48 I/O queues.
[ 1359.500671] nvme nvme0: new ctrl: "blktests-subsystem-1"
[ 1359.556630] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"



-- 
Best Regards,
  Yi Zhang

