Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B432286A1;
	Mon, 12 May 2025 02:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747018184; cv=none; b=gLxusDKPu2m3HfqT35Bh8zRqQjdd+Ey6OAiEuEQnWo3tk2/U2tX33pLlXD25ZhGXGe8hfZm566gCEysOOUFdvZkCCGdqsW/4/oIEyhjeL+gVnEw5nA22Z1lEipwEwRBThZVM/9Lq+q36qI4U8tqOxV/JPxqlIufr6XgWzhN46fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747018184; c=relaxed/simple;
	bh=mwDaVLJo43XMRzWtd8E6mvuH9PdZzsSVzcw3BctI6JY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e1T3C8Lu1IOzPcrHmFo59HsUSNfEFB/0RIxrS5i8krpFh04de0oXY8VoQfYItHijyp94fCl0NqvL15NlXJabs/PbXTUms8T+X8cd5L91ASe6+XEDxjCOS2XoS2LH+FTnQzEyLOhOJiEkusBGlgguWiPIUk39kB6vJF2sxi2vwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHLSfwh2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHLSfwh2"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30a89c31ae7so5211619a91.2;
        Sun, 11 May 2025 19:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747018182; x=1747622982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOVCqhCb2rhEzHvQ465eix34/9MV0t+iGj2FJ15KRTk=;
        b=QHLSfwh2p4IAim+5Ks3p4yfHSsrHmk9z/pHgh/MozMVboOLLL3nfBtPC6vwUx6BzU/
         d5Pw1BlQRo/uPtMdJ91eWFZ2B1MC/+QM1SV4UlM+b10YW1roiPBElCBSuUfre6E7Dky/
         bouqKnReCscAYx45YEeVkKTCyvAJNOVlhem6SHRhOS9RfWjhvsVVqdBaNLUg+/FOSs0k
         eSoBnHj0qIPwjvvBJQUwC2rQVfyGfTXeh1cGrN5PubyaEg3oP3dhX+tVUipStunEVxap
         lUI0t1vDvFL46AmWM6pxykWAl6l2TcxEeRjq6BNubhRHpW67fVBx5ycSjozNIca6UcGm
         gL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747018182; x=1747622982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOVCqhCb2rhEzHvQ465eix34/9MV0t+iGj2FJ15KRTk=;
        b=rKxwUMJgCkVopMhyrwfjQl9gd3M1c5YieH289akFgji6DQQ73F1gvm3N/rCDJigOLP
         zSGqNY0a8uFH1BEsug42+iVbHE89JTL3WJb4UimbqR5F2AtaWhcW6AYh/mqMOGfckCvG
         VO01UgsiwWq8pYgan13jazaQA2WGBYQf0v/7mjV6OISCweZMonkyoNi9INHy9dtgY9Ia
         shsKRzNNrFI7L0LVECDS7CBth2iwq4x/JWHCS8A8VRUwR1LzWYvr+PIkB3eCpQIIeO8e
         VvBoDmpOD4hSpx5Y/gm0DQWtsLgTxvT6PBdv8DdigTpu01ua0wjeTxylV9NnNuim3Yx/
         2K4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtuhKaio+F3lL8jibjR4dJpi6VhfddkRfHVo9mYDcjlXnmSrljknrrhRlShydpBjlLsCQl3lNo3QujIA==@vger.kernel.org, AJvYcCXEwggeaYQxjWaaGwfSB0lo8iodFj3+EE2lpOuNxGBvfCxw2HjSEW+R/KOOVSkowH5zzwuAJOB+wTLvEHlxAf0Sp8tB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Hu8fhxk8H0d5ln7gAjSgNTVX8lkAhp2sR4rZwDWCOEHDfRZI
	V7tY6g1jg71MeWF/9DkAawWe46l6QeeJeVb83lSaxlNiSIkmiEWOsDlIOgI6
X-Gm-Gg: ASbGncs+kouvgVD31V2KgFE4istsA2BsSBtgK5CsapDNJvqgYhurM6B2W2bfzmtXSsH
	ft3aqIbUangItXleXz8JuFgVDCeK6zwG0InQ5qsbtUddJm2Lh20R38mVLR0AH7bUeVezFlPlJ+j
	PIV90ETD7kIsTS3AR7DwrD/7bUZiPJefEQMBNUUyjRlKUZXp50HqpdzGGhXpZ/RY6Y7xGZVRXSk
	YH8zq4ydHsUdQpftbSgBeklvcXsOP+iZg81u/rp3SiHT5kgkuX2IEi8ZdC9Tz2fkRQhgp+UPmF5
	55AkveW33KK9cTa3gcHHWU0aZO9ZK71XSvygxnYBsdZGySTSU8VPL3Q+PAM5xunnPIPMd5C4QIG
	Cg1Lcj4goFet4+0zMTMcr7jM=
X-Google-Smtp-Source: AGHT+IFZt6ExJpgBrtXPpabu/brET+rV4uesYHpgrf7bict2XP9UfZjBmjmHwm86BIXgSqze/T1M3w==
X-Received: by 2002:a17:90a:c10b:b0:30c:540b:99e with SMTP id 98e67ed59e1d1-30c540b09e7mr11260942a91.13.1747018182233;
        Sun, 11 May 2025 19:49:42 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234af2c287sm3938761a12.41.2025.05.11.19.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 19:49:41 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v1 0/5] relayfs: misc changes
Date: Mon, 12 May 2025 10:49:30 +0800
Message-Id: <20250512024935.64704-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The series mostly focuss on the error counters which helps every user
debug their own kernel module. More patches making the relayfs more
robust and functional are around the corner :)

---
Note: this series is made on top of this unmerged commit[1]
[1]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxing@gmail.com/

Jason Xing (5):
  relayfs: support a counter tracking if per-cpu buffers is full
  relayfs: introduce dump of relayfs statistics function
  blktrace: use rbuf->stats.full as a drop indicator in relayfs
  relayfs: support a counter tracking if data is too big to write
  relayfs: uniformally use possible cpu iteration

 include/linux/relay.h   | 22 ++++++++++++++-
 kernel/relay.c          | 62 +++++++++++++++++++++++++++++++++++------
 kernel/trace/blktrace.c | 23 ++-------------
 3 files changed, 76 insertions(+), 31 deletions(-)

-- 
2.43.5

