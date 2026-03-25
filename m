Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81F359A65
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420691; cv=none; b=soD3oylOC1OILdrief9Ncl2mw8k8din3JHyswv+kBN+3Qc5R4gEc5wa9copj4mX9YQ0uUOrr9oxUQAL4BnqrKxAL1d6gfFChVC2ZF1Gzna45/oO3GbCIsViR3Q0tjDklokbaZX5AnXD4g3BMa5PNxN4MkMCF7+RUMSeSrtLDJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420691; c=relaxed/simple;
	bh=F99NNH142cVuV6qyl8Gi7xgfaHq1mIY2grCnraXXwHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFs6+nnffineW0DVtiPXWnROMcX6koaGEvDetcV/j4+2BaSGj6HtkR2kl4yxo2RHjWtO8njbuNktbUMC9d3mN7JuqKq1aGdU1FgMOgZJlM49ZkMQj98UcE17i6UXABMUhEEEccNMGAqrGMQcTTtN9EMslXbcwnutl1zoXFEGCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oxukk6zF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j2Yksk/v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oxukk6zF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j2Yksk/v"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P3o1Cg1208514
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HSJTals8UsXDwHkyegnf3eODvdagjyaQcP+rJw3ExcQ=; b=Oxukk6zF0M0+HX/4
	ZTl+jziBReO4QZHHZdawOiOVxxXr8D4B8pD0gn+QMK0Z9yRC7/uXhIBM1cgs5FUB
	MZdGqxsvqxcwc5jSurA3zvHfqBo7uDoFiAM2b8lRNooUfA/WoNCywD0DGCjPp2iE
	wLGu8TMmJz1Ntt2D08WG/gXCWdfrW2bsZq/zg3QA4C+lQqDNUpi2jqxNgXSwLtMD
	Llbq32Ebt9+LdL5FR2HrJI8NW1hPPPYSihjzHSwG8W5FYh9aXvFu2PIfqyyDyYfw
	Lc+iUcYaINjtGhqlUvApt19ntd4FjIm0sRn1P2ecQZUXmRDgBltT7NulHGHa3uDS
	TX1W/Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d48598ex2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:38:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c109ba1296so24147561eec.1
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 23:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774420688; x=1775025488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSJTals8UsXDwHkyegnf3eODvdagjyaQcP+rJw3ExcQ=;
        b=j2Yksk/v4Q/1j2uf5ZMz2afAzG+ljTYtaDMWg8jJ1cpB8gCiz9HmLUm/mPSOGkFrfr
         kkwTF9buGqmgwbwyUJpXi33DvY835oLGmHvr2acW7U2TCk/f1IIkpPIq3cfw0hZcXs2y
         7Krnmw7kJvR+L+pjNPypLFYZEg4Y8baUVU/Bgckr1ifWJY4eSJNI6DFuZ/xe5AqO5IHN
         QIGh9eS5EF9wsmND/w6VwcoXcJXXpOCco6rhK9PkLiw3HvWhtBlNON+XutbkFC4wvM6N
         VLGERdukv6PL/SfsnVkKPWP/a7CLfLcJGR9wMlJdzZK2WHc5SJFL2NI80udDgXW7fcaA
         dGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420688; x=1775025488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSJTals8UsXDwHkyegnf3eODvdagjyaQcP+rJw3ExcQ=;
        b=dgQc2QKR4uhd9fy7o6qvJH19vvYnkTU1H2iIVqS9Ivyqedco6IIiks2nXDp/g/g3we
         f+qFI2WlySDz6BpcihuydSlmmIJjz+ASj7rHHUJinMJvfoDFZXTKpBYEvbAGy698tatC
         es5SkqmnU3vUFOyb2Z/JfVqyMR7X8O/7dzk8/Bc+7KdYDSp5VWXwmwNzdy+LQYZNhIg8
         getDnaxKX3w8tbBcF+JBCsU/hp4DJBKmvN1ZIH9wAa084pqRPpQ4CEL3f5CxALelAaID
         E03aaomUSvUoEpx1Olk6W9EjESlIoCshCFbP4PbTA7/QrMZD7C+uQm4t2XLuT91FPxOv
         +CEw==
X-Gm-Message-State: AOJu0YyqCNOVuq2GIelHdhnkcC4UIKCwuoaxHQpvIRTroPYBpFzPJAqU
	A1J2Ot9htsQk9XSob8gcJVHWz794BVV/C/X+th57TSL+HtwtNZT6Du4TAjdMcNnNJi/LAyyeyAw
	hwizmErhvExEZTXavnrur2IwpFUGXDxPQu9AQED6diSwRmt19lgpMpgml7uC+JULpqQ==
X-Gm-Gg: ATEYQzzrqIQnVHlaCr4jKPEf9cipki0f28bzGGOnUk0NbUIHZwC8c/9qOEmYCYRvN5Q
	XPKK83xBqbWTPVjwtbiEbQcvSjUsKWVI1hccBnSsIqOXNJxGjAdwCmMRqljkRChrf/TqUTu8O2p
	B90kMKWWSP43WQ1wezjUya72Skh4IzAHp4tcbWk6v8FuhbQpygb6y7pp7e/4DzOSu92Gv8+UWvY
	z7ohHp9mLsPRlf0J5QnRmnRNRbNiKsfspHkAwt9PagzbxOYX3GCX/YfFGBg1U4K4EtNT4+WEK71
	iBAobBGVAyjdKGrLJFho6tAbqiwfxQSdN4bqNCAm5G3M8pJNkNJWhFe4nU0trK3kpk1mUWIaWE9
	rYCfB/5TYmA2paCIEbKGiPXF3cN712gJwU8vM8JDgIhkYdL9AKbsfZerxxE+OY97XXYk05J8TMN
	30eO0=
X-Received: by 2002:a05:7300:5346:b0:2c1:5b21:ddd6 with SMTP id 5a478bee46e88-2c15d382995mr1264219eec.17.1774420687776;
        Tue, 24 Mar 2026 23:38:07 -0700 (PDT)
X-Received: by 2002:a05:7300:5346:b0:2c1:5b21:ddd6 with SMTP id 5a478bee46e88-2c15d382995mr1264202eec.17.1774420687249;
        Tue, 24 Mar 2026 23:38:07 -0700 (PDT)
Received: from [10.110.19.183] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c1536aa870sm4779813eec.2.2026.03.24.23.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 23:38:06 -0700 (PDT)
Message-ID: <89565ee3-b5ab-4821-b5b2-fc20a10c7a00@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 14:38:02 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] dm-inlinecrypt: Expose inline crypto caps to the
 device
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrianvovk@gmail.com, dm-devel@lists.linux.dev,
        quic_mdalam@quicinc.com, gmazyland@gmail.com, israelr@nvidia.com,
        mpatocka@redhat.com
References: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com>
 <20260304121729.1532469-4-linlin.zhang@oss.qualcomm.com>
 <20260312063534.GC2359@sol>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260312063534.GC2359@sol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA0NSBTYWx0ZWRfX2TjFeQ1tu+S8
 m157q0qPm2u/IfODrbY3unz50rUDrDPSwaNaYnO+ZvWkNCRh6T7OGyLdzEUcklISdZ3FBC1TMdA
 rtAjIeMRnNhrtV+DOfm1OFRUnnkoUhKEQtPqHQUpK/yN4UmpzNzBNKEY9gUWycneptUluGu65Nt
 KUxbgdxrf6Azn2BOw/Ciwt6roXh646P63Mrt21xx8BkuviFGRrTAj/wjoShPKpiDzhO8uniu20n
 +pAWOJYcNRbyv99NvGTjZ+svlLkIDvfiBgdeSAby9eWx+oyaE1JseE8k2P3J5+ZblPdQY8wGZcr
 mc0CAuaTfIR6FAIqZeNE9NfEremf/I5b1sJabp7IyQkKi5AT5r1+KafTahQVPWSr+dLpfKmFpVf
 iY0tipxeG+JR07CXdDp1b6281EujipRI/qh7AtP3gBuuZwnC7iwGDUDj06pLOBCz9jA1/XhXWYV
 rW9pTEX3dvQcdQGjuNg==
X-Authority-Analysis: v=2.4 cv=VODQXtPX c=1 sm=1 tr=0 ts=69c382d0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=WmTw6OgLBKyD5lLRCsgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: l0rDkBjW8NS4sCQCk_foGRk3bDTCTHPv
X-Proofpoint-ORIG-GUID: l0rDkBjW8NS4sCQCk_foGRk3bDTCTHPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250045



On 3/12/2026 2:35 PM, Eric Biggers wrote:
> On Wed, Mar 04, 2026 at 04:17:28AM -0800, Linlin Zhang wrote:
>> Add a new DM flag, which means the inline crypto capabilities
>> from underlying devices can be exposed to the DM device, and
>> the DM device consumes these capabilities, rather pass through
>> them to the upper layer.
>>
>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
>> ---
>>  drivers/md/dm-inlinecrypt.c   | 2 +-
>>  drivers/md/dm-table.c         | 3 ++-
>>  include/linux/device-mapper.h | 7 +++++++
>>  3 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/dm-inlinecrypt.c b/drivers/md/dm-inlinecrypt.c
>> index 251760da9f7e..eda56893d430 100644
>> --- a/drivers/md/dm-inlinecrypt.c
>> +++ b/drivers/md/dm-inlinecrypt.c
>> @@ -396,7 +396,7 @@ static struct target_type inlinecrypt_target = {
>>  	 * Do not set DM_TARGET_PASSES_CRYPTO, since dm-inlinecrypt consumes the
>>  	 * crypto capability itself.
>>  	 */
>> -	.features		= DM_TARGET_ZONED_HM,
>> +	.features		= DM_TARGET_CONSUME_CRYPTO | DM_TARGET_ZONED_HM,
>>  	.module			= THIS_MODULE,
>>  	.ctr			= inlinecrypt_ctr,
>>  	.dtr			= inlinecrypt_dtr,
>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>> index 7be1d8dc8bdd..f0580935394a 100644
>> --- a/drivers/md/dm-table.c
>> +++ b/drivers/md/dm-table.c
>> @@ -1407,7 +1407,8 @@ static int dm_table_construct_crypto_profile(struct dm_table *t)
>>  	for (i = 0; i < t->num_targets; i++) {
>>  		struct dm_target *ti = dm_table_get_target(t, i);
>>  
>> -		if (!dm_target_passes_crypto(ti->type)) {
>> +		if (!dm_target_passes_crypto(ti->type)
>> +				&& !dm_target_consume_crypto(ti->type)) {
>>  			blk_crypto_intersect_capabilities(profile, NULL);
>>  			break;
>>  		}
>> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
>> index 38f625af6ab4..6abd1b4fcb76 100644
>> --- a/include/linux/device-mapper.h
>> +++ b/include/linux/device-mapper.h
>> @@ -306,6 +306,13 @@ struct target_type {
>>  #define dm_target_supports_mixed_zoned_model(type) (false)
>>  #endif
>>  
>> +/*
>> + * A target consumes inline crypto capabilities itself and doesn't support
>> + * passing through inline crypto support.
>> + */
>> +#define DM_TARGET_CONSUME_CRYPTO		0x00000300
>> +#define dm_target_consume_crypto(type) ((type)->features & DM_TARGET_CONSUME_CRYPTO)
> 
> This patch doesn't make any sense.  First, no new flag is needed, as the
> behavior is already correct if you just leave DM_TARGET_PASSES_CRYPTO
> unset, as far as I can tell.  Second, the new flag is numerically equal
> to DM_TARGET_PASSES_CRYPTO|CONFIG_BLK_DEV_ZONED.  Third, even if it had
> a unique bit as seems to have been intended, the behavior is the same as
> DM_TARGET_PASSES_CRYPTO, which should not be used on this target.

Thanks for your review!

ACK. The key can be evicted through the real block device (the backend of DM device) during
the removal of DM device when a blk-crypto-profile isn't tied to a DM device.
I'll remove this patch in the next review.

> 
> - Eric

