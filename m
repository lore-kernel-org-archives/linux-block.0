Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928817D6
	for <linux-block@vger.kernel.org>; Wed,  7 Oct 2026 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331478; cv=none; b=Nxayy0HWVIwZkACmAKjnijkp176QNdPHHUj39OJsdMUiuiBft3pdqQMrk0qUJ65mzw6WkdT3EKUymj4ArDh6O+LOxm7ycXL/5ahl8Onx1aXaQJhoSLr68jkIeEx0fbBqRLsKnDAkKpoQSr8szyOxo6EkxtxMR1s7UwAKRex0EMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331478; c=relaxed/simple;
	bh=VO4HprmEH26bPDpYKpkRUcTkm48LKb/lQGoubvhwlB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBJWfA3rq75tSx0M8elC8AZ19WnIdECAMFHnwCv1ewVtkvcxhOW+AUNI/41VdIqiSF+ssZAwXwpjZDUGhpldZxOQK4+3RovsSY2ultyE/jNPAjloFYT0KPaPyvmRw5qzZP/dxU/n+KUmO1FXbQmYbxAgs7vRYLzC5vdU5/GloHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tas6yyzW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c57Toj9Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tas6yyzW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c57Toj9Y"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696LekxB2011602
	for <linux-block@vger.kernel.org>; Wed, 7 Oct 2026 00:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R3JSQSkvd1It0UiMktc5j45ZpdPQLK3YDm6tjbqw98c=; b=Tas6yyzWLItqucKS
	dl8jKUO4sIMPfRmjsoIwJHH65AtlbBDNF38QAKrvnnYDFYDVUBumtF5eBNxc8jXW
	bYI5kMo5syUPyHzMdl7XUOCWMqPwhXIYl0WJzs8c38bj6jx2pmYgztfoUkpnEoca
	QddmSkahpwP06C0ciybD+Fj25oizt/IXikLsx+T/ELm37UQ1ZXoAJLSVgRJofKT3
	IbeKzchhTCEN2yNXdFgxeSzGhSO19G4mzz+TG9LCEEjMWFDUlEyoi+IBZ23FaDQ1
	pC9zhRkxANkzOhYDAPbmlpSdwyv7UDR/sJgO7yCmdQX3BlDIJ0tAb4JKBZ9kWGxk
	832VfQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9u912-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 07 Oct 2026 00:04:35 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1416f32fe11so6887483c88.0
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 17:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791331475; x=1791936275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R3JSQSkvd1It0UiMktc5j45ZpdPQLK3YDm6tjbqw98c=;
        b=c57Toj9YzAPhJltkkBuYGHSPDSwIaYGl6Ad8JAxEDeJ+u73NuWtLfdMaBD120TQtV/
         hYX5+tmuLqWlu3S5m2u7lgLO+XKwLQnCydBj3IC+ocE1GU/yPN/2Ebwd2qzQiPYJUs1F
         /aMxOWeljwG6WlTIayQ/WC5lST1jTq4RaZFbOX4xIG9D80O/gLPXf73M+jKOmsvoKwZf
         DhbYma8Jb2uw/bZNaDinvKn5NtICae44tmmDMmtJCKj+b89Dw53sjFUm+pVnDxhJ3mZy
         kMVlF485n5CHLqPzS0lTdXckyCYJQz8rUwNTeQNYGtyqiCx/YXC0VY5FKmeFL/HPPp59
         kHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791331475; x=1791936275;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R3JSQSkvd1It0UiMktc5j45ZpdPQLK3YDm6tjbqw98c=;
        b=l2PBy5a0I/0fWVOhFGRdWiMs+t4HBQb+CqEl72/DKyEFcVflNWwz5iMn2al+gdnH68
         eInwwWgp6aUefdGxfcFqDQ9sdivTTQ1TEOR/BfzD9k8Fn1KUNLpb14NFXbHycAe9fl4g
         m0wwgqcOseXitIfX5en909wzDH4dm2/RpPsFIpZgl3rZEbM9F2b46wvBlfUORLxi1Q0E
         2pfRr2mJgM/cplxMSTCDGfGi3qhTqOaYcQJHiaU+Gy0aE0a9Sa+DRH9lv+ytjA/s3UxQ
         x9yYpAe8p++QGiHGrK5KIYCDPmbDoj0pqqlVDhdhcEMDiBiic34KlekL/R6tCD3nqO7K
         aPEw==
X-Forwarded-Encrypted: i=1; AKwUvBz+E8y0irK6sgxtRjl57qqEZSzjZq8nEAPm87kWxfvMKVsLYLJPOyDtBTzPcvhyahYBKOYEiARt3dBv9A==@vger.kernel.org
X-Gm-Message-State: AFuF++nhOoTr70Ep2Ox9FoHHrRBNvfMfq6J/uBTgFfTDSwHlx8YoF3ZN
	FIaDjrtFtO8sBAY8HVVgtEhxJlIkLKzCAzOZpWTl+1x+l545SVm/G8hXK6t/9noFIQB6soT1/cb
	FlrsvDLgiJD6Wxcm8fNJ0DWlvdSWXl7pH8nAOEOeW+ZKYUyTr7qgXVuwmFIWlAGKm2w==
X-Gm-Gg: AYBFou2++/6MQbER7sW5jyZzNZsqg1VYwKCUskbx+Bv1HzCbowN2UaryVU9KXvfhV+7
	vFBLHQoLEcpN+r8u+wKj3Mo0FUh7dWd07z8B5s/iCADdRLE8XdLo9tJ9DkSmEpcXRyqboNQ5vHb
	dCV4v4jud1UrRasrSN1K8Lm0Va9ROh7zgDnLwg3Si6f4xQ50lFKfdAeRD5vfkhj4CQAfVguOJ1C
	q1WlV2sq9La0b7lF5zRlL9VkPkrUGeFGxEZkLmdi42k/RS/uDN4COLey3lxmYkXqVqzi0Le+Z+1
	vC5iULZ3BJYtBaoiTsJehEzwm4IMbS8u5MTd86dnq8u8KuG3to3CvEGWBFuVqAI+U+wgMzSvxnO
	Nc7IOPvfGIZt0QtPOuFCPhRQCqraiQtBlmgidh/OTbO6+BAbflj/wB2vLY75Bt0E=
X-Received: by 2002:a05:7022:225:b0:148:8aa2:91e2 with SMTP id a92af1059eb24-16207d7ca8bmr589564c88.38.1791331474585;
        Tue, 06 Oct 2026 17:04:34 -0700 (PDT)
X-Received: by 2002:a05:7022:225:b0:148:8aa2:91e2 with SMTP id a92af1059eb24-16207d7ca8bmr589063c88.38.1791331465559;
        Tue, 06 Oct 2026 17:04:25 -0700 (PDT)
Received: from [10.71.184.34] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16166121f2asm1995815c88.4.2026.10.06.17.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 17:04:24 -0700 (PDT)
Message-ID: <27eafbb4-22cf-4706-b551-34c0c8d30ae2@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 17:04:23 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <georgi.djakov@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, abelvesa@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, minchan@kernel.org,
        axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <20261001-dramatic-hasty-pug-68ebfd@quoll> <ar4070oH8lRCJMRw@google.com>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <ar4070oH8lRCJMRw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac58c93 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=UI1gRxWom6vz8qzGwdkA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfX+sCFqjuOV7PV
 VH+bViOzOxVqFC5sZaZXALKUGbzGbCNhf1Y60R0FLts35CR97DfqrX5pXhiGucNaSH1fpdP1B9Q
 JO7qcnZv9RMC8t71WI/abqEv5dDshUM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfX9qFfXjuTmKf8
 YpbaVb40dOv8R93a4la6I4rNeZJEqeVf+/b5agGtcbqpXc9bw4uaQO5v9ONqk2zW07m4bwloCEo
 +NFmR2OkQO+GTaGbXAWvfXHWmbepxFnCJdrItkLr+2lOXz+Rm1RtKmatyoyBXAUrT1xT06HSaZT
 Npw9515JgZYfyDIB5BxqjanBdNR5dFzZUFt7R+ktjADekfSFXHbs3wOD1I/GOpIYlS2sjUQwixz
 +PL3H+0oDv91Sk8lqX2wbiZXpcFR+8xqAhtPiMxvpZ7XZoC31ByE/g8KZttk9VgJYhnFX6v6TBz
 CNLXP1f8/2hTud1kceb64h02fb1rq/tLSJbzvP30LTvoV0boeHauShwTewZfQz5D+LsaTj/2Aia
 kyQwxDUp9WUKLXzjfLbxWtrr89+hRna8qfjtHS31Z+wH78UwPpePwNKVrbfWqs2uM23NBlOcdps
 ftodleavrvsph0GFGXw==
X-Proofpoint-ORIG-GUID: Q4wsx9CZrzn2X4T6P1K1RBB7KIis3yfs
X-Proofpoint-GUID: Q4wsx9CZrzn2X4T6P1K1RBB7KIis3yfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070000

On 10/1/2026 3:27 AM, Sergey Senozhatsky wrote:
> On (26/10/01 10:51), Krzysztof Kozlowski wrote:
>> On Wed, Sep 30, 2026 at 07:52:13AM -0700, Georgi Djakov wrote:
>>> Add a zcomp backend for the Qualcomm Page Compression Engine (QPaCE) so
>>> zram can expose qpace-lz4 as a selectable compression algorithm when the
>>> QPaCE driver is available.
>>>
>>> Compress and decompress operations are handled via the QPaCE urgent
>>> synchronous path: each request DMA-maps the source and destination
>>> buffers, issues a blocking hardware command, and returns the result size.
>>>
>>> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
>>> ---
>>>   drivers/block/zram/Kconfig         |  11 +++
>>>   drivers/block/zram/Makefile        |   1 +
>>>   drivers/block/zram/backend_qpace.c | 134 +++++++++++++++++++++++++++++
>>
>> So entire qpace should go here, no? Why did you create this entire layer
>> of indirection, singleton management under drivers/soc?
> 
> qpace seems to be standalone/independent arch/soc specific, and can gain
> users outside of zram (fs compression, zswap, etc.).  zram's backends
> potentially can disappear all together, if we switch to acomp crypto API.

ACK

Thanks,
Oreoluwa
