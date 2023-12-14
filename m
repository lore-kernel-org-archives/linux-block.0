Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pN3of0Up"
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A3499
	for <linux-block@vger.kernel.org>; Thu, 14 Dec 2023 09:29:14 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7b74bc536dbso58626439f.0
        for <linux-block@vger.kernel.org>; Thu, 14 Dec 2023 09:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702574954; x=1703179754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5CXfUyreEvGvv0gxggVYx1dZCqnIOszlCcCC6scZgo=;
        b=pN3of0UpUOySDvRJ/8Ldd36fovF8XVAKYvSj8rf15z1VvI/x2oiO+IPFkOt5XvywEQ
         /i4p6Ku67LYO8Rgwcshg/09tkcveVRUwK2IUFV91SFEjsvjvU9AFcRlprgx1oBW4hRTM
         NhMMMk8/S4bRh/bCy6yRrGAmHpiGWitUR0CyGQWBglF+2OytnTUjIsbBdEeoh3/VGyaX
         IZgFONg2NUM3tKV9qOGZrZUND6sDZ4Prx0eDhUS9exkpwascNleXVkQaOOL622FjA6/g
         ch24pv583g/UtmursFAtcOpAYwqSyBIZKMfUOxuHOhzypBptoMpTHHyUxmfwI4APkEmD
         USjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702574954; x=1703179754;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5CXfUyreEvGvv0gxggVYx1dZCqnIOszlCcCC6scZgo=;
        b=IESdEb8eKKuNVUOCC/yd+BfgrpxxbwtsiYkApREHxBm4WkoSL3QutZLt0IZ8uFHGur
         36hoxaQOH9HlhzqYVNVE2K6zBN2m24jzx2Ryh9tRMCheqxd7jVXMbMaIGSBVKzfHUuts
         CynfAX5T6JHecSdR+HDcNUDfL3ph/j9uGQFRtjLb0jMIGB8yNj5M+Fxe2GO8PNc+4hn3
         APITmB70lMNSKG3BKYEJtTSHfBbJFJ8PiUKsFvRVEgo3jgUOQfrVObxQ2mEhXJOIJWxt
         1msRtk+28aTZG08MdV7N+Lcu6NKF+eOvu6wv1n3SY+WjfHdcjdbTLMgK5lLAD80aCL/U
         0hzA==
X-Gm-Message-State: AOJu0Yz+6opPiseO8ooOw9YLCOdf9Kk7uXeRZJPYDoCg9L2kyyF4XLOT
	ZsLVmK3goQRhdFICvihFvCITcg==
X-Google-Smtp-Source: AGHT+IFYTmI+d/+rYLziStqNAFse/ahI6HpF2Kmv2hn8JUj3qJVUORVbu2qHgHt/9Vh9ZEIuusA5mA==
X-Received: by 2002:a05:6602:1222:b0:7b7:15c2:1d91 with SMTP id z2-20020a056602122200b007b715c21d91mr16622873iot.2.1702574954261;
        Thu, 14 Dec 2023 09:29:14 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y22-20020a056638015600b0045a04a88b0csm3575941jao.86.2023.12.14.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:29:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Luis Chamberlain <mcgrof@kernel.org>, Ming Lei <ming.lei@redhat.com>, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20231213194702.90381-1-bvanassche@acm.org>
References: <20231213194702.90381-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: Use pr_info() instead of printk(KERN_INFO ...)
Message-Id: <170257495346.53990.124276247822929815.b4-ty@kernel.dk>
Date: Thu, 14 Dec 2023 10:29:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Wed, 13 Dec 2023 11:47:02 -0800, Bart Van Assche wrote:
> Switch to the modern style of printing kernel messages. Use %u instead
> of %d to print unsigned integers.
> 
> 

Applied, thanks!

[1/1] block: Use pr_info() instead of printk(KERN_INFO ...)
      commit: f19d1e3b17acc8173cd83b189f4c9506889b1c49

Best regards,
-- 
Jens Axboe



