Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72773D091D
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813452; cv=none; b=tOhIIGfPWHvDslhaRdvvYiRtN61wkGjGgLm0VXQMFsLgaV5Rfcbt045usytNRfffsX+0H33todDacuFUe9I+h+Ri32rDsVL3sqPJGEA2UMMZXWYagTLFyqOGQIZ/tpNCDsb7z1A/BJSHhiuCEvmlV2uWahRtwzCv3ptaRfM99oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813452; c=relaxed/simple;
	bh=4wUdcMoXIqdQqLqCu3PyBpLhPzwc0EO1WLuZNMtdfmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b32RlmGkIdIAvpfBLkHuRIZ3RYWyKPPZfWtCBadmy/OJncXCBKS01o9D8DLUJAcErkFd+wR4Szzwmhy/wu0ccOMLtYz7OWoUmP08G6W+s5XejxcIJXnn5ZD7su+xc6xTYQs/Cq/rsLwmQg2C2Zo7VAnnWYAXrhcOw5Rhkmtc/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=aLtFNFre; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="aLtFNFre"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43acf1694daso6105535fac.3
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813450; x=1780418250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCd1gSuaIf46mkqpuuPeXA37mC71Ui24TOtMakL59tc=;
        b=aLtFNFresiZTZghWb/EYlhNZlV/Sxnef3JdZcGmKME/AO2xsSQR9r3X8WtMyyj+2hT
         D5cTeQj+oeDo9JfKSNtLxoI6JOVHCFlw0+4hSl8tcGNDNTlh0QCeWiN1hp1phiqDkOXm
         dFZ2u2VGz3RlOzViwZF3ilBypUBY+sROAMclJ41LGaCFtoumWpdfahwFl5XvTr/xQCVF
         vwY72Xm1UZW5r7gCNxvOP/TE8yZ/zwRuXF+U3PYIn/oNfYXwSf0V2N6fjC01oIyAp614
         M+dXobI3f2/akO8ORL/fDMR/ntpfAwknFgnZDjN0N96Y8nvk1BwFqu4gbcmizs7IzDUt
         /LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813450; x=1780418250;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCd1gSuaIf46mkqpuuPeXA37mC71Ui24TOtMakL59tc=;
        b=ct8jWqPeetiPqX9FDwxa9esdY8eEyMIy/8Fu0hMZiCRWEaalyOka/lJrYj50/R+U3D
         5FVQoEM4vEYtAJyc2wlwtk6ILhmT1Sl/MStEaDJucmO+RE7gGnTHf8duOvS2+3hFohVr
         YnQg8FRJFuw/LzOf0ART3444ObgnOWDYR675wjEZmDtwd9e3BSBHRzLnMnzp/1Ug605x
         XmTV99/ZEDmNV1eitzE7YM5WJ9F4n7Xfk4V/ZcNq6/Zj72iOJoqnetVT0gLk7pQoiFh0
         IijUiGnYI3o3Ip4DhhhdDKnApzQKNLPk6XCNYZB/QC+ydNdTYIKqsnCzLkULMpJ84AJf
         WyOg==
X-Forwarded-Encrypted: i=1; AFNElJ81q7+ATC/bw0Dsmpa5+Uiuk9MbaKmKpGtN8bhWBYzUyZfL829JCF/gs5ldNKitNnssZxUc9iErhJOzEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPMsM9+t4dJN5tOmp9QNIV+9W/Pojf/S2e4JpqKKePmudgku3
	kDCIeyg3JvJfvEbRp6yPQmCrqfu4hFpFQy8NiJ6KRUxO/VEtw7Qr1fHdsYMZR+aXZco=
X-Gm-Gg: Acq92OHfKkABE432GHx3sigMUb2MYZo44x3T6BxHUx2GcXYmd59CgIQSM7nDZWQaAHp
	rKTPK+SgiCVOTS8OIRQzokAaaydyEmnZ0ELVZdq1WwunrfKiN2er2NGpTxzoP1f7pOIFfqdlhZ9
	3UvjvH0t9Y3VmqyaKL+KBqo5Tkqp83eRmoGxod0lt5XL+09fvhOQhKEi+RbkjiKH1G7V2MalOTF
	/ly+6iWqgR9uVirtgSasnXBGcAqt2oHJsk8JBmGfHYkVEnoWT6rgOpyuzy/zY32j7xMGHF4YAKP
	xOr6t67bAmCFB9wnY/x073uK6UaGzJCRF+PxThd+Y0aoC6tUOziMiWrT5SMgSrhqUt39z0LJHGb
	vlD1qKmGUvxdPWW/MXstNXgqEKaDFVGyj+rIHnV62gWT3Ep7RcD2HDOUZHu4B9GXpYsCcKgn0/o
	YyysfawDUQd4b9Kd0TDx96MRbX82AsNnOcy481GY/so5HE4uUKO89brJlawEUZZqA07qAGvP1Dd
	JBHxgt4memGZg==
X-Received: by 2002:a05:6870:95a4:b0:42c:22ed:165 with SMTP id 586e51a60fabf-43b5aa19ae8mr11678694fac.3.1779813449931;
        Tue, 26 May 2026 09:37:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20260518063336.507369-1-hch@lst.de>
References: <20260518063336.507369-1-hch@lst.de>
Subject: Re: REQ_NOAIT cleanups
Message-Id: <177981344688.464267.1292458994150059710.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 18 May 2026 08:33:28 +0200, Christoph Hellwig wrote:
> this series cleans up spurious code related to REQ_NOWAIT handling.
> 
> I have block layer work depending on this pending, so merging it through
> the block tree would be helpful.
> 
> Diffstat:
>  fs/direct-io.c      |   15 ++++-----------
>  include/linux/bio.h |    1 -
>  2 files changed, 4 insertions(+), 12 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] direct-io: remove IOCB_NOWAIT support
      commit: ef9049ec8b9fd6c508832d9f7ab12029f3355102
[2/2] block: don't set BIO_QUIET for BLK_STS_AGAIN
      commit: 481105a949c8d11f7aa770b45fc4c8efcc53f205

Best regards,
-- 
Jens Axboe



