Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B0296BBC
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234932; cv=none; b=uk8KdNq5hfxhArogyZuNGRI0teD2k60GrLckTqzwQvrRFmWhePEJw5MuVEwRBS7CO6JBoXHdKjAppYzPx/5S+K4yRRO99ToNAggubmU9vjqXr9e2vrn7kkU3VvJlpIFdffKo4mIFFyub4+s65MzGs1Kb/21/yXaZ0OzwZbc9Hnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234932; c=relaxed/simple;
	bh=XRbTptgeLfFnGVjoH04s96CXwkSL9pA7ZPa2F/LCxg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYjEvM70gVrpnLc+ozK1of57Ia3wR9SGEyLK/AH3gbArdHHI/sPaqHmDZZGtl2zilKIZilWIQrxgPkqI/NMU37uBCIFjU2DrMNwfk41iLo5auX9yvIk/uLvnLA185BthfkMRonDWQU6/eL7x/EcbwuXYpw89nJvk2vc5E5n6IiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=umXtWpNF; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="umXtWpNF"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c75a5cb752so4963423a34.2
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 08:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768234928; x=1768839728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVVFSuRsjCwlvtdi0lzW9JD0Eq2NEbemzwA+xmgStKo=;
        b=umXtWpNFyiocBWXkk5T3c7suw97P3l9pXtNEfOT41oGK2uH4j7BwIO/Z/Le74TscXs
         JxOMCmBJmZ+7Ul3I4xoucNXNSiL19wXqmR8vvY0QCDjhfbap/VpdOa1WRRJvZKCbiW8/
         Iq+sQHonDodsgbzPtr4W7Vrtnch0t+ctBnNaQtn8GrjpljPsLci3WZCgYrl/qRT1ffMw
         mZxQewVO3cpn8WC7yjWEx/O4mQCsBEq5opKJc1wPNF2Hhdn7p4lAI2Hj4CeZFGBPwWBm
         OHv2xuBlU5JZXVPv0XPcmTcQSUEmir6lu0Ul+02qTUsoez/l0XmTWHfc2XGMYJ8m9vZb
         iEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768234928; x=1768839728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVVFSuRsjCwlvtdi0lzW9JD0Eq2NEbemzwA+xmgStKo=;
        b=ktI0cKZeruf8IlirDlpTCGXFw5j9UrXDvGiVUpsv0/eVpZGThf18lfwl8mwhyxMrwo
         f29dJG/0H/sgG1DDoxYQu9sOYFEgZjQQBmzSAe6dq/+XTiMp0HTqUjh+O5RycHZw7Oqh
         Oysx9PNcdEdR+gCm4ev06kIBzWoO1gNReO61yUl6gnOe7i3J6ofa0B5YcBn57T+IVNUk
         q/6lkNlvN6BhSxiM2qDeuSP6agjtMIoszpt/YHRagAPpBHa+ffqtgF86WdZrnh3q8Omr
         rhtkcWHFrh/1zjCrTPA2fZOkC8mQwYb3/647LLqw6h1TvuWUEoFtgVW8j0NkGOoklZHi
         seiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOz4TOfQx/iNvtWxF+ZxlQdfksPAUyZdDJgRvEJE1/lIX22xR4fGkVIDdljqdz+uo/Z9lH6+aTYC5UBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnbCr6+fPcP57EUPU2M4wIA+uriYWZI1KUqH0VOU+T7vDGn5F
	oTVJ9Uyqwluo6APycFmmcehHCV3+GLpJhbDhot68iMudca62UndDH/7eMKt0e6j+n7A=
X-Gm-Gg: AY/fxX5RnndE0HBCZNNnXup/vBb6esdjEow+waf12opazHh29nXwT31YRxm3iM44wJv
	L3p1ji2ceGv7DiSYFVdjrnENmi7BUXcM9GcdHSdD5CbcnHsEtitnb9Zg++mOqQuupNx597IZg1X
	B1qS14BbHNNiOpG5gz8PM/O79LntiN16NfGJVleuxKaaEv+tWIcrMNM+3uR5wkNlwEd4iakY8v9
	zWXXKpK8KjdJiZgoOECpHAiHUd7sHWxmVOnQ+uVEsv/G+vT/I/AhaeYwovw5lKx6vNvpVHxGUFl
	QB6Z5jWMAK0I6WMf8jVCGkMJwC3IMJJ/yqSDpfEez/utLFRQtFh5gkWEpxIe9oRDRBAgzKbqgBL
	Lx0HxDSKSSCR2Btwkxqy9zHMJnGrdcBAD7/npRaZOojFS+f+uLExsLE/IsRipulpRQOOj66G2qJ
	HH7+lBu8Bt
X-Google-Smtp-Source: AGHT+IFFsc7r/7+E50VF4hpRtDV9+pB77kbt9rvAFuWuRdpCwk4Sm7YH51B9GMYr3a6b85MuDDWX/w==
X-Received: by 2002:a05:6830:2709:b0:7c7:67be:8ea with SMTP id 46e09a7af769-7ce509e793bmr13194543a34.18.1768234928395;
        Mon, 12 Jan 2026 08:22:08 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4781c43asm13237437a34.7.2026.01.12.08.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 08:22:07 -0800 (PST)
Message-ID: <b784bf25-78aa-42cf-bf3b-0687d9138139@kernel.dk>
Date: Mon, 12 Jan 2026 09:22:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] ublk: introduce UBLK_CMD_TRY_STOP_DEV
To: Yoav Cohen <yoav@nvidia.com>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, csander@purestorage.com, alex@zazolabs.com
Cc: jholzman@nvidia.com, omril@nvidia.com, Yoav Cohen <yoav@example.com>
References: <20260112133648.51722-1-yoav@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260112133648.51722-1-yoav@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please rebase this on the current for-7.0/block tree. It doesn't
apply at all, and hunks like:

@@ -311,6 +312,12 @@
  */
 #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
 
+/*
+ * The device supports the UBLK_CMD_TRY_STOP_DEV command, which
+ * allows stopping the device only if there are no openers.
+ */
+#define UBLK_F_SAFE_STOP_DEV	(1ULL << 17)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1

is a clear sign that your way off base at this point. Why else would
STOP_DEV be 1 << 17, with the previous one at 1 << 14?

-- 
Jens Axboe
