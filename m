Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37341E9B15;
	Sat, 26 Apr 2025 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745632260; cv=none; b=uwIL5bRth+6Z1VVL3Fjd3xjY5pE0hikiMYTDs4E70PdUzxYB5vtKzKf9PxpB/SWsWWxH5b9vY6OjPLb/gBKFhWo8PVfFq8o6cKaZwkx4dH972C/wCL5TMKi553fdYXca31/qlIMEBbJpG4QEs0JVCZS4eCXCxInSetqym5zJf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745632260; c=relaxed/simple;
	bh=NadBSjFgNo4GUV3mjNIC/uZNOzNDIW/qt7YRgeCcP0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpJEOBO/+JN87OVqsKeuIVWjQ7sjoE8RY2RePiV7lqj8/5/Pw4EeGKyAj/v/w3jKcpX3a5VtZgXBctMPptNxP7o3XXK7kuW+rxShrWUFpFzHvREu8l+6sUO9V4S5gNJjPnYxZOor7fdMgIjEOOLoYBXuoCmLcOqZPvtKM8pAQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53Q1Zkol002804;
	Sat, 26 Apr 2025 01:50:34 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 468mq181kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 26 Apr 2025 01:50:34 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 25 Apr 2025 18:50:32 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 25 Apr 2025 18:50:29 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <hch@infradead.org>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ming.lei@redhat.com>,
        <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V2] loop: Add sanity check for read/write_iter
Date: Sat, 26 Apr 2025 09:50:28 +0800
Message-ID: <20250426015028.277421-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aAuOC8djgRrq-Gdj@infradead.org>
References: <aAuOC8djgRrq-Gdj@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KsNN2XWN c=1 sm=1 tr=0 ts=680c3bea cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=XGylfyputJtSCxGzs_QA:9
X-Proofpoint-ORIG-GUID: YOjb04-oHQdcljYWv-C0k9ydpzMW7tUv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI2MDAxMSBTYWx0ZWRfX0ndi5uA4Muzp QcUmfAOQUvHkoz2PLyZdJAlT1qbXcVvv4Qz4uxB1zzTdK2IONWjY1zf2D04DFMA005ZoUSqwPdK 3hJPvci6KRmcSTi9aXOMeZDvjtxjlExyWm7ADSsM5BHOuRFWkmQf0txQiZnAqQCs6ETTF2HzWT2
 0UnFBcB4Y0jGvi6meSvUDMXrvibOC9DifjudIGgnMhAl0TT4ZjmgcSHtSi3IXh+Ubgcqf6UIiTB 8CWVjf6AGdp8KRkCTpOQxIP1JvfsdqFavBlY/pYqX3VoE/VxWL/2iV38pEt2hCvbe9bVlkIDaw6 jsABMO1xnUU2ufs2iZiWV9rNXCy1BJrh6C91V8XrSP64hgJQAdpRl9RXGCzycov6y3CcCf+5Y0X
 sFbX7YoZaFBU+CMqZSsLidLDBlw2EM18AeNuZ5Jt+sOqJkpJqCTlwPuAUEiYRT0Nkk4cjMYH
X-Proofpoint-GUID: YOjb04-oHQdcljYWv-C0k9ydpzMW7tUv
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=803 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504260011

On Fri, 25 Apr 2025 06:28:43 -0700, Christoph Hellwig wrote:
> > Some file systems do not support read_iter or write_iter, such as selinuxfs
> > in this issue.
> > So before calling them, first confirm that the interface is supported and
> > then call it.
> 
> Nit: commit messages should not have lines longer than 73 characters.
> 
> Please also add a:
> 
> Fixes: f2fed441c69b ("loop: stop using vfs_iter__{read,write} for buffered I/O")
OK, I would deal with both of the things you mentioned above.
> 
> and maybe add a blurb that vfs_iter_read/write had this check.
It makes no sence. The current issue context does not involve vfs layer
iter_read/write related routines.
> 
> Now the other interesting bit is why we did not hit this earlier with
> direct I/O?  I guess it's because we basically have no instances
> supporting direct I/O and not using the iter ops.
> 
> > @@ -603,6 +603,12 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
> >  	if (!file)
> >  		return -EBADF;
> >
> > +	if (unlikely(!file->f_op->read_iter))
> > +		return -EINVAL;
> > +
> > +	if (file->f_mode & FMODE_WRITE && unlikely(!file->f_op->write_iter))
> > +		return -EINVAL;
> 
> Can we have a common helper for change_fd and configure, please?
The common helper is not very meaningful for this case, but it may be
useful later, so it can be added.
> 
> Please also drop the unlikelys - this is not a fast path and we don't
> need to micro-optimize.
Yes, you are right, I will drop it.
> 
> A bit unrelated, but loop-configure actually checks for write_iter
> and forces read-only for that.  Do we need the same kind of check in
> change_fd?
In the context of this case, it is necessary to judge the write mode of
the new file.
