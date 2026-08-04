Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75841D21F
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826439; cv=none; b=OBDdCSeBV6QUle5e8A2XeJHpJXgNzKGFYZtZ8XEwZGP8kDpSeGNlgtZ53AUjVPqCbVrW5ATQjM2b2NDCCZnDk9M3dHn5EAZOjrtVCVzcQH7JHcRSiPtCabPk4Jev8LCC2/xT0cO6jRSPG7GxaUrG3KJ4asMtgCGnuSTqppDgADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826439; c=relaxed/simple;
	bh=n9q6rCd6YQ1pvMnCwo1K95+qdtzPiaWYP2d5vJWLUcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Og6Rwjo6C0cGAfXfFPX83btRxS3UJN2x6p1P14gXqOc0UCoXAPGM8MrnorpA528/pcUF6Uxrvo7MbrpKtu4LHel3JID/eiIBstGYdF6HyQikW8/VejCSuqwDVU10Qae/PmT/3U7ukSB7jtIPkheV/4KDYc7NAHaOsWq3Dz65ofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VDGMHKNW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VDGMHKNW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741Hgn63576191;
	Tue, 4 Aug 2026 06:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mY3uTX
	0MXR0Xa1XZuKeXXmv7V34MZHAiVg3x8460xT0=; b=VDGMHKNWSdFh1MTaPDHwNE
	8IeDCJA6Ca8jqWdfVSakfOKhuPbkzPQGJCmmq+FLunojz6S0XghOfACH149ZDuHG
	eQ9ePfAZfB6koghF7p74fZD1nX2YFSdMQoTLppJ28mXTpYMsOJcKCt2p7fdT4MBg
	PyHDsTS3QopSMfze5NNJhEb/iNBMYv8VoO6mfUUaWq5hjFGuOsAOo6jM5SXTRMXo
	g0AE6WzDHb5Xsn6bUdJz8pKXp0tEFZuoJ1oZdnxEsk02Dpt5o0TpdM0lZUBHRP5e
	EaBAtJrBZeb6ZXbradbdfNoLGBtLwleDva3e2T5eTE/xzAS1cfkMGtc9CzYcaMzw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g4a36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:53:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6746fQgM016765;
	Tue, 4 Aug 2026 06:53:44 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k0tqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:53:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6746riof46268826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 06:53:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CD4A5805A;
	Tue,  4 Aug 2026 06:53:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E93A858056;
	Tue,  4 Aug 2026 06:53:40 +0000 (GMT)
Received: from [9.43.105.125] (unknown [9.43.105.125])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 06:53:40 +0000 (GMT)
Message-ID: <96b0b123-8062-40c6-a2f3-9b6baa7d2612@linux.ibm.com>
Date: Tue, 4 Aug 2026 12:23:39 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] loop: Remove the "bool global" function argument
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
        Haris Iqbal <haris.iqbal@linux.dev>
References: <cover.1785440858.git.bvanassche@acm.org>
 <d5142cf35b04e88939c4aed2debf6f3716d540ae.1785440858.git.bvanassche@acm.org>
 <f3d93315-c7cc-4200-b6c7-5b75ad02290d@linux.ibm.com>
 <437c4abb-0f63-43f9-a283-2687c374d3e2@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <437c4abb-0f63-43f9-a283-2687c374d3e2@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfX98Psfqwte90c
 QRpvyO4YcpHW+KX2XdJu8jeUnGdK4DYWE8sEmzbwAsAoZnhMg09eZ3fLwxi1YKnTkJp0w3G2PRe
 bgkhSCTiwTH2Dkntq8UHeDW9hYD4Pbzc0otr33CflRz2F53AwYIda152Bm0fJnk3xVse84Dkpt+
 fEfiE/pmGJLWKPIkU5upbxVfXqvPy95w7OY1mmM95PZ0rSqpiYqssP8JrLktSyx+EUrn0AotL5A
 J9KK3JTB5nsWSIIr1kiNlHRRdQmlJqTU6rOVm5P59o8eWEsG7XeXz82MdafQxa0Iz3S1T1qIR+q
 pZaMs6HCxfmdXm+ywWkrYSgdl9lquDn9I1wzcdNmWlCfk0BTF7BFhFUMYudjN1ChM+afnQRzboh
 tMeZXLuovYl1SjHKusJ8GHAIIZ2cKiKU4u3pfUlzN1zfnNdNz4W/n3h5JW9qDIoVBBPm2Al/xQs
 cyVHJc4+rymoqTGPQSQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a718c79 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=aJ2jEGXGeZ_ZiVYQvR0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YkmLyKbHSJnUrPcoV6FOoBkDJVA4SmbA
X-Proofpoint-ORIG-GUID: oeOAsQd2fbgEEIzVHTi7_k6pT1crtn9i
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfXwCApYWulpJIY
 HlWpbDQdGps1Xzssw0u7vZyPKROxWov1p2uyZROePQhwhlYuKrXP36he+yJnv8oE4qF1jE/Zgu7
 mGUgvIIpVc70L0kHng4kkPtdcgAJjmo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040052

On 8/3/26 11:11 PM, Bart Van Assche wrote:
> On 8/3/26 6:05 AM, Nilay Shroff wrote:
>> Overall this change looks good to me. But I see, lo->lo_lock
>> is used to protect lo->lo_backing_file. so shall we annotate
>> the lo->lo_backing_file using __guarded_by(&lo_lock)?
> 
> I don't think so. It seems to me that the strategy in the loop driver
> for serializing accesses to lo->lo_backing_file is too complicated for
> lock context annotations. My understanding is as follows:
> * lo->lo_mutex serializes configuration and state changes on an
>    individual loop device.
> * loop_validate_mutex serializes concurrent loop_configure(),
>    loop_change_fd(), and loop_clr_fd() calls across all loop devices to
>    safely execute loop_validate_file() when loop devices are stacked
>    or nested.
> * The blk_mq_freeze_queue() call in __loop_change_fd() serializes I/O
>    request processing and the code in __loop_change_fd() that is executed
>    while the queue is frozen.
> 

Yes, you're right about the locking being more complicated here. However,
I think there may be another issue: a race between the sysfs read in
loop_attr_backing_file_show() and replacement of the backing file in
__loop_change_fd().

__loop_change_fd() replaces lo->lo_backing_file through loop_assign_backing_file(),
but loop_assign_backing_file() does not take lo->lo_lock. Hence, the sysfs path
could read the old lo_backing_file pointer while __loop_change_fd() replaces it
and subsequently drops the old file reference with fput().

Since loop_attr_backing_file_show() does not take its own reference to the file,
this looks like it could result in a use-after-free.

Initially, I thought we could fix this by consistently protecting publication/removal
of lo->lo_backing_file with lo->lo_lock and taking a temporary file reference from
the sysfs path, e.g.:

static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
{
	struct file *file;
	...

	spin_lock_irq(&lo->lo_lock);
	file = lo->lo_backing_file;
	if (file)
		get_file(file);
	spin_unlock_irq(&lo->lo_lock);

	if (!file)
		return -ENOENT;

	...
	fput(file);
}
```

and similarly protect the assignment in loop_assign_backing_file().

static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
{
         spin_lock_irq(&lo->lo_lock);
         lo->lo_backing_file = file;
         spin_unlock_irq(&lo->lo_lock);
         ...
}

However, looking further through the code, I wonder whether we can instead get rid of
lo->lo_lock entirely and use lo->lo_mutex to serialize the sysfs access to lo->lo_backing_file.

__loop_change_fd() is already called with lo->lo_mutex held, so the update path would not
need any additional locking. We would only need to acquire lo->lo_mutex in
loop_attr_backing_file_show() while accessing lo->lo_backing_file.

Similarly, for the clear path in __loop_clr_fd(), it looks like the existing device teardown
serialization may already be sufficient, in which case the lo->lo_lock protection around
clearing lo->lo_backing_file could potentially be removed as well.

If that's correct, we could simplify the locking and remove lo->lo_lock altogether rather than
adding more users of it.

Thanks,
--Nilay

