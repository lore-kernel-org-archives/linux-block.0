Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yN5USrda"
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18B7CF
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 09:16:58 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7aff7bf7dafso31256939f.0
        for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700500618; x=1701105418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB7WfUEEaC1OvWTSK9npq8Mo0A16SnQAjvLM/HQZZuI=;
        b=yN5USrdaPRXPjFWxp8LhHRkSO+u4XLdXKwx8rSdK0XlHlCLn1f54W5Non/Az60nNVX
         wBMN0jhJC0IeSlJXHOcZ5sTrg2zlBvhqiq76hmT3g001iGIQd4Ep0lKPlTfWvdZZ/ZK0
         wc6eM+yzmWeiIDDMem2RUIogDh+KeU5xkyZCotXAKWkbNQD6F5tdSCr74PzL3AFslVat
         Hl6CD3KO0yfcHwAFSEJEjwSF6o1tVNC8SzFMx1bvwToM5xpS+4kUzaeE2Arpv/OPJcVS
         IgabTeJGLDmk7KgFlMRVTqGLR+ac6dMBHtq0DWp0B9/9FwTkWbZoNTO02XigWlQmgGxk
         41ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700500618; x=1701105418;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eB7WfUEEaC1OvWTSK9npq8Mo0A16SnQAjvLM/HQZZuI=;
        b=tOAYwislwReSfKmYVZEmESbKG7pEUdNdihPQ4BQDSXBB7OzGvG6UEvKVMlBiDT3akM
         BueabKesRNFj36h7VQ1brZ1ZmYQKA86Re9b1vJrl5ALRXzuoPYvn8wCSW+DQXBWroG+8
         NHFV9Qxs/myatlBg+/dxzskQQm+vajTOjDAoLj/XWAK3xWI8IYw0vDYgh4LdZIEuHFkX
         8zgweknK2ONuNFbJ+RsgqrAOArz5E3fq62HmtSm8+M/pbJuw+xUFUldnwacnrQZUAEY4
         BZ2knO4+EE4vMvTXxbkjow96pNoSwS8f5mJpZ9t9O2y5k13P2ZyixRFA6H58/V/s+m/x
         6QEA==
X-Gm-Message-State: AOJu0YyA4gUF64gX/TORLlM74vmsRCv3ALI58dIE1yTaI6Uf3BLiWCi2
	bkE/AMqdPVnEogFXwDSlNJ1SxQ==
X-Google-Smtp-Source: AGHT+IEIoY7JzwmmB4jXQdtkfpQOU8uINar07von849M9jzHSJ+h0OJXJMILhL1W2qbS/ovZ+3bm5g==
X-Received: by 2002:a6b:fc0b:0:b0:7b0:7a86:2952 with SMTP id r11-20020a6bfc0b000000b007b07a862952mr7278834ioh.1.1700500618197;
        Mon, 20 Nov 2023 09:16:58 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ds21-20020a056638285500b004645a5d3b13sm2110468jab.19.2023.11.20.09.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:16:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, linan666@huaweicloud.com
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org, linan122@huawei.com, yukuai3@huawei.com, 
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
In-Reply-To: <20231116162316.1740402-1-linan666@huaweicloud.com>
References: <20231116162316.1740402-1-linan666@huaweicloud.com>
Subject: Re: [PATCH 0/3] fix null-ptr-deref in nbd_open()
Message-Id: <170050061729.96172.17600082878837866184.b4-ty@kernel.dk>
Date: Mon, 20 Nov 2023 10:16:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615


On Fri, 17 Nov 2023 00:23:13 +0800, linan666@huaweicloud.com wrote:
> Li Nan (3):
>   nbd: fold nbd config initialization into nbd_alloc_config()
>   nbd: factor out a helper to get nbd_config without holding
>     'config_lock'
>   nbd: fix null-ptr-dereference while accessing 'nbd->config'
> 
> drivers/block/nbd.c | 82 +++++++++++++++++++++++++++++----------------
>  1 file changed, 53 insertions(+), 29 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] nbd: fold nbd config initialization into nbd_alloc_config()
      commit: 1b59860540a4018e8071dc18d4893ec389506b7d
[2/3] nbd: factor out a helper to get nbd_config without holding 'config_lock'
      commit: 3123ac77923341774ca3ad1196ad20bb0732bf70
[3/3] nbd: fix null-ptr-dereference while accessing 'nbd->config'
      commit: c2da049f419417808466c529999170f5c3ef7d3d

Best regards,
-- 
Jens Axboe



