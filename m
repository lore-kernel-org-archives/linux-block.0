Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583F13DABF2
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 06:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711607436; cv=none; b=jqjmSta3yI6eeO5neh9dCr4y4z0RlrYNJ5AQ8++v9QNKTmGrLD3DZTGVC+pMEVu7sEN+SfVgJFN7tWCnUqOuKYJ/yXXwOCc3qX3gIdeuzF+1qhqq2jipCstLS5YUCmjBUO0AsHPEBnui6TPSeBT+OVYYbXRPS+nS4AmgfF1nfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711607436; c=relaxed/simple;
	bh=tS/nH26IqollRxx0VHH3ijCDC9ISvMxAW0iiKgQRHuU=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=CcekAXTFlzAlMGilVhwxy/fvsDRe9cKrVRtoDH43zq28KJTCef+QwtcIHpT9bV7LB2Hygeofx8wFT11I3GXTjf1Q/n++qVKVS/U35089FFQYSl/Fb0gHmf2J+89FIoihh/LRT2rMORqC6HO3mZL+F/scslasfKDzKcp/RDeuvcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZqaBT3nX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZqaBT3nX"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S6MBwW015965;
	Thu, 28 Mar 2024 06:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : to : cc : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=dWeEjPmWFb0TGMpIBftaYdBnp85qaMTm57U5XHTmcAg=;
 b=ZqaBT3nX7WjMV+tEOe1N0fOsXPzqDBN+Go6hrLXjeV3jMqsSGUBCrtR/hF8Q9QIGEV6L
 4WtiAQj2z8pLdHQymahHs90thA1jBtY2Bw2bwXbH6iz4ln2Kjd5YrNxoF7qeE5jdBmjx
 NqzKP8qBDqg3ZCusj1uzKdbwkK/BAnOiOTXn3odTmrb2Pi5VKvch3jT3og33OcPfBq0H
 W0g4tRF2dOy4jAbvJfW/1Ndb4S339xc1RfD9UyV9ESaeV3eVOsVGNIQFTCbzLx7irTx8
 9ekGHXgdtRoOW7P6TMWiJ2KAK6JkxiLwwsROlI5PS08BSo6Oql2BqtLt1uKQd50yK4Sy Qg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x513r0974-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 06:30:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42S37aDH016411;
	Thu, 28 Mar 2024 06:30:15 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29duc3ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 06:30:15 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42S6UCVf29753794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 06:30:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C49C858069;
	Thu, 28 Mar 2024 06:30:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E13905806E;
	Thu, 28 Mar 2024 06:30:08 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 06:30:08 +0000 (GMT)
Message-ID: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
Date: Thu, 28 Mar 2024 12:00:07 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, axboe@fb.com,
        Gregory Joyce <gjoyce@ibm.com>
Subject: [Bug Report] nvme-cli commands fails to open head disk node and print
 error
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 588Rb1qvwyVZWugBwT_JyjfV1t2KUVX9
X-Proofpoint-GUID: 588Rb1qvwyVZWugBwT_JyjfV1t2KUVX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_05,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403280039

Hi,

We observed that nvme-cli commands (nvme list, nvme list-subsys, nvme show topology etc.) print error message prior to printing the actual output.

Notes and observations:
======================-
This issue is observed on the latest linus kernel tree (v6.9-rc1). This was working well in kernel v6.8.

Test details:
=============
I have an NVMe disk which has two controllers, two namespaces and it's multipath capable:

# nvme list-ns /dev/nvme0 
[   0]:0x1
[   1]:0x3

One of namespaces has zero disk capacity:

# nvme id-ns /dev/nvme0 -n 0x3
NVME Identify Namespace 3:
nsze    : 0
ncap    : 0
nuse    : 0
nsfeat  : 0x14
nlbaf   : 4
flbas   : 0
<snip>

Another namespace has non-zero disk capacity:

# nvme id-ns /dev/nvme0 -n 0x1 
NVME Identify Namespace 1:
nsze    : 0x156d56
ncap    : 0x156d56
nuse    : 0
nsfeat  : 0x14
nlbaf   : 4
flbas   : 0
<snip>
 
6.8 kernel:
----------

# nvme list -v 

Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys0     nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1                                                 nvme0, nvme2

Device   SN                   MN                                       FR       TxPort Asdress        Slot   Subsystem    Namespaces      
-------- -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
nvme0    3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0524:28:00.0          nvme-subsys0 nvme0n1
nvme2    3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0584:28:00.0          nvme-subsys0 

Device       Generic      NSID       Usage                      Format           Controllers     
------------ ------------ ---------- -------------------------- ---------------- ----------------
/dev/nvme0n1 /dev/ng0n1   0x1          0.00   B /   5.75  GB      4 KiB +  0 B   nvme0

As we can see above the namespace (0x3) with zero disk capacity is not listed in the output.
Furthermore, we don't create head disk node (i.e. /dev/nvmeXnY) for a namespace with zero
disk capacity and also we don't have any entry for such disk under /sys/block/.  

6.9-rc1 kernel:
---------------

# nvme list -v 

Failed to open ns nvme0n3, errno 2 <== error is printed first followed by output

Subsystem        Subsystem-NQN                                                                                    Controllers
---------------- ------------------------------------------------------------------------------------------------ ----------------
nvme-subsys0     nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1                                                 nvme0, nvme2

Device   SN                   MN                                       FR       TxPort Asdress        Slot   Subsystem    Namespaces      
-------- -------------------- ---------------------------------------- -------- ------ -------------- ------ ------------ ----------------
nvme0    3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0524:28:00.0          nvme-subsys0 nvme0n1
nvme2    3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               REV.CAS2 pcie   0584:28:00.0          nvme-subsys0 

Device       Generic      NSID       Usage                      Format           Controllers     
------------ ------------ ---------- -------------------------- ---------------- ----------------
/dev/nvme0n1 /dev/ng0n1   0x1          0.00   B /   5.75  GB      4 KiB +  0 B   nvme0


# nvme list-subsys 

Failed to open ns nvme0n3, errno 2 <== error is printed first followed by output

nvme-subsys0 - NQN=nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
               iopolicy=numa
\
 +- nvme2 pcie 0584:28:00.0 live
 +- nvme0 pcie 0524:28:00.0 live

# nvme show-topology

Failed to open ns nvme0n3, errno 2 <== error is printed first followed by output

nvme-subsys0 - NQN=nqn.2019-10.com.kioxia:KCM7DRUG1T92:3D60A04906N1
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
               iopolicy=numa
\
 +- ns 1
 \
  +- nvme0 pcie 0524:28:00.0 live optimized

From the above output it's evident that nvme-cli attempts to open the disk node /dev/nvme0n3 
however that entry doesn't exist. Apparently, on 6.9-rc1 kernel though head disk node /dev/nvme0n3
doesn't exit, the relevant entries /sys/block/nvme0c0n3 and /sys/block/nvme0n3 are present. 

As I understand, typically the nvme-cli command build the nvme subsystem topology first before 
printing the output. Here in this case, nvme-cli could find the nvme0c0n3 and nvme0n3 under 
/sys/block and so it assumes that there would be a corresponding disk node entry /dev/nvme0n3
show present however when nvme-cli attempts to open the /dev/nvme0n3 it fails and causing the 
observed symptom. 

Git bisect:
===========
The git bisect points to the below commit:

commit 46e7422cda8482aa3074c9caf4c224cf2fb74d71 (HEAD)
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Mar 4 07:04:54 2024 -0700

    nvme: move common logic into nvme_update_ns_info
    
    nvme_update_ns_info_generic and nvme_update_ns_info_block share a
    fair amount of logic related to not fully supported namespace
    formats and updating the multipath information.  Move this logic
    into the common caller.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Keith Busch <kbusch@kernel.org>


In 6.9-rc1, it seems that with the above code restructuring, we would now hide the head disk 
node nvmeXnY showing up under /dev, however the relevant disk names nvmeXcYnZ and nvmeXnY do 
exist under /sys/block/. On 6.8 kernel, we don't create any disk node under /dev and as well
the corresponding disk folders under /sys/block if the disk capacity is zero. 

Thanks,
--Nilay




