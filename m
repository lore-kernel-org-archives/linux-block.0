Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B13D6470
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120491; cv=none; b=aN6PSIssPW5OQ2xcWhIaMz0jcKQjyxENW7TgAZEnTfGcHmobrZoJnagtCjapejTH2dWBZKDgEEYdeApxbg1qcegjn0CbeEWK8Kz1JSMcche3bxgHs7IkEyhmDluJ4RDIUBr7BxMZYgbJ9W7LPMwZFbN9hDNO4P4RktzS4YXoEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120491; c=relaxed/simple;
	bh=73LC2pC5CX8V1OVYDzrlgGpHDCLk6stJa9pX2mrIQi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ibNIuwImqMFkZNEwXkqHVD+lvMilb7GqMKMuTxiK6cKsWubenMJu+ty1uwNXB8tooo2hpNfroof8tdrV53Ayg4gZgwy8T3XK9vjxputI4kSjEunldpTHyQf9/xU2mcu5VcjoJ4GoWpLlo3QWxxgCeItqSPZRkXP2ZoLH1M1Ti68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1qikbDOq; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1qikbDOq"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d18a9d2b1aso1040671a34.2
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 07:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772120488; x=1772725288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lcgSH6BIx1z+qenksgSCQPSRkHipodAz9c6UCb+DJg=;
        b=1qikbDOqVHOg3bPJq8TWoWiH9kZOwWx6uKQ9ReaXyy4tSI5QPlY8lp/tbvCkxChTYc
         LMmpVHdS4uRyNdf8r0koaCeG/OkJREP3YJKwgWlaMdfLZRglDUoV89jjKPqVtgfL9L+U
         dQo5CM7t9l0NTnxfrIEkdIZV7TYZKOEfNbwey3NyAV/RXv+6VN2hJXGzB1nPJBhWcs5Z
         TIgyL85vD0p3aCN/QdzpiXpmppdjC2IEjJkA+B0SeIrQA6sUBmt7HDNWr0tBBpHnQ55O
         2jQdpghU2M0gsTkhvyDm9EdE6dexjp7MLhHArzhtEyCRG6AAPQzgCWad5D+TyP/EnHvB
         c2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772120488; x=1772725288;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6lcgSH6BIx1z+qenksgSCQPSRkHipodAz9c6UCb+DJg=;
        b=FjrIsEjKHuWVN/1diGvFYiNBlF/sADI9FWXkZLn48X41rQ3AqoRABXzpR8VSzuDjZ/
         15AkSg6eYUr6BdvdGur5UGTqD7FaOF1LxCGyBGpMx6MCP6DRut1D/0QN3oENE5pM2eKE
         cJ/ouk8RXetDtHk2DJQPF7FQgmJXYtnBz6KcTN590FL4oeLy7DZOQBLKLqdt0dWrBctl
         UHPv8jbVgIxmL3QxUyWPrMGFrKRYdO6SE8XEryaWbmBzi4Cg3q5S7EqURnsUNwdrXrYS
         5wZpd1nVjY9Yr+OvqAZAcRyD2MeDyMqfNvwOzFfTpr85/H9YwHjPt4tSihXgaeJwRpTL
         2gSg==
X-Gm-Message-State: AOJu0Yw02O8Wq4uw/ROICweU2fLVdwvTtrwWAYRqSqYql7h/U2WT+8Y5
	YhwuxQiW5yF6ZAnaVJEWSp7EIwnDN4iCe2I/q8RFQw8/9wS0HijjmAsC0xhOAwgfvp8g18ECf45
	rN9dyndw=
X-Gm-Gg: ATEYQzwxMJgGNCUdKN+yP4SHWY1N7aM3lul0E7YdkkoOLqweMnX0Q5C5s5x4U5j4f+7
	Mg5JRM1Koie/uF4YnwhtI13JdxDZK2ao4p1ZpBNxf2NwaGAHuPuID7x4xZq+HNcfXHy8Uk6tHFg
	OvFCLxHC78LUdvNurLl3XROqUVFXW5J59J01CwH7Vy+l9GZ0ZpHzKBNPUBDl2jSolcQKy19LZrk
	S/VNsRrS9drJiP0foe87kNKgL4m6e1ifZsYptCx8U+F4piQgVXU8qO3paWQBEXXMwHn0j2QC1Oy
	QUGDPxgnh3m47dK4CGtlLKwlv6L4ONLG9pskKpV7zqWH6h5PrQiWfxtHID96dqsjnQZMNTnjNuE
	Vrvrm6grpE3kCr7m1W77M8NxhS+16JEU+/o23cVPECmb9+Li9a/igFTykkJ2vsncN3yhCvcBoxc
	gaScvaa+kfAYrpQSK2scRwEHpdIA05n1CgIxAav1303rpJWSmsMhz4kNfJH5fWsZe2xWCUAcw9W
	ynngwZjw2t5JYM=
X-Received: by 2002:a05:6830:82e1:b0:7d5:1101:9196 with SMTP id 46e09a7af769-7d52bdf7653mr13276500a34.6.1772120488091;
        Thu, 26 Feb 2026 07:41:28 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626869sm1978963a34.16.2026.02.26.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:41:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ondrej Kozina <okozina@redhat.com>
Cc: gmazyland@gmail.com, jonathan.derrick@linux.dev, gjoyce@ibm.com, 
 hare@suse.de
In-Reply-To: <20260206141804.278721-1-okozina@redhat.com>
References: <20260205150935.238137-1-okozina@redhat.com>
 <20260206141804.278721-1-okozina@redhat.com>
Subject: Re: [PATCH v3 0/9] Extend Single User Mode (SUM) support in
 sed-opal.
Message-Id: <177212048698.990177.1302244716721420868.b4-ty@kernel.dk>
Date: Thu, 26 Feb 2026 08:41:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 06 Feb 2026 15:17:54 +0100, Ondrej Kozina wrote:
> This patch series extends support for TCG Storage Opal SSC Single User
> Mode (SUM) in the sed-opal kernel interface. SUM addresses few
> shortcomins described in the chapter 2 of the OPAL2 sepecification
> extension (see below). It better isolates Admin authority from User
> stored data by taking the Lock/Unlock/Enable/Disable privileges from
> Admin when managing Locking Ranges configured for SUM.
> 
> [...]

Applied, thanks!

[1/9] sed-opal: add UID of Locking Table.
      commit: 985977af2390d5055ae30f9f56846b74dbe16311
[2/9] sed-opal: add RangeStartRangeLengthPolicy parameter.
      commit: d7c65aba73efb1519685bda79d0b924f3fc1d856
[3/9] sed-opal: add Admin1PIN parameter.
      commit: 1ccd8e90d2d705ccee423acb7eb69cdc2e17b3f3
[4/9] sed-opal: add IOC_OPAL_REACTIVATE_LSP.
      commit: e00c5bf602e9e99397c9385fc6687403b6536676
[5/9] sed-opal: refactor (split) IOC_OPAL_LR_SETUP internals.
      commit: 700cc7055c96dcecb1fe3ce86ad9769b6ecf87ba
[6/9] sed-opal: add IOC_OPAL_LR_SET_START_LEN ioctl.
      commit: 401262181b2f041679f526c9557e13ef4d243cd9
[7/9] sed-opal: add IOC_OPAL_ENABLE_DISABLE_LR.
      commit: e777eba95dae6427d640dd493c489511342f8b7f
[8/9] sed-opal: increase column attribute type size to 64 bits.
      commit: 93c58e070b38cd5be7a9870b324a14a4b0142475
[9/9] sed-opal: add IOC_OPAL_GET_SUM_STATUS ioctl.
      commit: 42dcb3826c86288a5c517dc2b465da687e7b38d6

Best regards,
-- 
Jens Axboe



