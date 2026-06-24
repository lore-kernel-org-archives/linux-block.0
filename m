Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADEB3AFD07
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305629; cv=none; b=GDdoEywlnMOFTS0uqzAh35yhpIe4cKcPv8bIGioVhgbdARbeUUX/y9VqLLLCmXlT4WV2FhgpSoGsG1kj+OBgHmzZC9ZNDiNrb2vGaLqplhOzH7WUqtt6JDAma/Szu5R/HdPhLieLtlpL/yTrUaXQA5pSAbwpBU4AasyxeXNxFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305629; c=relaxed/simple;
	bh=mTdaQN8LkgQU+MiolN1qp2+H3nexCz7HUCSEFaTAmVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jDsF9Yc0l61XGYbTFHAAa3pVMITCrD+b/Ovzu8jWz18slMDD9+DVmijsxnOLQmCcxABD15rPpMeWX2czgH3ZsldBLoJD8tf+olygrzDDes3DJPcwH7jmuYTcJocivI/A96maLfV7haRjXSVr8G6tv2J52WZPbalrBw+Azu0pyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=rgHoK1Ch; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="rgHoK1Ch"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a11eb98e8aso430687eaf.2
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782305627; x=1782910427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtWRsOSBlkOB3lvzuGUtRSaUPQB3QktMlLLVlQgCXU0=;
        b=rgHoK1ChygRYw9ZyzwkEsMpIVBK3iUVhWudTe0SGLApdoiIbWESDqh5VNvCiAe9C0l
         CsfEPRB2izBdKNHVrOesmTJVi+jqSnVlXFFnMRmy+krvuuy9tlgrnfFNOgIgjnubBhkf
         VkLt92/QyQPxz/zh5AUSfY8Rsr3y24KXPXi/w7jpHCnL+GQLcSmji3qK8Un9gjdNJwx9
         LDrg2tSXjfGRxT0jUFhdRvUcPtsH3zpSFSFVVBcM2xZr4vK+hUCDlMMce9Mtd24qeHbZ
         xNP5lp+GgBAKcfpJObjpZ6ryXN1lJHnAsdr2FWj+Vfu2oOkXCEf5IAdkPXbbxjoIa/c4
         xNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305627; x=1782910427;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xtWRsOSBlkOB3lvzuGUtRSaUPQB3QktMlLLVlQgCXU0=;
        b=qOg2uacxj/JiSjT/nvvgRqAFVMevhxUutZRtrJGwBaz5FapjWGf99P4C1v7b8sVDsR
         cuKMP/HhMTejq1Y57RB3gl59LxWe6N1U+VzWEbyXXizdAcv24pkdpXJi/WjwZ0UIq8rA
         jQcNESadoDBOXKH6PUcXcEa9ItFljUR0O2Sov/eJU9nx2GWKWIno8MWMmREGXH9rp69u
         R9IzyzVY435QgKkuR6E6vuRiBwuSm3hB/C3CW+RVqNXS9X4T1sGNYj3Yfcf2ihxKzvxs
         B58j5UTuRzZHmYkkDv7hleN5a5sy0C5qincyue22XMC8zV3JFdK06pHUk5vb5fIMu3gt
         o00A==
X-Forwarded-Encrypted: i=1; AFNElJ+/WvbTX+fFIzkWFzDgJJwaa2N7WgjaQxs4sq5IS+CoMZ4L6uHvqVmIiy0SVGd4thgO+DKGBLukfbqsZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPtxHv3VtKVAz+q2lSonMxlG/PD2zmaXjmelVvrGzOB3AfUKmq
	HHI4pktuDGs/KHmMRkRqHA0L8m7n0J2+LYWshHzTw4EJ2JLMWApvxMShBRnto+tQACLbNqgHVpp
	WuW+W+8g=
X-Gm-Gg: AfdE7cngECimKStsvD2A8gTupeYQtoQCABwvCgMGsT7XoGLxdj2wDsVXVriuAz0OvXa
	KlcE3ufJYHtN3lUrA8najCGdBBecsBFzzvaZ2sZY1JyYJwkg8JbxIfiogo8Q5LVnO3c5Qpi/SBU
	Vm5AT33eOWyGy2L9l3SfCUW9UwmQr2lxw17Vtc+0UxlOhQzc6oaU0AlG1nAty/a+Ge6DPk0J11O
	jcN2zNMAzm3Lkyecw42WIDqeBCjIDWNPB/QEXaEbbDoKlwx8JgyJUB6DzR3YixNzCUAo1nESpMC
	AOEUs5T1L83hnDkmYlYep0u9kFN4i543whYVVcJ0c0MtV114aOueqNVdb4YpyurCsLumE/L6U6L
	tKw+j+twaTF6y4u0ygUELx6mC7QqgOi51QKNrdyhj3f76ZkOYnqWcKXDoaAOa/XllWyFqOmHJ2i
	S0sleB299CIrDSRHyVp2fgZ54cj0NCkjqKigw2QCWKzSLtYf1Rcpwn+/CuJc6EGgqyZQ==
X-Received: by 2002:a05:6820:f024:b0:69e:41bf:fdc1 with SMTP id 006d021491bc7-6a122f089femr2020504eaf.19.1782305626907;
        Wed, 24 Jun 2026 05:53:46 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9faf29asm9264161eaf.8.2026.06.24.05.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:53:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 linux-block@vger.kernel.org
In-Reply-To: <20260624080014.1998650-1-hch@lst.de>
References: <20260624080014.1998650-1-hch@lst.de>
Subject: Re: PI fixes v2
Message-Id: <178230562426.29628.13170407852267441350.b4-ty@b4>
Date: Wed, 24 Jun 2026 06:53:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 24 Jun 2026 10:00:01 +0200, Christoph Hellwig wrote:
> this series has two unrelated PI/metadata fixes that came up
> during a little testing surge.
> 
> Changes since v1:
>  - take operator precedence into account so that zeroing doesn't disable
>    other GFP_ flags.
>  - add a commit log blurb on why Zone Append does not require remapping
> 
> [...]

Applied, thanks!

[1/2] block: fix GFP_ flags confusion in bio_integrity_alloc_buf
      commit: e7c1627afda2484baf65449be15873c2550f917a
[2/2] block: handle REQ_OP_ZONE_APPEND in __bio_integrity_action
      commit: a1c8bdbbd72564cebb0d02948c1ed57b80b2e773

Best regards,
-- 
Jens Axboe



