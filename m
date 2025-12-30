Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976FC1946DF
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767099946; cv=none; b=BuGRH+0CP7FTNAHUS1XrJ7nXy5eCuwqCH50MOeEH15ePnta2o3mxlOTsn0i+EjQdiNEsiT3SkVHL0ZIIiujJvbGNotAPTPR/Y7BdEl7Eu7HkttiH5ivPZ7jJotPIC5WouIFceEtJZTdyqpJi4+knQPARSL4o+HYqbITDXcZV41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767099946; c=relaxed/simple;
	bh=zIjWJKRT7Mr6FbULM3V4WMePb5ra2+gSHxHYLOjsjc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UiVgQExvxEVJ6k8+nssPQ6c2sOO4kkKsVWidWy6PW6Yoj3GNnAWlfvj8bLSiQ1mIJmdcm2GHiU40YDv4gBj1lgqom0XuzCax4QfOsmKh7kSTLR0XvHC/f/YVfwiKz80KPhSV4LaPJAoJ4MZ3ZJi9H7Ud5lWJiAvDq3+azaQ9K1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C+xXXE00; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C+xXXE00"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU5bi0x022411;
	Tue, 30 Dec 2025 13:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Eb6zRl
	sDHQA0Xj1Kgm86eLd+K9HPmou3oHCDcWmmpKM=; b=C+xXXE00BuTHcGEAQkF3Es
	gcdEr2ecS37pIZGrW+BBvSyCZOSNZ2daUhOxAZr7RTHgeuHRtX9IOMIprgII6B3U
	7RgjIK167xO2UirsxAXqOmIBnI7LNXctkgFG5k5x3zjIQyi5BHzO54UUfxU2/Cdh
	RqRssGNDK5dAKMf/npkipYxScTWWSXt07Vm1YZr1i41WJQVdpK1Q14WZ5TXOTVVK
	dOt/4DG4+e9HYzHODrQuQHdwkNCCt8KOr6kzw3yFaMlfScHpFZ7KvG7MSkSUOlqF
	RVq5Hx86OZtqCsgKun+F5nh8+EuptDVd7ROnqFiTfnHk9o3psdTCBX+IsLeeM/8w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba74u3jep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 13:05:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BUAnOUc012843;
	Tue, 30 Dec 2025 13:05:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bassst5hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 13:05:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BUD5Hbf66650484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 13:05:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0692C58050;
	Tue, 30 Dec 2025 13:05:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E52D58045;
	Tue, 30 Dec 2025 13:05:14 +0000 (GMT)
Received: from [9.111.88.112] (unknown [9.111.88.112])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Dec 2025 13:05:14 +0000 (GMT)
Message-ID: <f7ad88e3-1ed7-40a7-9756-346649a8071d@linux.ibm.com>
Date: Tue, 30 Dec 2025 18:35:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/13] blk-mq-debugfs: warn about possible deadlock
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251225103248.1303397-1-yukuai@fnnas.com>
 <20251225103248.1303397-8-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251225103248.1303397-8-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -1z0UTQ_pjEMlP1hkRX0PEb-WKadnTM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDExNSBTYWx0ZWRfX0Alo/aJf/+4Y
 Fv7GCWTKNHdrZojJzlmsA7KQmdWMJCAxz5Z1UYE8vfgTf8+0E3DIVHdMzHSlkvSfqhhEu7EYSh9
 NlHauDXBSZeNEfmtIX0Zo/wqAdgflCM/Kkxk541Z50BNs7NRt6JEmHnrLQMgzNI4yTSUWqG+T5W
 SbPe5ThoPpj0ov4z9DUI8pZzIn5GmvnzkHYjHBJrXhGWFcztorXLOLfbLnGHdpX1KQNWAvlh4JK
 C8uE+rBGryKAcQNk+4u70PYvO4W+E+1TG6IQHTprQmnC8XKIXw3StTPwzh2Rc7Wy5z9sv6w8KnN
 1lVFmm27vmEmUOgHBklWPdUji1oV4/w/cIzRw5LjLnJlkPuPiXbEt8zhtRPQCJsq00jRVKt+MMP
 0zORuCjZrxTu1S7UAitvgLYpL5TAvpgA1QDr7YzxwiE1L72Z8DDI4CAk90jvulkw32fInEkIvHR
 nFlRXPzmwa8ehsi7ZOA==
X-Authority-Analysis: v=2.4 cv=AN8t5o3d c=1 sm=1 tr=0 ts=6953ce0e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hW4mWN5mCCKzNfNKQ1kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -1z0UTQ_pjEMlP1hkRX0PEb-WKadnTM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_01,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512300115



On 12/25/25 4:02 PM, Yu Kuai wrote:
> -static void debugfs_create_files(struct dentry *parent, void *data,
> +static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
> +				 void *data,
>  				 const struct blk_mq_debugfs_attr *attr)
>  {
> +	lockdep_assert_held(&q->debugfs_mutex);
> +	/*
> +	 * Creating new debugfs entries with queue freezed has the risk of
> +	 * deadlock.
> +	 */
> +	WARN_ON_ONCE(q->mq_freeze_depth != 0);
> +	/*
> +	 * debugfs_mutex should not be nested under other locks that can be
> +	 * grabbed while queue is frozen.
> +	 */
> +	lockdep_assert_not_held(&q->elevator_lock);
> +	lockdep_assert_not_held(&q->rq_qos_mutex);
> +
>  	if (IS_ERR_OR_NULL(parent))
>  		return;

I just saw that we've nr_hw_queue update code path which is
calling into the above function while registering debugfs 
entries for the hctx but it doesn't acquire ->debugfs_mutex. 
So that triggers the lockdep warning. We need to fix nr_hw_queue 
update path so that it enters into the above function after
acquiring ->debugfs_mutex. In fact, kernel test robot also
complains about the same.

Thanks,
--Nilay
