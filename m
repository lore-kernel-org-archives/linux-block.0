Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F6426693;
	Fri, 10 Jul 2026 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686979; cv=none; b=F2rfKGPcEnDUbvoO5wl2MkijDYXV8kHkg0lXrxm/Pp/R4MbFsldbxAMZLXVvE1cuHyXttrEzUs5apkOITTka3wjseLyg359nyfuLzWU5j3pCZY9Zb+r6rj2+r/ja/oUXdVgl81f5Lmi33Bido+XZPiaqg00jqZcgTJRDhtmMkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686979; c=relaxed/simple;
	bh=jBXGkZu82oOuJTvK3EZDYFIh10ErsD0+revr/XOs6d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fszQDla1s1y1sGIicFpdOmTKvASlat1Gm6iB0RHnYHXQxAXZEhCCa7qm7PTe2T/YAck5vC3zugNlY3QxFc7KuKJSIVtQWTepEaVlXX1n4qa8+TW2BezAzi52zP6VAldvr9sEbwj8gZUlh+CM6g/SoWCfl9nVemElAjYJXxkUMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bL6uDzPS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bL6uDzPS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAmpLK1391166;
	Fri, 10 Jul 2026 12:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jBXGkZ
	u82oOuJTvK3EZDYFIh10ErsD0+revr/XOs6d0=; b=bL6uDzPS/QrPsBt8S5cRiq
	84KI1x2MaBarGwOK9DNJY5ldf50D1YtGR7ZKkCXRZG4i3gvUW6PNAiFKDTSDr4MG
	QdotVLezyRw+xe6K7a5hdYwAebnCaCBIjz2gs2zgURElt9EGEeNjjK/kuojICuue
	YDVsA9zxDpV0qEtkiCdBctlkk9YKPdlEtdg+3z7xqk6+IO6+HJOfnelPQgrbRfZj
	j/9NJ8+J34GfxCBzDdyHMj71nbieRIQWs0k7baqqmnO/iZJFOnpxIJBXu+a4jHQJ
	g5jyPp+pm/bZnGYRCL5rG+aTJFKfEOjtTyA+3GlJREBaw1Vp0y1FQIWG+x7tZU3g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur6exp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:35:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ACYbkC023547;
	Fri, 10 Jul 2026 12:35:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwj6ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:35:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ACZmu818416148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 12:35:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EFEA58059;
	Fri, 10 Jul 2026 12:35:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4697058053;
	Fri, 10 Jul 2026 12:35:43 +0000 (GMT)
Received: from [9.43.74.81] (unknown [9.43.74.81])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 12:35:42 +0000 (GMT)
Message-ID: <02c1aceb-1b51-4f9a-8f6e-6050794f9843@linux.ibm.com>
Date: Fri, 10 Jul 2026 18:05:41 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/9] null_blk: use DEFINE_MUTEX for the file-scope
 mutex
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
 <20260709100452.3520482-2-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709100452.3520482-2-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfXwXTiv5Rof0fH
 DcYSZoibLIXk9L8RfjS/WXSxCMRwt6Mu3Ys6c6srBs2OPCWonnlY19B32VnsiaKRz5Wsg1xnIyB
 B9uR9Qva0l977eXx2N0LAKEyXT60zlA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX3ccoOr/sxIrZ
 g2WRWEVd7DqT6wc7AJc4MVvQFJ53kytYzJ/vur3eRtgAmpTkrojRcXe+YFfdMfGYq0vPfcDB7kl
 3l6TiyIJGdG+XqaWyKR82ZkyLt+4ZIlE2IzshY9JKD5QJssGPEvW5a/SeAJUEqXVPRprgGBjCef
 wmuadLh75v9JV13CK7eRW7clTBq0HctDJN5VMN3bD1a8/do8DKloOYfUSb9kv/RUadhsY73alI/
 XDUluBJpNmd85unoSJe03lgCEr4uesvZD0djDB7cok0zwMq7CQHaT011D/rKwpIX0ZpA1IbB8gp
 Sv5/CS4/kCOk3n+I4fv7Cr19GJ3i9nQ7AZqiWBouj9OdpdD7LIvzafCxVRpHmrf2sR5FYTGWo6+
 1/YiuhywKDQuuSQ1aCehOQZTX5y3sga24B2th8ixizR8EiLCE8iYtxMo+flQtTJTUplrcBIzOaT
 +B9plJm0DtBujxvSAyg==
X-Proofpoint-GUID: AbmxH5EBUwy8jG2O36PP5sENzOITxwPo
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a50e726 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=cEZOg4Dt-nJQDL6BfZQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AbmxH5EBUwy8jG2O36PP5sENzOITxwPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100122

On 7/9/26 3:34 PM, Zizhi Wo wrote:
> In null_init(), mutex_init(&lock) currently happens after
> configfs_register_subsystem(), which exposes the nullb subsystem to
> userspace. A racing mkdir() into/sys/kernel/config/nullb/ can reach
> null_find_dev_by_name() -> mutex_lock(&lock) before the mutex is
> initialized, trigger warning:

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
