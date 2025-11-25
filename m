Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FCC31619E;
	Tue, 25 Nov 2025 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071709; cv=none; b=VfcDzdKqFxAEq6Xzb0LU+/WvMrGtO4rFHWG1P/OMmFb7ptfbsvWcT4ue0CZ7DKeWwECJHi2gTEFvdoHHCoir25LDdtjvPhHl2ABK1g3JNQXrmvWwc91ERjxunXRm/58eI3Ezkz0L6wFyzUOUEEKuyxEFemiO+jyZpBGvJstMV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071709; c=relaxed/simple;
	bh=I6TQ4S0UvxcnLt/xLkNRycww4xLPRWth3MjNv1Ty4pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRFafIB3Cjw20wrpU1U9dZe4fVx6OVC3hI4dwnaBaw7s01hMloT0bSmf1ndly8JKQhkYEZunq123g9N0a4jWqn19NdvfHXvXCQWhg3qu7hOrMKB+qAY4Ijk4eEoBKd9OtIDlIXtdAfEJHODr9FqBB4eF7wkPZ7FgdzgUi8mDzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cjbR12Vx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cjbR12Vx"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP85Lru025998;
	Tue, 25 Nov 2025 11:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2pxgtr
	DWmy7eTaSMnEPoviLmQdhhfwo9tIlruuWMXUA=; b=cjbR12Vx6Z+pU+Tuhevt65
	c9dW2YL+cblYfTERImzQc7IIBb+WLVYoRIcoPe8kaXhIjjuEAfGGrXhy0ortbIVx
	jwlznSjOeHl01Sfw3sxxxoKMEfDTfEpmdjh71acpgh8A3fD9xfvcYENL3m1PvEsH
	os6Au+azMQfR6zwCr+CHDOTZomuY+UfLnOrYYJOeb/vS3TEZymGOl2EfYLyJLvUm
	tgERr178hDz8F+O6npcmXWuQlCHVR6EakSllxMjTStHVsa7x8x15dK1UCM+jlImm
	Cu6jo0141cyCLbWVwugAsjwNLPYbWz3J1+Lyaw0t62lC0lHtSAVdnySIYhBSP73Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4phwd40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:54:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5APBbCdH010950;
	Tue, 25 Nov 2025 11:54:40 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4phwd3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:54:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5APBieds030755;
	Tue, 25 Nov 2025 11:54:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akqgsbuqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:54:39 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5APBscio24838408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 11:54:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7A7A58043;
	Tue, 25 Nov 2025 11:54:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2C7F58059;
	Tue, 25 Nov 2025 11:54:30 +0000 (GMT)
Received: from [9.109.198.169] (unknown [9.109.198.169])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Nov 2025 11:54:30 +0000 (GMT)
Message-ID: <c6e88bc3-8cc9-4503-a472-7692468ac218@linux.ibm.com>
Date: Tue, 25 Nov 2025 17:24:29 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "wagi@kernel.org"
 <wagi@kernel.org>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "xni@redhat.com"
 <xni@redhat.com>,
        "linan122@huawei.com" <linan122@huawei.com>,
        "bmarzins@redhat.com" <bmarzins@redhat.com>,
        "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "kuniyu@google.com" <kuniyu@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org"
 <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20251125061142.18094-1-ckulkarnilinux@gmail.com>
 <aSVMXYCiEGpETx-X@infradead.org>
 <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com>
 <0caa9d00-3f69-4ade-b93b-eea307fe6f72@linux.ibm.com>
 <20251125112111.GA22545@lst.de>
 <234bab6c-6d31-4c93-8a69-5b3687ba9b85@linux.ibm.com>
 <20251125113009.GA22874@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251125113009.GA22874@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX+gB8hFGESNa+
 rLSSySu64nxEfDrxZYQGlQRTgJYxxtncZQw0OF8Rlk0+ZjvrJJO4FsugSBSRvtSjZlOZLGxhvw/
 CLEQxhJSL1ura0xsKksySA0ttslXptDO0+EQbVyfOKVW6JZAwSvPv1eRhGcblGSfUiW20afdTQz
 wi/LRZw8gTtSz4pYNKvHCs3q1BcDYIZ0kFi7FPHuF3miOwrLrIDRKWfYmH4leQyQjgNJOG0AuFW
 HbBbtvXLeI4SeX6LqgKkrbZ6XjIkO/rkdBtW1WL6fD0rUUo2N17Asb+N17XToHQjEF52ne5hqka
 HkR8+X6IiIs4tCvJao7GBfkJ46lcyqfyb9gNjkNTw3bnhfmJ11x4mvxxVTpE9eqjV9hpLgyvpyK
 Ij9UiGqf4fxSrP5fMhQzsKuRQbSCUA==
X-Proofpoint-ORIG-GUID: AEQPSXV2ydGNTqwVbmTapqeQVKAF554X
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=69259901 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Dx6jXT7FOQMUIc5gBgQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AyOLiBIDLwXvYgj-rDV-m897x1pRDSHV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016



On 11/25/25 5:00 PM, Christoph Hellwig wrote:
> On Tue, Nov 25, 2025 at 04:58:32PM +0530, Nilay Shroff wrote:
>> >From git history, I see that was added to avoid memory reclaim  to avoid
>> possible circular locking dependency. This commit 83e1226b0ee2 ("nvme-tcp:
>> fix possible circular locking when deleting a controller under memory
>> pressure") adds it.
> 
> I suspect this was intended to be noio, and we should just switch to
> that.
> 
Yeah, I agree that this should be changed to noio. However, it seems that
this alone may not be sufficient to fix the lockdep splat reported here.
Since the real work of fput() might be deferred to another thread, using a noio
scope in this path may not have the intended effect and could end up being
redundant. 

That said, I noticed another fix from Chaitanya [1], where fput() is replaced
with __fput_sync(). With that change in place, combining the noio scope adjustment
with the switch to __fput_sync() should indeed address the lockdep issue. Given
that both problems have very similar lockdep signatures, it might make sense to
merge these two changes into a single fix.

[1] https://lore.kernel.org/all/20251125005950.41046-1-ckulkarnilinux@gmail.com/

Thanks,
--Nilay
