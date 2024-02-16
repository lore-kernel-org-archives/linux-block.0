Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0091420B8
	for <linux-block@vger.kernel.org>; Fri, 16 Feb 2024 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117480; cv=none; b=bxOoBDRVqrWMkr1IWBsTsZsN49Ff30Ep5yvj8V218VtVRDwVS6jC7DKH088FyHOZCTm0CFHtskj/s+w2CvH6SihKmBzWLJEbwX3jWA1AXFA0P2cgYo79owliRoBIyOjPlbTkjyCHzWfIGwKCeC7k1EUYQks1DyGhq+6UtzVRcQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117480; c=relaxed/simple;
	bh=yPaSk1y0GzHMQFuvfgN1VIIeDC16NnnYmpG8kqPXAfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQvXyxnRC+6auKkCB5Aw9CTlehjauQa59V9GOxi7sOzsE31fIeZk644xHhWV8SAuYiNX0CS49uqk9EZUiuqsAx2B9+IwQHcu3YGNq/Mip1wJt49mEJZKAAUQqM/Kvm9JT7AOGuRk7MV03FwCI91Eec25uqaym25jPm6eUD8oXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h0/d2x9j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h0/d2x9j"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GL1gcd012800;
	Fri, 16 Feb 2024 21:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wlyRXKk2BFhRtdTmKHnI6pFbVH88tVkXO++58IIwfvc=;
 b=h0/d2x9joEbxaKP+sEXvWmlZY9zqkx362lkO2BsiBoO/OPe69wDUzqmORupnKL9YpYup
 /CVbNr1pUpMLVFAz4syVd8BDFfE5b6kCn9jsP0YwzWY/Ff0Lc3J9FCu/cgCdukQh2ek5
 EkTFGsZlH0tSHgvfVlhK9uD7D1KIW21qcoCrgm5ZsVWaUhjcZxHplzAJNyvCkB90SiTx
 6BJtgWqESQ7NjOnL+htxaIm1szbD7bEbIg9p721gVMEEP7gHjilwF6YKmobv6x6+5075
 CwlTePWDqqXe7HOpjhU1F9D8KvM6P9BSljorWu+0VKWUgBOAXR23wu37gvGIyNfJr6Zi mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wadh1218y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:04:23 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GL4NER020396;
	Fri, 16 Feb 2024 21:04:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wadh1218r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:04:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GJwS2N010045;
	Fri, 16 Feb 2024 21:04:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npmdcnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:04:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GL4Ixl59703776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:04:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 248D05806C;
	Fri, 16 Feb 2024 21:04:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01B6458068;
	Fri, 16 Feb 2024 21:04:18 +0000 (GMT)
Received: from rhel-laptop.ibm.com.com (unknown [9.61.109.190])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 21:04:17 +0000 (GMT)
From: gjoyce@linux.ibm.com
To: linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, brking@linux.ibm.com, msuchanek@suse.de,
        axboe@kernel.dk, akpm@linux-foundation.org, gjoyce@linux.ibm.com,
        okozina@redhat.com, hch@lst.de, dwagner@suse.de
Subject: [PATCH 1/1] block: sed-opal: handle empty atoms when parsing response
Date: Fri, 16 Feb 2024 15:04:17 -0600
Message-Id: <20240216210417.3526064-2-gjoyce@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240216210417.3526064-1-gjoyce@linux.ibm.com>
References: <20240216210417.3526064-1-gjoyce@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NpysPU6H06SEAPKGx3-_4xdgibzR3315
X-Proofpoint-GUID: EYIFhrwcm9b3KWdBzy0z8foLyHLsLSgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=922
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160165

From: Greg Joyce <gjoyce@linux.ibm.com>

The SED Opal response parsing function response_parse() does not
handle the case of an empty atom in the response. This causes
the entry count to be too high and the response fails to be
parsed. Recognizing, but ignoring, empty atoms allows response
handling to succeed.

Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
---
 block/opal_proto.h | 1 +
 block/sed-opal.c   | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index dec7ce3a3edb..d247a457bf6e 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -71,6 +71,7 @@ enum opal_response_token {
 #define SHORT_ATOM_BYTE  0xBF
 #define MEDIUM_ATOM_BYTE 0xDF
 #define LONG_ATOM_BYTE   0xE3
+#define EMPTY_ATOM_BYTE  0xFF
 
 #define OPAL_INVAL_PARAM 12
 #define OPAL_MANUFACTURED_INACTIVE 0x08
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 3d9e9cd250bd..fa4dba5d8531 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1056,16 +1056,20 @@ static int response_parse(const u8 *buf, size_t length,
 			token_length = response_parse_medium(iter, pos);
 		else if (pos[0] <= LONG_ATOM_BYTE) /* long atom */
 			token_length = response_parse_long(iter, pos);
+		else if (pos[0] == EMPTY_ATOM_BYTE) /* empty atom */
+			token_length = 1;
 		else /* TOKEN */
 			token_length = response_parse_token(iter, pos);
 
 		if (token_length < 0)
 			return token_length;
 
+		if (pos[0] != EMPTY_ATOM_BYTE)
+			num_entries++;
+
 		pos += token_length;
 		total -= token_length;
 		iter++;
-		num_entries++;
 	}
 
 	resp->num = num_entries;
-- 
gjoyce@linux.ibm.com

