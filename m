Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADB39AE3
	for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161930; cv=none; b=gf/21aruLm28HxkBgxanqRCFJcMAfI1901jWX0bWrHPXxx8CJ8JyN59pPBRwA9EU4sYg4Sv7lnGvgih1e2sJEDg003pfNexCty8dHtWyh6kSLoB/kHJLvNnovB37OyYL6VEfevmwV+Dymf2NjwR2ujZI2i4kriWdwUwh7KZkUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161930; c=relaxed/simple;
	bh=tEplRxBEHOqcwB+BxwcqVj8w4qR0CiW7li14FQOMLLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2E3CZ3s948oYuy8G7B7bk32Ru90hGa4EiXB+pAB1pX3z6Rgc32D2VtCQYF32RM7uuYgNqEESkSbzn7KxAWQID4R/m8UX2yRq0vfsjx9QBMSc90FdsUd50qM3calqhMo7s4JK2B0ukv1S4GUx5LLrCjIuvEdqEAYG0P8bPDoeBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ouzmJKo5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ouzmJKo5"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BCXKR0021390;
	Mon, 11 Mar 2024 12:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ykVk8jWxGNEVliddlfYJYX7F0Y13BvDCU0/OONaHdVo=;
 b=ouzmJKo59OGUi3R668mRnQivRzkrOLFk4IVXA8ZVCCrGJW/Vu8K9ZwtL1sbgm/Aan6Au
 TS4jz7b6XBPT4hw2QKCkDyM1QBgb86yQFJq/i1ahBP2gTumBkP56/LmhQ2E6k3JNDZlh
 MRhcFAG92rlnZw1nBHxjUzKYLyVamI2TkUaYA/1zWdVfE0rdqMfpICbg5EFX4MmKktD6
 MocQP34bZKw9J01TSukM1mPlYV1WvOssnuz6OeOkW4gtnaRaOP2075pO9pPAEYzJGFG0
 +Jhzb6BA/tT3EzS861R1OqsMz7YNndGYRte7Ap+U/tFUbcFVuUC48mP27Hz3iTeME9RC LQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt2290drb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:58:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42B9jeha015501;
	Mon, 11 Mar 2024 12:58:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fygqwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 12:58:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BCwPKp20709918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 12:58:27 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E6F35805D;
	Mon, 11 Mar 2024 12:58:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB95558059;
	Mon, 11 Mar 2024 12:58:22 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 12:58:22 +0000 (GMT)
Message-ID: <ac294adc-a7be-49af-88cd-e3aabd9f7c3f@linux.ibm.com>
Date: Mon, 11 Mar 2024 18:28:21 +0530
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
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Ze6LglWPqkHVFh-P@kbusch-mbp.mynextlight.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z6AxxUxm8uiCZtocNblHIn06_I2JK3RM
X-Proofpoint-ORIG-GUID: Z6AxxUxm8uiCZtocNblHIn06_I2JK3RM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110097



On 3/11/24 10:11, Keith Busch wrote:
> On Sun, Mar 10, 2024 at 12:35:06AM +0530, Nilay Shroff wrote:
>> On 3/9/24 21:14, Keith Busch wrote:
>>> Your patch may observe a ctrl in "RESETTING" state from
>>> error_detected(), then disable the controller, which quiesces the admin
>>> queue. Meanwhile, reset_work may proceed to CONNECTING state and try
>>> nvme_submit_sync_cmd(), which blocks forever because no one is going to
>>> unquiesce that admin queue.
>>>
>> OK I think I got your point. However, it seems that even without my patch
>> the above mentioned deadlock could still be possible. 
> 
> I sure hope not. The current design should guarnatee forward progress on
> initialization failed devices.
> 
>> Without my patch, if error_detcted() observe a ctrl in "RESETTING" state then 
>> it still invokes nvme_dev_disable(). The only difference with my patch is that 
>> error_detected() returns the PCI_ERS_RESULT_NEED_RESET instead of PCI_ERS_RESULT_DISCONNECT.
> 
> There's one more subtle difference: that condition disables with the
> 'shutdown' parameter set to 'true' which accomplishes a couple things:
> all entered requests are flushed to their demise via the final
> unquiesce, and all request_queue's are killed which forces error returns
> for all new request allocations. No thread will be left waiting for
> something that won't happen.
> 
Aaargh, I didn't notice that subtle difference. I got your all points..
After thinking for a while (as you suggested) it seems that we potentially
require to contain the race between reset_work and error_detected code path
as both could run in parallel on different cpu when pci recovery initiates. 
So I'm thinking that if we can hold on the error_detected() code path to proceed
until reset_work is finished ? Particularly, in error_detcted() function if 
we fall through the pci_channel_io_frozen case and the ctrl state is already
RESETTING (so that means that reset_work shall be running) then hold on 
invoking nvme_dev_diable(dev, false) until reset_work is finished. The changes
should be something as below:

@@ -3295,10 +3304,13 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
        case pci_channel_io_frozen:
                dev_warn(dev->ctrl.device,
                        "frozen state error detected, reset controller\n");
-               if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
-                       nvme_dev_disable(dev, true);
-                       return PCI_ERS_RESULT_DISCONNECT;
+               if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
+                       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+                               nvme_dev_disable(dev, true);
+                               return PCI_ERS_RESULT_DISCONNECT;
+                       }
                }
+               flush_work(&dev->ctrl.reset_work);
                nvme_dev_disable(dev, false);
                return PCI_ERS_RESULT_NEED_RESET;
        case pci_channel_io_perm_failure:

The flush_work() would ensure that we don't disable the ctrl if reset_work 
is running. If the rest_work is *not* running currently then flush_work() should
return immediately. Moreover, if reset_work is scheduled or start running after
flush_work() returns then reset_work should not be able to get upto the CONNECTING
state because pci recovery is in progress and so it should fail early.

On the reset_work side other than detecting pci error recovery, I think we also 
need one another change where in case the ctrl state is set to CONNECTING and we 
detect the pci error recovery in progress then before returning from the reset_work
we set the ctrl state to RESETTING so that error_detected() could forward progress.
The changes should be something as below:

@@ -2776,6 +2776,16 @@ static void nvme_reset_work(struct work_struct *work)
  out_unlock:
        mutex_unlock(&dev->shutdown_lock);
  out:
+       /*
+        * If PCI recovery is ongoing then let it finish first
+        */
+       if (pci_channel_offline(to_pci_dev(dev->dev))) {
+               dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
+               if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING)
+                       WRITE_ONCE(dev->ctrl.state, NVME_CTRL_RESETTING);
+               return;
+       }
+
        /*
         * Set state to deleting now to avoid blocking nvme_wait_reset(), which
         * may be holding this pci_dev's device lock.

Please let me know if you find anything not good with the above changes.

Thanks,
--Nilay









