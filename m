Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC213806C4
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941730; cv=none; b=hsNstsvuLrBCMF4XwdW31qGoHlQ8C1cBXbdKGqDDTK4J+o91LUQ1e7xGfSP5mxXVzDDK/DH62fLB3xWBiZok4IvTXmRQIIKiqbI3CuIKA75QaGJA04PXBKkGDnIngeMrE/7cIdXs0wbyjZ2PwQl6QvygJX6q8J6C4dzFqT5U6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941730; c=relaxed/simple;
	bh=5rbruo5z+OCWzRyxWrt32IDfWyuwr5zrz/uWtP0m6r0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M9zeu1LlgV8e5fwuiqSeBpa/oqQmhhz5zFA/eWZiNViMndk3KN6lJVC+7e7nmCN/C6hNRATp8jwbGJ2QDRlwsgrBRjNnXK5Ll4h822mJiZmWaBRdiUlBWu1L+GwpEv1UmtyPkrCINf9NNHTJp5WmTiu7GzhZk9MeGWT1TxChjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=RNq1nufe; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="RNq1nufe"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dbe437b072so3738501a34.2
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776941726; x=1777546526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSIA/W7Xb9zRDmykFE/u2Zi49bGSWsIp/IaolcqvyiM=;
        b=RNq1nufe8MCsvNYh1BAyX6OQNBlNLlkUh7GvgqEbYy+WpBI1/eayMqCv0fcWqJ5hd/
         c2v0TpyzLwwC8UhkyXBh78KcSzaY3Zz8a6HCRUCmK72mZyAojoZyhHDCkoHgeLipYK2o
         QfDDdqF0bKpA59urU9uAkSeUfaQJBezpPIzgyDCw63iUYYHB9PngQTJRoteYMs43em39
         fYFmhSNOZPLECWQXlglaDkJrrBGXIFKdghNG0Zof/84pN4z8vPrI7qObB5Q8L7akK0un
         dfxSNE1V5Kpu9wPPM03v8QrgJhzyIbrTO1yH2M93zHrYvVZK5KY2zFMwXTbjAifNnfZB
         mFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776941726; x=1777546526;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zSIA/W7Xb9zRDmykFE/u2Zi49bGSWsIp/IaolcqvyiM=;
        b=fUWhRFODXr+wjCnxUeJU03VZPhqGKwLkyMbh8mCieZbip4K2JoXF5WcL95UKsNecBA
         bohDG9noraWEcs0psWsvsTOQCM9HYf90EY27jS5N44jO7cFVy+bfDrAgfEW/Ws2esvVs
         2R3oa8jDlhYgr3xBnCwj3V21ahS0JM3vwNJVG5eBDdtn1fDsG7OnebEGFhZbLs4BLzNv
         2+qm+aDPukUhJBHw2T/ilsQe04+6lupq1zybm0GRTAF5Kbd1yENhzDHT3nx+1zgpH6BL
         KiGsTALMhVqrexUXKbjoEzTyF3hJdzruaaTjO/MjFgs5FpEsGRUE9+MHpQjoNe5xqiW5
         ne5w==
X-Forwarded-Encrypted: i=1; AFNElJ8kiesHvH76NKr/g7cP+xwtKUhC1uJZxa9/XDnaIQFNex+tU7KtkXxEWXKncamvIK2/wkb3SEkisGuHJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsdnFwgsBrfGATDiRnCo8c7xehy+6LMtJfOfLXwunJbycqZpj
	Afaz0ERrsKxtuyTWbrNfNYbpIBIOwv9SSuW7zfqhKVvNBm1FdiFvVuc7X4Z8UC1VELE=
X-Gm-Gg: AeBDiesolNIWgLDJ19vgwd5U+i3FLbHhFyuirwWqvI+8LXmHRxux0VX2OtZBxYzE9Ds
	21uVfZ6k+SUaeMoMksFZoxZN5rr9e1iGLfuAtOSXXTXrw1OmwA9TaX2WeHOHRkaizBqVB9T1RuL
	RoYHiHw6xWuXfr49GUBHTL38Q9dvX802ZsKcZIZznMg+Pi9efbgELYBM/yWz84deaAokWlM6V4J
	lKoNvRUpkvfG6x3oE1eR9z8MremyrQIMAiatRTFxZJ6N3d1SxTKXDz48szRtDOP89PM3e2TAy4I
	gog6ehXpLSqo9xygyfr9dTVnnI5COICiRYoAApH4G4TgXRFWVRqfer5IKLtPOQ56QuQsUGs5fIW
	HObH+9MvgcDKVNc/HFj4K5lfdeTlf+25VdFXEMnv+OzWhDVRz1pu7N4VaEwsgpEvWP7DLgpJOhs
	n/KuMZxAdOzOQ5NjNw4EJ+0sK3rxhyf+Hu0/8qjQdm1BwnCJwhIWNi8EeCoghDIA8rQmhXSqHsK
	IdHEabDbXjQG/8=
X-Received: by 2002:a05:6830:3149:b0:7d9:71e7:abe5 with SMTP id 46e09a7af769-7dc9517f45emr16975992a34.10.1776941726459;
        Thu, 23 Apr 2026 03:55:26 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcdbef352bsm6106065a34.10.2026.04.23.03.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:55:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20260421200901.1528842-1-csander@purestorage.com>
References: <20260421200901.1528842-1-csander@purestorage.com>
Subject: Re: [PATCH 0/3] selftests: ublk: integrity test cleanups
Message-Id: <177694172551.1095312.2823646900889738261.b4-ty@b4>
Date: Thu, 23 Apr 2026 04:55:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 21 Apr 2026 14:08:58 -0600, Caleb Sander Mateos wrote:
> Update test_integrity_02 to allow fio-3.42 now that it's been released.
> Add a modified version test_integrity_03 that uses auto integrity and
> avoids the newer fio requirement.
> 
> Also clean up the callers of _cleanup passing an unnecessary argument.
> 
> Caleb Sander Mateos (3):
>   selftests: ublk: remove unused argument to _cleanup
>   selftests: ublk: enable test_integrity_02.sh on fio 3.42
>   selftests: ublk: add ublk auto integrity test
> 
> [...]

Applied, thanks!

[1/3] selftests: ublk: remove unused argument to _cleanup
      (no commit info)
[2/3] selftests: ublk: enable test_integrity_02.sh on fio 3.42
      (no commit info)
[3/3] selftests: ublk: add ublk auto integrity test
      (no commit info)

Best regards,
-- 
Jens Axboe



