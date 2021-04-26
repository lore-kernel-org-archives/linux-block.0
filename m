Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9171DC433ED
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 00:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E9F61040
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 00:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhD0ACD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 20:02:03 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:19448 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhD0ACD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 20:02:03 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210427000119epoutp02715ac1799440edfc650d58b77d859e13~5jgHAVbTG2169621696epoutp02L
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 00:01:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210427000119epoutp02715ac1799440edfc650d58b77d859e13~5jgHAVbTG2169621696epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619481679;
        bh=MNgDHKlVDksTKgzBFTI1KrpslHHnhsmPeed6h7/2oYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cas33J4i8gnKA6ywjaMOO6L3A1jxJx66QpfNnnetH2ayrSY8LMJtx9WgIukrk46+q
         8zs/c5MyoDXzItHI7ektN4D4sA5dN702wDWMEwB/UDI2qy8hgNXM3U2tqGlvkjByjk
         PYDtRz7YzNOHc+dSOUF7lGGYOoJwn+pfhbAnlVFA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210427000114epcas1p37797e4b6c0ba4c851dbc2a04371edaa2~5jgCjVYkp2065220652epcas1p3d;
        Tue, 27 Apr 2021 00:01:14 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FThkK0XZPz4x9Py; Tue, 27 Apr
        2021 00:01:13 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.86.09701.54457806; Tue, 27 Apr 2021 09:01:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210427000106epcas1p3f39e318e9211bf3378b3e4afad2de56e~5jf7moaiE2307623076epcas1p30;
        Tue, 27 Apr 2021 00:01:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210427000106epsmtrp23d4676e645b26f4fd5fe035792bde5a5~5jf7l8fKD0689006890epsmtrp2q;
        Tue, 27 Apr 2021 00:01:06 +0000 (GMT)
X-AuditID: b6c32a36-647ff700000025e5-b1-608754452508
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.4C.08637.24457806; Tue, 27 Apr 2021 09:01:06 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210427000106epsmtip1d3671dddcf0717d99dd754ab9e3c39b2~5jf7Zk-SD3023530235epsmtip1s;
        Tue, 27 Apr 2021 00:01:06 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     axboe@kernel.dk
Cc:     bgoncalv@redhat.com, bvanassche@acm.org, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, nanich.lee@samsung.com, yi.zhang@redhat.com
Subject: Re: [PATCH v2] block: Improve limiting the bio size
Date:   Tue, 27 Apr 2021 08:43:07 +0900
Message-Id: <20210426234307.7871-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <0f078c05-b212-3877-fa64-77fd79cc50ce@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmvq5rSHuCwZYv4har7/azWey6OJ/R
        YtqHn8wWK1cfZbJ4sn4Ws8XeW9oWhyY3M1lcu3+G3eL6uWlsDpwel694e1w+W+qxaVUnm8fu
        mw1sHu/3XWXz6NuyitHj8ya5APaoHJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
        JYW8xNxUWyUXnwBdt8wcoLuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWGBgV6
        xYm5xaV56XrJ+blWhgYGRqZAlQk5GZ/ubGAs2MBS8ePfY9YGxk3MXYycHBICJhJzHjWzdzFy
        cQgJ7GCUmPSggRnC+cQosWfZKkYI5xujxP9H25hgWhZens0EkdjLKNH/ZiIrhPOZUeLH3QYW
        kCo2AR2Jvre32EBsEQFhif0drWBxZoF1jBIvLyeB2MICNhLLX+5iB7FZBFQlPv2bCFbDK2Al
        sfrpDqht8hJ/7veAHcspYCuxcel7qBpBiZMzn0DNlJdo3job7G4JgUYOies/l7JANLtILDh9
        ih3CFpZ4dXwLlC0l8fndXjaIhm5Giea2+YwQzgRGiSXPl0GtNpb49PkzUIIDaIWmxPpd+hBh
        RYmdv+cyQmzmk3j3tYcVpERCgFeio00IokRF4kzLfWaYXc/X7oSa6CHR3fQVGtpAq17c7GWb
        wKgwC8lDs5A8NAth8wJG5lWMYqkFxbnpqcWGBUbIkbyJEZxWtcx2ME56+0HvECMTB+MhRgkO
        ZiURXrZdrQlCvCmJlVWpRfnxRaU5qcWHGE2BwT2RWUo0OR+Y2PNK4g1NjYyNjS1MzMzNTI2V
        xHnTnasThATSE0tSs1NTC1KLYPqYODilGph89lYwWG3cWKDAtDlM6caVcE9h95IWy1iWPcbq
        ihpxpaeufboaylIR0Npw+Y2CnZmdhI221zJh1mvGylmv3VjuCe4pNa7pvVAjVhVysGedUrPw
        z607Uw7bl8XZfTCKTj090aBr05dp+o/fvvfJZnj1dQu3X4XjY91FEx7NjHLatcTzV5bQluma
        ORkr6s7e97H5dsQ04s3W2k2fDigGX5y2QXt3qNOchM/qE256Pm38KibIpdepU6+jrVr7N0Te
        Kmq6aPqCVQwynhO2OkvZLVlpzpi+7HR3Xsm29fu+q9tyvMqenTDjj0Ru/jR3q0czZl28vCOh
        MHtvkMB+36qlxkuMczoak/YEvV3TyMaYpMRSnJFoqMVcVJwIAODazU40BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSnK5TSHuCwYQZphar7/azWey6OJ/R
        YtqHn8wWK1cfZbJ4sn4Ws8XeW9oWhyY3M1lcu3+G3eL6uWlsDpwel694e1w+W+qxaVUnm8fu
        mw1sHu/3XWXz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroxPdzYwFmxgqfjx7zFrA+Mm5i5G
        Tg4JAROJhZdnM4HYQgK7GSXm/LGGiEtJHD/xlrWLkQPIFpY4fLi4i5ELqOQjo8T9TZ3sIDVs
        AjoSfW9vsYHYIkA1+ztaWUCKmAV2MEp0T9gFtkBYwEZi+ctdYA0sAqoSn/5NZAGxeQWsJFY/
        3cEEsUxe4s/9HrB6TgFbiY1L37NAHGQj0fB4CytEvaDEyZlPwOLMQPXNW2czT2AUmIUkNQtJ
        agEj0ypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOCw19Lcwbh91Qe9Q4xMHIyHGCU4
        mJVEeNl2tSYI8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnV
        wJS3mql1vdvVPY4zfM5cDKsw+qt4wUci4lV72wftm+nMG2rmMf2WquTbzNxz5USR8tOZuQ9m
        NVR4cTX7fRbvCLDXF3mU1vW3sDpbYLqd7y6phcVdTbZPZNNUONviXnjK71GeX3ijLIWVkVl5
        S7iwvZf53kWNps8jKi5zL3/81TLypXbdTZu6zCiX1D0/LZUy7Iq/Kt2Rb/vx45RI1j8Z38+r
        b3lZvytyjzF3TjqgsVtnddW/ki/pOpVV5Ts8Hu7oOTjjyu5+jZlad32ijHwOvVm77274c67g
        UHUhLRdV+Zs3mP5H7ooT2dZ7b8nHmDPGszXnzLysb8bHOMPsZuHTK+oXXCPYa/5URVma+2oo
        sRRnJBpqMRcVJwIAnKygQOoCAAA=
X-CMS-MailID: 20210427000106epcas1p3f39e318e9211bf3378b3e4afad2de56e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210427000106epcas1p3f39e318e9211bf3378b3e4afad2de56e
References: <0f078c05-b212-3877-fa64-77fd79cc50ce@kernel.dk>
        <CGME20210427000106epcas1p3f39e318e9211bf3378b3e4afad2de56e@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 4/26/21 12:32 AM, Yi Zhang wrote:
> > Hi Jens/Bart
> > CKI reproduced the boot panic issue again with the latest
> > linux-block/for-next[1] today, then I checked the patch 'bio: limit
> > bio max size'[2] found Bart's fix patch does not fold in that commit,
> > could you help recheck it, thanks.
> 
> Hmm, maybe I botched it. But a bit too much churn around this patch,
> Changheun maybe you can resend a fully tested version?
> 
> -- 
> Jens Axboe

I'm really sorry Jens, and to all. I'll check and resend. Sorry again.

Changheun Lee.
