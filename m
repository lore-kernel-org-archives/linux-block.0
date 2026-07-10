Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C8408626;
	Fri, 10 Jul 2026 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687331; cv=none; b=HHLFCRgduGqJY1QG/ZKUyfHW0G84KP2ndI10Epwjzhk05mqnliiGnWM11lD4GIFhJtK4rp5iymvm2XTre9KqRGsvQr9gpIYBQWNai9bB7+oW3fz3cw8j2aPGE0LHM+W2ylZ54n46R3SaGfxEkiHWWQVwKQjhtRrL8KI9/mT1nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687331; c=relaxed/simple;
	bh=WH6Y9xPsyvv+RP11WXSgFw2JW8Cv787vT8A/69LnM30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrF6bR5myA1HZvdwqcwFhjQLo3njTbNlSWPcJlr7rD7w81Xh/NNpE1CvGuVja16We/FpIiWr4dhpsEgoH4krHbffOTGqKoxkN2YzR7Zm9h+yrfb3LSY1y1dxCitrBCcOFouItAFQD7Qh/Hy9TjpSEB5wd/iLu1DPml0x0LcfzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZwYcOqEH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZwYcOqEH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAn26K248096;
	Fri, 10 Jul 2026 12:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nhvU4x
	H9eWTWYkCxH15qGRTVYElYPMWjUB/PEkRqdHA=; b=ZwYcOqEHRFloj3QvYLJxcy
	50OsLDUexm6yNq1berZmD8XuyA272EU9PZn6TWZ5mcpaqtxnTzLz5kqPP3/i2e3G
	Pbz4p0IIRQEKfWrVj0gr8WHmuZwFzgslgrut3Jvyn692ie+LLpmIEH7wblDg4KPK
	RBbAdUnbLlrbenBuytSBxVzu8ikZoIX+ptCglvHkpPYuU9EzZcXrSRdhFdP/DmWJ
	/gQ+EKTlN4zMm3lz3Hshpsu1Jkj9cjA/HuVwxepzSBrrVh8FSWXxgKPmArkLDfO0
	ChPnuhLgbVRcCNw3F9RIjqs6Yz/VVMHWfPpCEw0AlG17lH+rAISzJH6+2QDJNukg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke6x32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:36:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ACYdO1015658;
	Fri, 10 Jul 2026 12:36:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hsvtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:36:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ACag7b62390754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 12:36:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4972158053;
	Fri, 10 Jul 2026 12:36:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5842058043;
	Fri, 10 Jul 2026 12:36:37 +0000 (GMT)
Received: from [9.43.74.81] (unknown [9.43.74.81])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 12:36:36 +0000 (GMT)
Message-ID: <795a6359-54f8-48f1-b985-1c16c9115caa@linux.ibm.com>
Date: Fri, 10 Jul 2026 18:06:35 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/9] null_blk: move unregister_blkdev() after
 destroying dev in null_exit()
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
        kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org,
        bvanassche@acm.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
 <20260709100452.3520482-4-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260709100452.3520482-4-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a50e75b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=fS6D7KRB-VWXMpwcrywA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX1mKLBdWhuUoh
 P6PzLYDjCG2n+772kC1DWfdPapRmi9NOZJbLDjE/qLhPJhKdxsMaRC+XnofncU6qRN502fe8yn9
 emArtH/i30g+F/QL/tdREixtmnUKsXaq5xeFsMzBMT5WqnA30k3qGV9ZtJqx0oYD8LM5a0Qpk2x
 hN/frnjwiZXAHF4RRj1TVsTldzpceG0ZdDJSjYouBiUWhEyGwz2dUjGkTkb41+Xx1D/vHVpdWSX
 uw4GaXsumQ/V4hURKunPFTcf+GhNZH5Cn3iITTItUdkqQcJm0yYIjvXxEMNKVYKfQFEntVzcouM
 M0jQe/Srkv6YMyKkBYE7UlXKgfgYCMLvxAUIhGapOCdIZUGP/6RkuGkSqOkPlV0PGlf/IHK4dp9
 MekL+MR7HBDMbfOiUEnNJEfePkfBQobnEzezqjMtP+wK7SM36awRlJQCZ8syYTkFbSTenlVr4L6
 Onx/mt6U1puGNfNWGig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX6NgM6w4yUJOT
 Y1ZlG2gqgM2gQnYBdfmUUzPRZ2mNRvtOo5M+O71VjC85XVSBKwJMs+lM2vTV+lIrUjc/f8/in2m
 U+xT9BNoQKf4Q5zX3Dt4eGqxF8rsd9I=
X-Proofpoint-GUID: p6KZeo6U9z9zQcJCfx3LVqasvxl_oPGL
X-Proofpoint-ORIG-GUID: p6KZeo6U9z9zQcJCfx3LVqasvxl_oPGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100122

On 7/9/26 3:34 PM, Zizhi Wo wrote:
> In null_exit(), unregister_blkdev() is called before the null_blk instances
> are destroyed, which is inconsistent with the cleanup order in null_init().
> Move it after null_destroy_dev() so that teardown happens in the reverse
> order of initialization.
> 
> No functional change intended.

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
