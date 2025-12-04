Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56EC2DF12E
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764858330; cv=none; b=BJ30hUy56fza46CYywU03QN1VP5CIXRGfjv3hUKvFUGzb2cvOqK9H+lEP5OVp9UE9Or/l0CyQ2FYWQqWo1ScIX4M/ZbG+z2UbruXVX7JDaanMkEMERfboer4+iji6xN1J/eRPnsZiw+q7jOgmkkqgBJPMMem4OINXUdlT7yU/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764858330; c=relaxed/simple;
	bh=DmwaIwM5g2Z02PVlNayTUXuQk90cje7eQ7OJBTnTWiM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Te0sOTV809hbx/uKdDeIjbtnq/1y/y5H2dRQhg0XXL89enaEpmH6UlaDqfY6hKv/8aGKNf+C4zWmsJ3r2/R4MYjdNOXaT7yIQV1NqR43IzYyn/iQ/+QeOJ+1AjkWir6W874jNa/O1GKtMHDzmM8t9haOKPKFdYNY8sKIjaxiO20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TsOZ1nCF; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TsOZ1nCF"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c6ce4f65f7so872849a34.0
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 06:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764858327; x=1765463127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzo8AOSpurCCeWobi8FOCmA82A9P5FjJwMklK33+N+0=;
        b=TsOZ1nCF4l3kByCZPnntr4Bu5Dc8P/DmLzE0BKl6SV+G8OKOKnE1E3jbJa52gx7SZx
         rsCmPDytCTzqBkOqmG4OWqSwHhY9w9lydU8PwrKxOmhOjaixKTK1L9UHBpSBXFExyXkp
         HxmIL2hTcowvyFYzrj0UUs1P0/edhj+DeUrfarQLck3OdM5nwduJHrV/JaTnklwxVYLU
         6gBsZCcKXJfPtlizyuLN8lLn0O9QPBlW8bgJJCnEKS1bUdP25dbYFRCqAHo0tSbovQbh
         ZKHs7BkbjM317tmA6+kpDXMOc7qsEZrgPsN9kaK+ADvF8+M7gK1EXkUPhLXdCYX58Rwv
         jgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764858327; x=1765463127;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hzo8AOSpurCCeWobi8FOCmA82A9P5FjJwMklK33+N+0=;
        b=uJK8SEcxHo3AppFuGVO4sQTlTLBrpe50rwqYTIKdT8dvqydQQVi1u7vuB1EU0DymFs
         dUgrHDgAkUGjOHCK6EIMRKbxZn9BXfIKGcwYRPm766JTXkJLchYzYpN7myB2zzYArZTz
         BGxpiXgInCgfKNjH8ykEbuz+iAcA1Ca2y2JkVW2jePlUXQGpg0RqLLfAIfsRDeCtCVns
         /Lo9kCoqLlsDvOTJd8k6R6bLA+Nd85tUVpbLad+ke8JBIE886BpLv6ottvQl/ZL6RqvW
         k+1FG3LPo+PDuQqRdDzz4uSHuGDqu5lGh7CHS3ll+ZOlC5qQNBELfV4pAmnYr+nef9/g
         aSnA==
X-Gm-Message-State: AOJu0Yz68ijVTfJnxHqaxDI7vMvWfJPAJQlR4CJgPmrusAMFL2Jlh73K
	AjK0/mutKp+s/GUaF1R6SukJrhUW0O2Fjr0xncu3F4nDZMafzVQr4Uu6LUE3GQcZEOaBi42bXOw
	bzJ8mP+Q=
X-Gm-Gg: ASbGncu8XccN5KveEIUPRpepl98384T2rlEKy3hawhrx2edx9jeub8zGos1e02b/vEm
	6KUNFkJSz7GsUYnNZlGEjh0iUY9KF5Q0IudBayc8DtfKF3byGerk3pA4QnW2S3Zrv/N4m7rGYDP
	uDVPEAICsz5Mjn0fuToJxre2tFTdDFlSMV7s0L7sNhMD6P/FJxRcnfS3s4aCF1nbNh0jh9C0fDQ
	76P+DVqXbfra2NOURLod6/fssOCDs3CvQmb6BR6oF2qJnG2V1JvJv3Jy3bPx08lQNM9PBoo0K6c
	g1D90K07+2LXJB70HErroJRPpklZISHt54Yzc8PHIVGiIsHud07ywuiejGYPK8m41ePXvnBpzPw
	5vDrKiSkxis5rd78jlf0LIBc1DS94PPWSeBEAUMCOVouna6EAY+8lNcgoSyJojfjzgjTgKJyK1T
	EiBw==
X-Google-Smtp-Source: AGHT+IHkvNqkBh1Z6ppshERZbkx4vB73Qlp/sZwMg+MPTVaOXd5DDFFmKEMwRD1qPWSCdubiEVMdQA==
X-Received: by 2002:a05:6830:310a:b0:7c7:586c:846c with SMTP id 46e09a7af769-7c958ba56ddmr1805178a34.19.1764858327281;
        Thu, 04 Dec 2025 06:25:27 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95acd567dsm1491772a34.25.2025.12.04.06.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 06:25:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20251204105952.178201-1-dlemoal@kernel.org>
References: <20251204105952.178201-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: Clear BLK_ZONE_WPLUG_PLUGGED when aborting
 plugged BIOs
Message-Id: <176485832650.920754.11922434400514933487.b4-ty@kernel.dk>
Date: Thu, 04 Dec 2025 07:25:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 04 Dec 2025 19:59:52 +0900, Damien Le Moal wrote:
> Commit fe0418eb9bd6 ("block: Prevent potential deadlocks in zone write
> plug error recovery") added a WARN check in disk_put_zone_wplug() to
> verify that when the last reference to a zone write plug is dropped,
> this zone write plug does not have the BLK_ZONE_WPLUG_PLUGGED flag set,
> that is, that it is not plugged.
> 
> However, the function disk_zone_wplug_abort(), which is called for zone
> reset and zone finish operations, does not clear this flag after
> emptying a zone write plug BIO list. This can result in the
> disk_put_zone_wplug() warning to trigger if the user (erroneously as
> that is bad pratcice) issues zone reset or zone finish operations while
> the target zone still has plugged BIOs.
> 
> [...]

Applied, thanks!

[1/1] block: Clear BLK_ZONE_WPLUG_PLUGGED when aborting plugged BIOs
      commit: 96fd48daf5f23e2c051120943b7a66ee90806bbe

Best regards,
-- 
Jens Axboe



