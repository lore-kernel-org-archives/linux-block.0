Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BeyLrSX1"
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5441F2
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 07:20:17 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b720eb0ba3so46165639f.0
        for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702480817; x=1703085617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3PNM5zXBLheQcIjEpK8gOH2bim9GcY7Tuic8Z+UFE8=;
        b=BeyLrSX1t2fusOTEW4Z/Jp9D0CCDHU/5SDqnfDRxmdZkzJQ0mn/o1i/wX+HUmqdywG
         VoxYHcN2CatjZG3wIt7ZWexen18me0u46jcoqYURbUX9FKR3FUeSxjbpoO8NP8NzPZlk
         +AMNbEEJcaFg225avSS5SzoJqGeb8ABcZYlZEEeXaQ1Y1sTAPlz+aaq68Qoofvpnloax
         4VfPkN6kUNR0wbH7FaBXrUVQR8kBKzZEEKIEnlrZCBQvhRpRsgWQbvMVmwqaBBaQChBI
         ZPN+m1bTosb1VXON0VGblAcjeXki4uMyTT7xpJN0YtJ96a5YM4N90o236tE8KuU/cRcG
         AM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480817; x=1703085617;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3PNM5zXBLheQcIjEpK8gOH2bim9GcY7Tuic8Z+UFE8=;
        b=tFUeWOKopHwsP7f2OuqRPOWFSwaZz2W+dbZhKBFVze8Hv5oVYryp0miVgJyfx19EhH
         P8bJsTCjk0GJu3kCUNpwaqSUfr84kQOoC3BbzvWQsq30It60z4zcpeSHtPtoKIvq0/0A
         mYCuFOw92TuFqzAYFAdwkQakm+0HH5rzuOTdMQpWfbsyj5SQ1T6cOGB2W4nTHAlVoVo3
         SEnDPz+4mi0eXzCPKv5FltfZqc5eaq27Y4FRiwWxG9MUS7H/oMLi/D4flVDTsnVUXJjK
         PMA4AoyqxgZfFHgKu1NHDpckb2APQU6uFeiO8yFuD10PwoKtr5+TqJgivubnn0VYp+7e
         YTlA==
X-Gm-Message-State: AOJu0Yzr6AEs3VZccZEBz6WL5MVFUXNUrKcDOkjNAj01E+8i0AseHn1Y
	zZfrZb7k0oyUheGI3/Yj+xZq3g==
X-Google-Smtp-Source: AGHT+IGY0kHOkIzt6H+QWTL10izoHuOyMzxLzV+feo8HGgLLYqLqoUMAAYk3po1dYDle3iKyK7WuqQ==
X-Received: by 2002:a05:6602:b90:b0:7b6:fe97:5242 with SMTP id fm16-20020a0566020b9000b007b6fe975242mr14827360iob.0.1702480815144;
        Wed, 13 Dec 2023 07:20:15 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gj1-20020a0566386a0100b00466601630f4sm2990491jab.174.2023.12.13.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:20:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: willy@infradead.org, hch@lst.de, dlemoal@kernel.org, 
 gregkh@linuxfoundation.org, Min Li <min15.li@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20230629142517.121241-1-min15.li@samsung.com>
References: <CGME20230629062728epcas5p2bb48fea42a380039c0eb06c19a44aad1@epcas5p2.samsung.com>
 <20230629142517.121241-1-min15.li@samsung.com>
Subject: Re: [PATCH v5] block: add check that partition length needs to be
 aligned with block size
Message-Id: <170248081388.44340.415544465517225810.b4-ty@kernel.dk>
Date: Wed, 13 Dec 2023 08:20:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Thu, 29 Jun 2023 14:25:17 +0000, Min Li wrote:
> Before calling add partition or resize partition, there is no check
> on whether the length is aligned with the logical block size.
> If the logical block size of the disk is larger than 512 bytes,
> then the partition size maybe not the multiple of the logical block size,
> and when the last sector is read, bio_truncate() will adjust the bio size,
> resulting in an IO error if the size of the read command is smaller than
> the logical block size.If integrity data is supported, this will also
> result in a null pointer dereference when calling bio_integrity_free.
> 
> [...]

Applied, thanks!

[1/1] block: add check that partition length needs to be aligned with block size
      commit: 6f64f866aa1ae6975c95d805ed51d7e9433a0016

Best regards,
-- 
Jens Axboe



