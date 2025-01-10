Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25328211288
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519533; cv=none; b=XPzYApZ5GpHGoa2oCK9OeCB2l10Gyvv/sM2kbjSGL8Y/BLigf/00up04KAE6tCZR3z1OqY+qpMtqrGBe7t2b21/UdmTVaQOl7U2nxvQa2AxoUpgSJ+BPCE6Kt42lt+b43LGO2DTMoCYyW++olKsS8N0SHIErzl2X/bo48H5/JZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519533; c=relaxed/simple;
	bh=DUWGDPn4XxuwUxn/KXcLcKay1KzpdFk1yg/lY0XxXqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IjgjSP2J0vDqiSRuUFcdrTdgUCpgg+DAmWsu64cTvzUriF6IraaQLd8Sug7fK14Ch4t/DuhP8Fn5aiFQ204hvVu0+Q9mT70eI/6T0+esDzWeBdyMyjStDd3f6vmGVDzpH9vkDQEXQBReBCrtQ+2/BTdhYWIvj29djxI5TCPURbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lX8KWNlD; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lX8KWNlD"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844e7bc6d84so62948639f.0
        for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 06:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736519531; x=1737124331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0JbanZY1faW9JPLnriOi+OAgQBXl13BZvnclHButEE=;
        b=lX8KWNlDUrD6UqZoL3ZFQFajE0uocTHyd3OkKrNVcwnwo/TzCBvsEDfoYT8R7YJZkP
         B3VnUr39m9b1ldsuHwCekHMRhHV5C050xuiax1ngrIDQi1nE6kPAU2FeDoc0GJrdQwbh
         A495iZIBkWx5bO0iPHGtvfReYQx81Oh4cTmUtwNA5utQFkzSPVZaTnG36wXeKEmZ81Ja
         vP9F5L7/P9diW+NyK9JCTS9vR0fRAO8Y4yKCnWMNuV1toPE6G+Zu/WNjmMJM2XxjQaJ6
         NZBGeXU4Wy5Xrd1gEAv92dT5h9CpQf0fzRxWpyqm2oUBQ/wMArmjCFgThLSxfJDA6ikq
         +R8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519531; x=1737124331;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0JbanZY1faW9JPLnriOi+OAgQBXl13BZvnclHButEE=;
        b=M1ZSEDNo1lr6oiv/0Ax52NECaBjH1tVDn7/nWdTqqDLs6ebU6stBhRH0e/622d/CcO
         Z6jaPXTeczKo5f7gD21TAd4eGsR5PbsgUuT34k5NQG1GS496IrbUwTceZv6be923yhFo
         GCfm0djfsa4OBnFN1EFg4DxLwEMoIA15idfrBx5tpc5Rv3W/rMryewDd/ya0uVTyxnl1
         oTo0CZNYKCRrby4JwaY4YtwuRtrQBfQqWkZtF9xkEzdQcoxrPthFsLKpcq0iIFVWgjLL
         toaN+Hc4P80lgSra67f9rT036KJEw6w1URp8wgj97r/JT4AKG4Pyn4odkYFZAoCagzdN
         dGIg==
X-Gm-Message-State: AOJu0YyEfKIxVQqLakUED/6wnC7zASTUDTZyQkYgD9dx4w3euBOcr1+U
	FTBpa3WbB/dPN9CwFZcSuNnPCN4Ll5of9K8HBRIliE16DD7qSCFHNMx0tA8g78u+LPxhOEXenwF
	+
X-Gm-Gg: ASbGncs4BPuloU3Hvx2glloc1MslGj4qV+NAMjKA/J0fXMTwy77OG/MUT/fbhKYPic/
	GEIvCv29bHvB0VRBZ7fqTCoubFaMBQgYd7n4m4y0+L11Cywgsrwi15uPxMZRQAZ5ygqt5MiCq0H
	mIIJDGBwKGaSxexyevXBtcuhUH4knqex0/O3Nemza2hm/iq4KHpeCISPHVHbObA/SPikzUtmGoN
	7tjdEHlPC+1L5pI+mzdQnei97HHvKNOqfy6a40vW5JilsM=
X-Google-Smtp-Source: AGHT+IGWdX1egc7RmUFd8sQAryKmuKxcrQyP6gA/CqdChviUsVZ/aupQ0jJxDu2KcBc9vB9LmcSNSQ==
X-Received: by 2002:a05:6602:3e99:b0:7f6:8489:2679 with SMTP id ca18e2360f4ac-84cebf17b13mr572931039f.8.1736519530809;
        Fri, 10 Jan 2025 06:32:10 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84d61fc84dasm91086539f.46.2025.01.10.06.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:32:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250110073750.1582447-1-hch@lst.de>
References: <20250110073750.1582447-1-hch@lst.de>
Subject: Re: tidy up direct I/O flag handling in the loop driver
Message-Id: <173651952845.758529.4233293735179721751.b4-ty@kernel.dk>
Date: Fri, 10 Jan 2025 07:32:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 10 Jan 2025 08:37:30 +0100, Christoph Hellwig wrote:
> this series fixes a few inconsistencies and cleans up the direct I/O flag
> handling in the loop driver.  It sits on top of the recently posted
> "fix queue freeze and limit locking order v4" series.
> 
> Diffstat:
>  loop.c |  123 ++++++++++++++++++++++++++++++++---------------------------------
>  1 file changed, 61 insertions(+), 62 deletions(-)
> 
> [...]

Applied, thanks!

[1/8] loop: move updating lo_flags out of loop_set_status_from_info
      commit: ae074d07a0e5c05769f1a9a2faa260c36d69465e
[2/8] loop: update commands in loop_set_status still referring to transfers
      commit: 4155adb01e7406653f6b01aaca916a59567cfbfa
[3/8] loop: create a lo_can_use_dio helper
      commit: 781fc49a0e5c111b1a210bd1b3499c89bb21cd81
[4/8] loop: only write back pagecache when starting to to use direct I/O
      commit: 09ccf5549d7809671af34774bb30c8f935d6ed2b
[5/8] loop: open code the direct I/O flag update in loop_set_dio
      commit: dc909525daec7c7c5d628683c99d26e281c1a7bb
[6/8] loop: allow loop_set_status to re-enable direct I/O
      commit: 3a693110afd7127400cc9f779c885f01cf16d0f2
[7/8] loop: don't freeze the queue in loop_update_dio
      commit: 0cd719aa63def1d57316e8e903f01f4af0641a46
[8/8] loop: remove the use_dio field in struct loop_device
      commit: afd69d5c4a1049230fa91c9b54fdd8132f755503

Best regards,
-- 
Jens Axboe



