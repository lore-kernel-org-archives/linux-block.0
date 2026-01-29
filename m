Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1C76026
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726804; cv=none; b=s/hmiZppiQ21HpxmqMdYpBO09CLsbpk/eHFjeBluCPcmEBxGXN2tbFQGkDSrRuofw9jg/X1jotqoV+11wZGIhasLCYgMztSUX41TopiwMwCs0RGhkdwuGaK/YZPVyXhCwCt71bAZKW0dnUcOzKUBlLN96EA6uXyg0rLvy+VwmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726804; c=relaxed/simple;
	bh=CDQQ/uUyy5fr/etPRxtgn4X+g/hpuKtycBn+gkpEw0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XdxkdNpkVY17pdC/XlsWEWRTVm4VeQIOaElV6vTlgpCovlUO9H0kaw4eP/LrHONYprzOH6l/qoenJhYqcVgaCaKrKXvsqnPBKHmd7yKS4lXlvhC8LxWWSJsNk1No/LMx9QDycQ+s2eKDREM6QQdCSSd926TFpzL4E1/WaCFEAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C17sjzre; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C17sjzre"
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7cfd53bc33eso13344a34.2
        for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 14:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769726801; x=1770331601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2gne4L9kBR6zVQ7rdOIdSD6ZYDDutauCuzg5qd10yU=;
        b=C17sjzreqrSR5U/WC3PbLJUk4LyDN1ydW3Qa7ae9yRMS5lR33R4B39ZS8m/LrbDxd1
         BNX4kEVOS2jms5hJyVqKUjim9EKPOzm3+uL+kwyl7VP37eVmltJD34T4k4nRfACb9hI2
         atFzIoAnlIqE3ouwfWWsNa9jwgmpwTpRp2oVsR+hPTOF/pb0hIL2DcjC0xhuabEvYWPM
         I05+HLnaEK7gEXAXU3JX4u5lEh2NqpQMyZOb7ztoklGtt1ghLdHHWlhXwait4uA26yHR
         SLTnuC3//jiebAKdn5SeODWyIgyeks+FhtiuihTKrM4AEvVb82Y/eQ4L+e1G5P7rYmv0
         N18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726801; x=1770331601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2gne4L9kBR6zVQ7rdOIdSD6ZYDDutauCuzg5qd10yU=;
        b=FVECZYgOxN5ow68QZU1qcwiSwdxNq55/yECFf7vfhvlILf8KEHbw8JePOI1xT8E1wO
         mz56yDRJaN/OjtNbKel4C0uhnRKnFamIAmhZp1qt4dL9TzwLdJLtbobkKaYccfe6X6ad
         yJPJ/mmA4eHFEPFi6S53fn0wk5CYN8uNY+8vheQjm9Rx3HkDT2ewGBkcku2mW0DqoFTU
         /InHGvHk3BAbv3jxJdjEvs+h6rxXWlf6j2rDuZ5XC4cecPzvEQePaglC4wtOYfDkgOHP
         MIp4+37NwRPGIIk6znU8clzmiRfsirfVJoiJtSyDh+JozbLvOxWMJcHc9un5l6D9L8g4
         +aJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxtXnSWqa3q52mOqyOG1JOe+yv7lqqdq96B46WKaWV3vgK6OfgYvthFIn3O8nkIGh/ELMIrOHHu4O9jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rCFH+InPSlnxsqaBKzGTjOjF6F7HNwFYLdYLsuvsjAluICyG
	a5283I72BNq7/q7+g7APTRzqMG0OVxEHmhOaA0Uej2BibhmMYkAAP2DgFkbgv73/nY0k1tF+Uvb
	Yiq+/Jyd3V8/sE9O6UC6d6ae1ZO4VpzSrUWe3
X-Gm-Gg: AZuq6aIlr94pxUDzIce/Gd3tGRtMYikscLm//hN4VLrjGKneMTiTlGN1qm+k39iANH2
	h5gSvzB17K/d/oH0he/mxA90D8KZIVmTdRIvssC+a/VG1KC07vmcNMzntbrhP772gemIXRe10PY
	SygymHc9EBD/JjmrTejTyHfQGJD8ohFBsLUJq22gIWgcnyq3ZZgYdpZoYwO2E/XWRMtzBDQ0jlT
	KlcsIu133ikTq0WB6oulgBtnA6gAhUNpQGMOYdTScCGW9ayh7ZuRlAGKCyE0MWWumLBHDPBrcp6
	c47QjNGFa+8L7VgLPMmAq3GyMg78IFuKUUTOeaMgDEmPSP0TKtjVmtjVKA6kOIoYxmRqT3G+bGh
	IdeThji6/ei1xo4no640NOwaEZk7Uv1qjXNZypoBFDw==
X-Received: by 2002:a05:6830:3155:b0:7cf:e1c4:acea with SMTP id 46e09a7af769-7d1a5369cd9mr568227a34.5.1769726801510;
        Thu, 29 Jan 2026 14:46:41 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-40957568772sm625954fac.19.2026.01.29.14.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 14:46:41 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 261F6340603;
	Thu, 29 Jan 2026 15:46:41 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 0AB32E40456; Thu, 29 Jan 2026 15:46:41 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/4] ublk: fix struct ublksrv_ctrl_cmd accesses
Date: Thu, 29 Jan 2026 15:46:13 -0700
Message-ID: <20260129224618.975401-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ublksrv_ctrl_cmd is part of the io_uring_sqe. Since commit
87213b0d847c ("ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK
issue") allowed some commands to be handled in the non-blocking issue,
the SQE may lie in userspace-mapped memory. Validate that the SQE size
is the expected 128 bytes before dereferencing it. Access the
ublksrv_ctrl_cmd fields with READ_ONCE(), as userspace may write to them
concurrently.

Caleb Sander Mateos (3):
  ublk: don't write to struct ublksrv_ctrl_cmd
  ublk: use READ_ONCE() to read struct ublksrv_ctrl_cmd
  ublk: drop ublk_ctrl_{start,end}_recovery() header argument

Govindarajulu Varadarajan (1):
  ublk: Validate SQE128 flag before accessing the cmd

 drivers/block/ublk_drv.c | 163 +++++++++++++++++++--------------------
 1 file changed, 80 insertions(+), 83 deletions(-)

-- 
2.45.2

