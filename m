Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4BD302CAA
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773591; cv=none; b=RwvqLTZCW7zo0Wge38Av1L4XDPtLgLmol3kDD5rjgL+fWtyRvx1Aw8iqINVMcaZhTooHVNBDWXq+DnLNW5G9sohxWxDqxnzAnf9g/lZS+zyoMv8GW4QWnfZDgLHqBn49X1O5Qyz4fp+WEHzmW9muTcoD0BrsYwvVY4Rf0MxNRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773591; c=relaxed/simple;
	bh=1HHUy/3YvXeU6Y5WL8zn/5TMgd+ut8HpJPqmrGF81Wo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UIohhEzGy2Kze1hjTY4rkz3FfOjwquQCUg0j+xb7aKmhk1p2EEoF75ua5GY2aWHh1eaWt64JMVGIw9OVgae4wM4mbSKh6SZh4Dq9AzLzV/4onPKohh5Y5xYCyXeIPzfxiX8XUXdvPJipog6b1W4w3Z7yxK/7HyNl1eynSK90AXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B0d8R3D5; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B0d8R3D5"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45066bee74aso1593624b6e.2
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 06:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764773589; x=1765378389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqMdYJKNtpqnFCa+gHYL+8XS8vWRB2K6+SiBds0lbTw=;
        b=B0d8R3D5qXo5k9XoHKzhDwEH9wnhkci2pn6dqKVbv1BlDtXOkYB4J4RT83IvGM8Vcb
         j+jSrqWLeAHkAMHg1/QlEVRcCPt4wpkns1KTpm4KZ1LwOTu0auEFtHmZJ0vK8nXQArfH
         pBwR0i40LrhLUZLXLVwrjruHgEAGPAA7cT7DMxqnLtd0OlMbVcxR1KRtJYwSbqNpc0IG
         lsLYbOc4sLx15PazeeKY4DQKmQo6TYOewEuZ5SgfjLaYcI8Dmx4+ZJ2aJxwRHoc06g6F
         L7a5VjGZaMN4S1HoyTFBtf12d59LITR3x2DN5V12R9WUEvAObGDxgJDJYS46GFMu0/4p
         xZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764773589; x=1765378389;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RqMdYJKNtpqnFCa+gHYL+8XS8vWRB2K6+SiBds0lbTw=;
        b=PU6WlfmyEDn6m2k/wR8quljdBSZ4ezBl6mEkC+XroVPYxiLmh9U1FcUFupa+6OCUXZ
         Ki5PI0s3LvW1wwig3dEuXucITg32OHGtt98EJqpy/T6NlL1Qe1MMlDYIO6UlfkpsclGC
         LSkC86JMDN3CRfL6yMOeWAFB0CpZMufjtGTSb3gphEOx0NN1VyzX7+qWd9Z9HsGRAkm4
         oNI8lHYr7VC9xPiLW3HP7istDUZn8AEW7MpldjDM1oxIR/Ifm9g7fjzRmZUKYnN7BdVX
         Ewft6EzD8GsYPI7o3vrD3e3dBk/OWNjVELf6Jm9HREYGMTvQA1WngNhmKgoG6+xrvEio
         zbkA==
X-Gm-Message-State: AOJu0YyfeuEWZfPpwTjp3KEbM+NraqNgMYWryH3fqOWj9sLFUDa1VPm1
	z9/h4LLfYQw6sQSVgbvAgT/ShRuA8K5Sdp0fzMK748NOe4LCi8aGEbLSz1z91Reqm+8=
X-Gm-Gg: ASbGncuHjdn8/Q/xyvgSro6jbLT6GLgUPPhcPzl0M0HjbishvcFd2oHOQZZsEMUy8xp
	WBIiNw4XQWcG0s6766EswMhxShZuFrVk3RlCWF8R0tGgZTTHwmoAAVKjN0P/Gac685q3BcI83XD
	1HGxCWsQsGEZKux07al15jXwkYhDH1/yRc67H7Cb7u+8kTgpEGBxfNg2kc0WN+fbZ6pptkIJ00n
	prhCYTErcybLKfRE1Jvsgkp7COAbpniV7718A494UjDsWgntSdpXAiOauU+GDr87OuXdRFvUQW3
	HsCOsfxGNOeCwM0/F4oToKEv/Rv8gqHxGiQYln+tqNsHybEpx+nKeOcFdrWEqcCbbwYqdWtsZwO
	aMLEjFinSgBrVkek+r63AcgChF9YtgI7pjjw4u66mAR9FNqhJns0Bs+akiQpoNLT9p9u6bFUOoK
	HQwVi26DTJ6Fl6
X-Google-Smtp-Source: AGHT+IFGSMja15l26XwVOaOiK4nD4iWWKzjJ/wcAt7kaI/lXAw89EczEW3iLJQf1wj0KMvfoXau6rw==
X-Received: by 2002:a05:6808:c2ca:b0:44d:aa05:ce74 with SMTP id 5614622812f47-4536e3f0af0mr1267241b6e.19.1764773589022;
        Wed, 03 Dec 2025 06:53:09 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc55bfsm5953139eaf.9.2025.12.03.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 06:53:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Mike Christie <michael.christie@oracle.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-nvme@lists.infradead.org
In-Reply-To: <20251201214329.933945-1-stefanha@redhat.com>
References: <20251201214329.933945-1-stefanha@redhat.com>
Subject: Re: [PATCH v3 0/4] block: add IOC_PR_READ_KEYS and
 IOC_PR_READ_RESERVATION ioctls
Message-Id: <176477358760.834078.18043119459557804028.b4-ty@kernel.dk>
Date: Wed, 03 Dec 2025 07:53:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 01 Dec 2025 16:43:25 -0500, Stefan Hajnoczi wrote:
> v3:
> - Use checked_mul_overflow(), struct_size(), etc to avoid duplicating size calculations [Christoph]
> - Don't use __free() from cleanup.h [Christoph, Krzysztof]
> - Drop one-time use num_copy_keys local variable [Christoph]
> - Rename inout local variable to read_keys [Christoph]
> 
> v2:
> - Fix num_keys validation in patches 1-3 [Hannes]
> - Declare local variables at beginning of scope [Hannes]
> 
> [...]

Applied, thanks!

[1/4] scsi: sd: reject invalid pr_read_keys() num_keys values
      commit: d832d9366b072e76b94344c0532b7067536b3ef9
[2/4] nvme: reject invalid pr_read_keys() num_keys values
      commit: d7d07c1995913f23fe6140fd8d7323c8b923680a
[3/4] block: add IOC_PR_READ_KEYS ioctl
      commit: 51f31451b34d1c5d8f16d1dc6ef481d0b49441ee
[4/4] block: add IOC_PR_READ_RESERVATION ioctl
      commit: e78d75d1fa447ce2b66799f1ccdcee61a4951a79

Best regards,
-- 
Jens Axboe



