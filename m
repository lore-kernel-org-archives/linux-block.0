Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5610015C158;
	Fri, 25 Apr 2025 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554797; cv=none; b=He9MwhTSLERb5Bx+IS+SO0l+dcsAeMLudXHwpRP58j6Lcu2MoA0OeT2P5y19GdGxppoYyWI2X3scX3f43Y//oeuoLhAr0ieKoZYnTPBwWN7ug20uj2hCPtd+wVinGie15rOA3mFLVIZx9q5YmT7xqG3TcwE7Rlw8vM20I0q6Cik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554797; c=relaxed/simple;
	bh=ioR4skgPOyOn8QsgJ+wTTSYELuK/OKgKf03OMzprBTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ochDZXkoO8ukhiOM4fby87+nAf7RDD8fBPN0aBOI5EnXdhHyU07o2H2lnVj3zS8RX0A5CblRYJCpi0rDgeSLuV8T8GceFbgwmGLR1+lQUyUqScgcBeaRsDqt2ooNKtiRF0WZy5Niy5CGvsvEJqbEVTatcl4oG52tNRwtloWSK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P4GuL0007467;
	Thu, 24 Apr 2025 21:19:43 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jhd38wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Apr 2025 21:19:42 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 24 Apr 2025 21:19:42 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 24 Apr 2025 21:19:40 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <yanjun.zhu@linux.dev>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] loop: Add sanity check for read/write_iter
Date: Fri, 25 Apr 2025 12:19:39 +0800
Message-ID: <20250425041939.3388803-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8352c76d-ad30-4c2e-91bd-9676df21b293@linux.dev>
References: <8352c76d-ad30-4c2e-91bd-9676df21b293@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZNDXmW7b c=1 sm=1 tr=0 ts=680b0d5f cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=x9mcN1thFNAw6uWNoUEA:9
X-Proofpoint-ORIG-GUID: WGApeCznCFB7YWr6BMh3tTgl8PLkEL2z
X-Proofpoint-GUID: WGApeCznCFB7YWr6BMh3tTgl8PLkEL2z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAyOSBTYWx0ZWRfX3Vl37cFQb80B 4C4TfTV6ePTYx4d3VyKxbJN5Fyzm6U9gXYCQXFopnIGi73oJX3DQ66MHXjfcgB+BzNTS+QysHWd AqmTudfWRE9rym1/hRSfarD5ynsQhU4cyWF+nMoD4zgMXAZ/B/xtd0bKxLu/YTBILPGb6jk0/o1
 F28WBY4r4VQ86Xw5VodEpYscvDwQn/ktwD+3bzsWGk3FLUO6hzmp+qnekI2vfuMcnmWHgyweJK7 fAwAacWsPRWr02099PyIgNMZt47vB89PSmm2XAwjQhiH5tocTu7aQVTQh6PfJ2GIrguCK52lDsv yy5bBo2av2BLAdN3KBXBRW6Lc779C8vl9D2WtZLH577M8V0gy4QYZ2XOyzo5MZhHYHBJu+ilxna
 nT9R5tXg+5lC2ELhN4EHu7lzEMvRc0jOrBS7fX5A26bi9QugmfGq+r9nFEmzQShzkuabdiJh
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=808 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504250029

On Fri, 25 Apr 2025 06:06:51 +0200, Zhu Yanjun wrote:
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 674527d770dc..4f968e3071ed 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -449,10 +449,15 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
> >       cmd->iocb.ki_flags = IOCB_DIRECT;
> >       cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
> >
> > -     if (rw == ITER_SOURCE)
> > -             ret = file->f_op->write_iter(&cmd->iocb, &iter);
> > -     else
> > -             ret = file->f_op->read_iter(&cmd->iocb, &iter);
> > +     ret = 0;
> > +     if (rw == ITER_SOURCE) {
> > +             if (likely(file->f_op->write_iter))
> > +                     ret = file->f_op->write_iter(&cmd->iocb, &iter);
> > +     }
> > +     else {
> > +             if (likely(file->f_op->read_iter))
> 
> "else if" is better?
There is nothing wrong with writing it this way logically, but it will
destroy the clarity of the original context regarding the read/write logical
relationship.
