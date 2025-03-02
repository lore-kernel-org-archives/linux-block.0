Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4812478F47
	for <linux-block@vger.kernel.org>; Sun,  2 Mar 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740935369; cv=none; b=XPQZiSNRGCaFqNtfX470mHijozkQYWVbMXfz5Tk4IJtPe7P/cTFaoYb0TEncfFHvs9hOXN6I4Ppn244oMcRKP1+fuMrobZZF4X+/4VT21o4VY+TOE2BBZ7DYUlB46kKU3IUTcqPpVZk6RAnn5Bgw6X82qhel18IKDJJj31et2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740935369; c=relaxed/simple;
	bh=JIAhYck11nGcAiDBQuwWiz9DeZpPcCOijT+w0rjV84A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AT33hEMmhQzgsC1KcNW4mKu06grMIhGfhgLmdDj7wvV1aOTUmugzZlOLpmC2ekMTaSlIyTy4tPTXP1YzBnSsi1pCYUkh42WhQd/TJmfEEHX/QNMr91hkujTemK9MTT/CfQotHayJBlCaoUGsCOaf73TUJA7eMVfU++jgqA4E8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=Cl1vbqz/; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Cl1vbqz/"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4721bfdb565so52797851cf.1
        for <linux-block@vger.kernel.org>; Sun, 02 Mar 2025 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1740935365; x=1741540165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXK0kHg3zC5EDYKPmvPzJo0TDy9CNyg2uim5Oy2DqB4=;
        b=Cl1vbqz/gUvfXvIpa4u1QpcZjIlKask++c09Vwz5DFvdpp4jESGRiN8jeyn7VLZ0zG
         MAMQaWRzyhgh05RP+jAlHJ3nQ/CaUAPzInAdDTsmiLfJagfHnjReJNBa5KowXiv1HIxN
         oYrpN4qpibgs178ZFT3F+L1/vKBeiFYU7Qb3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740935365; x=1741540165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXK0kHg3zC5EDYKPmvPzJo0TDy9CNyg2uim5Oy2DqB4=;
        b=My5wn3yElUu4TxGKvUBrnkPsvrOwOgByYZTkQfQlC/QM4EFFVIByGt8mHtHlD0T5Nd
         hWZKbYO+3oA7VPpX4dvwh1WJmTFx0t4R1cwsDTrgTgo8jDqtmZLyh1CjKbDJysVcjrUf
         TFHE7ALYwaFo4slHWbgoaP7hcr2+Y0Nn08qETrSdo6pI2x7Jz1PhhJxR7PFL73sA3fus
         X2Urpb7EDKOTjvnTp63dhjp+SKo8YzvAGK211FqDuOiDB80oKtsBmdTrVmKOX3NO5Sd3
         zqeU9JUS9mme9wa5zyTZ6rRpEByAVuzTPrbSP5DTyu3B0+I4Lf7aHxfFWwXesWdS+dT/
         j/vA==
X-Forwarded-Encrypted: i=1; AJvYcCWYxHh1xbuKrpQcaCreDFu9PMJDbssubof9vQnLSkm0sUYrmwzciJdxVyEj3bi/DwEd4Z0Es3HE0H5x8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVKO2lZ/RBHXLgQEEgTS31e7FWlhuhdS3GXok1PwGSNu43LbEO
	qlM1thnyUkZQkgFpsya5JuMiGyWBiE3UvLq9Q2FysS2PP3tYEbBaaivgN/cY0g==
X-Gm-Gg: ASbGncvIVrngjACn9+jAg/lDe/0L4+PELk/G9XVtgrWYH6UhClX6LZG/Sh35xuHDsc+
	wuHzBPTpPr2jjK9du4L3PpwLqL3chamvS+v2+nulZqVscNWMEbkk4eCPXD7gJ3aaJWKyE8S8EmX
	URFw7T1p08qOtQFi0bsEwbs8KvHfp8cEdyBf5p60Lmke8BHqQiN+W+dPnIv03VevCMNDwHs6FSx
	M5VEtePvRTuuzyQvkRV3iiyXKbL+aApfbtIMs3+x56ZcEMmDJbB6GgGV3Xv/CUv7D9F3XL+koG/
	uMXDeFg+N7dv9ihAnwu61yxHNFiHwPRvlItEtybb3iXe3xNuRmyNQous+jD4YhXUhwI/63wXLCI
	vnD+0eKwJem1P
X-Google-Smtp-Source: AGHT+IEkYCzQCrsbOZDD0xNfmEvExmAH5gSqt2/yzeJomeGsRxZOKC9EFtrYiJrgVGYVspIagyTp8w==
X-Received: by 2002:a05:622a:1887:b0:474:e4bd:830 with SMTP id d75a77b69052e-474e4bd0b9bmr25937391cf.11.1740935365158;
        Sun, 02 Mar 2025 09:09:25 -0800 (PST)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-474691a1f8asm48409861cf.12.2025.03.02.09.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 09:09:24 -0800 (PST)
Message-ID: <cc17e0d8-2909-4c01-906c-941700beecd6@ieee.org>
Date: Sun, 2 Mar 2025 11:09:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] libceph: convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Daniel Vacek <neelx@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>,
 Xiubo Li <xiubli@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250301-converge-secs-to-jiffies-part-two-v4-0-c9226df9e4ed@linux.microsoft.com>
 <20250301-converge-secs-to-jiffies-part-two-v4-2-c9226df9e4ed@linux.microsoft.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250301-converge-secs-to-jiffies-part-two-v4-2-c9226df9e4ed@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 10:22 PM, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@ expression E; @@
> 
> -msecs_to_jiffies(E * 1000)
> +secs_to_jiffies(E)
> 
> @depends on patch@ expression E; @@
> 
> -msecs_to_jiffies(E * MSEC_PER_SEC)
> +secs_to_jiffies(E)
> 
> Change the checks for range to check against HZ.
> 
> Acked-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Much of this is fine, but I have the same comment on the changes
where you bring HZ into the checks, which is wrong.  Just
convert the code more directly, factoring out 1000 *only*.

> ---
>   include/linux/ceph/libceph.h | 12 ++++++------
>   net/ceph/ceph_common.c       | 18 ++++++++----------
>   net/ceph/osd_client.c        |  3 +--
>   3 files changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 733e7f93db66a7a29a4a8eba97e9ebf2c49da1f9..5f57128ef0c7d018341c15cc59288aa47edec646 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -72,15 +72,15 @@ struct ceph_options {
>   /*
>    * defaults
>    */
> -#define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
> -#define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
> -#define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
> +#define CEPH_MOUNT_TIMEOUT_DEFAULT	secs_to_jiffies(60)
> +#define CEPH_OSD_KEEPALIVE_DEFAULT	secs_to_jiffies(5)
> +#define CEPH_OSD_IDLE_TTL_DEFAULT	secs_to_jiffies(60)
>   #define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
>   #define CEPH_READ_FROM_REPLICA_DEFAULT	0  /* read from primary */
>   
> -#define CEPH_MONC_HUNT_INTERVAL		msecs_to_jiffies(3 * 1000)
> -#define CEPH_MONC_PING_INTERVAL		msecs_to_jiffies(10 * 1000)
> -#define CEPH_MONC_PING_TIMEOUT		msecs_to_jiffies(30 * 1000)
> +#define CEPH_MONC_HUNT_INTERVAL		secs_to_jiffies(3)
> +#define CEPH_MONC_PING_INTERVAL		secs_to_jiffies(10)
> +#define CEPH_MONC_PING_TIMEOUT		secs_to_jiffies(30)
>   #define CEPH_MONC_HUNT_BACKOFF		2
>   #define CEPH_MONC_HUNT_MAX_MULT		10
>   
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 4c6441536d55b6323f4b9d93b5d4837cd4ec880c..ee701b39960e1c9778db91936ac7503467ee1162 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -527,29 +527,27 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
>   
>   	case Opt_osdkeepalivetimeout:
>   		/* 0 isn't well defined right now, reject it */
> -		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
> +		if (result.uint_32 < 1 || result.uint32 > INT_MAX / HZ)

		if (!result.uint32 || result.uint32 > INT_MAX)

>   			goto out_of_range;
> -		opt->osd_keepalive_timeout =
> -		    msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_keepalive_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_osd_idle_ttl:
>   		/* 0 isn't well defined right now, reject it */
> -		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
> +		if (result.uint_32 < 1 || result.uint32 > INT_MAX / HZ)

		if (!result.uint32 || result.uint32 > INT_MAX)

>   			goto out_of_range;
> -		opt->osd_idle_ttl = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_idle_ttl = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_mount_timeout:
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)

And so on.

					-Alex

> +		if (result.uint32 > INT_MAX / HZ)
>   			goto out_of_range;
> -		opt->mount_timeout = msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->mount_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   	case Opt_osd_request_timeout:
>   		/* 0 is "wait forever" (i.e. infinite timeout) */
> -		if (result.uint_32 > INT_MAX / 1000)
> +		if (result.uint32 > INT_MAX / HZ)
>   			goto out_of_range;
> -		opt->osd_request_timeout =
> -		    msecs_to_jiffies(result.uint_32 * 1000);
> +		opt->osd_request_timeout = secs_to_jiffies(result.uint_32);
>   		break;
>   
>   	case Opt_share:
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index b24afec241382b60d775dd12a6561fa23a7eca45..ba61a48b4388c2eceb5b7a299906e7f90191dd5d 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4989,8 +4989,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
>   	linger_submit(lreq);
>   	ret = linger_reg_commit_wait(lreq);
>   	if (!ret)
> -		ret = linger_notify_finish_wait(lreq,
> -				 msecs_to_jiffies(2 * timeout * MSEC_PER_SEC));
> +		ret = linger_notify_finish_wait(lreq, secs_to_jiffies(2 * timeout));
>   	else
>   		dout("lreq %p failed to initiate notify %d\n", lreq, ret);
>   
> 

