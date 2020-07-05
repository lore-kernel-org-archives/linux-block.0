Return-Path: <SRS0=GQ+f=AQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6BFC433E0
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 19:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D88320760
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 19:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n12YwTLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgGETdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:33:45 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:38230 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgGETdl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Jul 2020 15:33:41 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200705193338epoutp04025b33a0f5f5b33eefa36988e794c417~e8jLn8x700667006670epoutp04n
        for <linux-block@vger.kernel.org>; Sun,  5 Jul 2020 19:33:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200705193338epoutp04025b33a0f5f5b33eefa36988e794c417~e8jLn8x700667006670epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593977618;
        bh=+bk2lmZ7gPPPzttyHRqxEmsrZ661RY3hev7QPoHymss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n12YwTLbuOZ8sDvazG6o5Ig5khq2QBGP7KHi9INq9NJz/KiwsZ4L5GhUBbRKyO26+
         jBpDcnslHuEpA07TodfsDXeQSqC71fgGPOgZo21UAHguuNLihkAeoTwjX1C02azQrV
         03sTDAQpWkm5sioyS0qttCKA1afObWHSbGJtWLL0=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200705193337epcas5p38b3241a80f295a850f02f80116223afd~e8jLC2ESo1042010420epcas5p3V;
        Sun,  5 Jul 2020 19:33:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.56.09475.11B220F5; Mon,  6 Jul 2020 04:33:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200705193337epcas5p4b15eec1bbd6dd687f706f9b8fd93c14a~e8jKnGSe71079210792epcas5p4V;
        Sun,  5 Jul 2020 19:33:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200705193337epsmtrp2f9305ac5378e00d951f1adcb31de8bb8~e8jKmYTgC0744407444epsmtrp2H;
        Sun,  5 Jul 2020 19:33:37 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-3d-5f022b11a440
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.B4.08382.11B220F5; Mon,  6 Jul 2020 04:33:37 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200705193335epsmtip104c777968086b6fa02de6131c3251a7d~e8jJJoqDZ3114531145epsmtip1R;
        Sun,  5 Jul 2020 19:33:35 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien.LeMoal@wdc.com, Kanchan Joshi <joshi.k@samsung.com>,
        Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: [PATCH v2] block: fix error code for zone-append
Date:   Mon,  6 Jul 2020 00:59:53 +0530
Message-Id: <1593977393-21446-2-git-send-email-joshi.k@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593977393-21446-1-git-send-email-joshi.k@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7bCmhq6gNlO8wap5Jha/p09htVh9t5/N
        orX9G5PF4zuf2S2O/n/LZrH3lrbF5V1z2Cy2/Z7PbHFlyiJmi9c/TrI5cHlcPlvq0bdlFaPH
        501yHu0HupkCWKK4bFJSczLLUov07RK4Mu61TWIpeMlW8fnHRMYGxmusXYycHBICJhKvTy0A
        srk4hAR2M0p07XzEAuF8YpS4/PU0VOYbo8S3m9uYYFoWXGxjhkjsZZS4svQ8I0hCSOAzo8TE
        x+xdjBwcbAKaEhcml4KERQSEJfZ3tIJNZRb4xSixd8EusN3CApYSO88/ZAOxWQRUJbqv32MF
        6eUVcJaY9kIRYpecxM1zncwgNqeAi8TmSSsZQeZICFxjlzh+ejnUQS4SP959Z4awhSVeHd/C
        DmFLSXx+t5cNwi6W+HXnKDNEcwejxPWGmSwQCXuJi3v+MoEsZgY6ev0ufZAwswCfRO/vJ2Bh
        CQFeiY42IYhqRYl7k55Cg05c4uGMJVC2h8TWXTfZIWEynVHiwoc2pgmMsrMQpi5gZFzFKJla
        UJybnlpsWmCcl1quV5yYW1yal66XnJ+7iRGcCLS8dzA+evBB7xAjEwfjIUYJDmYlEd5ebcZ4
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxKP87ECQmkJ5akZqemFqQWwWSZODilGpjOvHA4dPP+
        inS55U6H5Vzvyp4KfXfSaJLJ5Z05nz9nzhFZfKdhp1LY2s/u5/k6PySmn9bZ/v5k2PKwQ6d+
        xa76Np+t0q1aw/gUU9ak4zaBPxc8imrxLX9RaMGUH/NhkoTQujWXvMIXekSynjet3qem6Pyl
        xi2BI2zGuzWr//7k+h/Nzzv9wsGb25NnWXjGXhHcrbo+9947pgZNnsw3TwyNnibz2d/x6rzs
        I7G+YEPbdC0J9k0TW0zd0i9tt36j8P763yPs/xvOlBZ8WW/9TlT0931ppn9Gb+tsH7UUB2Xy
        P5m621LQTPHVMxe9p+eKJQvafzFsYpa/Xd4qG2B34e85u7m6zuvMtGxTznbu6/qhxFKckWio
        xVxUnAgAGH+xhHMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSnK6gNlO8QW+LlMXv6VNYLVbf7Wez
        aG3/xmTx+M5ndouj/9+yWey9pW1xedccNottv+czW1yZsojZ4vWPk2wOXB6Xz5Z69G1Zxejx
        eZOcR/uBbqYAligum5TUnMyy1CJ9uwSujHttk1gKXrJVfP4xkbGB8RprFyMnh4SAicSCi23M
        XYxcHEICuxklbm47yQiREJdovvaDHcIWllj57zk7RNFHRolHTVNYuhg5ONgENCUuTC4FqREB
        qtnf0coCUsMs0MAkcanhJhNIQljAUmLn+YdsIDaLgKpE9/V7rCC9vALOEtNeKELMl5O4ea6T
        GcTmFHCR2DxpJdgNQkAlz7bdZ5/AyLeAkWEVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7u
        JkZwEGpp7mDcvuqD3iFGJg7GQ4wSHMxKIry92ozxQrwpiZVVqUX58UWlOanFhxilOViUxHlv
        FC6MExJITyxJzU5NLUgtgskycXBKNTDNLXNJ9IxlWCHgqpWyYd615sTS5Lzdvo3Tdvybd/b8
        knRJdpniRK9f/j9+qB/SvXX4hGK5/k/Xk74Hfi29YvUq0jlJJlx7NZcv671bdjUHHwnVph9M
        rbsgfmzu+tIU1xk/Uz6UNltN42Pdr1EuNeVwySnJTqPHv1Sq7u69NTv/67ObD2bzrb04w/Lm
        ktnTHHrm3Pix+sf9CbMnOHJWLDcTnxvyjbdxfs4yzsQvZ1dq3XhUP/eMGfv+9KfsTIZWK1xf
        tdz+Ic2io/9nXnHJE/byl9KLv0uGNPwVW33mf417/sNrf95ce3h+35z565y3LvaQWHIuWU9i
        RvnN3pf1DddFQnIM1uZaV0/4XB0bssFZV4mlOCPRUIu5qDgRAF+U1DSxAgAA
X-CMS-MailID: 20200705193337epcas5p4b15eec1bbd6dd687f706f9b8fd93c14a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200705193337epcas5p4b15eec1bbd6dd687f706f9b8fd93c14a
References: <1593977393-21446-1-git-send-email-joshi.k@samsung.com>
        <CGME20200705193337epcas5p4b15eec1bbd6dd687f706f9b8fd93c14a@epcas5p4.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Avoid returning success when max_append_sectors is zero. This prevents
infinite loop in bio_iov_iter_get_pages().

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Selvakumar S <selvakuma.s1@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index a7366c0..0cecdbc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1044,7 +1044,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 	size_t offset;
 
 	if (WARN_ON_ONCE(!max_append_sectors))
-		return 0;
+		return -EINVAL;
 
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
-- 
2.7.4

