Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2087814B838
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629652; cv=none; b=m8gHVPEVenLWdPjMWV5Eg05gqZRlrAU8zIaGR99Luhn5wMgv4EO+/0j7LlHXknbWS6smWTqBom3kauSd/JpymKwfd25MeNtJmS97xzpxbxeTGNKL/0HYZp+0Jw25O5DjKr5/PYICocGVWE05n+b2ZD0NwIKOGyZwztLRJzxYq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629652; c=relaxed/simple;
	bh=wFVrLNDEVHWAtLuyxe1k0/7IWdw0WgnMYAsOFEsnA5I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BdBafxf+4ZIazDnbfr/VS6VnN5JJs7dA6n/oospV+CY5wPXhP/XaFbTQfPQ8j093cVAOltc7r7xWaWaczbQP9WfCoOkPKYlFDU/k7/rKAc3WwUzPuCteTIfA9OIS+B3OSONEJUMyfXhpklJOrDtDEzspnxhVYhNBn6Vm+cNdpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UpxBp7Pq; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="UpxBp7Pq"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIuwO9024346
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 11:20:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=p8qShFwhTtknzI77X44MfhyLlzFMkNuoLEZxY31tmUM=;
 b=UpxBp7PqxOCaSVxUNr80IMafvPF8X4n0BVJp1lxTa1Z0on5lqV7La7Tkt/glXMfWfP5s
 QtRwM/TaO+Kn35+4tjIdXFvEPmXAxpOkqDi3BbjEXhH1rSOWeBg37065eNJI9cWgVv6q
 8AxIVMnDzLALg7XVZYYi11X8eYqJwf2LQBnGyj7qphsyIrVywaGUEAwUvN0NMFv4rQsM
 SF+FIPOufV20z+N7wfTfOfS/9FwHize8qR7ARCkyyf9MBN8YmVdRH/o0OCOqXpToxUwg
 pnIDR0wB8xns/5pv7gNIhUazaIAV/M37C72jTpLKMchf8pCJAY9tAGcZ5hdnnn70LHpY sQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3wec0406ec-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 11:20:50 -0800
Received: from twshared5578.09.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 11:20:49 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id B02B7256D9815; Thu, 22 Feb 2024 11:20:40 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.org>, <ming.lei@redhat.com>, <nilay@linux.ibm.com>,
        <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/4] block: make long runnint operations killable
Date: Thu, 22 Feb 2024 11:19:18 -0800
Message-ID: <20240222191922.2130580-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YWh_pBaBHsjocpo-lA9f9xOxwKoz9OfS
X-Proofpoint-ORIG-GUID: YWh_pBaBHsjocpo-lA9f9xOxwKoz9OfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

Changes from v2:

  Wait for chained bio's to complete before returning from kill signal.

  Miscellaneous cleanup patches for style and consistency.

Keith Busch (4):
  block: blkdev_issue_secure_erase loop style
  block: cleanup __blkdev_issue_write_zeroes
  block: io wait hang check helper
  blk-lib: check for kill signal

 block/bio.c     | 12 +----------
 block/blk-lib.c | 57 ++++++++++++++++++++++++++++++++++++++-----------
 block/blk-mq.c  | 19 +++--------------
 block/blk.h     | 13 +++++++++++
 4 files changed, 61 insertions(+), 40 deletions(-)

--=20
2.34.1

