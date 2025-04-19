Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87F647
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745069333; cv=none; b=p3oafAEmYviIW1ea1iKsHwI1rf07YYT4qbGF0QY1NFm1H2+KgpoCgS50ep0FkAuajesHWUUkoiujgf61+LXIjwi4MwliiSjFor9XzPKXFokmidokkyrnl9Tby97CBouYdOY1M/ptHLrGyuJVfA2ZZniiCKpE4ihdnks5/loiOA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745069333; c=relaxed/simple;
	bh=KqksFZn5SMepgA2ol3wMNTCxNMCXR+CLXTv4bnLZlTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVHDNzkEUphGmiByYDn8TcIf599Kx40W2WPapIOn8cHd2dzFj7RXf425fVaSLuFSopopbE7HjYMDjLkI/lQM4dEjY+/MtC1g6nF+fv9r5+FNz5WBcXY66eJGsrWi634n3OLbAwYQNHl9DDVGVOb23h3RtzRYFbsfc9DjlTFpi3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wwj8L4Ok; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wwj8L4Ok"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J3VXZB013796;
	Sat, 19 Apr 2025 13:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Dzp4c
	yZJKHD4/MQMbd9YOYmEJZA7V89fApAhB+oZzs=; b=Wwj8L4OkCTzcAZgQFaYGN5
	YkmKl4qVuWfkUX5ot0mmkRKi1/0OItpVZzY1SixsdPF/HTnxo2k+qpie7v2bsM6V
	sLsebifuUQF496Vqf/Mr2JaIaCzxUTmu6EnITjeNH9CGp8qy9DVxIcRK4CocBB9l
	0qM7An2g30iP1SOggQe19yenlf7vVZEYi+OxF98C4Y1foWg2IJ7rx/Yn3AnsHWlM
	tukBfe9u8bvLNLAi2XMcADE6k51GUv7zfgdKBTdim+I6DkF2gGUfLybWtYJBDiTv
	j0ahZP5MNEBMSqdqPJ+OGD2jZxl19NWdJPlP9r8UtLqYWyaT4hw9SIGPbhHYOyvg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46428khjra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 13:28:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53J8A5TP030919;
	Sat, 19 Apr 2025 13:28:44 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gp7mrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 13:28:44 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JDShqQ32113186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 13:28:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A24B758058;
	Sat, 19 Apr 2025 13:28:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ADA858059;
	Sat, 19 Apr 2025 13:28:41 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 13:28:41 +0000 (GMT)
Message-ID: <1952b64e-00e6-4a5a-adf7-5f7b9ad17600@linux.ibm.com>
Date: Sat, 19 Apr 2025 18:58:40 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 14/20] block: pass elevator_queue to elv_register_queue
 & unregister_queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-15-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-15-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P6NxXFfZmYDcj9tUSyvjZfX78JqE3hML
X-Authority-Analysis: v=2.4 cv=U7eSDfru c=1 sm=1 tr=0 ts=6803a50c cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=OMLs49g1Dx6a1TUWmk4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P6NxXFfZmYDcj9tUSyvjZfX78JqE3hML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190107



On 4/18/25 10:06 PM, Ming Lei wrote:
> Pass elevator_queue reference to elv_register_queue() & elv_unregister_queue().
> 
> No functional change, and prepare for moving the two out of elevator
> lock & freezing queue, when we need to store the old & new elevator
> queue in `struct elv_change_ctx` instance, then both two can co-exist
> for short while, so we have to pass the specific elevator_queue instance
> to elv_register_queue & unregister_queue.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
