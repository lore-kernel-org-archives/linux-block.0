Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BFA230BCB
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670097; cv=none; b=GDkSjXtogE9tKIZi8oTEOxOLSYtRFOT9oQBqvHyrMVkKC4eS/wTVR6hYaZba6hazIYa6IAQ8R2FeFOUDZ8wF7PW8tyASzDqc510k37IhY3570DYhrlIw41691mywA7HQzWin/2lPjNHse2ByeybD6aN3hA/rsJWPtuy1aA7gMJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670097; c=relaxed/simple;
	bh=4x0gzM8eYV44UDOY8IdbfxrYJAA72lCChK0fDiqWOok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcRlCLdbWMNuBNcUBJGe+ra3d6XO7gux5Nw1QBvEwX2PrvD6T0ZLfqr9h3hHYLXFAH/8T1n1R0VwgtmiS36i4r9LfjNdD00yflKaOC05VRwDHyYc1Dsl+7nroOutb05IUjZaive0Lo8USqusrtVoJTXi96Cn9MTa6yKGNepzSm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p5PsMoBm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p5PsMoBm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MMjHj6026617;
	Mon, 23 Jun 2025 09:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W4SZDo
	8R6xxwk6frlV7WHo3unWngD22Po3ZX6mnavNM=; b=p5PsMoBmS58K9uhm4ZuxjC
	Yp12DhCaFDObO7OmkDeDObNz4sgsoN2K6NRuhqQ/PyUC+TyMU8AFyFrghVVxa7jp
	s0JKjkvyomUUxrlRvBT02avZXeWyNP9EQsWhwW1TN/4yUX4sajuY9D7Jf/19IKxw
	f6MffPJTvJyly+IRbX/sFC78ab1OPqsZEoOuwObSMjvnzoHg1CGcsDJw49qVRCSt
	XHaNWKe4GFF+8CTd7iiPM9nEAD/N1+8C7g0Jba69mxBxiQqolOk1T55FtySLITJj
	OFuR2WSh08vIaa/mp604FBrpZTVzPRJ/9aCcq+Z376YPNHmf0/tkEHt/i2XOJVLA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tgpn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 09:14:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N84pov030537;
	Mon, 23 Jun 2025 09:14:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eynk2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 09:14:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55N9EmC27537178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 09:14:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A079858059;
	Mon, 23 Jun 2025 09:14:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E0EE58053;
	Mon, 23 Jun 2025 09:14:46 +0000 (GMT)
Received: from [9.61.134.245] (unknown [9.61.134.245])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Jun 2025 09:14:45 +0000 (GMT)
Message-ID: <1d924b10-358d-447f-8abf-4d746c0b971b@linux.ibm.com>
Date: Mon, 23 Jun 2025 14:44:44 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/2] block: move elevator queue allocation logic into
 blk_mq_init_sched
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, axboe@kernel.dk,
        sth@linux.ibm.com, gjoyce@ibm.com
References: <20250616173233.3803824-1-nilay@linux.ibm.com>
 <20250616173233.3803824-2-nilay@linux.ibm.com>
 <20250623055613.GA30194@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250623055613.GA30194@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G_HHSzHso75_znmh-p37HFCrs0kn3C0k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1MSBTYWx0ZWRfX4WMjvmtz5LEy gW7ul29fNdx5wouQ3ztk6g1NJjEFn5CaYjYL47cUWhcLvNXgEPjaEl9k8Ik+PuwwO/4e6UGVoUP /V35rSoNXC53x3e9YEXThoV/A5RAYXCu4cL8FDbUxoWThhgnKqub6QTitlKcoZs0JhIV7KgzhmN
 oQpIh/pPn1vCFDnUbTJl91Fj8iBjqMHuOgscQ31/VTK40P4k8qt5c68PLsLQVEcWnEtvgQznN2y lGO7lQtZ5qeKAGmTB1bjoGBbem2cbE3tAZEZN09fEr1dbDk1iYRMZ4A/PlRrauLx0y1w0a2+nGI 1yuXhRukWVHLxnOvH/J1mwGReAP2JRzTTppEspaFCanQ04FMNhqzDblP8+AapX+Cpz29qJY3U6u
 Ek8/XPNFibT3FPvfRmwV6GBEpVRc+8NnUShwCBOnrxvRuIgVYL4CcPOnouX11X3m1F8tSP04
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=68591b0a cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=HFG-mOtRXtEahctX3YcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: G_HHSzHso75_znmh-p37HFCrs0kn3C0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=871 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230051



On 6/23/25 11:26 AM, Christoph Hellwig wrote:
> With this elevator_alloc can be unexported now.
> 
Yes it should be unexported. It will be handled in the next patchset.

Thanks,
--Nilay
