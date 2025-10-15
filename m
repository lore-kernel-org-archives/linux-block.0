Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A221D47B4;
	Wed, 15 Oct 2025 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760502894; cv=none; b=ZvQ69IgEp8iEtu+d9VJNQur8cMbT36mSW3/n7gzIawgQWu92XhSe36slYX5Ps2sR+h5MG6AJE8ldAz1/2ovQyFKOowIVhcn2+XWnjRpxonvU2uyozCPFg7O0teGsoA1QXTSSp9231sIVMSUxOFoejgoxQzQfdPRqi/y1AJz5Y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760502894; c=relaxed/simple;
	bh=wrg3USiIuwwebvBzdsnXiAh/UZmR9uVjFkUv3J6027E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0rE9BRY6cfJ4nZGwpUrY55ppKD9TlCCwTBkwMY1vZhEtI8DYtIQ6jnx2iwwCZ3nXvdU6q/bxksIxwrBA5k+HeR/WWppaigqaJHfVbK/leu2MiJ58ITB9pUmy5fwb6yLAGvhjBZv8xSxlXI0YvoWAuNy8579TrkATseTWJqoN3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TnP2hui9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TnP2hui9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2hkCe017895;
	Wed, 15 Oct 2025 04:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fK4Vxo
	Lf/oxL0zRspfxg2X6qbp0dUx1UBtIzxXAgJgA=; b=TnP2hui9gmnl1ERlhBAU0D
	RTwm+TUV35YPhWy2RoymfZuFtJ6houAOA/tVYJa5G5CzKrciHxFWllpplCqbOe20
	2Nkaz47H7MwQy4eLxn+oG/t9UmJz2HwFJQSx+xIqSRTVUy6Wl088vL0VtvgNg65A
	C/zRC8eKfTF22NGYLhuKKmVTc7oet6Y1MEJ7TrUdFe13cMZdoTyl1ZdagLfS7TXE
	MOn7jQ/jXYS9nKfJRqtNf2cirNS3JLhnO0/tYBtkKuPBuV3zWw5DmRUIRoXNr0kN
	lHCJudnJu46piwSBQUIWbeWcFJp68zc4brSP/rQrGsFGHw4vuYlHC9EtZR+3UM1g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewu2ftf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 04:34:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59F3fkCI018362;
	Wed, 15 Oct 2025 04:34:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rf84c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 04:34:30 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59F4YHMw28705300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 04:34:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F1A55805A;
	Wed, 15 Oct 2025 04:34:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65CEB58051;
	Wed, 15 Oct 2025 04:34:26 +0000 (GMT)
Received: from [9.61.83.49] (unknown [9.61.83.49])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 04:34:26 +0000 (GMT)
Message-ID: <b37320d0-2160-43b0-a05c-5de4b49631a0@linux.ibm.com>
Date: Wed, 15 Oct 2025 10:04:24 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: fix stale tag depth for shared sched tags in
 blk_mq_update_nr_requests()
To: Yu Kuai <yukuai3@huawei.com>, axboe@kernel.dk, clm@meta.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20251015014827.2997591-1-yukuai3@huawei.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251015014827.2997591-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 95URFQ5dG3_qXFur-6Qm__qk-J4kd9x1
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68ef2457 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=Yw-QP_cF-ZKMuhm6JHYA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 95URFQ5dG3_qXFur-6Qm__qk-J4kd9x1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX15kc8W9VACWS
 swUk0fYuWUuHlaBjwpXd9Aid6lYhOmmiBB174hoqdp5riWa6bkAfovHA0FEizAG+C6s4iJLd2EE
 RPhJaYEV3vCd7IUraVddy1VY12hwE1kyr8qPek8gJIdvtMWdnFqRy+Dhn8CzYD6PJYUlZaVMYYQ
 CGY3HcFBVmWeV92LpFNvr4kk6dJxur5jp3KYhlbgYiz0WmL1hpptwgasODQ7TkgiyUXOFq1ru7Q
 xA2uHbYV6UwIDHjiJnZ7lCsAUAeG1VOIkyxhsHC8NUWqZgkubR3oHVwqGexxhmSeXJaDr48+QwK
 K6VTl5EnpPRdTH92IkIW6fiE2wPIN+xz/26JpkZuCPzACi/nU9ZNqkX33ox1l9UzcCRrFpgcPVf
 3EDboGOx8yMdwrRfVkFSJYVynGIoQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014



On 10/15/25 7:18 AM, Yu Kuai wrote:
> Commit 7f2799c546db ("blk-mq: cleanup shared tags case in
> blk_mq_update_nr_requests()") moves blk_mq_tag_update_sched_shared_tags()
> before q->nr_requests is updated, however, it's still using the old
> q->nr_requests to resize tag depth.
> 
> Fix this problem by passing in expected new tag depth.
> 
> Fixes: 7f2799c546db ("blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
