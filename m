Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0B18B48D
	for <linux-block@vger.kernel.org>; Wed, 25 Sep 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274016; cv=none; b=bgxd7UWUHeKHCJ3gCeR8blrQjptqRWDSRRvVBSp5ER2rWbUhEma27VGmLlwmhcJ4bv+UWA/AuQVl1XyLqeypXqqmoDley1BJCkiHTu+4DBdtxMhfUmEfWkxmj2//xIkdbrGMxiFH8q10A6zFhKYO6t7LQYkxStJn6jmvmjn/YgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274016; c=relaxed/simple;
	bh=l1sCpvtLYuSbeNJh5PG8L/QtftmDXwF2OMl87pBSvko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ka04QlZT49JqQYZNQPZPo3cp+WuQ8xTwi3i80MMcMI8D8Ekh7oPeN4t4M2dvgXVcG5E0vdiYbRaQZT52sU69kftm+tYnE6Owc97nj0RgKoggtPLoAsqnSsiMMud0ABnKGAToU/JPfMbwoE3uS0bXnV9EMjT7B9fBrs/IeKUOSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PtQvL6fK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PtQvL6fK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PD1XiS022617;
	Wed, 25 Sep 2024 14:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:reply-to:to:cc:date:in-reply-to
	:references:content-type:content-transfer-encoding:mime-version;
	 s=pp1; bh=JsL3gpgpujkygvgicHTmEKBG0+fOt0ySRyoy5v2B4e4=; b=PtQvL
	6fKyysq8kQ/8M6rgabwLHrd7sfaV3MvP3nC0D2RQ2ENtfgWlO6m6+J8LDCCSMlU3
	xhVH5swPsxPbUeMq4XKTEFE8jkgetvrxqtpT57ZJysDMjzPlo4Z3FZ/SJZTweKtN
	uM2XYSKymWbPlnFeObZua4u6E7zh4W9mc7YrZU+21cA7UdeDdIP3/Z8gjT69gb5D
	ih8k0kAVxm1/oVUPieUBexyjM9XPBwfNJ6OjlahoQnOM5nwZPNUM2PjZ/+Ejv8qz
	y0Kj+A00VKCOBiLOE7uHyCSd02JV4vLwnIe8NrTU3r/0/Qg9B/yJn2tCk/vjcdBc
	bwqo8/RO/EhxSJg9w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvb8m2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 14:19:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48PBqFKB000682;
	Wed, 25 Sep 2024 14:19:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41t8fut813-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 14:19:55 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48PEJt6736307246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 14:19:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDA1758050;
	Wed, 25 Sep 2024 14:19:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A634158045;
	Wed, 25 Sep 2024 14:19:54 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.147.165])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Sep 2024 14:19:54 +0000 (GMT)
Message-ID: <58a898bda1d1b2c1240ca329204070e8755e196a.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/1] add ioctl IOC_OPAL_SET_SID_PW
From: Greg Joyce <gjoyce@linux.ibm.com>
Reply-To: gjoyce@linux.ibm.com
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, msuchanek@suse.de, jonathan.derrick@linux.dev,
        dwagner@suse.de
Date: Wed, 25 Sep 2024 09:19:54 -0500
In-Reply-To: <20240829175639.6478-1-gjoyce@linux.ibm.com>
References: <20240829175639.6478-1-gjoyce@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mDnNj7EfHbijBU1QoEn9VBWZyLeXwg9y
X-Proofpoint-GUID: mDnNj7EfHbijBU1QoEn9VBWZyLeXwg9y
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-25_04,2024-09-25_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250098

It's been about a month with no comments. Does anyone have any feedback
on this patchset?

Thanks,
Greg

On Thu, 2024-08-29 at 12:56 -0500, gjoyce@linux.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.ibm.com>
>=20
> This version does not reflect any code changes since there have
> been no comments on the patchset since the original submission
> on 13 Aug 2024.
>=20
> As requersted, it does contain an expanded description of the
> patchset and a pointer to the CLI change. Thanks
> to Daniel Wagner and Michal Such=C3=A1nek for the feedback.
>=20
> SED Opal allows a password for the SID user as well as the Admin1
> user. If a CLI wishes to change the password of both users there
> is currently no way to accomplish that using the SED Opal block
> driver ioctls. The Admin1 password can be changes using the=20
> IOC_OPAL_SET_PW ioctl but the SID password remains the password
> that was set when the SED drive was provisioned (ownership).
>=20
> To allow a CLI to change the SID password, a new ioctl
> IOC_OPAL_SET_SID_PW has been created. The valid current password is
> required to change the SID password.
>=20
> The nvme-cli has been changed to use this ioctl such that the
> "sed password" can change both the Admin1 and SID passwords.
> The pull request can be found here:
> 	https://github.com/linux-nvme/nvme-cli/pull/2467
>=20
> Greg Joyce (1):
> =C2=A0 block: sed-opal: add ioctl IOC_OPAL_SET_SID_PW
>=20
> =C2=A0block/sed-opal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++++++++
> =C2=A0include/linux/sed-opal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0include/uapi/linux/sed-opal.h |=C2=A0 1 +
> =C2=A03 files changed, 28 insertions(+)
>=20

