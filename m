Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D1A78F59;
	Tue,  8 Jul 2025 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973228; cv=none; b=KdBzsfhIeccqlMWWsT0Hm8iHw2GusLlroIeA+TzxiQod5JZUYPDB430RzcyBNjpNutBq3Q78DdtPG1IZza/yEbm85jQyokyFkdG59RJ5LLQujnd0cKrUJ79VvehxxUJW6bJbi2GwUBZcF337ofTFm4WS4WHDAQY8RYgv2PmUGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973228; c=relaxed/simple;
	bh=akZ/oFKHtBt9lSINCk/rLJ4nIUwf967LCMGx2qPaHNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8Mb5/pFpHFbetMkNymmQGUf9BRPCLbtX6nwQBG7TDkRzfdC/d+0hsIBc6j9CXVXtpIzNKH0xiFmEUL1nmDNDwN/PLpRNybbV00DWLgffYFqHj+wJvV6gNfBMGqdN6Eaiedz+1wK3QRX7x9UiJ+1a66wvCHSd959BNKGbkl4pgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aXbWfDJ/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aXbWfDJ/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567NriRF028461;
	Tue, 8 Jul 2025 11:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YlA3mh
	SCzITCTWIUMR8JK/UJmo74o7B8OGsfDAdFx28=; b=aXbWfDJ/0CnDfug7ftCMnf
	metpXO5gkjePGFWrZsgXN898VZHT56kghxuR6lYQnUKDT2+spvsS1DcVgvrfgODk
	tWObwjv35iqavIIqn3DCKGSmTrF4yUL0JsIOLgn6YYy11AwyBhFa3MlOCi97JtmA
	g7+mNDUJSWWHMCJIAyp8tDClvYhWjIucKxQYUNqbRSi6TDp4LZdBh+TItOL2Ncoy
	wTqkx5H2qa2g5wQIpwqKN4q4Ew84mE+jsZJeUVM/wINNN2dW49CudbpkB0RpU96b
	imVcZAKe6hH+2lBKwDIA2BPY0HowjJPJObCO94hqfuNjbIwZ3y0p+qtzIgcEBO1Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur6ybt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 11:13:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 568A0XNF021519;
	Tue, 8 Jul 2025 11:13:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectjt3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 11:13:11 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 568BD5sQ30081558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 11:13:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BBE758054;
	Tue,  8 Jul 2025 11:13:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E97125805A;
	Tue,  8 Jul 2025 11:13:06 +0000 (GMT)
Received: from [9.109.244.163] (unknown [9.109.244.163])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Jul 2025 11:13:06 +0000 (GMT)
Message-ID: <63ae97dd-8284-4123-a879-a2680b6fab26@linux.ibm.com>
Date: Tue, 8 Jul 2025 16:43:05 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: fix false lockdep deadlock warning
To: Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, josef@toxicpanda.com, axboe@kernel.dk,
        hch@infradead.org, hare@suse.de, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250627092348.1527323-1-yukuai1@huaweicloud.com>
 <aF56oVEzTygIOUTN@fedora>
 <c2fbaacc-62a1-4a98-4157-2637b7f242b7@huaweicloud.com>
 <197b6dca-56be-438d-a60f-21011367c5ed@linux.ibm.com>
 <99b4afce-de05-ddcb-2634-b19214cf4534@huaweicloud.com>
 <aGSaVhiH2DeTvtdr@fedora>
 <7b09167f-bf8d-4d94-9317-3cfbb4f83cd8@linux.ibm.com>
 <bc3f20c3-21f8-443b-619f-da7569b37aaf@huaweicloud.com>
 <08ce91d9-756a-a8fa-a988-a13ec74d8c1c@huaweicloud.com>
 <91174432-8c70-437f-811f-7c8a6c028f64@linux.ibm.com>
 <aGzJ6dssrCmJtG-3@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aGzJ6dssrCmJtG-3@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA4OSBTYWx0ZWRfX5e7I9TUWuuUI gHBMGtlZssInr0JdoYLjlfmcuuSiGQ2aeRVwN1JQWE8ov42ikg+Yftnf6/J+elwElRlVCqX7WBx WXQGZzQZmDiMluKBL9x/0PYf+O9ISNaRSppw3M+hymSKUDk472X9MpAT9YL+uzKLjMqJXgQZSyH
 8w6VZ683M4CPAJ/nAnvdwx7Qoh1nDC35zdT7+pgHi0t6d+2zsZTK9tCcwoVxHhrfVpySUzwMLa0 tt/JEG3aCjHH+UybMkAncOW0HwkpWILXGekx/Op0FwGe2phTNX5DbQ9iCzQ3Ad+o0hVx9scpmDW 8TT7PjLWYj1M3MShV6fIneqYybOqrYQ7eHrXA1YOEee6nMANRuqS83XubTF789RO7UZzvfmhwuu
 MF01B+qGQtBcazNGJEwOLm4E1NRTeF4tqTbNlUnao6eir70/9NEZ/Dfeo15Xvuisha2leeGb
X-Proofpoint-GUID: A9wbSwByPkNm6TQTP7Npo5hQ7ySRXDAa
X-Proofpoint-ORIG-GUID: A9wbSwByPkNm6TQTP7Npo5hQ7ySRXDAa
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686cfd48 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=5nsAZIZkkCYsSzfyBqYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080089



On 7/8/25 1:04 PM, Ming Lei wrote:
> On Tue, Jul 08, 2025 at 10:42:00AM +0530, Nilay Shroff wrote:
>>
>>
>> On 7/5/25 6:45 AM, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2025/07/02 15:30, Yu Kuai 写道:
>>>> Hi,
>>>>
>>>> 在 2025/07/02 14:22, Nilay Shroff 写道:
>>>>>
>>>>>
>>>>> On 7/2/25 8:02 AM, Ming Lei wrote:
>>>>>> On Wed, Jul 02, 2025 at 09:12:09AM +0800, Yu Kuai wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> 在 2025/07/01 21:28, Nilay Shroff 写道:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 6/28/25 6:18 AM, Yu Kuai wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> 在 2025/06/27 19:04, Ming Lei 写道:
>>>>>>>>>> I guess the patch in the following link may be simper, both two take
>>>>>>>>>> similar approach:
>>>>>>>>>>
>>>>>>>>>> https://lore.kernel.org/linux-block/aFjbavzLAFO0Q7n1@fedora/
>>>>>>>>>
>>>>>>>>> I this the above approach has concurrent problems if nbd_start_device
>>>>>>>>> concurrent with nbd_start_device:
>>>>>>>>>
>>>>>>>>> t1:
>>>>>>>>> nbd_start_device
>>>>>>>>> lock
>>>>>>>>> num_connections = 1
>>>>>>>>> unlock
>>>>>>>>>       t2:
>>>>>>>>>       nbd_add_socket
>>>>>>>>>       lock
>>>>>>>>>       config->num_connections++
>>>>>>>>>       unlock
>>>>>>>>>           t3:
>>>>>>>>>           nbd_start_device
>>>>>>>>>           lock
>>>>>>>>>           num_connections = 2
>>>>>>>>>           unlock
>>>>>>>>>           blk_mq_update_nr_hw_queues
>>>>>>>>>
>>>>>>>>> blk_mq_update_nr_hw_queues
>>>>>>>>> //nr_hw_queues updated to 1 before failure
>>>>>>>>> return -EINVAL
>>>>>>>>>
>>>>>>>>
>>>>>>>> In the above case, yes I see that t1 would return -EINVAL (as
>>>>>>>> config->num_connections doesn't match with num_connections)
>>>>>>>> but then t3 would succeed to update nr_hw_queue (as both
>>>>>>>> config->num_connections and num_connections set to 2 this
>>>>>>>> time). Isn't it? If yes, then the above patch (from Ming)
>>>>>>>> seems good.
>>>>>>>
>>>>>>> Emm, I'm confused, If you agree with the concurrent process, then
>>>>>>> t3 update nr_hw_queues to 2 first and return sucess, later t1 update
>>>>>>> nr_hw_queues back to 1 and return failure.
>>>>>>
>>>>>> It should be easy to avoid failure by simple retrying.
>>>>>>
>>>>> Yeah I think retry should be a safe bet here.
>>>>>
>>>>
>>>> I really not sure about the retry, the above is just a scenario that I
>>>> think of with a quick review, and there are still many concurrent
>>>> scenarios that need to be checked, I'm kind of lost here.
>>>>
>>>> Except nbd_start_device() and nbd_add_socked(), I'm not confident
>>>> other context that is synchronized with config_lock is not broken.
>>>> However, I'm ok with the bet.
>>>>
>>>>> On another note, synchronizing nbd_start_device and nbd_add_socket
>>>>> using nbd->task_setup looks more complex and rather we may use
>>>>> nbd->pid to synchronize both. We need to move setting of nbd->pid
>>>>> before we invoke blk_mq_update_nr_hw_queues in nbd_start_device.
>>>>> Then in nbd_add_socket we can evaluate nbd->pid and if it's
>>>>> non-NULL then we could assume that either nr_hw_queues update is in
>>>>> progress or device has been setup and so return -EBUSY. I think
>>>>> anyways updating number of connections once device is configured
>>>>> would not be possible, so once nbd_start_device is initiated, we
>>>>> shall prevent user adding more connections. If we follow this
>>>>> approach then IMO we don't need to add retry discussed above.
>>>>
>>>> It's ok for me to forbit nbd_add_socked after nbd is configured, there
>>>> is nowhere to use the added sock. And if there really are other contexts
>>>> need to be synchronized, I think nbd->pid can be used as well.
>>>>
>>>
>>> Do we have a conclusion now? Feel free to send the retry version, or let
>>> me know if I should send a new synchronize version.
>>>
>> Personally, I prefer synchronizing nbd_start_device and nbd_add_socket
>> using nbd->pid but I do agree retry version would also work. Having
>> said that, lets wait for Ming's feedback as well.
> 
> IMO simpler fix, especially in concept, is more effective for addressing
> this kind of issue, with less chance to introduce regression.
> 
> If no one objects, I may send the retry version.
> 
Adding new socket/connection, after nr_hw_queue update is initiated or 
device is setup, is of no use. But I am also good with retry version. 
So please send your patch.

Thanks,
--Nilay

