Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LVDqwpXU"
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2D2EB
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 07:20:14 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7b7117ca63eso49237839f.1
        for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 07:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702480814; x=1703085614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v15uYxGg6gkytkWqBGX5C6eEYyMifKma8MdBhOHf7x8=;
        b=LVDqwpXU7wvdPvbyla3Ud/xuqvkGtl4867QSTBmnmBhTJw+3xdj5iXTBF7fLgmR9jw
         DAl0a5LyfDQGO/d73ysh15X2VQ4y/z64PvBKwc0N1wu8QVrANSobuyWz/EuS04DXQvJ8
         KURbFs6jwRmLYxc6D5v07qXOzMeujRXQJ06JQPv8QzAsJQwNps1i8hoxdjKZiWDTKTXX
         3BNaLUdiAX2CzPEuyb5yiuq5iWXqNGIOxaAHcNmLThGJB4p7m4ynhSjrl84oCrnaQxSt
         WYhq+1OpT6eI/rHe+f+JcbXu382wmabhxT38TRzx1OuBiIHWVLXsRz8yjR0WakuDnmGh
         AtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480814; x=1703085614;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v15uYxGg6gkytkWqBGX5C6eEYyMifKma8MdBhOHf7x8=;
        b=vVrFQZ9B7DfwgrqXkE3WtUPEIK3rupAK4yLqCFht+N9ShCIWiWvPhvBb200C0Mlgmp
         sfDLEAeG5zdyKZBKrFjo6a00fJHqTYvk1GEj7UpmdWWNPpdf8oyyoL69FmaF121ej+Sn
         /hDLN0RfYNyaeRtofaPOhXYtM9JfBRVJ4d+DTaOVd99PV7alSCeC50VNHXFBHmeaA2gC
         A9HzVKiTLEPCUfXfIh9TORAv7sXXB/oKZEr7Ksp4YoXVZDhyn4PYu5VdhlTdgkgJC/wi
         W393dP6v+WELoNJAEI9CqSTGYE7YtHZQ8da8FRsFpD2zPkbMFwOJMNqQDj9I0OaUOw+4
         /BiA==
X-Gm-Message-State: AOJu0YzGQ4zHHtQOi8NV3nGZjamY+SOzgmg4vc9Rknqu9t+hfg5wfejK
	jf6qnsz712iZet4Rkw948wBywmWKr8wgFCSPtPuDoA==
X-Google-Smtp-Source: AGHT+IF5WQK1UZjrunvvmScqN+py0D//HqewJThVrYQlPIQSuuwNxdHCvFlLtvuWmTnS8JdMpmXDfw==
X-Received: by 2002:a6b:ea0a:0:b0:7b4:520c:de0b with SMTP id m10-20020a6bea0a000000b007b4520cde0bmr13370272ioc.1.1702480813790;
        Wed, 13 Dec 2023 07:20:13 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gj1-20020a0566386a0100b00466601630f4sm2990491jab.174.2023.12.13.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:20:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: akpm@linux-foundation.org, ming.lei@canonical.com, 
 linan666@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20231211075356.1839282-1-linan666@huaweicloud.com>
References: <20231211075356.1839282-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] block: Set memalloc_noio to false on device_add_disk()
 error path
Message-Id: <170248081296.44340.16976032771590083104.b4-ty@kernel.dk>
Date: Wed, 13 Dec 2023 08:20:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Mon, 11 Dec 2023 15:53:56 +0800, linan666@huaweicloud.com wrote:
> On the error path of device_add_disk(), device's memalloc_noio flag was
> set but not cleared. As the comment of pm_runtime_set_memalloc_noio(),
> "The function should be called between device_add() and device_del()".
> Clear this flag before device_del() now.
> 
> 

Applied, thanks!

[1/1] block: Set memalloc_noio to false on device_add_disk() error path
      commit: 5fa3d1a00c2d4ba14f1300371ad39d5456e890d7

Best regards,
-- 
Jens Axboe



