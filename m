Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705EA1BE229
	for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822577; cv=none; b=qHjFw69aMChxp4R6XuqonTsre837+M0BMwovU+EL2d41bIDGuWYMgDCoeo23H9tUn0nJKBCI+5/9eakoetUQfTd+mqUGwSGIJWg0KC5INTjzmWAldjPO/4BOfZVoMg2qkgt7ALviAiAOJ0Wh6C4EnianyIfks7lTFZD07nYI7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822577; c=relaxed/simple;
	bh=Fl5uMslt95NSlCrlKFlziJrwl0kxK+QWnUdW7fry2ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOHgubIvM/7yC0+xZ5T68494t7XvjomtHowrPLnGON8k7io+XKGVx+aJs9F0VXd3vKqkHQtGNCKohO6HWNLV8EnQ8o/1kbBOtcyW+BhNMUWcYZTCOi7IEUxftevEDhxJHJTwEPZX7YoB1mwKzwFZIDlKYPubwQKFV4XpWu2Z7+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sw3UY1ZO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sw3UY1ZO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G0FGJS000465;
	Fri, 16 Aug 2024 15:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=ej+lIwJNZUCcRpoKoV9M72my1L
	9cCbIiRvwm5vpCYjo=; b=Sw3UY1ZOgVoZHgzbU3HITx7vUOkm2GzIBqK5T+QPrJ
	EPhMMfB1FpaV3Ip8flYVfF/LAJfRi1EJI2wI3EUwhVkIQiAnPbPiqg8rlgdZxNfv
	Yk43ir6hcguUqn+KD7D8izl+cjzxgAcOpST0tOrUM3Bw8J1p0kW8yZKz4FuI0dma
	iRxhKlZARapf/gzb8VV2BxlGeeaHf81dOq8Cj9IBIdYnNZ20FyYqNuUpiJCj/luB
	VgUooPGNwCUiM9UWCP18KDr64KJQ9YtUmePyYfn+WZ4zTZ8hhD7woyz+iFixpy8E
	ndS1kvY8omk7XNNi0weZkeHFNVjUu+QAuk+UuZCF2acQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111j619s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 15:36:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47GBwhUT015321;
	Fri, 16 Aug 2024 15:36:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xm1n45b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 15:36:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47GFZw3e62063074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 15:36:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66F7558059;
	Fri, 16 Aug 2024 15:35:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F030958055;
	Fri, 16 Aug 2024 15:35:57 +0000 (GMT)
Received: from ltcever58-lp2.aus.stglabs.ibm.com (unknown [9.40.195.162])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Aug 2024 15:35:57 +0000 (GMT)
From: gjoyce@linux.ibm.com
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, msuchanek@suse.de, jonathan.derrick@linux.dev,
        gjoyce@linux.ibm.com
Subject: [PATCH 0/1] add ioctl IOC_OPAL_SET_SID_PW
Date: Fri, 16 Aug 2024 10:35:56 -0500
Message-ID: <20240816153557.11734-1-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IWXsFT-Lm4LU-DqF54DPi1xEBfxqRoeC
X-Proofpoint-GUID: IWXsFT-Lm4LU-DqF54DPi1xEBfxqRoeC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_09,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=514
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408160111

From: Greg Joyce <gjoyce@linux.ibm.com>

After a SED drive is provisioned, there is no way to change the SID
password via the ioctl() interface. A new ioctl IOC_OPAL_SET_SID_PW
will allow the password to be changed. The valid current password is
required.

Greg Joyce (1):
  block: sed-opal: add ioctl IOC_OPAL_SET_SID_PW

 block/sed-opal.c              | 26 ++++++++++++++++++++++++++
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  1 +
 3 files changed, 28 insertions(+)

-- 
gjoyce@linux.ibm.com

