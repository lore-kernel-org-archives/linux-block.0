Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7B839FE;
	Mon,  3 Jun 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410947; cv=none; b=WFQPrYDiDuYgBZ/peVSnxgvthMxSxLY3/j0qGv28ru2yKNUwXLbxKQ/uobfdP4zaxX08gQHgBp0ELvrzuoH3DNQfyjAxWGg8rJ7nZP+/yD5Q0O+fTaGSwXD3DUeqVYKUUDrxFsjW6L0+Vgc7dzrof2/XOLdO4OL72DT7YwZWaXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410947; c=relaxed/simple;
	bh=g03U2T+ZSiDQhRck4HsL2XZ+Ag9dfNCNHACg+gxiuJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baSubHMeUuZIMlZzsp8c935vNTlG1GbNrpTgjXUfccO4txGGQ1pu+QSxSpqJ06/mMzi7Lx2KAbhbJJcMbnUFNQ19lkZp8I7OylJPF3l1D/hTVuGbqdFVtozOmoY4kO11Nwbw/eLnlQIa3+o3AM/OGBM9dcih5rbvYZyFUpXva7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42137366995so18082315e9.3;
        Mon, 03 Jun 2024 03:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717410944; x=1718015744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQSggjIOQS2XbswQ4LbCkfSppAvW/BDbYHoAyzOGG3A=;
        b=aToB/5W821gBp/7HH1EFEG9miTXw8FcoCRkyiX7N9YI3J7S3CZe1j8uU+iGFlZYWlx
         CAp8wpXrl2qW4iit98VlymFPuZmfeLYNePrqOZuM0tXBaoEN0S3v5UDAFe2uSjvzTdEF
         roWjgWxJa49JwgqZvhX6vAk6zp0KdfgCcwF+sgfCRtY45sMsBi8jmzftHCqfmf/JTudq
         Sy4nEy/p5tcYIRUeil+X9Vm9BLBiNtLN5TQSuag9VCdzMIfMUnq7xHFNu2QNyhOpChEd
         2oREhmLakMggYFmBUDdfza6M5TdNVjfYkTqnhHvFu3HXAyMhLdK1xyX04hPrNfxj5vMf
         AnOw==
X-Forwarded-Encrypted: i=1; AJvYcCUhjlrdkvSxGVBfdgBVNnKWSbfGZauhFnxjUHIpronZglVUjKQIpxCM27DNotb4I+0DuSUwdsQUAeCYemNgBdTXK3/QIha0l/rvMXDZSvTWragYeCWTPolXWhNOPzZbVHv4P3KPZjauMJ4V+4Db
X-Gm-Message-State: AOJu0YzdruKvUp9uFa4kwh7g9Ajkyfl59vf4RPNLc+da65T1LAr2pbv7
	uN6L8iZG3nn+2xLF+e8pE8kHR8dqEFXhbEYEnHPslyERW6QY0bpu
X-Google-Smtp-Source: AGHT+IH3ijTEeyQxiZtNFYEU1o6Dtn6/zM66j2TUsJDbN6NpiEOXCDlWqxK3e2nmeIy4gb5/k94w/A==
X-Received: by 2002:a05:600c:4704:b0:41b:eaf2:f7e6 with SMTP id 5b1f17b1804b1-4212e046c83mr84943375e9.2.1717410943697;
        Mon, 03 Jun 2024 03:35:43 -0700 (PDT)
Received: from [192.168.1.20] ([31.215.5.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b83d4e2sm113796005e9.2.2024.06.03.03.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 03:35:43 -0700 (PDT)
Message-ID: <f3a27dbe-091a-43d0-aac8-eebb4e2833d4@linux.com>
Date: Mon, 3 Jun 2024 14:35:40 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240602-md-block-floppy-v1-1-bc628ea5eb84@quicinc.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20240602-md-block-floppy-v1-1-bc628ea5eb84@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/24 04:05, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/floppy.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/block/floppy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 25c9d85667f1..854a88cf56bd 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -5016,6 +5016,7 @@ module_param(floppy, charp, 0);
>  module_param(FLOPPY_IRQ, int, 0);
>  module_param(FLOPPY_DMA, int, 0);
>  MODULE_AUTHOR("Alain L. Knaff");
> +MODULE_DESCRIPTION("Normal floppy disk support");
>  MODULE_LICENSE("GPL");
>  
>  /* This doesn't actually get used other than for module information */
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240602-md-block-floppy-1984117350ec
> 

Reviewed-by: Denis Efremov <efremov@linux.com>

Thanks,
Denis
