Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4173021E0BB
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 05:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752124058; cv=none; b=eXFhavEZ4Mogo5T3mYd10VKGq9bBRaMhSwnzK1i/wCMTT47tWM54h8Rp8iLDLIPDUIj2RJC2yo5HGWRdpJ5p70qwvXoB4rQ6vgSmG6uG/qIDfkqqHYFU3RYISwiK2WqtnqgSYp9eLgm7DKIxHTEXtuxNCMvHLd95y2M0Ch55wQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752124058; c=relaxed/simple;
	bh=A/bV8iLKwrhz4lY+8pN2QejwSnA+2SKAH2tVnSzSfbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTnAHVwlqi3JA5CfQKqOXqdp/MSoxzBEQkLvyw5Q67xSmBl4B87ev+ih02Sj/2HDbPE1KKmq8hu/34SRkejaJGWpvpm30GwfpDkWESreIO5T+HR6ctP0JRt8/h748P1VIZw5AWtfXeMRO1Sj0LWMFWQk2oY9Z+JhZO8AVodNa9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ReICOneD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ReICOneD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Ms1ne011211;
	Thu, 10 Jul 2025 05:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AvMH84
	qBE5GCm9uR9TayaoG4QyZk0jcQyCZthSAENPg=; b=ReICOneDcM8p5im+J8NC/g
	knFqWgERkAE3hcSO0xInki6qjWLD+sWArbAX1XpUO76r2wagldfDVIv301/1/QEi
	3XG1+sy+7nykGzBqLl2U/xpbMz1E/TWcmerH+L9jTRu3yj3oGNhw6CfZUQ/RTXXs
	fwtaSZijFf2taqDqnkfu6xRxlhYKYC662KGpGGXCivjznsMRA+5QwsTiMStiOX6P
	09ph8duPBUj2CNHDbd5rbYAKwiVoDEbFGuOuAiqKYp2neFd4aEaRFsgj1F6GIhNu
	gzxgP0tn8BKkMs4mk4w+f/55B86WL/xwN4LAQwT9CRzU9jD7lv3c6euk/Aaf1bLg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnhpjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 05:07:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A3Frde024277;
	Thu, 10 Jul 2025 05:07:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32knhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 05:07:24 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56A57NJT29688508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 05:07:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACFA158045;
	Thu, 10 Jul 2025 05:07:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1123958060;
	Thu, 10 Jul 2025 05:07:21 +0000 (GMT)
Received: from [9.204.207.151] (unknown [9.204.207.151])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 05:07:20 +0000 (GMT)
Message-ID: <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
Date: Thu, 10 Jul 2025 10:37:19 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
 <aG7fArgdSWIjXcp9@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aG7fArgdSWIjXcp9@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=686f4a8d cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=I5r0CxplrSDLCy34:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=RmKR18SSKyEKqrCuxJ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _O4R_Qh21PqzV8-PSyDBTaOw4XqyJAW2
X-Proofpoint-ORIG-GUID: _O4R_Qh21PqzV8-PSyDBTaOw4XqyJAW2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAzOSBTYWx0ZWRfX0liXGqYKcM62 h5pMCO2VuhK9X1AQm4xFrKpAPjtLGMgtLBoeA87KTgqTo3v4eO1h8NpyUavHDjS72QSe/IOsKU6 FJos5bd/wK5/damL/E1rYpLC7FcVRuU5y+C+CBhgKji85JTcjexh8dcYP+uzCXqfu1hOOdS6o2c
 vvH5QGwptIjxTtq9HHNzAjEhOZxs7NnYgsIbOnDv36lC6gWHlC12g6TQaYnyjqKgGoovCy8eGa7 zhCTGRDu7PR3fMyQY9D4g0OFMEqARtunyFO27vtTja3vruoHsrp/eN2NPQX0LsJ/uSGxdszg1P5 aolUJESrYOa9Sz8gJ6QrYJKJ/cWcVssmMb4ryIeFT1btsEbDRTQLyRWL2uUiq6IJUkghG/GNH5N
 oOvEPUulju6zX6GaXom7Jv0TRR8hgpgDGHDpymJkJ7kkNIObku+iyq5SBoBcjNEVuTGmbEMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100039



On 7/10/25 2:58 AM, Keith Busch wrote:
> On Wed, Jul 09, 2025 at 01:21:17PM +0530, Nilay Shroff wrote:
>> I believe there are multi-controller NVMe disks in the field (including the 
>> one I have) that do not exhibit such inconsistencies, i.e., they report a
>> consistent AWUPF value across controllers and do not change it based on 
>> namespace format. The NVMe specification states this (quoting it from 
>> NVM-Command-Set-Specification-1.0e):
>>
>> "The values (referencing AWUPF / AWUN) reported in the Identify Controller
>> data structure are valid across all namespaces with any supported namespace
>> format, forming a baseline value that is guaranteed not to change."
> 
> I don't think that's a backward compatible requirement. Controllers
> often rescale these after a format command, and it was the only way for
> 1.0 and 1.1 controllers to report atomic sizes.
> 
> Lets say the controller can do 128k byte atomic writes, If all
> namespaces used 512b LBA format, then AWUPF would be 255. If you change
> one namespace format to 4k, AWUPF scales down to 31, yielding a
> sub-optimal result for all the other namespaces.
> 
On the multi-controller disk I’ve been testing, each controller consistently
reports an AWUPF value of 63. I created shared namespaces with mixed LBA formats
— some using 512-byte LBAs and others using 4KB LBAs — and observed that the 
AWUPF value remained constant at 63 across all controllers and formats.

This implies that:
- A namespace with 4KB LBA format can support up to 256KB of  atomic
  writes (4KB × 64),
- A namespace with 512-byte LBA format can only support up to 32KB of
  atomic writes (512B × 64).

So in this case, it's actually the opposite of what one might assume:
Users of namespaces with 4KB LBA format would see the best possible atomic write
performance, while those using 512-byte LBA format may observe sub-optimal 
performance, since the maximum atomic write size scales down with smaller LBAs.

>> While the spec doesn´t explicitly require that AWUPF be consistent across
>> controllers within the same subsystem, it seems to be implied. That said,
>> I agree this should have been stated explicitly in the specification.
> 
> Considering multi-controller subsystems, some controllers might have
> namespaces with only 512b formats attached, and other controllers might
> have some 4k mixed in, so then they can't all consistently report the
> desired AWUPF value. They'd have to just scale AWUPF based on the
> largest sector size supported. Which I guess is what the current wording
> is guiding toward, but that just suggests host drivers disregard the
> value and use NAWUPF instead. So still option III.

Yes, I agree — option III seems to be the best possible way forward. 
However, does this mean we would disregard atomic write support for any
multi-controller NVMe vendor that consistently reports a valid AWUPF value
across all controllers and namespace formats, but sets NAWUPF to zero?

Thanks,
--Nilay
