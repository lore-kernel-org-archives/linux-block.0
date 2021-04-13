Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B0C433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 11:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC91F6101B
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 11:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbhDMLfg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 07:35:36 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:52708 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhDMLff (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 07:35:35 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210413113513epoutp011ee145789877903d67b2220d31eb20dd~1Z7_mKex22343023430epoutp01P
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 11:35:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210413113513epoutp011ee145789877903d67b2220d31eb20dd~1Z7_mKex22343023430epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618313713;
        bh=7KodStiJwoEppifiqJl4Qq2C/0OrS0r8Is5x7+ficno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZ/o/D2OBoS2MKBv578ZKciiK1aMBSkw0u7DIjI7EujkAYXhHxlce6lP+3Qj6MoRd
         8pMSf69ZQeTUuAElAsdJQl9RUevcoQrhfCojqpBYcjTkaWlpN6hGGF3KZ38FWEWTWm
         F9XYaZvqNc46cutdkUIDp0b8wEt2dd3/W34cPc1k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210413113513epcas1p49c598c6f2fd8b3559e35c10e67c88bc9~1Z79wh1Ol2636026360epcas1p4q;
        Tue, 13 Apr 2021 11:35:13 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FKNnW4Vvzz4x9Q2; Tue, 13 Apr
        2021 11:35:11 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.3F.10347.FE185706; Tue, 13 Apr 2021 20:35:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210413113510epcas1p29dd90b47ba8c8701a2309fc34698ad29~1Z7721p2c1608716087epcas1p2u;
        Tue, 13 Apr 2021 11:35:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210413113510epsmtrp19801237d3256e863bcba82c3c730fe43~1Z771UQtk2864828648epsmtrp1b;
        Tue, 13 Apr 2021 11:35:10 +0000 (GMT)
X-AuditID: b6c32a39-147ff7000002286b-87-607581ef72b0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.3C.08745.EE185706; Tue, 13 Apr 2021 20:35:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210413113510epsmtip2f03d0177ee2d5ec23b4f1ba56547eefd~1Z77m-Lqu2639626396epsmtip2Q;
        Tue, 13 Apr 2021 11:35:10 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     gregkh@linuxfoundation.org
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, bvanassche@acm.org, damien.lemoal@wdc.com,
        hch@infradead.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, nanich.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v7 3/3] bio: add limit_bio_size sysfs
Date:   Tue, 13 Apr 2021 20:17:27 +0900
Message-Id: <20210413111727.12999-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <YHVJq0n/fzd6WVO4@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJsWRmVeSWpSXmKPExsWy7bCmvu77xtIEgzMnZCzmrNrGaLH6bj+b
        xbQPP5ktWtu/MVk0L17PZnF6wiImi54nTawWf7vuMVl8fVhssfeWtsXlXXPYLA5NbmaymL55
        DrPFtftn2C0O37vKYvFwyURmi3MnP7FazHvsYPFr+VFGi/c/rrNbnNoxmdli/d6fbA5iHpev
        eHtMbH7H7rFz1l12j80rtDwuny312LSqk81j/9w17B7v911l8+jbsorR4/MmOY/2A91MAdxR
        OTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QJ8qKZQl
        5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoMDQr0ihNzi0vz0vWS83OtDA0MjEyBKhNy
        MuYf7WQu6Oet+L3jH3sDYx9XFyMHh4SAiURTQ2UXIxeHkMAORolNmycyQTifGCV+vvvPAuF8
        ZpTonXyctYuRE6xj0pIZUIldjBKr9l5jhqtqeL2NBaSKTUBHou/tLTYQW0RATuLJ7T9gRcwC
        /5glFvf8YQRJCAtYSizr3g02lkVAVaLx4F6wBl4Ba4l505czQayTl/hzv4cZxOYU0JT4tPks
        E0SNoMTJmU/AljED1TRvnQ22QEKgmVNi25yPbBDNLhKHjixigbCFJV4d38IOYUtJvOxvY4do
        6GaUaG6bzwjhTGCUWPJ8GdRqY4lPnz8zgsKJGWj1+l36EGFFiZ2/5zJCbOaTePe1hxUSlLwS
        HW1CECUqEmda7jPD7Hq+difURA+J69fvgj0sJFAjcf5sJ/sERoVZSP6ZheSfWQiLFzAyr2IU
        Sy0ozk1PLTYsMEWO402M4MSvZbmDcfrbD3qHGJk4GA8xSnAwK4nwuk0pSRDiTUmsrEotyo8v
        Ks1JLT7EaAoM7YnMUqLJ+cDck1cSb2hqZGxsbGFiZm5maqwkzptk8CBeSCA9sSQ1OzW1ILUI
        po+Jg1OqgWnb5UU26blhJnnKBv6N2tHZTptZsyb/ULkhUqJtZHLUnu+lj11MZot2rvqUmi/O
        mmq33VdFJnVw/f7PqtT+lT2hoILHzJ/r7Nw7eozbe6a7Pl3wb0+GEL+Py3d5V4cJs6UkO8Ie
        /Nshtz6+LY9bsUeAwTpzoQ3fBGn9q3/3P35oZn0j/IRb2nqmq/PWXxA+/ets0XQD6YdzpcOr
        0veHq4R/P2XeaMSw+sBEC+W1a7gTtSRLJDWyn/NLbnbaavrR1e+SI6tCYoj7/PRve4sbOv2q
        f3ndLD5UEW/Pb3CA9bTOJKa/11vr37glBrZGv+012Hcupmb1h8MLuzsdp6dJNbaHa347+WLv
        6u44SWYlluKMREMt5qLiRAAsWXKahQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSvO67xtIEg9d3TS3mrNrGaLH6bj+b
        xbQPP5ktWtu/MVk0L17PZnF6wiImi54nTawWf7vuMVl8fVhssfeWtsXlXXPYLA5NbmaymL55
        DrPFtftn2C0O37vKYvFwyURmi3MnP7FazHvsYPFr+VFGi/c/rrNbnNoxmdli/d6fbA5iHpev
        eHtMbH7H7rFz1l12j80rtDwuny312LSqk81j/9w17B7v911l8+jbsorR4/MmOY/2A91MAdxR
        XDYpqTmZZalF+nYJXBnzj3YyF/TzVvze8Y+9gbGPq4uRk0NCwERi0pIZLF2MXBxCAjsYJdpa
        brNBJKQkjp94y9rFyAFkC0scPlwMUfORUWLm5u0sIDVsAjoSfW9vgdWLCMhJPLn9hxmkiFlg
        BotE7/c9jCAJYQFLiWXdu1lBbBYBVYnGg3vBGngFrCXmTV/OBLFMXuLP/R5mEJtTQFPi0+az
        YHEhAQ2JM0uPsULUC0qcnPkEbDEzUH3z1tnMExgFZiFJzUKSWsDItIpRMrWgODc9t9iwwCgv
        tVyvODG3uDQvXS85P3cTIzg6tbR2MO5Z9UHvECMTB+MhRgkOZiURXrcpJQlCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MPGUn+wXkeN/UHjp7p+5dQst
        nAJbg89N4z9QaG2T4P3q7BYxvw2BG6c03J1hyTH1WskcIx/zLStebgqtipv//brAv7LDG548
        E/9w/fWhQ18UXr851WJ74WLCFD9R05pdDM5aJy3EUxZqsh3jbv9Q+rzyk+GiE7fXP9usFLD+
        2cr767dEGeX/3xDmlRW/w95yxqdL625bRfV0yz5iKv2uXm526IXbxec7xdYwm/01XM7+62jJ
        7CObGC5JTSwK7FwS8SpWKelXB7+Gz+2Q0lUlslvY759Ukeb+XbNi4d4+yYuLf3k8F5q39xBH
        xe3HLUKiLOeaj7/4ZVy3x6FXJkPSf++LLZPnaDeddGHbujSqPGuTEktxRqKhFnNRcSIAhRGb
        6T0DAAA=
X-CMS-MailID: 20210413113510epcas1p29dd90b47ba8c8701a2309fc34698ad29
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210413113510epcas1p29dd90b47ba8c8701a2309fc34698ad29
References: <YHVJq0n/fzd6WVO4@kroah.com>
        <CGME20210413113510epcas1p29dd90b47ba8c8701a2309fc34698ad29@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Tue, Apr 13, 2021 at 11:55:02AM +0900, Changheun Lee wrote:
> > Add limit_bio_size block sysfs node to limit bio size.
> > Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size is set.
> > And bio max size will be limited by queue max sectors via
> > QUEUE_FLAG_LIMIT_BIO_SIZE set.
> > 
> > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > ---
> >  Documentation/ABI/testing/sysfs-block | 10 ++++++++++
> >  Documentation/block/queue-sysfs.rst   |  7 +++++++
> >  block/blk-sysfs.c                     |  3 +++
> >  3 files changed, 20 insertions(+)
> 
> Isn't it too late to change the sysfs entry after the device has been
> probed and initialized by the kernel as the kernel does not look at this
> value after that?

Kernel will take a look this when page is merged to bio. And bio size will
be limited dynamically.

> 
> Why do you need a userspace knob for this?  What tool is going to ever
> change this, and what logic is it going to use to change it?  Why can't
> the kernel also just "do the right thing" and properly detect this
> option as well as userspace can?

Actually I didn't considerate userspace knob at first. And there is no tool,
no logic to change it. It's a kind of policy about bio max size.
One time setting will be OK on system boot time actually.

At the first, I suggested 1MB bio max size. It is same with bio max size
before applying of multipage bvec. But there are requests of big bio size
on another system environment, and feedback of knob for utility too.
So I made this as a optional for each system, and a knob too.

> 
> thanks,
> 
> greg k-h


Thanks,

Changheun Lee
