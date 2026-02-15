Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81BFE571;
	Sun, 15 Feb 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771162534; cv=none; b=aIe3jLTHdNs+FEIxXPkyBoHTyKS4H9c6pvFKxw2ion53yjtraUnKtSmZifmcPau7bP+WPpZFYT2Yrrpzns8yDWkzMMJFXOo4iWtKLv26FfaohIoQcl4qgBGK0syWTUjKjMU+KE5mLjkQdKYWKWsK5rWAFqTDP/B6pazculluunA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771162534; c=relaxed/simple;
	bh=YMd0NY2Cp+cVSvRtKxKI0RGhsN7DwjSYuuBq+Aawt/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMAUbv9m6LQEZw8uzri14ji0aB6tbMoBndQop8T4XiGbWyzRBwu1QLVfz3siFLT9VEWhItCDhmkKPSQFDGAQI0sAu4UjU5bdEPyeDGHa+BgYuuXvJ2cQtTQxKzSPnL19/0cZVMOWw4DS1zdEovfY75cGAkU0Tlj91rBHSsmcX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EegWYlza; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EegWYlza"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61F1oENf1317217;
	Sun, 15 Feb 2026 13:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AusRQa
	maEuCGJfZFYlSYYG+pqqCFjK0ilKgB9/4tSoU=; b=EegWYlzaLbMcSNU+i/qSpY
	ERmCigghc3yCRFUtso0zrtEyfVhZaCxIGGPK4u6klfdt5cXWlC8r5FhzxayuR2nd
	h4RS/4Sndxk8bJB6Jq4aBy0XGiEmcaK+uNhctb0rABdZIJgT96YkC0S+46zaqxL/
	Ba8dhnRCRCEBLti6BRRN4+A/DA7VMG0nvgbom6DAHTMjNdhPwBrKET/olglo9BeO
	P2H/V7TTD8tVofpNp2gfYMsKwYEelM46aYCKKPPsY/+2EU4SWakN4rvHoc1B7XKc
	me5hIhTGpbr95kaWiTYGZ66mwS5nuoX8YbOeDGMLDXvVK0MGyYE4kmwgdmneas6A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6uc0tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Feb 2026 13:35:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61FCOQIo025024;
	Sun, 15 Feb 2026 13:35:01 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb3rxhxhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Feb 2026 13:35:01 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61FDZ0sv66978052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Feb 2026 13:35:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 993055805B;
	Sun, 15 Feb 2026 13:35:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D39BE58059;
	Sun, 15 Feb 2026 13:34:53 +0000 (GMT)
Received: from [9.111.50.199] (unknown [9.111.50.199])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Feb 2026 13:34:53 +0000 (GMT)
Message-ID: <fd2f4aab-27db-4a01-8b25-762466634c1e@linux.ibm.com>
Date: Sun, 15 Feb 2026 19:04:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-mq: use NOIO context to prevent deadlock during
 debugfs creation
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, ming.lei@redhat.com,
        hch@lst.de
Cc: yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, kbusch@kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260214054350.2322436-1-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260214054350.2322436-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6991cb87 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=JF9118EUAAAA:8 a=tJLSzyRPAAAA:8
 a=VnNF1IyMAAAA:8 a=IYyPFNahz8ouDM3NFjgA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDEwOCBTYWx0ZWRfX7sP2HGckZMqt
 DemqwAQ27FNN0xM2/BeMZxYRJuDj6ugENnAsalyMkL/3tC/qrRNJSKaxoRD3oE6f5ApI1JZ69xw
 sdPojGmMw4773YWXE8xtgOn5/Kudud9uMBEHq7COiHxhNClBGqJlhB/bFcvW/6r/CxHk1bTHuwK
 CMr1Hz9mylgmVgeqYHiO0IydUk72hKrBS0/S7cYaQe/EWWgx2eS3T8TYwRpQcQ/5XFOOa7DmoER
 5YRGooThRKohhX0lD2Mw3Y+u22DRt/Qeo1S/CUhcbYHN7N3zVIVLTwsXnJ8OyDtwTHaGpvFCvpv
 +QBlTo7Y2akn7mSBppP9y17XjMmN+RQ2UzyuWO3JjPuLKqlY15huwkGLFA0DyIdHXgBL2UGgalm
 vCGnk0wCFket3X1dStsnBvV1iVlV4ulDf0g663RbKlv8AGiMfnz//vw6FX6KusiTy+O5S0khvtv
 4tVN24ezxsX2eOEFiBQ==
X-Proofpoint-ORIG-GUID: MPP4kn1W_IYiNqbji8zmbKoKXO3BGuGB
X-Proofpoint-GUID: MPP4kn1W_IYiNqbji8zmbKoKXO3BGuGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602150108



On 2/14/26 11:13 AM, Yu Kuai wrote:
> Creating debugfs entries can trigger fs reclaim, which can enter back
> into the block layer request_queue. This can cause deadlock if the
> queue is frozen.
> 
> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
> to detect this condition, but it was racy since the queue can be frozen
> from another context at any time.
> 
> Introduce blk_debugfs_lock()/blk_debugfs_unlock() helpers that combine
> the debugfs_mutex with memalloc_noio_save()/restore() to prevent fs
> reclaim from triggering block I/O. Also add blk_debugfs_lock_nomemsave()
> and blk_debugfs_unlock_nomemrestore() variants for callers that don't
> need NOIO protection (e.g., debugfs removal or read-only operations).
> 
> Replace all raw debugfs_mutex lock/unlock pairs with these helpers,
> using the _nomemsave/_nomemrestore variants where appropriate.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com/
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/all/aYWQR7CtYdk3K39g@shinmob/
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
