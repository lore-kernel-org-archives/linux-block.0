Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166177A0C
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724038; cv=none; b=NRqZyqtcxpsulriuOtzWZe2KKHBlt2XVuANFNQ4HJoDYQnc4tGZ6eerbVnbrUWqzeEfCSGLtemHx8iOisweNgTkxn1x3necCStDn5dSl2gjgKhBOO8YuMbK6UqdU8GciX7Q8ZMl7U7LHKyqLGQ0X3c3PU4KiMsIiL4acqLHKdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724038; c=relaxed/simple;
	bh=xSNYdW8KXhcHCvI5aRG9AV5ILc0/skfWtZT4mqVXrpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdmIhwf5MMWasC71U9QTuo9TB9Oo8CnOXr1m7wahG3JecIHiAqB9KEvEn370WeaJZhnHavdsvEuCqAJHZASe7DZ2uDGfV+bPVRTQMlMBqTys4pgmopx8mQp17DIFIiuqAe8KVg0iY6s+dCYjwpt5x1d/g838u9dOuFFdCD0H/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k673XBmL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k673XBmL"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426AQEpn012686;
	Wed, 6 Mar 2024 11:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ohhH0YuYyOrzNA74fqYS5iToaSblsSUwwc4UbEvZvPg=;
 b=k673XBmLcxgR7wxYfIPi2k/5GuV4TdUX9X8piH9ooC0H5EnMHhtenQOk3pOpnmVDD1se
 mUJEQwogmUYbi1D7foHxzEf7A/H6h6jkmJ1WlHslajC4LyXzgbLgIm1wm0+icbPvFyqh
 HhUuppMiNU4dXUCZ20tn25d7JytfXX/ttkbp49iqx0agFZZN2yiqDfFxKfiabWHrABAt
 jCIvOGUcAfZmMK7VH3P99AK0G16EUOAdBQEJBCke6BRvcrBpvxVOwo+9ApGaSkdTpBXv
 W4n6E380xWDlWDCEfGq7ZE+fPPKIt1JniXmIe3eNkrPsByzzsMS00JR1aMuQNKKwPkL8 UA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wppa89xuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 11:20:20 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426A2BKj025396;
	Wed, 6 Mar 2024 11:20:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmetypebp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 11:20:19 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426BKHmJ17170944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 11:20:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFD5458054;
	Wed,  6 Mar 2024 11:20:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B46258075;
	Wed,  6 Mar 2024 11:20:12 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 11:20:12 +0000 (GMT)
Message-ID: <4bc44911-afc2-4886-86cc-e0adb6be4457@linux.ibm.com>
Date: Wed, 6 Mar 2024 16:50:10 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, hch@lst.de
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gjoyce@linux.ibm.com
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zd4p_E8cPFpr1M--@kbusch-mbp>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Zd4p_E8cPFpr1M--@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X99vli0cNQibgqXpN6lw8phQZCoaJ_Ga
X-Proofpoint-GUID: X99vli0cNQibgqXpN6lw8phQZCoaJ_Ga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060090

Hi Keith and Christoph,

On 2/27/24 23:59, Keith Busch wrote:
> On Fri, Feb 09, 2024 at 10:32:16AM +0530, Nilay Shroff wrote:
>> If the nvme subsyetm reset causes the loss of communication to the nvme
>> adapter then EEH could potnetially recover the adapter. The detection of
>> comminication loss to the adapter only happens when the nvme driver
>> attempts to read an MMIO register.
>>
>> The nvme subsystem reset command writes 0x4E564D65 to NSSR register and
>> schedule adapter reset.In the case nvme subsystem reset caused the loss
>> of communication to the nvme adapter then either IO timeout event or
>> adapter reset handler could detect it. If IO timeout even could detect
>> loss of communication then EEH handler is able to recover the
>> communication to the adapter. This change was implemented in 651438bb0af5
>> (nvme-pci: Fix EEH failure on ppc). However if the adapter communication
>> loss is detected in nvme reset work handler then EEH is unable to
>> successfully finish the adapter recovery.
>>
>> This patch ensures that,
>> - nvme driver reset handler would observer pci channel was offline after
>>   a failed MMIO read and avoids marking the controller state to DEAD and
>>   thus gives a fair chance to EEH handler to recover the nvme adapter.
>>
>> - if nvme controller is already in RESETTNG state and pci channel frozen
>>   error is detected then  nvme driver pci-error-handler code sends the
>>   correct error code (PCI_ERS_RESULT_NEED_RESET) back to the EEH handler
>>   so that EEH handler could proceed with the pci slot reset.
> 
> A subsystem reset takes the link down. I'm pretty sure the proper way to
> recover from it requires pcie hotplug support.

This was working earlier in kernel version 6.0.0. We were able to recover the
NVMe pcie adapater on powerpc after nvme subsystem reset assuming some IO were
in flight when subsysetem reset happens. However starting kernel version 6.1.0 
this is broken. 
I 've found the offending commit 1e866afd4bcd(nvme: ensure subsystem reset is 
single threaded) causing this issue on kernel version 6.1.0 and above. So this
seems to be a regression and the proposed patch help fix this bug.

Please find below logs captured for both working and non-working cases:

Working case (kernel version 6.0.0):
-----------------------------------
# uname -r
6.0.0

# nvme list-subsys
nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:2.5-inch:S6EUNA0R500358
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
               iopolicy=numa
\
 +- nvme0 pcie 0018:01:00.0 live

# nvme subsystem-reset /dev/nvme0

# dmesg
<snip>
<snip>

[ 3215.658378] EEH: Recovering PHB#18-PE#10000
[ 3215.658401] EEH: PE location: N/A, PHB location: N/A
[ 3215.658406] EEH: Frozen PHB#18-PE#10000 detected
[ 3215.658409] EEH: Call Trace:
[ 3215.658411] EEH: [c00000000005130c] __eeh_send_failure_event+0x7c/0x160
[ 3215.658577] EEH: [c00000000004a104] eeh_dev_check_failure.part.0+0x254/0x670
[ 3215.658583] EEH: [c0080000044e61bc] nvme_timeout+0x254/0x4f0 [nvme]
[ 3215.658591] EEH: [c00000000078d840] blk_mq_check_expired+0xa0/0x130
[ 3215.658602] EEH: [c00000000079a118] bt_iter+0xf8/0x140
[ 3215.658609] EEH: [c00000000079b29c] blk_mq_queue_tag_busy_iter+0x3cc/0x720
[ 3215.658620] EEH: [c00000000078fe74] blk_mq_timeout_work+0x84/0x1c0
[ 3215.658633] EEH: [c000000000173b08] process_one_work+0x2a8/0x570
[ 3215.658644] EEH: [c000000000173e68] worker_thread+0x98/0x5e0
[ 3215.658655] EEH: [c000000000181504] kthread+0x124/0x130
[ 3215.658666] EEH: [c00000000000cbd4] ret_from_kernel_thread+0x5c/0x64
[ 3215.658672] EEH: This PCI device has failed 5 times in the last hour and will be permanently disabled after 5 failures.
[ 3215.658677] EEH: Notify device drivers to shutdown
[ 3215.658681] EEH: Beginning: 'error_detected(IO frozen)'
[ 3215.658688] PCI 0018:01:00.0#10000: EEH: Invoking nvme->error_detected(IO frozen)
[ 3215.658692] nvme nvme0: frozen state error detected, reset controller
[ 3215.788089] PCI 0018:01:00.0#10000: EEH: nvme driver reports: 'need reset'
[ 3215.788092] EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'need reset'
<snip>
<snip>
[ 3215.790666] EEH: Reset without hotplug activity
[ 3218.078715] EEH: Beginning: 'slot_reset'
[ 3218.078729] PCI 0018:01:00.0#10000: EEH: Invoking nvme->slot_reset()
[ 3218.078734] nvme nvme0: restart after slot reset
[ 3218.081088] PCI 0018:01:00.0#10000: EEH: nvme driver reports: 'recovered'
[ 3218.081090] EEH: Finished:'slot_reset' with aggregate recovery state:'recovered'
[ 3218.081099] EEH: Notify device driver to resume
[ 3218.081101] EEH: Beginning: 'resume'
<snip>
[ 3218.161027] EEH: Finished:'resume'
[ 3218.161038] EEH: Recovery successful.

# nvme list-subsys
nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:2.5-inch:S6EUNA0R500358
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
               iopolicy=numa
\
 +- nvme0 pcie 0018:01:00.0 live

Non-working case (kernel verion 6.1):
------------------------------------
# uname -r
6.1.0

# nvme list-subsys
nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:2.5-inch:S6EUNA0R500358
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
               iopolicy=numa
\
 +- nvme0 pcie 0018:01:00.0 live

# nvme subsystem-reset /dev/nvme0

#dmesg
[  177.578828] EEH: Recovering PHB#18-PE#10000
[  177.578852] EEH: PE location: N/A, PHB location: N/A
[  177.578858] EEH: Frozen PHB#18-PE#10000 detected
[  177.578869] EEH: Call Trace:
[  177.578872] EEH: [c0000000000510bc] __eeh_send_failure_event+0x7c/0x160
[  177.579206] EEH: [c000000000049eb4] eeh_dev_check_failure.part.0+0x254/0x670
[  177.579212] EEH: [c008000004c261cc] nvme_timeout+0x254/0x4e0 [nvme]
[  177.579221] EEH: [c00000000079cb00] blk_mq_check_expired+0xa0/0x130
[  177.579226] EEH: [c0000000007a9628] bt_iter+0xf8/0x140
[  177.579231] EEH: [c0000000007aa79c] blk_mq_queue_tag_busy_iter+0x3bc/0x6e0
[  177.579237] EEH: [c00000000079f324] blk_mq_timeout_work+0x84/0x1c0
[  177.579241] EEH: [c000000000174a28] process_one_work+0x2a8/0x570
[  177.579247] EEH: [c000000000174d88] worker_thread+0x98/0x5e0
[  177.579253] EEH: [c000000000182454] kthread+0x124/0x130
[  177.579257] EEH: [c00000000000cddc] ret_from_kernel_thread+0x5c/0x64
[  177.579263] EEH: This PCI device has failed 1 times in the last hour and will be permanently disabled after 5 failures.
[  177.579269] EEH: Notify device drivers to shutdown
[  177.579272] EEH: Beginning: 'error_detected(IO frozen)'
[  177.579276] PCI 0018:01:00.0#10000: EEH: Invoking nvme->error_detected(IO frozen)
[  177.579279] nvme nvme0: frozen state error detected, reset controller
[  177.658746] nvme 0018:01:00.0: enabling device (0000 -> 0002)
[  177.658967] nvme 0018:01:00.0: iommu: 64-bit OK but direct DMA is limited by 800000800000000
[  177.658982] nvme 0018:01:00.0: iommu: 64-bit OK but direct DMA is limited by 800000800000000
[  177.659059] nvme nvme0: Removing after probe failure status: -19
[  177.698719] PCI 0018:01:00.0#10000: EEH: nvme driver reports: 'need reset'
[  177.698723] EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'need reset'
<snip>
<snip>
[  179.999828] EEH: Beginning: 'slot_reset'
[  179.999840] PCI 0018:01:00.0#10000: EEH: no driver
[  179.999842] EEH: Finished:'slot_reset' with aggregate recovery state:'none'
[  179.999848] EEH: Notify device driver to resume
[  179.999850] EEH: Beginning: 'resume'
[  179.999853] PCI 0018:01:00.0#10000: EEH: no driver
<snip>

# nvme list-subsys
<empty>

Thanks,
--Nilay
