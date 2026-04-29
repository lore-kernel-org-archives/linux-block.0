Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F353C345F
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466050; cv=none; b=Vrrp4Atg0x/CExMK7hirCuwF8vE/Ah2epSZDgoRvZTO/1y/5R5r7n5OgpaHmDez74JX9zMyMrVUx+FZJK+PmqQB0x5eMM78xQZeyZl3xNJ0FFaK7Kl7DBeVYl9sG3ekFh1FYShsIL6azWw7XDU1n2/jNGSsUJVt0kLzJHmwGsAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466050; c=relaxed/simple;
	bh=sdcsv9NyXfxxr3df9sMar2q/gbpIVDepv6xljGdN+TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dfb4lPkVk1CzbyhRUKus9Qq9+zYxa1F/DwPD4EnXdaB2JyQrnansJ7P3HYqSayPXQKgj72e6c970gJne0VQfa/4FJOPH0x8ehpMGhIdNWfi67HdIsdZARNPnE2Et1o96jT8TS5Kc4agZSiFtLyJ9BuwDzKQgzUb9Njm7cymllwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rpk6QOvj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ja9m+IWK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rpk6QOvj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ja9m+IWK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8qWL62889857
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 12:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ESKRVLao67V51kqXr2l1u0fZIaIK0uFsHy1DPkT8I18=; b=Rpk6QOvj/ExBWkDK
	ufF5Au2L4yaCwWKcCSGrKdknn0mLwhq0VfWLMbDJ8BZUS/uzbqCSCPfVGO8q032g
	5H3TwX85uHd6Q0hbQgczNaTTRUiVeF81tUKThK8yNfD/NiKy7Cq1MZKjRWQ775KG
	p+3hkT05Yb4PJiRCFLr8wpdrzg0r1/xSAVNwQDfrqE7RNjhVg7WVvvqbACu/nXYy
	9IwFrXZ4Awv5SRZB/6RRawSqrCKyGGXPZDfS3yjfoif+aZr5YpSNqe4YbVESXPeW
	Ojxn04MvZEKAqg0ZCGCXZI+skfpldbqzB0ZksyfsU1AspBExBcmfG+BVULN+2Exy
	SrpNNQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du0wqbw05-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 12:34:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so27692728eec.0
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777466047; x=1778070847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESKRVLao67V51kqXr2l1u0fZIaIK0uFsHy1DPkT8I18=;
        b=ja9m+IWKswDlL5xuBOhfPO3HTfYVCxia4f20LBPjidONws9LKJ3MbjjFCG72ZCLuWv
         KR5fDq5FfpzQ4T2cqvQFC3jd3mPr+G3riQKWc/6i7f6AnPMaB9rgqa9drSm7dOdMiANF
         ngwb1M7Bd4NlalGRZIehbrVdybi7majZVkn+Erbt2fJuokK94TfsNE+H9Q/VCxZ5hDag
         WSXh258KH0UE20VYTB5n2p9ov1nuNlyq4R6CLJfszOBEOHoBDo4S/AwXrlZiJlT5RlrL
         RmUJN1ORoWP5zRiE0hinb4kuPh6a4Fm3qc2YAwrQAx/r2DK+HJTos4yXVH3RJ5yLU+WE
         7NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466047; x=1778070847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESKRVLao67V51kqXr2l1u0fZIaIK0uFsHy1DPkT8I18=;
        b=VkAWj8cNatsNkKoBfgEzVVIA6pWjBezEfamC64i+LmET5w66hq/SCHqI/GPl6vVT7z
         XuE/1Pqhor92yMtyHd6lYu3Dcl58qDVk3wTvyroNvVI9UaX1/Wok7jX8MaIv6p5RmaAo
         GYcKpxu7fsnM1VYCRRsaZoZZTWmXgQsvyht/Qk5IrppBDxU3hJ9PlsyGDUgXvRl1EVYP
         mzwIdfDtf6iYuCbSTB22uX3EpSKeqcIAcx0pWGomn0eWFIuv+lYzyZQdBQlrlI3U1Cjk
         /RdLWTgGgBjNdhxMQMEUspzY48rL2/VFYLWreeW52ivbPps7imAUbqTJ/MN3EO3wUsi4
         YieQ==
X-Gm-Message-State: AOJu0Yxzv0e8OEanhq2pGKx/2Ryj2Yex+fTgxcCPlyRfEISBFFfWAqLl
	pcLiX85naoPZnHklk5p69HVIk2FNvZDYUNyDZRnmO9J0cY8Zc2W1THbctAqH5xrKWoV3d/bRfEf
	NHdkvr/O26S5aH2uANRiibNoRsZ21ECtDQVxpH6RxnDLOXWHcLQ1bzVCBbQl11pHS7w==
X-Gm-Gg: AeBDievV93Jdfng57XLdBQq304Vb8NwjizE0pTdMQ1njSd5OcBwD9FQ4oqPOlS+PTA2
	2oObgvqCcqKFQ0yJu1ysNYznf7r/Ilugklzcb5jayfFNHJkD/e3LhBT1bPbrSaxQIs1ZYYpEzPB
	/nHVBLlgnPNVjkFBfVFyettsOocAlttm8y6w8iQeX+tUASI7/ECOPv0bVL/0uw/t0p+HM0OOT00
	fIxJpy1Nv8tPb7sGfcBi1+eRZ5lWTZao+xc9B5mFeTkTymkDzFU+AwK2u+dC71c4dIYG4MLkBTz
	URIOg+s9wgAStkWCkIiQ2CZpWCRyKSKtJWh7NLvOeYefz6sbHEmVYjw3KU6hFcS1Y9T5wPmO6yK
	XIOwlbTqd2scfaOeA695CXEgxQV76CiKItwFfOb2Op4YP2Jhb94t5b/XWc7/7dJdPuAdUV4E3D0
	ZaVGDi+zBXx/v6ZA==
X-Received: by 2002:a05:693c:3017:b0:2df:7b88:a1b0 with SMTP id 5a478bee46e88-2ed0a1a9028mr3495472eec.27.1777466046135;
        Wed, 29 Apr 2026 05:34:06 -0700 (PDT)
X-Received: by 2002:a05:693c:3017:b0:2df:7b88:a1b0 with SMTP id 5a478bee46e88-2ed0a1a9028mr3495449eec.27.1777466045450;
        Wed, 29 Apr 2026 05:34:05 -0700 (PDT)
Received: from [10.110.45.159] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c09c6e3sm1847750eec.25.2026.04.29.05.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 05:34:05 -0700 (PDT)
Message-ID: <7ab5cd97-30b7-42ca-80ce-6d9cd8c45b73@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 20:34:00 +0800
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
 <6390db35-7f8e-4d00-9c1f-43d676007910@oss.qualcomm.com>
 <afDh8XRWW_JgaUP3@redhat.com>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <afDh8XRWW_JgaUP3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zRXXx_pP_-gwRLgTjlWb78qpIhxnJvzN
X-Proofpoint-ORIG-GUID: zRXXx_pP_-gwRLgTjlWb78qpIhxnJvzN
X-Authority-Analysis: v=2.4 cv=BfDoFLt2 c=1 sm=1 tr=0 ts=69f1fac0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=1XWaLZrsAAAA:8 a=PdZeKNdsCEgzLFXmAeUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEyNyBTYWx0ZWRfX+qJkAFTWJA/J
 dSOcFOSZqva8vZKBwLDDHJ0eR0uvsBtO9YzMJ7AVGLhEs/EA23vTYTLDFxwv6Q+E1mYMS3bCr7m
 MUVZ5g1adc66INnV20lPvEHKdhj1IelxVRj9MJ37VYTH4RguU+dHbqvw/OndcC3l1aam50crGL7
 z3sSVFBHffcOJAbppKxFSGMCREZoDbHYNaoQtsloSpR9A5/d/CLz7KkHR/0uexyTBU4/Rxhnz2a
 0HYR+rYMwzaijZ7y8nCzjIaEqV1KKXIoWTbx9Spu0lytuzSHDBUFVGbXjLONs40qCKCUM1SvYOA
 c+8wFHOsYmeJMNz6Owt2Tgxg9WYMURZhph0yxhDscoyjI2b90/+azg33cz8f/XXhJFdZvNJndis
 uv4fF20V/aj3knZpA4xu0KhnxIzGRldZENTQowaMuXjlGEDsr2X8HY7Q98EO4JkcjZfyOGQpbO/
 6BAwNviYBe2x9ESAIgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290127



On 4/29/2026 12:36 AM, Benjamin Marzinski wrote:
> On Tue, Apr 28, 2026 at 05:20:07PM +0800, Linlin Zhang wrote:
>>
>>
>> On 4/28/2026 7:21 AM, Benjamin Marzinski wrote:
>>> On Mon, Apr 27, 2026 at 01:23:27AM -0400, Benjamin Marzinski wrote:
>>>> On Fri, Apr 10, 2026 at 06:40:30AM -0700, Linlin Zhang wrote:
>>>>> From: Eric Biggers <ebiggers@google.com>
>>>>> +	/*
>>>>> +	 * Since we've added an encryption context to the bio and
>>>>> +	 * blk-crypto-fallback may be needed to process it, it's necessary to
>>>>> +	 * use the fallback-aware bio submission code rather than
>>>>> +	 * unconditionally returning DM_MAPIO_REMAPPED.
>>>>> +	 *
>>>>> +	 * To get the correct accounting for a dm target in the case where
>>>>> +	 * __blk_crypto_submit_bio() doesn't take ownership of the bio (returns
>>>>> +	 * true), call __blk_crypto_submit_bio() directly and return
>>>>> +	 * DM_MAPIO_REMAPPED in that case, rather than relying on
>>>>> +	 * blk_crypto_submit_bio() which calls submit_bio() in that case.
>>>>> +	 */
>>>>> +	if (__blk_crypto_submit_bio(bio))
>>>>
>>>> This will still double account for fallback writes (which call
>>>> submit_bio() on the encrypted bios, and return DM_MAPIO_SUBMITTED here). 
>>>
>>> Just to clarify, I'm talking about the vmstats accounting. The IO
>>> originally gets accounted by submit_bio() when the bio is submitted to
>>> the dm device. For actual inline encryption and fallback reads, dm will
>>> submit the bio to the underlying device using submit_bio_noacct() to
>>> avoid double-counting the IO.
>>>
>>> For fallback writes, __blk_crypto_submit_bio() will submit the encrypted
>>> bios to the underlying device with submit_bio(). This adds the IO
>>> sectors again, even though it's the same IO, only encrypted now.
>>
>>
>> Right, thanks for calling this out.
>>
>> For fallback writes, the IO is still double-counted. Given that this only
>> affects IO accounting in the blk-crypto fallback write slow-path and not
>> correctness, I think this is an acceptable tradeoff, and we can leave a
>> TODO to revisit the accounting once a better solution exists.
>>
>> Add the bellow to the annotate.
>>
>>   /*
>>    * TODO: blk-crypto fallback write slow-path currently double-accounts
>>    * IO in vmstat, as encrypted bios are submitted via submit_bio().
>>    * This does not affect data correctness. Consider fixing this if
>>    * a cleaner accounting model for derived bios is introduced.
>>    */
>>
>> Do you agree?
> 
> You could add an extra argument, for instance "bool need_acct", to
> __blk_crypto_submit_bio(), and plumb it through to
> __blk_crypto_fallback_encrypt_bio(), where it could be used to choose
> between calling submit_bio() and and submit_bio_noacct().
> 
> We could even add a flag to cloned bios for stacked devices, that could
> be checked in submit_bio(), so we didn't need to have
> submit_bio_noacct(). But this is a pretty niche case with other
> solutions, so I'm not sure if it warrants adding more checks to
> submit_bio().
> 
> I do agree that people probably aren't using dm-inlinecrypt for devices
> where they don't actually have inline encryption capabilities, so it's
> not a major issue. What to you think, Mikulas?

Thanks for the suggestions.

Adding a bool need_acct parameter to __blk_crypto_submit_bio() would require
updating all existing callers, which feels rather intrusive given that the
accounting issue only affects the blk‑crypto fallback write slow‑path. I’m a
bit concerned that this would broaden the scope of the change more than
necessary for the problem at hand.

An alternative might be to track this at the bio level instead — for example,
by introducing a bio flag or metadata that indicates whether accounting should
be charged for a derived/cloned bio. That would avoid having to thread additional
parameters through multiple blk‑crypto entry points. However, this likely needs
a broader discussion to make sure it fits well with existing stacking and
accounting semantics.

Also, as discussed, the current behavior does not affect data correctness; it
only results in double vmstat accounting for fallback writes. Given that
dm‑inlinecrypt is expected to be used primarily on devices with actual inline
encryption support, the fallback write path should be relatively uncommon in
practice.

With that in mind, would it be acceptable to merge the current change as‑is,
with an explicit TODO documenting the double‑accounting in the fallback write path,
and revisit the accounting model in a follow‑up patch once we have agreement on a
cleaner solution? What do you think, Ben and Mikulas?

Happy to iterate further if there’s a preferred direction here. 

> 
> -Ben
>  
>>>
>>> -Ben
>>>
>>>>
>>>> -Ben
>>>>
>>>>> +		return DM_MAPIO_REMAPPED;
>>>>> +	return DM_MAPIO_SUBMITTED;
>>>>> +}
>>>>
>>>
> 

