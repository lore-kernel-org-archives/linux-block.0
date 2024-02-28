Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC30312C520
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119212; cv=none; b=MgrU5jBgxoUONY8UlGEZ4lNex5WPIaFrwx79IWy663Ot61mksb1Yy527SrYtpFL0XFet7CwjUC+FCLP4kPKllKJuoAE66rf/vc+O3amGlk0aJp0fHn2EqtCsO9m54M7zCZblGNSETNow6fZI75SbwUWwxCKWRjQC7R4QlbjV+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119212; c=relaxed/simple;
	bh=LyzpgWt0XKoC6TKWK9DEvLeuSyihEd6F5x4O3qak8S4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dSPxZDH7dSEIBe+tO9t4DH5Kzn0qJNvuXHn96b8JTsB+poIKnhTmsmSd+ZuxazMW2ZEvqDHuevu1uPVuJRsQn90b5415Jo5T9wbCV7tHqX88vjyK+9A+IAwGIpP6q4YmOVg0mM1wnLSgKtqPjueSK+S+yUYS2p3OdL85U9bdBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FXg2Jo6A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FXg2Jo6A"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SALsbK004130;
	Wed, 28 Feb 2024 11:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LbC6SRU4uCRRnksGzrXKfhWWPyPIfWqw4ijilPNIA5I=;
 b=FXg2Jo6AxZiFPAPhrmWkaq4/PN80ZzPpbwuACAwPfRU39zNq7V1d34jYUsuDAjm2HMu1
 jOaPwcJhknNPp0mz/1Br4pjt7akFsU9BKpbzN/a0qpJfDZM/iK8OqVjvHTTxv1DelM1M
 XotXDeXIeW0HSAL3Gq7jRtPCgZqcQxZVQZCG+JPYX6soIfpoAdGX0uuBYm2i9FJfBKSX
 H7P5ilhgEtQ6CO389mwYPRW5D+7Z2YG86c/uCmnNFm1+esunhxOnzVVi/QpInpUS/0jz
 DzbYf7IXcNnByfy5hDgoRhVPfx3MXgCOSFahmdF8pObZNcrlsOJ/T2omOAEzdrhOFr7n +w== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj30w1k45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 11:19:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41SA50lM012371;
	Wed, 28 Feb 2024 11:19:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg2desd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 11:19:57 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41SBJt1D33947986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 11:19:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FF0658055;
	Wed, 28 Feb 2024 11:19:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E10F5804B;
	Wed, 28 Feb 2024 11:19:52 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 11:19:52 +0000 (GMT)
Message-ID: <07b92c25-d0dd-455c-8fb9-a4f2709677ba@linux.ibm.com>
Date: Wed, 28 Feb 2024 16:49:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gjoyce@linux.ibm.com
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zd4p_E8cPFpr1M--@kbusch-mbp>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Zd4p_E8cPFpr1M--@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rXZZebUGSjYOaPnZWxjcF7M1IGvkYdz6
X-Proofpoint-GUID: rXZZebUGSjYOaPnZWxjcF7M1IGvkYdz6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280089



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
> 
Yes you're correct. We require pcie hotplugging to recover. However powerpc EEH 
handler could able to recover the pcie adapter without physically removing and 
re-inserting the adapter or in another words, it could reset adapter without 
hotplug activity. In fact, powerpc EEH could isolate pcie slot and resets it 
(i.e. resetting the PCI device holding the PCI #RST line high for two seconds), 
followed by setting up the device config space (the base address registers 
(BAR's), latency timer, cache line size, interrupt line, and so on). 

You may find more information about EEH recovery here: 
https://www.kernel.org/doc/Documentation/powerpc/eeh-pci-error-recovery.txt

Typically when pcie error is detected and the EEH is able to recover the device, 
the EEH handler code goes through below sequence (assuming driver is EEH aware):

eeh_handle_normal_event()
  eeh_set_channel_state()-> set state to pci_channel_io_frozen 
     eeh_report_error() 
       nvme_error_detected() -> channel state "pci_channel_io_frozen"; returns PCI_ERS_RESULT_NEED_RESET
         eeh_slot_reset() -> recovery successful 
           nvme_slot_reset() -> returns PCI_ERS_RESULT_RECOVERED
             eeh_set_channel_state()-> set state to pci_channel_io_normal
               nvme_error_resume()

In case pcie erorr is detected and the EEH is unable to recover the device,
the EEH handler code goes through the below sequence:

eeh_handle_normal_event()
  eeh_set_channel_state()-> set state to pci_channel_io_frozen
    eeh_report_error()
      nvme_error_detected() -> channel state pci_channel_io_frozen; returns PCI_ERS_RESULT_NEED_RESET
        eeh_slot_reset() -> recovery failed
          eeh_report_failure()
            nvme_error_detected()-> channel state pci_channel_io_perm_failure; returns PCI_ERS_RESULT_DISCONNECT
              eeh_set_channel_state()-> set state to pci_channel_io_perm_failure
                nvme_remove()

                                           
If we execute the command "nvme subsystem-reset ..." and adapter communication is
lost then in the current code (under nvme_reset_work()) we simply disable the device
 and mark the controller DEAD. However we may have a chance to recover the controller 
if driver is EEH aware and EEH recovery is underway. We already handle one such case 
in nvme_timeout(). So this patch ensures that if we fall through nvme_reset_work() 
post subsystem-reset and the EEH recovery is in progress then we give a chance to the
EEH mechanism to recover the adapter. If in case the EEH recovery is unsuccessful then
we'd anyway fall through code path I mentioned above where we invoke nvme_remove() at 
the end and delete the erring controller.

With the proposed patch, we find that EEH recovery is successful post subsystem-reset. 
Please find below the relevant output:
# lspci 
0524:28:00.0 Non-Volatile memory controller: KIOXIA Corporation NVMe SSD Controller CM7 2.5" (rev 01)

# nvme list-subsys
nvme-subsys0 - NQN=nqn.2019-10.com.kioxia:KCM7DRUG1T92:7DQ0A01206N3
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
               iopolicy=numa
\
 +- nvme0 pcie 0524:28:00.0 live

# nvme subsystem-reset /dev/nvme0

# nvme list-subsys
nvme-subsys0 - NQN=nqn.2019-10.com.kioxia:KCM7DRUG1T92:7DQ0A01206N3
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
               iopolicy=numa
\
 +- nvme0 pcie 0524:28:00.0 resetting

[10556.034082] EEH: Recovering PHB#524-PE#280000
[10556.034108] EEH: PE location: N/A, PHB location: N/A
[10556.034112] EEH: Frozen PHB#524-PE#280000 detected
[10556.034115] EEH: Call Trace:
[10556.034117] EEH: [c000000000051068] __eeh_send_failure_event+0x7c/0x15c
[10556.034304] EEH: [c000000000049bcc] eeh_dev_check_failure.part.0+0x27c/0x6b0
[10556.034310] EEH: [c008000004753d3c] nvme_pci_reg_read32+0x80/0xac [nvme]
[10556.034319] EEH: [c0080000045f365c] nvme_wait_ready+0xa4/0x18c [nvme_core]
[10556.034333] EEH: [c008000004754750] nvme_dev_disable+0x370/0x41c [nvme]
[10556.034338] EEH: [c008000004757184] nvme_reset_work+0x1f4/0x3cc [nvme]
[10556.034344] EEH: [c00000000017bb8c] process_one_work+0x1f0/0x4f4
[10556.034350] EEH: [c00000000017c24c] worker_thread+0x3bc/0x590
[10556.034355] EEH: [c00000000018a87c] kthread+0x138/0x140
[10556.034358] EEH: [c00000000000dd58] start_kernel_thread+0x14/0x18
[10556.034363] EEH: This PCI device has failed 1 times in the last hour and will be permanently disabled after 5 failures.
[10556.034368] EEH: Notify device drivers to shutdown
[10556.034371] EEH: Beginning: 'error_detected(IO frozen)'
[10556.034376] PCI 0524:28:00.0#280000: EEH: Invoking nvme->error_detected(IO frozen)
[10556.034379] nvme nvme0: frozen state error detected, reset controller
[10556.102654] nvme 0524:28:00.0: enabling device (0000 -> 0002)
[10556.103171] nvme nvme0: PCI recovery is ongoing so let it finish
[10556.142532] PCI 0524:28:00.0#280000: EEH: nvme driver reports: 'need reset'
[10556.142535] EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'need reset'
[...]
[...]
[10556.148172] EEH: Reset without hotplug activity
[10558.298672] EEH: Beginning: 'slot_reset'
[10558.298692] PCI 0524:28:00.0#280000: EEH: Invoking nvme->slot_reset()
[10558.298696] nvme nvme0: restart after slot reset
[10558.301925] PCI 0524:28:00.0#280000: EEH: nvme driver reports: 'recovered'
[10558.301928] EEH: Finished:'slot_reset' with aggregate recovery state:'recovered'
[10558.301939] EEH: Notify device driver to resume
[10558.301944] EEH: Beginning: 'resume'
[10558.301947] PCI 0524:28:00.0#280000: EEH: Invoking nvme->resume()
[10558.331051] nvme nvme0: Shutdown timeout set to 10 seconds
[10558.356679] nvme nvme0: 16/0/0 default/read/poll queues
[10558.357026] PCI 0524:28:00.0#280000: EEH: nvme driver reports: 'none'
[10558.357028] EEH: Finished:'resume'
[10558.357035] EEH: Recovery successful.

# nvme list-subsys
nvme-subsys0 - NQN=nqn.2019-10.com.kioxia:KCM7DRUG1T92:7DQ0A01206N3
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:41528538-e8ad-4eaf-84a7-9c552917d988
               iopolicy=numa
\
 +- nvme0 pcie 0524:28:00.0 live


Thanks,
--Nilay
