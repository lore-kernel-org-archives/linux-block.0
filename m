Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AACDC433ED
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 10:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C75260BBB
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 10:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhEMKVj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 May 2021 06:21:39 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:46253 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhEMKVe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 May 2021 06:21:34 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210513102022epoutp01b3183de954c93831756c47441262061b~_mRLUDM6b2762027620epoutp01k
        for <linux-block@vger.kernel.org>; Thu, 13 May 2021 10:20:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210513102022epoutp01b3183de954c93831756c47441262061b~_mRLUDM6b2762027620epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620901222;
        bh=dBhV4HMCwrJY+wzRN3TXZNcHKDa/PokNUw/sRTs01Qg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Fk20JzaSq/BazUGsgR7x7cJtP5mnZ/Dj+45P9GQdriG+7K6ALe1+7LN492VZs8hy8
         oepIwJfen3XDk5CUG9gAuV1MZj/XPtf+jXhXqqYxadMGH6naWlLiIwczS+cpXAdl1r
         8CzZMZt1scFkyw3tbxMTuN+Xl8vC0S4L6Qr/H1HI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210513102020epcas1p148bd2649b9b22cbfd0a3e5ffb4177154~_mRKKJARC2839628396epcas1p1E;
        Thu, 13 May 2021 10:20:20 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FgnjH3Rscz4x9Pw; Thu, 13 May
        2021 10:20:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.58.09701.36DFC906; Thu, 13 May 2021 19:20:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210513102018epcas1p2a69f8e50cdf8380e433aea1a9303d04c~_mRIRfz952795127951epcas1p2E;
        Thu, 13 May 2021 10:20:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210513102018epsmtrp175f54beaca115ca661520b6123d21eb0~_mRIQK_pl0664606646epsmtrp1c;
        Thu, 13 May 2021 10:20:18 +0000 (GMT)
X-AuditID: b6c32a36-647ff700000025e5-c4-609cfd6313e1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.B4.08163.26DFC906; Thu, 13 May 2021 19:20:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210513102018epsmtip2ef3dab1e338e022c50c948ba45c20c0a~_mRH8atTL3252832528epsmtip29;
        Thu, 13 May 2021 10:20:18 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     alex_y_xu@yahoo.ca, yi.zhang@redhat.com, jaegeuk@kernel.org,
        bgoncalv@redhat.com, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, bvanassche@acm.org,
        damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v10 0/1] bio: limit bio max size
Date:   Thu, 13 May 2021 19:02:04 +0900
Message-Id: <20210513100205.17965-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxze6S23LRnkWp2csES6RuJkA1qgcJwwyUC9CyQjMXOLy4QCVyCW
        9tLbqlPZwA4olPAQBspLmM4hgl0QkHarc2VCqqxh4TUZggywuoG8dBtsZCu9uPHf7/vyfb/H
        d3L4mPAf3JufptRQaqVcIcbduR1dOwP9k1ZrEiTL97zQtdFmHqpp6gDo6v1iHJl/vABQxfwy
        hnLyfucg3UUjju6WfM5BU8YqDBVOnXFDqwVjHPRsgkGWkddQv7kGR9YyHQdVXq/B0NB4Lw91
        jQ1y0cSlUgzZbYtuqG4yEq18eRuguT+HeehOZxmGhu0VODJalvFIb7J/IIYs1T3hkaaq+zzy
        eqMf2f+DlmxtysfJb2ubeeTczUGcLGprAuRS6zYy75aBQ1qtl7G4Fw8pwlMpeTKlFlHKJFVy
        mjIlQhxzID4qXhYqkfpLd6EwsUgpT6cixNGxcf770hTOCMSiY3KF1knFyRlGHPhmuFql1VCi
        VBWjiRBTdLKClkroAEaezmiVKQFJqvQ3pBJJkMypTFCkWnvKAf0ddqK+zy8LDHIKgIAPiRDY
        dz7frQC484VEJ4BPSxwcFiwCOHN2CWfBEoCVLcOgAPBdFntdBsubAey23Ob9J6rOzsPW+uLE
        67BodsTl3kLUYrCh+SFYAxgxCeCALRdfU20mJNA+NwvWai7hC/OHR1y8B7Ebmru/4LIb+sC/
        xwsxlt8EbeenXDzm5HXt1dhaU0joBHCofMyNNUTDxz/fWa83w1972nhs7Q0fF+fyWIMBQF3u
        BcCCEgAvOS6vBxIMF5eWXJdixE5oNAey9CvQ9FctYCd7wifPCt3YMDygPlfISrbD3k/Hseez
        HC2m9Y4kLDrT49pHSHwI62ZKsBLgU7XhnqoN91T9P7geYE1gK0Uz6SkUI6WDNr5rK3D9BL/Q
        TnB2dj7ACjh8YAWQj4m3eGxNrE4QeiTLPzpJqVXxaq2CYqxA5ky4FPN+KUnl/EpKTbxUFhQc
        HIxCQsNCZcFiL4+UqFMJQiJFrqGOUhRNqZ/7OHyBdxYHWG5m7DnQN9RYf244Vhlu0vStNiwY
        fB9VRL6wo9J02vTNEfyn4yvH+eUtsXZ3PYwZ0sdN14m2vSrzyUn0+WTXwvLbooWI2eK3nv5i
        v7jyYOiqlu8ukFXr99+4NpCtubc9yKIcyDQHhBYfbtbXd9WFZe7xM8C7xsDdghumGbqn9+T3
        tvbswJC88c4P9rZu2vHHZ6Oq5miH7dB8hxfh+95Rfs5oj8Gi9rTNBL1jce8uasvAyqJkvxke
        XvEM5xpvfTwxDR7Rh0/Q+pfff3AQnquWag42nJp2HEOT5Yoj++I1ZOIVgWZvVmxDRLvefnp/
        UWNCXF+m6eu5bvpd2VfTIY6pXDGXSZVL/TA1I/8XS9tgjJIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRiA+853dna2mh2nuS+lpGFC06zE4DOl9E+cLlBREQTlVp6W5C7t
        pJb5Y7TStsyU7mtd0C7jZBma5lZabZSZNRRvJTMVzT9lWpplZeSSoH/f+zzPy/fjpaFcIMPp
        DP0BzqTXZCopKVnjVUYu3jXpUC/NfxuN7/rLxdgh1AB8u/sUhd0tVwE+NzIB8bGCcQJbyioo
        3FRcSuCBCjvEhQNHRHjS9o7AX/t4XNcVg1vdDgp7TlsIfL7KAXFHzysx9r5rJ3Hf9RKIfY1f
        RPhKfwr+cesZwMPfO8X4Ze1piDt95yhcUTdBpYSzrW3r2BLLJzHrsneL2Sqnim19ncVWClaK
        fXy5XMwO17dTbNF9AbCjlfPZgicnCNbjuQk3ztouTU7nMjOyOdOSlWrpXk/DGWB8Cg9ea1aZ
        QTthAzSNmATku7LfBqS0nKkFqLilZYpLpng4angxJJpuQpDXy083nwGa9FWLAg3FxKKioS4q
        IEKZaojGSs+AwACZDwDZ+kvJQBXCLEW+4SEQeJPMQmTtDGxIaBmThNzPb5DTv0WiXz2FcJoH
        o8aLA385nOKW6kuwGATZ/1P2/9Q1QAhgLmfkdVodv8wYr+dy4niNjs/Sa+N2G3SV4O85Vapa
        8EgYifMAggYegGioDJWF7bqklsvSNYdyOZMhzZSVyfEeEEGTSoWs2daYJme0mgPcPo4zcqZ/
        lqAl4WbCkHzybfTy42Bwtbl81cu11kTJnF5d0/tUcStk54wO0moC5a0SDNb3PGGsahpLC553
        fc33HaPyca13s/NYdo/wyztRFPltX+HnmmqLCIwlDeoPJ8X/9KsvfKqPmnTvuSPTBseud2ww
        B7PbfEHpsYtKcs8eyoquVegiFKkrzOP3XP5UYevBKH2O+qEpm5+dsPz8prHOj4r+th1lGa6q
        J5o8Y+LCPWbnPGvum25Y4P4qqDoqEwv6nbLesK0rXOnO50FHM247XBI7GZnUm6j1l0fHjPwO
        nUk8KFM2zyreyW7xt42GjQfl9eXnyWKkhrYBh4bpkC3IvDkDKaIeUUqS36tZpoImXvMHVjan
        ij0DAAA=
X-CMS-MailID: 20210513102018epcas1p2a69f8e50cdf8380e433aea1a9303d04c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210513102018epcas1p2a69f8e50cdf8380e433aea1a9303d04c
References: <CGME20210513102018epcas1p2a69f8e50cdf8380e433aea1a9303d04c@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

 v10 modifications
 1. bio_max_bytes is set to "BIO_MAX_VECS * PAGE_SIZE" as minimum.
 2. fix maxsize when iov_iter_get_pages() is call in
    __bio_iov_append_get_pages()

Changheun Lee (1):
  bio: limit bio max size

 block/bio.c            | 17 ++++++++++++++---
 block/blk-settings.c   |  7 +++++++
 include/linux/bio.h    |  4 +++-
 include/linux/blkdev.h |  2 ++
 4 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.29.0

