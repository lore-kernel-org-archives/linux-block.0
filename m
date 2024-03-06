Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713013790F
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739329; cv=none; b=qEFysXxeovT342sFuYm0cFvazsRZZhqVZvV1IrzChRWij92AnCVjerGnN9x81S+AM5G3dMxoqHz2nwR4Wh8vxffX9cznRYGELT878Gy84zd+gOZJYCDWxQcrHqPxfbwhbeOebgwO/3anag7p7zwwLBKm6eKrClb84x1QaERth0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739329; c=relaxed/simple;
	bh=EiaDPxdGDvN95P2aJU1WedCYWLCUVsWbHIRBxi+88aE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ri7w/kY7O0uHndmo58BI5nyT8Oh4o0VB2Q6erZYjzryH9+2RpvE0TmCpfOyxxjQNSxfeA5/fhENLN2CsWCeomVSDIIsXSNydIa6jPx/9woCoEA8a4sQ7I4LD8DzxU4byAA/XFQ/rYSIfMZqKjAq/rQLWa0J/fAGm+9sZ2VTeH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sRWyUQvj; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sRWyUQvj"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-365b5050622so1989325ab.0
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 07:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739327; x=1710344127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz9dhqOr1Ud3NvOw8Nr6oScIMnP2/c+zHKrweYL0YBs=;
        b=sRWyUQvjOXUwVj8D/0Xxoh8diWddXU4gt95TNjZbjABv8xvznqF4jHMBMkZNNG2k+n
         y9yekxZ1pxx7zG/naQ2csbZvs3vbin9SYSeYnlSu60pR03TfxaSoE1lK1C8xlf4hPfvg
         ESVbpdT9gUtSgt9kegVCi4+PVxfiu5jCowv1fCV3Q5nit3K2tyLBn6JI/EN+ItL7clvd
         sFZ+vW2wWVqMpHXFuXzPD8A8siMneZAuoUkZr8ddb4O4SMBVSxBdvi7+2xI8sfp/NVYZ
         SsbCd6lhqe/fJCps2ZObUJGhwXyoboAzu0EuBXAM3ATx0o09n/l8s3pvmhaDxXhvyfhS
         KQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739327; x=1710344127;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iz9dhqOr1Ud3NvOw8Nr6oScIMnP2/c+zHKrweYL0YBs=;
        b=j7lR+jWNhzoV/wy+6to1wgxQEt+SazqTRnJsKZoomcqxpZsk0QaJN2ytFPLOenMUvB
         vKopI/TXafYgXBkisKXKabEHSYhlVzjJHzHiXryT1atzgL93JG+2neUjOU+Nc1TX8x7v
         APALXoAHqh+VYMgnbtjHtT3VkbhUNbD8DfMmsTX3wfeyoG+iZU8+ohc6r8eFWYyKUuQm
         iEX8xsZnBUX5u5ItQKIqP76B5CHqywqyrzzct1ezSDhwmg/8a4qqVHm6Kqan7DzFaHxy
         YjsCg8WaHRZAFXeYFE11RzUBttD/mvpHxcV6VgYL+gvZoQJYeLms683UtK5IMHFLRsVo
         Vgzg==
X-Gm-Message-State: AOJu0YzDdvncKTQWWYxVuTOttHlXaVPK+xz6eAVIYihfCOt46fJlJQdj
	5Xy/UDL1WMdYVwPdB1mnoMsS6gZOAf1eTuRoEogNUD8XvKHAXFpDwTPY2RiO7no=
X-Google-Smtp-Source: AGHT+IEpMKeCNyHuNQ869Uxn/zSRMMkFXbQBjmfokpxdpjWTw93gaHDde4ZmdgkX21NmrvO6fw7Yhg==
X-Received: by 2002:a05:6e02:2164:b0:365:4e45:63ee with SMTP id s4-20020a056e02216400b003654e4563eemr4170290ilv.1.1709739327454;
        Wed, 06 Mar 2024 07:35:27 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: jonathan.derrick@linux.dev, Li kunyu <kunyu@nfschina.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240306100659.106521-1-kunyu@nfschina.com>
References: <20240306100659.106521-1-kunyu@nfschina.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_sed-opal=3A_Remove_unnecessary_=E2?=
 =?utf-8?q?=80=980=E2=80=99_values_from_ret?=
Message-Id: <170973932485.23995.10515626710283058348.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 06 Mar 2024 18:06:59 +0800, Li kunyu wrote:
> ret is assigned first, so it does not need to initialize the assignment.
> 
> 

Applied, thanks!

[1/1] sed-opal: Remove unnecessary ‘0’ values from ret
      commit: 2449be8c8cfcbb24b3cd15d8b55c2c91041c847b

Best regards,
-- 
Jens Axboe



