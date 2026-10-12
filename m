Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32747886A
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818130; cv=none; b=SgtKLr6Ttt7RkS8SsumBriiA8pxmxTAU1bhOvPRDCq3opiz80maypvAUgLuNmdb+/8wEXFp0xjP6Lj7NR27PzP0VL1S4vDuko2awEXJfxFe9MRXOHOTeQL/3upGz5xef+Vtyequ+tFBqJkIW3RruVxS7fAmXBEm7wulg7yvccCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818130; c=relaxed/simple;
	bh=7qgVyFysHoVC1duyEw08amev+yygbjqSf6AzLOBwmF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvaBPEB81qRp4v0IOHnK1JbX5oYQb4cjJOmgsybsZM8SYUYk2btyTWmu6pDBMzdnjS4AlY0fKuF5+TTbsClChW/XYsp5UDUy9B70cqfaNUwjH65x/JTIavH4BvBIVbH9QUM88cy+Kyn9urgK+/nWXovF1QUYRdnlk+K5aYKSaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=S9stOwZ5; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=yyKVMXRF; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="S9stOwZ5";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="yyKVMXRF"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CEgTEq1222141
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 11:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=pTcR
	9VdhLMOfNwJ97P2ZQdpB3JBpyHBXMrA4hjsGBGc=; b=S9stOwZ5iLDRDWwsZX54
	AE2Gb2YXHvah3bLSVhDSuP2MmkJ650Z6c9Wv3+QJ6CSq1QuZwe/b+qeAjxMryaLN
	2XQ1HZVI2HtLaN7BHKb8mY+SRz/gi3t8qhGAbHufTAsw/VhtwnHRFKzPWzGH9cWQ
	2S4T/AxM3saJGBtmjV0zTix5oED6Ll4sun3Pk25Rbzj+EoPud/BRdarM+e2fnM+a
	pJw1LOXUJVi6IOXvx2+APVQtdvBKkv56ShlJh2G2uxHATuTZz8JKb0z2T7EeksU0
	wNyyo18Y3b9y/UDiXssby4/uBlii8/F+l6JRI4PCDuQGeU+pjeCBjutOOZ4/kUae
	MQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h8y4w20e9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 11:15:27 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53397338004so72992761cf.2
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791818127; x=1792422927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pTcR9VdhLMOfNwJ97P2ZQdpB3JBpyHBXMrA4hjsGBGc=;
        b=yyKVMXRFF1YtgB5aQs0vgLCspjVcgaUYsvvRueiQIUyKXGcSLDtVewzqJ05Or6akvw
         8PD2lE/dJZd1/XlaEM89X1PNcAV2m4DbZvfzjvD/qCcum7kgyXaewWIRGD++uaC7v2xl
         AfIYv5M3qmfTpJP50Yn+VmnUZUDMVj+/ZvLaqbR2/fVfathiGEF9y3tz7uYCh91nFSzz
         GMJHOVZ5YfzrKsG5NsVf25G0sHbBF5Pclm2qnSddhBONl6T1ssGB0EtMUt4IznnmGMrU
         Tc6u3sW66ewR0PzNbvSJW8N+XEygvpI4y2CTm20ZlQ6S2hadOSJwI0NmiJMgyrpuTLOo
         0+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818127; x=1792422927;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pTcR9VdhLMOfNwJ97P2ZQdpB3JBpyHBXMrA4hjsGBGc=;
        b=LEqK/+v7B3PX4fod/5yZcf94u/g75pPVQCUL1eZzGmX/efy0D0YIRfjzXmPMlZAsbb
         rBglrTXoqkjqHW/jtvJGBQJAEcWdA5UGhigdNXiThx2vli2lyYVOODEmkmA5Dyu9qw46
         mmVXp7Zljx9ST9fGxh/ZGvxf7u362iE8RUGGifWJxE6AsmqfarjcfjQJjKLVkChBde7M
         dzieZPv1Kd7iJHgDC+WLhPgIFNRxPbnmdjB9u0ftK41HktbTUbc9q3Z33TrbqgHMt9as
         mJf3SMwZ6NCjnfoR2hmm/owaLsdtS4xxoMJ7OQnaqv571cBKshTzm/Uo8x9QEf7zaFQI
         MdaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmWnOfkbUVFovUBoMlAAUZk3ux4V5h90XbvYuiYpQCXs3eoj7izelaDsbCz0Ut1Dn7Hlgyvf4RhL2Dng==@vger.kernel.org
X-Gm-Message-State: AFq9FYJRt3Q70kqi89GboSC4Slg7yMGzW0F10Db1przg5h0RnhhDjCqX
	FXPhE75aqa4eS7L+DsY+lQ5FyXK4uMxr84HniR3sAzjtkqZ7PTpQ2taVyF0K8oCZ8Y4fopZZcvL
	HDJzEjI0NzIUe7+8UCcsY3PRqqHb8Aybr76kFvrM44s4+Out5GYUcVrcTqVrV9/yTDNEt
X-Gm-Gg: AYBFou2UBhlqx8QzT6i2gVKiXxTPPTu7A3MxOFXe8paJ4pfsAa4OVBcfLjKLcbw4oAQ
	hhUkykWJWlCjUmVcPGYJwHDja5G/H7NTHggI5930HIQLxciXscOyyZiRXfXMApB7yfuv0PDEz+g
	gXFJ7Hj/LtDH8GTev+GqJcG8nGxuMqkqTQwtvNxtnVBPI6uADWqL2JlTeJOrr+1cnLq2l8WA5A9
	VoJO1Az0/jbWnUH0ziPUyHHT2P4GiTsrL+NhqCz8P3A/WLqqYu5g5SzGOmG52eV9gL2SCUw+qIt
	vG1mKF+w4ZwrleSk31gdN981wVwe/orwNQdzLhAgWYIWhrOFPgTOo3ySCnTPdJ2tZwUi3nGJ1nC
	hFeYhM9daECUfRzYM2rHhv9q3tpS6yOaG+emALUL626pwUmI3
X-Received: by 2002:a05:622b:da:20b0:535:a5f8:a5c8 with SMTP id d75a77b69052e-535a5f8b602mr107357571cf.72.1791818126417;
        Mon, 12 Oct 2026 08:15:26 -0700 (PDT)
X-Received: by 2002:a05:622b:da:20b0:535:a5f8:a5c8 with SMTP id d75a77b69052e-535a5f8b602mr107357071cf.72.1791818125964;
        Mon, 12 Oct 2026 08:15:25 -0700 (PDT)
Received: from [10.207.9.0] (nat-128-59-178-231.net.columbia.edu. [128.59.178.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97178de2sm422646d6.0.2026.10.12.08.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 08:15:25 -0700 (PDT)
Message-ID: <cc483bbf-92d1-4795-b5d4-3a7bd087d63d@columbia.edu>
Date: Mon, 12 Oct 2026 11:15:24 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 4/4] block/052: add a torn atomic write test
 for block devices
To: John Garry <john.garry@linux.dev>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
 <20261009-blkdev-fixes-tests-v2-4-fcb3599e47f7@columbia.edu>
 <7e6e2875-29f7-4cad-94f6-5f0e07569481@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <7e6e2875-29f7-4cad-94f6-5f0e07569481@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX0X6DJzSdjE88
 Ig5HsvoCYelCXE1xptDIh/n5w8eg6ybAi/BTuIA0Z7f5jvl+VrHtGSxSZhRqRGEiw444yzpf1Bg
 lwCKdGVhfLE9ePqANf9Tvvfyhf99fzULLQd97HEj3xn4WQ85p9R0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX8OL38a4MQmb6
 QWGwF5S0jhxorej8PfTkb0jnbuytAfGr4xILeNVVvmZn9xZ+KFPWUhT2z0pxJheEX/H8wZqlqg0
 2GHfTNiY3cx4XR88VO8s6p7rusBxphAjPsoFlCBUpZj9QcPliWpsp3mXYWO1rlSq1R585QFvc55
 CtTFlHpmZg0fw5U0fcR+ZexeslSloAK7A92IlEalL4WQgOUH9k2c60HtU8xORALqH2KxOZQGCCH
 cdykZjqFMpa0uYBOWSuHm98e8t9EuslLHD888EAROmxnuZPK/mwuGdXtGMiv42W1yeBgpgxIFkH
 dCe7qwG+G/xZZMg98o30niIJqIMZsNLmh3Q6ZsSnsyjyBkfEMk/JeNnrhjv9NNMbGOtMoKg/s+b
 RNOvUj09tDd8TpFr7Z33Zep3M9NLwOMnmiqve4uqpI399eM0jknF7dIAkGZV7WdNH7YL4UKPFaM
 FyBPrJRrhDCX2iagWtA==
X-Authority-Analysis: v=2.4 cv=GOydgeNK c=1 sm=1 tr=0 ts=6accf98f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=9fnr1hFzp71kSIFw8uYQYA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=rVu-C-lY4VMZbb0URPUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: iI9dmtJjYLt-n9WQF8ccF-NtcLNiCdUA
X-Proofpoint-GUID: iI9dmtJjYLt-n9WQF8ccF-NtcLNiCdUA
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11933
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 phishscore=0 adultscore=0 impostorscore=10
 malwarescore=0 priorityscore=1501 lowpriorityscore=10 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120060



On 10/12/26 4:12 AM, John Garry wrote:
> On 10/10/26 00:53, Tal Zussman wrote:
>> An atomic write is submitted as a single bio,
> 
> nit: A HW-based atomic write is always a single bio. A SW-based atomic
> write - like which xfs supports - does not have such a limit.
> 

Will clarify this here and in the comments to specify that block devices
use hardware atomic writes.

>> so when its buffer can't
>> be fully pinned, the direct I/O path has to fail the write rather than
>> submit the pinned part. Otherwise, it submits what was pinned with
>> REQ_ATOMIC set and leaves the rest to the buffered fallback, tearing the
>> write at the pin boundary.
>> 
>> This is a regression test for that issue, fixed in the kernel patch
>> "block: fail a short atomic pin in bio_iov_iter_get_pages()" [1].
>> 
>> Issue pwritev2() with RWF_ATOMIC to a scsi_debug device with atomic_wr=1
>> from a buffer whose last page is PROT_NONE, so that pinning the buffer
>> stops one page short, then read the range back with O_DIRECT and fail if
>> it holds a mix of old and new data.
>> 
>> The write has to span at least two pages so that one can be left
>> unpinnable, and the device has to support it atomically. Use the largest
>> power of two up to 16K that the device's atomic write unit max allows,
>> and skip the test if that is below two pages.
> 
> As you probably saw, we have other atomic writes tests and they use
> xfsprogs (xfs_io, specifically) to issue the atomic write and statx.
> 
> Is there scope to use xfsprogs again here? I suppose that the gap is the
> mmap and mprotect call.
> 

I don't think xfs_io can do this, since we need to control the permissions
of the buffer used. So yes, the gap is the mmap() + mprotect().

Thanks,
Tal

