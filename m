Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3207239089
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601452; cv=none; b=TInJ0ld/DwsHRv+3A7k+kXFgCHVLWvLu4UqR66x1kh/kkDPBMHIpnq9FlD3GUCbkyryvJS/1HRx32qTOp3GzHhX56d1auMjwUkKm1E2r2wVI1M+0sTmgVS3RndyvQuPQkw4vH6kA6JRllxRXIN5QU5PWKCz2PUwki43DRGAhxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601452; c=relaxed/simple;
	bh=RvArk7DvjQ4JcTjf9cW3WaTXnKJqfeHmF4f5sXRl/1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFRYbTEq+k1FLpRjq9iDJSn6ZCLeD/JD4NDv64uWQu6XeDvyhgdaEwmYBmQ9VZCh6W/v8HvJF36QReCf7Jwd1p8FyT1+W3KVK9/MlH57MCnGiVVIap9M0kaKTbx1KAXExWqRVYivWjiSLTUXSxPm+RTy1Ra2v2jCFh4eD8mGqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bOxG1JWz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bOxG1JWz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532CTIcL022927;
	Wed, 2 Apr 2025 13:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=USc/VN
	vOhsPCciup4mQ4SQ0Fe5z+DJn7dPB8BbCkiD0=; b=bOxG1JWzZom09hxojlu/ph
	Q0qrLxN44gWmtU/yqfn5z35pkPYTspiQ+QWBJKYRZgH6Dw5mXMdiiuyJ790KIAXn
	+W7DM4O2I92IB+bEMkxe3+KIS8P3w+G6CW5YjxE7oSIDlc+ne+VjvHvzub+D3vxB
	x9jxXt7DBzLbexO77p9bxX6JJhtKhG79LKYdkBC/zmsFeGwWEmmeHg2gNt0UOn8x
	QfMPcd9d7UQAxaXvh6VVovlFXvNhKactpz6ft8KOPor2cLBeTQny714ysQTfNyc8
	ulN+14jXwPD+EXjksknpDERYC8c5Ja2l9vgTiklSq/JcEQMhEIggRlrGaNblPRBw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45s59frcc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 13:44:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 532D0KOI014573;
	Wed, 2 Apr 2025 13:44:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pvpm83bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 13:44:01 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 532DhxfR26083884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 13:43:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46FB458059;
	Wed,  2 Apr 2025 13:44:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A9958043;
	Wed,  2 Apr 2025 13:43:58 +0000 (GMT)
Received: from [9.171.6.25] (unknown [9.171.6.25])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Apr 2025 13:43:58 +0000 (GMT)
Message-ID: <089a8cf5-bc01-468f-ab96-f04448e034ae@linux.ibm.com>
Date: Wed, 2 Apr 2025 19:13:56 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: use blk_mq_no_io() for avoiding lock
 dependency
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>,
        syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
References: <20250402043851.946498-1-ming.lei@redhat.com>
 <20250402043851.946498-4-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250402043851.946498-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PhUA9BzmKXO8fk36eE-5fXcQ9CjuQOve
X-Proofpoint-GUID: PhUA9BzmKXO8fk36eE-5fXcQ9CjuQOve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=433
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020085



On 4/2/25 10:08 AM, Ming Lei wrote:
> Use blk_mq_no_io() to prevent IO from entering queue for avoiding lock
> dependency between freeze lock and elevator lock, and we have got many
> such reports:
> 
> Reported-by: syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-block/67e6b425.050a0220.2f068f.007b.GAE@google.com/
> Reported-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
> Closes: https://lore.kernel.org/linux-block/7755.1743228130@turing-police/#t
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I tested this series on my system and this works well as we cut dependency
between ->elevator_lock and ->freeze_lock. However don't we plan to now 
model blk_mq_enter_no_io and blk_mq_exit_no_io as lock/unlock for supporting 
lockdep? Maybe we don't. 

Overall changes looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>








