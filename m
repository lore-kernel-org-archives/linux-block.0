Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AA826CE3B;
	Tue, 25 Nov 2025 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070155; cv=none; b=JNaAu2Hs5nO0fPegFO0KMb9ER0TX487NQ8uNfGEwQQedKZi+rZgeapG0GZCUUSPXGnIvCB+g5nonmgv5/tujOmU0YMgdB51rn8wRq10Ai74p8f69AFZrWZ9G7/2xkx9ZCP3YAPZMs1+5xkuwzNg0TBlbgSpKuCfu1VvVRxRKM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070155; c=relaxed/simple;
	bh=yQZYC3jGPLlM1L9HjSstT55UOumJ2q2wO9SaHOXZ1lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liEj7q4HgVse7/nFkU+fXTo3EhYBeSrX+RkyOj6WHJNZva0DqXbceI+ZYXIUJm42dxAix60U8syysbXzB0M1hScclhkLSyDNeWhoU+bJGNyV5f2SBRr0uLKOOAS0p4+YsUDpfgfp6PCV7w4oOw4WgRInjfiB2nK4srPF4+N/XbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NlpIy0kf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NlpIy0kf"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP3JXn2012704;
	Tue, 25 Nov 2025 11:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9RiuCf
	xnWHxmrrnFRYzOmRRkguqcJYx5Uw7atOBQooM=; b=NlpIy0kfVa8FJs9OFdSTGC
	rbWrSmDBF6ItPFPFguJUd93C84f0in/Td4nLI8ACAOkx9/pZXHKZ2VN0SSqWbg3A
	pj/y0dLnzThByOJmErL/VRNqOvA9nHq57skMBLpPynu0iJ1XjUGejCUOdo0vlZKQ
	n+i9mI6Uf2kCohDvcDThDL2sLCu+SkAvAJ+addc+mGUEaW/BkXWOPDVpSnuVGR2Q
	fdCyFSlurXjrTxrp63NSWl/V22/MKmc91wdnmD0ykXb0blzuduQL6HGhpwWXYh/z
	JkeAuMvSaUfa8c3xKtZaUv6qEIkozMoePvOC9fKdH0mbVYZqq/CGb6VKp+syMznA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u1vgds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:28:44 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5APBShHD006595;
	Tue, 25 Nov 2025 11:28:43 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u1vgdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:28:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5APAUGnr019031;
	Tue, 25 Nov 2025 11:28:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aksqjk69h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:28:42 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5APBSgkR30868048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 11:28:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BA8D5805E;
	Tue, 25 Nov 2025 11:28:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B39F58055;
	Tue, 25 Nov 2025 11:28:34 +0000 (GMT)
Received: from [9.109.198.169] (unknown [9.109.198.169])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Nov 2025 11:28:33 +0000 (GMT)
Message-ID: <234bab6c-6d31-4c93-8a69-5b3687ba9b85@linux.ibm.com>
Date: Tue, 25 Nov 2025 16:58:32 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
To: "hch@lst.de" <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251125112111.GA22545@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX4e4c6Gc3Pyqc
 4szu/7jCe1u3VSmqjh85J4ctk5qnV2cYZVg0rpfS+csJMswZLgbBe+Ji+VnE835dVlngzJLkVyU
 RzmNr0pHQNJrop4DP65jbSwmGKPmgnAikteKluLWkaW6MdfUqmQWGax3CuKxbw/plMIEWrTIB7o
 kLIs4rlSixxufA/M5G8myVQyH2/d8uHMxoBXs7GM31/K2w5LLc/cC1giNFxSgacE6C/lUKgwfSS
 j4Edz9dH02HBxvQEaaM7G1GE/czTI8JvtUDme8FodtTWBvaQCqxjA9aAt7jh3fV/yt+lRRbTdSd
 Yykei5w8ZsEN8iPWabNBnS8wgf0jZm6hyF9Rz8KZwX5G0stABIZP78egJCfdnwgFhvHxBE9HHz9
 YGrmJBLPmFYRYp/PX36ma/Ksrri5pg==
X-Authority-Analysis: v=2.4 cv=SuidKfO0 c=1 sm=1 tr=0 ts=692592ec cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=24NWyznfeLdFRI4gLukA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: MX1PWgwFbNuhDDXHcFI8wKk7svkcfXpM
X-Proofpoint-GUID: W3IVZCItLKqpBNzcK1raoqgBDMJnn4W2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220021



On 11/25/25 4:51 PM, hch@lst.de wrote:
> On Tue, Nov 25, 2025 at 04:43:25PM +0530, Nilay Shroff wrote:
>> The memalloc_noreclaim_save() above shall already prevent filesystem
>> reclaim,
> 
> memalloc_noreclaim_save is oddly misnamed, as it sets the
> PF_MEMALLOC, which does not cause any gfp_t flag adjustments, but
> instead avoid direct reclaim.  Thinking of it I have no idea why
> it is even used here.
> 
From git history, I see that was added to avoid memory reclaim  to avoid
possible circular locking dependency. This commit 83e1226b0ee2 ("nvme-tcp:
fix possible circular locking when deleting a controller under memory
pressure") adds it.

Thanks,
--Nilay
