Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383E1C5496
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726819; cv=none; b=ojwsNTAi4l2BNULHUZnwUt8BDrfZqNciQp7GJHD7+Dh+S9cfBwFeyoTwkBx8MnG5l6i+wsaBuxKhMNjQ6Le/UfxNP/+RhtnQdUZMy8s9Ulu68cPCRt6Lnni43gxHGLlEonXhnCs1sVwvZQOiOnjy+uPDcjV1xE/qKqRlHy2vvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726819; c=relaxed/simple;
	bh=HZXVuQWOOyG00TbGc3miTizKVcFDbgYjPIojtPeS3aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbhgNDW59QOBdO+6msJ4q5slWS3LdzJSBy33GwoiQiRTXfYbSUfiFZqEzr8CT0iQraDMoEegSvxsRujKjwwgZLzBamqwfS5JdZnH7lg/uYB5JOg0bbVpuioOiUFxghL2p4fe9bpj/jqZpZhor1sjurG1IgAPSumY1yuEGlx+I1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bv/R1XSb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bv/R1XSb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S2wolV017929;
	Fri, 28 Feb 2025 07:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ysiHt+
	+J2CM/Qbqad48rsZhGjBZOtyZj/aCBOKyPQr0=; b=bv/R1XSb4LvhL2wmJg2DoQ
	PUq4Qu7wje1/Si14O0Mhjjp5/BEX/Ibo8PPc/fqiZuXUXTThfPPSiQG/JsCK5o2T
	9Cf+ldm/PAA/0gNlL12kAAUUCw6anJJfoW2Hb1DriqNsKYZxHE4so1dnyQkHXOHP
	CiQ/qTt/7340IN/Ig9KqVS/ojrrEs1NYdmuiMtCKq+EJzAf7WcGqWWwRbkU1Kh0W
	0CfnN61kv/TPtwu5Xf6SX3642w/UgSsqf7e7QaHcqnwSoEyJGJQksnMu7zz80yNc
	6s2OSOEwhLnGNYvPUE8g/wtALAzSFaVpLDJhdTuR1cmU/aNAUY57qGoldd9Zrk0Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452krpe7eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 07:13:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S5swaU012507;
	Fri, 28 Feb 2025 07:13:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9ywcpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 07:13:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51S7DC3N21824128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 07:13:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7B6458056;
	Fri, 28 Feb 2025 07:13:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A231858052;
	Fri, 28 Feb 2025 07:13:10 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 07:13:10 +0000 (GMT)
Message-ID: <7f0a3ae7-9659-426d-9595-fff9b14149fe@linux.ibm.com>
Date: Fri, 28 Feb 2025 12:43:08 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG report] WARNING of sysfs in __blk_mq_update_nr_hw_queues()
To: Li Nan <linan666@huaweicloud.com>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>,
        "wanghai (M)" <wanghai38@huawei.com>
References: <0ef71f91-eaec-f268-7d29-521fdcecc5ca@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <0ef71f91-eaec-f268-7d29-521fdcecc5ca@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7eUaJUI6TirPBa3vgueLm3ssdvmQ6UXc
X-Proofpoint-GUID: 7eUaJUI6TirPBa3vgueLm3ssdvmQ6UXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_01,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 mlxlogscore=517 clxscore=1011 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280049



On 2/28/25 7:52 AM, Li Nan wrote:
> Hi,
> 
> In __blk_mq_update_nr_hw_queues(), we don't check the return value of
> blk_mq_sysfs_register_hctxs(). When sysfs creation fails, there's no
> proper error handling. This leads to a kernel warning during subsequent
> __blk_mq_update_nr_hw_queues() calls or disk removal:
> 
> ```
> kernfs: can not remove 'nr_tags', no directory
> WARNING: CPU: 2 PID: 805 at fs/kernfs/dir.c:1703 kernfs_remove_by_name_ns+0x12e/0x140
> Call Trace:
>  <TASK>
>  remove_files+0x39/0xb0
>  sysfs_remove_group+0x48/0xf0
>  sysfs_remove_groups+0x31/0x60
>  __kobject_del+0x23/0xf0
>  kobject_del+0x17/0x40
>  blk_mq_unregister_hctx+0x5d/0x80
>  blk_mq_sysfs_unregister_hctxs+0x89/0xd0
>  blk_mq_update_nr_hw_queues+0x31c/0x820
>  nullb_update_nr_hw_queues+0x71/0xe0 [null_blk]
>  nullb_device_submit_queues_store+0xa4/0x130 [null_blk]
> ```
> 
> Should we add error checking for blk_mq_sysfs_register_hctxs() and
> propagate the error to abort the update operation when it fails? This
> would prevent subsequent operations from hitting invalid sysfs entries.
> 
IMO, yes error checking should be added here. However it will be tricky
to undo everything as the error might have happened deep inside loop. We
need to carefully delete all sysfs objects added under each hctx->kobj.
BTW, typically, we don't abort the nr_hw_queue update operation but 
instead fallback to the previously configured number of hw queues.

Thanks,
--Nilay
