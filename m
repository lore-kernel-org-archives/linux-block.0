Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982821B6541
	for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954217; cv=none; b=sCEChAEOkp2ze095SrqcX7Vm4uVICAEjSCVpK1jIZaV21tjsLVPbvBhMcrtxV+1utOTuVombKcyiYVRBHyWsABrDE3ReK1rEgeCCnbdUVjfPvDQVASyzVvOqt8Sp+X1VBA74nUUjGUxnWuh/EJeSilcqoJ1GyBilEWjlqkKyCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954217; c=relaxed/simple;
	bh=T5beP7U4pwqXl7rreG0I6Q3uN0h5/Dj1lgMrcIAhiuw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iY/qG/HqFixC7L6vVfTfMAEbBG4AzwcrGzxtAkTcEYBoG/BagaZ38SfdtufDfojGtHymSno+rB/ltkk1Br5SKoanvMiOhWFtEUmxqOD1+i6GMCjA6Z8o4TtfyCn6VHimdsaGmoYZr2OAudGlhczAkrFJzU3iewOrdzAchIJjNBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EVh/i7rl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EVh/i7rl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47THePox010352;
	Thu, 29 Aug 2024 17:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pp1; bh=BwsQUv1/9EtCG
	1XQtQ15dhTykImrHC/iXRGwyrsNkPM=; b=EVh/i7rlzIwrkMIH10ddPQNAzfe0F
	nQNRwV673IBOIL2CdzjbXUUF+L82JXhYPdBhAF9Mz2vW5O9CUc8wZz5fKi0aAJAa
	tcODHmYwibpLPk8eCdAhnNfdqdcIaffirAVCWsU76TG3c22q967DUAItxPTRFflg
	2ztn3J9Pstc9l0sMlpobQoH/DtdkrYAsive6WWWQe7kg3PX6gIO3MSmlX8TvqDkH
	YVFo582O8PrFaC6ug09FIj9IQuT4I4HN26TXWOrQpO4QXAa65FbDpKb9cdD707wE
	OOrw9mhkJR2vMGnoYMmQzKQ1f7Wkh3GXZiZZRpuMMzEolbN1fyMc1EdJA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8u99hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 17:56:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47THYHkR021748;
	Thu, 29 Aug 2024 17:56:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 417suup61s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 17:56:41 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47THue9l28836386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 17:56:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D00A858088;
	Thu, 29 Aug 2024 17:56:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A21B5808A;
	Thu, 29 Aug 2024 17:56:39 +0000 (GMT)
Received: from ltcever58-lp2.aus.stglabs.ibm.com (unknown [9.40.195.162])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Aug 2024 17:56:39 +0000 (GMT)
From: gjoyce@linux.ibm.com
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, msuchanek@suse.de, jonathan.derrick@linux.dev,
        gjoyce@linux.ibm.com, dwagner@suse.de
Subject: [PATCH v2 0/1] add ioctl IOC_OPAL_SET_SID_PW
Date: Thu, 29 Aug 2024 12:56:10 -0500
Message-ID: <20240829175639.6478-1-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DA0--q4723FGkZIUe5DpPByhxzWflmY1
X-Proofpoint-ORIG-GUID: DA0--q4723FGkZIUe5DpPByhxzWflmY1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290125

From: Greg Joyce <gjoyce@linux.ibm.com>

This version does not reflect any code changes since there have
been no comments on the patchset since the original submission
on 13 Aug 2024.

As requersted, it does contain an expanded description of the
patchset and a pointer to the CLI change. Thanks
to Daniel Wagner and Michal Suchánek for the feedback.

SED Opal allows a password for the SID user as well as the Admin1
user. If a CLI wishes to change the password of both users there
is currently no way to accomplish that using the SED Opal block
driver ioctls. The Admin1 password can be changes using the 
IOC_OPAL_SET_PW ioctl but the SID password remains the password
that was set when the SED drive was provisioned (ownership).

To allow a CLI to change the SID password, a new ioctl
IOC_OPAL_SET_SID_PW has been created. The valid current password is
required to change the SID password.

The nvme-cli has been changed to use this ioctl such that the
"sed password" can change both the Admin1 and SID passwords.
The pull request can be found here:
	https://github.com/linux-nvme/nvme-cli/pull/2467

Greg Joyce (1):
  block: sed-opal: add ioctl IOC_OPAL_SET_SID_PW

 block/sed-opal.c              | 26 ++++++++++++++++++++++++++
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  1 +
 3 files changed, 28 insertions(+)

-- 
gjoyce@linux.ibm.com

