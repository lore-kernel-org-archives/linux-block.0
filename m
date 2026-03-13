Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5745039
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370838; cv=none; b=j1siULKEN7e8wLQu12IKQufrcN89pBzjrFRNbYn0oTJxAL9FuOYaqu2+mwv44rYQJW9ThdgJ2HdO/JcsEBD/e+GppsY6XRKhD8D490giC3fn/2dMjGhr7PWk9oQwBr/2wh1PblZPGZmKCc0YtyvqsxkPXjBA+8U4G2ROdF2S5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370838; c=relaxed/simple;
	bh=7mTdkwpFI1aN7JFvG/P2xcX1IHlUm6mmgB2869nJvv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWq0BF/vF4qp3FdLJWUhuadzoY7OFxoJqfZCdA29cI8bBgTrggGOuv6hjGRvZKuNmrwyS03VzRGEhNn/vgGHS+Q5cQ3ylDY6AMJDfTz9AAQhi3b6LUFpQNzvk6nwYXHOcRtq5tsOiHGDK6OO3nhxThfYXyD0hW7HoGj/+ILDrMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dc8C5Fbe; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dc8C5Fbe"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6e2355739dso598398a12.2
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2026 20:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773370834; x=1773975634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UJO3hU13zmgBpfZOgPSVu8qZgkxwPSAJ5ztfPhcpXsU=;
        b=dc8C5Fbem50AAejFfpM1hJ4my0s1epwcC3yIWPWcFz26mQstad8nPVtrn9ke8+1VcW
         1WtdboB7Gt0YlPU4h2zrsBCdSmaNsan5pRXhPQqKxGj4SbphFQ7ZY5Lbu5DKn78qmzwu
         JnSCTQdd5h1YmEAJHISqMIz7N20DNaBWL8vDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773370834; x=1773975634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJO3hU13zmgBpfZOgPSVu8qZgkxwPSAJ5ztfPhcpXsU=;
        b=FsX1y5o/t/t8CZyzSfNuS/peTWi7bD/z+abx3XwF9F2SA2OPcaCie16zlCosD0PJsr
         6TNY/+uT68s+D4PPP9nYCvUFqtHeg1odfpZOl63PcDxCIhZ8CjlHdSvmO1xZ/MIoDVVZ
         ynqzw9z6FNifgvsFr8j8ZRvswsDxvQ45vvv5cBDNatkdjap2XUfkkRjQ3XCBq553PgVf
         7t0XZYFBTKrXgrbv8EDw8NqwRd6B++Hll1nzMs+aETWPBhKuoX879N2IF1VEnRF4OHOW
         TmDEgCLfeCLedfapuuzntE4ooKoOYIi8DP6gHMkpGc2+k8fylag89V+LGgFHtu6AdvXv
         cdfA==
X-Forwarded-Encrypted: i=1; AJvYcCX3FjSkOGQIeCsSpEHv7G51iUmd49z3HXi8qAAn+UeMINqSxynDZc5/viRI3fpzeVomyb+awdJL0OYyLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydnlhhugKndTBQituHcAwaf/VeZn2j5gDPCSbyGtArxT1VgdRU
	5Q38/Qxbym+uIFweOEwQh4l4KMgLawyyJQ4pOj6ybk/IK9IMdxvqzYJiA+v6JRvrh4vYgE98Gui
	kUlg=
X-Gm-Gg: ATEYQzzhQV6xcfL5fMC4ll8epW5ypQLmcSzH+DPNs0Murq1cdPwsdHNKrQ9V2RjxqC5
	fwfZIZ62mQ0sRAhdz0arv3jWfl4Xw4PdQ5zsVCFncIdR4D3Ln+xvucq3r2KJu1zBL4ezoKErcPh
	eSWjLq4PH5eQzTBoOzEWsmUyqYV6Cu4N65vOLlvgQluISE0QGxHXkYw4bg+RxxiTsRv7u1m3chY
	GT0r6AXbcJkbWXRhhmZiXEELp1ksrOlpyVM4yzw+K/xMc112MDMZ7oWmfVgx35WVwUaBH4K+1tL
	L8hOpgWI+FqFnQ3EJ71Y4Tu8RAVKy6+Kw2Oz4U35D5bpXDLttzASpjwLgh/uXLOpAHbI3cVOdG3
	D3Mei6cTyyxhFQOpQFaVbfYxDgfkDP1+h4Sf/2PVowOJmA8rvtWRwPuAz9rPjjekuJVo9tKDPGz
	IaKccZOtf5umTKOBWogCEJ+HzLBW+ES9KSPhukCvEjKGYEd6X3/rXHzgnYrYFD8nw=
X-Received: by 2002:a17:903:2c06:b0:2ae:b807:da61 with SMTP id d9443c01a7336-2aecaaf6429mr13476545ad.35.1773370834520;
        Thu, 12 Mar 2026 20:00:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:ae8d:6319:a485:ec00])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece8098f7sm4469395ad.62.2026.03.12.20.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 20:00:34 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:00:30 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, gao xu <gaoxu2@honor.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"surenb@google.com" <surenb@google.com>, zhouxiaolong <zhouxiaolong9@honor.com>
Subject: Re: [PATCH v2] zram: Optimize LZ4 dictionary compression performance
Message-ID: <abN9hhmE2hG2Cyl0@google.com>
References: <698181478c9c4b10aa21b4a847bdc706@honor.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <698181478c9c4b10aa21b4a847bdc706@honor.com>

On (26/03/13 02:41), gao xu wrote:
> Calling `LZ4_loadDict()` repeatedly in Zram causes significant overhead
> due to its internal dictionary pre-processing. This commit introduces a
> template stream mechanism to pre-process the dictionary only once when
> the dictionary is initially set or modified. It then efficiently copies
> this state for subsequent compressions.
> 
> Verification Test Items:
> Test Platform: android16-6.12
> 1. Collect Anonymous Page Dataset
> 1) Apply the following patch:
> static bool zram_meta_alloc(struct zram *zram, u64 disksize)
> 	if (!huge_class_size)
> -		huge_class_size = zs_huge_class_size(zram->mem_pool);
> +		huge_class_size = 0;
> 2）Install multiple apps and monkey testing until SwapFree is close to 0.
> 3）Execute the following command to export data:
> dd if=/dev/block/zram0 of=/data/samples/zram_dump.img bs=4K
> 
> 2. Train Dictionary
> Since LZ4 does not have a dedicated dictionary training tool, the zstd
> tool can be used for training[1]. The command is as follows:
> zstd --train /data/samples/* --split=4096 --maxdict=64KB -o /vendor/etc/dict_data
> 
> 3. Test Code
> adb shell "dd if=/data/samples/zram_dump.img of=/dev/test_pattern bs=4096 count=131072 conv=fsync"
> adb shell "swapoff /dev/block/zram0"
> adb shell "echo 1 > /sys/block/zram0/reset"
> adb shell "echo lz4 > /sys/block/zram0/comp_algorithm"
> adb shell "echo dict=/vendor/etc/dict_data   >  /sys/block/zram0/algorithm_params"
> adb shell "echo 6G > /sys/block/zram0/disksize"
> echo "Start Compression"
> adb shell "taskset 80 dd if=/dev/test_pattern of=/dev/block/zram0 bs=4096 count=131072 conv=fsync"
> echo.
> echo "Start Decompression"
> adb shell "taskset 80 dd if=/dev/block/zram0 of=/dev/output_result bs=4096 count=131072 conv=fsync"
> echo "mm_stat:"
> adb shell "cat /sys/block/zram0/mm_stat"
> echo.
> Note: To ensure stable test results, it is best to lock the CPU frequency
> before executing the test.
> 
> LZ4 supports dictionaries up to 64KB. Below are the test results for
> compression rates at various dictionary sizes:
> dict_size          base        patch
>   4 KB          156M/s      219M/s
>   8 KB          136M/s      217M/s
>  16KB           98M/s       214M/s
>  32KB           66M/s       225M/s
>  64KB           38M/s       224M/s
> 
> When an LZ4 compression dictionary is enabled, compression speed is
> negatively impacted by the dictionary's size; larger dictionaries result
> in slower compression. This patch eliminates the influence of dictionary
> size on compression speed, ensuring consistent performance regardless of
> dictionary scale.
> 
> [1] https://github.com/lz4/lz4?tab=readme-ov-file
> 
> Signed-off-by: gao xu <gaoxu2@honor.com>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
