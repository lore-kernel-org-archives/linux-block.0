Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901813F9D5
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710331201; cv=none; b=IbCHpxO9uzWUOUWTiqrI/g7lqS625qaGRlKzGMmOVGSQUVC27nP82GSo8rwIfanWCeVFbcDf6hIybF37CNEbeUjoibc46YeVRb1k2gRV3OK0q2i/1PKUZ+XzqvOPcxTDk+sgA2n7ofvBgSszdstB/GFU4uEYk0xLqF+UjnLtXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710331201; c=relaxed/simple;
	bh=4M+7OXb2xrHvW0r4vmAJiV00BBNH6vPbYLsFCC9fzrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Noc5FX4sRL7peRofMsRK5eytkMEroyvhVNt6dFTU54uUAW3rRurXqrga/Ninx5P1A0nNnCpHU4iwcvibBt5PgnOuySfou9LK6bGwR0IfMO2kdlXzy9YvMJAU4i7Hh2TC7GQxv1y7S1sJjNxnQLSqwyMglLlkIvz8/+adqTvbi40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HUZgd5yF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HUZgd5yF"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DBbpc7016657;
	Wed, 13 Mar 2024 11:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Tr6PJcYjFadw1eIBRwVRlMYUQn0uuS83HA+kDqe8X8w=;
 b=HUZgd5yFz3GFX4cXCxD1+nMjFA2b5PyN3FhETsyMKW+X15upof0YEs68ftmwVtSKij4+
 hi6kPH3b3AwmIK337ZLZqDJrOifpjnNimXwIsm1xIgD/LcvoJBIW4dri7GYpR+5xQrFo
 2SHraxhZF3xsAwsmswquTHtbyyIXPXsRaFpYcUithK+H2f+UPI8uJ9KCJypCmDE2NUaj
 5b1Jio20Dksf/qa5KhNrRFFZWcMgLvfz2DmQ5Dtq6EImWhtYBxeIqs8CudvRy3r1EXpR
 jocxZbqHa237JgYyzcaePC6bDwB43BNaALkBkXiedv0MQSGtroYAYrOZEBE/ppTDyjfb 9g== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wube6gay0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 11:59:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42DAR3oe020436;
	Wed, 13 Mar 2024 11:59:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3km5fv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 11:59:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42DBxdOE51708388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 11:59:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D51B258057;
	Wed, 13 Mar 2024 11:59:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B43858062;
	Wed, 13 Mar 2024 11:59:37 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Mar 2024 11:59:37 +0000 (GMT)
Message-ID: <af991867-02a3-4ff9-94fc-50955913f227@linux.ibm.com>
Date: Wed, 13 Mar 2024 17:29:35 +0530
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
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, gjoyce@linux.ibm.com
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zesxq81eJTnOGniB@kbusch-mbp>
 <039541c8-2e13-442e-bd5b-90a799a9851a@linux.ibm.com>
 <ZeyD6xh0LGZyRBfO@kbusch-mbp>
 <301b8f41-a146-497a-916f-97d91829d28c@linux.ibm.com>
 <Ze6LglWPqkHVFh-P@kbusch-mbp.mynextlight.net>
 <ac294adc-a7be-49af-88cd-e3aabd9f7c3f@linux.ibm.com>
 <ZfBm72xPozFN99GA@kbusch-mbp.mynextlight.net>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZfBm72xPozFN99GA@kbusch-mbp.mynextlight.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SHICZkNxk0Hq4WiTRiv7FSRd9KagCRI0
X-Proofpoint-ORIG-GUID: SHICZkNxk0Hq4WiTRiv7FSRd9KagCRI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130089



On 3/12/24 20:00, Keith Busch wrote:
> On Mon, Mar 11, 2024 at 06:28:21PM +0530, Nilay Shroff wrote:
>> @@ -3295,10 +3304,13 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>>         case pci_channel_io_frozen:
>>                 dev_warn(dev->ctrl.device,
>>                         "frozen state error detected, reset controller\n");
>> -               if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>> -                       nvme_dev_disable(dev, true);
>> -                       return PCI_ERS_RESULT_DISCONNECT;
>> +               if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
>> +                       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>> +                               nvme_dev_disable(dev, true);
>> +                               return PCI_ERS_RESULT_DISCONNECT;
>> +                       }
>>                 }
>> +               flush_work(&dev->ctrl.reset_work);
> 
> I was messing with a similar idea. I wasn't sure if EEH calls the error
> handler inline with the error, in which case this would try to flush the
> work within the same work, which obviously doesn't work. As long as its
> called from a different thread, then this should be fine.
The EEH recovery happens from different thread and so flush work should 
work here as expected.

>> @@ -2776,6 +2776,16 @@ static void nvme_reset_work(struct work_struct *work)
>>   out_unlock:
>>         mutex_unlock(&dev->shutdown_lock);
>>   out:
>> +       /*
>> +        * If PCI recovery is ongoing then let it finish first
>> +        */
>> +       if (pci_channel_offline(to_pci_dev(dev->dev))) {
>> +               dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
>> +               if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING)
>> +                       WRITE_ONCE(dev->ctrl.state, NVME_CTRL_RESETTING);
> 
> This may break the state machine, like if the device was hot removed
> during all this error handling. This will force the state back to
> RESETTING when it should be DEAD.
Agreed, we shouldn't force reset state to RESETTING here.
> 
> I think what you need is just allow a controller to reset from a
> connecting state. Have to be careful that wouldn't break any other
> expectations, though.
Yeah ok got your point, so I have reworked the ctrl state machine as you 
suggested and tested the changes. The updated state machine code is shown
below:

@@ -546,10 +546,11 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
                break;
        case NVME_CTRL_RESETTING:
                switch (old_state) {
                case NVME_CTRL_NEW:
                case NVME_CTRL_LIVE:
+               case NVME_CTRL_CONNECTING:
                        changed = true;
                        fallthrough;
                default:
                        break;
                }

And accordingly updated reset_work function is show below. Here we ensure that
even though the pci error recovery is in progress, if we couldn't move ctrl state
to RESETTING then we would let rest_work forward progress and set the ctrl state
to DEAD.

@@ -2774,10 +2774,19 @@ static void nvme_reset_work(struct work_struct *work)
        return;
 
  out_unlock:
        mutex_unlock(&dev->shutdown_lock);
  out:
+       /*
+        * If PCI recovery is ongoing then let it finish first
+        */
+       if (pci_channel_offline(to_pci_dev(dev->dev))) {
+               if (nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+                       dev_warn(dev->ctrl.device, "PCI recovery is ongoing, let it finish\n");
+                       return;
+               }
+       }
        /*
         * Set state to deleting now to avoid blocking nvme_wait_reset(), which
         * may be holding this pci_dev's device lock.
         */
        dev_warn(dev->ctrl.device, "Disabling device after reset failure: %d\n",


Now I have also included in my test the hot removal of NVMe adapter while EEH recovery
is in progress. And the  EEH recovery code handles this case well : When EEH recovery 
is in progress and if we hot removes the adapter (which is being recovered) then EEH
handler would stop the recovery, set the PCI channel state to "pci_channel_io_perm_failure".


Collected the logs of this case, (shown below):
-----------------------------------------------
# nvme list-subsys 
nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:2.5-inch:S6EUNA0R500358
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
               iopolicy=numa

# lspci 
0018:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173X

# dmesg
[  561.639102] EEH: Recovering PHB#18-PE#10000
[  561.639120] EEH: PE location: N/A, PHB location: N/A
[  561.639128] EEH: Frozen PHB#18-PE#10000 detected
<snip>
<snip>
[  561.639428] EEH: This PCI device has failed 2 times in the last hour and will be permanently disabled after 5 failures.
[  561.639441] EEH: Notify device drivers to shutdown
[  561.639450] EEH: Beginning: 'error_detected(IO frozen)'
[  561.639458] PCI 0018:01:00.0#10000: EEH: Invoking nvme->error_detected(IO frozen)
[  561.639462] nvme nvme0: frozen state error detected, reset controller
[  561.719078] nvme 0018:01:00.0: enabling device (0000 -> 0002)
[  561.719318] nvme nvme0: PCI recovery is ongoing so let it finish

<!!!! WHILE EEH RECOVERY IS IN PROGRESS WE HOT REMOVE THE NVMe ADAPTER !!!!>

[  563.850328] rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
<snip>
[  571.879092] PCI 0018:01:00.0#10000: EEH: nvme driver reports: 'need reset'
[  571.879097] EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'need reset'
<snip>
<snip>
[  571.881761] EEH: Reset without hotplug activity
[  574.039807] EEH: PHB#18-PE#10000: Slot inactive after reset: 0x2 (attempt 1)
[  574.309091] EEH: Failure 2 resetting PHB#18-PE#10000 (attempt 2)
[  574.309091] 
[  574.579094] EEH: Failure 2 resetting PHB#18-PE#10000 (attempt 3)
[  574.579094] 
[  574.579101] eeh_handle_normal_event: Cannot reset, err=-5
[  574.579104] EEH: Unable to recover from failure from PHB#18-PE#10000.
[  574.579104] Please try reseating or replacing it
<snip>
<snip>
[  574.581314] EEH: Beginning: 'error_detected(permanent failure)'
[  574.581320] PCI 0018:01:00.0#10000: EEH: no device

# lspci
<empty>

# nvme list-subsys
<empty>


Another case tested, when the reset_work is ongoing post subsystem-reset command
and if user immediately hot removes the NVMe adapter then EEH recovery is *not* 
triggered and ctrl forward progress to the "DEAD" state.

Collected the logs of this case, (shown below):
-----------------------------------------------
# nvme list-subsys 
nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:2.5-inch:S6EUNA0R500358
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
               iopolicy=numa

# lspci 
0018:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173X

# nvme subsystem-reset /dev/nvme0

<!!!! HOT REMOVE THE NVMe ADAPTER !!!!>

# dmesg
[ 9967.143886] eeh_handle_normal_event: Cannot find PCI bus for PHB#18-PE#10000
[ 9967.224078] eeh_handle_normal_event: Cannot find PCI bus for PHB#18-PE#10000
<snip>
[ 9967.223858] nvme 0018:01:00.0: enabling device (0000 -> 0002)
[ 9967.224140] nvme nvme0: Disabling device after reset failure: -19

# lspci
<empty>

# nvme list-subsys
<empty>


Please let me know if the above changes look good to you. If it looks good then 
I would spin a new version of the patch and send for a review.

Thanks,
--Nilay


