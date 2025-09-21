Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B061DFF7
	for <linux-block@vger.kernel.org>; Sun, 21 Sep 2025 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758456899; cv=none; b=fwp3LKzU6exBg1FTFP0kJacbbPZBu2yI0zBKE0J+amXC1oBaWc94z8xCTtl7H6jFn49VlXSkgmIg++3FELnc+HBmWDfNtibtrTiOhwemIH31G6PD+uEmTbYqKWl0tYtP0JGgLKZD8liFOqp+/18RQhVJH74iVlbTu8OiqzUcXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758456899; c=relaxed/simple;
	bh=/LlhWgnI5ZLlLZ7mBPs0pVoq/Tfsqe6DALvX1Svd6dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIz6AaNORU4tVRkOUokWpo3owUJmXNMsxN/mf7BzLT62z2fT//KvegtMSJX7sJTSSvd0fnSgn9MM6epHykmVPUD90kAClTA0UnJLpDEo4eWHQ9JUegBJwF75z/nlf9BPUkOfIlTm7prFPvUsfgFlYyG1wg7UeHONuSeSyQDcKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tPJKF3c6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tPJKF3c6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L9592B002923;
	Sun, 21 Sep 2025 12:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GHc/iG
	mC7hcpr/3pjXA5ZfnRtlpKoD+XGllEct7Gjxk=; b=tPJKF3c68OedzMXhtxNGX4
	VFob9nch7Jxpew6kigSBrg+m+qzBcO83RetetdB2Litqz0O2a3aUtXND48utllKa
	HzkwK6fBWoARKqugjZXA445Y0Ju5sa6QUJwSqXYNkd/9Zd2JjAbMYGnK+18swW5u
	dQpeQdBM6cNs6f0fDObJ38jbAcWbha2leW04bQhmGOF7sVpM8iFnRKi0bMrZewvL
	nq9Y9Bz7U2Q5iuytEAheyhetufR7hig1zNhhJKuNrPMOyogn9sVKM2zbMZvJ0kQt
	cYxBYNkLkS27cZzO0CXQXN2y5gfuXiok8nVeqVS2JQH6ZraPYP7Jh+EvBOaJCoAg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hppwnmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 12:14:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58L871hu013638;
	Sun, 21 Sep 2025 12:14:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a8tj1ewd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 12:14:28 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58LCERWj12583590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 12:14:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC28C58064;
	Sun, 21 Sep 2025 12:14:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA62558056;
	Sun, 21 Sep 2025 12:14:24 +0000 (GMT)
Received: from [9.43.45.7] (unknown [9.43.45.7])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 21 Sep 2025 12:14:24 +0000 (GMT)
Message-ID: <20e208fa-4a13-45dd-8f26-6592242d477e@linux.ibm.com>
Date: Sun, 21 Sep 2025 17:44:22 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tests/throtl/004: add scsi_debug for test device
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
        shinichiro.kawasaki@wdc.com
Cc: ming.lei@redhat.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250918085341.3686939-1-yukuai1@huaweicloud.com>
 <20250918085341.3686939-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250918085341.3686939-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68cfec25 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=LYV1QqF6SERot7WJNpkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CbsKtqFV2pVFRipdhLThKlf9xRszIAkJ
X-Proofpoint-GUID: CbsKtqFV2pVFRipdhLThKlf9xRszIAkJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX2+uZHrbWmVGN
 9yH6QNowKhXz7Cpf4iXnKgfGWCl23sWCesteFY/uq58uvQ72HQRwOpsV5tV3RCMg6ra07lASncq
 b+xtCpHUAU2p2Fm869zON5cscxRPZ2xDaVmxXsuxwFmUvRyRE3YJd6kcr0l5hKD9BAGrl89DkWa
 9k6ONzp9pNPVoPEdgyK17rRqEccjm6yulFjtoFcURS11kGne9D2N9Exnl55aj9oU6EmnP++KOco
 ivc0hp2vVKjp1kAi9COYZt5B7q1lSLcuoLvyikdLk1jdUaw9O+7f97as30hJJH4ztnEpJWQpJ3N
 UhHQe2OCRxGMocekVXeObYo/Pwl8cpc7zZ2K9yUaF7utCUJP/ZKthfjjpMSb8WIfM1zBQwdH2jt
 Ywt6wXoC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224



On 9/18/25 2:23 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> While testing throtl manually, it's found there is a deadlock problem,
> add this regression test.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Changes seem good, however, does it make sense to add a separate test
for this lockdep?

Thanks,
--Nilay

