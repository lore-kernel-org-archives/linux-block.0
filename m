Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB81C76192
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 05:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186B321721
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 05:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IFHPNZnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfGPFoR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 01:44:17 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:14059 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfGPFoR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 01:44:17 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190716054415epoutp02a23fc3a1f465ce70be7d2f8099f8eaa8~xzOrsuUgm3175631756epoutp02i
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 05:44:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190716054415epoutp02a23fc3a1f465ce70be7d2f8099f8eaa8~xzOrsuUgm3175631756epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563255855;
        bh=T+tZsyXWgOgF9q0OYheRXgflUx2HgoqlmnEXCHyGDtQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=IFHPNZnfMQgfAu492U/ApOXOCtPnd+5kk0I0866sr9GpoNgYsIXS+WylxhPEv3sTe
         eWLRiIT5zMapbqgSy32ivOgHZiRTtCY6tiG93qFk6Nag4xvdfjUQNSJt1zdFHPvnC4
         88M0vGyh7Uj/UGvoXLLtl3o3wl2bCQ/SGOAAk1bo=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190716054414epcas2p3b1bdb471b940602f62c2eac0ba29c81e~xzOq1tSy10919109191epcas2p3M;
        Tue, 16 Jul 2019 05:44:14 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.181]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45nq8X65Z6zMqYkh; Tue, 16 Jul
        2019 05:44:12 +0000 (GMT)
X-AuditID: b6c32a45-df7ff7000000103c-05-5d2d642c4802
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.13.04156.C246D2D5; Tue, 16 Jul 2019 14:44:12 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH V2] mpt3sas: support target smid for [abort|query] task
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     Hannes Reinecke <hare@suse.de>, Minwoo Im <minwoo.im@samsung.com>,
        "sreekanth.reddy@broadcom.com" <sreekanth.reddy@broadcom.com>,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Euihyeok Kwon <eh81.kwon@samsung.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <860cc8cf-6419-c649-b2d9-19b82f6ebc99@suse.de>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190716054412epcms2p76849500e9450ac399bb123fc9b345c23@epcms2p7>
Date:   Tue, 16 Jul 2019 14:44:12 +0900
X-CMS-MailID: 20190716054412epcms2p76849500e9450ac399bb123fc9b345c23
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmma5Oim6swcv1hhYfV+xit3j4ztli
        z6JJTBaLbmxjsth7S9vi8q45bBbd13ewWSw//o/J4lcnt8Wz0weYLea+bgCq2vqe1WLDvFss
        Ft0nPSzWH5rAZjHz61N2i2dnYhwEPWbdP8vmsXPWXXaPCYsOMHp8fHqLxaNvyypGj82nqz0+
        b5ILYI/KsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB
        Ol5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BoWKBXnJhbXJqXrpecn2tlaGBg
        ZApUmZCT8XrXMbaCl1wV/+dtYm1gPMnRxcjJISFgIrFi+gbGLkYuDiGBHYwSj5+tYuli5ODg
        FRCU+LtDGKRGWMBb4uvFw2wgYSEBeYkfrwwgwpoS73afYQWx2QTUJRqmvmIBGSMi0MIssXxt
        N9hMZoFmFomH52ezQizjlZjR/pQFwpaW2L58KyOIzSlgLfFp42qouKjEzdVv2WHs98fmM0LY
        IhKt984yQ9iCEg9+7mYEOUhCQELi3js7CLNeYssKC5C1EgItjBI33qyFatWXaHz+EWw8r4Cv
        xJ0lb8DiLAKqEqsmnGSCqHGReLh+H5jNDPTj9rdzmEFmMgM9uX6XPsR4ZYkjt1ggKvgkOg7/
        ZYd5ase8J1BTlCU+HjoEdaSkxPJLr9kgbA+J+R2LwGwhgWOMEheWZE1gVJiFCOdZSPbOQti7
        gJF5FaNYakFxbnpqsVGBIXLUbmIEJ2Mt1x2MM875HGIU4GBU4uE9sUcnVog1say4MvcQowQH
        s5IIr+1X7Vgh3pTEyqrUovz4otKc1OJDjKZA709klhJNzgdmirySeENTIzMzA0tTC1MzIwsl
        cd7N3DdjhATSE0tSs1NTC1KLYPqYODilGhjn116JTsv4M/n6jkU/D5Y/W9Vc2Luq+N5vm5i9
        U5O/zNytohAl9sp3Je+doNAlejdEXhcxWB8u/21+5K9524QGzdADCu48nmf1DJKeSc5M2zfr
        x1e7HVfP/9V9Ljqj0tvYPzAq/EHbhW83Nrgt+GqxUl9gY9xPT90bv+aEsy06k3pM4EwU97NV
        SizFGYmGWsxFxYkAPNlgNdwDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190714034415epcms2p25f9787cb71993a30f58524d2f355b543
References: <860cc8cf-6419-c649-b2d9-19b82f6ebc99@suse.de>
        <20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p2>
        <CGME20190714034415epcms2p25f9787cb71993a30f58524d2f355b543@epcms2p7>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> I think this is fundamentally wrong.
> ABORT_TASK is used to abort a single task, which of course has to be
> known beforehand. If you don't know the task, what exactly do you hope
> to achieve here? Aborting random I/O?
> Or, even worse, aborting I/O the driver uses internally and corrupt the
> internal workflow of the driver?

This patch is nothing but a case-addition to the existing code.  I also
have a doubt here why the first picked SMID should be aborted/queried,
but not for this time in this patch.

> 
> We should simply disallow any ABORT TASK from userspace if the TaskMID
> is zero. And I would even argue to disabllow ABORT TASK from userspace
> completely, as the smid is never relayed to userland, and as such the
> user cannot know which task should be aborted.

System administrator might want to query task or abort task if something
happens based on the tag in block layer via debugfs or some logs.
You're right that userspaces has nothing to do with the tag generation
which will be held inside block layer.  But some of administrator would
know the relationship between smid and tag which can be found at debugfs
or the logs.

I'm not sure if it's okay to be picked, but if we can request TMF for the
Targeted smid to the HBA firmware, it would be great to test devices or
Figure out what happened in the target device.

Thanks,
