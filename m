Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF029827E
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421732; cv=none; b=StLY6ALpHlMUovU4p/3nVJ09S4hm3pScZM6R2uS6hktEalkSl4CV8GgwX4jyQDqCdIlCMFj1ZozJRlLmHnNayp0JwEhrYO8dDWitlOFX4D85l9qq8nZpbyHHRvnpKJ0M8aHB7a+XmHiBralPAQ5ywMgJhweuEy1t0SraHgsLB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421732; c=relaxed/simple;
	bh=A9Bw7A93QwyB/11G0f5DcWqXROOckyJZYM3CCOgkNCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lscKsUDsLTnEs5Z++Lph3St8151IJAyIoh/TqSwF+BiEW0I9iwSEzkf973nnoGu+XMbdAN5Qza2t6AH5cglwXReknrpNuXX63qKLcE+YlOgB7JuxO5806kOoZHP3Yk2Kew9Y75LL8OfhqhOIF56KOUojpmSjelWjeTmGFG0Z/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ci3z0clO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dfJU92A/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ci3z0clO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dfJU92A/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P4uiW8989140
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/OyRLeF1qiRXWOZLHBDozmhB2d8QM8xWWW+aAnLORUI=; b=ci3z0clOgC8UHxX9
	ynM7JYqI7e71SxHgKyxjQsM0LgoUdR0M+Ch0zQDKMAN/w7HWOb+s3t7K6SRdnO/9
	Gt5S8TbUkQV/fLKNN4x9g7398akOBzlnlH8E53kGYdUk/wvWvyDHwNahgeyX1Aim
	dWQ2z4Qg1ev8c6KzrmR5dzfg7fakeVamWqmYUVfcwlzrLrFDUJr08zEkk6lZsA6G
	IdmRJrDzUzaemRNRuuUrOW63i6jMxxPBoEUeb+qWOjBP5TzXuxFTWyi7ouC8oMkv
	86VaGqZJtnj+lsNi2NSHlp6P0lBFSTrchdOYmEWjlvcHcrBVJM2qFzUuJaH8mMV7
	NdhYUg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m3g77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:55:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c0ba59a830so5190422eec.0
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 23:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774421729; x=1775026529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OyRLeF1qiRXWOZLHBDozmhB2d8QM8xWWW+aAnLORUI=;
        b=dfJU92A/UmW4e38htyYsiBk+ID4O9R33gMuR7wPNNx9DWpJfeFbdVTJhl86/JYgPJG
         K8zSxxhFRpEwDj96nt7OrQatDSTSTHM5bj2i6ir/3OYj5wWbPzN+7Cy/x7IYTL0xeqWz
         ZUfPW3QNveiUjx/ILMcVKzhC6DebhTwpAIPgqlIEBw8+RBf2fz+7Sh6273wLrS0ruu0k
         Srj0gp6uhxrkXEAB5xyfwu/Fy6oJXdgKSKtk7pvBQTer+SyKPIkJTXuFyW/yML3REV1a
         qbAs58uIsjHn+6SLKPfYe3FyAFc4v8ZQiDye2dRy5mZhArOzWqE16WuDBMDsx6wsBhHQ
         Vqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774421729; x=1775026529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OyRLeF1qiRXWOZLHBDozmhB2d8QM8xWWW+aAnLORUI=;
        b=PStbehRzx7BVSG1YOzr3h96QE3cKew46zm8IaiNIHEo4hC6NFC3VeuD0XEcjoY5KXF
         B4ZuMKIztOgq+evzzB6th8/5Wn6pjkOEwNnZsYYVkHMtEFkTmUya+62ivh63PRscXM7+
         nE7dhOVcljgElOH7cNwohBc4PWLHrgAPcF0lEZwCKM294AS1BqX/fqPsLSnwW6ugeZ0p
         7bg37xPQ8Qov4UU32GZ+RYyOLlUGmUdYmOS9zXIoK3FBGUVQiqRWCnjyAVeAY2czu3vw
         i3LOlPh4O8zuXNI8+KwOVM/L9B5wlu3Rp7mgJre0xQZxgKktqXFEaPEw99rENni3HfX+
         PWDw==
X-Gm-Message-State: AOJu0Yxqe398hK76sbP5J8fMq4xWh8JpZVm2hKVvfzhm6vA9AjgJrkzp
	GiChqVcozRumF4Gj+LN++QQskLkzaqFfiau4Bfe4U24a9b9HqJ3zPo/hAsuBnpQkkxzgGHLyxNe
	w2R21np2Ru75HRyYwwpFKFZmb8iai6x5WKcpx/2E+Hv3pyqmWXN6v0crzp5grWQn9ow==
X-Gm-Gg: ATEYQzxTuLSUClPc+w1MfZNdgHszXHbRtbez7q4Pjb9rh+amL4Cr9EDil2U2VKi20tE
	uiYLcE0bSdU77+qBA2y+4iX22uzPYC4TEr09Pya9xNLLaRuN9DYo6wvidpuRvkfMdJkcav1vylX
	1iKc2vSl6DlxESWPRs9tORotwS9wB60q1gIU+1ZppTNaEOhNkCdS+W7CaTDJcl84JEBdM2owTUw
	dyw6D2pEgynV1CNvYoh2RZMjfzyDwkvTBo/rXLOu/Uhz2/zuiU+HZ6tZLDecrLe4qIyfdfIUNkj
	OmTzHW/NU+0qgStCAF0GZmEY6OdE2SzP1doYLYg0cIDbv1sE2t7nFC+lbPjcOxoKnkdN8TqNX04
	TJdtMh3kv5PMZqowOrajqQlXPfv/cKx8MXxPsbbXuEzUz8OAqvMGUtdD66GAnRTwlKPfTI1AU9O
	1Hqtc=
X-Received: by 2002:a05:7022:6713:b0:128:d17b:e7ab with SMTP id a92af1059eb24-12a96ef7ce1mr1125002c88.36.1774421729174;
        Tue, 24 Mar 2026 23:55:29 -0700 (PDT)
X-Received: by 2002:a05:7022:6713:b0:128:d17b:e7ab with SMTP id a92af1059eb24-12a96ef7ce1mr1124976c88.36.1774421727992;
        Tue, 24 Mar 2026 23:55:27 -0700 (PDT)
Received: from [10.110.19.183] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733b4a99sm12883815c88.1.2026.03.24.23.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 23:55:27 -0700 (PDT)
Message-ID: <b837cfd6-a3fc-469b-9c92-8df6d3148a68@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 14:55:23 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] dm-inlinecrypt: add target for inline block device
 encryption
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrianvovk@gmail.com, dm-devel@lists.linux.dev,
        quic_mdalam@quicinc.com, gmazyland@gmail.com, israelr@nvidia.com,
        mpatocka@redhat.com
References: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com>
 <20260304121729.1532469-3-linlin.zhang@oss.qualcomm.com>
 <20260312070110.GD2359@sol>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260312070110.GD2359@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c386e1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=Oh2cFVv5AAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8
 a=p8t-2gd-wzcZwGZBdWsA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-ORIG-GUID: h5u0U2qDwaSesdfXPlRn0Phhw5RgwcYv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA0NyBTYWx0ZWRfX49v9Mz5KWEOd
 c5Aa4SdHensYMeB2ZC+9BCTDJNbSDAOQi0FaYZJuzGkUKA1R8GhebM5khPILMjtVJ7WSLQC3y8n
 Zke8vWMBCSRLpIlSy08z7pYISZvFJKjIBJ8yPf/zjzMO417AmPwyk+7Cr7Qv/VBXlkyg73+heam
 7eoes0m1EZVlD1Xu7G8DjvrxixVDxBVj9KMeQErvNDUCTow9T+drTnPw1fUCYWho01IEKuU1jEQ
 5pFxjHg2/f1B4H5kMqgr/Qh2TSU1cw6IHUnydxSaa5JzTkTZCu68ZmGqdGse51P+WhRt3rrj0HL
 LMWBuAGUE/l6KFhl23+uF/xF/21gDYkm0XfzT1fu6P4Pbrg2Jn3znnYmNyJ2iMJBlIfXFyS94kT
 z5KxaUyjafHBgjIW+AEaNWX7y+cRRd0Ldi3miHBJA/p8XAx4UgfKjt7PAyY/Gog+i/gHtKXW1aq
 utnGUfAcYeP3SyhSw4A==
X-Proofpoint-GUID: h5u0U2qDwaSesdfXPlRn0Phhw5RgwcYv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250047



On 3/12/2026 3:01 PM, Eric Biggers wrote:
> On Wed, Mar 04, 2026 at 04:17:27AM -0800, Linlin Zhang wrote:
>> From: Eric Biggers <ebiggers@google.com>
>>
>> Add a new device-mapper target "dm-inlinecrypt" that is similar to
>> dm-crypt but uses the blk-crypto API instead of the regular crypto API.
>> This allows it to take advantage of inline encryption hardware such as
>> that commonly built into UFS host controllers.
>>
>> The table syntax matches dm-crypt's, but for now only a stripped-down
>> set of parameters is supported.  For example, for now AES-256-XTS is the
>> only supported cipher.
>>
>> dm-inlinecrypt is based on Android's dm-default-key with the
>> controversial passthrough support removed.  Note that due to the removal
>> of passthrough support, use of dm-inlinecrypt in combination with
>> fscrypt causes double encryption of file contents (similar to dm-crypt +
>> fscrypt), with the fscrypt layer not being able to use the inline
>> encryption hardware.  This makes dm-inlinecrypt unusable on systems such
>> as Android that use fscrypt and where a more optimized approach is
>> needed.  It is however suitable as a replacement for dm-crypt.
>>
>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
> 
> I don't think it's plausible that this new patch was actually tested.
> The version I sent in 2024 was tested at the time
> (https://lore.kernel.org/r/20241016232748.134211-3-ebiggers@kernel.org/),
> but I see at least two things that would make this new patch not work.
> 
> First, the call to blk_crypto_init_key() will always fail, since it's
> being passed BLK_CRYPTO_KEY_TYPE_HW_WRAPPED but using a 64-byte raw key.
> 
> It needs to be BLK_CRYPTO_KEY_TYPE_RAW.  (BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
> support would make sense to add as an extra feature, once the basic raw
> key support is working.  Note that when I sent the first version of this
> patch, support for wrapped keys was not yet upstream at all.)
Thanks for the review!
Yes, a mini change about key size validation is absent in this patch, which
leads to the failure of dm-table loading with dm-inlinecrypt target.
Similar to dm-default-key in Android, next patch updates ctr function to
ensure the key size not larger than BLK_CRYPTO_MAX_ANY_KEY_SIZE, and pass
this key size to blk_crypto_init_key().

> 
> Second, since v7.0-rc1, submitters of bios don't automatically get
> blk-crypto-fallback support; they need to request it explicitly.  So,
> this patch will not work with blk-crypto-fallback anymore.
> 
> If you'd like to continue work on this patch, it might be helpful to
> check the latest version of dm-default-key.c in "android-mainline"
> (https://android.googlesource.com/kernel/common/+/android-mainline/drivers/md/dm-default-key.c)
> and resynchronize this patch with it.  It already has the code to
> correctly support both key types and blk-crypto-fallback, for example.

ACK

> 
> Either way, this patch also needs to be re-tested with the latest
> upstream kernel, which doesn't seem to have happened unfortunately.

I'll share the test result on top of the latest upstream kernel in next patch.

> 
> - Eric

