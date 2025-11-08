Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C92AD04
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762596039; cv=none; b=gsIBL0HLmdAfdzKwso6tnZvgy0rhTEPh9yz4NflpwyVJrfTgxqhWJ7KbCLAyRj2yWJJpOvR0L8/iZxuO7/zHNzYRZo/WPVqer1/rTOGisUXHbb8aG1qDrnxV1pGyqTm/y1ylF4oHpu53n4iEhXFxMzhROD2xtkbEuZjWGYcA5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762596039; c=relaxed/simple;
	bh=zovWvIXTeGOZM00GW5G9wnFnWbpq9w2A9fP8s/yN0Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEvOL56/hVzuCIkA8i/611DcjkEK6AMGMxGsFx8Sbt6EL+flxOUG3peTuxNHDjC+81a5/+Rmd6DQ+3kcFSawx+RcAoNP5EveVbm5zkCp3HM84ozw4rk74WA5YYWpCMmvprMz1508/2z9DFZCjpIYQc9YOpvKW4/FbulWTJ0+2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SV7etRvJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV7etRvJ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781997d195aso986817b3a.3
        for <linux-block@vger.kernel.org>; Sat, 08 Nov 2025 02:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762596038; x=1763200838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKkpvmb/gNhZAh81SS7lxMpIqynFZoUlh3WN1RUeadA=;
        b=SV7etRvJf8D5B68he+R3tbfhXTE3tvhR6e0VZnKVKDHfWRRaKKR8lhujEaC4BMpmu/
         mDbb4Dswk6G4k+Bzr5FEaYGlzNh0mBiB3RyvP6ARm6+n9pfpdx9GBY427FZ5ngdq/sSY
         ySa/9Mq97/nsicufPQ/4PzKk1AP2+Dy2xP66jGWp71yvXYUmp82KB6PcIcZjHNmALJvk
         TmMetQZR8hkb4V9IzFxpfraevJYuktdim0HeLWsqF0XgpZYD+iu7NggT2IT4wryG9Pgu
         Q4zjQeYJji9vrVkL15D7NJjPQlGVffzTG8UjXd1u87WbrdIugnQi9GZ7v2dTKPhcpwDG
         l4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762596038; x=1763200838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKkpvmb/gNhZAh81SS7lxMpIqynFZoUlh3WN1RUeadA=;
        b=HqGBqdIu5GwtYY1WrGtEDaLwWmzl3oeSlIdjZNxnctwYgk2xaqmDw4li8d9XByHB3R
         7koK15+uT9gK7GP6ACU38bEGXcPceTY8OlE25CVPhhU43i/jiRoiQ2XprmgWgSaJnxRr
         jTUx4tMI4i67mrtFwrabXCykDy2sVnVFMhsNY5k7DIjPMbeITdNdenJWxx3ZoGNQuXW2
         izi7f23RLnY+/rw9ifbl0wo8pbAR7k3Yt5f2rmRaWla6ha6XuBVVcPNoYsyqf/WwTYEx
         3LAbAdAbJEgluphyR0HDPIefjaWD47Lmnt9ET2tJ0NYB5LDqigAvRPyyEySySucstAe0
         7KrQ==
X-Gm-Message-State: AOJu0YyXyEN9e4zYSQ1i676/RPMGyNnNX22G+PktRPlIC5/7oeS6pTPz
	evb5F8aRqDp7O1DBjiJ0u20C+KaNsw8XD6f3atVNRbHDkKAVlS0HQUHt
X-Gm-Gg: ASbGnctl/J2A3bxIMimzYhOPxJhemOg5ItUTeEJ9Jks/iu+cDCB3AzvgXcZiGDqK8Ka
	0Tpe744mNh38uWHMZbX9TqU5+kyVXDPTaGSReVT0LxPW/pkzl+uQ/o+1dwqatLpRQvnomPKr6Rd
	2vN8yu4/CkiuoyMEDmI93AeXq2xY80XlhD2Vzb7m8ZMK4gBcQ/lVFKopxKYMSNsThh+k4JQT0Vg
	paRmQCBFlFbH4KkQJ5mYJkHt7gZ0PPf0XwyXFZU2wFTM/NlEo01UtdS5MZbRPY5jlaXSQkb3GVd
	KMaRAymSYRNhiUz3pO9F1GIrK/PSVaNLVo4+9NSpclrO7166pO4luL5Bwxz60Zl6OIUUaAVvqyq
	DD7smWH5stb4DXqJRGGCScOOa5aoNHkbruyQmYzPnfngbOQmXPXEH/y+H70hOEHmfNg9FcvKn8Z
	F4bv+Ne7rvoaLyRvdIxtoFaq33D9U8RGddNHTgfOqo3bXualq6eiXl9fk/8Q==
X-Google-Smtp-Source: AGHT+IHeqVqxMetOHAbnbE/jeU7bkSaaZHhTfZXTTL7tsffypUXuVkCFrS/EZD7ccDhZsjdeCDvGeA==
X-Received: by 2002:a05:6a20:6a22:b0:33b:625:36be with SMTP id adf61e73a8af0-353a3574e00mr2761286637.38.1762596037688;
        Sat, 08 Nov 2025 02:00:37 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b2c83906e5sm960397b3a.71.2025.11.08.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 02:00:37 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: shinichiro.kawasaki@wdc.com,
	wagi@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH blktests 1/2] common/rc: add _have_kernel_options helper function
Date: Sat,  8 Nov 2025 02:00:33 -0800
Message-Id: <20251108100034.82125-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper function _have_kernel_options() that accepts multiple
kernel config options as arguments. This allows tests to check for
multiple kernel options in a single call, making the requires()
function more concise.

Example usage:
  requires() {
      _have_kernel_options IO_URING BLK_DEV_INTEGRITY
  }

Instead of:
  requires() {
      _have_kernel_option IO_URING
      _have_kernel_option BLK_DEV_INTEGRITY
  }

The function iterates through all provided options and returns failure
if any option is not enabled, maintaining the same error reporting
behavior as individual calls.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index 86bb991..545da61 100644
--- a/common/rc
+++ b/common/rc
@@ -226,6 +226,12 @@ _have_kernel_option() {
 	return 0
 }
 
+_have_kernel_options() {
+      for opt in "$@"; do
+          _have_kernel_option "$opt" || return 1
+      done
+}
+
 # Compare the version string in $1 in "a.b.c" format with "$2.$3.$4".
 # If "a.b.c" is smaller than "$2.$3.$4", return true. Otherwise, return
 # false.
-- 
2.40.0

