Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A459C77B75
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjESGF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjESGF2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:05:28 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CCF10D9
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:05:27 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230519060524epoutp029841c2e276c801f2cfd765f4533b8455~gdkq-NqgN1904819048epoutp02S
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 06:05:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230519060524epoutp029841c2e276c801f2cfd765f4533b8455~gdkq-NqgN1904819048epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684476324;
        bh=oOF8MuPYOH2An8FWy5GwcVNNVNFi8i99I8IMaZDpLXQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=pXM4sZ+y7s+HiyDRbHKUVHE5yhb3vIghn1c0nlI1Csn5etHBJbEVDhjjnG1jGnCAo
         O+74D1HluXiHPIkO1znNtn+8hzjuyz9CPkwBxWZ1xOSGEVe6UvwBoG9ePoyygnEteu
         YErx7wWkKj/jI2pcS2BjkjwSlNuvwSCukE0/6l+Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230519060523epcas2p11031c02214f44aa40527bb1bb50d0d83~gdkq0RPR31984019840epcas2p1k;
        Fri, 19 May 2023 06:05:23 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QMxCR3J2vz4x9QC; Fri, 19 May
        2023 06:05:23 +0000 (GMT)
X-AuditID: b6c32a46-b23fd7000001438d-52-646711a3ec0d
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.1F.17293.3A117646; Fri, 19 May 2023 15:05:23 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 2/8] block: use SECTOR_SHIFT bio_add_hw_page
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230512133901.1053543-3-hch@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230519060523epcms2p4ee7e528615b8a0ab090552c4f6cfd759@epcms2p4>
Date:   Fri, 19 May 2023 15:05:23 +0900
X-CMS-MailID: 20230519060523epcms2p4ee7e528615b8a0ab090552c4f6cfd759
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmhe5iwfQUgzuzpCxW3+1ns3h5SNNi
        5eqjTBZ7b2k7sHhcPlvqsftmA5tH35ZVjB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdcfnWZscCnYkbTROYGRocuRk4OCQET
        id/rprF1MXJxCAnsYJS4fPkrYxcjBwevgKDE3x3CIKawgIPEjsuJIOVCAkoS59bMYoQIG0jc
        6jUHCbMJ6En8XDKDDcQWAaqevWEpmM0sYC+x93YrI8QmXokZ7U9ZIGxpie3Lt4LFOQWMJHo7
        DkHVaEj8WNbLDGGLStxc/ZYdxn5/bD5UjYhE672zUDWCEg9+7oaKS0ocOvSVDeQ0CYF8iQ0H
        AiHCNRJvlx+AKtGXuNaxEewEXgFfiY8rF4F9wiKgKnF2ah1EiYvE+ZYjLBDXy0tsfzuHGaSE
        WUBTYv0ufYjhyhJHbkFV8El0HP7LDvNfw8bfWNk75j1hgmhVk1jUZDSBUXkWIohnIVk1C2HV
        AkbmVYxiqQXFuempxUYFRvA4Tc7P3cQITnFabjsYp7z9oHeIkYmD8RCjBAezkghvYF9yihBv
        SmJlVWpRfnxRaU5q8SFGU6AfJzJLiSbnA5NsXkm8oYmlgYmZmaG5kamBuZI4r7TtyWQhgfTE
        ktTs1NSC1CKYPiYOTqkGJsnypxc3aoXuntlueqw6YZNzSfP6HWozREye5C2PuzPfdZnzNv/4
        7qCn5Xc6o3z3G7nKdtW6fFjAfytBwVov6Pdrweo831wGy8mHhZZ+W78/fLZaZq/Qp9c7Hkdd
        uxuou7N17Sbv/YHW+w4rvQ1ZemxF/nFrdfWJAWm9py+WfNu2svlv3qRdisqdned/Ntep/ZF1
        /Rtasnwjz9X5/jP/zDAVPdG4rNhky/fSpQvXfTEXLavueP3vhfLRxkqzJNHdASaCWs2MNpk6
        a9+biLB6va0/l7b61edDXp6GlRwLt8ZcCk+z/vZai/H1t/xffjnW9zyEF2k9PfM8c05CpOKk
        0FdXG6M29R6x25yocaSoUomlOCPRUIu5qDgRAA58TKH6AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230512133923epcas2p28f1f1ac6aa6a34c70ddb60c2fae7ee6c
References: <20230512133901.1053543-3-hch@lst.de>
        <20230512133901.1053543-1-hch@lst.de>
        <CGME20230512133923epcas2p28f1f1ac6aa6a34c70ddb60c2fae7ee6c@epcms2p4>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me,

Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
