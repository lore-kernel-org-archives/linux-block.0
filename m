Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2540EC76195
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 04:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C4B2199C
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 04:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kr+JlwVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfGVEbK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 00:31:10 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:45200 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfGVEbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 00:31:09 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190722043105epoutp018469fc6eb1f2735a8926a409fbfc1ac9~zoGho9C_c2877828778epoutp01q
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 04:31:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190722043105epoutp018469fc6eb1f2735a8926a409fbfc1ac9~zoGho9C_c2877828778epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563769865;
        bh=RbTQ+3lpnekzFW2aYFoQw11SgLg6H7uTq1TIF0rQZYg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Kr+JlwVKpPJJ3a71nRlfnD6mp50C3xPRLmjXa+HJCA2T0Nn6aekh4i3jd3aYV3Yro
         wPlKBhiDysCILvw89KobkQOmzSRb6n/qVp4fW3TudVxCvm086+aqI8iz27SH/lluKp
         Jk4PBPL4rxu4TU74NogeLuF7+SLza6izukZBFXMo=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190722043105epcas2p169c6ca0a1a1494584cc12f67aaa01108~zoGhLSGK52303023030epcas2p1I;
        Mon, 22 Jul 2019 04:31:05 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.187]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45sTFM12gJzMqYkW; Mon, 22 Jul
        2019 04:31:03 +0000 (GMT)
X-AuditID: b6c32a45-ddfff7000000103c-e2-5d353c05fb8f
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.A8.04156.50C353D5; Mon, 22 Jul 2019 13:31:02 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] lightnvm: introduce pr_fmt for the previx nvm
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <mb@lightnvm.io>,
        "javier@javigon.com" <javier@javigon.com>,
        "birkelund@gmail.com" <birkelund@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <BYAPR04MB5749126EF9E68D94125BACB486CA0@BYAPR04MB5749.namprd04.prod.outlook.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190722043101epcms2p2645d83b2c4aca7fc446f8d9109342327@epcms2p2>
Date:   Mon, 22 Jul 2019 13:31:01 +0900
X-CMS-MailID: 20190722043101epcms2p2645d83b2c4aca7fc446f8d9109342327
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmhS6bjWmswfbzjBbnm/rZLWbdfs1i
        0Xn6ApPF3lvaFpd3zWGzWLH9CIvFr05uB3aPnbPusns0L7jD4tF99Qejx+dNch7tB7qZAlij
        cmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgI5QUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQYGhboFSfmFpfmpesl5+daGRoYGJkCVSbk
        ZHw584Gt4BJrxdGZ11gaGFewdDFyckgImEjcePyHqYuRi0NIYAejxKH1f5i7GDk4eAUEJf7u
        EAapERZwkuh9dZwJJCwkIC/x45UBRFhT4t3uM6wgNpuAukTD1FcsIGNEBDYzSnQ8/QDmMAss
        ZZR4tr+VHWIZr8SM9qdQi6Ulti/fyghicwrESuyZ+J4VIi4qcXP1W3YY+/2x+YwQtohE672z
        zBC2oMSDn7sZQQ6SEJCQuPfODsKsl9iywgJkrYRAC6PEjTdroVr1JRqff2SBeMtXYu5kEZAw
        i4CqxMQfK6BKXCReTDoHNp0Z6MXtb+eAQ4EZ6Mf1u/QhpitLHLnFAlHBJ9Fx+C/cTzvmPWGC
        sJUlPh46BHWjpMTyS6/ZIGwPiQlv2tkhgXydUWLbljOMExgVZiHCeRaSxbMQFi9gZF7FKJZa
        UJybnlpsVGCIHLWbGMHJUct1B+OMcz6HGAU4GJV4eG9sNokVYk0sK67MPcQowcGsJMKbZ2Aa
        K8SbklhZlVqUH19UmpNafIjRFOj/icxSosn5wMSdVxJvaGpkZmZgaWphamZkoSTOu5n7ZoyQ
        QHpiSWp2ampBahFMHxMHp1QD400Dlr2fHp3r079iXR2z7xv31oq/qtIrLX9n7l9jnxfqtXLy
        To2kdykSpcX9mj/PRLLYWzsvdK6b6bZtw+SOe483Ki5YeHbdieP/g/TWfeHzmqHTPFd3ctm5
        4if3pJzYNihtY25/KOry6Z55dqof76L+4NSX9w/tvJFV0i82x2/p7NqiqgyTBCWW4oxEQy3m
        ouJEACt3SgikAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190720212747epcas1p4d3e17fefd1cbd2007a1a1a452dde9c55
References: <BYAPR04MB5749126EF9E68D94125BACB486CA0@BYAPR04MB5749.namprd04.prod.outlook.com>
        <20190720083043.23387-1-minwoo.im.dev@gmail.com>
        <CGME20190720212747epcas1p4d3e17fefd1cbd2007a1a1a452dde9c55@epcms2p2>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > @@ -1111,27 +1112,27 @@ static int nvm_init(struct nvm_dev *dev)
> >   	int ret = -EINVAL;
> >
> >   	if (dev->ops->identity(dev)) {
> > -		pr_err("nvm: device could not be identified\n");
> > +		pr_err("device could not be identified\n");
> >   		goto err;
> >   	}
> >
> > -	pr_debug("nvm: ver:%u.%u nvm_vendor:%x\n",
> > +	pr_debug("ver:%u.%u nvm_vendor:%x\n",
> >   				geo->major_ver_id, geo->minor_ver_id,
> >   				geo->vmnt);
> The above last 2 lines can be squashed and pr_debug call can be made in
> 2 lines since you have removed the "nvm:" which shortens the first line.

Yeah Okay.  Will prepare V2 with this and also s/previx/prefix in the
title.

Thanks for the review.

Minwoo Im
