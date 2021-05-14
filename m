Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A757C433ED
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 06:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9656144F
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 06:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhENGwL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 02:52:11 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:44810 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhENGwK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 02:52:10 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210514065058epoutp03b14b9f6c769fdeeb2aaab1f40c6c2bd8~_3Doqt-KL2706527065epoutp03M
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 06:50:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210514065058epoutp03b14b9f6c769fdeeb2aaab1f40c6c2bd8~_3Doqt-KL2706527065epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620975058;
        bh=CjMGsm2TiaMCR6zeyCXkQkwh+BfIjFA08Uqp8sAU+FQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oo44cANTkfoQNnulixqCSX4VhV1f1zidJD0XlvG82lFpYtezccFY54pjgV6xIJq+1
         yHV85GcpwnhFudhUoou3kWsczCLU9NR04DjYcCICdOQWNEx0wg4oFh8cnRIUYYMsSw
         6Tv0267k0SHiLDoE0hGlZZkxz7nN3ZlI1sSJRcxE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210514065057epcas1p3d3f3d390ec4368af1a70a9d9b563c494~_3DnhBavg0919809198epcas1p3g;
        Fri, 14 May 2021 06:50:57 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FhK1C44mkz4x9QJ; Fri, 14 May
        2021 06:50:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.00.09736.FCD1E906; Fri, 14 May 2021 15:50:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210514065054epcas1p4bd5c92a59d4010da4447ef62f65fdd4b~_3DldshhT1456114561epcas1p4o;
        Fri, 14 May 2021 06:50:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210514065054epsmtrp1489e13e1b7708007624e739a1904a65a~_3DlbsHfJ0151201512epsmtrp1U;
        Fri, 14 May 2021 06:50:54 +0000 (GMT)
X-AuditID: b6c32a39-8d9ff70000002608-ac-609e1dcf8db0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.DD.08637.ECD1E906; Fri, 14 May 2021 15:50:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210514065054epsmtip2782ad7d39cb150c712fc29cc1b9c5362~_3DlJ2a2W0522605226epsmtip2P;
        Fri, 14 May 2021 06:50:54 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     hch@infradead.org
Cc:     Johannes.Thumshirn@wdc.com, alex_y_xu@yahoo.ca,
        asml.silence@gmail.com, axboe@kernel.dk, bgoncalv@redhat.com,
        bvanassche@acm.org, damien.lemoal@wdc.com,
        gregkh@linuxfoundation.org, jaegeuk@kernel.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com,
        nanich.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yi.zhang@redhat.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v10 0/1] bio: limit bio max size
Date:   Fri, 14 May 2021 15:32:41 +0900
Message-Id: <20210514063241.22260-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <YJ0MJe1Gc5XMV1gB@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGd+7tF7hqRXFnTXRYNRnMYmspHCYsGhSvY9kYZkvGRFrpDRD7
        ZVtUcCZd+RCBINgJWIoFCqjIYAHGAGWwMoZMBowP2dwoQ2BEHcgokOHGspYLGf89531/z3nO
        eU8OC/fIZHJZ8UodqVFK5TyGO62h3VvA791+QyL4t4aLqn+tYiJzZQNAd0auMFDzjxaA8maX
        cJR6aRFDydYaBnqQU4qhiRoTjrImDHS0nGHH0MKYFrU8egMNNJsZyGZMxlB+nRlHD0e7majd
        PkRDY2W5OOrpmqOjG+MH0YubHQA9/2uYib5vNOJouCePgWpalhgHucTAYBiRmzzDJJpMI0yi
        7pYPMfBDAlFbeZlBtBZVMYnnXw8xiOz6SkA4ancQl9oyMcJmq8DDX46UB8WRUhmp8SKVMSpZ
        vDI2mBd2PDokWuwvEPKFgSiA56WUKshg3uF3wvmh8XLnCHheZ6XyBGcpXKrV8va9FaRRJehI
        rziVVhfMI9UyuVooUPtqpQptgjLWN0aleFMoEOwXO0mJPK5i8hmmvsM+3//nCF0POtwzgBsL
        cvzg1XQTIwO4szw4jQD29U5j1GIOwOyxGbqL8uAsAjiVsnvN0d9twimoBcCukqJVuwPA2cdT
        Kw4GZy/Mnn7EcOmtHE9ozx8ELgjn/EKDDdarmKuxxbnVt8bfmC5N4+yB1kHTSp3NOQA70gvo
        VNxr8J/RLNyl3Th8+MWT20yK2Qy7rk/QXBp3MslfFq4cCXKsbrDum/s0ynwYPlvuZFJ6C3za
        Wb+qufDJlTQmZcgEMDnNAqhFDoBlUxUYRYngnMPhbLCcEd6wpnkfVd4Jm/4uAlTyRjizkEV3
        IZDDhulpHhSyG3anjOJrWVOfN63uSMCqMTONmqkewPLqD3KAl2ndfUzr7mP6P7gY4JVgG6nW
        KmJJrVAtXv/GtWDlV/gENoL86VlfG8BYwAYgC+dtZW87VSjxYMukiUmkRhWtSZCTWhsQO6ed
        i3M9Y1TOb6XURQvF+0UiEfLzD/AXi3ivsGNDLkg8OLFSHXmaJNWkZs2Hsdy4eszv2nJi0sl3
        z13YXt5qOd3Dm9sYMd/5s/v9wMSlaONPzWq7o9T6elmxbeLIeOS9A1HdeUdDSh5LHB0Bputm
        W//7l0tiGquLjb2yHMM9N/si/0X82xsSrYYzv6fLS/94tf7E5hSUhVn1bR/PFz/MLVLPV4Mx
        +qdRhpNH2kbOZPpnn6AvTEaUxU1P+S8faqQFfRiqsohaI0v9JnbhdONn7YVRxZ8cz0tKVfaR
        uXct5zYcK2Bd3PWRz3s7DHuywkb0Z5+eUnEvjrXfsr/kyTIfg217hzeVW77Skt6TFcY5XXwJ
        36vgwflDRX2S/CGZ7u53Oam3FZsiJsYTb4YaFM0a8dEh/TUeTRsnFfrgGq30PzTypcGeBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvO452XkJBj+/aFqsu7OG3WLOqm2M
        Fqvv9rNZ7Lo4n9Fi2oefzBat7d+YLJoXr2ezOD1hEZPFk/WzmC16njSxWvztusdk8fVhscXe
        W9oWl3fNYbM4NLmZyWL65jnMFtfun2G3OHzvKovFwyUTmS3OnfzEajHvsYPFr+VHGS3e/7jO
        bnFqx2Rmi+vnprFZrN/7k81ByuPyFW+Pic3v2D12zrrL7rF5hZbH5bOlHptWdbJ57J+7ht3j
        /b6rbB59W1YxenzeJOfRfqCbyePQoWXMATxRXDYpqTmZZalF+nYJXBnLnr5mKljNW3Hp413W
        BsajXF2MnBwSAiYSl87MYu5i5OIQEtjNKPF64gM2iISUxPETb1m7GDmAbGGJw4eLQcJCAh8Z
        JebN9wOx2QR0JPre3gIrFxEQlbg3/QojyBxmgd8sErcffQRLCAMtODL5ATuIzSKgKrH4yiwm
        EJtXwFriaMcMVohd8hJ/7vcwg9icAroSG16uZIdYpiNx8eBnFoh6QYmTM5+A2cxA9c1bZzNP
        YBSYhSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4GjW0tzBuH3VB71D
        jEwcjIcYJTiYlUR4xZJmJwjxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUg
        tQgmy8TBKdXAtOb5c+eqLxI3lWPOynsnPDX9au0Ysu3YTrvOJ7yc0Qvbtxk3PnloPz34qoTC
        rc3FQvXlRz1VD5Yt8vMWlRM0nBOfsf9Q8da5EpI3p8rO8pAWMn3vpR1sEHGmav6rJwcW6256
        5fgvznkvv1Gc+O/s5IbyVR8+f2w9/NMsauMbAdPeYC25Leb+S38dTz1cWfbAIW+/ePfUA9ef
        PWpTPGxgETnnIm+28VJNx0+xr55P0qmfUqxw4duRCRs8dknrz/tm5apcOV/c3WhD6ALtoMux
        uk5PVwofN7Xgy/nlKZA7USzgtqs9y8eGsFUzJnSsjGMXtty7aqUZ59nNrvY7w08Zyax2Uter
        YN9teeQ8T8R3JZbijERDLeai4kQA872IyFUDAAA=
X-CMS-MailID: 20210514065054epcas1p4bd5c92a59d4010da4447ef62f65fdd4b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210514065054epcas1p4bd5c92a59d4010da4447ef62f65fdd4b
References: <YJ0MJe1Gc5XMV1gB@infradead.org>
        <CGME20210514065054epcas1p4bd5c92a59d4010da4447ef62f65fdd4b@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> FYI, I still think this whole limit is a bad idea, and instead we
> need to fix the algorithms to not waste time iterating over the bios
> again and again in non-optimal ways.  I still haven't seen an answer
> if your original latency problems are reproducable with the iomap
> direct I/O implementation, and we've also not even started the work on
> making some of the common iterators less stupid.

Sorry. I missed your request.
Actually iomap direct I/O implementaion in f2fs, or do_direct_IO() is not
easy to me. So I tested it on ext4 environment. iomap is applied in ext4
already. As a result, same performance degradation is reproduced.

I tested 512MB file read with direct I/O. and chunk size is 64MB.
 - on SCSI disk, with no limit of bio max size(4GB) : avg. 630 MB/s
 - on SCSI disk, with limit bio max size to 1MB     : avg. 645 MB/s
 - on ramdisk, with no limit of bio max size(4GB)   : avg. 2749 MB/s
 - on ramdisk, with limit bio max size to 1MB       : avg. 3068 MB/s

I set ramdisk environment as below.
 - dd if=/dev/zero of=/mnt/ramdisk.img bs=$((1024*1024)) count=1024
 - mkfs.ext4 /mnt/ramdisk.img
 - mkdir /mnt/ext4ramdisk
 - mount -o loop /mnt/ramdisk.img /mnt/ext4ramdisk

With low performance disk, bio submit delay caused by large bio size is
not big protion. So it can't be feel easily. But it will be shown in high
performance disk.

Limit bio size is not affact to stacked driver. it's for physical disk
driver. As your advise, algorithm fixing to remove waste time is needed for
each module. I agree with you. But I think it might be good submitting bio
when bio size is over than disk transfer size logically too.

Thanks,
Changheun Lee.
