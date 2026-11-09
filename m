Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231828;
	b=CoiLoqBMf2F35sXgM1nvoS9ndzG7n0sj5gVUDGVpLHvd7ieOwvLZ30g3svxts2O0+wGb
	 YXamAZYx0XAgDSwTYtyqAKVqPFMJjb5GhrOp+X76s8LeK4KiiAZ5OeszuB7vvZVXGo2Yp
	 TGOM5O04pbhxhIMNCkM+SKtd/fetnjh0wt/xhdS0hkquMHBcbnVEEuYVq0tzcaQz6eu5I
	 a2C44P9RwldUfcBQjojCFflVPiK53VqbypNnLB2itiHGV5b0vxrhVlz9NUakQHJBb4sM9
	 KEs1Xp/YDKk1/GbZGoRyGcArUcAa/4DMqoIWT/4G4z7CzaWUhHxRd+ryejhvA1Cuyrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231828;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CKWrRE24xGA9Q5PGyFZBNTV8NES0y92YbzNWrmtBCVQ=;
	b=wAoZLPh9lh9+ztrBLdByQRcU5NOCy9BrJtBKo/tsWvT/RMdo8Y7VOeAg+kXaZMU7lBv8
	 ufU95567I6PK4JmcDyI6KeFGTlMT4B31RH/43X0ZnQn2JirrMZefmVhzmPVOdppE6qaK4
	 J/QnezCJHxXEPQxT0jzs9d/7XDWaAc1s4fGJpiapgEDJKlNzDw0QPaqVjpUtmG/uyc8Cs
	 EI86u+3+FfVLJybVisXWLNHSBw/nQl/wp/5H70LzIeA643aKbs3NCXHOJbmZfrFI52NHA
	 q0sVnCDq2x0mxjF2MBUyShGLOXTIYzQP1hQZJ+KQZ5Pj12cT4w9TZgCvTI68RkGv4jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BLPhbfpv;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0C606A321
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 13:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6A0C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BLPhbfpv
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DEx973499093;
	Mon, 9 Nov 2026 13:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CKWrRE
	24xGA9Q5PGyFZBNTV8NES0y92YbzNWrmtBCVQ=; b=BLPhbfpvKM83n31N068pUC
	+qzSwy1xjBM0zdQ1jn0SiLnPE0oMAJ6NFw3Izd5KgJLbwXgLNv0JPiu7PB/5Ckw7
	6o7C+alzkQXur5RsBF2qualDNVzB3r4+RzstYZ1H2Qma39o8u2H485gcSmsKyVgB
	jFmbdF01F0v8G+lyM1LKLW9ZXTeGXTBOxam6FMS01lWyA5VqeGazUQ4W+cC1Qcl+
	Fa4Dpxk52tIUc+32bpC8qP61IdzGAosmTxvucDd6M8OsvIR1gGTy1BpVHENUjbbx
	B6o/INxxLYv7uL6r5kd7DKXq/w7UY09jiIwzyllJQAfXx+91T+FY7Rcrbq8zQCxQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6nc9v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 13:43:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DJtSk131299;
	Mon, 9 Nov 2026 13:43:33 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0xykjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 13:43:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9DhWPh6292236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 13:43:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C55958059;
	Mon,  9 Nov 2026 13:43:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED10C58057;
	Mon,  9 Nov 2026 13:43:28 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 13:43:28 +0000 (GMT)
Message-ID: <7a2bcf1c-990f-46fa-badd-dc1b14dfa96f@linux.ibm.com>
Date: Mon, 9 Nov 2026 19:13:27 +0530
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/081: test the per-queue io_cpu sysfs
 attribute
To: Saravanan D <saravanand@crusoe.ai>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org,
        dwagner@suse.de, hare@suse.de, sagi@grimberg.me, kbusch@kernel.org,
        iyamahata@crusoe.ai, kiyer@crusoe.ai, ganbalagane@crusoe.ai,
        sjpark@crusoe.ai, bchen@crusoe.ai
References: <cover.1794015622.git.saravanand@crusoe.ai>
 <20261107095350.98072-1-saravanand@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261107095350.98072-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MiBTYWx0ZWRfX4HjXv9A4FxSV
 SMpvw35gFuKj9ZbjQtQ2DNnWs1MhjXFKzAvzoV0w33yXKvsns1I+zLPGncxE8oqkIKvudymYBpG
 aBtlWbOVdsfs0/AoUCyYxMtN0xpV2WI=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af1ce06 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=vo2OPiIVJ99YoxJSP2MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ponbikn11T6b_6Y74z-m9BrlAfgMLeDn
X-Proofpoint-GUID: Ponbikn11T6b_6Y74z-m9BrlAfgMLeDn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MiBTYWx0ZWRfXzaVZ5Vo+5VV/
 i+F61jOVTIW7cXZHF+ljk8Rbl3u2bUS0ZjHffh9wCiQsLQVpLk+Cx6WZLrherYbrImlc4yhxMmZ
 z9IMGvto6hIaaaG9xrN7jcU++dyl3ERixFVcmz20wj6HcmpcHHPKdS3R0bYE9E+V3erLvAXmN0L
 zLRkKFL9kDLqkGxQZuWsqqPVKsUNlrrrtzaUqAP1DSrBWLIxq/XpYbUH9MGp2SNY7D7Mkus3aKa
 dCYoXy9BW6RU9p8nitLQ4puDSeyo6yE2AhftxZlplzJlA+rx+lZAHL1aqZn+NJBc85cWpdMpek/
 69qIzcxlzQDICJpEOtbko4VOiXUbE40sqiFvaDoQ75G/ZmiWVE8XJ/Z2rWOfrB1aktIDJt42EV9
 tRffTLltflZfVB/rxEz7QrSpEY0ZN957zehVWnVDtX3YcvQDRH56rnMD7WH6Y4PEKzb5MtdwYoF
 Mt7r6BR7515UAeJb20g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090052

On 11/7/26 3:23 PM, Saravanan D wrote:
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
> +	local skipped=false
> +	local nvmedev qdir cpu writer
> +
> +	_nvmet_target_setup --blkdev file
> +
> +	_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 2

How about adding connection option "--nr-io-queues 2"? If we add
this option then we may not need to have the requirement of
_require_min_cpus 2. I think, we shall be able to run this test
also on the system with only one cpu.

> +	_nvmf_wait_for_state "${def_subsysnqn}" "live"
> +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> +	qdir="/sys/class/nvme/${nvmedev}/queues"
> +	cpu=$(last_online_cpu)
> +
Can we also add one more test here which tests whether "$qdir"
exists or not?

> +	if [[ ! -f "${qdir}/1/io_cpu" ]]; then
> +		SKIP_REASONS+=("missing per-queue io_cpu attribute")
> +		skipped=true
> +	elif [[ "$(nr_queue_dirs "${nvmedev}")" -lt 2 ]]; then
> +		SKIP_REASONS+=("controller has fewer than 2 I/O queues")
> +		skipped=true

I think using --nr-io-queues option would also replace the above relative
comparison with an exact comparison based on num of queues selected.

> +	else
> +		test_read_write "${qdir}" "${cpu}"
> +		test_reset "${nvmedev}" "${qdir}" "${cpu}"

The reset test could be updated to ensure that number of queues
remains unchanged after controller reset. Current test_reset()
verifies that the io_cpu and managed attributes retain their expected
values after reset. However, it doesn't explicitly verify that the
queue directories were recreated with the same count. I would capture
the queue_count before reset and compare it afterward as well as
ensure that queue_count matches with nr_queue_dirs.

Thanks,
--Nilay

