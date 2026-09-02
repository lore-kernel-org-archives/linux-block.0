Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70D4A5C24
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361302; cv=none; b=ghfSuBnYTeu1RV3V429djfTG7F/Tt+wQi3++xDXyGo5a8RJMsVAg3dS3EtjXsROzL+IPQr1G5ZBmozLaRhhzBupUsEjQm/gew7zZzJ2zcbni/H10DobSkLMUEenAusXbLiYOqf2wEmH/RogLuZWXvfbFfYV286BXIbqa46SCOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361302; c=relaxed/simple;
	bh=bZG08AocPFbLDEUxFFmfC5QIhC/V/PzFbcuqhbde558=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8yO3JykNo3Lj75PfKLh6OOm9h8t9g68qwsw3l5g/mKd/M52eLPVTXbiuI6QQ4e1Jkt1ZO5gi2nLNvEzIjzWlaC/UECYXxW9bVdWV1/AaQe5KN2P9tqzV8+eXp5pJgr8nDNCZhm1PPyKWygZ7eqpuvgDR6X9EQSbP2hPr09Vrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mnL98ItZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IH8gaSN6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mnL98ItZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IH8gaSN6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682DI4kc1874081
	for <linux-block@vger.kernel.org>; Wed, 2 Sep 2026 15:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1pxn+AJDlmps3CqVjI1Bkvkq9NQfvaIy9iIccLAqBlY=; b=mnL98ItZ7aKWDYr1
	JcN9+siYyUBeWKF6y12pt7ags+1xAewv/xSGAw8so9f3U229OKlYvt7Rgu0awVl4
	KrFasiQRvYbckBUItDK/Moq5I1OrOLqgxhk2LUSJ5rVzdOI+cGw+JW4/4Z36pruz
	1tg0S1DbhJ4Sy9DX92Tmg52IT3bRPw0TYZPmfeW4k2XbyxxNvkWtxVwWhlQOwlhx
	qKWGs3ZVrb+Px9rL05kZvul41VgocMSQOk1N/CviHSrxjUJj7IVmeckxjSkN6F7L
	Euy0gdmwf+AsRbcez7Jv26cnremQE+71TdA+HV5C6jEk2xGmjyR/Nn1ZlPO2QfuW
	kLLGAw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh8dac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 15:01:33 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc132709c76so1945322a12.3
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788361293; x=1788966093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1pxn+AJDlmps3CqVjI1Bkvkq9NQfvaIy9iIccLAqBlY=;
        b=IH8gaSN6wlqm3VnJ/kGc4tYTPFisFpvUq7Z4/L3rEHvHd23vIDgXbecJNu5qGrI5Jv
         wz4ZirgkFjE6R5qDOchH4CAP8MM1EvFgFJDHmTlqjTadvpnFnogOxDxfCtsl7zT8ekYY
         Un4EiOtxOxpRvAlFx3vkYjz0tPAPzJCv7StAHmJ+qRHUm/fzOsF4M2iusTSyuOz9wHBL
         f0N2UPnG+ca6uTcQ6rw7tJzi3PnSF3g6Dm3FmyHVmHZ7co+F7J+glTK6bj8YqKzhPikH
         9uy2o7+XmwIcP62aS2Uf0jbsbiILhueQbk778CG7eDLXXc9irJ5Ez2JnRagS1Fl23MAL
         7olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361293; x=1788966093;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1pxn+AJDlmps3CqVjI1Bkvkq9NQfvaIy9iIccLAqBlY=;
        b=equU7lNPwkQ2MGs9BoQe7EWnaXmipk/XfpNLmorgUeXxNdSsucpT5HRQyLcF4tz4Iu
         jDrO/42aXMQCac3fwXeiv/J4MkKZdCm3eNFTVyCFJjvyF996b72lg9/msBzvAS1bkcLt
         yi/5BiwuMA6CARrlySjasm8mAt6TKJGAKZNl6rf9gUFtAUMap7bVtd9HGLWINeDEKVgn
         7h9cPzJLfAHq++KuZDDOq1XCL11wk/d9wxb355XpC7ML5cMFFijVRsOCMZZ8jHRqmFSt
         /DZx3L7HWA9G00GCEOhz8lHA0u9Po7k57xOtr9lzdb5Qqvivxy4NoWvfxGV3iW8+RcuL
         axkg==
X-Forwarded-Encrypted: i=1; AKwUvBwkTuXmMLGE4FeU7Nrep1ThWipYunNw+6aKm6M5/RTHqDjz7GdN2sM3vE5L1UcitQMddVqRwSzrSU8vwA==@vger.kernel.org
X-Gm-Message-State: AFuF++mJpBOf/YkMNwUIw+SYGyscCfjCJ5ARjz2AR3hZ477wr6Bb11PR
	kXvB8Pwbl2731usHTuIekwJtAtPnna4pdjUFTV3ucrZoARKRdbJJX/fnMBfsCz7sSntpcZUQpt8
	6ak6xqfsZbYvVXC8gqTN8S3Uw/WRMebUqIo0d6yh1woxQNKZIqRSa+0B0KjTy4TgpRg==
X-Gm-Gg: AYBFou3EGC1uYJi+q20HWIqIQAsno7vxCxn175fdpA+KpT3CCdxDXcRL2N6WwtlNXqG
	OO/WFu0WRvTv61nwGDPMuw4sq6vBk0u+TSYQ7fEoG+cCo1pWqBxtNZNw36/PlvX7/ru1IHdq2tU
	FctmW3kQR/ha26kzQ5grHr3LObesDIj+j/0zoWqN9hxz3t1LGblhKRooFZB8RmnUtkd4ZGRR7pH
	RBWpubFFZueD5zCakg4N9pHVixgQgpSiDPmUfEEWCPyDkoAkiOncnBYVbi3swNeMREczoxRTdgL
	75c2nQJx0odUPdCYWTPx7oiMHwcfPYVMpV6GrjKz/SpZTVw2Nm2NxZaBV73OtRi8eGL5MPnSKkJ
	S4LeXfT13we1UoFCaoIVoTThxWwiADsHPia/3PIPtxJraBtWowS+PJLBuzQ==
X-Received: by 2002:a17:90a:e7c9:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39aee219f45mr7642545a91.17.1788361291808;
        Wed, 02 Sep 2026 08:01:31 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c9:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39aee219f45mr7642344a91.17.1788361290870;
        Wed, 02 Sep 2026 08:01:30 -0700 (PDT)
Received: from [10.110.114.54] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07c02203sm8484464eec.31.2026.09.02.08.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:01:30 -0700 (PDT)
Message-ID: <c5aaea57-c9c4-44ca-9bd5-7f09175637b3@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:01:22 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/11] soc: qcom: add crypto_virt backend for
 virtio-blk inline crypto
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
 <20260827160806.1295313-3-linlin.zhang@oss.qualcomm.com>
 <f5915133-ffac-4777-b7d9-cf38ba163d43@kernel.org>
 <03097984-fded-477e-82b6-f9b31fd2f1d3@oss.qualcomm.com>
 <38389106-9609-4ec4-bc83-3d1b7fac3698@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <38389106-9609-4ec4-bc83-3d1b7fac3698@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yEMk_MGi9sQSLoQqDQFMpKuQG6-RgJEH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfXx2EQJ1sskvwO
 PYT45JhRLXMbQOj3S2F6FF3k7vWFpUCRBOY581JwfNb0/aRfJSdIE+sPjvr4m669e0KmDAgN5p7
 lr63hIgJ42UOfXWaeMqDrBvqkYTYLOMCSkVR1uRQfc3kyAymUiJDPz4EBiRQPDOsoKeRF3ZsF0n
 9ec3nKpe6zj59kLUNhWHfr1CMfXAxDa/dgI/4w2irTvmJoCR6id9Qa1pxa7YOyGKZkUycCQVjji
 sQ8vMU38BH/jYDGJwA7nVNJTZDiqIdDg/DyxJfv9pqVVN+lX9kszCEsa6Dc537HLqEL5pNTsZ81
 g3L2fhaA5KU7uGz7v5ip4nAGW22rZaZiATGaHp73wxsznNE0y8VcCNckY8TfcC7Hi7YBXHvaJM/
 Da/aB2+AMlkRQK5DntKzgLW3m1y9vUBUVXP8ynOgN+/9cR4EPSC8SFvBrSMT6RKdX+Kbv2wGmho
 fthDU91k4KPXn3TRTPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfX8/1HbzgK3t97
 wZjnA5c8bCfR46pghtOidGhY5GQT/QmiwG0OMnlPFoDUIBtgPxUui/av0M5Q4GCxCi0UxGmeVNs
 xo3IvUCbQ7WsGqgLJt5cL9LqQ5163o0=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a983a4d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=-WgfA_H36cW_bsA5Db8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: yEMk_MGi9sQSLoQqDQFMpKuQG6-RgJEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020133



On 9/1/2026 9:58 PM, Krzysztof Kozlowski wrote:
> On 01/09/2026 11:39, Linlin Zhang wrote:
>>
>>
>> On 8/31/2026 2:56 PM, Krzysztof Kozlowski wrote:
>>> On 27/08/2026 18:07, Linlin Zhang wrote:
>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>
>>>> In a Qualcomm GVM environment the ICE hardware is controlled by the
>>>
>>> What is GVM?
> 
> There is no such TLA (git grep).
> 
> Maybe you meant guest in a virtual machine? Don't use some qcom-specific
> TLA.
> 

ACK
> 
>>>
>>
>> GVM means Guest Virtual Machine. This is designed for the virtualization
>> platform.
>>
>>>> host, GVM has no direct access to it. So, key operation in GVM is
>>>> done through SCM calls rather than direct register access. In this
>>>> way the access to ICE registers are offloaded to Trust Zone.
>>>>
>>>> Add QCOM_CRYPTO_VIRT, which implements struct virtblk_crypto_variant_ops
>>>> for the virtio_blk_crypto_ext dispatch layer. It maps keyslot
>>>> program/evict to qcom_scm_ice_set_key() and
>>>> qcom_scm_ice_invalidate_key(), and software-secret derivation to
>>>> qcom_scm_derive_sw_secret().
>>>>
>>>> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>> ---
>>>>  drivers/soc/qcom/Kconfig       | 12 +++++
>>>>  drivers/soc/qcom/Makefile      |  1 +
>>>>  drivers/soc/qcom/crypto_virt.c | 89 ++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 102 insertions(+)
>>>>  create mode 100644 drivers/soc/qcom/crypto_virt.c
>>>>
>>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>>> index 2b524154d9fb..6c632d114d45 100644
>>>> --- a/drivers/soc/qcom/Kconfig
>>>> +++ b/drivers/soc/qcom/Kconfig
>>>> @@ -298,6 +298,18 @@ config QCOM_INLINE_CRYPTO_ENGINE
>>>>  	tristate
>>>>  	select QCOM_SCM
>>>>  
>>>> +config QCOM_CRYPTO_VIRT
>>>> +	tristate "Qualcomm Technologies, Inc. Crypto Virt driver"
>>>> +	depends on VIRTBLK_CRYPTO_VIRTUALIZATION
>>>> +	depends on QCOM_SCM
>>>> +	default VIRTBLK_CRYPTO_VIRTUALIZATION if ARCH_QCOM
>>>> +	help
>>>> +	  GVM-side hardware-wrapped-key SCM operations exposed to
>>>> +	  virtio_blk's inline crypto layer: per-slot key programming and
>>>> +	  eviction, and key derive/generate/prepare/import.
>>>> +	  Say Y here to compile the driver as a part of kernel or M to compile
>>>> +	  as a module.
>>>> +
>>>>  config QCOM_KRYO_L2_ACCESSORS
>>>>  	bool
>>>>  	depends on ARM64
>>>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>>>> index 798643be3590..6d4b7546d1fb 100644
>>>> --- a/drivers/soc/qcom/Makefile
>>>> +++ b/drivers/soc/qcom/Makefile
>>>> @@ -39,5 +39,6 @@ obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>>>>  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>>>>  qcom_ice-objs			+= ice.o
>>>>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
>>>> +obj-$(CONFIG_QCOM_CRYPTO_VIRT)	+= crypto_virt.o
>>>>  obj-$(CONFIG_QCOM_PBS) +=	qcom-pbs.o
>>>>  obj-$(CONFIG_QCOM_UBWC_CONFIG) += ubwc_config.o
>>>> diff --git a/drivers/soc/qcom/crypto_virt.c b/drivers/soc/qcom/crypto_virt.c
>>>> new file mode 100644
>>>> index 000000000000..4ee2a36af6c1
>>>> --- /dev/null
>>>> +++ b/drivers/soc/qcom/crypto_virt.c
>>>> @@ -0,0 +1,89 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include <linux/types.h>
>>>> +#include <linux/blk-crypto.h>
>>>> +#include <linux/virtio_blk_crypto_ext.h>
>>>> +#include <linux/firmware/qcom/qcom_scm.h>
>>>> +
>>>> +static int crypto_virt_program_key(const struct blk_crypto_key *key,
>>>> +				   unsigned int slot)
>>>> +{
>>>> +	u32 dus_512_units;
>>>> +	int ret;
>>>> +
>>>> +	if (!key || !key->size) {
>>>> +		pr_err("%s: invalid key\n", __func__);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* Only AES-256-XTS has been tested so far. */
>>>> +	if (key->crypto_cfg.crypto_mode !=
>>>> +	    BLK_ENCRYPTION_MODE_AES_256_XTS) {
>>>> +		pr_err_ratelimited("Unsupported crypto mode: %d\n",
>>>> +				    key->crypto_cfg.crypto_mode);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* qcom_scm_ice_set_key()'s data_unit_size is expressed in 512-byte units */
>>>> +	dus_512_units = key->crypto_cfg.data_unit_size / 512;
>>>> +
>>>> +	ret = qcom_scm_ice_set_key(slot, key->bytes, key->size,
>>>> +		QCOM_SCM_ICE_CIPHER_AES_256_XTS, dus_512_units);
>>>> +	if (ret)
>>>> +		pr_err("%s: slot=%u ret=%d\n", __func__, slot, ret);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int crypto_virt_invalidate_key(unsigned int slot)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = qcom_scm_ice_invalidate_key(slot);
>>>> +	if (ret)
>>>> +		pr_err("%s: slot=%u ret=%d\n", __func__, slot, ret);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int crypto_virt_derive_sw_secret_key(const u8 *eph_key, size_t eph_key_size,
>>>> +					    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = qcom_scm_derive_sw_secret(eph_key, eph_key_size,
>>>> +					sw_secret, BLK_CRYPTO_SW_SECRET_SIZE);
>>>> +	if (ret == -EIO || ret == -EINVAL)
>>>> +		ret = -EBADMSG; /* probably invalid key */
>>>> +
>>>> +	if (ret)
>>>> +		pr_err("%s: ret=%d\n", __func__, ret);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static struct virtblk_crypto_variant_ops virtblk_crypto_qcom_vops = {
>>>
>>> Why is a crypto-handling code in drivers/soc/?
>>>
>>
>> This driver is a Qualcomm vendor-specific driver, plays the similar role in the
> 
> Not really, there is nothing vendor specific here. Look at this code.
> 

crypto_virt_program_key calls the interface from qcom_scm driver. Similar to
crypto_virt_invalidate_key and crypto_virt_derive_sw_secret_key.

>> guest, like the ice driver in the host. so I place it in drivers/soc/.
>>
>>>> +	.owner = THIS_MODULE,
>>>> +	.program_key = crypto_virt_program_key,
>>>> +	.evict_key = crypto_virt_invalidate_key,
>>>> +	.derive_sw_secret_key = crypto_virt_derive_sw_secret_key,
>>>> +};
>>>> +
>>>> +static int __init crypto_virt_init(void)
>>>> +{
>>>> +	virtblk_set_crypto_ops(&virtblk_crypto_qcom_vops);
>>>> +	return 0;
>>>> +}
>>>> +module_init(crypto_virt_init);
>>>> +
>>>> +#if IS_MODULE(CONFIG_QCOM_CRYPTO_VIRT)
>>>> +static void __exit crypto_virt_exit(void)
>>>> +{
>>>> +	virtblk_set_crypto_ops(NULL);
>>>> +}
>>>> +module_exit(crypto_virt_exit);
>>>> +#endif
>>>
>>> How do you instantiate this driver exactly?
>>>
>>
>> This driver is not instantiated per device. It acts as a provider of
>> Qualcomm vendor-specific inline crypto operations, which is based on
>> qcom_scm driver, and registers a global virtblk_crypto_ops instance
>> during module initialization. So that, each blk_crypto_ll_ops from
>> virtio block driver in common kernel can be sent via qcom_smc driver.
> 
> 
> If it is not instantiated, then it is dead code. Drop all this. Or read
> my message again very carefully instead of replying with whatever copy
> of commit msg. I did not ask what is this driver about. I did not ask
> what it is providing. I asked how do you instantiate it or clarifying -
> how do you load and run this code in final system.
> 

I agree this does not fit well with the usual Linux driver model, since
there is no device instance, probe path, or explicit lifetime
relationship between virtio-blk and the crypto_virt backend.

Given that, I think the current global registration approach is difficult
to justify upstream and I will revisit the design.

> This is just dead/unused code, straight from downstream.
> 
> NAK.
> 
> 
> Best regards,
> Krzysztof

