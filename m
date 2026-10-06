Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DDF4CCDCB
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330702; cv=none; b=G0CePgzTAwc7TaKaqUTu/YXVF8v51qlJi5mStUSg87Zu0YYKsu0EMKUmt1SrJyOZ4dWL+U8gVKiXX39WBy+nwG+68TRhnMf7OcF9nTQpGi2ZrB5orRN+yM31VqIgdKdrSOhviHmnzDKewCVgs0QiCYl8jKBNlAdmmSy1K+q/FLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330702; c=relaxed/simple;
	bh=JRCWWvoeBkR1EqOOI850qAIqGo3i2IaJrNESPB1OpRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFb9PuOPBL98Pk6TdYSmO7amYccz9a1OTynaxNGiZnIECy5DenC/xy+Y+rsbhNGb9uiF8eDwAdovi4QSCmafkNSeSRDT5JH5CC8jsYdw+9rYHJsi9nH9lP3quy2goN1fbNyBzmouzI1RavLaFqAVHfu+3ghhY6iSzlAfwb3XHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gvm3Wh4I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jIKWk2g1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gvm3Wh4I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jIKWk2g1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696Lh0CJ1429993
	for <linux-block@vger.kernel.org>; Tue, 6 Oct 2026 23:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KUOCSJmnYcO+ianQu42+sOwe7Nnzm0XvP5PxD1AQSYQ=; b=Gvm3Wh4IBfUa8CF7
	ctTQuhUcJTj5ODzVdPUrGnvBj0CRjrP2WSad9T43bUWFJbHJscamICTTXwZUNGwA
	YxoAaZTnDf3v70C7sgc65RoZFVsLEKwXbmmZEww1u/HyeBF58Roy15DkglSispP1
	sUT+mkjjB3qaTHcC3lbqw5W2RNgIXk+UG6JnDmKidEeZmjqWOgQA2NOA+nT5XoVJ
	I3D+L7/KH/V2lX1DePxbxhiKOuqZwRf46SP8VuMMJd4Uiswt6ex11xrj1pvxWrCl
	M9jlOLXRCFhEWWewlEnHpKymmgU9BHZMnqteN60GEjEK68QUm7P1vyvMUWrPEfYb
	r1r2hw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xf7u775-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 23:51:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-34bbf2e3c5cso5474177eec.0
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791330699; x=1791935499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUOCSJmnYcO+ianQu42+sOwe7Nnzm0XvP5PxD1AQSYQ=;
        b=jIKWk2g1ysV28jsV0Ttry8xg/DwdAmr11RZuQRYXDjAxBjuKM4+1L6Bay786laFPcx
         DxZbc+BzC2fu5r39fkpSPtxwT6mZrsaHNlyIob1k1J5BKcnsrhfG6e1ZUumWRzR3Tddc
         Ghq9Bgx1bTbjuK49GRGFJoeYVeqC+Fm+VT+dgmXQZE504t5HifDD9nK7vtIHDl1P6vaN
         EDomY3/eaYDEX6bVe6XNbHRymWL7sKtrD91eEihG/N4pP2NsbECfo1mUyROpNHCT4MSq
         aQjrLLKOnFZgAYLFH44jCaF+LCg0DeuiIlTOFJ4YFxVkJl7SsPwbxnycCJUdD1ZArFjT
         bMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791330699; x=1791935499;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUOCSJmnYcO+ianQu42+sOwe7Nnzm0XvP5PxD1AQSYQ=;
        b=IEJowT3te3xBIV0+lAIl2oz9VP06EkbwhL0ZGDqwKw1LLPfMev4SKICuoiPHKnjMcB
         nIClOO3kRnDRfxDnSt7lHNJYNrlEy2S4bWIXq2MINxOnZdTSXo/mVh8cTwT0IjG5SEfG
         55Bs30FuXT0P0beaKASIhhVluAbkjcNB/5Qofe939U3Akhb5w5I+3Pq+NcRT8sO8HiVC
         pfQBgNQAqxIsC9HS9p+L6ptW3cI1EcomFaMTPIdeQYucOtE16XuDCPGOdY0+ghhi2nf2
         WFOqctpXtj/yXsBPdh4b2zTeI1CoplkWzNopLRsQkg7l/zv1tp/Cm+y02IErwB/K5XER
         14Uw==
X-Forwarded-Encrypted: i=1; AKwUvBwHtAE68XjTdtoXnEfHAdzHtiQBJHg36OmKLzGz5BckM3+gvDH4+zkSFmP42TDWaOuhRiyEqdET0buB0A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLtPCcOuXtod4Anyg868cy+TC25Tcn3fUep4MeaqWR4LpMICFNq
	UJAwkENuTPlxfKrFjQkSsxajYNSFJFToztFEFkOMOHDTwVwjxaF9eEwPG2LKgaAifYH3Bk5DXmQ
	LSaoH/D36yIu4NSQ7YPa+YxhvajZaJJoMqyZqO9YEyi0RSjp14UyJJwze2xH+lFYo+A==
X-Gm-Gg: AYBFou1RDYKfSZq0a2xGEIOW+VUXeMGHNE0fl6W2TRRLsqjNXyee+x7IVBhPQ6VeZI+
	R0pPL+uhjxwaxVAgKZODsUWHDKf0Gmi+KRVA9m92CrkWHdlrnLzY5SK9dTDVdFWbeb7u+x5kKHh
	I9e4Em/0g6xeZ7op7sTNbGQUXg5fpjkSnZLFbaZ6dADRF+TAgKRjcZZJ1OFnCFDaeMX99fAjp/f
	cEYTyfmHC14x+ELK3MGfqEjM7Tn/3QP1d2YTw/3yKXa5QFlEUlI5FNHWiBsJyVI5J4SvHtjIAuN
	3fbSmq1OdM344MWITMFuJAUEtKhUAtS+3Ssk6g2V+mw8uzTM51k5Pg7IHds1cWtdM0jYC3u7xzw
	k++wUaVJVn6kez07R+IDMR/zK3x6gFhxLNpYBlj8o3Z9a/RmUwFuwLEGb3SK3QxMT
X-Received: by 2002:a05:7300:559c:b0:351:1e3f:810f with SMTP id 5a478bee46e88-3515de5f36cmr362661eec.28.1791330699157;
        Tue, 06 Oct 2026 16:51:39 -0700 (PDT)
X-Received: by 2002:a05:7300:559c:b0:351:1e3f:810f with SMTP id 5a478bee46e88-3515de5f36cmr362613eec.28.1791330698181;
        Tue, 06 Oct 2026 16:51:38 -0700 (PDT)
Received: from [10.71.184.34] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515affdc9bsm1796252eec.25.2026.10.06.16.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:51:37 -0700 (PDT)
Message-ID: <fed665c5-3062-462b-928d-ab60976ce839@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 16:51:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] soc: qcom: qpace: Add Qualcomm Page Compression
 Engine driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-3-georgi.djakov@oss.qualcomm.com>
 <20261001-hopping-belligerent-spider-876e7b@quoll>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <20261001-hopping-belligerent-spider-876e7b@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfX/fNE7nLgUJ/m
 sq1zXWGa5j0ialR6BKkuEVYL5giM0nY2KyMylOT1jSUzJPvQYC1a60WYL2wnZIBr8VYGiD19VQj
 DSfHLTlhxW9MT5YLkFAVInaHmCaAWY0=
X-Authority-Analysis: v=2.4 cv=FpSQbGrq c=1 sm=1 tr=0 ts=6ac5898c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=xgJ8PqIMSwnDUBfTh2kA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfX7h4aQnZ5lpk/
 uEkJqzzabe/Y5SVSTfWckgAUgWX+oZTm2647GPHWWZ2oukn72w6bSin6IeUqzSm2Wljx9ull+wk
 mwXWDTpB92E9AkHR+EUSpf9v69xeAqpN7D0Ydsjt0exhvZj34l8h7sK5Ql2ADHQ95CMQlhqjmyP
 7UhE4QlT8bvkHZ7NLdez3psnf5gcmiRobThjWEF1rwL2bT4bFN8saGbFnD2SVLcjEGZqfZR5R5x
 FtJYnNg4kprWDrhSWsaqrd1wFq5nj/QwKprQk0OKWmzZr/9a3+m5aE16kt6wju/9mPlM+MpnUG2
 aAOjRBcNQjwgIopzlAWipyme5INaDatK0EiKZWXqulxE6tikaOYWllvhFIUYBfF2ZPE5UlzLHgS
 9e2iYs9AiciKfmvSr6uI6WFbI/m1HlcpHHZSqRg6/9RTi0ituWg7xGi61BRdDfzG1nm96/BuBRX
 OLahUOxKSPawW641UuA==
X-Proofpoint-ORIG-GUID: BiNvhlouw8M2zwh0uvw9FM1k_w3q4iVj
X-Proofpoint-GUID: BiNvhlouw8M2zwh0uvw9FM1k_w3q4iVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060095

On 10/1/2026 1:50 AM, Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2026 at 07:52:11AM -0700, Georgi Djakov wrote:
>> Add a platform driver for the Qualcomm Page Compression Engine (QPaCE), a
>> hardware block that accelerates compression and decompression of memory
>> pages.
>>
>> Provide the urgent command path for synchronous single-page compression and
>> decompression. This exposes the low-latency operations needed by
>> compressed-memory users such as zram, especially for page decompression on
>> the read path.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
>> ---
>>   drivers/soc/qcom/Kconfig          |  14 +
>>   drivers/soc/qcom/Makefile         |   1 +
>>   drivers/soc/qcom/qpace.c          | 764 ++++++++++++++++++++++++++++++
>>   drivers/soc/qcom/qpace_internal.h |  84 ++++
>>   include/linux/soc/qcom/qpace.h    | 154 ++++++
>>   5 files changed, 1017 insertions(+)
>>   create mode 100644 drivers/soc/qcom/qpace.c
>>   create mode 100644 drivers/soc/qcom/qpace_internal.h
>>   create mode 100644 include/linux/soc/qcom/qpace.h
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 535c8619197b..6bcb86dcd726 100644
>> --- a/drivers/soc/qcom/Kconfig
> 
> Sorry, but no. Soc is not a dumping ground. This has clear function of
> compression offload, so it should have some dedicated maintainers like
> other offload engines.

The reason for putting this in soc/qcom is because this is a qcom HW 
block driver. As per your comments below we will check and see if we can 
make use of existing crypto framework and respond back on this.

>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -288,6 +288,20 @@ config QCOM_PBS
>>   	  This module provides the APIs to the client drivers that wants to send the
>>   	  PBS trigger event to the PBS RAM.
>>   
>> +config QCOM_PAGE_COMPRESSION_ENGINE
>> +	tristate "Qualcomm Page Compression Engine (QPaCE)"
>> +	depends on ARM64
> 
> Why this can't be built on other archs? This is really odd and I do not
> see any asm headers included.
ACK. We will remove this so that it can be built on other architectures.

> 
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	depends on OF
>> +	depends on INTERCONNECT
>> +	help
>> +	  Enable support for the Qualcomm Page Compression Engine (QPaCE),
>> +	  a hardware accelerator that provides high-throughput page compression,
>> +	  decompression, and DMA copy operations.
>> +
>> +	  The engine is used as a hardware backend for compressed-memory
>> +	  subsystems such as zram. If unsure, say N.
>> +
> 
> ...
> 
> 
>> +	ret = FIELD_GET(URG_CMD_0_ED_STAT_SIZE, stat_reg);
>> +out:
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(qpace_urgent_compress);
>> +
>> +int qpace_urgent_decompress(dma_addr_t input_addr,
>> +			    dma_addr_t output_addr,
>> +			    size_t input_size,
>> +			    struct qpace_algorithm *algo)
> 
> You need kerneldoc for every export.

ACK

>> +{
>> +	int urg_reg_num;
>> +	int stat_reg;
>> +	u32 stat_reg_val;
>> +	int ret;
>> +
>> +	ret = qpace_get();
>> +	if (ret)
>> +		goto out;
>> +
>> +	urg_reg_num = get_cpu() % NUM_TRS_ERS_URG_CMD_REGS;
>> +	qpace_write_urg_cmd_ctx(qpace_priv, QPACE_URG_CMD_0_CFG_CNTXT_SIZE_n_OFFSET,
>> +				urg_reg_num, algo->urg_decomp_cntxt,
>> +				FIELD_PREP(URG_CMD_0_CFG_CNTXT_SIZE_SIZE, input_size));
>> +	stat_reg = qpace_urgent_command_trigger(input_addr, output_addr, urg_reg_num,
>> +						algo->urg_decomp_cntxt);
>> +	put_cpu();
>> +
>> +	qpace_put();
>> +
>> +	if (stat_reg < 0) {
>> +		ret = stat_reg;
>> +		goto out;
>> +	}
>> +
>> +	stat_reg_val = FIELD_GET(URG_CMD_0_ED_STAT_COMP_CODE, stat_reg);
>> +	if (stat_reg_val != OP_OK) {
>> +		pr_err("%s: register %d failed with %u\n",
>> +		       __func__, urg_reg_num, stat_reg_val);
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	ret = FIELD_GET(URG_CMD_0_ED_STAT_SIZE, stat_reg);
>> +out:
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(qpace_urgent_decompress);
>> +
> 
> So singleton? For what reason exactly? Random drivers will be getting
> the reference to compress something? If so, aren't you duplicating
> existing infrastructure/API for in-kernel hardware offloaded
> compression (e.g. drivers/crypto/)?
> 

We will check and see if we can use existing crypto framework and 
respond back on this.

> You miss proper comments (see checkpatch --strict) explaining lock
> usage.

ACK

> 
> 
>> +static DEFINE_MUTEX(qpace_ref_lock);
>> +
>> +static void _get_qpace(void)
>> +{
>> +	lockdep_assert_held(&qpace_ref_lock);
>> +	if (!qpace_priv->active_rings) {
>> +		reinit_completion(&qpace_priv->no_active_refs);
>> +		pm_stay_awake(qpace_priv->dev);
>> +		cpu_latency_qos_update_request(&qpace_priv->qos_req, 300);
>> +		program_urg_command_contexts_v2();
>> +		program_decomp_core_cfg();
>> +	}
>> +	qpace_priv->active_rings++;
>> +}
>> +
>> +static void _put_qpace(void)
>> +{
>> +	lockdep_assert_held(&qpace_ref_lock);
>> +	if (!--qpace_priv->active_rings) {
>> +		cpu_latency_qos_update_request(&qpace_priv->qos_req, PM_QOS_DEFAULT_VALUE);
>> +		pm_relax(qpace_priv->dev);
>> +		complete(&qpace_priv->no_active_refs);
>> +	}
>> +}
>> +
>> +int qpace_get(void)
>> +{
>> +	int ret = 0;
>> +
>> +	mutex_lock(&qpace_ref_lock);
>> +	if (qpace_priv->suspended || READ_ONCE(qpace_priv->broken))
>> +		ret = -EBUSY;
>> +	else
>> +		_get_qpace();
>> +	mutex_unlock(&qpace_ref_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(qpace_get);
>> +
>> +void qpace_put(void)
>> +{
>> +	mutex_lock(&qpace_ref_lock);
>> +	_put_qpace();
>> +	mutex_unlock(&qpace_ref_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(qpace_put);
>> +
>> +static irqreturn_t urgent_interrupt_handler(int irq, void *unused)
>> +{
>> +	pr_debug("Urgent interrupt handled\n");
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int qpace_hw_init(void)
>> +{
>> +	u32 reg_val;
>> +
>> +	/* Select CPU SCID for our system cache slice. */
>> +	reg_val = qpace_read_gen(qpace_priv, QPACE_CORE_QNS4_CFG_OFFSET);
>> +	reg_val = u32_replace_bits(reg_val, 0x1, CORE_QNS4_CFG_CACHEINDEX);
>> +	qpace_write_gen(qpace_priv, QPACE_CORE_QNS4_CFG_OFFSET, reg_val);
>> +
>> +	/* QMB2 register configurations. */
>> +	reg_val = qpace_read_gen(qpace_priv, QPACE_CORE_GEN_CFG_OFFSET);
>> +	reg_val = u32_replace_bits(reg_val, 0x48, CORE_GEN_CFG_QMB2_MAX_RD_OUTST_LIMIT);
>> +	reg_val = u32_replace_bits(reg_val, 0x48, CORE_GEN_CFG_QMB2_MAX_WR_OUTST_LIMIT);
>> +	qpace_write_gen(qpace_priv, QPACE_CORE_GEN_CFG_OFFSET, reg_val);
>> +
>> +	/* DECOMP_CORE_CFG init steps. */
>> +	program_decomp_core_cfg();
>> +
>> +	/* Below settings help save power since all decomp cores are set to sync. */
>> +	reg_val = qpace_read_gen_core(qpace_priv, QPACE_CORE_OPER_CFG_OFFSET);
>> +	reg_val |= CORE_OPER_CFG_COMP_MEM_PWR_DWN_1;
>> +	qpace_write_gen_core(qpace_priv, QPACE_CORE_OPER_CFG_OFFSET, reg_val);
>> +
>> +	reg_val = qpace_read_comp_core(qpace_priv, QPACE_COMP_CORE_CFG_OFFSET);
>> +	reg_val = u32_replace_bits(reg_val, 0x8, COMP_CORE_CFG_DMA_RD_MAX_OT);
>> +	reg_val = u32_replace_bits(reg_val, 0x8, COMP_CORE_CFG_DMA_WR_MAX_OT);
>> +	qpace_write_comp_core(qpace_priv, QPACE_COMP_CORE_CFG_OFFSET, reg_val);
>> +
>> +	/* Set all COMP engines to bulk mode. */
>> +	reg_val = qpace_read_comp_core(qpace_priv, QPACE_COMP_CORE_BULK_MODE_OFFSET);
>> +	reg_val |= COMP_CORE_BULK_MODE_ALL_CORES;
>> +	qpace_write_comp_core(qpace_priv, QPACE_COMP_CORE_BULK_MODE_OFFSET, reg_val);
>> +
>> +	/* URG CMD register configurations. */
>> +	program_urg_command_contexts_v2();
>> +
>> +	return 0;
>> +}
>> +
>> +enum qpace_interrupts {
>> +	QPACE_IRQ_URGENT
>> +};
>> +
>> +static int qpace_register_interrupts(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	int irq, ret;
>> +
>> +	irq = platform_get_irq(pdev, QPACE_IRQ_URGENT);
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	ret = devm_request_irq(dev, irq, urgent_interrupt_handler,
>> +			       0, "qpace-urgent-irq", NULL);
>> +	if (ret)
>> +		dev_err(dev, "failed to request urgent interrupt\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static inline bool _qpace_power_on(void)
>> +{
>> +	u32 ready_status;
>> +
>> +	qpace_write_gen_core(qpace_priv, QPACE_CORE_OPER_CORE_RUN_STOP_OFFSET, QPACE_RUN);
>> +
>> +	if (readl_poll_timeout(qpace_priv->gen_core_regs +
>> +			       QPACE_CORE_OPER_CORE_READY_OFFSET,
>> +			       ready_status, ready_status,
>> +			       1000, 5 * QPACE_STATE_CHANGE_TIMEOUT_US)) {
>> +		pr_err("Timeout in waiting for QPaCE to turn on\n");
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static int qpace_power_on(struct device *dev)
>> +{
>> +	int ret, ret2;
>> +
>> +	qpace_priv->interconnect = devm_of_icc_get(dev, "qpace-mem");
>> +	if (IS_ERR_OR_NULL(qpace_priv->interconnect)) {
>> +		ret = PTR_ERR_OR_ZERO(qpace_priv->interconnect);
>> +		pr_err("%s: devm_of_icc_get() failed with %d\n", __func__, ret);
> 
> use dev_err, not pr_err

ACK.

> 
>> +		return qpace_priv->interconnect ? ret : -EINVAL;
>> +	}
>> +
>> +	ret = device_init_wakeup(dev, true);
>> +	if (ret) {
>> +		pr_err("%s: device_init_wakeup() failed with %d\n", __func__, ret);
>> +		return ret;
>> +	}
>> +
>> +	cpu_latency_qos_add_request(&qpace_priv->qos_req, PM_QOS_DEFAULT_VALUE);
>> +
>> +	icc_set_tag(qpace_priv->interconnect, QCOM_ICC_TAG_ACTIVE_ONLY);
>> +
>> +	ret = icc_set_bw(qpace_priv->interconnect, 0, 1);
>> +	if (ret) {
>> +		pr_err("Failed to turn on QPaCE VCD: %d\n", ret);
>> +		goto rm_qos;
>> +	}
>> +
>> +	if (!_qpace_power_on()) {
>> +		pr_err("Failed to start QPaCE\n");
>> +		ret = -EINVAL;
>> +		goto rm_bw;
>> +	}
>> +
>> +	return 0;
>> +
>> +rm_bw:
>> +	ret2 = icc_set_bw(qpace_priv->interconnect, 0, 0);
>> +	if (ret2)
>> +		pr_err("Failed to remove QPaCE VCD vote: %d\n", ret2);
>> +rm_qos:
>> +	cpu_latency_qos_remove_request(&qpace_priv->qos_req);
>> +	device_init_wakeup(dev, false);
>> +
>> +	return ret;
>> +}
>> +
>> +static inline bool _qpace_power_off(void)
>> +{
>> +	u32 ready_status;
>> +
>> +	qpace_write_gen_core(qpace_priv, QPACE_CORE_OPER_CORE_RUN_STOP_OFFSET, QPACE_STOP);
>> +
>> +	if (readl_poll_timeout(qpace_priv->gen_core_regs +
>> +			       QPACE_CORE_OPER_CORE_READY_OFFSET,
>> +			       ready_status, !ready_status,
>> +			       1000, 5 * QPACE_STATE_CHANGE_TIMEOUT_US)) {
>> +		pr_err("Timeout in waiting for QPaCE to turn off\n");
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static void qpace_power_off(struct device *dev)
>> +{
>> +	int ret;
>> +
>> +	/* If this fails we can still remove our vote for the VCD to turn QPaCE off */
>> +	if (!_qpace_power_off())
>> +		pr_err("Failed to stop QPaCE\n");
>> +
>> +	ret = icc_set_bw(qpace_priv->interconnect, 0, 0);
>> +	if (ret)
>> +		pr_err("Failed to turn off QPaCE VCD: %d\n", ret);
>> +
>> +	cpu_latency_qos_remove_request(&qpace_priv->qos_req);
>> +
>> +	device_init_wakeup(dev, false);
>> +}
>> +
>> +static inline int qpace_register_ioremap(struct platform_device *pdev)
>> +{
>> +	qpace_priv->gen_regs = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(qpace_priv->gen_regs))
>> +		return PTR_ERR(qpace_priv->gen_regs);
>> +
>> +	qpace_priv->gen_core_regs = qpace_priv->gen_regs + QPACE_GEN_CORE_REGS_OFFSET;
>> +	qpace_priv->comp_core_regs = qpace_priv->gen_regs + QPACE_COMP_CORE_REGS_OFFSET;
>> +	qpace_priv->decomp_core_regs = qpace_priv->gen_regs + QPACE_DECOMP_CORE_REGS_OFFSET;
>> +	qpace_priv->urg_regs = qpace_priv->gen_regs + QPACE_URG_REGS_OFFSET;
>> +
>> +	return 0;
>> +}
>> +
>> +bool qpace_is_dev_available(void)
>> +{
>> +	return static_branch_likely(&qpace_drv_probed) &&
>> +	       !READ_ONCE(qpace_priv->broken);
>> +}
>> +EXPORT_SYMBOL_GPL(qpace_is_dev_available);
>> +
>> +struct device *qpace_get_dma_dev(void)
>> +{
>> +	return qpace_priv->dev;
>> +}
>> +EXPORT_SYMBOL_GPL(qpace_get_dma_dev);
>> +
>> +static int qpace_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct qpace_priv *priv;
>> +	int ret;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->dev = dev;
>> +	/* Starts already complete since active_rings == 0 at init. */
>> +	init_completion(&priv->no_active_refs);
>> +	complete(&priv->no_active_refs);
>> +	INIT_WORK(&priv->disable_work, qpace_disable_work_fn);
>> +	qpace_priv = priv;
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
>> +
>> +	ret = qpace_register_ioremap(pdev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to map QPaCE registers\n");
>> +
>> +	ret = qpace_power_on(dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to power on QPaCE\n");
>> +
>> +	/* Get QPaCE HW version. */
>> +	qpace_priv->hw_version = qpace_read_gen(qpace_priv, QPACE_CORE_HW_VERSION_OFFSET);
>> +	if (qpace_priv->hw_version != QPACE_HW_VERSION_V2) {
>> +		dev_err(dev, "Unsupported QPaCE HW version returned: 0x%x\n",
>> +			qpace_priv->hw_version);
>> +		ret = -EINVAL;
>> +		goto power_off;
>> +	}
>> +
>> +	ret = qpace_hw_init();
>> +	if (ret) {
> 
> How is this possible?

ACK. This can be removed.

> 
>> +		dev_err(dev, "init failed: (%d)\n", ret);
>> +		goto power_off;
>> +	}
>> +
>> +	ret = qpace_register_interrupts(pdev);
>> +	if (ret) {
>> +		dev_err(dev, "failed to register interrupts\n");
> 
> Do not print same error multiple times.

ACK.

> 
>> +		goto power_off;
>> +	}
>> +
>> +	static_branch_enable(&qpace_drv_probed);
>> +
>> +	return ret;
>> +
>> +power_off:
>> +	qpace_power_off(dev);
>> +
>> +	return ret;
>> +}
> 
> Best regards,
> Krzysztof

