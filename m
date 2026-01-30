Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87D30C61D
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769785961; cv=none; b=ganKZNjjG7a8hTWnjWmDWHHwnR/a+ZHdUfLxxYNzivp22N6vK2famgmRYrX97/mV6CGpseVh/0LzIXtla5TEU5c0GlykuQiyFtWJWtfXKLsgDMKIUUX/WreUdUyghOIZAysSzFi+nsNlYxRbrMumyLlf817OgB+DKkRCTjJJATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769785961; c=relaxed/simple;
	bh=iGeggJeQX9uYoahJzcc0RbYr/2cTy5sVq2dVoGX5ljk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B0Q6fGP4b0m5WJYaH8gcfWwcVL8jdYEoHS5zLLGGivTfm9cb+6lULzuxB8ScmDSU9S31Udvl57V2AUuFEcyC8clWuRTHwrzKK1l5x+do4Xcedd+wgowiGuSl+QLHrNhGE4OK5H+oTcKpMHU0Fw8pNdQpKU5E2nqmEtKaAxRNIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1j6qcEmi; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1j6qcEmi"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7cfdf0c8908so1333569a34.0
        for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 07:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769785958; x=1770390758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4FxRs3c+84UbVfsSFyOiWwW6/z7WTOgoT+QaGsd2WM=;
        b=1j6qcEmiriaqrzvBSXd3mrsbS6vzc04hbw6GkeDBpGLh9Ix1NER+LFUZsp/LAbMBLK
         Kqvc5ZaqrpwlI1qmC+RMFUQYhioQIic2CW93HRTEYeLupWhYTNLlBVD3+NPx3yffQX5z
         hxV22rDrC0FwQYtrB3KR5SAxgDPt6PM9a3EoD3OAt09ZmcS8K6MIf48Jq8QWGnCfnK6p
         SfYgMUhpagELCcl/mu8lfJTsN3CGME3bdSCm8EMjAyCu5VBAbdsma9bOF5o2wRCBuuow
         IwP+QXLxxd4Uik6qLnYD+KGUq0UkQP+GCXRUCaBdiFPlQT+2M7cS+vM1paTprpzvPtdI
         0ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769785958; x=1770390758;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i4FxRs3c+84UbVfsSFyOiWwW6/z7WTOgoT+QaGsd2WM=;
        b=c2PoqEVR2vYr1l2cjF4eNwmHxmSV/7R2RTYsPOKwx+cYbPTX0VtMEokPGTL4vCa0Fh
         JQe81PK+TjKOyUXZn9dW8RZm9gXxfmrIb5ikFc1SeDkvp3099DCWbvyTbUZAbA9ucULj
         9dWoD1N/bCgD/08LZSLMHuNcqx2/DswrmobkJFR1c9dtdeikKhnSWL8J69cnGh4kLCvD
         VwtLbAdO1NKkFReFk0JvbOTgjUlom/SFjutSL0SRjzFWbA8wNzvtrnNzpIabEAr0Ehdy
         XOgj94gGTR7HQ5s3uziTFeZ3AeJfzJOlyM71WpkSRIgY0WFLXLdNYpj82lWC1nKu1pMM
         XAjA==
X-Gm-Message-State: AOJu0YyEYLnwRgbU+SxYRtZKaethzI3BYSmY3YSCLf/odyN4r16sA6aP
	oUuRVZh9aM9s7DfqcFxmQARobz7MUGF0RncRMR2UqncCPyXQOQBvH6A+nLhHl4SabQ8=
X-Gm-Gg: AZuq6aJU/Ncf2SJujyDBgeNRNy3sPhl8ubmjV5blX/Z4RW6clV5EKo+EApueybvClM4
	Cd2xa++W16FDxyX15uA4jCw/F0JSKmAdC4qW607ya1GIrHFczAglVcsfq+C8mwEbQW1dCbZbqH/
	vl1ax1O1jUR0SyRnJ4z3hY8gj3jMIq6Ag55kbY9OyIQkrTleHkyAM58f3/dfa1G28YIroyPPX46
	AviOppjugDdgMyALZxMdVQ7Dh6xxOYwVcZJRyuDFZxK096Ou2z9sBspk0TVcPcbZJ+krojtciNP
	2aZFXXRMQa7WugcOGV1eJDVWZgWb8N2WKmL61I342wiDNUGYu0bNISjOtZwHyud+FQHsvvmyib6
	cn9PnLJGvEq/Jc4W7GqjAn8DwgU+hEKiiQRHT+wr/9tnhc+WL//RaIaEE7cGVk+8apEp2X0Iylr
	wy0fl4l8DyF/mCrSRGDhRPIxdd70pXMW3PZq3d6l/uIjMAAnsJfLei9uzo5WR4yYSHY0tLGaebJ
	Q==
X-Received: by 2002:a05:6830:929:b0:7cf:db63:e3dd with SMTP id 46e09a7af769-7d1a532b1d1mr2440440a34.17.1769785958416;
        Fri, 30 Jan 2026 07:12:38 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c69e632sm5685845a34.10.2026.01.30.07.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:12:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260130062846.1227392-1-dlemoal@kernel.org>
References: <20260130062846.1227392-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: introduce bdev_rot()
Message-Id: <176978595572.809940.5645724024309473376.b4-ty@kernel.dk>
Date: Fri, 30 Jan 2026 08:12:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 30 Jan 2026 15:28:45 +0900, Damien Le Moal wrote:
> Introduce the helper function bdev_rot() to test if a block device is a
> rotational one. The existing function bdev_nonrot() which tests for the
> opposite condition is redefined using this new helper.
> This avoids the double negation (operator and name) that appears when
> testing if a block device is a rotational device, thus making the code a
> little easier to read.
> 
> [...]

Applied, thanks!

[1/1] block: introduce bdev_rot()
      commit: da562d92e6755c00cd67845a8dbfb908dac51a9c

Best regards,
-- 
Jens Axboe



