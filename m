Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927271;
	b=t8zte1FKU2T3cJyexp0ZlhIQ+dvweWRObXTD3lWvgz9B4l6qQi37a+/omN8i+0PqOSXy
	 8s8EGFxkBd5XESimRMQajTgasuAieli3dfUA8/fD2dv/ywPgefLAqFsgrdAMpkBn+G7Wu
	 QdYYx1SOasedhMqk+fGxRyXYnNwVQ1j1+SZIbiOLtkHg4CkKQnf0QfNcee0613xUPBs6j
	 86VPXmj3NbvuA3ggLjquTVnXU8r+md1yZDIJQfhQysKKKvTuiO2oGnosGQMfuIpqo6Y19
	 vzz+Px9IL/XkJubJsp4qXldgyRujc/r0hBUT+PFqQooxQblp5ddfXiw+nh6JiS6gMGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927271;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=G2z1WNSCI5+9W0otpYmPG1HlbmXpwdh9y3di0gUnCg0=;
	b=LnYXWtCsEtsW2MEBtovwXKuR0P4EHKpam47ZCYCK8SRteszc8/jm9idVOaQ1DSwjdP0s
	 /wwalwl8POTF2ECjZP4Gdz9Kwx6MTm4ROlRvoahicEb8pEDl+VpnXmROBtVm/cHkvEjzi
	 xVoSTrk7yIThx/o9/LRZDD5TGgR2D3V+AiDj1ZAwT+3r4fKo3R5SZqfCqgt2sGsxc02/z
	 0kAiW8eaIv1OXlOkLhsiwDIQvlOr1agH2ZXlMu/RDrzFAH+EWS0Fio190UAU/z7omHEmn
	 Tc0x+TKOqkmH5+g5AZT4GtVr8Ma6shw1K/IhwcA8Ol5TEFivj78dM/vF8a2LTdPZmxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=febUlXed;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47F606A32A;
	Tue, 17 Nov 2026 14:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C47F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=febUlXed
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHBwbIp1089802;
	Tue, 17 Nov 2026 14:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G2z1WN
	SCI5+9W0otpYmPG1HlbmXpwdh9y3di0gUnCg0=; b=febUlXedSv0fOZyNM4toYN
	pyfeQC6dy7gNvVTfcRdxgB2fUzwsApBgMgjwiLSyvnkmYorthpGF/4dCEdQHQ0mh
	woXv5L89isg3NXd86vObo5Vo9yY0q+0R8iutl+uJpxV78jgE+ZS9D12WAp3IBD17
	Nx4mqyHyaGK1ZZqQDOUCz2kFemq1IAipLOuQ/IOTFlUg/IMyWkEhrRkIbnbMEV38
	dI4HiYVs77bZehmysFylepNOYUNf+vvFFKIB+fzIcueZ77ky3S3nhhy2qMV7uGUg
	l/OAw4qyiHX5hp6B2tPV1h+TCcJP/6s4wtmlFY5YbJptX9ragMPPduh1ZAFdNO5A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxe2db6x0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 14:54:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC5tAP3508343;
	Tue, 17 Nov 2026 14:54:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067nc3p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 14:54:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHErOMQ27853368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 14:53:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BB1058066;
	Tue, 17 Nov 2026 14:54:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5101058060;
	Tue, 17 Nov 2026 14:54:12 +0000 (GMT)
Received: from [9.61.5.249] (unknown [9.61.5.249])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 14:54:12 +0000 (GMT)
Message-ID: <11341b42-f641-49da-b823-d7c083d83a9a@linux.ibm.com>
Date: Tue, 17 Nov 2026 20:24:10 +0530
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
Subject: Re: [PATCH v3 2/2] block: return early when the elevator doesn't
 change
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20261116-bug-block-elevator-unchanged-v3-0-cb4dda2dadf4@linux.dev>
 <20261116-bug-block-elevator-unchanged-v3-2-cb4dda2dadf4@linux.dev>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261116-bug-block-elevator-unchanged-v3-2-cb4dda2dadf4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1NyBTYWx0ZWRfX07yao+Tok/F/
 TNnmoz0tLbdZrao4DDgSwTvuPlMQf8A+LRAzR0Qk4vGlsFGa71pQCJfOT0Dzp1A3/9d+pAHNTnr
 Fl1EVyENoWRlc1nC0fnGm7rqxit/FAQ=
X-Proofpoint-GUID: 9I0Bk_QM5L8rCCqSV5WjolE2W5Mhoco3
X-Proofpoint-ORIG-GUID: PQsvkT4QhkRE6BeE1zFigzzaZ-XNRkwX
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6afc6a99 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=0xM2EKjX6uQc8llLSOYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1NyBTYWx0ZWRfX1XT07RgyJfio
 0brGkaf+U1gMvDloTCIm/vopopUuHQaEBa/jVqTuy4ytE9A4kl05GDaJvA9YSd6NSNbN+YMhmlS
 Ptjj8x2WDpWz/gWd0p8y/eswN/B4n2PwGSbqLNbyjexLIpVQgndRpgqyjQRzNGvPi+oaQG8ZP1X
 NrOjew8C+XJXifUte/ZeccWF0AIIdH6FfBA34GQi0oNBWCM+8WHZ8T9F+NIt6TLeVuUb7kA0gLa
 GdLmieQyMSNJrXiEM8+fL9xK2D0bnGIRlclRT0WeETHeM1NwY1rUgVcvYnMZ9bAhVF7De91WXTl
 a05wJHBk/aoMYwua6Ri8LSFxD3wIGJ/2KHcTxi14czeP0FjqmjwYUvkAFmMNNK6kSwYp5I7SkUc
 vX2NGnOh+n5ZBxa2637XbuOidcLrySqtbIbQ21tu7cwfatnd5Nh0Kxxnq0gOCl3V2bj74ALyxm4
 mKOUJPSnskL84B0smaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170057

On 11/17/26 8:26 AM, Qiliang Yuan wrote:
> Writing the scheduler a queue already uses to queue/scheduler used to
> be a no-op. elevator_change() now only checks for an unchanged elevator
> after freezing the queue, and doesn't treat "none" on a queue without
> an elevator as unchanged at all, so that case also quiesces the queue
> in elevator_switch() and resets nr_requests.
> 
> Every such write therefore drains in-flight I/O and waits for an RCU
> grace period. udev rules and tuning tools that set the scheduler
> unconditionally stall I/O on live disks each time they run.
> 
> Check under elevator_lock whether anything would change before
> allocating scheduler resources and freezing the queue. The check can
> race with another elevator change, which at worst leads to a redundant
> switch, so keep the one done under the freeze as well.
> 
> Writing the current scheduler to queue/scheduler of a null_blk disk 20
> times takes (median):
> 
>    operation                 before (ms)  after (ms)  change
>    none -> none                     9.11        0.08    -99%
>    mq-deadline -> mq-deadline       9.05        0.08    -99%
> 
> 4k random reads at queue depth 1 for 10 seconds, while "none" is
> written to queue/scheduler every 50 ms:
> 
>    metric             before  after  change
>    IOPS               340562 390392    +15%
>    max latency (us)    16302   1224    -92%
> 
> Fixes: af2814149883e ("block: freeze the queue in queue_attr_store")
> Signed-off-by: Qiliang Yuan<qiliang.yuan@linux.dev>
> Reviewed-by: Christoph Hellwig<hch@lst.de>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
