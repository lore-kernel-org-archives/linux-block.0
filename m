Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D413666F
	for <linux-block@vger.kernel.org>; Mon, 20 May 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716214086; cv=none; b=gALTLXxhk7/Cw1TVc+YOtjYmokqYuU9TlJn4fmLw/mwOmbt4dEDmcP5N0aqG9H9lYrVGUhfHXB961xtFnQHol4RYvhexQ8BgnWb6hu3zycdhxRszHqg4OXEVScVVPqFDeRYSCSmrOZb+qtf9WcifaOZ5eHKQytnic74dUXQsKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716214086; c=relaxed/simple;
	bh=jejequIZLQUkXoRwRN38Pai8FJ1AhPODk6cIdwLFiZs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UDH8SkIYr+vUotWq/zWX9A29eqNRoJRlrUHwHvX/HKJVZUzteXxkIBLhulliURCISEGqzfsxnC9FcKypjakXvRVzfnxHCuBbgY6e3zS4453SrjqZsDdLmghvgVorbbZlsufjgqg9WJtBbdwrzh4Coys+yaeUZWrfS66p+NPSDX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q1rmb1I3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q1rmb1I3"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eca151075eso6740895ad.1
        for <linux-block@vger.kernel.org>; Mon, 20 May 2024 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716214083; x=1716818883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUPDjNArKJ3mfUMSjW2yhq61IQlP1POL1CAjSweGz24=;
        b=q1rmb1I3UB2MCbhXDTl8HJk+JlONBra45FPlNABo4ewLHWHA8JXEGtzcm6JDV/G5Z3
         3fqtG9AJA1wtzwXgSg7u2uqyrKK0NcDIqs23OIcYXFnmAE8p1vzcyw/RRnq3R2w29PPf
         3gRxtUNYEzUCgmDLwK9Dm5f40o27bx+GDp7QOVSk4ctmu5imbWMJ98Vb70N4b5SySZ/L
         h3W+CCbHKMwFId+2iQrP/iPZQJDHdKAUjxlCkPdARia5DYqDHKH90faKzgEB/o87W62x
         NxUKgdIAYdU0+kgpLgykcF5eJSfRiF/i0nb5yrbYE1GprVK2ZKNwyT760abN44mcgYnK
         J5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716214083; x=1716818883;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUPDjNArKJ3mfUMSjW2yhq61IQlP1POL1CAjSweGz24=;
        b=WYVgEYi7QwB8E2KpPYAeZHC4h39NDSP0iIBMLF2UdcFJ66L29wAi2mf/Me4Pp3OMG6
         JHklEqZniEuqYjf9N8luceNtu6i2NxCB8BeaOsOzNbnR98MhAscabcSfF9jWsPJKhv3I
         4b8WBUCFTNJaER8p+LMUxrpsSaYxiO6jLATARE9z/wLXsfqU61PJvW0RxsRpSZOJS8nF
         Yc3lOH+ai/hlnY2bxuFF6fLRFPF7DuS741hifpkfMV4cRDBoscxcd4TdKwzMYaY4jGXZ
         hoH26T7ILgkzLS+L5Ei0+uCfyLoPhVLeijPxRh6KCi8JVCBj9HdnwRMOXz102px2p1yX
         tZQg==
X-Gm-Message-State: AOJu0YyyclR315+QrYzGI4r/RsGJcfrJLhs57Gp2axBzzzazLRDl0YEX
	p43qpwpwMQ83eFaeTGhGN/2N6G0WnpW0r58KdSw/EdIdIFwBenSVdfHfaxfvu64=
X-Google-Smtp-Source: AGHT+IFRAVhTX6eDNJiRwOPpKgGY/dBfWAVh7Azrv4tnNy307MGqgnnXihGSFJR0EEXwooshsV6e2g==
X-Received: by 2002:a17:902:d508:b0:1f3:358:cc30 with SMTP id d9443c01a7336-1f30358e620mr23191555ad.2.1716214083522;
        Mon, 20 May 2024 07:08:03 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada431sm203721085ad.100.2024.05.20.07.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:08:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240516-md-t10-pi-v1-1-44a3469374aa@quicinc.com>
References: <20240516-md-t10-pi-v1-1-44a3469374aa@quicinc.com>
Subject: Re: [PATCH] block: t10-pi: add MODULE_DESCRIPTION()
Message-Id: <171621408252.12318.1975684366197625365.b4-ty@kernel.dk>
Date: Mon, 20 May 2024 08:08:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 16 May 2024 17:15:06 -0700, Jeff Johnson wrote:
> Fix the allmodconfig 'make W=1' issue:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in block/t10-pi.o
> 
> 

Applied, thanks!

[1/1] block: t10-pi: add MODULE_DESCRIPTION()
      commit: f0eab3e8d1530b87f3523cee060004dd513a6d2b

Best regards,
-- 
Jens Axboe



