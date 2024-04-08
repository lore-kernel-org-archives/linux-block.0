Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD93755C07
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572284; cv=none; b=IEsWxNsEc7odCquHzL50TtrQdJS2lwpWp+qEzd1lIIDW1bN87kuEdnS3sbzD5x2jogz/DjcbYiSIaYCQeTvSBj76lqWJWN3r5PBzZwmnu0nMQQ99z1ShGPqRSQJPVxPaOBpalF4nWlDJlxY5OOsRqCWwckTQQLO+cGT2HV5M4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572284; c=relaxed/simple;
	bh=GK0UC2dnWbJLH/bBaJQYK33x/tdTTgPCJaJ3N911K+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+jnXshY4HdqMABpQVjuEdKQQo5dmVtxaMG/UDyY2PRI56qIHBLotVcqmrf9Pl45HCkSQN1T0X2djruLITaQaAECSVmypUR44c7vR2+ak6O5FSXfInsqS58SyidX1Ub1IPoMzdDpb4OfRFVTC1N5b56RyuMKQParHmF0bl6TwjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n5aZ3q91; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n5aZ3q91"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4389tCTH028664;
	Mon, 8 Apr 2024 10:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=M5pDYCzyy4wlFKA//uN4vmqtN66ksvh0eaQquzYrdAQ=;
 b=n5aZ3q91iAliyZqQGAYLFs7rMdQf6z7Gek8boOT+dpxeCaw7TprHjoJ3HelzbYu7AHFM
 HyGT4rDgFA+lZMgHr3SwCOV/IHOK6stRRpqvLPm+G0kihcQu1RxB/m4/xWx5QN0b2pub
 vKQrEKRhc9SjpOuy9YNI1zfec+cOEWMhv6Acz/oW/6SXvL5wEBQcHolaYuPxldOtuCp/
 J637tfDsD4+nG2mDGfd4j1mf/efa3F+hwrMoIi9QRh4pGHUyJCBONjkbhUY6X5IYBDgI
 vdgLCy2y9mVbmPNwEG9bZwUkzbti0NeNvoodxYdhwK941XFv+UmN05OJW3ijHhZ5+Zbr Lg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xcec5r2dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:31:11 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4388s1US029907;
	Mon, 8 Apr 2024 10:27:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbj7kye1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:27:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 438ARUV749283522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 10:27:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6C4420043;
	Mon,  8 Apr 2024 10:27:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E54EC20040;
	Mon,  8 Apr 2024 10:27:28 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.231])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Apr 2024 10:27:28 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, axboe@fb.com,
        hch@lst.de, gjoyce@ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2] nvme-pci: Fix EEH failure on ppc after subsystem reset
Date: Mon,  8 Apr 2024 15:56:29 +0530
Message-ID: <20240408102726.443206-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vNwklh-bpLM3hj7u5SzMirLLgCPdkfKW
X-Proofpoint-GUID: vNwklh-bpLM3hj7u5SzMirLLgCPdkfKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_08,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080080

If the nvme subsyetm reset causes the loss of communication to the nvme
adapter then EEH could potnetially recover the adapter. The detection of
comminication loss to the adapter only happens when the nvme driver
attempts to read an MMIO register.

The nvme subsystem reset command writes 0x4E564D65 to NSSR register and
schedule adapter reset.In the case nvme subsystem reset caused the loss
of communication to the nvme adapter then either IO timeout event or
adapter reset handler could detect it. If IO timeout event could detect
loss of communication then EEH handler is able to recover the communication
to the adapter. This change was implemented in commit 651438bb0af5
("nvme-pci: Fix EEH failure on ppc"). However if the adapter communication
loss is detected during nvme reset work then EEH is unable to successfully
finish the adapter recovery.

This patch ensures that,
- nvme reset work can observer pci channel is offline (at-least on the
  paltfrom which supports EEH recovery) after a failed MMIO read and
  contains reset work forward progress and marking controller state to
  DEAD. Thus we give a fair chance to EEH handler to recover the nvme
  adapter.

- if pci channel "frozen" error is detected while controller is already
  in the RESETTING state then don't try (re-)setting controller state to
  RESETTING which would otherwise obviously fail and we may prematurely
  breaks out of the EEH recovery handling.

- if pci channel "frozen" error is detected while reset work is in progress
  then wait until reset work is finished before proceeding with nvme dev
  disable. This would ensure that the reset work doesn't race with the
  pci error handler code and both error handler and reset work forward
  progress without blocking.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v1:
  - Allow a controller to reset from a connecting state (Keith)

  - Fix race condition between reset work and pci error handler 
    code which may contain reset work and EEH recovery from 
    forward progress (Keith)

 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/pci.c  | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 27281a9a8951..b3fe1a02c171 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -557,6 +557,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
+		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;
 		default:
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685..553bf0ec5f5c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2776,6 +2776,16 @@ static void nvme_reset_work(struct work_struct *work)
  out_unlock:
 	mutex_unlock(&dev->shutdown_lock);
  out:
+	/*
+	 * If PCI recovery is ongoing then let it finish first
+	 */
+	if (pci_channel_offline(to_pci_dev(dev->dev))) {
+		if (nvme_ctrl_state(&dev->ctrl) == NVME_CTRL_RESETTING ||
+			nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+			dev_warn(dev->ctrl.device, "Let pci error recovery finish!\n");
+			return;
+		}
+	}
 	/*
 	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
 	 * may be holding this pci_dev's device lock.
@@ -3295,10 +3305,13 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
-		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
-			nvme_dev_disable(dev, true);
-			return PCI_ERS_RESULT_DISCONNECT;
+		if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
+			if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+				nvme_dev_disable(dev, true);
+				return PCI_ERS_RESULT_DISCONNECT;
+			}
 		}
+		flush_work(&dev->ctrl.reset_work);
 		nvme_dev_disable(dev, false);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
-- 
2.44.0

