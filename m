Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D931514EC
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737021; cv=none; b=hSxM2OC+WscwhfdT95HQMpaDjIb2BjTIF8Qtt7ha+lNKI61yo2oOjPglPef31zu395cG9avo1Z3aRlDgpCgaCS5c7KrMIBKMqCkwV6tnQUuyoG3WRlvunbz5K3gss0XwabJ/WePZdx8ixCpZLUZiB1OUetKCJLcjWKQedjMEdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737021; c=relaxed/simple;
	bh=VZ+ccW3b4NaLfmP6434HZ0mAUx/Jrpv/DOLMxLCp7SA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QGQqwNf698DFbZqcsFLIt6lsWNTE7X+44g7b4Ei/X4coKRoFRI27ItKONnDlN0+dBd8tCOj1zAgSMI4EEakDZaZ6ahyyqoNOkcCqGSmqjkVrDjfkCboNTgdxLxSwwvR16027euzg2BNesmQWXnbTtWmmLPTmuupm4NEFjQuEWMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sAG1DRzp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sAG1DRzp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 443BRp55002884;
	Fri, 3 May 2024 11:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zdazS+xZoOkYFy/zdIPgO0Yc0Ax4z4CJW/bLOuyNv5c=;
 b=sAG1DRzpTrTCcOcJ4e7kFQWbRL8OQhUw3hi7bP+lWp6pXhHG5a0k5bEB+igP6Xz0r2AD
 WPzniwQOMF6CQPb0g9VPJlabbU4+JLuvtn7wvvjYcYqDpLnkG/VelankVmeAX3sx9kGj
 zV66BGDAhz/SYFC/Cv8C289eJqNsvXQzWEuz+ZIxJwO1DSHu8CQJnFG4x036KpLD/VEN
 Wcr+7Zu2OSoak1kF18w/qpDWTwN9DCGGFJ0Re6UBUpluYtNdj9pAQXV+13hmNBieIppU
 EZAiYpqk6Q+knI6fYSrg73fykNjSBZOWcvklhaIUCr4SpTkteDss4kZ5PdTlxVf212rl SA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xvy2h01k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 11:50:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 443AVFvH022190;
	Fri, 3 May 2024 11:50:01 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsd6n5bcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 11:50:01 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 443BnwK635586378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 May 2024 11:50:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C76805805A;
	Fri,  3 May 2024 11:49:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3695F58054;
	Fri,  3 May 2024 11:49:56 +0000 (GMT)
Received: from [9.179.22.4] (unknown [9.179.22.4])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 May 2024 11:49:55 +0000 (GMT)
Message-ID: <bbad86b5-b28f-4b47-8f53-cfc0af5b183e@linux.ibm.com>
Date: Fri, 3 May 2024 17:19:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-pci: Fix EEH failure on ppc after subsystem reset
Content-Language: en-US
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, axboe@fb.com,
        hch@lst.de, Sagi Grimberg <sagi@grimberg.me>,
        Gregory Joyce <gjoyce@ibm.com>
References: <20240408102726.443206-1-nilay@linux.ibm.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240408102726.443206-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OrZTITXJgn3D23UvXwr73qTuI5GcPzpx
X-Proofpoint-GUID: OrZTITXJgn3D23UvXwr73qTuI5GcPzpx
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_07,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030085


On 4/8/24 15:56, Nilay Shroff wrote:
> If the nvme subsyetm reset causes the loss of communication to the nvme
> adapter then EEH could potnetially recover the adapter. The detection of
> comminication loss to the adapter only happens when the nvme driver
> attempts to read an MMIO register.
> 
> The nvme subsystem reset command writes 0x4E564D65 to NSSR register and
> schedule adapter reset.In the case nvme subsystem reset caused the loss
> of communication to the nvme adapter then either IO timeout event or
> adapter reset handler could detect it. If IO timeout event could detect
> loss of communication then EEH handler is able to recover the communication
> to the adapter. This change was implemented in commit 651438bb0af5
> ("nvme-pci: Fix EEH failure on ppc"). However if the adapter communication
> loss is detected during nvme reset work then EEH is unable to successfully
> finish the adapter recovery.
> 
> This patch ensures that,
> - nvme reset work can observer pci channel is offline (at-least on the
>   paltfrom which supports EEH recovery) after a failed MMIO read and
>   contains reset work forward progress and marking controller state to
>   DEAD. Thus we give a fair chance to EEH handler to recover the nvme
>   adapter.
> 
> - if pci channel "frozen" error is detected while controller is already
>   in the RESETTING state then don't try (re-)setting controller state to
>   RESETTING which would otherwise obviously fail and we may prematurely
>   breaks out of the EEH recovery handling.
> 
> - if pci channel "frozen" error is detected while reset work is in progress
>   then wait until reset work is finished before proceeding with nvme dev
>   disable. This would ensure that the reset work doesn't race with the
>   pci error handler code and both error handler and reset work forward
>   progress without blocking.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Changes from v1:
>   - Allow a controller to reset from a connecting state (Keith)
> 
>   - Fix race condition between reset work and pci error handler 
>     code which may contain reset work and EEH recovery from 
>     forward progress (Keith)
> 
>  drivers/nvme/host/core.c |  1 +
>  drivers/nvme/host/pci.c  | 19 ++++++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 27281a9a8951..b3fe1a02c171 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -557,6 +557,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>  		switch (old_state) {
>  		case NVME_CTRL_NEW:
>  		case NVME_CTRL_LIVE:
> +		case NVME_CTRL_CONNECTING:
>  			changed = true;
>  			fallthrough;
>  		default:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8e0bb9692685..553bf0ec5f5c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2776,6 +2776,16 @@ static void nvme_reset_work(struct work_struct *work)
>   out_unlock:
>  	mutex_unlock(&dev->shutdown_lock);
>   out:
> +	/*
> +	 * If PCI recovery is ongoing then let it finish first
> +	 */
> +	if (pci_channel_offline(to_pci_dev(dev->dev))) {
> +		if (nvme_ctrl_state(&dev->ctrl) == NVME_CTRL_RESETTING ||
> +			nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> +			dev_warn(dev->ctrl.device, "Let pci error recovery finish!\n");
> +			return;
> +		}
> +	}
>  	/*
>  	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
>  	 * may be holding this pci_dev's device lock.
> @@ -3295,10 +3305,13 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>  	case pci_channel_io_frozen:
>  		dev_warn(dev->ctrl.device,
>  			"frozen state error detected, reset controller\n");
> -		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> -			nvme_dev_disable(dev, true);
> -			return PCI_ERS_RESULT_DISCONNECT;
> +		if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
> +			if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> +				nvme_dev_disable(dev, true);
> +				return PCI_ERS_RESULT_DISCONNECT;
> +			}
>  		}
> +		flush_work(&dev->ctrl.reset_work);
>  		nvme_dev_disable(dev, false);
>  		return PCI_ERS_RESULT_NEED_RESET;
>  	case pci_channel_io_perm_failure:
A gentle ping... Can I get some feedback?
For reference, link to first version of the patch is here: https://lore.kernel.org/all/20240209050342.406184-1-nilay@linux.ibm.com/

Thanks,
--Nilay
