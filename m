Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C561C84B2
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745249167; cv=none; b=VE3sIsfJp1MO/2x1gHGdFlaHh8eLHAqKpZwV+PdRk9q4rXx8wvt+qMqx6a5TuQT7llwJfPJ3S8HAzLVURuYMi9z1Wg2mrcj5ER4e75afFJsavg5Wvz2hdGxRkb8TuyB9TcsgpPUQ/PSaPKq95aR1bSezNdg24w3AkZUdCtlYSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745249167; c=relaxed/simple;
	bh=oyFDL0tEsBmkIRbx0EJ12DAGw3V6d2obR28xoFCrRcE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o8uSFHVB1r9p6T9s8W3sxBIF4noDpcRRDSnKL/rGOcIDfZisLTDj08oqfh71QF/FCIMSaldKsGXtEY8dYmxFKupEv52uZv1PzUtplAd4Eo0lAV2IF/REFtb7s047myW2n9Bh9aZdcOP90W736b5DX40py3bISzn/RaEUcVGy7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YTAV1Rl2; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YTAV1Rl2"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86142446f3fso81400939f.2
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745249164; x=1745853964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9ScjabGJtaO0rM/C7HSW9TUBYDvPcVX/rnHRwpfBEg=;
        b=YTAV1Rl2YpOfu9MWbCV4cMThb3FCaEEDWJzTbQ1R8Mat1zjZxh7zldsvJPhz7Z0o78
         iw8y+4nQV3HqTDB/TK17/8Ff1fbN5QW6GZkTj+v0l1cr1KKnjsoJj5FACTLTgUwJBoGx
         9xUjNmh8yEeLl424q3/8UoNWYs/w06BF7Nz5Ki+bIvTVL3psvYOu28SJBuKqld2bTQ2U
         6c+8Ls5mwSuEIiU1FH7uy6lErpZ8meZd0RmU/38LGKmroVkfNgiWbS8pr2qgzXMCqiTp
         yocQ5Z+6eQVPEYUTmRoQ7JXh6PqUOY2tDrkvepwYWkwRWPKWIcZuzegSInQsKTmtRxZD
         uiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745249164; x=1745853964;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9ScjabGJtaO0rM/C7HSW9TUBYDvPcVX/rnHRwpfBEg=;
        b=We3Shi9MWkrCt3kXf2EI4UbWqMfoERHmhxS4KQIbvXT9g/ufDADf3Gf/56RDtNzuXw
         p1dMoX5g5Iyiccew4luwTjcN+p34nPPq0umJS6/gQEw6IdixxKrKFzARCpl42u7wsyRw
         ryFnQ9WY7tVSWDINbju6Hn9HR78q2BtzKYf7lMMc9tdsQsIG2K8lZDnIqJ2vrVzhP7x9
         olnllb9XaRH83x2xC9xv19srEf80mZsE3ZwZYPNIf769COgB5zvgz60SV5ETCiKIsu6g
         ea2xAldzD7vVxo5CczFlV4lBQ4h3pB6Pvdm5i6DpWyW0TZAjxbLL07C5dD8kKhhy/etm
         LhkA==
X-Gm-Message-State: AOJu0YwJ2j46SXI4ar7GnCtLgb4E/9KYYVk35ViE4ftEWdfRqXaKifKD
	XnsLC17iBDrr+462n3B84+mixx+nNZxU/QtLmP4vSO8yOSN8kYKzuU4U5SfNjk4=
X-Gm-Gg: ASbGncsObo1B0xUH7OPOKoqc6zYjQHbsAhHFu3rqfUBIUiOrIgTcmWQfw348S8ogLJW
	LTNq9FpfEWq6YyElpOTPPSlM/6J7SjX4U8Y1+3dJ2j9+gXhczqehTCEfB8JD34aBw0i/ZrTlOWH
	I0YqUO+45MoyRVcyQDntqeMSHa9YfEDnHwIFzfe9Im9PxDMUs2QSzr9ZUPPm4yTnlL/LZXQ6fDE
	Tt6zotaPcAMWyTtCBJ/D4ZO0DmvipRniHXQgGuHwPgiJlgXW+A51CrPbLVpmkQy4H66leLpA4GF
	m0I3Th04UK/2mDS4NbmAk6DdRt5aLoE=
X-Google-Smtp-Source: AGHT+IF01T6wmSj7KoQYmRqwlp03sRX4209ENV+s7X3xwtCVlC7c9y68dEoHiQsVp5xHpX7SucNoHw==
X-Received: by 2002:a05:6602:418e:b0:85b:41cc:f709 with SMTP id ca18e2360f4ac-861dbee316dmr1056536339f.14.1745249164247;
        Mon, 21 Apr 2025 08:26:04 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a37cb943sm1816250173.4.2025.04.21.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 08:26:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Jared Holzman <jholzman@nvidia.com>
Cc: Ming Lei <ming.lei@redhat.com>
In-Reply-To: <2a370ab1-d85b-409d-b762-f9f3f6bdf705@nvidia.com>
References: <20250421105708.512852-1-jholzman@nvidia.com>
 <2a370ab1-d85b-409d-b762-f9f3f6bdf705@nvidia.com>
Subject: Re: [PATCH v6] ublk: Add UBLK_U_CMD_UPDATE_SIZE
Message-Id: <174524916290.914665.10011985049741221768.b4-ty@kernel.dk>
Date: Mon, 21 Apr 2025 09:26:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 21 Apr 2025 13:59:50 +0300, Jared Holzman wrote:
> Currently ublk only allows the size of the ublkb block device to be
> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
> 
> This does not provide support for extendable user-space block devices
> without having to stop and restart the underlying ublkb block device
> causing IO interruption.
> 
> [...]

Applied, thanks!

[1/1] ublk: Add UBLK_U_CMD_UPDATE_SIZE
      commit: 98b995660bff011d8e00af03abd74ac7d1ac1390

Best regards,
-- 
Jens Axboe



