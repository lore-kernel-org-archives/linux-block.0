Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02026B2D5;
	Mon, 28 Apr 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745847767; cv=none; b=ZTuv2ucrPcaN62oXJbrUEMV3/NKS+g2a2FqdyBB4sDXrc7p1MNl8wXMcZhvA5vJ//3H2i/J79IOXr5GFgEn7shE9J0ob0f2ET65hmZ2fduxnuscG8KYe+bi3TPTVwchd4pdMHqBBR3UmM2PWDnh2EGwjYgCxm1hyU1my4qsx/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745847767; c=relaxed/simple;
	bh=FIKyWc+Yvk0BpBifXACwV2bCdwa6VpH+62R22TcYc94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujXOWkhlMrQHywXvxqhC2C/1crC91sMSdGBR5kgGAp8fatATvX/n7MepO6SQZO/I65/zyfstXlK63jCYPkw0AP7W1UBTqTCTqUk1MjnIRcQ+olxugrvNaX2fgx40evcdpypRGlhjweasY2nMjzRvCZ3bX5SKAH8Ql7os4SBR6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SBaCEk006090;
	Mon, 28 Apr 2025 13:42:35 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 468mq1b2ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Apr 2025 13:42:35 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 28 Apr 2025 06:42:34 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 28 Apr 2025 06:42:32 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <hch@infradead.org>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ming.lei@redhat.com>,
        <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V3] loop: Add sanity check for read/write_iter
Date: Mon, 28 Apr 2025 21:42:31 +0800
Message-ID: <20250428134231.3215496-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aA95UNX_BHq7GtP9@infradead.org>
References: <aA95UNX_BHq7GtP9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KsNN2XWN c=1 sm=1 tr=0 ts=680f85cb cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=H60z1jf0Lm91z7guYCEA:9
X-Proofpoint-ORIG-GUID: 3xExEZZ5NWd4UOkrQgLqll8_gfh7sH8f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDExMyBTYWx0ZWRfX+ZRYA2+iAtxE HUDnZajWbnrpJb+tbCj4xWeel3DB2K+LtXBJZ9wPfEV+N7y+bxclpOASLZMT5NmTwIPkRIimB9p FLeMtFLG1TML9B5BiY0CZ7uuz00Wn23zzXu6U4kzvdp+0VSlDN3+j4SRoHamTl/2iyXM2mStTpZ
 AWE/JimMLdJCScZcxopqm4p9FBu+Cuit8XrEuTHGpzcRNkTO8rqYgvaqp/TplbYbyhNscFitQ9H MlMbm0GUiG4m+/xlB/++yQWdykQnpH/zQrRznBub4arxkH9s4bG0KxdILqqCxKeV8Ltrp/VZ1bF 8bnEDx93EoPbL0C9nTR7OVYwjKjUsP7xtb/a8kvCRZ5b0So/MNRlUxBdB6xZem60NY48lI+Wcc7
 oG7c+bgh6Maq93Qn/vbZMMNPYm/cqpKqo6NlYMncF2vY7WqE1HcxfTAv3ChFQnvSvZwbAX3N
X-Proofpoint-GUID: 3xExEZZ5NWd4UOkrQgLqll8_gfh7sH8f
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=697 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504280113

On Mon, 28 Apr 2025 05:49:20 -0700, Christoph Hellwig wrote:
> > +static int loop_check_backing_file(struct file *file, blk_mode_t mode, bool change)
> > +{
> > +	if (!file->f_op->read_iter)
> > +		return -EINVAL;
> > +
> > +	if (((file->f_mode & FMODE_WRITE) ||
> > +	     (!change && (mode & BLK_OPEN_WRITE))) &&
> > +	    (!file->f_op->write_iter))
> > +		return -EINVAL;
> 
> This looks a bit odd.  Both callers have the open struct file, so
> we should be able to check f_mode for both cases and not need the
> change flag as far as I can tell.  Or did I miss something/
Changing flags? What are you talking about?
This patch is to fix filesystems that are missing read_iter or wirte_iter
support.
> 
> If for some reason we could not pass the fmode, the helper is
> probably not all that useful.
The helper function does not pass fmode, but passes 'blk_mode_t mode',
because it is used when executing LOOP_SET_FD or LOOP_CONFIGURE, but not
when executing LOOP_CHANGE_FD.
I think the purpose of this helper function is just to facilitate code
management and facilitate similar problems later.
