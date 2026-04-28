Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409E2DF12F
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368015; cv=none; b=oCejfXdxRNRRJdqe8liF70Vr8U8BdZBSJy5VDaGwvi3sK4I5QTpEYD36nHSG5zFFwDgV9R+BdEmjNngmZtuD4oFvn9LfSU4Npi5hpQ1nh4ExUCGsuRJV8KNhp+Lpbzo93ET3EuSTjpL2tPUKTj0VBD1ftjmN0mPwSVK6Wzq8ymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368015; c=relaxed/simple;
	bh=E59q141eIMRoVS0CIFBNpImOnrZTdEnPeY4n1aRI5qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiNuMSnslAZ6XfrDysQjG5Rg7ArTzZ1HlQzr7jlYRuenVMkKNxICh/bn/oFjlNEKFwf0q1M5scA0qpz77eI2QkR0v+U5+cUbP+2hgqjrOFfBHAv+2quNIssiOjTGJm7+d2s9jQ5/8eygdwBIUNUVjGKHKsohqsZftyW9OabsGcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QEyvf2UM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WOmlfpAC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QEyvf2UM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WOmlfpAC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S3kDd52112409
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 09:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vpAxPHzEnIqyJBQRocZHAzzK0xrcj2x1AR2IF+lJmZc=; b=QEyvf2UMeBITgznu
	+c0glZBplK9L1i6Oaneda/tHjAbz6LNUlUwMrH0Jpxp8ViGgZEBprVEyNgn85/Tc
	TwLrPEcgFWBuxVHTSHUX0nJlMzkGWEjtsG7KuBooBBkBFhsE4Xj9zE62/Dalag6F
	F6lx98sxn4wrLMEMF5Q5ZcgrQFeGOxnhaQ57CU9xxtaRTvb8Q9w69P2XbAtXDRyS
	3HzBUOMTtgTdyJ/Hy0mZAW30tndjpuiVRCZVbMp/Ku8g7DOLK0gSQ4cujAUYp+Wn
	90gFXSWaT2eNtjZuzKSenmmPGazPCvNuaI62Hfc/V3u7oRS0Q/ZDAdD84nNgGy+C
	4Fd0AQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbjtb8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 09:20:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so22741070eec.0
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777368012; x=1777972812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpAxPHzEnIqyJBQRocZHAzzK0xrcj2x1AR2IF+lJmZc=;
        b=WOmlfpAC7eJHFXYE+rj3XDYSE6sVNibDBVQ+SqD0vpSlyqFSTWzaGYLasVUWaWdcoT
         o7LDmvVvmo7EPJu0qX3VJVl8xnZ3K/pWSFLiUqE5KOPtfs/s7wAvUD9UFFCTbZzxgmJ6
         xak+FwLRQEU1OOt2mLODrNWO0hjY32dLzyWyTocho2yj8nhDXpq4K3eApymkEp9+RRwA
         tmurd8v5ar5eTN8vLpshwc0fxbIC9whh4p4Mpp9E0MPPL4TrLEltPrWIWmXrDt7SLgoY
         lgsb9NjUJKk5yIUBjZTKW9vtXqOXefA+w2IJQwp1h3stZOmhNLfaDih18hHv0mJSo1E5
         PEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368012; x=1777972812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpAxPHzEnIqyJBQRocZHAzzK0xrcj2x1AR2IF+lJmZc=;
        b=TsAwznJRucQATtuPihshPZnFzhIXSZTWn33/rhbi5T1GoyVgLGDmXgtkorccLxnjE2
         q9tcFJc8zdLoizEdQJRP8KrnVZ6heuoS99Y51C85ZGbOSFuzkDk1qXFPeQOOXIFth1gt
         IndAMqXKii/jNY4PBW0bH4089t8J3WsUWyzZt4uJIKeatIJaWGgaf2gp32DRrUfnWyIX
         5WNO0ybsEDbD3w5XvsFT6gxiMB1wAjEyKcesFoIcf679CL+2iAzLqr1kEqJR/rJj9DLl
         KiGIMSZh8FihETcV7KqzQC6wP9BtYQOXhU1kIPpqSIpjD1svMsojfni5Tf0t+TlacNJf
         F+Tw==
X-Gm-Message-State: AOJu0YysH9Ctv8dGTQKkDSRAWFARC3VvuoEmuLAfBffKiKQ+aFmtoNGd
	j7nXrGv1pqQbxkSwRN+cLHOQ2HXyVEsWjQGoffGrmH0wX0xU6sEDmiXObwE/zBKXIgbs7LgB5TL
	cQXf0ejnM4DnN2/ICoGObZTfC/y+/inW8gVnhKdXd75D7irPzOHml3ncDSILHV183uQ==
X-Gm-Gg: AeBDieuHAcpu5PUjrLqbLIXYp4EDrbIkixIoFzekNzOayoNALgJWJ9KFJcbNn2XtwRU
	+unqyc1/N5Prh+MvaZb32cCRQtIiz6QVOkssK6IFpQ0yffX3A2VncviuxaphJOP0AtMYm0Ti132
	tlxpo3hwjisAVbQYB9wGh4Dq1dfF23dDGBBrnSpc+5y9cy+9YlMT2U6WYIJJJ4nnEv0eT8JscgA
	aoXFVPa7kvglpPNFEyYCtcPfJDaLp/R6/Z37WFJm2+jH3W117HOykcqv4s2RYie8KnKMJO76o05
	+m9hhP7v/yHt5IKGf4x3I6eoEAvEbXKgMqpMA6hMUn8G+z0Tr7rjGTjZ4Bk6a2sy0zwo70ksOkq
	DJaDSm85vUA8VgZfRlHANjbc1265EwtImNf4kB5otZVItC73BcRIeYJrIPhigeNyB5+EOfrwsYq
	DIqh8MtcrXnno3hg==
X-Received: by 2002:a05:7300:bc1a:b0:2ed:e17:d50d with SMTP id 5a478bee46e88-2ed0e17d71dmr608529eec.32.1777368012409;
        Tue, 28 Apr 2026 02:20:12 -0700 (PDT)
X-Received: by 2002:a05:7300:bc1a:b0:2ed:e17:d50d with SMTP id 5a478bee46e88-2ed0e17d71dmr608514eec.32.1777368011821;
        Tue, 28 Apr 2026 02:20:11 -0700 (PDT)
Received: from [10.110.45.159] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a103542sm2463767eec.21.2026.04.28.02.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:20:11 -0700 (PDT)
Message-ID: <6390db35-7f8e-4d00-9c1f-43d676007910@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 17:20:07 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dm-inlinecrypt: add target for inline block device
 encryption
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com, linux-kernel@vger.kernel.org,
        adrianvovk@gmail.com, dm-devel@lists.linux.dev,
        quic_mdalam@quicinc.com, israelr@nvidia.com, hch@infradead.org,
        axboe@kernel.dk
References: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
 <20260410134031.2880675-3-linlin.zhang@oss.qualcomm.com>
 <ae7yzw-5wz9cqZt8@redhat.com> <ae_vacHQ75AgZbm_@redhat.com>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <ae_vacHQ75AgZbm_@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6ldoZvIV4O26u7Q2r4ccFD-RK3a8_Sg2
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f07bcd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=1XWaLZrsAAAA:8 a=mLr8kJcTbZJnnLskd6wA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 6ldoZvIV4O26u7Q2r4ccFD-RK3a8_Sg2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MiBTYWx0ZWRfXzOZR63dsWQSw
 ACF7eEXhg8aFUhALa9Abhy5BttxGl4U79vAfU9qVcqe7VtIhTGBpigf5CxaKUlWBLTKfkJA18pL
 8mHmcl7aubw8zEwgigEVRAJEcqhahnY0uPu84MXyax+HAvhLoTQhCbSC38mmoy/voQ5d4XOdvII
 imvoOLyMGlUr1AMrWALJ7CUAI160KILMxOfZVDFxZJHO2cic5EndnVR9sxzdP+0BtPQRRu3hSZ2
 11ylbCQqxXIRGqeKrchXbmvoDYuayK7r484KovlLK27/LSk+aZmcKwdYMOg0wJ1wbKQ4pm1RYc+
 0TnMZlRhXUc8cuqJSz5otjQLgIkgu/m3/Gp/kUxT7fpKxJ4jb8GXghhanUgyKnk9+sQcTc+22lR
 QdNd9f3ZvruCuLRmkaPm6KljX5crCYdXwFoMRnAm8tCiismRx3lOcCvK9cYx9OE/i4XaiSxjh73
 kHVxolblU7KxsjoRfWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280082



On 4/28/2026 7:21 AM, Benjamin Marzinski wrote:
> On Mon, Apr 27, 2026 at 01:23:27AM -0400, Benjamin Marzinski wrote:
>> On Fri, Apr 10, 2026 at 06:40:30AM -0700, Linlin Zhang wrote:
>>> From: Eric Biggers <ebiggers@google.com>
>>> +	/*
>>> +	 * Since we've added an encryption context to the bio and
>>> +	 * blk-crypto-fallback may be needed to process it, it's necessary to
>>> +	 * use the fallback-aware bio submission code rather than
>>> +	 * unconditionally returning DM_MAPIO_REMAPPED.
>>> +	 *
>>> +	 * To get the correct accounting for a dm target in the case where
>>> +	 * __blk_crypto_submit_bio() doesn't take ownership of the bio (returns
>>> +	 * true), call __blk_crypto_submit_bio() directly and return
>>> +	 * DM_MAPIO_REMAPPED in that case, rather than relying on
>>> +	 * blk_crypto_submit_bio() which calls submit_bio() in that case.
>>> +	 */
>>> +	if (__blk_crypto_submit_bio(bio))
>>
>> This will still double account for fallback writes (which call
>> submit_bio() on the encrypted bios, and return DM_MAPIO_SUBMITTED here). 
> 
> Just to clarify, I'm talking about the vmstats accounting. The IO
> originally gets accounted by submit_bio() when the bio is submitted to
> the dm device. For actual inline encryption and fallback reads, dm will
> submit the bio to the underlying device using submit_bio_noacct() to
> avoid double-counting the IO.
> 
> For fallback writes, __blk_crypto_submit_bio() will submit the encrypted
> bios to the underlying device with submit_bio(). This adds the IO
> sectors again, even though it's the same IO, only encrypted now.


Right, thanks for calling this out.

For fallback writes, the IO is still double-counted. Given that this only
affects IO accounting in the blk-crypto fallback write slow-path and not
correctness, I think this is an acceptable tradeoff, and we can leave a
TODO to revisit the accounting once a better solution exists.

Add the bellow to the annotate.

  /*
   * TODO: blk-crypto fallback write slow-path currently double-accounts
   * IO in vmstat, as encrypted bios are submitted via submit_bio().
   * This does not affect data correctness. Consider fixing this if
   * a cleaner accounting model for derived bios is introduced.
   */

Do you agree?

> 
> -Ben
> 
>>
>> -Ben
>>
>>> +		return DM_MAPIO_REMAPPED;
>>> +	return DM_MAPIO_SUBMITTED;
>>> +}
>>
> 

