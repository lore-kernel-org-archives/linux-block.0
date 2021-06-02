Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F8EC4708F
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF19F613BF
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFBMa6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 08:30:58 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:62677 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFBMa5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 08:30:57 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210602122913epoutp02bea8cdd43ae5ed98726a546f27ee18c8~Ew7Y9TfGv0259302593epoutp02K
        for <linux-block@vger.kernel.org>; Wed,  2 Jun 2021 12:29:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210602122913epoutp02bea8cdd43ae5ed98726a546f27ee18c8~Ew7Y9TfGv0259302593epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622636953;
        bh=woOP6Geg9KvqiLtlElYG3X44Jz/VfEkIs7qnjn4k4Ss=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZeeaJHl9WxtE90fNf8UhhTTq4JexaMp7rm7xg+1J4ItANaRSw1Wrho30+zV71obl9
         hIZNpCwD8z0ecVu1mIlNkKjKG9etB9OvVlBI3SYw4u0pRaI6sW48Lw0B6dBKw17726
         q/885OMgkMxT3lMTbymVaw/e1jaJquzGONZ9dgCI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210602122912epcas1p39079b0f078a6aeecb6c9775a69a89531~Ew7X2iyM_0844208442epcas1p3x;
        Wed,  2 Jun 2021 12:29:12 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Fw7ck5jt3z4x9Pq; Wed,  2 Jun
        2021 12:29:10 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.C5.10258.69977B06; Wed,  2 Jun 2021 21:29:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210602122909epcas1p4f4cad512dd31ed9458ca6049c5074b71~Ew7VDBZdU2784327843epcas1p4o;
        Wed,  2 Jun 2021 12:29:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210602122909epsmtrp2a55e7d3a95a98289fe2c1f5ffccbb1ff~Ew7VBwV9S2283522835epsmtrp2X;
        Wed,  2 Jun 2021 12:29:09 +0000 (GMT)
X-AuditID: b6c32a38-42fff70000002812-ec-60b779963542
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.0C.08637.49977B06; Wed,  2 Jun 2021 21:29:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210602122908epsmtip1cad040e318db0dc23284976f6611222f~Ew7Uudnja0104801048epsmtip1P;
        Wed,  2 Jun 2021 12:29:08 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     hch@infradead.org, Johannes.Thumshirn@wdc.com, alex_y_xu@yahoo.ca,
        asml.silence@gmail.com, axboe@kernel.dk, bgoncalv@redhat.com,
        bvanassche@acm.org, damien.lemoal@wdc.com,
        gregkh@linuxfoundation.org, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com, yi.zhang@redhat.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v11 0/3] bio: control bio max size
Date:   Wed,  2 Jun 2021 21:10:34 +0900
Message-Id: <20210602121037.11083-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjO10NPW7HsUJh+1BtrxhJwXMrNT0c3Fwg76LKw6eJmIFDoGTSW
        tvYUY1lERhWwMC2QlQwouIGXMbURikIXxlLcFLllAiMhAyTUgUyunQTGhLWcmfHveZ73eb43
        7/vl5WKCNVzIlSu1lEYpVYjwLR53OgKDg026u6lhC48C0K3fb3BQdcMdgL4fuYQj26+1AJnm
        VzB0vnCJhfR1Fhx1Gb9lIYelEkMljnw2emEYZaHn4zRqG96L+m3VOLKX61mooqkaQ7+NdXNQ
        x+igBxqvL8VQb+ciG9VMHER/X/sZoLnlIQ562FKOoaFeE44sbSv4QSHZP3CYLNXPcsjWyhEO
        2XQ9iOzvySYbGy7gZLv5Boec+3EQJy9aGwDpbNxNFv5UzCLt9qtY4tbjiphMSiqjNP6UMl0l
        kyszJKLDR1JiU6Kiw8TB4v1on8hfKc2iJKK49xOD4+UK1wpE/qekimyXlCilaVHo2zEaVbaW
        8s9U0VqJiFLLFGpxmDqElmbR2cqMkHRV1gFxWFh4lMuZqsic/cME1FbuaVt/HTsPGHED4HIh
        EQkHpkUGsIUrIFoAdPzVizNkEcB7hvb/yBKARSMGzAB4G4n7M1Y2U2gD8MGjSQ5DnAAalxc2
        XDjxJrw4M4y7sS9Ri0HbCO02YcQEgAOdBRsFHyIc5ln6NrAHEQBnrGXAjfnEW/Bc7RTOtNsD
        /xkrwRjdG3Z+7fBwY8yl65urMPejkCjkwaFfVtlMIA7eHlsDDPaB0/etHAYLoXO2DWcCxQDq
        C2oBQ4wA1k9eZTGuCLjodAL3bjAiEFpsoYz8GmxdNQOmsxecfV7CZtbHh0UFAsbyOuw+N4a9
        7DV5s5XFWEjoaPZzywIiGT7oqsKNYE/lpnEqN41T+X/fywBrANsoNZ2VQdFideTmb20EG4cQ
        hFqAeWY+xA5YXGAHkIuJfPnvKZtTBXyZVJdDaVQpmmwFRdtBlGvBpZjw1XSV65KU2hRxVHhE
        RASKjN4XHRUh2s7PiP08VUBkSLXUCYpSU5qXORaXJ8xjQb9n+x9aHLfrfvCy7fBMPik/I+tb
        fWJL6zldcOnLD+flxUVBdyc/u/Zn4C5TyLP1CfPo8FK7BI+fCT3xzl6oG6ipybnyTZVR5XWM
        V77YuJD/3XW+Yeqo9t2q1iz/2JIzklPJj4+Vxu2aM+3cnZRrF3ZxsUOGYt7gTd/6L/IPBW1r
        7L5iPqJt8jT3lM3zjoev75hPmmbr0wfiDfdW2LNpi77jCWVnOYbulkFvyS3lk0/riSSdT85H
        1TEclU7YV3qgTffx06JXcv2S0s6Dr7avPZU5vS5vte58w7HMj24h10/2efZJKhI6kiy5Fz4h
        Ao4meE9Y5BVTk2d7C1+Eez8O0H0wIfKgM6XiIExDS/8F4o9s1ZEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSnO6Uyu0JBldum1msu7OG3WLOqm2M
        Fqvv9rNZ7Lo4n9Fi2oefzBat7d+YLJoXr2ezOD1hEZPFk/WzmC16njSxWvztusdk8fVhscXe
        W9oWl3fNYbM4NLmZyWL65jnMFtfun2G3OHzvKovFwyUTmS3OnfzEajHvsYPFr+VHGS3e/7jO
        bnFqx2Rmi+vnprFZrN/7k81ByuPyFW+Pic3v2D12zrrL7rF5hZbH5bOlHptWdbJ57J+7ht3j
        /b6rbB59W1YxenzeJOfRfqCbyePQoWXMATxRXDYpqTmZZalF+nYJXBnvnk1jLNjCUbHr8mLW
        BsYJbF2MnBwSAiYSx99uYe1i5OIQEtjNKHFszWlWiISUxPETb4FsDiBbWOLw4WKImo+MEl8f
        zWEBqWET0JHoe3sLbJCIwFZmicct8iBFzAKvGSW6Hi8CKxIWMJJoWH8erIhFQFXi7ZZJjCA2
        r4C1RMv8F1BXyEv8ud/DDBEXlDg58wlYLzNQvHnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55b
        bFhgmJdarlecmFtcmpeul5yfu4kRHJ9amjsYt6/6oHeIkYmD8RCjBAezkgive97WBCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYqoQXMr2sWOYgeVZB
        yqrCyis19N6j3nmOV4SbOBolDnRf3/rSXHthl8yDBVN3X/MxvGB84BfbupxFvef9vst0LL4c
        X/7c/vyZh4e9Ild9+cHy9auUd0vDpHsib5VSrHfb9R1NKtvm3edveFnp/44roc4JesfPdbNp
        nmdxWZ36UvvC3OXH779ddPcJs2q5S/jmosX2Sndvlpim/1x0eummdyd8Vhy/aTU1enu/9Z17
        r49UMu2wUk3VvhPPwHaiudzkttJC6zuPYkOO33xxZf/keRvtbeOmSR6b3SChaizo9vfMt+SK
        g0fmMIomhx2wZHX1nMLb4Jj02GnrgXP2Psznqy8m8E3TYW784+ilF3rLT4mlOCPRUIu5qDgR
        AKL5TTk+AwAA
X-CMS-MailID: 20210602122909epcas1p4f4cad512dd31ed9458ca6049c5074b71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210602122909epcas1p4f4cad512dd31ed9458ca6049c5074b71
References: <CGME20210602122909epcas1p4f4cad512dd31ed9458ca6049c5074b71@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio size can grow up to 4GB after muli-page bvec has been enabled.
But sometimes large size of bio would lead to inefficient behaviors.
Control of bio max size will be helpful to improve inefficiency.

blk_queue_max_bio_bytes() is added to enable be set the max_bio_bytes in
each driver layer. And max_bio_bytes sysfs is added to show current
max_bio_bytes for each request queue.
bio size can be controlled via max_bio_bytes.

Changheun Lee (3):
  bio: control bio max size
  blk-sysfs: add max_bio_bytes
  scsi: set max_bio_bytes with queue max sectors

 Documentation/ABI/testing/sysfs-block | 10 ++++++++++
 Documentation/block/queue-sysfs.rst   |  7 +++++++
 block/bio.c                           | 17 ++++++++++++++---
 block/blk-settings.c                  | 19 +++++++++++++++++++
 block/blk-sysfs.c                     |  7 +++++++
 drivers/scsi/scsi_lib.c               |  2 ++
 include/linux/bio.h                   |  4 +++-
 include/linux/blkdev.h                |  3 +++
 8 files changed, 65 insertions(+), 4 deletions(-)

-- 
2.29.0

