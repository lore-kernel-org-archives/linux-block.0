Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MqyXD354"
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A8E9A
	for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 06:42:37 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7a9541c9b2aso53911539f.0
        for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700577757; x=1701182557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgSwU2wjmRzA6RzqAcEMU9EpGu84w83u/YmCrCrTRVc=;
        b=MqyXD354+ZkPfKBkUd3tC7UHh1hIMqRNNFnDv05Q6PooI0pA/VMaiRoljmWWOsyJvf
         K0bTcsK+BQ91pwkq0wiWPY75CVq2hRqYhNDZ1yQTKEwayV036/wWuW2fmhAqjz1AfiGK
         Ve+MpJHdbjlcMrDs5BeIsJXeI8RzCtbzPECSPcLpd8gyPFrMGQIaIcWZw76qhLihDaAw
         +6jTq9pyn+OLlTiZn8jq3gtRLJb2rv9b53EsFl+vqSPxquaRtgqPH+ingIPJQg7nwMy8
         zzdjULi3nJZwoBVFYIheQ+qZpHtOgp/uvYx7SxhTvCd3LtGX/x2v1MzWEIx+D+gweh8t
         b+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700577757; x=1701182557;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgSwU2wjmRzA6RzqAcEMU9EpGu84w83u/YmCrCrTRVc=;
        b=U5Ox/l1F4ftmAUpIPtzo0oqxbnBRDXhIj/tnxHm1spzypBEJRJ6YQg91tla6SI7Cjr
         RQjXx24/EB1BKKdwZqm4nuecB+CCavcyj70yPs/DQCfdDZDAK5IzTRo0iBO1uavAnwkD
         Zao9w+175rf6chdbrfw9kaiqvzYF9p6JPM4wb+G7TstCWcK7dw7o269pHzOia/hDYh33
         O+w9kVUurdjbDtiRYIaim70Qp+aP/aDCIW0ldRT2xsgqc3W4idC4/rbXSZaNFlJR9KNN
         rfBfY8Pfizkq/n/M06ShA5KDJlFZUw1+xzpaw5XzSmt3bXw1azA1ydfR8TpblbmXmd5U
         qNjw==
X-Gm-Message-State: AOJu0YxGBMjuzWb6RqJY0Nf0gyo8YaaLoRlWAbx3zOLs5XVbCpSa7+Q3
	erx7DomHd6+YoJnQ/XqXzAcL4g==
X-Google-Smtp-Source: AGHT+IEEmIAZAYZgOvVGMKlcTAnQdAbmk+xo/5J9j5adJQMyuSUcAXy3WQ87OhmLmjTMwEB7mBPsrg==
X-Received: by 2002:a5d:9b92:0:b0:7b0:acce:5535 with SMTP id r18-20020a5d9b92000000b007b0acce5535mr7649795iom.1.1700577757029;
        Tue, 21 Nov 2023 06:42:37 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j14-20020a02cb0e000000b004665ad49d39sm1187305jap.74.2023.11.21.06.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:42:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, linan666@huaweicloud.com
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org, linan122@huawei.com, yukuai3@huawei.com, 
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230911023308.3467802-1-linan666@huaweicloud.com>
References: <20230911023308.3467802-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] nbd: pass nbd_sock to nbd_read_reply() instead of
 index
Message-Id: <170057775563.269185.521615863055260084.b4-ty@kernel.dk>
Date: Tue, 21 Nov 2023 07:42:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615


On Mon, 11 Sep 2023 10:33:08 +0800, linan666@huaweicloud.com wrote:
> If a socket is processing ioctl 'NBD_SET_SOCK', config->socks might be
> krealloc in nbd_add_socket(), and a garbage request is received now, a UAF
> may occurs.
> 
>   T1
>   nbd_ioctl
>    __nbd_ioctl
>     nbd_add_socket
>      blk_mq_freeze_queue
> 				T2
>   				recv_work
>   				 nbd_read_reply
>   				  sock_xmit
>      krealloc config->socks
> 				   def config->socks
> 
> [...]

Applied, thanks!

[1/1] nbd: pass nbd_sock to nbd_read_reply() instead of index
      commit: 98c598afc22d4e43c2ad91860b65996d0c099a5d

Best regards,
-- 
Jens Axboe



