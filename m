Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1EBC001B0
	for <linux-block@archiver.kernel.org>; Tue, 25 Jul 2023 01:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjGYBlr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 21:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGYBlr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 21:41:47 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFDF171E
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 18:41:44 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230725014141epoutp042a1674f41c8c53e77aa6aa4f02e86f9b~0_MjaDIQh2604426044epoutp04v
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 01:41:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230725014141epoutp042a1674f41c8c53e77aa6aa4f02e86f9b~0_MjaDIQh2604426044epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690249301;
        bh=oOF8MuPYOH2An8FWy5GwcVNNVNFi8i99I8IMaZDpLXQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=CyNJCmxztUx95u5gXUWHC7b9++9vIKpouFeJgThXR474Ne9clfpYvKxM70MGwZPqz
         MKYjeUNj4lCK+fD2cbxKWHl58xhvtYbnm7QqTLj9heNXnPuQMcHlkcdDUk00Aiw8di
         Wgoiwl4q0NzVv4n+fr4w0gweDE5Np+Va3XhDrznM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230725014141epcas2p2cb1a8a0265705d37b1bd68ccac92858f~0_MjHakEO2590825908epcas2p2z;
        Tue, 25 Jul 2023 01:41:41 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4R90BF0Twdz4x9Q0; Tue, 25 Jul
        2023 01:41:41 +0000 (GMT)
X-AuditID: b6c32a48-87fff70000007e89-f7-64bf2854e9b8
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.0E.32393.4582FB46; Tue, 25 Jul 2023 10:41:40 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/8] block: tidy up the bio full checks in
 bio_add_hw_page
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230724165433.117645-2-hch@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230725014140epcms2p85f29d559a650738c209603e77862b145@epcms2p8>
Date:   Tue, 25 Jul 2023 10:41:40 +0900
X-CMS-MailID: 20230725014140epcms2p85f29d559a650738c209603e77862b145
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmhW6Ixv4Ug6v3rC1W3+1ns3h5SNNi
        5eqjTBZ7b2k7sHhcPlvqsftmA5tH35ZVjB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdcfnWZscCnYkbTROYGRocuRk4OCQET
        iWXzljJ3MXJxCAnsYJQ4e3YeYxcjBwevgKDE3x3CIKawQIDEk8uMIOVCAkoS59bMArOFBQwk
        Wm63sYDYbAJ6Ejue72YHsUUEHCRmb1jKBmIzC9hL7L3dygixildiRvtTFghbWmL78q1gcU4B
        Q4nbt1azQ8Q1JH4s62WGsEUlbq5+yw5jvz82H2qOiETrvbNQNYISD37uhopLShw69JUN5GQJ
        gXyJDQcCIcI1Em2/3kOV60tc69gIdgKvgK/ErZNTwFpZBFQldsyexARR4yKx5e4tZojz5SW2
        v53DDDKSWUBTYv0ufYjpyhJHbrFAVPBJdBz+yw7zYMPG31jZO+Y9YYJoVZNY1GQ0gVF5FiKQ
        ZyFZNQth1QJG5lWMYqkFxbnpqcVGBSbwWE3Oz93ECE5zWh47GGe//aB3iJGJg/EQowQHs5II
        r2HMvhQh3pTEyqrUovz4otKc1OJDjKZAT05klhJNzgcm2rySeEMTSwMTMzNDcyNTA3Mlcd57
        rXNThATSE0tSs1NTC1KLYPqYODilGph68+bnPtnzPXXVgSXWH29W/T0Rs/zegoOTNwp/3my5
        4th/c+trnnFMwhGL95geman08XRuXulr0buXl4VclTB8zPbvw/2s604JThzvNla/1bXR3Gt2
        pjd99r8fht5v1SQ/RGr23f3+POXQG2PVtrSN+yf/XPGr/PGlZ7c37rBfJWW01l76T03r/12q
        KhOO9xjNKZfIvRbkvmlKifHFCys2PMsOZbsbsfu0vc3kxfpZNssqvL6eveNq8nj+BfmCLx37
        V8pNDgkR2HPggZcn463vs75aKCzoW2nr+ujYI7bjy0QuVxwSZwnoM5eePo/7/5mAA+KXX8wQ
        ac8Tij86f+qexVdnfnN7OeuVX4p8uf9OdT0lluKMREMt5qLiRAAuHN6j/AMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230724165440epcas2p1f17d8a23f72ff5016eed8cdbd28005cb
References: <20230724165433.117645-2-hch@lst.de>
        <20230724165433.117645-1-hch@lst.de>
        <CGME20230724165440epcas2p1f17d8a23f72ff5016eed8cdbd28005cb@epcms2p8>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me,

Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
