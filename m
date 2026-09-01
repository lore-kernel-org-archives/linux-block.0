Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E72471CFA
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259239; cv=none; b=EpKidqiENBs1zEZy9mPKJRYHKOUYjVmxQL9gWsLx0/2kFHqBJR2qu9CNmoMGec069rp+VOHAQaR6mzVsEFHDdPAV0RX3HLdagZ65C22duLgeiI75ob9/ZIorgrD8dYB5Zn3U+HOxcMFdUBU2YD251SaOuG4C+BQlTj1AMVa0SJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259239; c=relaxed/simple;
	bh=xszAzpPB/8wB2ZU3+7zZIkbSXKAfS6N15bO/2mtZhow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiZpBWTDZvUxM4yo27rRCobVU6BCDjAzcO9/d2+azS3dvV20PgFg1O3RH0Oqr8/WQJ9HgMy5mD23O/8nlfvZYw0aUNRyLha8nfeP3qGUa0G6NGQksAgG30JwEVXAJbgWQIvJbDpxnRoUqhjSmXMNquZ/FJ0MVmL4CC4Y7hWH+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l0Bzk9lI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XdZg8kEE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l0Bzk9lI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XdZg8kEE"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJCvV3406495
	for <linux-block@vger.kernel.org>; Tue, 1 Sep 2026 10:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hxDRBSBRVK3WBdeGvq3gY+7hIJoDgMgpm6vjxtzaRS0=; b=l0Bzk9lIegBfmvRN
	rZKPQjfA6NwTdYst3Dyzpn0f+0GSvY6sIKOx+JcTBR4ed0PrQP+H5Zb1irLgtTcU
	nORQScvNIMQXWOFpa5ayfOkLBjOvp2eYM9VuZ+YdTzFVHXqaWXEYx7STFakNPh3/
	zRfhLWNqULuIuXVg55bj+sL1YbilZo07CK7KDjnNl+hvwtKfKWmeVAawWdT8yMZf
	YnLwTtilfSdCFDPZJPxez4ALEA6R6exAQHrLzkSKfsvM1uWB9Zam4fobq3TjUlF7
	W0GKZAngaXOqeIWsCUioEQPvVEwbGSobv6uXVQ4V2EIMEslocxCxJj307tDZe89H
	jrsafA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdsnu114e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 10:40:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3968dfff779so1387503a91.1
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788259235; x=1788864035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxDRBSBRVK3WBdeGvq3gY+7hIJoDgMgpm6vjxtzaRS0=;
        b=XdZg8kEE6+QFbZO1v+EmgHu7Cn3um+8JT+Q1B0mUcBWIfWxQVsXjyO0HD5JusNQttG
         k/e5j3ZOh5dKNSSkANFdjBQ0yIL5MuRJGAxfysh9PVXjTkmoUlCXhAa78mRAReqN8lWN
         IPTKODE/z8ceTiKneL9g1j+e+juNJgbz2/XUQb+XLID3e6/26MHpr1A2MI6+S23GlMw9
         Dp7HK7oV3a2nP5Imca0pQqvG5FPj2F5Y396wz9faF85o97ngvDEtivQ7YpvM4jASecf1
         aqGVUmnJDX0rdOK7FHvZ/c9BM0TdR6Mchua2MHRsMO9D5GJFOf/DkJSi+Kou6C5fTgAU
         A4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788259235; x=1788864035;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hxDRBSBRVK3WBdeGvq3gY+7hIJoDgMgpm6vjxtzaRS0=;
        b=TdsvXz08R4SMoRGis2CfY842XqQl1FDggNY4cfiVuApD9IKD/7dh7OQM1406vpHv5F
         TEsrwpfly78WCmsccCSmUyOoZSNqi9hyKKrUd0zez3HjPypW7qg4E6qSRD0haXu/4qE1
         kdJoC+wWDhnrFyp2Y8WjTFXfW08Ws5PcXqp3pGP4XrdrK1CpKB81kJIgvn6Tz2GqUZlO
         r80TIuu3rx+O50jzyJ17NJhldStcZxxx+ywkVTydAQBN6J2fEl3TDUBY4Fiz7t40PAD9
         /QZQsv9fNhLW/SVJfdzSIEFJlXt2W0q5npQswf1LG4QoYxTo4PbaTSms6FabKeMTJJ11
         Qvwg==
X-Forwarded-Encrypted: i=1; AKwUvBxKy2yHQ6u6csw2sVYQT5M5W/jE+5cjMgBuJE2rFkS49EeLSXcEbWHCVcJR7QmNojHgUEAfjo0AFzkCcg==@vger.kernel.org
X-Gm-Message-State: AFuF++mCoefslFei/+XaS98gYuEYQgZcnzASoYacyKU1bF8iTxPKtwUv
	mr+he/aGv4ApnvQs4Cr+dw0KF+rMscu/pA+n2M2FvdcNdovtrHMdrW/9DrsdulHSqORU68ByxvE
	fkRQ7uVrBtzDmx7mkJP0A4ue1FNEQT8zUhEmQMVAEbmWCV1zU0E4w3P0TJw5yRil2Yg==
X-Gm-Gg: AYBFou0b3U3JyBFtpIG0vzpqd6tfOd4lsXHzkEv8Uq15plcoXtMOFsHJ82J7pD070lq
	UoO7V2vrPD6XaVW8QC0auGcosNxJWNEW1FhzoMLHYovwSryB7+HVCOlxhNJqzOoRnG/rHohs4IZ
	oe1RVOM6POu6O4qKTm5MX4YJsD77BYK9DQl9cuJO7N5Eph4NjGLj1cEQ9lwnehafvlyFdkkILR0
	8vXM3yuxjpZs8XnhrQVzGi8/PcUWwLsZuI8yEzFYd1BiHeRjHvG4XzIjPkUNAAuSz41UGR1U6dm
	9AJuyX+rHDVWcya5Xeiho72SZQ0EcIWEPPA3nv9eohBvxS08WH1D9sAEUPyjk/E5kGzqdOsUn8r
	+Jdlj49DVZa0n46QmmbMxj75JNHA9byvcN07BNFUaArs7k0I9IW0Wl0+H
X-Received: by 2002:a17:90b:584f:b0:398:9beb:a2b7 with SMTP id 98e67ed59e1d1-3990f90df1bmr4602613a91.25.1788259235116;
        Tue, 01 Sep 2026 03:40:35 -0700 (PDT)
X-Received: by 2002:a17:90b:584f:b0:398:9beb:a2b7 with SMTP id 98e67ed59e1d1-3990f90df1bmr4602571a91.25.1788259234570;
        Tue, 01 Sep 2026 03:40:34 -0700 (PDT)
Received: from [10.110.34.210] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm30690555eec.4.2026.09.01.03.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 03:40:33 -0700 (PDT)
Message-ID: <db1488a2-deb8-461d-b77d-849da2783edb@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 18:40:26 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] dt-bindings: soc: qcom: add binding for
 qcom,crypto-virt
To: Krzysztof Kozlowski <krzk@kernel.org>, ebiggers@kernel.org,
        axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: neeraj.soni@oss.qualcomm.com, gaurav.kashyap@oss.qualcomm.com,
        mani@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        bvanassche@acm.org, alim.akhtar@samsung.com, avri.altman@sandisk.com,
        stefanha@redhat.com, pbonzini@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
 <20260827160806.1295313-5-linlin.zhang@oss.qualcomm.com>
 <bf36b0b7-d6c3-4731-b00c-c3a4c02ffc76@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <bf36b0b7-d6c3-4731-b00c-c3a4c02ffc76@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5NCBTYWx0ZWRfX1fORBIi2B7pf
 KWK2Fdfo94WDosWjgeFbyj95GNa74usgyjpGraiRkoTmBBmOCjfqJ+FxmI5NRsC2LwZa9LxGGBN
 cYbuvfOlffZbTESgh8Apxl5/PPld4Klx8w2ZMAXaTlSZZAjPw+fgbTDItVaJSPp5+VLl/X8Pd7n
 AkSJ+cB+XXCeP9GzUZLJF3T3P1f/dBoE0wk4ZjY05R6nw9gwanvj1VbAJuqVZd4StylAaXlj0tx
 uLEb9DSzPms2+gfXiSacISfPlQcfluedymFEQ7FihIRCRw4q8C1LE/DcRODPMgl42Qi9n51jdSo
 hs/ZY2sF8Zgu5rprNAJgMDpIm4qFEL51v1oGX8xvw4k3lyV8Vi/fDfo0N/pyGmNe3Ocen8kmmS/
 d2gTrSqGJXbSnnNbsRKV+KC5uC8eD82M4PMdJgXLKjL+RU2XBqvVUNtDP4X9vOebNiFDzpIx145
 7OXoaZEEU/TyS/uLp3w==
X-Authority-Analysis: v=2.4 cv=L6ItheT8 c=1 sm=1 tr=0 ts=6a96aba3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gEfo2CItAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=s59Ba9DYA-YjRSie7ucA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5NCBTYWx0ZWRfX+5kgIUladv7U
 nE0ygwhJGuYTw61pQLiwjhoJSf7US1xiTUKIcn2COafz3RAC2q5ATugnbOS9W2HGZ+8VL7GV65k
 2ek93Delsz7tteS6XGWR64yS6l81drY=
X-Proofpoint-ORIG-GUID: SCcXGMp_rclwF45rjJiGza9EyY6jLT0c
X-Proofpoint-GUID: SCcXGMp_rclwF45rjJiGza9EyY6jLT0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010094



On 8/31/2026 3:01 PM, Krzysztof Kozlowski wrote:
> On 27/08/2026 18:07, Linlin Zhang wrote:
>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>
>> Document the device tree binding for the Qualcomm GVM crypto-virt node,
>> which provides the wrapped-key buffer size needed by the QCOM_CRYPTO_VIRT
>> driver to perform hardware-wrapped-key SCM operations backing virtio_blk's
>> inline crypto layer.
>>
>> The host does not report this size over virtio, so it is supplied via DT
>> through the optional qcom,wrapped-key-size property.
>>
>> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
> 
> Your Git does not look like properly configured.

ACK

> 
>> ---
>>  .../bindings/soc/qcom/qcom,crypto-virt.yaml   | 39 +++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
>> new file mode 100644
>> index 000000000000..5eb204f29762
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
>> @@ -0,0 +1,39 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/qcom/qcom,crypto-virt.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: QCOM GVM Crypto Virt driver
> 
> We do not take bindings for drivers. Follow standard rules for bindings,
> e.g. read DTS101 slides.
> 
Thanks for your comments!

I understand the concern about introducing a DT binding for a software-only
driver. The motivation behind this binding is to provide vendor-specific
wrapped-key information to the guest, since the guest cannot discover it
directly from the ICE hardware.

I provided more details in my reply on the previous patch and in the cover
letter. If current out-of-band key operation handling is approved, I'll
revisit the design and consider whether there is a more appropriate mechanism
that does not require a DT binding, maybe move the slot mapping table to
Trust Zone, Linux kernel only need gets them via SMC request, then don't need
dt-bindings change.

> Also:
> drop second/last, redundant "binding for". The "dt-bindings" prefix is
> already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
> Just describe the hardware (not drivers)

ACK
> 
> 
> Best regards,
> Krzysztof

