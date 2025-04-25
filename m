Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CCD3596A;
	Fri, 25 Apr 2025 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745555637; cv=none; b=Di5c4smHJAb+pGLQ2JlXVdU63EYGi2XfiP0n9fwJLrv/EQtqgjuluCje+sUfZS/8gXIHVv8kFtD3ISM04qoy2+onF77kbqPce2pULpXDZTmOOFO34c99CcXMGbj4yHZ3K+kBtamA/mt5BJRYQxCgpJ6Ac/IFVJee5d2A8tR9JSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745555637; c=relaxed/simple;
	bh=Igwob0HEgkYtZ/rFMyh1Nllz71AfHl9t8U+YJNEEIHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATNmCXAm2WmO0Syu9rt3zDMQ7vkuDw8yBqaIPAuErY0+MKdsr33uZ+H5LmyawUVhwcOw8SygEKBZDhhVGvm5tprSNsSwoOT+mB0DZHTvt+pBkA8dMY5wHwz1N3mse8ZK3mw2MQcO1y+yO2AL6uC813+V0koq4NAPVHqdsK2Gjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P4SjIP003908;
	Fri, 25 Apr 2025 04:33:50 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jhjbb0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 25 Apr 2025 04:33:50 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 24 Apr 2025 21:33:49 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 24 Apr 2025 21:33:47 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <ming.lei@redhat.com>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] loop: Add sanity check for read/write_iter
Date: Fri, 25 Apr 2025 12:33:46 +0800
Message-ID: <20250425043346.3412383-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFj5m9LVuekp_n6pEfs17n6QB3Q0yu-qRP67NOJb9ZXRNyhP3Q@mail.gmail.com>
References: <CAFj5m9LVuekp_n6pEfs17n6QB3Q0yu-qRP67NOJb9ZXRNyhP3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3AIN-IZ1FyTo2WAgUHJZj81HuG023yY3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAzMSBTYWx0ZWRfXwlQJcgDaf61i h5NhZTqoL3EOwgGfLzwhB6snNiZuLZKg4gz2i9sBOac6VLFM5tzyu0bQBdtzF44UIxtMkXgAOdg RHA7GhGXuMgNLZkvuo/fR+u5JXGEq9DbWApBLw/BLuyxAMEZU1TeZ0Cr3aI5b93O384fYIZlDu1
 m6Od5klFA7fMLrGSz7GPlO2c+Grv2jeBZUwcn6TbEdX2DdXlh2a/QUf2rlF3nbsNxzGe9eeADn/ 5qsdn6QbnJurrpfDFlPO8DZW7If70CB+/8R+wK9M/QAySQ9NziKfMMtgyTd53e4QLkjoW+rsqKm eGugURM+/15CYnQDLGS4wUELpDwyz2S4z5IyqLSAtPwYnsfsMLRRnl8sOxLY/T+85SM7WmTPmvi
 J6sJU4b4nN6JoSBkCz8yPyHoblhT2vZKCSxHuiqfYVMTjhkpuQr1ioAR/Zb+JUdTT67Bd00y
X-Authority-Analysis: v=2.4 cv=ONQn3TaB c=1 sm=1 tr=0 ts=680b10ae cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=edf1wS77AAAA:8 a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=d7AxSSdjkbr9cxrgU1kA:9
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 3AIN-IZ1FyTo2WAgUHJZj81HuG023yY3
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=811 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504250031

On Fri, 25 Apr 2025 12:20:21 +0800, Ming Lei <ming.lei@redhat.com> wrote:
> > Some file systems do not support read_iter or write_iter, such as selinuxfs
> > in this issue.
> > So before calling them, first confirm that the interface is supported and
> > then call it.
> >
> > Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=6af973a3b8dfd2faefdc
> > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > ---
> >  drivers/block/loop.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 674527d770dc..4f968e3071ed 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -449,10 +449,15 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
> >         cmd->iocb.ki_flags = IOCB_DIRECT;
> >         cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
> >
> > -       if (rw == ITER_SOURCE)
> > -               ret = file->f_op->write_iter(&cmd->iocb, &iter);
> > -       else
> > -               ret = file->f_op->read_iter(&cmd->iocb, &iter);
> > +       ret = 0;
> > +       if (rw == ITER_SOURCE) {
> > +               if (likely(file->f_op->write_iter))
> > +                       ret = file->f_op->write_iter(&cmd->iocb, &iter);
> > +       }
> > +       else {
> > +               if (likely(file->f_op->read_iter))
> > +                       ret = file->f_op->read_iter(&cmd->iocb, &iter);
> > +       }
> 
> The check can be added in loop_configure()/loop_change_fd()
> instead of fast IO path.
Yes, you are right, I will test and send V2 patch.

BR,
Lizhi

