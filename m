Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B83C77B75
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjESG1i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESG1h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:27:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDC51AD
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:27:36 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230519062734epoutp04dde45dcc3f091c197744627067b87023~gd4CPTzNI1269712697epoutp04c
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 06:27:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230519062734epoutp04dde45dcc3f091c197744627067b87023~gd4CPTzNI1269712697epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684477654;
        bh=oOF8MuPYOH2An8FWy5GwcVNNVNFi8i99I8IMaZDpLXQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=IU1q00wow350pKnNZsbOOtjzyH09gC+YnYs3TpluEiOOXRApii7IceJYugiRvOZP0
         yOACIgpKvXoR9+cNxOj63e4bo+JZQZS7P+RxPE0+lj8WvIW2FS0n+NyBwR1apWkZRp
         7VC06X70tJBNn25bK8ndm9wI9/aQsjmGGWZYFqzg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230519062734epcas2p4ebfe116425be61b06b09be1bf3ac9fa8~gd4B_wIXq1418014180epcas2p4V;
        Fri, 19 May 2023 06:27:34 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QMxj20CwTz4x9Pt; Fri, 19 May
        2023 06:27:34 +0000 (GMT)
X-AuditID: b6c32a46-8b7ff7000001438d-08-646716d52a5e
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.BF.17293.5D617646; Fri, 19 May 2023 15:27:33 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 7/8] block: move the bi_size update out of
 __bio_try_merge_page
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230512133901.1053543-8-hch@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230519062733epcms2p6b9ddc6d3368c1572eedc95461fdffdce@epcms2p6>
Date:   Fri, 19 May 2023 15:27:33 +0900
X-CMS-MailID: 20230519062733epcms2p6b9ddc6d3368c1572eedc95461fdffdce
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmhe5VsfQUg9OHbSxW3+1ns3h5SNNi
        5eqjTBZ7b2k7sHhcPlvqsftmA5tH35ZVjB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdcfnWZscCnYkbTROYGRocuRg4OCQET
        iQtXRboYuTiEBHYwStzZv5wFJM4rICjxd4dwFyMnh7BAqMTE/7NYQWwhASWJc2tmMYKUCAsY
        SNzqNQcJswnoSfxcMoMNxBYRcJCYvWEpmM0sYC+x93YrI4gtIcArMaP9KQuELS2xfflWsDin
        gJFE/8rNTBBxDYkfy3qZIWxRiZur37LD2O+PzYeaIyLReu8sVI2gxIOfu6HikhKHDn1lg/gq
        X2LDgUCIcI3E2+UHoEr0Ja51bAQ7gVfAV+L/vHtgY1gEVCVedX6AWuUisX1yE9T58hLb385h
        BhnJLKApsX6XPsR0ZYkjt1ggKvgkOg7/ZYd5sGHjb6zsHfOeMEG0qkksajKawKg8CxHIs5Cs
        moWwagEj8ypGsdSC4tz01GKjAiN4pCbn525iBCc5LbcdjFPeftA7xMjEwXiIUYKDWUmEN7Av
        OUWINyWxsiq1KD++qDQntfgQoynQkxOZpUST84FpNq8k3tDE0sDEzMzQ3MjUwFxJnFfa9mSy
        kEB6YklqdmpqQWoRTB8TB6dUA5NEK5NWSV+jZ9yxnsbJb/987GPUu7ombRPXn0O/r+xT5edq
        m5svnhxyqvYsl6rO5NnHPu5QZVX/b3OWOct6ypozbMc8A+Y/mGDII2u4a0Wx2OknnzYuqqnb
        VHIh55dhY2itO/NpXvX736Uvflny/7Opv6nTtvsWAg2aeXmSf7c4Ck/hcbIpO3qufIGiuvqb
        Z+n3zA+oGXCfkdL5cfnDiqhfc3u1dnQ8+rPvW7Kvw99d+y0bHqcL/N9WIpIYUvGn4NR/vZ4d
        Pz3M1+v0ZBzZW8qp2OF7wmxddWrpdY5d6xr8unNEF9gtnnKsZuq9b5vqvk549lBDLU115c7t
        7e3HPjgWK7B6J3EtEIo8LzV1tZ0SS3FGoqEWc1FxIgCK5iQ6+wMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230512133935epcas2p24ea612299a0d11eb4bcb62ce74b148b3
References: <20230512133901.1053543-8-hch@lst.de>
        <20230512133901.1053543-1-hch@lst.de>
        <CGME20230512133935epcas2p24ea612299a0d11eb4bcb62ce74b148b3@epcms2p6>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me,

Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
