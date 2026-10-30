Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400759;
	b=LeliauUrw3Srws0N3fx+TmoG4avfBfVhpMXmrisnTDoU8KW8zm2v6n7kqhM+EnRftvn+
	 SpqYr4xleeEMl5FycN6XdO7rnb91WQ4WzK/thD5ijQwFLpXn+qYYeWDI2AJEsfy+vj4D6
	 xvasNQHhZIH5uDPaYcOGdr4I7goPY9t2/Jiy1qN+JE7wCGTpUx2ai7FDxLnAoDIiR+DYi
	 IQLs4xcvd1bLjngGpjbAmwD9mFK3E8dVJ19UN/k5orbb+3dU+FwuPQDpTgMRNl2ZvmD1J
	 Ur29b0e3C3MP2QiyEwYd//wE3YIGJJB+GKgxZdkQd4BJInuDeoPTyWwqjp6JE1N7N8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400759;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=z4WOWcRuksCIYPpmwXFZfqXjqvsGcASgb0XVBploFjs=;
	b=S1YBLyIBjpnZjh7VBHlVxd08dtMJTgjF1gdcxcx/N7UUOSJxzPG87zPFLaiHrTGxPXA5
	 pUySPz+0RjhL6fBLrgpwzgYRSMyVrsnt/uf7Dv3NH3qgegUZH0ImfIfYNlhqtGS6rfCPS
	 MlR7mOezxymkeOYMqs7yuVA3XvLqIPhxtyhXfTKNF3QK+LkrLPvgfke6D+S4CLE89KBCR
	 8v7GME6ZvPZL0u1dGvycnkPXsMDTFI4fUqpIvqFpDfPDTNCPiEodMOsVN9EApl6eJuqu2
	 LA6wa7/RX1og+IlckSCPv/j4229brbl3X9RbfoYU+MBIm5fkOsB9wMY99aBgUCEs4Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=e5O8diDR;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="maji/mZ6";
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E05606A31D
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 22:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E05606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=e5O8diDR;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=maji/mZ6
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UMY2fU3007249
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 18:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=z4WO
	WcRuksCIYPpmwXFZfqXjqvsGcASgb0XVBploFjs=; b=e5O8diDR7g6M7/mw+qbb
	oteCAgUKdAa4cQsyAOU1+1O/u/9pJ8HA+0E2LM55rX1t0EwhbHKdax6Qih8WuMfa
	/mwybw/nD6/4FmuBfhU5eFLOxSP7kFO9RNGhYGD2MJUMQYfbg9QdAHWQytk9DZtP
	xlY7t9N5HuS6nHQHywT0Q4jgmIFhkSWK4GzoJ7Jw9t9xz0m0cn6AkYuDVret5GQw
	DBNFAsMYF78UNWCMTIEKQzDHfT5G9NrzR0I6qReqOrVibEQ0FeZfhIawvzDQxALD
	bn9xl01vKX0pUUKHpDQiJWurs28V0vdaiBY37cS7/dblQ4C6VPzKtZI3fznFalMq
	mA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hn2x40hg8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 18:52:31 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9308eafb465so290098985a.2
        for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793400751; x=1794005551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z4WOWcRuksCIYPpmwXFZfqXjqvsGcASgb0XVBploFjs=;
        b=maji/mZ6mYd0LnGXtVqF7CH/33yRquC3BLJvISzmdOKN0vrfonqGLNF8MRqeeZDPMc
         q7oWR/yLMwBh6vHIqXFWHpW3aEn/RSXFK42HYejaT5tZ8nLFylZYOJMnn9fiogpf5njY
         XlSjTFIemJFTDumQWIQvJKvbEYNyZuOtXBJhiQYncnmMfNka+3tdJ6gkUGLl+5p1Ejqg
         8c8xm3DD58xQSW8AasRGuNxizHdUkn4cQWnmSh+9YrRbSKW0SiiI5rtAFuCHHmpgzj+w
         LRF9PIiJ80nt3kkDbTSVwIgo640hENDirUtQDMwzwuwT9iShe1sOTIn2mq1aTJYncyuB
         XWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793400751; x=1794005551;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4WOWcRuksCIYPpmwXFZfqXjqvsGcASgb0XVBploFjs=;
        b=FfH/FI4rOQMTtnGAri7/Vj3Ud9SuTBNfMjoe/DiOiSydO8G9RgVv13kYRGa14iKWvr
         mzMi3aTm9rhIFpt6Yz1gXBvVsmfNM0gCMbWkGuLGqfLOmfhjnamMTR5iUjTyeVBVgt/t
         aNqxFShC0Z8sO42jXHukxQ0QsfcVlgEvY3onmbj9UxPOKIJuEzEdZxpk59G3llLmJ0Eo
         /pqVxcnajoLAgP9ZhKdRb6zxAKI9ttkXZ1Dlj2k5dsxMi2Bpfn4s7JdlM9YGsMYvOcHE
         kVZgBv/pSZPoiZ4+NGuzdg0i/xTilb78o94ymJevr/Pt4LctEPU2VWV+F30yJQM5XEqj
         DP9w==
X-Forwarded-Encrypted: i=1; AKwUvBxiYe4mMkcFs4ISaa/+vE9KKzp6VniBAbkIWzRtmw0DN4RJpbeohwnM6cPROl48FE/LXivRvk9nuoFCnQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLYVY5Rj1RVTwUgy+fJLsofzvcZu7soikwCPBVWE/CYWsWzgMjX
	pL6aBwq0mNINR0Q5knEDtqMntKi5gdT5rBMHFGNOsW0hGJm02a8a1aSqB029CgsBahKgdB3Bibz
	3t/78UpFfmCwI39OWWL3VjNVan+e1mUaFrLpXd3XxTlW+ONy1vO2Wk0gQUOd8
X-Gm-Gg: AYBFou3op70U1VagWL/+0UA6fnFTj+8MGykzuTeTlc8d7nKUlsmnf2lYelVJxHciHDo
	BIi5BedFygJ+R+ocyXSdJLgMcKyXBRiK9Is4zKILsCPDVEuB5nMPomxwCYqsCBvwlnpCTbXGeAo
	GojYEU8HT6iSBZgGb5aS3im8xAJ3OYDIPAB1ZI+mMQUxIxa8szwMZ5r6KUpMkqpbIrnQ1qyMUX9
	sFwvgOKbQLAJj0MIH0etfv9kE/tTsV77lmImdLR2umK/Vo08l+rWNGShzTcIDE3dqsIyxhBg6OG
	2gSWDAM4LGZ9i4qUd0PbbUBIMiU4JWE4rgv87Xg1q1vnSfBGEnot4mX32yJNkfhQ59vqZAqjW66
	bC1hLgidP/Eusxp1r+jTkTJ2sepTPEm9Q1gqTaLKl3L4K1/nRTclCDq9WQTmgGe8D+eYurWcCwP
	Vhmvqe3fFBJzVxtqsrG0zqIUMltcmJY/YIPw==
X-Received: by 2002:a05:620a:44d1:b0:93e:d5c1:da49 with SMTP id af79cd13be357-9442176424fmr626465985a.82.1793400750856;
        Fri, 30 Oct 2026 15:52:30 -0700 (PDT)
X-Received: by 2002:a05:620a:44d1:b0:93e:d5c1:da49 with SMTP id af79cd13be357-9442176424fmr626463285a.82.1793400750415;
        Fri, 30 Oct 2026 15:52:30 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:85d9:d6b:b848:9578:6d4e? ([2a00:a040:199:85d9:d6b:b848:9578:6d4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d5dfsm6245133f8f.3.2026.10.30.15.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 15:52:28 -0700 (PDT)
Message-ID: <f9e40962-53b6-4de3-8e0a-3b17c257287f@columbia.edu>
Date: Sat, 31 Oct 2026 00:52:26 +0200
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
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: John Garry <john.garry@linux.dev>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
 <20261015-blkdev-fixes-tests-v3-4-b6ffa6410514@columbia.edu>
 <8fff4ba1-1b19-4974-bbd1-16686c8b5bd2@linux.dev>
 <5b4621c2-f707-4644-8aeb-d4d0956317c7@columbia.edu>
 <auP5md9PBSJnZDND@shinmob>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <auP5md9PBSJnZDND@shinmob>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gwY2F4yWakZ6hLtM55RZcbbm01FLdzbc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA5MSBTYWx0ZWRfX5CMAgkvHefd+
 bL069vjPxsG56H6fFvH8DnyolCvJFfCBfMtckc5ULIMX2QP4ftT9pKwNiEamaHnEJdThOTX7X1X
 K/jQ+sD3KzmR9Or2oUzdkpMH6/1P8+j5YCtLX/s6JDj1TSFchbeklCKcIJYoeWqLoFrEBPdFe0U
 hPvg7Oo4L4lwLVoM5dnjM+vzYXd6+1PkraVfV80PRRVDWKstlXxHATWtP4drF6l38uyCV2YVXrz
 Ud6NmJkB9d0RH6+agaSUAjQ0oN5O0BaorhiJTHdnrO7wznf8zhA3IMUdekCRlKZZ/RLAFW45OcG
 IUMY/vfxnrG+k0GN5e13BnK/g4/QG9OXbT0CST5qLQJGFzptBdTgKn5ZjkJ1tqhPlmaWRHr1I3l
 usL3FmZTCEQxq8jW2efDv5a5a1b8M6Z14h3UG2ygSB5PZU5b3hpG54mCpUxbQwdGlUouDBr06Wy
 ijWtvysRcKQMBuS20Og==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA5MSBTYWx0ZWRfX00x1/uQhK0et
 SQl8j5PaIgdT50zCMULO/b3wvV5gGKpzFZI9vn1Rx6f0V6f6LElHI0g8L9Ik4qYvO/ROs7sw0zH
 uFBl9jZWKHtZhJvZArkgCrGQ+erdTD5JLqcyXlCJxNgb4IXNIKuV
X-Authority-Analysis: v=2.4 cv=aNxlOr9m c=1 sm=1 tr=0 ts=6ae51fb0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=_VmNW797vodnDx9XqNgA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: gwY2F4yWakZ6hLtM55RZcbbm01FLdzbc
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11951
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 bulkscore=10 priorityscore=1501 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 impostorscore=10 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610300091

On 10/29/26 10:12 PM, Shin'ichiro Kawasaki wrote:
> On Oct 30, 2026 / 01:15, Tal Zussman wrote:
>> On 10/16/26 4:53 AM, John Garry wrote:
>> > 
>> > thanks, just some more comments
>> > 
>> 
>> Thanks, I'll address all of the below.
>> 
>> ...
>> 
>> >> +#ifndef RWF_ATOMIC
>> >> +#define RWF_ATOMIC	0x00000040
>> >> +#endif
>> >> +
>> >> +#ifndef STATX_WRITE_ATOMIC
>> >> +#define STATX_WRITE_ATOMIC	0x00010000U
>> >> +#endif
>> >> +#ifndef STATX_ATTR_WRITE_ATOMIC
>> >> +#define STATX_ATTR_WRITE_ATOMIC	0x00400000
>> >> +#endif
>> >> +
>> > 
>> > Do we still really need these? Surely a test machine will be installing
>> > the latest headers along with the new kernel, no?
>> > 
>> I would assume so, but src/metadata.c and src/metadata-iopoll.c also redefine
>> various structs/flags from kernel headers, so it seems like that may not be
>> the case.
>> 
>> Shin'ichiro, any guidance?
> 
> First of all, blktests targets not only the latest kernels but also older stable
> kernels. I expect the make command for blktests can build src/* binaries without
> failures regardless of the kernel header versions installed.
> 
> The #ifndef approach above can avoid the build failure with old headers, so I
> think it is acceptable. The other approach is to check the relevant C macro
> definitions in src/Makefile as it does for UBLK_U_CMD_START_DEV. This is more
> ideal since the unnecessary binary is not built for older kernels, but it will
> add some complexity in the Makefile. Either way is fine for me.
> 

Thanks, that's very helpful!

I'll add a Makefile check for this.

Thanks,
Tal

