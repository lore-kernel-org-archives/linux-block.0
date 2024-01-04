Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD92D025
	for <linux-block@vger.kernel.org>; Thu,  4 Jan 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s4rGAajc"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdf90e5cdeso195885a12.1
        for <linux-block@vger.kernel.org>; Thu, 04 Jan 2024 15:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704409854; x=1705014654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtWKzPW+VggNnhjhkGvk6PwM7eD4b5VfXbjsvAZRsdg=;
        b=s4rGAajcagvdXTON4ibcIgMX5X4+HrGDFzDU7jr6tbabSPoI2Y4gU9qScJW079OaT+
         DQegsilY6JcWxrgiAC3fK65hPrDtRZYBMvalGiB1bRhiS10k3jbHne4qFP7/OBopYy3j
         cCrPEPCvWofbhqxGQWW7eGqphbpnbu0154m+ClbdJH2+mhDNIWy22n0K6L9grF0MJHa3
         6cJL93mzELrlmtUJ2Ht8wdmkkAOn+6OUhyufBN9/+3YIwslyOrTmEnOlVqEKukFpqpDG
         eCp+nAPiUwtKgmCleR72xNpKOVN4N88XviFvhpw3miS3T0qEip13NXQ5O8mjjbCx5W7g
         bUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409854; x=1705014654;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtWKzPW+VggNnhjhkGvk6PwM7eD4b5VfXbjsvAZRsdg=;
        b=vg21FsLLyDWOIy6alBn7qzHg3hrHaj6scTTekCi2QVrpX65wHrsD10rRoWVzWhmVPG
         1G/MB45/DHDbw85sgIZXfRkuG9nDSq/t/7k5KJSyHiudhAmcWiwXlGoyPKU35syl2UrE
         clcfqqKWSMy48AJgNikke3d1fJ07QWchqO5+0fZcZoJGUSkIzZDzja77Qx/38DffiwJ3
         s/izlZ6YJQM/otb19vep7NxhFPDXo5BAYO0pt8daaz4q604RcvnjzuqxwcHVZk5pjXKd
         z6xkO9t99/4g2YPfUy+KaumBYDLCZHVMsSwDLnCqY606bB+aIizirO7F3QxzrlTz+k8Z
         k36A==
X-Gm-Message-State: AOJu0Yx5h81J24NeewULOODWpYHpEhfiBrZQoUEYAxBEV1sqbyGSapfV
	azZ+waRmzicWCfNT3QNbnJNqiUt23VEGOQ==
X-Google-Smtp-Source: AGHT+IGU1glSIcKnbi9+C3kDPTLq7P1ixYqypmQFGI+x4/dzZR5aGRIoxmn66PhikKYpDvkjio+XDg==
X-Received: by 2002:a05:6a21:339d:b0:197:1c10:aa3 with SMTP id yy29-20020a056a21339d00b001971c100aa3mr2816239pzb.2.1704409853904;
        Thu, 04 Jan 2024 15:10:53 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id lo2-20020a056a003d0200b006d9bdc0f765sm179484pfb.53.2024.01.04.15.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 15:10:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Daniel Vacek <neelx@redhat.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240104180031.148148-1-neelx@redhat.com>
References: <20240104180031.148148-1-neelx@redhat.com>
Subject: Re: [PATCH] blk-cgroup: clean up after commit f1c006f1c685
Message-Id: <170440985277.724469.7162918731895817738.b4-ty@kernel.dk>
Date: Thu, 04 Jan 2024 16:10:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-f0463


On Thu, 04 Jan 2024 19:00:30 +0100, Daniel Vacek wrote:
> Commit f1c006f1c685 moved deletion of the list blkg->q_node
> from blkg_destroy() to blkg_free_workfn(). Clean up the now
> useless variable.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: clean up after commit f1c006f1c685
      commit: fab4c16c527e24c804efa4992b3cf40438c9b227

Best regards,
-- 
Jens Axboe



