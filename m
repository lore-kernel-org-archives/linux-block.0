Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629BC322B62
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821585; cv=none; b=aplkG24tbbFqHd2Fm6nSt9+5KexOLhO16bI5UGxmP/GbMC3AvQSS5o3gS6D+9Tuyev5AEBhcOf4Bzd+e//b/n6Zxy/HgmTdSOnGqChr1npQfhfaG3lUjre9M6ARecMZKVxeMOacVVWblw2fSSBSrODkrTi0uSN7P3rhxuTlx658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821585; c=relaxed/simple;
	bh=rKVKnsmZY5Zk5WseCbLhC70tZU73oYSI0ZX68nvqOpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjKoE5tXBKpkgH4HMHU0Eo6bUMelDwcqfCqXT6E/g5Pjq/g4eZtDwGdXusHWVzgwR5MIYuAWMjEcuHEbomTsRdGWHsTGVAKCONSfyDgHAMGItXGPREgcXrqQXumoMj+9qcDKp7IwIJS/kRlsoVfWcM8G49GAfLTgaHTbY7LnXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWcISiYv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWcISiYv"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5943b62c47dso3758742e87.1
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765821580; x=1766426380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIbn2oDFRSGWfD5W22SaWrURpraJkYSQ1nm0bbeV7eo=;
        b=mWcISiYvQDMyWrcSRycAfbgC2LcfDHeiHNEwlrIHZIiej1AYC1xSGsNIQAQ09hrYkV
         JX5RKvAXPuBpvT42pleeeJWKLBH2sgmOEqfv/KpJmG2j4MZwEb/VhmN2KUWZSKmpR4y8
         W9Y9TRYiK/LUJSWBxJeCtVm6+grs9CMML+9OjkE4C8237semIawFtJN/0+n1tfa/B4sH
         4PXZxM7CBczsbeXD5LrxS/cB7X27CZ/SgFLeQqgNRSooR0u6fqf5viqD1bfmET98d1BJ
         y+OTGkBGOVpj54S8EoEEBS6SOazJkp5BEh/6fqKDGAxYCvW45iAXLY5VypDKgUjIZ0ta
         NCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765821580; x=1766426380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIbn2oDFRSGWfD5W22SaWrURpraJkYSQ1nm0bbeV7eo=;
        b=L/fixQ4bTSLRmpmZF2KwfEDJSSiVXOVOVa2q9dZds5IOUVywtQbPOI+eBIs7F4An9t
         BA9hjcGHLC6rUw+3vjG9mfOFoibUI5XQksBhl8HcuPSw1vgnSsYf2ZRX/PnL6R08bzLY
         bSXW2kX7eva80D2jv+r2S9TJgkn+cR/c7S3/8OZi1e5sJpPQgaIuWd1EJT3vMpUbXFKC
         w8hW6LH2xUIJdPvYV0KpkK3FKMmmAt4aThUEenG9yfztPaCVIfnOByXDc4UMDT8Fe95u
         e6FM8t4jMDmh5Yz8VyDRu4F/v6EQjxxLFzUTWnhsPoa1temCaGLZxVAoSWzX5IoFQMYB
         sOhw==
X-Forwarded-Encrypted: i=1; AJvYcCXZXXGOWN6g2Q0JlCZbClTbxPoSwXx/j0agUFQCbqYkS+HR/UDrcoxdBgYqzXBp47gdxpupueA5gNIxLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrfWwN12bpcZaWhPn83fXYiwi5mxLN7FJoJMGdqGGc2XMYesG
	uSiWlwrcXTh+58c8q3wHGkDP9IquVgrzo4/yNPgmsnPygZwChXcq5XtkVGZMTQ==
X-Gm-Gg: AY/fxX4zQ8Scvpb24i1UMXHw+7JjrCAtM+VcsWzrSkV/sef0a+XPMRW4udTT8QyNqVd
	nXXAq1I0kYDV9qPWO4Kub+b3876l5o9tWsXod6I60o5kq8u1928vzTiVjSbaQd+Kqbf1lTC1sUQ
	lEP4DbzunuSypQpMGoqkwyvOQj39RPPShhO3BFYpoVyPMuQ5575Eejv5/BOwMnDvVu9II4D2vBr
	JYliYVJO3GJlykarK/eUBO4Xq6gnrEjqbB8BRCZjocfUtrCmortX+2xSxAkQh2/137kSQOdcS+e
	7HK3vKsaZZM+r915K7CytskU7PvyhSjwdkQOw6LVNUw74tHnGJIUBoFV3THziMH90g8hNC+I/vz
	Gq8mwTAQ+QJk3a0drDp/s9kMgV+8wKyKTbHfXaSVECheOMeL9IgD9VzDCD2GrU48/+DwhODQl2H
	tsWk3W63ye
X-Google-Smtp-Source: AGHT+IFsDUVoZATaLzj9N1/hjfRE03GZ2gIP+Qj4HQeX9tt2ONoJL779FMDFpau9DQULSPR5u/L2Cg==
X-Received: by 2002:a05:6512:1154:b0:597:d59a:69ca with SMTP id 2adb3069b0e04-598faa4d5b5mr3889154e87.28.1765821580147;
        Mon, 15 Dec 2025 09:59:40 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5990da11dbfsm5648e87.13.2025.12.15.09.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 09:59:39 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: rdunlap@infradead.org
Cc: initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 1/3] init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command line parameters
Date: Mon, 15 Dec 2025 20:59:27 +0300
Message-ID: <20251215175927.300936-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5c3c4233-3572-4842-850e-0a88ce16eee3@infradead.org>
References: <5c3c4233-3572-4842-850e-0a88ce16eee3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Randy Dunlap <rdunlap@infradead.org>:
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.

Thank you!

P. S. For unknown reasons I don't see your email in my Gmail. Not even in
spam folder.


-- 
Askar Safin
