Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC114A627
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498253; cv=none; b=VRSQtO/RSikG5Y8jpC8KhJw66wpQmEk1v/QwP9e9Jui47QKbHoJTpkF3lsxAPJlPPnrDxe0mftmPgTlpKsD/ATCA6oMhvQ2kvWubQfpz3zI82vlWDPMXLUQL0ReA6wPHGDxM+59OIIYqwMRP8QP7pMSc2hwqAvX1AUDrsglUT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498253; c=relaxed/simple;
	bh=M+rmIynp+O1RcPF3wh/xEw9cDhFQl32O96orhBpPcyE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DjCI/Qp9t+NwoU+EUAq220im+lW1QITu3MBX0/WN0EcdnqwNPtOITk2S34Ied7uZajlwDHo2dAFQzG1d0kXOoTSZbocOHXTgFza+tZuyP5JmyLhF6UC4EsARgZP03QpJ8I+fdo0ksVkqrhVcTc4hjp7PyCrhepKC4hEKKu5dRgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oylOxP/G; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oylOxP/G"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so16793185ab.2
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740498250; x=1741103050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61c684Is4Axo0A1sNSCxaz4L4naeHUra5lJQHTcqa08=;
        b=oylOxP/GMppC+sheUAmxmX+K2HZ/fH92VEZuYCKPB33lZ5C9iSpX2fHJaux82yYlaI
         xxS+xD6zPQnuN2l1JLU8W/gvzm7nhh5BLGYcMOhN3fQlpWY4OzpiOxWJ0r4aRmVvjiHy
         d1qfJJs58CCx6bEUy6sd5d/xOoYjmU0wZ+Cx5b9AgazmBUeEkEysoxP2uOHN6rvFASld
         ib4ZEofhobiMboWKQRYdz4Vy/Em0BaFkfpsVHOIzZJYC17bSj50Ad+A0LB5mv7DhzV0e
         WBdJaUQmAL831qrxLotiDz92CtM9a536dMLVZujQMqCSVheHlBJPgDe8dpJmobWfdxCp
         iIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740498250; x=1741103050;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61c684Is4Axo0A1sNSCxaz4L4naeHUra5lJQHTcqa08=;
        b=BmHL4KM7rgB8OfqswnxJXl5VD9SSjqsMka9HzLT5hMtOlbjzP1wvSY0gZXTF14HFtN
         efS++5qZI1M1Q4M9DVRpj5DGkwU4KyKyyhFaScJqnbS+R1zxrxAgXAjYZhq+W8Ia12J+
         JeCkc149eW/JrePeFRBH9h679XiRe+tP1g4MDaW7JZG9C8ITh62YE3fMWbpGzXJLLCFD
         Yi0qBdwuUUPvF973vjhKcip6aNp+Yl/p+5VEKT7ZjT0gSR57dQcIRZTSHMNu8MIZ/RAs
         V60SeKvrCMENVajDn5UAEQKGzQkb3LlVEhjF9/nck7arwLEHTlGzzQllsk+BrJHVy5oe
         xePw==
X-Gm-Message-State: AOJu0YxEaJszh6wzbgMzzvea6tmWOBVcXTBLR2RmL6tiwzYHR+U6Tqki
	WXzsar4t5BlR4neLjdfSyBbimMusN5nMebgnri67UMAhVqfy572jO5kDIkElcmR0Xq5O1cHlsNF
	l
X-Gm-Gg: ASbGncsV6W0w125s/hoNPVISKXnwbglrbtgzcmjEQmn22Dy2k9EiPXAifNQOqldiLXr
	cYcHVZCUAc8pdH4QzCbpk9U/JxXNPQdW+o9Mx/pP7JPxzL/O4sWigt4sT+c3/ZVt56hxQkGS4F2
	2Fj+ReeqjVI8JC/dpCkNzwKVkQm4bO+OkHgmEQpY0WuukFU3BLsc6NIVsEW2hvj2kN3Ei1M3WTB
	22LeaDtTaHLjZXnICSe06UbJt9s30okfDSl9MhocXqBcdia9WxlXJanhf1n9LhzzZ8qXCcxGkJV
	Hf+T7VOK1MlVBuJ/
X-Google-Smtp-Source: AGHT+IFTQyALoW1kg9S23FSV3Ap0OKeFeZkA3Ze0CNSF58PPgAodOBnTUupL5i4cA+NFXJJuhaOHMw==
X-Received: by 2002:a92:cd8a:0:b0:3d1:9236:ca50 with SMTP id e9e14a558f8ab-3d3d1ea4a0cmr740885ab.0.1740498250218;
        Tue, 25 Feb 2025 07:44:10 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d367fef1f5sm3700075ab.62.2025.02.25.07.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:44:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai1@huaweicloud.com, Tang Yizhou <yizhou.tang@shopee.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250213100611.209997-1-yizhou.tang@shopee.com>
References: <20250213100611.209997-1-yizhou.tang@shopee.com>
Subject: Re: [PATCH v2 0/2] Fix and cleanup some comments in blk-wbt
Message-Id: <174049824924.2143405.7515075277897160831.b4-ty@kernel.dk>
Date: Tue, 25 Feb 2025 08:44:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Thu, 13 Feb 2025 18:06:09 +0800, Tang Yizhou wrote:
> v2: Take Yuai's advice. Modify the subject of patch #1. Move the
> modifications to the comments for wb_timer_fn to patch #2.
> 
> Tang Yizhou (2):
>   blk-wbt: Fix some comments
>   blk-wbt: Cleanup a comment in wb_timer_fn
> 
> [...]

Applied, thanks!

[1/2] blk-wbt: Fix some comments
      commit: 5d01d2df85f01ce083e0372bd3bd4968155e2911
[2/2] blk-wbt: Cleanup a comment in wb_timer_fn
      commit: 8ac17e6ae1bf4625b8fa457f135865c1fd86beae

Best regards,
-- 
Jens Axboe



