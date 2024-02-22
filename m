Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDE4153BD5
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621770; cv=none; b=Fw0h9w1xuFtdmz9N6kaUuqk1sFKyk5dc60oX849PVUUL5lDmzsjj2tsHxpVuWu3U2hehQi5z4nsJPtalYNOVkOc+H+CRNIBd3F1gqJ43YMgddmLkiuxNoVv0xjZCbtsVlh7juQ5YX6hqFNvZk1sCxOWFfSX4xjs7hVRR9+S+F8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621770; c=relaxed/simple;
	bh=celCtcEPOo2fHHqBOz3nSdK/i7RCfiSVSuhe9wgbjnU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=igMojQV/wdPdh2EN0FskfrDY4pgoEF9COpMxwweWBmQCxc+UuKJVg1dYRJDIFrR8clGFc/OObwfcVkpC8wX2Oh3+H4XWWQ59dfkUjLc725taaW/ymvkst3PQu5/Mil9ty/tuSkDrEDEzYlCYB99BMozzW1lxaDWg8S6iVlj31JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NdnYy3M8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NdnYy3M8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1db9cb6dcb5so8209675ad.1
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 09:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708621767; x=1709226567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsB2Fa2MB2AKFmE4QgPHpTanl2i0CQHMOV8hh32bbjQ=;
        b=NdnYy3M8jr4uc0Y5b9SraXjzlZj0RVtt8tIzyyC0Yy4ENKCjXe+dK3jkJQ+mTJQXRr
         /l28m5GD0/TVVRI8UWHMrA36CNmiJP3LdEIonrDSBbA1QSU2wCJzXiAbr/H7UIVpFRcs
         vVigSN3zNghgElceMbm8KIUrwMd4+HLE83qQIgqBSqDkyigIiRNkX8okNeBnbNl74EfX
         e9ONxLKho9qfnxRTI0c9Urndr+pRm543RHsp4zMhB/bGlsPvpEl+feIJgObEaHW1FJFh
         ZyXXeTJoA335TMPkqKE5ZdMlFWVnUBWTkj0CywKB1aMPapZn99nWdncy0uvKpfKWbhRt
         xcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708621767; x=1709226567;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsB2Fa2MB2AKFmE4QgPHpTanl2i0CQHMOV8hh32bbjQ=;
        b=EOGJMuhIetn9HHXQZtrpM5hw/jLsW8B0+1vznA0QFpxXmM2b1jHNcDjwS5o53F7ZUR
         nBhTNNu8mHLZP70SICSuCT08W8j8PgBLQYlWXsQxkG9cmWzhQ9CvwMgqP2dTbE8lKK6p
         lZvqcIccoxhUi5gsYecBi49vpgsNXkYre3F3ZWLjDxXxNzSgjlMETGYcpbHmCL4JhH9z
         ZMo4FIdQA7nyI/Gty7qcwqo/wCxj7TYQKS83hvXnhSaAjX9cU3GpVCUNML0uCL10+LzZ
         AXj+2TZr8RIyZPTLPdFSiOOLocEe6E5fGbdNYA2EKgDHvCXN1/i4CU/OH7sWkU7pVMC/
         c9Ng==
X-Gm-Message-State: AOJu0Yy4+S4nwXg9q0vMj//jNma5ac/bmeOmzwR2Ecdbje8XS1nAGNoe
	94x14B+qkOfk2Jzx7OuMasKGtT2mH71R2eqcDeTJD/g2otEXwX7QYeP7ew6XKFM=
X-Google-Smtp-Source: AGHT+IEQORPQqdSdKH5gSaxLmE90VNhie4CuVf5II+5mIvejOfv3ilBZL0Bs6AFZ+F2bWnN20Uf/qg==
X-Received: by 2002:a17:902:f689:b0:1db:c3b8:4620 with SMTP id l9-20020a170902f68900b001dbc3b84620mr3184232plg.5.1708621766846;
        Thu, 22 Feb 2024 09:09:26 -0800 (PST)
Received: from [127.0.0.1] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001db839b9e80sm10253745pla.286.2024.02.22.09.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:09:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240222073647.3776769-1-hch@lst.de>
References: <20240222073647.3776769-1-hch@lst.de>
Subject: Re: pass queue limits to alloc_disk for pktcdvd
Message-Id: <170862176605.8813.6292201088013363148.b4-ty@kernel.dk>
Date: Thu, 22 Feb 2024 10:09:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 22 Feb 2024 08:36:45 +0100, Christoph Hellwig wrote:
> this series has the queue limits conversion for pktcdvd.
> 
> Diffstat:
>  pktcdvd.c |   25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 

Applied, thanks!

[1/2] pktcdvd: stop setting q->queuedata
      commit: 6f420d6a2dd8d4a795eab2839b0e08663269f9f8
[2/2] pktcdvd: set queue limits at disk allocation time
      commit: 4068550870360410261638479ffaf8364c366dd8

Best regards,
-- 
Jens Axboe



