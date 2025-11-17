Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850431BC8D;
	Mon, 17 Nov 2025 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370134; cv=none; b=YZ7uQml5WESyJmamta9Poq/aC/oOu5Uu3AAxQEyjnIB16C61AQ8NFrZMpPPdsnPJnjkCBwZ+ImInWpHWiSGe+99bFvpTUQrFRzEmMQk3RN7xv++9RJo7tCgkBmXSmnWiOIyPyyTQJ92dmtI6wTrZlMBurIDvqVZ8EC3B8bINQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370134; c=relaxed/simple;
	bh=dg7CXevlIsnuqPReLm3SerOjBmC0kT4dd1RNc42zAMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlPTVv/yXS2QEWL8ZfWGzC3OfZLbgtwOLg5Shhl4jMW4c8nLNA4lYKlifzkTT0M82q1nKmVba0fUFt6MgmvXvRsAqxZhKfsyhy6Ptt570Q1fFd3BA2bEYcWVoOwLwGfmX+NHjuFQ+Fi9WSyWl/tP3l+N9s05Ha5m7s/bVXoRcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sPGXfE9D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sPGXfE9D"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGMrSMT031300;
	Mon, 17 Nov 2025 09:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PwflT1
	I/Uph07lr+p8RbFYFfClGoEtJaI0hycQ6We+o=; b=sPGXfE9DJ77vo2dOlbZonD
	2yiFBM54o+40QddlXUxUmN8yK//INEEZ/k+mGxMOwm7Oa/jwU9YnM6ldeqhRIBMr
	1HjeV5Q83xrEomnwoAR1Etr0gJOPSRdBCH7HbTxNs8AZdNf/gUBmrBZak6J/PpQj
	3W4JCJRknOdHgF845v28dNJB4snl3DqMFRtzTqusLVSTWpV+qY1SHxHFQuZRpVIr
	7pTfoaUgtQWk/j0htba/aN+Qz6bf5s0oTYjDcWDovIuJbLaVn9YDRn7KZXrkakUj
	zTHs1f+1Pm50JmnNHlhy1w1Amoqm64LDKTNoygzJ+diCpjaQu6rg9tDrIzaOCgqw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjvwaem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 09:01:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH8nirG017317;
	Mon, 17 Nov 2025 09:01:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1cma5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 09:01:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AH91qu330540486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 09:01:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 353435805A;
	Mon, 17 Nov 2025 09:01:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBE655803F;
	Mon, 17 Nov 2025 09:01:47 +0000 (GMT)
Received: from [9.61.140.236] (unknown [9.61.140.236])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 09:01:47 +0000 (GMT)
Message-ID: <542de632-aace-4ff4-940e-55b57142b496@linux.ibm.com>
Date: Mon, 17 Nov 2025 14:31:46 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] block: Remove queue freezing from several sysfs
 store callbacks
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
        Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20251114210409.3123309-1-bvanassche@acm.org>
 <20251114210409.3123309-3-bvanassche@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251114210409.3123309-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691ae482 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=IPLMIk6eJIHjdk74lYUA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX9s8WqisTafGS
 XxK4Ht0nQJRu6bAh/Vl+PT93UGRzw7aVWYGIHYmwfMmNp2e1v4RqdZcxEbCw+yD3372iDz9M2WJ
 ZZ60TlMftDL2EudPwzOp9DxRHvPoZO4Dc5+RX8d/LD6NWxnMP+dQ1Z5QY5aPni9QnSCx2C0DAsL
 Y8YRmHEFY3mlgWD+WISpdekc5M/LASTXE/7WPsQG9N8UG7q+JdwcD5Or6ak7d8HvmjTR7q5VQtq
 f4NvLYJKTS7ycnzD/I/hpUP8M1VQfJOmi/khqGSToMzNP0wOK7wzD9Seqy50o36ZqH2n+QlqlDd
 ZblQddHQyArEUuWu3s3dqhbymLnX788bzRA8jMZswy7XUeTMtQoZTHE1qawKiUb02hfJnT+xeI9
 gYSlQM7J5HKLVf4L5VwNymqjQcP5ww==
X-Proofpoint-GUID: xxppZQWA0lbZxB0SZgZJdBBCYOANrdZM
X-Proofpoint-ORIG-GUID: xxppZQWA0lbZxB0SZgZJdBBCYOANrdZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

Hi Bart,

On 11/15/25 2:34 AM, Bart Van Assche wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2fff8a80dbd2..cb4ba09959ee 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -495,7 +495,7 @@ struct request_queue {
>  	 */
>  	unsigned long		queue_flags;
>  
> -	unsigned int		rq_timeout;
> +	unsigned int __data_racy rq_timeout;
>  
>  	unsigned int		queue_depth;

This change look good to me however as I mentioned earlier, 
introducing __data_racy would break the kernel build. So 
are you going to raise a separate bug report to fix it? 

  AS      .tmp_vmlinux2.kallsyms.o
  LD      vmlinux.unstripped
  BTFIDS  vmlinux.unstripped
WARN: multiple IDs found for 'task_struct': 116, 10183 - using 116
WARN: multiple IDs found for 'module': 190, 10190 - using 190
WARN: multiple IDs found for 'vm_area_struct': 324, 10227 - using 324
WARN: multiple IDs found for 'inode': 956, 10314 - using 956
WARN: multiple IDs found for 'path': 989, 10344 - using 989
WARN: multiple IDs found for 'file': 765, 10375 - using 765
WARN: multiple IDs found for 'cgroup': 1030, 10409 - using 1030
WARN: multiple IDs found for 'seq_file': 1358, 10593 - using 1358
WARN: multiple IDs found for 'bpf_prog': 2054, 10984 - using 2054
WARN: multiple IDs found for 'bpf_map': 2134, 11012 - using 2134
[...]
[...]
make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
make[2]: *** Deleting file 'vmlinux.unstripped'
make[1]: *** [/home/src/linux/Makefile:1242: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Thanks,
--Nilay
