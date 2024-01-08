Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3A5026C
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w/77Zib6"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ba9356f562so19613939f.1
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 07:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704728080; x=1705332880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IHhPCDhhBllAAgkD47C6skIXw4dFy2VNA3VtIllqMo=;
        b=w/77Zib6dAyStYhb9IHdBQe5l2Llo2jFP1OaBUJTMugNdkWu1rgemDtvILq1F9CJRH
         BCsn01j7pAwwDVesybtcLaXu3jPABxAw2/Q+H6mEMAcIPR2F4yDcZQga/Zq6hG3CXBQu
         +mmKZho1wPT4TEnToFWgFI8+rl/x2HrtSIJgqvXqpUhxWt88N+Iqaobb5fSMCoAAwANl
         29cbSVqmjYGeFdd+eTB22QWNXoktkgYUJd7DlJ4glywpNOEqBumMaX5kKBvXROcUiWXR
         7BIjs3f/oBDl5SJeZt18U/CzBm94TXuH2ErV79VqZ2Uur9jDPnrj9MQOUlnXarGlcxoh
         4szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704728080; x=1705332880;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IHhPCDhhBllAAgkD47C6skIXw4dFy2VNA3VtIllqMo=;
        b=oHZemLzhg8NxOhRgWi365EwxDr0aLPIpRXBXxowSd6lOYsijOCiJi9spAAzmnNhVKQ
         BuNmVaVTAbAlSF8w9z2sTAqDR1DlDzBqGKk6+9YXoExcBWwmhmvYbtNLGhGPGvRl3GwU
         +ZJmuUgDPZ3r7OgbQ2fNhdRizKPAAwqcjpOP7Vg4BOWCo9dJrqt1OU+rm6txfMe1kktm
         ezkx6IvsEdAsmpYH/Hjv+ZGzVsHy5WVOeEI2PmI8eab07ELVRLUZ10WVqMvxAppI5RnS
         QgXRo3H0kCobxlcT1AKH6Xdi520Jtu/ln12oVayeJ67LLjjZawJHsbU/QUp8DxeQ7Y16
         TD7A==
X-Gm-Message-State: AOJu0YzyQK+orf0t7MvKfRgXvFdFWqUs2KAdLKrq5xB+hkOqxHwV/pEO
	9s1nCQtnUAdvbWjGbK89WhPX7gqg9aFo4Q==
X-Google-Smtp-Source: AGHT+IHebW1zojN9C1mAH2rC00aAgOrWoqZBzrRVaoPlx6HUDQgJxppncsvBa4rg6SDmVfO/XeZSTg==
X-Received: by 2002:a05:6602:4f42:b0:7bc:2c5:4f6a with SMTP id gm2-20020a0566024f4200b007bc02c54f6amr5659480iob.1.1704728080486;
        Mon, 08 Jan 2024 07:34:40 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b12-20020a05663801ac00b0046e23b253bdsm17964jaq.13.2024.01.08.07.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:34:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20240107072212.1071080-1-dlemoal@kernel.org>
References: <20240107072212.1071080-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: Treat sequential write preferred zone type as
 invalid
Message-Id: <170472807986.1177326.10379585841494921683.b4-ty@kernel.dk>
Date: Mon, 08 Jan 2024 08:34:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sun, 07 Jan 2024 16:22:12 +0900, Damien Le Moal wrote:
> With the removal of the support for host-aware zoned devices,
> blk_revalidate_zone_cb() should never see the zone type
> BLK_ZONE_TYPE_SEQWRITE_PREF (sequential write preffered zones). Treat
> this zone type as being invalid.
> 
> 

Applied, thanks!

[1/1] block: Treat sequential write preferred zone type as invalid
      commit: 587371ed783b046f22ba7a5e1cc9a19ae35123b4

Best regards,
-- 
Jens Axboe



