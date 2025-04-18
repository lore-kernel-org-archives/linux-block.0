Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F21FE461
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744973186; cv=none; b=dvMzi0vRCDByYgy8pi0u+nPgOKYlDtH7WtGa0Ex84tkPViK+8GBBLk0EQhvXrc6hoeCXZ+thg2zxAQZ+dBp8DLjZRo68wZIAdGB96MYKUKrDMkRJwasZGt1ZXbK/0/m+gRn1Bf1AOcD+32GyGe6sMpLvcVNjls3RQc8J51mKVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744973186; c=relaxed/simple;
	bh=DUN+7TTJ+pEawDuyJWkxlC+52wLv0MJj2xG52sD9UfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEWqbJr27IUtPDD+dPQcjlpxziG+lKfIdKb24+tURVvZQGYh4QvQ7aWu/Rx7CUW4Vxi4Iv2Wvznh8zFGNxB0shhAdkk5CBM/zAmb/Ya6Eu46my1w3sQUKETntG3pTI6I0g1jmoK1ZsYachrN1LVFCv8qfWE84Bco9ipma2m5dSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PFmyxDiW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PFmyxDiW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HLY7Yg013172;
	Fri, 18 Apr 2025 10:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f+lM4c
	EzPuR1OwgDyvqurF/Q8Z6R8y2GB0k/HxgdlZ4=; b=PFmyxDiWD35qppSCTbO/oj
	f14wOS4F3a50spIrDDgR7MfC6+AzaKpGLfxGR1qSYI2nOsablUICij86d39efWIP
	sUQPAmSPf2n3g5osNnoFFROo2PKUAIaNOSiXaaG93Q2utpJXjfmk3ol7s/uSg+go
	2kVhl8BJvrykDDpK2G2HoqcD5iL7W7uNz8nvfZneGX9gpyho+T8QYPptZSWK17XW
	Dp6obm0Ny4jfgli6JU25h+KOKAeu0kW499Vw3JH7+O2v/an9RVcyWHfSANM/ijUa
	E1QaExQB4MMUYvGQ+VNefvq9aZ8C7g3iBJiz/DAMxJBE4BIZIJDWx0auK8MPrHCA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46397mtq1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 10:46:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53IAJfYG001265;
	Fri, 18 Apr 2025 10:46:03 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602w0ah5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 10:46:03 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53IAk2Ge24707592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 10:46:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 344AD58050;
	Fri, 18 Apr 2025 10:46:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7960458045;
	Fri, 18 Apr 2025 10:45:58 +0000 (GMT)
Received: from [9.111.35.56] (unknown [9.111.35.56])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Apr 2025 10:45:58 +0000 (GMT)
Message-ID: <385cbcd5-fcb1-4f98-bdf7-80b16d4f5f8e@linux.ibm.com>
Date: Fri, 18 Apr 2025 16:15:55 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of the
 multipath head node
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, hare@suse.de, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250321063901.747605-1-nilay@linux.ibm.com>
 <20250321063901.747605-2-nilay@linux.ibm.com> <20250407144413.GA12216@lst.de>
 <5db5ab7b-fdf2-4b40-86fc-3ab4ccff9a41@linux.ibm.com>
 <20250409104326.GA5359@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250409104326.GA5359@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z9Lq6T5CgwolRtJ-aTGyW827M0PVonFK
X-Proofpoint-GUID: z9Lq6T5CgwolRtJ-aTGyW827M0PVonFK
X-Authority-Analysis: v=2.4 cv=b+6y4sGx c=1 sm=1 tr=0 ts=68022d6c cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=8Hd5KiJbEzgm8ycHHukA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_03,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180077



On 4/9/25 4:13 PM, Christoph Hellwig wrote:
> On Tue, Apr 08, 2025 at 07:37:48PM +0530, Nilay Shroff wrote:
>>>> +	 * For non-fabric controllers we support delayed removal of head disk
>>>> +	 * node. If we reached up to here then it means that head disk is still
>>>> +	 * alive and so we assume here that even if there's no path available
>>>> +	 * maybe due to the transient link failure, we could queue up the IO
>>>> +	 * and later when path becomes ready we re-submit queued IO.
>>>> +	 */
>>>> +	if (!(test_bit(NVME_NSHEAD_FABRICS, &head->flags)))
>>>> +		return true;
>>>
>>> Why is this conditional on fabrics or not?  The same rationale should
>>> apply as much if not more for fabrics controllers.
>>>
>> For fabrics we already have options like "reconnect_delay" and 
>> "max_reconnects". So in case of fabric link failures, we delay 
>> the removal of the head disk node based on those options.
> 
> Yes.  But having entirely different behavior for creating a multipath
> node and removing it still seems like a rather bad idea.
> 
Yes agreed, but as you know for the NVMeoF, connection is retried (for 
instrance fabric link goes down) at the respective fabric driver layer. 
However for NVMe over PCIe, our proposal is to handle the delayed removal
of the multipath head node in the NVMe stacked (multipath) driver layer. 
If we want to unify this behavior across PCIe and fabric controllers then 
we may allow setting delayed removal of head node option even to the fabric 
connection however as we know that fabric already supports such behavior 
at driver layer (by virtue of reconnection_delay and max_reconnects options), 
IMO, it may not be worthwhile to add this (delayed removal of multipath head
node) support for the fabric connection.

If the current proposed implementation seems conditional for fabrics, we may
change it such that we don't have any explicit checks for the fabrics in the
nvme_available_path function and so it could be re-written as follows:

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0f54889bd483..47a3723605f6 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -428,16 +428,6 @@ static bool nvme_available_path(struct nvme_ns_head *head)
        if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
                return NULL;
 
-       /*
-        * For non-fabric controllers we support delayed removal of head disk
-        * node. If we reached up to here then it means that head disk is still
-        * alive and so we assume here that even if there's no path available
-        * maybe due to the transient link failure, we could queue up the IO
-        * and later when path becomes ready we re-submit queued IO.
-        */
-       if (!(test_bit(NVME_NSHEAD_FABRICS, &head->flags)))
-               return true;
-
        list_for_each_entry_srcu(ns, &head->list, siblings,
                                 srcu_read_lock_held(&head->srcu)) {
                if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
@@ -451,6 +441,10 @@ static bool nvme_available_path(struct nvme_ns_head *head)
                        break;
                }
        }
+
+       if (head->delayed_shutdown_sec)
+               return true;
+
        return false;
 }
 static void nvme_ns_head_submit_bio(struct bio *bio)


Please note that head->delayed_shutdown_sec is exported to user via sysfs.
The default value of this variable is zero. So it's only when the value 
of head->delayed_shutdown_sec is set to a non-zero, we allow delayed removal 
of head node. Moreover, as discussed above, we may not want to export this 
option to user if the head node refers to the fabric connection. So this 
option shall be exclusively available to non-fabric multipath connections. 

Thanks,
--Nilay
