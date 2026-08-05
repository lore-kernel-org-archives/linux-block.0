Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9441A519
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969868; cv=none; b=SmUJxTxAvYc3PXQ9c69/Yaj4wI7IRorrPlenIKBqYZmJKdiroUNGNcxhJdsbECNjEzQiP60ao+KpZz2N8CEo3P0i4dRM8LDZuzU8YiJn3rOAdZOVX3c1hlL1qzBGHV9FeXVc+jJ9qUTIQAvAQIwvMmCMQBuzGQNH+y17Z9q5iew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969868; c=relaxed/simple;
	bh=y78uB04UaBBhOW4XOhBioQ1rp9ZOlz29j4SiZC6tJE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSSlzaS52A+DKccoJdBWOBEUPQJND+XBmhyTX75dotQKcatRo6gpGsC88QRSbtBSy7skWOzPKngsl76x4F+uvsXK89HxS4/WDCmId7XvVHdnWp7e0gU2IebU7NujViAs6hq9DByjXcs78swCNaaCuQKEKEu28GZARM0Ze2GYCIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ePr9KJpT; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ePr9KJpT"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Ma0Tv1518224
	for <linux-block@vger.kernel.org>; Wed, 5 Aug 2026 18:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=c8Cu
	7MLig2Oq2nSGqkPCY3VelAYgEPyIP2bq+cN5Jh4=; b=ePr9KJpTXStYPT87EV3n
	IarJZ9Tl8GqOybXafgD+KqjkXc86CsIR8WE3evkCGFu8Zi4b9206cpZoKo7qQy6c
	MAw0vTlyK4g/fCbgkHV4wCnuLX7kk7WLOMdtY6x6Td2+P0vVkxgPyo7Vrx9+HHab
	lejjZprU7EWkEMSwwv6/Ww+//lHu3cd1pIbWhrnABu4IzMPzaKLT1ic+VXLqdUfx
	ObKIfUesihUp/lWB35jQEZYrLGva2h9RzVvFFh/Y/hMNs8BblKaJlM9RG6HjlFkB
	CSkDVnKq4zXLR6GLj2lNB9hvHpga2bOmjEIBnpgNsouylF0XGpM06vzfhpiII7Ov
	Ew==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fve1902jn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 18:44:20 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51a8db414c7so19001661cf.0
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 15:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785969859; x=1786574659;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c8Cu7MLig2Oq2nSGqkPCY3VelAYgEPyIP2bq+cN5Jh4=;
        b=VT484ElMhSfCrEY6LnVjGdHRUm1K//yryEunvI7XyhppC2WwoQjY39dpN/4CJkeGA6
         1xi9u5PsI1rEVys7f0PzSXQgFmfHgVFewj45q6aH/lMRCQclgMDEJ0xsgpTYURw/yzUu
         E+jxY8OUG1Mtf/1AwlowfHgjW1WPLjpC1pHOCsgW9Ce35/Sd32OxY5oRSiVkIES0Civu
         pbJZUrT/lkKneBkAclh3CxKBwF0YdAXq5f14+PF6Hwfgfz95lpWzaFLBkLEZVR1pyqxx
         0UAedH6onvuddn7LeZcY2yU36bdwPHH0UGdTQbc/IxGV9fiR4SFwyNLpmVYqlI2LGhrr
         Vwjg==
X-Forwarded-Encrypted: i=1; AHgh+RqD80ETR1n8vgGs2oihaILfvnZ1B53dCpzgV2i/xddfqlK9w5D1p4eBPiV84o4XnkuX3gVIdnCAT/43vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO7YYuX0STc3tYC42CTp6NV6XUH8dNb4UVGbrakzdE/IMfuUCq
	r+ekMzXkW3pIiL8x1Du2neX/uU4DmhrWVb8wCvnh/rxU0fpySZUS5AHoKhW2vyqI/zJxty8Vyev
	gUYfL3VU2sD8LEcSg1+UcAYVbdu+xue8mCYfw1/OvHl9WbS99o4ieAiVXs6dH
X-Gm-Gg: AR+sD12ZYy2mFrWYnZnG2Y889mDg/ANOcNvOzFL1LoGCpmEwkuAtFXc9eDoAEs487w3
	+ZprR6znFb2PVv5Cdt7uxvwEQxwsb+F++5X7CzXMU3IN2Q+Q15IpEqutft5fEAJ9E4DJHa/lAF7
	96AY2tqmfsOJXV7glGkUpHth24KCJ3cy8TBD0xEX1ypPkdCiGXm1BNqUMjI82WZyOEpJKHaw/ks
	7Vb6Mya9C2QczELIv/twe95J5gBrEDHup4eoMTIMhoaIVxnTQLzGo0yDgUBs8ZYHAplawe1ySkY
	v8474vmbLU76ndSsTnHqYsvE+abPMpz2R0q2X79G8lJ9iwxOHOub1TJqwd0KkfrZJKPdyrk0eXL
	RmP4mL0llmIVNuNbWEfeClBMtO+XQYsQCCPCHlJHWWrphqwLUaNk90oNa6+bkvj9/
X-Received: by 2002:a05:622a:1793:b0:51b:fde4:cd57 with SMTP id d75a77b69052e-52ce61a1b7bmr99249781cf.31.1785969859161;
        Wed, 05 Aug 2026 15:44:19 -0700 (PDT)
X-Received: by 2002:a05:622a:1793:b0:51b:fde4:cd57 with SMTP id d75a77b69052e-52ce61a1b7bmr99249391cf.31.1785969858600;
        Wed, 05 Aug 2026 15:44:18 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:782e:b593:3821:1a47:8a5e? ([2a00:a040:199:782e:b593:3821:1a47:8a5e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b496esm887615f8f.14.2026.08.05.15.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 15:44:16 -0700 (PDT)
Message-ID: <a99f53ce-add5-47b6-bfa6-438f99d62859@columbia.edu>
Date: Thu, 6 Aug 2026 01:44:15 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: use iomap_dirty_folio for block devices
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20260802-blkdev-fixes-v1-0-a82fc549fd74@columbia.edu>
 <20260802-blkdev-fixes-v1-1-a82fc549fd74@columbia.edu>
 <20260804140102.GA8894@lst.de>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260804140102.GA8894@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aVsM3Cq18d8WVbLQp0oFXUtN2N_zyvh1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE4NSBTYWx0ZWRfX9XQs49a8h/xN
 lzIp1966x28a9TI79b18Mu7ciRg4Neh6zPgu56IWgyE1TkHu6n0Lrr+4+HO76MZ+LLZMjI5vxDD
 3qZJiXWuLAVb1W2ktff5fFHz8DzbHg70HsWjgG/q0wA7GJmGwZIz
X-Authority-Analysis: v=2.4 cv=LdEMLDfi c=1 sm=1 tr=0 ts=6a73bcc4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22 a=uherdBYGAAAA:8
 a=NEAV23lmAAAA:8 a=Q55gfk39d2I8ydEQuFIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE4NSBTYWx0ZWRfX97iV1LUly4h4
 gHjq3B85lsBS/pb2HrnxutYr9pMglKv3DsnkjqGSkqtA6nNEN9fESN1zkwcHVZlPgyBo8hKqLJj
 3Qn/Ax7n8wzTRZwuuagEGVPYRGivGLxwU6WIpzGlsPaAyrFQ0aqlSa6qMMlQNXVoyb4ucPQ6FLE
 5LtRxxUkY0aMpbZPEtsVfzZLaszUGiOJjF+oCoNLvmao0R0wascfQWIzGJ19PLFYIo1XP6JqKyd
 7rUrTWeplz22GxNC4c5yhtaKGNhPrbjh9nU3m56PiIlLDQ8nkW7LU+f2Vc3geo8qDaT8oe50a+C
 bcP0l5hCcD8TwXkmtLyIzNYJ45BlxyEkbO5GQfO8MPB96uE0v348C9cDttxkDg82LJyJ4LDmJJ+
 fKEsKJ0XQp8SmqnUS4ROdITE1j5oOlI97a8gsWCxYFoHzavAgFPxud2FqSqaJGvQrbtshPKGZNm
 P3UCeEnYsHz3jgG2VIg==
X-Proofpoint-ORIG-GUID: aVsM3Cq18d8WVbLQp0oFXUtN2N_zyvh1
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11866
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=10 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 impostorscore=10 suspectscore=0 spamscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050185

On 8/4/26 10:01 AM, Christoph Hellwig wrote: 
> On Sun, Aug 02, 2026 at 07:14:26AM -0400, Tal Zussman wrote:
>> To reproduce, on a device with a sub-page block size, write a known
>> pattern with O_DIRECT, mmap the same range, store to it, msync() and
>> fsync(), then read it back with O_DIRECT. A reproducer is available at
> 
> Heh, shared mmap writes to block devices..
> 
>> [1].
>> 
>> [1] https://urldefense.com/v3/__https://gist.github.com/ 
> tzussman/18ab05cba4b3fdc79cce0a69d1fd05b4__;!!BDUfV1Et5lrpZQ! 
> U2LXFwSk7d0ux5nR34lhpiqhUc75GwdbKoKfJ3Q99AlXZf6q-4Zu4abOqvcnW4gx6nBiH5895_e5MpFV$ <https://urldefense.com/v3/__https://gist.github.com/tzussman/18ab05cba4b3fdc79cce0a69d1fd05b4__;!!BDUfV1Et5lrpZQ!U2LXFwSk7d0ux5nR34lhpiqhUc75GwdbKoKfJ3Q99AlXZf6q-4Zu4abOqvcnW4gx6nBiH5895_e5MpFV$>
> 
> Can you submit this to blktests?

Done: https://github.com/linux-blktests/blktests/pull/258

> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks!
