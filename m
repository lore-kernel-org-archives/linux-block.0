Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255EAC433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 15:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045B6208D5
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 15:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T+sAuD3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgGBPme (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:42:34 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:49562 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgGBPmJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 11:42:09 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200702154206epoutp0270d717cf158dc162396a471c49a5a429~d_dLEooS41594515945epoutp02P
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 15:42:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200702154206epoutp0270d717cf158dc162396a471c49a5a429~d_dLEooS41594515945epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593704526;
        bh=hysM3c4xp8mz2RoHJXjNUcMrUuaAnVpURb0TToaAgcg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=T+sAuD3lgv9FTnfubK66Ip5wYe4fDi1Bo9Cs6gOY8M4X++maQYnZoK4ITD7aXEgEC
         dEfHG2SerCXKPLtsFYyLoi0pd4hlQmb/N65OW5OEgTZhQBjFtSQ+U5Khu49Wcd1iKW
         tJp4yVDRhLolQDzzRH7XF0pSfwQ28yezrX4NFdoQ=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200702154206epcas5p16cf30866565a800b0b47ddddd035ac44~d_dKdLsG52199921999epcas5p1u;
        Thu,  2 Jul 2020 15:42:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.93.09475.D400EFE5; Fri,  3 Jul 2020 00:42:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200702154204epcas5p15106774a3d556b77050710722da89922~d_dJR0RxH0362503625epcas5p12;
        Thu,  2 Jul 2020 15:42:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200702154204epsmtrp28b3a1b4bd241cf66c1da132bc730a710~d_dJQ7Fn91523715237epsmtrp2G;
        Thu,  2 Jul 2020 15:42:04 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-0f-5efe004da22b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.3A.08382.C400EFE5; Fri,  3 Jul 2020 00:42:04 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200702154203epsmtip14afc6ea65b1b130ba47eeba550dbd81a~d_dHyOAFO2839128391epsmtip1o;
        Thu,  2 Jul 2020 15:42:03 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     axboe@kernel.dk, kbusch@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, Damien.LeMoal@wdc.com,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 0/2] fix/extend zone-append in block-layer
Date:   Thu,  2 Jul 2020 21:08:48 +0530
Message-Id: <1593704330-11540-1-git-send-email-joshi.k@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7bCmuq4fw784g6NtjBa/p09htVh9t5/N
        orX9G5PFytVHmSyO/n/LZjHp0DVGi723tC0u75rDZnFlyiJmB06Py2dLPTat6mTz2H2zgc2j
        b8sqRo/Pm+Q82g90MwWwRXHZpKTmZJalFunbJXBlvL1kWXCWpWLC6uesDYyPmLsYOTkkBEwk
        9u3qAbOFBHYzSjz+w9/FyAVkf2KUePh1OVTiG6NE35EqmIbLn6azQhTtZZTYtLuPCcL5zCix
        +vYnoA4ODjYBTYkLk0tBGkQE1CT2LvrEBlLDLNDOKPHtcBcbSEJYwEriT287mM0ioCqx7fke
        FhCbV8BZYtXyRywQ2+Qkbp7rZAZplhA4xC6xbNU5VoiEi8ThR/1QPwhLvDq+hR3ClpL4/G4v
        G4RdLPHrzlGo5g5GiesNM6Gm2ktc3POXCeRSZqBL1+/SBwkzC/BJ9P5+AhaWEOCV6GgTgqhW
        lLg36SnUWnGJhzOWQNkeEm9ufmcFKRcSiJVYdcZ5AqPMLISZCxgZVzFKphYU56anFpsWGOel
        lusVJ+YWl+al6yXn525iBEe9lvcOxkcPPugdYmTiYDzEKMHBrCTCe9rgV5wQb0piZVVqUX58
        UWlOavEhRmkOFiVxXqUfZ+KEBNITS1KzU1MLUotgskwcnFINTObtDiqbf93SE2G1mrnYV8bJ
        Q/RyZP+uLTlM/zJTTxcXCIgsWrpvVcU0s90TVKs9+vdH5bQfPywYIflNcxpXQWvGRzdb3ZfH
        so+4T16w02ylTHC0usXFlD3Js3ltalMcNTf9UzwSr7ljUzTLx2Uivx6H7BafzHTJ2Wbb1a8z
        r86IsvKP1UnfuyRm2p/45+vNo2e5uQXfyrM/wPJSxCOnKvr5XaaQe4qisSt+6vscS8qv4Ndb
        5Z5v3ORWICVoFr5tg+zsRyIJEqePPjPd6bJX2fqHydYwIYvAvXJZ8lveftTJr+9jUuQ1bi55
        d23R/Y3a8x+nLF+pMdNWI0pucv9EHQ1Hq8U7BaXLt7PGPtyoxFKckWioxVxUnAgABli55WkD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42LZdlhJTteH4V+cwbFXuha/p09htVh9t5/N
        orX9G5PFytVHmSyO/n/LZjHp0DVGi723tC0u75rDZnFlyiJmB06Py2dLPTat6mTz2H2zgc2j
        b8sqRo/Pm+Q82g90MwWwRXHZpKTmZJalFunbJXBlvL1kWXCWpWLC6uesDYyPmLsYOTkkBEwk
        Ln+aztrFyMUhJLCbUWLX26NQCXGJ5ms/2CFsYYmV/56zQxR9ZJTo3vabpYuRg4NNQFPiwuRS
        kBoRAQ2JFZ+XMYHUMAv0Mkp8/zuFESQhLGAl8ae3nQ3EZhFQldj2fA8LiM0r4CyxavkjFogF
        chI3z3UyT2DkWcDIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzi8tDR3MG5f9UHv
        ECMTB+MhRgkOZiUR3tMGv+KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ894oXBgnJJCeWJKanZpa
        kFoEk2Xi4JRqYGqN2H9Fv8NCZ5PsfME0Np7XbcxBcSrCW/QyJJYlPirtSYsqrQy3nS8p2nB8
        ceapNYcE5Qp231K/9m/57c+bGZ9WHyufLR3N7ObDs/CbUm+9ucnWzKmLS2pM7vYVm/K1XX6f
        /FLno9CX67ur1rGoOPV0Hzu0ybb9ouuS7u8XImoXd57yKrRRY1P4LzDHOXdP4dF5f0tLshYf
        DXvQ+0TD+9vqdM9zWY7Fq8Q+OeklmS5oVe3bPPdk0NS0N2tuRihalX19Eyly+bndLV0WUbML
        1QwVT1VKK4L+xHVu3nR3R9jclcmilXP8Z2SU2habONu124m3GHirr1y70WuRnsQ143uhV0Vt
        b6+RSggJXB2nxFKckWioxVxUnAgA3oMPsZ4CAAA=
X-CMS-MailID: 20200702154204epcas5p15106774a3d556b77050710722da89922
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200702154204epcas5p15106774a3d556b77050710722da89922
References: <CGME20200702154204epcas5p15106774a3d556b77050710722da89922@epcas5p1.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

First patch is about returning failure (rather than success) when
max_append_sectors is 0. This prevents bio_iov_iter_get_pages() from
getting into an endless loop.

Second patch enables issuing zone-append with iov_iter of bvec type.
It adds a helper which is similar to __bio_iov_bvec_add_pages() but
takes zone-append limits into account.

Kanchan Joshi (2):
  block: fix error code for zone-append
  block: enable zone-append for iov_iter of bvec type

 block/bio.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

-- 
2.7.4

