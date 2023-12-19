Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5D1D149
	for <linux-block@vger.kernel.org>; Tue, 19 Dec 2023 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UivCMGxT"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d03f03cda9so10745555ad.0
        for <linux-block@vger.kernel.org>; Tue, 19 Dec 2023 07:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702999410; x=1703604210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0UOZ8VrL/oouNYdqSXbbgETnT3D/EQ3t1zUq6Qh2Js=;
        b=UivCMGxTSx94MzV0UFNQSLKrR34mNVFNCUFcH29GipSktwPh9zpXEAeVPKwgr3pQdv
         GS3lRlmEJvqn8c+y+zkk8dDB6wYqpGk+kv/14QNdAkujw/le+r5sQOXO5O3GFGS4xGF4
         JPp6xDMDYGC78EDA4iIs5UvZRmKuV3lhDHBGLQ0XHF939YQCWYNDZphgnkCMcSjosUzm
         1XGUE+WXgncC8grl7cATyNMolA/rYnYhqTYH0ZPgmSVdSNTybqgw97tLiLZhoDRFUuzI
         I9lUHgUIJQ6XJUpZOOGfaiCGkp3F0iYLDrLhGaUa/bw5dbQ4vZzCyxiblh1kfIw3WEcj
         ExsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999410; x=1703604210;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0UOZ8VrL/oouNYdqSXbbgETnT3D/EQ3t1zUq6Qh2Js=;
        b=uTpw9tKLUrFdt3WT62ovbQ+vgf4ns6i4m6oPpVI+zacvgAOUvfkgeq5yHo48hwGeuB
         3+6EkkjEPd539uemZlPe3Y2yJAQ/s3eVVUhNA3BgAD66P0mx1osAcz+PNXv6a9GMBLpP
         3aSWrgf6ege2s7y5Z1baaorqmfw3BVnjtf5nEQP1c6ssp2XoG/UGPdAqaj83/reJbnLi
         iC1z0flcLzK8Mxj9Nu5ZaM/NebbaTuh119r6KG4zaWhXvX8+4GeIkp9le1X05fs74Y3z
         dBvt9Oo5jjH3xcuR2vqE+VsQFBhAmvdlpnGtFm0KaW+54rntF4aAnzugrV5uYf53in3X
         6D4w==
X-Gm-Message-State: AOJu0Yxp6nx+/YBiWtt6I9rZmcps/v4arbEM7PT5euX3xv2KuF55DTuE
	P0mJTF35WaaXJ2Pu2pT3t6WjTA==
X-Google-Smtp-Source: AGHT+IHh9ZJ35UY/PHwE29mi3IVPdXNAs3MelG+vc1BesnepllatXTbWOB526Oi6etCKPHV+dvEv2Q==
X-Received: by 2002:a17:902:b18d:b0:1d0:80db:a841 with SMTP id s13-20020a170902b18d00b001d080dba841mr35939110plr.3.1702999410070;
        Tue, 19 Dec 2023 07:23:30 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170903279400b001d36df58ba2sm9877965plb.308.2023.12.19.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 07:23:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: penguin-kernel@i-love.sakura.ne.jp, linan666@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20231219075942.840255-1-linan666@huaweicloud.com>
References: <20231219075942.840255-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] block: add check of 'minors' and 'first_minor' in
 device_add_disk()
Message-Id: <170299940902.460104.1563250346911093809.b4-ty@kernel.dk>
Date: Tue, 19 Dec 2023 08:23:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Tue, 19 Dec 2023 15:59:42 +0800, linan666@huaweicloud.com wrote:
> 'first_minor' represents the starting minor number of disks, and
> 'minors' represents the number of partitions in the device. Neither
> of them can be greater than MINORMASK + 1.
> 
> Commit e338924bd05d ("block: check minor range in device_add_disk()")
> only added the check of 'first_minor + minors'. However, their sum might
> be less than MINORMASK but their values are wrong. Complete the checks now.
> 
> [...]

Applied, thanks!

[1/1] block: add check of 'minors' and 'first_minor' in device_add_disk()
      commit: 4c434392c4777881d01beada6701eff8c76b43fe

Best regards,
-- 
Jens Axboe



