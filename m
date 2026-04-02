Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A4221F26
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135376; cv=none; b=QwDvGii+CLpo7mtfihwhuNJQBpWuwqHKpnWgz2BQsrV7mkFayBMTWy6G68DsHBc0+uOL+SEcf7X9hbHmfsQq95oUhstq/fZolyPlawEiA6O9dwcE0EL5A1tr62Px0zsPimiE0KI14Rve0lwbHsEylDk6aT27ihqRCD27E6WWZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135376; c=relaxed/simple;
	bh=p28Mh9l3wkYUK8qERZBPA6gUYoYjIsabZmszqCX1sPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jkjwijBNKir19QGWRigfHp5dn8KhDAQOvMOQIWq9O3OsFgLULSRQDgePAJARYRLHScvN8g4/6cPrxaX19q3e1S1AjMCyKhI3gDYPBEV6q0KYGvE6s9WnfzT2K7jzEFraNjZ2EIkJ/D6hCiNULx9Re5yhu7LDigUR04H/1ZweIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NkuEvrjc; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NkuEvrjc"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-467fd082ffeso533820b6e.1
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1775135371; x=1775740171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV2BMamJ14hxKG9Jtsdcimout5XNJc46VrdLTwbjaWE=;
        b=NkuEvrjc8WZPFidAR+weMYAcR4fQeCKiEcPp79MtDSqICPafhWA22/kDw7F5uFtwm7
         KFRhYfvVZ95sCgMpKKCQzaLKafYfE/xVsy/FY0IbHvNpxhFhrzxGSwOql5K82r0PUROW
         MgbVL9cJxyg+YtMx8I4E2bPzzlQpUVE4w7Jvt5aUsbx8VuV53QU2JU1GZ2mRzDM92lwA
         Vm8kpzY4CSLf2LMQU2CVp2K3A/yxWwlLAo+VNwHlFAyVLAwtWV0O4tKsp2phhb8kXdj1
         yZyZ3xpPte6Q2UZbQDxBOgxjleLP0yuEgsOUxwH9JNtPLpvJgD4oJAcV4Ny2tgY5ce0O
         i2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775135371; x=1775740171;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rV2BMamJ14hxKG9Jtsdcimout5XNJc46VrdLTwbjaWE=;
        b=cvC5AYDJ0kNSCl+M4Em9fZnwh18ed17ED/06JHGFLZA9q9rtiuMG5g2+tgbSEp65fc
         OQnFaAgC5I935nM7MDECsAc+nqZ7MrfflSoKr0ulA5au3Opy1niT8+o3EMgNDkpQSPFb
         D6L57IR8f93WVOZevo9WRRF6inBNsj2iBM+2MKV9Cn+ACpgjLbRunJNAolUPgX1/wfju
         Nvme78NBRbyz1PLmBchyIyoik0ahthDj6I4MMze2jVF1vmOpGRVBmovVfFLyq1WIcIHy
         +Q5f/JX8XCGbfoS7LLeY9k6qnpUjGjNded9tJ0yiUa4j6aCnc+gFhajD6r7e3FHMw7c9
         Je4w==
X-Gm-Message-State: AOJu0YxVSrck+xK1+kqGbSzwzFakE0MFRVEIEbMmaZadAWa4HX6dp/M2
	QujIOLiJ/zNFuCY5khEq45dxe4T08VrIrxribtorXoopnl0kvVoFl4o8AILPmtSd/SU=
X-Gm-Gg: ATEYQzzPgW1iJULXkcvHW8jNDW3YWa1XLHAENpj1bKRKWOlnJFiLDgO9kZM7uNQ9Yh5
	oEB/CGkmzubeoLIpY9lNuNMXkRn3CfECUUNufF2Zk1wpudUcSSB3A/utMgfIOHaDFCW/FEYaqOX
	SN51mEzfhqmEOSfWiTiI3Fv0QZzdQqA5VgUHztRkuJ1k4utPPO2bAWJ8Nr7WmCBb5oXWWVzFluS
	WoT36N/B+OXt47t6qwcP7HaNB2V+Od1CxZtH8o5SPJHs3YbUu6nYgfujyLQff4sMbmedwzZXn3l
	vHirL+YRDqYEEfptv15DByY/HSBVwbPhZtTNwdj6fCSfy6yLPWnAOCo55mqY9J/RBNiDJ1R9lAS
	uBTnYb1/T9Ox99i7+tle+IqIhDc+L7b5U9MTtnjnpRGryLYITFy4kD6oSrw3/ywS0VcfA5ACqzl
	/xtxdGsGgQQkDcI/Kru77GLceTpCcZ5EWrehcanhqS8YoDBIl8CGJThGDA7W94YoTc3QPNtel6/
	GYJPvhtQiwT1tE=
X-Received: by 2002:a05:6808:6f86:b0:467:5571:7f3c with SMTP id 5614622812f47-46adffc1a20mr3992595b6e.6.1775135371275;
        Thu, 02 Apr 2026 06:09:31 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d9387a763sm1593841b6e.18.2026.04.02.06.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:09:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ebiggers@kernel.org
In-Reply-To: <20260401135854.125109-1-hch@lst.de>
References: <20260401135854.125109-1-hch@lst.de>
Subject: Re: [PATCH] blk-crypto: fix name of the bio completion callback
Message-Id: <177513537016.175771.2579282690336286589.b4-ty@b4>
Date: Thu, 02 Apr 2026 07:09:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Wed, 01 Apr 2026 15:58:51 +0200, Christoph Hellwig wrote:
> Fix a simple naming issue in the documentation: the completion
> routine is called bi_end_io and not bi_complete.

Applied, thanks!

[1/1] blk-crypto: fix name of the bio completion callback
      commit: 4e56428ed4782e9e1356875af8e714b24c5a8783

Best regards,
-- 
Jens Axboe



