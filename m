Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8210A05
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 21:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635734; cv=none; b=WeRIvyW+8e8nWI5tVYMTvFaei8wj7QEFUMxrxuRPUifGSY9wWN9u2uoKBdXH8XSgUDZzAAefbkk637pZFselqPoe5TrllMn/vEIaXOLVGP1Qbh7YaAblvka0vujDF0JkHk9WoEk6hPPf1/3N2x7sRCXTkhChcYq211wbHXvpNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635734; c=relaxed/simple;
	bh=ZwmrNSK/T1GHYFznxRefHq86thJpwxeMPqHhYLRVJJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=qUBB635CIA6t30bPEqW3THQqGfcKVsal8lE4Tnr3UaslHbFQiB0X+WEDBV3+HAxIiM8MdkwRKKxeIP605R/oLLPV7J4O859u2XbEOGneO2LhAcw7+7LpaHDSUlk0bcuYZfmQi1582Y/rApQybZS97dYIbQsuKpJ4PJaPRusJSz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DDCTiXDJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DDCTiXDJ"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MKpRXP031444;
	Thu, 22 Feb 2024 21:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=iHmgRUT9SX+zZV5/hhMnuKRLOmXEIyuIC4dh2jZnQF0=;
 b=DDCTiXDJdjokUhXZNQt5vpF9Gf7uwiI8+5bmVNBnGHjWkKMpopfNw4HslrueKXiny4gG
 xZbDUEDPAsajTSwAkifkevcW2zD1JQXm5td8wfbnfXrmIv6dIC1nRXCECIAjfw6Cw8nu
 ve9q2slU39TKW6NHn4lo1XMi8KyfnErYoUTZyH5SaYp2b1aCL6pk+v6FtJOZWWnJBG6d
 NPHZ0Hfgmk7ochLWjOGNfca0uYEYaeso8FC2symwWuCDtZIQFX+YF1g7OLE7rAvxzDqZ
 b8LwENNgioAaNKFQjjzjEcuXBvYN6e0Vhd9n1f5pC+eG8LWLL4kuaOrvTc4qYXOk3FJp Qw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wedcx8k56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 21:00:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41MKB72o017265;
	Thu, 22 Feb 2024 21:00:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmrrjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 21:00:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41ML0BQE29622738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 21:00:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A44BF5809B;
	Thu, 22 Feb 2024 21:00:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 374C458065;
	Thu, 22 Feb 2024 21:00:09 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.141.127])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Feb 2024 21:00:09 +0000 (GMT)
Message-ID: <14c739bedccbf5a4cf21cf3fec724bc17fa265b6.camel@linux.ibm.com>
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
From: Greg Joyce <gjoyce@linux.ibm.com>
Reply-To: gjoyce@linux.ibm.com
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
        Wendy Xiong
	 <wenxiong@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Date: Thu, 22 Feb 2024 15:00:08 -0600
In-Reply-To: <20240209050342.406184-1-nilay@linux.ibm.com>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rkaLANrPWZs_7kUFTmK9QCt-7wfu_52Z
X-Proofpoint-ORIG-GUID: rkaLANrPWZs_7kUFTmK9QCt-7wfu_52Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220164

On Fri, 2024-02-09 at 10:32 +0530, Nilay Shroff wrote:
> If the nvme subsyetm reset causes the loss of communication to the
> nvme
> adapter then EEH could potnetially recover the adapter. The detection
> of
> comminication loss to the adapter only happens when the nvme driver
> attempts to read an MMIO register.
> 
> The nvme subsystem reset command writes 0x4E564D65 to NSSR register
> and
> schedule adapter reset.In the case nvme subsystem reset caused the
> loss
> of communication to the nvme adapter then either IO timeout event or
> adapter reset handler could detect it. If IO timeout even could
> detect
> loss of communication then EEH handler is able to recover the
> communication to the adapter. This change was implemented in
> 651438bb0af5
> (nvme-pci: Fix EEH failure on ppc). However if the adapter
> communication
> loss is detected in nvme reset work handler then EEH is unable to
> successfully finish the adapter recovery.
> 
> This patch ensures that,
> - nvme driver reset handler would observer pci channel was offline
> after
>   a failed MMIO read and avoids marking the controller state to DEAD
> and
>   thus gives a fair chance to EEH handler to recover the nvme
> adapter.
> 
> - if nvme controller is already in RESETTNG state and pci channel
> frozen
>   error is detected then  nvme driver pci-error-handler code sends
> the
>   correct error code (PCI_ERS_RESULT_NEED_RESET) back to the EEH
> handler
>   so that EEH handler could proceed with the pci slot reset.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Note that while in this case the issue was discovered via the Power EEH
handler, this is not a Power specific issue. The problem and fix is
applicable to all architectures.
 

> 
> [  131.415601] EEH: Recovering PHB#40-PE#10000
> [  131.415619] EEH: PE location: N/A, PHB location: N/A
> [  131.415623] EEH: Frozen PHB#40-PE#10000 detected
> [  131.415627] EEH: Call Trace:
> [  131.415629] EEH: [c000000000051078]
> __eeh_send_failure_event+0x7c/0x15c
> [  131.415782] EEH: [c000000000049bdc]
> eeh_dev_check_failure.part.0+0x27c/0x6b0
> [  131.415789] EEH: [c000000000cb665c] nvme_pci_reg_read32+0x78/0x9c
> [  131.415802] EEH: [c000000000ca07f8] nvme_wait_ready+0xa8/0x18c
> [  131.415814] EEH: [c000000000cb7070] nvme_dev_disable+0x368/0x40c
> [  131.415823] EEH: [c000000000cb9970] nvme_reset_work+0x198/0x348
> [  131.415830] EEH: [c00000000017b76c] process_one_work+0x1f0/0x4f4
> [  131.415841] EEH: [c00000000017be2c] worker_thread+0x3bc/0x590
> [  131.415846] EEH: [c00000000018a46c] kthread+0x138/0x140
> [  131.415854] EEH: [c00000000000dd58] start_kernel_thread+0x14/0x18
> [  131.415864] EEH: This PCI device has failed 1 times in the last
> hour and will be permanently disabled after 5 failures.
> [  131.415874] EEH: Notify device drivers to shutdown
> [  131.415882] EEH: Beginning: 'error_detected(IO frozen)'
> [  131.415888] PCI 0040:01:00.0#10000: EEH: Invoking nvme-
> >error_detected(IO frozen)
> [  131.415891] nvme nvme1: frozen state error detected, reset
> controller
> [  131.515358] nvme 0040:01:00.0: enabling device (0000 -> 0002)
> [  131.515778] nvme nvme1: Disabling device after reset failure: -19
> [  131.555336] PCI 0040:01:00.0#10000: EEH: nvme driver reports:
> 'disconnect'
> [  131.555343] EEH: Finished:'error_detected(IO frozen)' with
> aggregate recovery state:'disconnect'
> [  131.555371] EEH: Unable to recover from failure from PHB#40-
> PE#10000.
> [  131.555371] Please try reseating or replacing it
> [  131.556296] EEH: of node=0040:01:00.0
> [  131.556351] EEH: PCI device/vendor: 00251e0f
> [  131.556421] EEH: PCI cmd/status register: 00100142
> [  131.556428] EEH: PCI-E capabilities and status follow:
> [  131.556678] EEH: PCI-E 00: 0002b010 10008fe3 00002910 00436044
> [  131.556859] EEH: PCI-E 10: 10440000 00000000 00000000 00000000
> [  131.556869] EEH: PCI-E 20: 00000000
> [  131.556875] EEH: PCI-E AER capability register set follows:
> [  131.557115] EEH: PCI-E AER 00: 14820001 00000000 00400000 00462030
> [  131.557294] EEH: PCI-E AER 10: 00000000 0000e000 000002a0 00000000
> [  131.557469] EEH: PCI-E AER 20: 00000000 00000000 00000000 00000000
> [  131.557523] EEH: PCI-E AER 30: 00000000 00000000
> [  131.558807] EEH: Beginning: 'error_detected(permanent failure)'
> [  131.558815] PCI 0040:01:00.0#10000: EEH: Invoking nvme-
> >error_detected(permanent failure)
> [  131.558818] nvme nvme1: failure state error detected, request
> disconnect
> [  131.558839] PCI 0040:01:00.0#10000: EEH: nvme driver reports:
> 'disconnect'
> ---
>  drivers/nvme/host/pci.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c1d6357ec98a..a6ba46e727ba 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2776,6 +2776,14 @@ static void nvme_reset_work(struct work_struct
> *work)
>   out_unlock:
>  	mutex_unlock(&dev->shutdown_lock);
>   out:
> +	/*
> +	 * If PCI recovery is ongoing then let it finish first
> +	 */
> +	if (pci_channel_offline(to_pci_dev(dev->dev))) {
> +		dev_warn(dev->ctrl.device, "PCI recovery is ongoing so
> let it finish\n");
> +		return;
> +	}
> +
>  	/*
>  	 * Set state to deleting now to avoid blocking
> nvme_wait_reset(), which
>  	 * may be holding this pci_dev's device lock.
> @@ -3295,9 +3303,11 @@ static pci_ers_result_t
> nvme_error_detected(struct pci_dev *pdev,
>  	case pci_channel_io_frozen:
>  		dev_warn(dev->ctrl.device,
>  			"frozen state error detected, reset
> controller\n");
> -		if (!nvme_change_ctrl_state(&dev->ctrl,
> NVME_CTRL_RESETTING)) {
> -			nvme_dev_disable(dev, true);
> -			return PCI_ERS_RESULT_DISCONNECT;
> +		if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING)
> {
> +			if (!nvme_change_ctrl_state(&dev->ctrl,
> NVME_CTRL_RESETTING)) {
> +				nvme_dev_disable(dev, true);
> +				return PCI_ERS_RESULT_DISCONNECT;
> +			}
>  		}
>  		nvme_dev_disable(dev, false);
>  		return PCI_ERS_RESULT_NEED_RESET;


