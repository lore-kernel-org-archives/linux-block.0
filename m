Return-Path: <SRS0=YXNx=VL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AE1C73C66
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 02:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF3720848
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 02:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l8n9tSki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfGNCR7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Jul 2019 22:17:59 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:23162 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfGNCR7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Jul 2019 22:17:59 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190714021754epoutp0435abaff42889a53dc8483005b8539b1f~xJH9PmosG2027920279epoutp04r
        for <linux-block@vger.kernel.org>; Sun, 14 Jul 2019 02:17:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190714021754epoutp0435abaff42889a53dc8483005b8539b1f~xJH9PmosG2027920279epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563070674;
        bh=yNAoPuRoPzyZ4mRfa7HYfRK55kOEm67EhAubhyYqoXQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=l8n9tSki1NutIF5cz/cTpm4aUr9VCCh1SOcv48mS97giPgH7pPidWfj3zJAxu92zi
         xeqfNbQFuNVFHXtu4fTQsvwpEd/9pflI9Im0SwJBVLt3bhi88XggMbrWOzjJROphp5
         DLaIPP5dkd3+bERtL3M30IQVs3tBQ4GykTqK4EDc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190714021754epcas2p38ba7dd96266371e2281d77273b97b176~xJH8o00nl2917029170epcas2p3G;
        Sun, 14 Jul 2019 02:17:54 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.189]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45mVgP0swczMqYlh; Sun, 14 Jul
        2019 02:17:53 +0000 (GMT)
X-AuditID: b6c32a46-fd5ff70000001035-85-5d2a90d0f030
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.61.04149.0D09A2D5; Sun, 14 Jul 2019 11:17:53 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [RESEND RFC PATCH] mpt3sas: support target smid for
 [abort|query] task
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Minwoo Im <minwoo.im@samsung.com>
CC:     "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Euihyeok Kwon <eh81.kwon@samsung.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAK=zhgr_T8vA=BCdFCT37RxGCgS3xr8Wp9MEMK_9nZ=oYHy=7Q@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190714021752epcms2p6994026d1e2b3738f2857f8eff307c866@epcms2p6>
Date:   Sun, 14 Jul 2019 11:17:52 +0900
X-CMS-MailID: 20190714021752epcms2p6994026d1e2b3738f2857f8eff307c866
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmhe7FCVqxBm2nmSw+rtjFbvHwnbPF
        ohvbmCz23tK2uLxrDptF9/UdbBbLj/9jsvjVyW3x7PQBZou5rxuYLBZtfc9qsWHeLRaL9Ycm
        sFnM/PqU3eLZmRgHfo9Z98+yeeycdZfdY8KiA4weH5/eYvHo27KK0ePzJrkAtqgcm4zUxJTU
        IoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByge5UUyhJzSoFCAYnF
        xUr6djZF+aUlqQoZ+cUltkqpBSk5BYaGBXrFibnFpXnpesn5uVaGBgZGpkCVCTkZsz+cYy14
        JVjReG4OWwPjdd4uRk4OCQETiVNbJzB2MXJxCAnsYJRY+OcTaxcjBwevgKDE3x3CIDXCAqES
        kx+dZQEJCwnIS/x4ZQAR1pR4t/sMK4jNJqAu0TD1FQuILSIQLvFo1mdGEJtZ4DqrxKs98hCr
        eCVmtD9lgbClJbYv3wpWwykQKHHm5Wl2iLioxM3Vb+Hs98fmM0LYIhKt984yQ9iCEg9+7mYE
        OUdCQELi3js7CLNeYssKC5BHJARaGCVuvFkL1aov0fj8I9haXgFfiYcHfzKB2CwCqhJHDy2D
        Guki8fHoVBaIk+Ultr+dwwwykxnoxfW79CHGK0scuQVVwSfRcfgvO8xTO+Y9YYKwlSU+HjoE
        NVFSYvml12wQtofE9q9zmSBhfIdRYsXcNUwTGBVmIYJ5FpLFsxAWL2BkXsUollpQnJueWmxU
        YIQcs5sYwQlXy20H45JzPocYBTgYlXh4d3BrxQqxJpYVV+YeYpTgYFYS4V31Xz1WiDclsbIq
        tSg/vqg0J7X4EKMp0P8TmaVEk/OB2SCvJN7Q1MjMzMDS1MLUzMhCSZx3E/fNGCGB9MSS1OzU
        1ILUIpg+Jg5OqQbGXaXLem4nbdobMufCNG3ZQo+HD6Yt4b8Xvqyj81zy3dfbO23P77cITtWc
        2nK8KKgy2WOpx5rXh6++eKasXV2QMeFdx42GTV/4Sz7vLl12t39e6YrTSxmSwkw+MPO5bf32
        SE1Ha1XUrJ9ds5ecra+u7jt3JFfx/onjDXK3Nxq0PXzSUlV5bY3iOiWW4oxEQy3mouJEAN6E
        pE/OAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190621063708epcms2p309f4173afabe5de28942ba15d13987f7
References: <CAK=zhgr_T8vA=BCdFCT37RxGCgS3xr8Wp9MEMK_9nZ=oYHy=7Q@mail.gmail.com>
        <20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p3>
        <CGME20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p6>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sreekanth,

> >  drivers/scsi/mpt3sas/mpt3sas_ctl.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > index b2bb47c14d35..5c7539dae713 100644
> > --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> > @@ -596,15 +596,17 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc,
> struct mpt3_ioctl_command *karg,
> >                 if (priv_data->sas_target->handle != handle)
> >                         continue;
> >                 st = scsi_cmd_priv(scmd);
> > -               tm_request->TaskMID = cpu_to_le16(st->smid);
> > -               found = 1;
> > +               if (tm_request->TaskMID == st->smid) {
> 
> I think it will difficult for the user to find the smid that he want
> to abort. For this user has to enable the scsi logging level and get
> the tag and pass the ioctl with tag +1 value in TaskMID field. And
> hence currently driver will loop over all the smid's and if it fines
> any outstanding smid then it will issue task abort or task query TM
> for this outstanding smid to the HBA firmware.

Sreekanth,

You're exactly right because I have done this kind of abort based on
The scsi logs with logging level configured.

> 
> May be we can do like below,
> * First check whether user provided "TaskMID" is non zero or not. if
> user provided TaskMID is non-zero and if this TaskMID is outstanding
> then driver will issue TaskAbort/QueryTask TM with this TaskMID value

Okay.  If I get it right, you mean to check the given TaskMID(!=0) is
Outstanding or not is by an iteration first.

> else driver will loop over all the smid's and if finds any smid is
> outstanding then it will issue TaskAbort/QueryTask TM with TaskMID
> value set to outstanding smid.

Got your point here.  I'll make a conditional statement for the case
where the TaskMID is zero which is the legacy behaviour.

> With the above logic still legacy application will be supported
> without breaking anything where they provide TaskMID filed as zero.
> And it also allows the user to abort the IO which he wants.

Sure, I'll prepare V2 patch soon.

Thanks Sreekanth,

		Minwoo Im
