Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF1C433ED
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 06:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5228161453
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 06:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhD2G5w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 02:57:52 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:10710 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhD2G5v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 02:57:51 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210429065703epoutp032b9779e32798249ba01308022b07b8a3~6Qdq4LiGd1509215092epoutp03N
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 06:57:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210429065703epoutp032b9779e32798249ba01308022b07b8a3~6Qdq4LiGd1509215092epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619679423;
        bh=G79yVibCe2K55l+NgP4yOi1BUZxF76594HnvvKnDoYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncQUsxgVnamnzBAPozVdFTbj6X5wFWIM0nRfkE4e2jPZq37zp80+1yif9Bmg/t7+l
         A+2Q/fZcWglcCTdqzZ5yPLZ0K35pfjxeVx8hnCDgF/yj76xCqTzpbqVrg9+e4Ob88Y
         d64B9lbbrCD/BHRELCSoLsTpvjrPo4tJwuUgRpfY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210429065703epcas1p2e3b4717b78dba073cb85c47b68771896~6QdqXfSVO1806918069epcas1p2F;
        Thu, 29 Apr 2021 06:57:03 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FW5sB0d9Gz4x9Q3; Thu, 29 Apr
        2021 06:57:02 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.04.09736.DB85A806; Thu, 29 Apr 2021 15:57:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210429065701epcas1p363667a6f0c598f27bb5afde32473ea39~6Qdo62nif2155021550epcas1p3c;
        Thu, 29 Apr 2021 06:57:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210429065701epsmtrp25a102e7ddb8bcaa0a68b51d968ad184d~6Qdo6CzmP2997629976epsmtrp24;
        Thu, 29 Apr 2021 06:57:01 +0000 (GMT)
X-AuditID: b6c32a39-8d9ff70000002608-4d-608a58bd21d5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.0A.08637.DB85A806; Thu, 29 Apr 2021 15:57:01 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210429065701epsmtip1f2c3898c9370c1cea000764e4c38371a~6Qdor_YNe2132421324epsmtip1e;
        Thu, 29 Apr 2021 06:57:01 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org
Cc:     axboe@kernel.dk, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, nanich.lee@samsung.com, yi.zhang@redhat.com
Subject: Re: [PATCH v2] block: Improve limiting the bio size
Date:   Thu, 29 Apr 2021 15:39:01 +0900
Message-Id: <20210429063901.9593-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <a1759842-eb14-e477-fdf6-b6844e5aa29f@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmvu7eiK4Eg7PbrSxW3+1ns9h1cT6j
        xbQPP5ktVq4+ymTxZP0sZou9t7QtDk1uZrK4dv8Mu8X1c9PYHDg9Ll/x9rh8ttRj06pONo/d
        NxvYPN7vu8rm0bdlFaPH501yAexROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
        Sgp5ibmptkouPgG6bpk5QHcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoMDQr0
        ihNzi0vz0vWS83OtDA0MjEyBKhNyMhZ+MCk4w1bx9cEu9gbGOaxdjJwcEgImEnsWrAGyuTiE
        BHYwSry/Oo8dwvnEKHHzbwcTSJWQwDdGib+3bbsYOcA69q81h6jZyyhx4MddqO7PjBJtjw6A
        NbAJ6Ej0vb3FBmKLCIhJXP7yjRGkiFlgNaNE683tYAlhARuJ5S93sYPYLAKqEod+3wZr5hWw
        ktjzfzkbxH3yEn/u9zCD2JwC1hJn9+xkg6gRlDg58wkLiM0MVNO8dTYzyAIJgVYOibmdz9kh
        ml0kjt+5zghhC0u8Or4FKi4l8fndXjaIhm5Giea2+YwQzgRGiSXPlzFBVBlLfPr8mRHkaWYB
        TYn1u/QhwooSO3/PZYTYzCfx7msPKyRceCU62oQgSlQkzrTcZ4bZ9XztTqiJHhJ7ri1hgQRX
        H6NEx8+fTBMYFWYheWgWkodmIWxewMi8ilEstaA4Nz212LDAFDmKNzGCU6qW5Q7G6W8/6B1i
        ZOJgPMQowcGsJML7e11nghBvSmJlVWpRfnxRaU5q8SFGU2BwT2SWEk3OByb1vJJ4Q1MjY2Nj
        CxMzczNTYyVx3nTn6gQhgfTEktTs1NSC1CKYPiYOTqkGJp4p/r2/1VVd/ktU1z+PNT9m/1TP
        0f3j0+SdOyd/Evt51sjgx37uzRbbXuRtjVj5uaIlorXk4TkbjrKD9ySrBPYee/LsrBfbJGeH
        n9cNWrp+Bot9PqXx82zlnL3th/aWPwxddvX15bjenKVT2bxclp3fPWWawYq66Iapifd2FH6Z
        cDtRcsKDB0srN27ovN32xDfkjOP1sLcXfpnGTupsOfLdInOmjK/B0gkFfvb8Uyyy69OmxWfn
        OXVumRCwm9NurX96UuQi6fJvSz+zp7AVlRtMcer42mdwoG7BU6Hp1xnyuSQW5ycdvlGlURtj
        sGv3wbgp4XtO2PDM5g589Me6W+7etIzlk79sYb0cHnIrjkmJpTgj0VCLuag4EQB8V0R7MgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSnO7eiK4Eg3/bpCxW3+1ns9h1cT6j
        xbQPP5ktVq4+ymTxZP0sZou9t7QtDk1uZrK4dv8Mu8X1c9PYHDg9Ll/x9rh8ttRj06pONo/d
        NxvYPN7vu8rm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkLP5gUnGGr+PpgF3sD4xzWLkYO
        DgkBE4n9a827GLk4hAR2M0pMe/2GuYuREyguJXH8xFuoGmGJw4eLIWo+MkocP3uIDaSGTUBH
        ou/tLTBbREBM4vKXb4wgRcwCWxkl3v5bygiSEBawkVj+chc7iM0ioCpx6PdtJhCbV8BKYs//
        5WwQy+Ql/tzvAVvMKWAtcXbPTjaQxUJANT/P+EOUC0qcnPmEBcRmBipv3jqbeQKjwCwkqVlI
        UgsYmVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgSHvJbmDsbtqz7oHWJk4mA8xCjB
        wawkwvt7XWeCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxS
        DUy20V+nvbtx0r5q2ZeYEHbVXo7Qa+/Tp/Fs5FtpWHO+6OunGJ2VRt+LGxc7/PWTtXBWU02J
        yQpkDk0PnflIfM2D6Y7CZhWPjbSKeizjYhYmx7f+rp778Oj15J+Op4yYNZTN1tyNTV5wZmuD
        QxSHz2xOk8Vaxi++3Nq1d2bgrB87L18+Pf1inb30au+b3z7N3aeo9q7ulnBN56/p2YdKe7YL
        yq6d1XBr8+ObjtsDm822yVoc9D5/d9WPLdNCDP67f0gp+nk5dfOC0Mkx14ROWe9PnXWGi0Nv
        S8HprYKWa0zj1NvClKsenMg0fcKzdNdRvetlZwLc7BpTF14+d2PVxcdPaz8eTT+7q/jRqdPG
        3GFcSizFGYmGWsxFxYkAMAQBkugCAAA=
X-CMS-MailID: 20210429065701epcas1p363667a6f0c598f27bb5afde32473ea39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210429065701epcas1p363667a6f0c598f27bb5afde32473ea39
References: <a1759842-eb14-e477-fdf6-b6844e5aa29f@acm.org>
        <CGME20210429065701epcas1p363667a6f0c598f27bb5afde32473ea39@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 4/28/21 12:21 AM, Changheun Lee wrote:
> > Actually I don't know why NULL pointer dereference is occurred with Bart's
> > patch in blk_rq_map_kern(). And same problem have not occured yet in my
> > test environment with Bart's patch.
> > Maybe I missed something, or missunderstood?
> 
> The call trace that I shared on the linux-block mailing list was
> encountered inside a VM that has a SATA disk attached to it and also a
> SATA CD-ROM. Does replicating that setup allow to reproduce the NULL
> pointer dereference that I reported?
> 
> Bart.

I can reproduce and see NULL pointer dereference in same call path without
your patch. But I can't reproduced it with your patch.
I tested in ubuntu via grub. SATA disk is attached only in my environment.
Actually I didn't test in VM yet. I'll try.

Thanks,

Changheun.
