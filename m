Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793081604;
	b=gUgdFS0RXZZb9v4/gc4zYiw1P8V1BO4dZ6w+EXs0zI+vokdiuZLNzijqWjRQbAivRD4X
	 qAm0W7GbeFV3QQG56/O5aQgkLO4XKIOZrzEDJxYcFtHFo2tpjShn1Rhan2P7Etql5fRBv
	 W3Ui61Yrab2lzUNCsqG3MB6xIB8P+X1j1n91xBlvWD5o0aZfdkKpAc6AgB2b29eKCNUte
	 z/EKYiiQFmjWBC+E+KyHbt74Otnjn7M0zwHZdOveK2oCs2zrrRACKe21y+v/u0JupqrSR
	 xkkQpwMrakgJJ/H+Z0kmzycjRihsIAg8Yc5NMvXoVpMn8aX5BXHbebCvR8tKYxSbhlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=mffSw+MxdEAje0XtGPg2+DovEJNnFqJUem/6VRtADtE=;
	b=ZpHK2N1HwPiWhm3fLPNwOq1A/yuZt3Iam4GOQ4bE9Wr9CAInYBu4AnxlsPQGtnsM20hP
	 YgjFwE+gk5vMJh+PRUHdjUKHCwoKTdkQozasnX1C6FbtGNtsNd8Msz6ooMnB1Nqfh3UKa
	 QzYmqc0atEClND8u2+hY0ALFx72jIwhspGcyXdp/XzJpHRffUiDbPQPcoYkW8eGNe2c2a
	 Nru6RJcxTFl1hHPb8mZWV4+I9p14N2tNFX0MKQmtRKXTs7VJSKx1Egsb1xXHD9C73BtHI
	 uHaS47Iudp8cdDBqEyIo+jWFpNhn226dYwdfAFCcoc+Lam+s1xdOVjpQvMujbpX2/SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=fWlOahps;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F202606A31E
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 06:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F202606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=fWlOahps
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2933942a91.1
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793081602; x=1793686402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mffSw+MxdEAje0XtGPg2+DovEJNnFqJUem/6VRtADtE=;
        b=fWlOahpsTdQn5NB1uVUlK7ahruh61jBYOCD8+LRoUvlLU8Z8IruBEwe9TlPVsA9nnl
         Kgn8usObPOJmXt0KaqX0rIQ9ho3FTNey5AoEs31Wqx4kzlm1F7De3szm++30Wn6p8KsU
         mv31rQNeS9suscMS8BilN1OS6BC11oa4SaCmDdAmHbPqyAyGV+l1gbKMsZRKNHcKKTO4
         aVGdaIDah2Jz6MjDekjHyJhyGJNpgxXfM//MpilLKWdgZVvql0ha2kP7P5nd0TWnb/AC
         1wu4ZymidzOFAG7OT/I+2/PvJ0yKIC8AvqxBVAyN9pxelRomCIFKD6VzyF79ZIhxuerG
         nZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793081602; x=1793686402;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mffSw+MxdEAje0XtGPg2+DovEJNnFqJUem/6VRtADtE=;
        b=1JjBEmRrv5eMEuq7lgIvrO5byXuDFw0EWFusITrReHB5atyniy68A/HIRaTHns7VfU
         JlsN3GUVoDcrMlAcmApgh78wyTP+hUJZ2BE8CXU3ph0T6E5tISfGR5YP5pXO6bIG547F
         DcpoAH7zbORLdPe/EK5rcnZzrKUy2fZ/xZRRtQ38JaVYoGEMutVXXSgl/Er8M+ZHgnQ0
         YH+Xm547p1YCUj03p7xDeSldDI7iM95rfvNBaisQC1IA5/0dz+WVuZ8FA9ai6zwKsONA
         5r9E759PmA5J+ATI37pb629D59fqdFEHgUscKLtqAXeunFQmCAIfi4dzw+Aa8WYhgf/0
         z7wg==
X-Gm-Message-State: AFq9FYIHoJh4CTyGwYHrnJfi2m2Lq/38JQzWDamG9F51JWYE7d6hQc6b
	Lghw5aOuo+vOsBtZD1FFLpYw87T2A2R/ZUuEp3MKlpgF4fWyPz3TQfUkGb6A6z09bKQ=
X-Gm-Gg: AYBFou3yUuXZOcG8y5QthuZ4nkG0uifMNoW70p7tKEE0NzbpgRkvDCHPtkhJ3loHK+V
	lcOKx5xmpsKW+cclxdkhLlHQb1BOiA9a3r7cQ8R+O7oUOzqTHbdiJC2l8ognJxrbpBRyKCIwooi
	K6IQXdMdxO8eUMY9jNVluhQCO4CnAQ1YjdE7CbKNAtS5g1Q4GheamdPMMJkX4Ph2CCg7/MI5vsn
	2pQU2dbX6PBNIfKgfKYNGwIFthfdWgo0aoE3VJGk8wxjDifkKYLq7iR7FrCAl9qF2cH9BIdFSc1
	5gjWvc9uAuG3QpvbnOnNVzg6ykKjoyOG6zzUYFzOabTAVpJm97PHCkGY9VzRBRDunTih0lcl4nN
	1PsOo3IiAJArLIM8I6GkSx7kLOZeRzLDftM4GI9b5icQMUoIIuq8dgISsS/CeHPTWCMoQEZJLNs
	8vHG/KKT6eLrWEYr39EFdSY9nNqArvzyHEzF/VJNSsKC7V76LikTEmnZspRjnlfocXezHX7AMhb
	M8PSrdrFQPO8fiMWHGxEZmUHwu54Kycxehcf0KRX5vR0KQ35fx1XssjrNy3qVpo/6zfDxpVtQHb
	pb8sK/6IVNVaWgVEwbpcpv7V
X-Received: by 2002:a17:90a:d605:b0:3ab:2236:6b3d with SMTP id 98e67ed59e1d1-3adead57d9cmr7228994a91.27.1793081602508;
        Mon, 26 Oct 2026 23:13:22 -0700 (PDT)
Received: from [100.81.10.186] ([61.213.176.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae402a0587sm2163867a91.1.2026.10.26.23.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 23:13:22 -0700 (PDT)
Message-ID: <b8e77932-d22d-4c08-b163-f60ffec25553@bytedance.com>
Date: Tue, 27 Oct 2026 14:13:17 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: take the inode lock for buffered write
 fallback
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, jack@suse.cz, axboe@kernel.dk,
 viro@zeniv.linux.org.uk, mcgrof@kernel.org, djwong@kernel.org,
 tz2294@columbia.edu
References: <20261015091105.1315605-1-sunjunchao@bytedance.com>
 <20261015091105.1315605-3-sunjunchao@bytedance.com>
 <auAmMShKl4S2lc1u@shinmob>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <auAmMShKl4S2lc1u@shinmob>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 12:24 PM, Shin'ichiro Kawasaki wrote:
> CC+: Tal Zassman,
> 
> On Oct 15, 2026 / 17:11, Julian Sun wrote:
>> Commit c0e473a0d226 ("block: fix race between set_blocksize and read
>> paths") added shared inode locking around ordinary buffered writes,
>> but missed the direct-I/O fallback path.
>>
>> Move the lock into blkdev_buffered_write() so both paths serialize
>> with set_blocksize().
>>
>> Also correct the comment claiming that this path takes invalidate_lock;
>> it only takes i_rwsem.
>>
>> Fixes: c0e473a0d226 ("block: fix race between set_blocksize and read paths")
>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> 
> When I checking the new blktests test case block/050 by Tal Zussman [1], I found
> the test case hangs [2]. I bisected and this kernel change triggers the hang.
> 
> Julian, may I ask you to take a look in the hang?

Hi Shin'ichiro,

Thanks for the report. This issue should be fixed by:
https://lore.kernel.org/all/20261022062513.77372-1-mzx199711@gmail.com/

Could you please apply that patch and rerun block/050?

> 
> [1] https://lore.kernel.org/linux-block/20261015-blkdev-fixes-tests-v3-1-b6ffa6410514@columbia.edu/
> 

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
