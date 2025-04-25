Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098F17BA5
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586232; cv=none; b=ZFaJRuzeNen4Y7VVgXBzTxQNDkqvuFKofauNu+GeQykDxhJmVC8MUr36521CVFWoG5GNy+jmwxlQmt58LVZHwO1OfYORPqA92LfD3zyE4R/W4Tfa8l3OJipi9oh/lzCYDDSNZqCRh8xADG8YpdrM46p7rUcFENViTxc8QKBd3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586232; c=relaxed/simple;
	bh=DQIcUqIBjVSxRUmGZ+FyrjOjTiCNh0DzivQ5GKzvYDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btKBSnRDWSYzlknALtDs8AQ3D8zJ3SoSePlO90Wu9yXFJCyqZD2OpWOaYhKCqyU+gOjwzKXu5t+BMAlpMRQwjKguA3hbOnlFGdHrZDjBu8wr+jtUyaHVSV14tAzXbT/wccoH3PnwxLEWQjDbdP3GyuHUiztAiBPprOMESte3U4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TU4Pkk2w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TU4Pkk2w"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PB2Tiq004810;
	Fri, 25 Apr 2025 13:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zL3kuo
	k9Y8rpgRpKTbMI1AntoKE7a8L8C03cvwqsoJM=; b=TU4Pkk2w3TZ/9tr0sLv0b7
	rqhIXdjXIx/k5qujY/n0BZviM4q0JP/LBesLrz+CsMDSZPZJ99758v90NVv/nxDZ
	OO439a3efKfwpMrNW+QnYjQSbRsc0eyvWhMEsdKTDSNT4jkzbKC2zUq4QejVz3qZ
	fT9Sai0PoIZZUZurFGri6kF+s5/LUSbeW2uDF75cbku5n/azrgvaZF3bnPosjEsu
	l/yzQgXSILsVdy1fVFvkRqmcGV/F40OIoJ/7sP0x3kWw0na2zsdZZMJmm5mH9evF
	UztGKNA0/EV/f62CB+SMCLlrP6pu1DKDR+37VBpb+fXGuTdE2QTRtmH301UILHbQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wew39jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 13:03:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PClGrf008792;
	Fri, 25 Apr 2025 13:03:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxw9y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 13:03:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PD3f4B30409412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 13:03:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AC5158063;
	Fri, 25 Apr 2025 13:03:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC70058057;
	Fri, 25 Apr 2025 13:03:38 +0000 (GMT)
Received: from [9.43.102.9] (unknown [9.43.102.9])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 13:03:38 +0000 (GMT)
Message-ID: <a201f5f0-b33e-4de1-8773-4d905bc83578@linux.ibm.com>
Date: Fri, 25 Apr 2025 18:33:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 13/20] block: unifying elevator change
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-14-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250424152148.1066220-14-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5MSBTYWx0ZWRfX0txKncCL2pzB Ck6VinmSHp0BbJw12lwrhcypP6WrWORzCHMXRPpgFZM5CtSkP9s9OBuWNVom53vEWTBl9swMV4z tKSLNqU0x6bwmSwR7ixUjfFEcu4wfvpO4I1UQMGkKNrGZI+GP225xQ8LyOTeWPU6eUw88o/0O/k
 EzlcokNR30jNWZ4zXZBWkXUFUYY2kQMs0gSkLLQM4ORGwjGOqXyzrTTY6f8KKF/yUBUliXBD3fC Cx/K/2hZqDF661m3avJ4VxpzOxOTP6M+64SFMonKdy9MF9A0DRgLgUMqs0BG+j6o71qxfmb0sTd t/xVn0pBYD3K1qv20EPZScLgF6jY8LugkS9QlcdDtoMDizcGyU19ZfGyhO1ttDrb11uinIYu3zY
 m6/t9PQ1Zm+e/Ddb0B5a2BFJxPfcnn4i8AFOkmHXpC7NqAxmFj5Bjp9b6kXCUkL1fFHCgAq/
X-Proofpoint-ORIG-GUID: enjNWlzmROfkKSNBbEP3Cn3d0tQncJOH
X-Authority-Analysis: v=2.4 cv=JLU7s9Kb c=1 sm=1 tr=0 ts=680b882e cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QhKuIGE6kc1buLoYNf8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: enjNWlzmROfkKSNBbEP3Cn3d0tQncJOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=899 suspectscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250091



On 4/24/25 8:51 PM, Ming Lei wrote:
> @@ -564,12 +558,7 @@ static int __add_disk_fwnode(struct device *parent, struct gendisk *disk,
>  out_free_ext_minor:
>  	if (disk->major == BLOCK_EXT_MAJOR)
>  		blk_free_ext_minor(disk->first_minor);
> -out_exit_elevator:
> -	if (disk->queue->elevator) {
> -		mutex_lock(&disk->queue->elevator_lock);
> -		elevator_exit(disk->queue);
> -		mutex_unlock(&disk->queue->elevator_lock);
> -	}

After restructuring __add_disk_fwnode() we may still need elevator_exit()
in case when blk_register_queue is successful and so we should have set
q->elevator to default. Now if after queue is registered successfully, 
for instance, bdi_register fails then in that case we still have to exit 
elevator to free its resources, isn't it? 

Thanks,
--Nilay 

