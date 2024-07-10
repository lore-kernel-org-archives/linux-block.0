Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6716EB4C
	for <linux-block@vger.kernel.org>; Wed, 10 Jul 2024 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592630; cv=none; b=pv2aQUcS4C5Crz/4FzldTr/tVUkcxT26zOG5zF1HWbN8h5MQ0ZM1oritqXjbjETteAQPVHJx0LdtVq1oHfSrGuKi8hmJNBSn9S4kRp3WIXRYXiBx4RwcVaIbhDp4lyougxMNrKuwqh06g86PFXe6+CcVoEIjflaqS0cdaxtuguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592630; c=relaxed/simple;
	bh=1MzlV2SivzQk+toU9O0s1wYx7Gxy0Hx2ackzSFFM4U4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Eg03SHyk9vzFrE1+BZtcUsyN1weShtHQAFXdN0z2ERFEOeUawyXJSgxWJ2qO11/s/MQ0GpKF57vCWD8lu1xySkFWYnUC3Q4en7qxaKen2mvCS0wBxbLVxFDZ6RZXWHlTLwquFcVEAvXdMnzpI+p9AW+QwrxLRogRoQ2fwUtZlLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=K41vxN1X; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="K41vxN1X"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e98c72d2bso665004e87.0
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2024 23:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720592627; x=1721197427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peZsNPj1BNH4twyiHnIZz89+5SLDTDtVFfp9lmKUxv4=;
        b=K41vxN1XBNHWYrqcnA2JNGiZrMzESpr1xyF0sCMrLXUppgzkOqwSgl8T28ralCx9MO
         rW7PqW7bA0k8kfs17fYRBRuu7qa0khlMPPpik93IN83tdf5AAIyut176qWDI6/wX9VML
         KVfZ3SWsUco0E4FJStAks+xlgKX+ulbWtBtS4j7vjDePEl3lyitlczoUvxvG3yY+FxNt
         OfyvcDt6+zhIwijAfqZ4zVM3+RNKLgadUiEdPnM8lzhAxd3+QPRgc1W2rvqfRdtxuFDt
         PzHRnO3VV6HIDP5jspeb9irs+tKqaUX+RxtFvsGmaSd5CMkdS6BwfitvCQXuj59mfv7O
         +npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720592627; x=1721197427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peZsNPj1BNH4twyiHnIZz89+5SLDTDtVFfp9lmKUxv4=;
        b=MMHHsTRXZq+VCDqb8ulk95dY4Oz0MEghNY1mocy/WLEPWGbOAeMdZmpp56XrSUTlnF
         FvYIoF12v52BSx0NhIaAisEdtAfLfNdncSs9r0tY5ho0O0eeGBj96cq3uiAv044RZzGs
         oZll33roDrHG/0Gqdwlw23SG8LGk98gf8IgZ0x3NK32wC7+i6dXB7OXy4ItC2MZgSQdR
         qpJwp7EZwgPno/jej3fNRmXJs2BUFVG71IzADGY1Yx/7S46NlxD+nvru8aXFjLWOEOqg
         7EbKaVLgJxok1R8KlqHfiYuyGK/VDjmZJsV2jf+9AdbEdbCFkCFqq8ZRO7iIPBMTCLAc
         WEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwEK8dac7t50i3M4yhx+OVNnNSUXf400v3/iZQcMMzYHoSIF9aU9En3oja1y7MpdscLOoeW4ZTTGOeY2N5JIAMEvZ6oDfWF4xxQQ0=
X-Gm-Message-State: AOJu0Yx1pHASH/CNK6QCdObK0lUGjfMw8nIsdm0iLoI6N0w/oDd48bYn
	RefBfnO0KtCOICcpZ8+iJoigLCuk4dXhWFaG0S63nlLOoaSfclK83hCnZNA/zlU=
X-Google-Smtp-Source: AGHT+IH5aoFqMDetAj6DeM6xs7OgL2qyb/6WTEb5Xw8gbWI7SvdV3F54U25nwN6xMLvlPI5WP9QFwA==
X-Received: by 2002:a05:6512:3d8e:b0:52c:f533:1e21 with SMTP id 2adb3069b0e04-52eb97586acmr3136252e87.0.1720592626693;
        Tue, 09 Jul 2024 23:23:46 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb90670b6sm463892e87.197.2024.07.09.23.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:23:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240602-md-block-xen-blkback-v1-1-6ff5b58bdee1@quicinc.com>
References: <20240602-md-block-xen-blkback-v1-1-6ff5b58bdee1@quicinc.com>
Subject: Re: [PATCH] xen/blkback: add missing MODULE_DESCRIPTION() macro
Message-Id: <172059262581.380385.3520658420031785227.b4-ty@kernel.dk>
Date: Wed, 10 Jul 2024 00:23:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Sun, 02 Jun 2024 17:37:28 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/xen-blkback/xen-blkback.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied, thanks!

[1/1] xen/blkback: add missing MODULE_DESCRIPTION() macro
      commit: 4c33e39f6201ab130719d44d6f6f25ec02e1b306

Best regards,
-- 
Jens Axboe



