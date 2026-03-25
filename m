Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF036166B
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439838; cv=none; b=m+iXKVTrjkipIrE8kOt7c43JmODnB+/9d+d610pRfinAmtpfTUw5XOhHWcahKDJ+ltXR0aGNO5vHarWvBsXgTbI/FdIRrudDoFlJzY5PyuLHoDH2OdocQOeJMYmq7jp8jYtYYWW9/+dcgqsbfMv8tl2tyULrJGvyFQpDXLOHSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439838; c=relaxed/simple;
	bh=rGUXkPwSkQ89I158wBw/9XHF84KlHiIQkhQ/gUtbYRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBITSDHgA+uX/aQA7Ti1JRaDkNEGZGa+llzjav/ibeDXtE+ulFPfFO3jHXB0p7NUzkdyB8lQTKE+CqhpWHYww5BF2/9XauQ1MUJO8xKqlCP8MUHK4eITpaKyr13V3n1/1Ku9PPtAVzSCBnrk4/hv2MfKdupc7TuGlcR9RDjDsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R6Q9LAS6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZT5mDwJ/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R6Q9LAS6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZT5mDwJ/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBGGY82197444
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 11:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gr18nfu9JJ8gSoYFoxnvVAHkTdc2dAzT6iMHWG8h1ww=; b=R6Q9LAS6EO7rrk50
	nW1Leqjq84qwf6cfDWMfEvVB4SOmxhkM0NpHrN+1l91gUTrNS125PoWtaEJPWojr
	/TAiUYD7Xved23H2r2ytnowG440qLoHxLB1wHcv/GWSYZM94ubTb9rrnRFOCW8+c
	Kapivy3iI1oh3iJwDRmn+XANH/v5K2NGH1+gIe4xtBHnibrd1OGnZ1STNHrKFXjR
	fJXuuRg0x/oJpzeJBpMv+YuvT5TQq2PdTNs1Zns0mET44fu3iklMPdOmx0xqVN64
	1/Gq0g8l/xwGOJgWVLEYyEyXC7dnKHtugChDRiAyCuXg5PyDrmhmqg41mJBkvrLO
	rMMwoA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d48599ng0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 11:57:16 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c0d15416b3so28567221eec.1
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774439835; x=1775044635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gr18nfu9JJ8gSoYFoxnvVAHkTdc2dAzT6iMHWG8h1ww=;
        b=ZT5mDwJ/6xYMqh0tISmI1Cun9cwBEO1A+I0nZVJoYPNfh70WaeJiK1i9wqcQVgQY2i
         0jvvDNXRvo95KSIPDrZ+MQ05tzwns1rnOrjozX6wXo6oJbwNg4rW/265DEnVu4Q6au5j
         wCCZvwXzt4wI/n5XSTbvZtgOCVaEvq+Gpe3cu5r+FrBzMEoEntXMo59OaCSzgYhuzhLP
         39t1NS9SCTR53g1kQ55HNqsBslcinhwjsxx9gzpFYC5NfESd/YbbafASHtt3G+K9/ZVl
         AiBHKOMTt3KXLoavQzaWdHMB83uGUggBJspthB8vSjS3tkAGJLf9LT4kiowPL5c2imAO
         NlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774439835; x=1775044635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gr18nfu9JJ8gSoYFoxnvVAHkTdc2dAzT6iMHWG8h1ww=;
        b=Hu7KM7x56iBobrr9caYqOq0DoOI0LgCR4YknQB3Y16sShXOrkzqfhB6zd45mGmcSbe
         Mav6LVNGXxBZGJLxHHg4Glr0CCaoSlq1FVyzEFAl8009l5Et4rO3g3NXXZt9k2uas9/b
         f4+2fQYWkeaygp7KeaObhA0yzGxvBnRE/dvwMEGxowaZf7t/klXVmtjmTpDT/mABPNms
         HU7oidEYV9mYpkeK78So08DSxvqbKROsM2bZQznznk+3H0Ff3QzanHigkFDgLgaF7PWT
         fbjaO5NVg8JzFSebDaZ99MNfnpEpq0VP/yqWaF8N2cFAAmbYtIgtwEJmgEK7ub3u8m0I
         p0ig==
X-Gm-Message-State: AOJu0YxdWUijcsa6/vP6H9vrifbMbhO90rIXbj1IRuhvgF6qv5ckrITs
	PY+NspDMbEbVKAJuAeBADTIknE7v08CaKLeEJO9qlRfWPXLYiE8B1/iOp+S6jkxkSm3N0jpM4Td
	r/lifGITybFjdM0es0Vx466f01VhMLwvfgG74TdFHi+LdNtE8fle4DZQtlf0XBOiW1690JweTDg
	8l
X-Gm-Gg: ATEYQzyxEg2VXL0cSRASp0sw2kuazEYPaFRB3643EkumghSPW7GVb93Dl73e36yAT2h
	R4e4OaWmSnXYm9QOrOKzTMaU+KiR/1QlOcTfINMeUXrBbw27Hng721Zvgvr90uSmtF7ax5FMRG6
	h+1XADV0Xiryfu9nL01OvtRNEbj98pwvlA1vfWcl4da3WN9HnYdBkZUdEL3dufsl1YxZkvxqDZp
	QhprphugEM/FbKJGpxf8qyP3r5zQ4QX97C4oDJ5rHyamY+ObiSjZJg4ZBVDe2Yz0cfJ4HuokQ0C
	yTZ8Dro4pAtFl2oGQfaYR9s3o23u4GTop1UVpAADH/YvAJ90OwOARS/Ao1G+XppjDQ8VDaogSFl
	vt0jsSArwW4suM5ZzN0I9fC6n+KGTjonw82bT9bwljNAa4OwC1HU8Ji2hxl0HoA7hbqB7YxTWRf
	Gfd4A=
X-Received: by 2002:a05:7300:7ba0:b0:2be:e4b:60a8 with SMTP id 5a478bee46e88-2c15d31dbfamr1990506eec.7.1774439834843;
        Wed, 25 Mar 2026 04:57:14 -0700 (PDT)
X-Received: by 2002:a05:7300:7ba0:b0:2be:e4b:60a8 with SMTP id 5a478bee46e88-2c15d31dbfamr1990491eec.7.1774439834282;
        Wed, 25 Mar 2026 04:57:14 -0700 (PDT)
Received: from [10.110.19.183] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14c99bsm18187680eec.1.2026.03.25.04.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 04:57:13 -0700 (PDT)
Message-ID: <c86ff571-092e-4181-9bd9-3e99f7c4b1b2@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 19:57:09 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] dm-inlinecrypt: add target for inline block device
 encryption
To: Milan Broz <gmazyland@gmail.com>, Mikulas Patocka <mpatocka@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrianvovk@gmail.com, dm-devel@lists.linux.dev,
        quic_mdalam@quicinc.com, israelr@nvidia.com
References: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com>
 <20260304121729.1532469-3-linlin.zhang@oss.qualcomm.com>
 <20260312070110.GD2359@sol> <5a310122-bd7e-d10e-653e-bc7e09681478@redhat.com>
 <7f613001-fc2b-44e3-ac14-7e661cf52fdd@gmail.com>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <7f613001-fc2b-44e3-ac14-7e661cf52fdd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NSBTYWx0ZWRfX8hoM7Kly2fxo
 EnaO1sRUT2/GhSZJn17zN2usuziwgKBgbfybqTTLNItpFXoW9332cNZX9wDrF8HZOCgNmL3+yAg
 A+MwMvpRApJFnPYX0AYD/I9EuZqYdP12qz9q13EON2nK5rZMToz9U9NBDupHeIYiubUTJMaqXKy
 7Q/UENr0Bm8PQnCbeLLEt1VQ4bPep3E+1W+fy3hZye3B494Ii18vy5GOeAYzqLmPcLeSl4yKJGw
 zVDBmV+yIN/Wbu2xI5TMK2CZ2n+GVP6QZ0aDY2kH9ypiS+LvIs/ZQrliAXzHVZ0nr2t76kn24VD
 Gshl8CHAwolOK1C7fcDUUb55/ZyJPnHvyhYfF+HRjK1jObVkxyPN1nM4g3926DSfTRCDZ0ZrYJd
 BVsLnpZ1YyIhOl3QV9gSdLf71gy2E7WpzWJo276bpzPYq7gIP0AJSWoffvb7Z4earRrC1IsAZWL
 OzeAwJArEKV3pbZQlKw==
X-Authority-Analysis: v=2.4 cv=VODQXtPX c=1 sm=1 tr=0 ts=69c3cd9c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=Q6PVb_SgueIFlp-ES8wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: Up6btocbgtK7JpQj2ragapkalWHkCJuH
X-Proofpoint-ORIG-GUID: Up6btocbgtK7JpQj2ragapkalWHkCJuH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250085



On 3/13/2026 11:27 PM, Milan Broz wrote:
> On 3/13/26 2:25 PM, Mikulas Patocka wrote:
>> On Thu, 12 Mar 2026, Eric Biggers wrote:
>>
>>> On Wed, Mar 04, 2026 at 04:17:27AM -0800, Linlin Zhang wrote:
>>>> From: Eric Biggers <ebiggers@google.com>
>>>>
>>>> Add a new device-mapper target "dm-inlinecrypt" that is similar to
>>>> dm-crypt but uses the blk-crypto API instead of the regular crypto API.
>>>> This allows it to take advantage of inline encryption hardware such as
>>>> that commonly built into UFS host controllers.
> 
> ...
> 
>>> I don't think it's plausible that this new patch was actually tested.
>>> The version I sent in 2024 was tested at the time
>>> (https://lore.kernel.org/r/20241016232748.134211-3-ebiggers@kernel.org/),
>>> but I see at least two things that would make this new patch not work.
> 
> What a waste of time... thanks.
>> OK. I dropped it.
> 
> Well, the inline crypt has some advantages to proprietary internal
> hw implementations (like self-encrypting drives)  - it can be actually validated
> comparing to sw version.
> 
> Anyway, Mikulas, if this dm-inlinecrypt returns one day, please be
> sure that we do not have security-related "regressions" like not supporting
> keyring. There is no need for dm-inlinecrypt to keep key inside the mapping table.
> The keyring code is in dm-crypt, it should be easy to adapt it here.
> 
> Thanks,
> Milan
> 

Thanks for your review.

I understood that supporting keyring here is to ensure no raw key exposed to
dm table. As implied by the name dm-inlinecrypt, the key used by dm-inlinecyrpt
is a wrapped key, rather raw key. Can we keep the wrapped key inside the mapping
table?
In other word, can dm-inlinecrypt support both keyring and hex key(key in mapping
table)?

Thanks,
Linlin
