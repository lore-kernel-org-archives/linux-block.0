Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B813A19DF61
	for <linux-block@vger.kernel.org>; Fri,  7 Feb 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957852; cv=none; b=ulI1DgYOtlvnhHEUIGze6jKXcS0/rfGFiuCiTx5dDZBYAhDxgusPLRCqiiEkpmraXol0kxOQ3a/Q+quhokt/EW/k4+8HTsRXYEFBlNufL+Wvs9leHhMxoFSs94txci85A/DjF+xTA8NI7fgUBt0Z61q5m8/SmHt3k08O8zViJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957852; c=relaxed/simple;
	bh=HjMz/oZxr/oavrLXJUtFQZGJEwj9Xw1FBmTX58qKwCI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LyW+rgr3mQ4dV6+a/Cw44vMrE9+QhR91bxcXVII5EoW9CgS2dBbwSRdX6kAofjux0bzQoftadf/DqwhFnQbhsAuVgRfiUQKqkFbovjpnkE0e0Cv2x3j8/h24pO4XwcZlaRvt/x8iuDJQhuST0LxQbWCOsTNAZ7t6PAinIOlgsrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iwTcgQP2; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iwTcgQP2"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467b74a1754so32061871cf.1
        for <linux-block@vger.kernel.org>; Fri, 07 Feb 2025 11:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738957849; x=1739562649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HjMz/oZxr/oavrLXJUtFQZGJEwj9Xw1FBmTX58qKwCI=;
        b=iwTcgQP2LVWeiC/8j/QoOTQsOA9qmA1Y5Terk+nYEexDq1iYrJxb5DCh16B+b8kkiC
         yuqfv8PBuzwxechs9Eh8eNWQQbKMBJIpNB/aOv2JfbJndIVXIvWwwFwM9oKfecoPZKvS
         sAARhy5vHVWOlQ1AimH+zJ46OIfT+ta7QSrZDM7r3/DgmRc1TN59gPxHWzvhmkPp8NVh
         4iqcpglQvy9atKQiguAlDp2iHegZywFpAknigzlFnkxXApKJYc+QP8XuWVPdZ8lx8UCy
         qOoUs6NjAtCxvRv01AirRSkSh4z2G7i+gyHLo7NLjKfhx42J3pN5E06j8iGqNl6BGX0u
         7O5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738957849; x=1739562649;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjMz/oZxr/oavrLXJUtFQZGJEwj9Xw1FBmTX58qKwCI=;
        b=cJVgz+XoXXHmn2FRqYzMpR7mo6sm+bwbaEpW8mfU0jWkHx7BQJxXIG/VrYOvGcS6RX
         ifSTn992TvhHpJ/8h8mAJd/k/eYjX9K4GMPQ+RoYu28LfKjknfFfR9gDcODpR0KHTXWx
         vo+g4Yb1PS2aP3SEExZPErv9BoeBI9blOwqPncIFmOxgW2WhtgtVNVY/fMhAq8KKadav
         XvbOVf9kNWt9ssS1nBWDc6DvgLct3itqdh/xf/j0VSQ+F/2UcoDlzwOFrlIkuInvCYJS
         TTH0uDQDzaug+jaZ/jh0RPQM6a/WnyRwlbqL6Yx300z+XxjiRIqZ7cbMbcZwL7z2H0YT
         1qOg==
X-Gm-Message-State: AOJu0YyGwMwlDWuEJtXolKQrNT1tz6mEToW5UKnLsECexcy9fpSvDOnA
	IyjAB6YqrEsz4mOabXmBI6e3QoR8S0BsOIQmkbse5tYeBKBdVNlsCfwd+c7axJs41pLIYH3lrMC
	nAWEie/GzqDNOyXuiWVA+5Je+etwR4yPSIoOKg2WubT8rJKd7AVzB
X-Gm-Gg: ASbGncsDAw+HQZsaRZiJG8BpPR4FK/5zJW846JPF0FC2t7K+Ie2E8LQyI+QvSbi+zH/
	VMepHEayHGHJzTV6I/1/r6CQtQ7JBX7aWV0yawjMVkYUYeNjxHhVo74zEVPD2kWHuhekLJGSVEd
	E5ff/bZuzxoNTyi1Wi1OIE6txf
X-Google-Smtp-Source: AGHT+IEW6lJAaGR6UWt/6KiZcKeVAIGgUpqhqKQP/UZTezdExqAxaxaq9AZugHqja9rSEBO+2VbUUgG7J7tReSTkABw=
X-Received: by 2002:a05:622a:5918:b0:464:af64:a90a with SMTP id
 d75a77b69052e-47167a37083mr77646341cf.23.1738957849471; Fri, 07 Feb 2025
 11:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matthew Broomfield <mattysweeps@google.com>
Date: Fri, 7 Feb 2025 11:50:33 -0800
X-Gm-Features: AWEUYZnA8CbMj74K-1c8qbjgoMwUoBJisd3Dc6wpwU7UpAA77Bvb4Oj7_5phJyg
Message-ID: <CALEiSPxGXy5faNFiiPt_tOF=K2cS=02RVdjw1JGuokNV7JPHJw@mail.gmail.com>
Subject: ublk: expose ublk device info in sysfs or support ioctls on ublk-control
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

It would be great if there was a sysfs file which exposed "struct
ublksrv_ctrl_dev_info" so programs written in languages without
io_uring libraries (such as python) could easily read this information
for management, testing, or record keeping. Ideally if possible this
could be something like "/sys/block/ublkbX/ublk_info". Is this
possible?

Alternatively, the "/dev/ublk-control" file could support ioctls which
mimic the io_uring cmds such as UBLK_CMD_GET_DEV_INFO,
UBLK_CMD_ADD_DEV, etc. This would be more powerful as the block device
lifecycle management program could be completely independent of both
io_uring and the program which handles the block IO. However I'm
skeptical it's worth it in the long run to create a ioctl -> io_uring
adapter. (As opposed to languages natively supporting io_uring)

Thank you,
-Matthew Broomfield
