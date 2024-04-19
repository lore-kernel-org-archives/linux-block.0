Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A619212BF2D
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535908; cv=none; b=RSYJfm2Pk2FBp/AzCc1aJ9zbMaTIiC7G4fDA1mUCYK9qJqEiCsg6Qy/ENRhgxEknYCZ9hJBHirV8LKlkdN81th+N2N2Up5CrmEWfoXHuQZrofxs/Hg/2Eb6xgpNTzuG32x4sNsAzEQQxLxgkNIDTZS3PWL3di7yWOyLRzElvKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535908; c=relaxed/simple;
	bh=lhuuhlHoSybByQn0SwSCUX4ACgq5MHGKsq4NUwZKxu4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FEoLv4YZ3fRr8wcCPmA6tRWWN64D5o/5UbrzFucWPlQ8RfwedcQ9WmOGdaBYjcAPubrMYLvvLrhzbkY9F9T4GRW10qcbWsHMUe99rWrM/GfjTvDr8snOmyX2lY2DDTIT+CnwhBn1dxCSza+h4R4KUbiaqJ2W0A6wxJ0UiWritt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UiOOSX2D; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UiOOSX2D"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecf1d22d78so424367b3a.0
        for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713535906; x=1714140706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wys6ZkDgxTEpvXL6YfKptglVkZTc+L3A3W2ruhO3H8E=;
        b=UiOOSX2DlMO7U9TZ+vxC/jv1gdvL39YdO/msZ/zuGeVVDQTNOYmmWnWpUwECplo7Gz
         eDP0TuZ/PgwFTZ4PVkZcYJw7i/apVF6uUF2EH/mWkTYnN9oobSVLgwHLf1KqwLC5G4vF
         8BdiApGl68BKfGfeixLLymHH072rDGToHpc3d0X9roqjOlRUxpJIhpOwVMo+WyN1ptaX
         FYM4Ngvp0ISgnYgZ5hGAAAoII8WEjfvzj7EX+nId901af/Zw+yM3FKEnCU3Pjg5ERBJB
         Ui1PC91i3jNtKOk7Fs1DPh2Se7otXvT2LfVc4SprzDUb19t/REPx1UetJxTBqvtQU0cz
         jA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535906; x=1714140706;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wys6ZkDgxTEpvXL6YfKptglVkZTc+L3A3W2ruhO3H8E=;
        b=TOHo3P98uylSicntxTP3jYsCdSJHYm3vVhpugMXmAddVYviua5up0t/4Ce8ms1yzFs
         FClVciTNGXW++7Ze8tiv5zaoYd1OTFy5Enwo0Fc2slO82LVtbCRbtQREFRDBijUN/M9t
         uSlg3hy5GV2D/FejYc83Zu8mmKXpDJZ7Im3iKqfjkr/nMDjbZ9Fk3FlMeHLPzTod14xO
         SP5aTGFlwn+V10X3NLA1aCPeqzdH8e5mzjiRV4aoho0SdBR3xHgBPGPNgJr5cdKvJ+1l
         heKuYx+Kpf4yRHjUK42EJEBmSJGcfKxW85yIBMdsJwMVCv1m3OL3tdCdO9NSQuygLLf6
         enjQ==
X-Gm-Message-State: AOJu0Yz3gElwAzxDffrU9Naw+HbMjW/AkZpnRzFiZV/OK5w/JCT7Xn1B
	BFDq+nlP81gs+28wP58yMPhNJRlZwWMsvCdLdYjtDfMXjepVd5yXlO0G5qyCoI1RauXmQ0+sV5+
	r
X-Google-Smtp-Source: AGHT+IFCc8KLLf1SOEMuhb+QGId8pOkh7M0fMhCUVy5hGkteY0WGoCWDclRF3oRGhPuIjxvMuKmAMw==
X-Received: by 2002:aa7:838f:0:b0:6ea:6f18:887a with SMTP id u15-20020aa7838f000000b006ea6f18887amr2483792pfm.1.1713535905614;
        Fri, 19 Apr 2024 07:11:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id fb22-20020a056a002d9600b006eceaccaec9sm3240102pfb.131.2024.04.19.07.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:11:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20240419025610.34298-1-jiapeng.chong@linux.alibaba.com>
References: <20240419025610.34298-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] block/mq-deadline: Remove some unused functions
Message-Id: <171353590474.449375.12575665892825233453.b4-ty@kernel.dk>
Date: Fri, 19 Apr 2024 08:11:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 19 Apr 2024 10:56:10 +0800, Jiapeng Chong wrote:
> These functions are defined in the mq-deadline.c file, but not called
> elsewhere, so delete these unused functions.
> 
> block/mq-deadline.c:134:1: warning: unused function 'deadline_earlier_request'.
> block/mq-deadline.c:148:1: warning: unused function 'deadline_latter_request'.
> 
> 
> [...]

Applied, thanks!

[1/1] block/mq-deadline: Remove some unused functions
      commit: 8294d49adbb06d7df8cfaca5a4f4eb9064a91b90

Best regards,
-- 
Jens Axboe



