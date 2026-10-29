Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315765;
	b=2BQIpGVBYg4GyMGXwg5e6qDaurVpZGhIwEi/2fJVljAEN/DAg0BnW5Yvp0s25CvPXqVF
	 RLQQcQEff4/VKKcNO3rXdwnYC2nwk5xf9KEPEwihWnxyBw/2eXVR177lEuc62DKK0pxUD
	 MS26ATkbemMQHZM22makZnughep8SZ7itpXRXgpDdZdxWXx5XQqoqhd+bchYBoTlbAuF+
	 mi6fxL+co2Lo78KeN6fMdwOp4GCw5osOJQ8loRk/puPNlC700ijL1HqurTTs2y5W76nTf
	 inoRx3DUwBWJbEGZB9lkSUqlPEHlcI0zBf1GV63gDzHzUM1Pm7UMhQkb1sokNgskWZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315765;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=U1Kfz38SI8GH20zxJnZwVi7ru3196Nf3geH+Rh5tSCI=;
	b=fKFaF7Zr347uylUWBUEtTDkVgrBAtN7IUqeLSJXDjfgPZz/ClmcKxBxwEskfjubhZjVI
	 BRjoSnZ/tYOLyNia6VTOwMGvXB86JV8u2Fn7xZ65R7GO1P0sjQHn3wTi1CGgYy77nJAPR
	 mT2Rio4ODbLedS2vc8BrAnDIHUIxYpTJqvgj8zKy+FhAsADz2P7HnkyxF3oAVuerEkMOr
	 +EWloA3z4j/3IM/xUIPlaXTQeHL6zUiSQNeuwK7Lp6iZK5fnsO74vyBB4gXmVh2cD+iPQ
	 stVR+O80plkuI3GYfNZpKPslPDAUTcHUDXPrbSs2nLcNeT8VN1hUDTeNm3TZFjqP2Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=mdao+wR2;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=tNUemk5G;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCD6606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 23:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABCD6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=mdao+wR2;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=tNUemk5G
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TMWNho3569178
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 19:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=U1Kf
	z38SI8GH20zxJnZwVi7ru3196Nf3geH+Rh5tSCI=; b=mdao+wR2lWV96UNZU8FV
	nu9dn0xDIqcxxtQ+WBOODwjKMJvywg6FyhFTTpUILxrq7nahW48KemHFjVaeJWEz
	+L28HZGMHBfYTZOKsZ0u4rxPXVgODkSUO7VIjRRV/cU5vLmKGoih+IIVHA0T3pOf
	REltDk6YPgl8NsG07DCqXwx+6Ga8eK5GXzx7wCAWjvpeh+exZFrAeTPGsxqUULf8
	5IZn5iBSHQR7ZJdCdFA+DkNFmRZqZTCaZcjEfXuqpQZmOcOA5Wi4MaPy4ExiZ+R/
	fvcOxdTGObpvIHtxQwvSmOc92XGgCAkHlqm85Q5plqoxxV2R0L1kH1FzY+YkdpXY
	TA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hme6s0q7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 19:16:03 -0400 (EDT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-988bbb0ed9aso101651241.3
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 16:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793315763; x=1793920563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1Kfz38SI8GH20zxJnZwVi7ru3196Nf3geH+Rh5tSCI=;
        b=tNUemk5GqkozIIUnUWkf6zi1ywx8oQKLDrghHAwZ67RM3gjPQ44w461SFT7ktfNmih
         P0L+m8bjrY2DmCvLmRWCCQ6mNfR7N/2JJfVeuB6p+jZqEg3c7pTaJDS5uMAtiuG/YZl/
         TyNtflHzy1OU3lk5zNVVIiZVe8fb9RqqZmaR6RNKdAi2+9OZNbh5GxdViSF3reQgVsgL
         seNj3skm5O3syJkv/1vjC/NqXayZy4enMu/H9Sd8xsdcHf1l0P6f8EqnuVF20hss/Rxe
         VsqnUkHDaLHcIkSBeHTvv4PsL9iJGPQTbZsebYj/Jticos6BL9yT04FzWb+3iYibou4F
         +eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793315763; x=1793920563;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1Kfz38SI8GH20zxJnZwVi7ru3196Nf3geH+Rh5tSCI=;
        b=dHMzTNVs35rT6CVF8eRSIv7MiR9BcolQ4KqqhtKCLWHpq5BzEhOiOZNU1aLExoUwGo
         A4KvQBrtX0+iTkSVDLcqalCdwV2vwnrZkDEozLsevhFTZIMsKg4+smFp4ZUtg2K8XRrY
         t74/BcZRpx3b+ti8OoQBJEOobdsBZgZ4l9Nw+PiOOz3lxhYlWaRlvctIulZ3M8ZXeAv4
         441HwGGiP7fny1qt5s9CSfteX/VcHMxEpIaY/JvUZoA7LzGMchDPIudt3IUwaGLPM1KY
         5XzTlEUb9PLtvaWp1BNpAu1UJbmZeWgcVaN0OBf7qbaVe3bWqW6hk6wmtoTbnAF4d+0+
         F6Bw==
X-Forwarded-Encrypted: i=1; AKwUvBwmBg+FV2ygQUmBdABtBMmqTjF3J8yGnZeMIqr1/T1vpk116Ql60Hv66FiqOnIQtpUZqX+NOxl1hez7TQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI5TT1Er0rTyRcCXmoa5qGWGbfJSRc67yxXhfmlF8T1UrpV5yW6
	/4swXLpowdRJQ8h6Y/WCPjsyvmX2mlPEgI/o4Pcnto6mFCQsXE0dSKC3757TFWAqiC5Lof4aE5i
	kclaaJHQRy1jTPuCCcb+BiUQPwzZRY0XcO+LhSePsZbq78l5gkDH72m2Uk455fzKYD1xI834=
X-Gm-Gg: AYBFou1lTWJ6f3UXldMg5zlYVKh9kQ0Vtc/nmbe4BCYENlwMSnqaDgS3mKnmx7gBlSm
	rLMpgIacJsnrLfPcyJ2QHFiNGdTabIMvSHutk3GyeK3nhe6ZmlzjztHELJ8g94C8QHh0eQNBB7T
	kJEsG6X9UcdbB/ZYMw7Gi9cHS6aSBBPdASVzGCfBwYOLmVv15/LhE9xb+odDKdxv2gmZkzPpKRg
	CkTSFaeNSRWja1nXpEdnYtn6SDRpw5AHbSqbCRmm98rNd/5HFali0LJqJFO9Zk17FKaDXYL0QFP
	P6VrOf7bUmU2elyY1O/ojQRvdi9abKD9r/sLA89R7C3mTEuNT63OFUBVwfjtzL47etRyTj/hhD3
	BUYlg4k4oXEqEMNMdwplOvbPBpCebQwu7rWlI04Qj8bfnQv8liROphDVtMlnks+Gd4uZLUQBYaX
	yIdxv263I4r8LBD3i5XxWFfWIYz/JTeboQMg==
X-Received: by 2002:a05:6102:6051:b0:7cc:9d46:f062 with SMTP id ada2fe7eead31-7d072c3e900mr331568137.17.1793315762768;
        Thu, 29 Oct 2026 16:16:02 -0700 (PDT)
X-Received: by 2002:a05:6102:6051:b0:7cc:9d46:f062 with SMTP id ada2fe7eead31-7d072c3e900mr331559137.17.1793315762250;
        Thu, 29 Oct 2026 16:16:02 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:85d9:d6b:b848:9578:6d4e? ([2a00:a040:199:85d9:d6b:b848:9578:6d4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71287a0esm321220f8f.6.2026.10.29.16.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 16:16:01 -0700 (PDT)
Message-ID: <5b4621c2-f707-4644-8aeb-d4d0956317c7@columbia.edu>
Date: Fri, 30 Oct 2026 01:15:59 +0200
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
Subject: Re: [PATCH blktests v3 4/4] block/053: add a torn atomic write test
 for block devices
To: John Garry <john.garry@linux.dev>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
 <20261015-blkdev-fixes-tests-v3-4-b6ffa6410514@columbia.edu>
 <8fff4ba1-1b19-4974-bbd1-16686c8b5bd2@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <8fff4ba1-1b19-4974-bbd1-16686c8b5bd2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sfYkUHaqmm9bouUWY9wtY7ydOwXALPyN
X-Proofpoint-ORIG-GUID: sfYkUHaqmm9bouUWY9wtY7ydOwXALPyN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA5MSBTYWx0ZWRfX0vHYvx3+6E5q
 ds3CTW6joQy8YnRckxjaJzQcaosy3kr64MaB0Tp5b35nDeToOcjDi902gYp+zqLZSyLqt+8xX1Z
 I/bQzfr1Q/H905hR1uyj7G8PAA0PY8DD+Q+CQ+qIMvX7q+vLa9wB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA5MSBTYWx0ZWRfX/R/orlnaf2/C
 HkEl82o7UiHyUbpg7kB0+6JLeuZ9vDg5E7b6LtUCOQoAlWOOCNBN8WPUczGy9mjstUMsmspjj5B
 7lfRXtv5Er0RioNnlpFFjvjSY/YCyKJZMKz5mWquF6bNASle33qla3aON799/GLc+yMMrxeeBgX
 3vH412zxZ0ki1xj1Y+DOqkLLVAgX82/iWyVebS6Bmc7Al/5z2OigYr3qRZzOGzKJoFbAbo8F1M4
 wr3egFgTdUhcjhbuOBI6tAvElPRCWX4Mnxhdu0aDBo67JGWMIvznzSViiCCzz8m+gCYRnCg1U40
 JdSrP9dq9bnESYltEuFNHCDqnea7vcz8qCBS4qzlpvyygxiRMkaN8M/cn/U4NsVMpM96OI8gAgP
 iOa5Ui1Q274lD3630b0TrzaMVAcYKPqNQ1G5kZgle9B1KVeCiAngIGRWiIwx/Vt0yelS/YXHFtI
 Fv+QGUxIp5iq6B4VgbA==
X-Authority-Analysis: v=2.4 cv=GdyCDgXL c=1 sm=1 tr=0 ts=6ae3d3b3 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=b9rtSVTUWcj8M9QB1S0A:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=10 suspectscore=0
 malwarescore=0 bulkscore=10 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290091

On 10/16/26 4:53 AM, John Garry wrote:
> 
> thanks, just some more comments
> 

Thanks, I'll address all of the below.

...

>> +#ifndef RWF_ATOMIC
>> +#define RWF_ATOMIC	0x00000040
>> +#endif
>> +
>> +#ifndef STATX_WRITE_ATOMIC
>> +#define STATX_WRITE_ATOMIC	0x00010000U
>> +#endif
>> +#ifndef STATX_ATTR_WRITE_ATOMIC
>> +#define STATX_ATTR_WRITE_ATOMIC	0x00400000
>> +#endif
>> +
> 
> Do we still really need these? Surely a test machine will be installing
> the latest headers along with the new kernel, no?
> 
I would assume so, but src/metadata.c and src/metadata-iopoll.c also redefine
various structs/flags from kernel headers, so it seems like that may not be
the case.

Shin'ichiro, any guidance?

Thanks,
Tal

>> +/*
>> + * The atomic write fields of struct statx are only in glibc 2.43 and later,
>> + * so use a local copy of the kernel's layout and call the syscall directly.
>> + */
>> +struct atomic_statx {
>> +	uint32_t stx_mask;
>> +	uint32_t stx_blksize;
>> +	uint64_t stx_attributes;
>> +	uint32_t stx_nlink;
>> +	uint32_t stx_uid;
>> +	uint32_t stx_gid;
>> +	uint16_t stx_mode;
>> +	uint16_t __spare0[1];
>> +	uint64_t stx_ino;
>> +	uint64_t stx_size;
>> +	uint64_t stx_blocks;
>> +	uint64_t stx_attributes_mask;
>> +	uint64_t stx_times[8];	/* stx_atime, stx_btime, stx_ctime, stx_mtime */
>> +	uint32_t stx_rdev_major;
>> +	uint32_t stx_rdev_minor;
>> +	uint32_t stx_dev_major;
>> +	uint32_t stx_dev_minor;
>> +	uint64_t stx_mnt_id;
>> +	uint32_t stx_dio_mem_align;
>> +	uint32_t stx_dio_offset_align;
>> +	uint64_t stx_subvol;
>> +	uint32_t stx_atomic_write_unit_min;
>> +	uint32_t stx_atomic_write_unit_max;
>> +	uint32_t stx_atomic_write_segments_max;
>> +	uint32_t stx_dio_read_offset_align;
>> +	uint32_t stx_atomic_write_unit_max_opt;
>> +	uint32_t __spare2[1];
>> +	uint64_t __spare3[8];
>> +};
> 
> or this.
> 
