Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FE8C48BD6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1CC2084B
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 07:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hShNGErK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF0HjJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:39:09 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:44811 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfF0HjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 03:39:09 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190627073906epoutp010a182792a3334c9fb8c6417fa8e83a19~r-iifCR-G2892728927epoutp01c
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2019 07:39:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190627073906epoutp010a182792a3334c9fb8c6417fa8e83a19~r-iifCR-G2892728927epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561621146;
        bh=9H6zEdFQIVwFEza2JBBAvxKq3hSomULWP85vkCD2b5Y=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=hShNGErKfCW+5SgBtJHv18tr4A9qx2bZvT7Af5ViC4O7QbePgdh6cbqG525brQ1d3
         8wVs4Z+WyqunedBYw7c88X7H3AQX8zs1dkBlV+EEe0+CWoU958V3qteKMg6ZqbEwfm
         na4PkOQQb8/OLnpACvAfDckqKFIloP3gMvh1F8f4=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.189]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190627073903epcas2p37c07c8ede4ce1c8352fc32360b5288c2~r-ifv2gym1084110841epcas2p3B;
        Thu, 27 Jun 2019 07:39:03 +0000 (GMT)
X-AuditID: b6c32a46-d4bff7000000106f-57-5d147297bd73
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.00.04207.792741D5; Thu, 27 Jun 2019 16:39:03 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [RESEND RFC PATCH] mpt3sas: support target smid for
 [abort|query] task
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
CC:     Minwoo Im <minwoo.im@samsung.com>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Euihyeok Kwon <eh81.kwon@samsung.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p3>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190627073903epcms2p73dec91f5f4423e888b2a7b82f71fdee7@epcms2p7>
Date:   Thu, 27 Jun 2019 16:39:03 +0900
X-CMS-MailID: 20190627073903epcms2p73dec91f5f4423e888b2a7b82f71fdee7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmqe70IpFYg5fdAhYfV+xit3j4ztli
        0Y1tTBZ7b2lbXN41h82i+/oONovlx/8xWfzq5LZ4dvoAs8Xc1w1MFou2vme12DDvFovF+kMT
        2CyenYlx4POYdf8sm8fOWXfZPSYsOsDo8fHpLRaPvi2rGD0+b5ILYIvKsclITUxJLVJIzUvO
        T8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlVJoSwxpxQoFJBYXKykb2dT
        lF9akqqQkV9cYquUWpCSU2BoWKBXnJhbXJqXrpecn2tlaGBgZApUmZCTsXLrWcaCBxIVb+dN
        Zm9g7BfpYuTgkBAwkWi8FNnFyMUhJLCDUWLFzQeMIHFeAUGJvzuEuxg5OYQFQiUmPzrLAhIW
        EpCX+PHKACKsKfFu9xlWEJtNQF2iYeorFpAxIgJbmSTO3GphBHGYBY4zSyz8uAisSkKAV2JG
        +1MWCFtaYvvyrYwgNqeAn8SKe+uYIOKiEjdXv2WHsd8fm88IYYtItN47ywxhC0o8+LmbEeJ+
        CYl77+wgzHqJLSssQNZKCLQwStx4sxaqVV+i8flHsLW8Ar4SRz4eBRvPIqAq8aNxCtRaF4mP
        7TvAxjMD/bj97RxmkJnMQE+u36UPMV5Z4sgtFogKPomOw3/ZYZ7aMe8J1BRliY+HDkEdKSmx
        /NJrNgjbQ2L717lMkFCeyijR/vI22wRGhVmIgJ6FZPEshMULGJlXMYqlFhTnpqcWGxUYIUft
        JkZwotVy28G45JzPIUYBDkYlHt4VO4VjhVgTy4orcw8xSnAwK4nw5oeJxArxpiRWVqUW5ccX
        leakFh9iNAX6fyKzlGhyPjAL5JXEG5oamZkZWJpamJoZWSiJ827ivhkjJJCeWJKanZpakFoE
        08fEwSnVwLjuTOf0ppUu+39FCCZHScifEj84Ky4g6cDnqj/Nf+Lund8ScuvOBcPagDWBvg+0
        kiV2GudKfTXjfjbtp6Ds6m5dNa+iVodzDPGpy16JC783+md8JLVTOUNSlC9I8f2Xz2u+te64
        M1ftfuWajdP+JWVmNu18fPXF5LdPnLM/xtQk8aV9qDC8yarEUpyRaKjFXFScCADUZEaZygMA
        AA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190621063708epcms2p309f4173afabe5de28942ba15d13987f7
References: <20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p3>
        <CGME20190621063708epcms2p309f4173afabe5de28942ba15d13987f7@epcms2p7>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Gentle ping. :)

> -----Original Message-----
> From: Minwoo Im <minwoo.im@samsung.com>
> Sent: Friday, June 21, 2019 3:37 PM
> To: sathya.prakash@broadcom.com; suganath-prabu.subramani@broadcom.com;
> jejb@linux.ibm.com; martin.petersen@oracle.com
> Cc: Minwoo Im <minwoo.im@samsung.com>; MPT-FusionLinux.pdl@broadcom.com;
> linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org; linux-
> block@vger.kernel.org; Euihyeok Kwon <eh81.kwon@samsung.com>; Sarah Cho
> <sohyeon.jo@samsung.com>; Sanggwan Lee <sanggwan.lee@samsung.com>;
> Gyeongmin Nam <gm.nam@samsung.com>
> Subject: [RESEND RFC PATCH] mpt3sas: support target smid for [abort|query]
> task
> 
> We can request task management IOCTL command(MPI2_FUNCTION_SCSI_TASK_MGMT)
> to /dev/mpt3ctl.  If the given task_type is either abort task or query
> task, it may need a field named "Initiator Port Transfer Tag to Manage"
> in the IU.
> 
> Current code does not support to check target IPTT tag from the
> tm_request.  This patch introduces to check TaskMID given from the
> userspace as a target tag.  We have a rule of relationship between
> (struct request *req->tag) and smid in mpt3sas_base.c:
> 
> 3318 u16
> 3319 mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
> 3320         struct scsi_cmnd *scmd)
> 3321 {
> 3322         struct scsiio_tracker *request = scsi_cmd_priv(scmd);
> 3323         unsigned int tag = scmd->request->tag;
> 3324         u16 smid;
> 3325
> 3326         smid = tag + 1;
> 
> So if we want to abort a request tagged #X, then we can pass (X + 1) to
> this IOCTL handler.
> 
> Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: MPT-FusionLinux.pdl@broadcom.com
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> index b2bb47c14d35..5c7539dae713 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> @@ -596,15 +596,17 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc,
> struct mpt3_ioctl_command *karg,
>  		if (priv_data->sas_target->handle != handle)
>  			continue;
>  		st = scsi_cmd_priv(scmd);
> -		tm_request->TaskMID = cpu_to_le16(st->smid);
> -		found = 1;
> +		if (tm_request->TaskMID == st->smid) {
> +			tm_request->TaskMID = cpu_to_le16(st->smid);
> +			found = 1;
> +		}
>  	}
> 
>  	if (!found) {
>  		dctlprintk(ioc,
> -			   ioc_info(ioc, "%s: handle(0x%04x), lun(%d), no
> active mid!!\n",
> +			   ioc_info(ioc, "%s: handle(0x%04x), lun(%d), no
> matched mid(%d)!!\n",
>  				    desc, le16_to_cpu(tm_request->DevHandle),
> -				    lun));
> +				    lun, tm_request->TaskMID));
>  		tm_reply = ioc->ctl_cmds.reply;
>  		tm_reply->DevHandle = tm_request->DevHandle;
>  		tm_reply->Function = MPI2_FUNCTION_SCSI_TASK_MGMT;
> --
> 2.16.1
