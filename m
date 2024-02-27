Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0C4B5C1
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057719; cv=none; b=jQfJfa/NZfx0NQ/bZ4BnQKlEzSER5TeuIV5pKT664Y9QuG0MmrLtr0WQgRyCCWfnl1ZnrY6fvFYsKBNghmmD0HU66zcBHeiv9+CrXtg+8Ad6xoGHZNaOBWLC0tkXnlbH7QDPkodkrchKORM0+2u8wc0QiP/xGM4I8imT6APO6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057719; c=relaxed/simple;
	bh=BA1M2B1uvtUyotYRXPsM2G4+0C210AeHPfbrz7hLsXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/i7v/AE0ZuLT+IQeE8vGAwatXafRhbBOCTuGsrLBWQW+dIsTdHeScNt1hz9rdec2Xe0ny6dDL3nKQrhDyyGHjnl2sARc9RLHv9aIcSlPoNzM6sTfu/9qzEvjHvrL3uWNYyuZji9Ye9G7mgYis8L+EdpoWsLmd4fGnOnvOolblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DlXWu8rH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DlXWu8rH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RI0WXo026846;
	Tue, 27 Feb 2024 18:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5AvmDA0grlwGB4Xi0roYbMQsUGJdsgI5cbaEbGF6POA=;
 b=DlXWu8rHefm8qYqJ3ekk6B/FHXkoOhY2CBOw0ucAooIGSZWYafYyoaP/e4P68DnmJQa+
 Qw7IYTwTKgaF9hCORY4GIEUxRCWmksIxXPh3J9SM/fgLAtjVmviBCxmw164B/rlt/WqB
 q22/NxSDzSNWe14IB5UJnyrfPYGg0sFvb8/dwzMq5VVFvCwfpgUhuM/FudY+GISoEAf1
 L9JEHSpURO+G+k2Dk0xyJEXJiKA8rgmOZQoPhtA4+Toc+ZzKoShfxkFW23cM/Ia1Ji2/
 z5P5OY7AvoRehopp6GjdoCerucw7kP3KG3vTnxnkI15A7GVLr0xE7heeJBe22MLVD0CF 7Q== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whm7ugxyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:14:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41RFnbTT021768;
	Tue, 27 Feb 2024 18:14:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu601huy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 18:14:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41RIEoKZ56295866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 18:14:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22CA058058;
	Tue, 27 Feb 2024 18:14:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80F6E58064;
	Tue, 27 Feb 2024 18:14:47 +0000 (GMT)
Received: from [9.171.1.29] (unknown [9.171.1.29])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Feb 2024 18:14:47 +0000 (GMT)
Message-ID: <ef73919c-230d-4fac-9bd9-4fc0ad8c1da9@linux.ibm.com>
Date: Tue, 27 Feb 2024 23:44:46 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        gjoyce@linux.ibm.com,
        Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <2c76725c-7bb6-4827-b45a-dbe1acbefba7@imap.linux.ibm.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <2c76725c-7bb6-4827-b45a-dbe1acbefba7@imap.linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zzDtb_tp2SGURkyazfDVO44MWUgtuTuV
X-Proofpoint-ORIG-GUID: zzDtb_tp2SGURkyazfDVO44MWUgtuTuV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270141

Hi,

A gentle ping...

Thanks,
--Nilay

On 2/16/24 18:07, Srimannarayana Murthy Maram wrote:
> Hi all,
> 
> Tested patch with upstream kernel "6.8.0-rc4"
> 
> Issue verified on IBM power systems with manual test case has following steps
> 1. Note nvme controllers for a nvme subsystem using
>     "nvme list-subsys"
> 2. Perform nvme subsystem reset on each listed controller
>    under nvme subsystem one after the other, only after successful recovery.
> 
> Verified it on power system with NVME device on normal and multipath (2 paths) configuration.
> 
> Provided patch successfully recovered single controller(normal) and both controller(multipath) listed under nvme subsystem.
> 
> Tested-by: Maram Srimannarayana Murthy<msmurthy@linux.vnet.ibm.com>
> 
> Thank you,
> Maram Srimannarayana Murthy
> Sr. Test Engineer | IBM
> 
> On 2/9/24 10:32, Nilay Shroff wrote:
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
>>    a failed MMIO read and avoids marking the controller state to DEAD and
>>    thus gives a fair chance to EEH handler to recover the nvme adapter.
>>
>> - if nvme controller is already in RESETTNG state and pci channel frozen
>>    error is detected then  nvme driver pci-error-handler code sends the
>>    correct error code (PCI_ERS_RESULT_NEED_RESET) back to the EEH handler
>>    so that EEH handler could proceed with the pci slot reset.
>>
>> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>
>>
>> [  131.415601] EEH: Recovering PHB#40-PE#10000
>> [  131.415619] EEH: PE location: N/A, PHB location: N/A
>> [  131.415623] EEH: Frozen PHB#40-PE#10000 detected
>> [  131.415627] EEH: Call Trace:
>> [  131.415629] EEH: [c000000000051078] __eeh_send_failure_event+0x7c/0x15c
>> [  131.415782] EEH: [c000000000049bdc] eeh_dev_check_failure.part.0+0x27c/0x6b0
>> [  131.415789] EEH: [c000000000cb665c] nvme_pci_reg_read32+0x78/0x9c
>> [  131.415802] EEH: [c000000000ca07f8] nvme_wait_ready+0xa8/0x18c
>> [  131.415814] EEH: [c000000000cb7070] nvme_dev_disable+0x368/0x40c
>> [  131.415823] EEH: [c000000000cb9970] nvme_reset_work+0x198/0x348
>> [  131.415830] EEH: [c00000000017b76c] process_one_work+0x1f0/0x4f4
>> [  131.415841] EEH: [c00000000017be2c] worker_thread+0x3bc/0x590
>> [  131.415846] EEH: [c00000000018a46c] kthread+0x138/0x140
>> [  131.415854] EEH: [c00000000000dd58] start_kernel_thread+0x14/0x18
>> [  131.415864] EEH: This PCI device has failed 1 times in the last hour and will be permanently disabled after 5 failures.
>> [  131.415874] EEH: Notify device drivers to shutdown
>> [  131.415882] EEH: Beginning: 'error_detected(IO frozen)'
>> [  131.415888] PCI 0040:01:00.0#10000: EEH: Invoking nvme->error_detected(IO frozen)
>> [  131.415891] nvme nvme1: frozen state error detected, reset controller
>> [  131.515358] nvme 0040:01:00.0: enabling device (0000 -> 0002)
>> [  131.515778] nvme nvme1: Disabling device after reset failure: -19
>> [  131.555336] PCI 0040:01:00.0#10000: EEH: nvme driver reports: 'disconnect'
>> [  131.555343] EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'disconnect'
>> [  131.555371] EEH: Unable to recover from failure from PHB#40-PE#10000.
>> [  131.555371] Please try reseating or replacing it
>> [  131.556296] EEH: of node=0040:01:00.0
>> [  131.556351] EEH: PCI device/vendor: 00251e0f
>> [  131.556421] EEH: PCI cmd/status register: 00100142
>> [  131.556428] EEH: PCI-E capabilities and status follow:
>> [  131.556678] EEH: PCI-E 00: 0002b010 10008fe3 00002910 00436044
>> [  131.556859] EEH: PCI-E 10: 10440000 00000000 00000000 00000000
>> [  131.556869] EEH: PCI-E 20: 00000000
>> [  131.556875] EEH: PCI-E AER capability register set follows:
>> [  131.557115] EEH: PCI-E AER 00: 14820001 00000000 00400000 00462030
>> [  131.557294] EEH: PCI-E AER 10: 00000000 0000e000 000002a0 00000000
>> [  131.557469] EEH: PCI-E AER 20: 00000000 00000000 00000000 00000000
>> [  131.557523] EEH: PCI-E AER 30: 00000000 00000000
>> [  131.558807] EEH: Beginning: 'error_detected(permanent failure)'
>> [  131.558815] PCI 0040:01:00.0#10000: EEH: Invoking nvme->error_detected(permanent failure)
>> [  131.558818] nvme nvme1: failure state error detected, request disconnect
>> [  131.558839] PCI 0040:01:00.0#10000: EEH: nvme driver reports: 'disconnect'
>> ---
>>   drivers/nvme/host/pci.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index c1d6357ec98a..a6ba46e727ba 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2776,6 +2776,14 @@ static void nvme_reset_work(struct work_struct *work)
>>    out_unlock:
>>       mutex_unlock(&dev->shutdown_lock);
>>    out:
>> +    /*
>> +     * If PCI recovery is ongoing then let it finish first
>> +     */
>> +    if (pci_channel_offline(to_pci_dev(dev->dev))) {
>> +        dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
>> +        return;
>> +    }
>> +
>>       /*
>>        * Set state to deleting now to avoid blocking nvme_wait_reset(), which
>>        * may be holding this pci_dev's device lock.
>> @@ -3295,9 +3303,11 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>>       case pci_channel_io_frozen:
>>           dev_warn(dev->ctrl.device,
>>               "frozen state error detected, reset controller\n");
>> -        if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>> -            nvme_dev_disable(dev, true);
>> -            return PCI_ERS_RESULT_DISCONNECT;
>> +        if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
>> +            if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>> +                nvme_dev_disable(dev, true);
>> +                return PCI_ERS_RESULT_DISCONNECT;
>> +            }
>>           }
>>           nvme_dev_disable(dev, false);
>>           return PCI_ERS_RESULT_NEED_RESET;
