Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984A8355055
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076383; cv=none; b=NC5BCMHc9NYoU84WqjdQTFhjjYdHu3GggOkZyN8q3QkwaLAI5qnZavvEBU/jfCljlPGgVGAV1uU9yOU05vMtuyjzhOPs+fYRMq1c6WhYnbId7GztFcrRcK5Hl3OAyijnIWUHWBEvbNe7DCizpQF9cnhSIvLLdOEJKwXAKglnn1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076383; c=relaxed/simple;
	bh=5lb9w0zKmZuezk0vjvGDjY5jotDtea0yZd2HC3qnPuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqyy5FkCzJzIejAQ4TXo7VAMx+HFZ8GeKSyFoXHN1r2m9NgoW6Ite0NI5gglIxRf70cA96V5fOgmNwVGOEOVsGcXVreN/61wUMjuwEeP2wnh2R0nibNlUJDo8gPCdXhvnRnvvzrqzFewGsD6/H0jUNrngxWctM0BDTDQ/ok+Vns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h2TMzbZ2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h2TMzbZ2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M2bXhw022452;
	Thu, 22 Jan 2026 10:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lchr+N
	dWLaVrz7Dr5WTRfminlhgagHK6ClG+B9bA0Kg=; b=h2TMzbZ2iIQeYz4uxjOf8i
	vKYhkzVvDc9s95aqN89q74a6ue9Ugnfg6T7E5Q0lnsxgsSNFmbZzo8Fnrvwubjju
	01uSd1jZmrwKC7iMNydbrj2Zf2nJs3qBU7ISF5AF9FP1QK7pavHbhXPXQBHUhaAK
	mgkwHWZDQZCmW+cR2+/I9RQZ2FEBQz5miEfzcRbaMSPTQ3+IH83kBNpFP5PgmMQt
	jmnuttozUAHug1kR/L6tZnG+wEb745maDbAUGdcwL/zxvpBuT57Cb8WhCIB0dxQ4
	L6sNmuKSBNWWfrc3f0FtIAIH/2jF60Tkf873HUSOPij/YHaDxrrnhvGOH0SeQK6g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612c0pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 10:06:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60M9nDZ5027298;
	Thu, 22 Jan 2026 10:06:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrn9evn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 10:06:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MA5o9V10945144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 10:05:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F010658060;
	Thu, 22 Jan 2026 10:06:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E2555805B;
	Thu, 22 Jan 2026 10:06:06 +0000 (GMT)
Received: from [9.109.198.182] (unknown [9.109.198.182])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 10:06:06 +0000 (GMT)
Message-ID: <fd73dd79-b314-4514-86b7-74f1862aae1c@linux.ibm.com>
Date: Thu, 22 Jan 2026 15:36:05 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: John Garry <john.g.garry@oracle.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
 <aG7fArgdSWIjXcp9@kbusch-mbp>
 <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
 <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
 <501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com>
 <e7873ec2-c447-4eda-9725-80e614c3e210@oracle.com>
 <eaeaaf10-2e60-4ce1-9a84-42aaff1b7fc5@linux.ibm.com>
 <4023a0ad-ef60-4307-aca6-514ee790d6c6@linux.ibm.com>
 <d2ce6a5d-f6e4-441c-957c-fefc33f3758d@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d2ce6a5d-f6e4-441c-957c-fefc33f3758d@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hR16I1v1BXCTEV54XxfGnWZGmltthl1w
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=6971f692 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=I5r0CxplrSDLCy34:21 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GPVZdlxbx82-4tJytYoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hR16I1v1BXCTEV54XxfGnWZGmltthl1w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA2OCBTYWx0ZWRfX3WsmgHM4YTej
 K/JUxyP1k7IFY2ni3baTr0Wm0rg2AgZ4oUqWN6vucoa4VgTI/9qTq9fbI9y8D2GCNmEfr1HivVa
 aKFmNiqNoGouv/mHF++DSX4Ju5c4J7vx5QpALiz5eWR6GXNp/UbpXVxyT0z6iVbhF/mBbEjwV5B
 I+BY6jwnRWNnyibMdAl3KCXcd8CdzpHwv8BVuaYX0TfXgg/sjasl3gIjF8WAsM3s4YMQY3ekC3O
 maVtPu3nhoI4I2utrcVIs6cJohrkoHG0E9Mj2jKqs31VMoCo+V5H8osZjG/c/xqMkgHXxd3cdPz
 j7GeER2KtTDyIxL72Dzos0tK+ouozDhPLF9EUt65R7NMozFrZam1Lvh0wFW4/0uOOI7hpleTEYY
 OTDYKsD6JreO7/XzAJahP/VWPzb22x1AROFcAURGkQ2IvXCTXiwSYW4ZHaTp5wOkTbLgXh1Qzm/
 BZrlErBmIV43OWYo9hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220068



On 12/9/25 1:56 PM, John Garry wrote:
> On 08/12/2025 12:11, Nilay Shroff wrote:
>>>> Do you think that you could check with the OEM for updated firmware (that reports NAWUPF)?
>>> Yes, certainly — we can check with the disk vendor for updated firmware that correctly reports
>>> NAWUPF. I’ve already discussed this with my manager, and he’ll arrange a call with the vendor
>>> so that I can directly explain the issue and what we want from the kernel perspective.
>>> I’ll follow up with you once I’ve spoken to the vendor.
>>>
>> Just an update...
>>
>> We met with the vendor team and explained the current situation regarding atomic
>> writes and the NVMe Linux kernel driver. I’m happy to report that they acknowledged
>> the issue and agreed to provide updated firmware that advertises atomic write support
>> using NAWUPF instead of AWUPF.
>>
>> We shall first receive a test firmware build with this change. Once our test team
>> verifies that it behaves as expected, the vendor will proceed with a formal firmware
>> release. I’ll keep you posted once we receive the updated firmware.
> 
> Thanks for the update. It's good to know that this vendor will provide the required FW update.
> 
An update...

IBM has now formally received a firmware update that adheres to the (proposed) Linux
NVMe driver requirements for atomic write support. With this updated firmware, the
controller now reports AWUPF = 0 in the Identify Controller data structure. All 
namespace-specific atomic write limits, including NAWUPF, are reported exclusively
via the Identify Namespace data structure.
Additionally, the atomic write limits are now correctly scaled based on the LBA format,
as expected. The results below illustrate this behavior:

$ nvme list
Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev  
--------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------
/dev/nvme5n2          /dev/ng5n2            3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               0x1         12.44  GB / 204.84  GB      4 KiB +  0 B   REV.BAS8
/dev/nvme5n3          /dev/ng5n3            3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               0x3          0.00   B /  25.61  GB    512   B +  0 B   REV.BAS8

$ nvme id-ctrl /dev/nvme5 | grep awupf
awupf     : 0

$ nvme id-ns /dev/nvme5n2 | grep -A4 nawupf
nawupf  : 63
nacwu   : 63
nabsn   : 0
nabo    : 0
nabspf  : 0

nvme id-ns /dev/nvme5n3 | grep -A4 nawupf
nawupf  : 511		==>  As expected, the atomic write limit scales naturally for 512B LBA
nacwu   : 511
nabsn   : 0
nabo    : 0
nabspf  : 0

With this update, atomic write support is now clearly and unambiguously expressed
at the namespace level, while the controller-level AWUPF is set to zero, avoiding
ambiguity and aligning with the Linux NVMe driver expectations. Based on this
outcome, we could consider:

- Recommending other vendors adopt the same reporting model, and
- As it was already proposed earlier, updating the Linux NVMe kernel driver to disregard
  atomic write support for devices that report a non-zero AWUPF at the controller level.

Thanks,
--Nilay

