Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B89C77B60
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 03:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCaDpv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 23:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCaDps (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 23:45:48 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37BE18809
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 20:45:42 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230331034533epoutp03997bfea815416b999e8d4acd733ecd8b~RZDlU5qIo2395823958epoutp03y
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 03:45:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230331034533epoutp03997bfea815416b999e8d4acd733ecd8b~RZDlU5qIo2395823958epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680234333;
        bh=T1x3L8c64sT9IQ+EX3Ery3BRF6jYq+O+48Pi0EdVwz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j6TYCUCr4djhCfwrYWpdR5PYGgNphbOl+Mfb3wl98+CjmO8W2qM3CD2QKmwAwLFCj
         5EUtqpeqxZeouJeS6mlbquw/WmbkLVEAdNMI9mTZsT86ugwSdWtPPa7CaYq7RcUeyh
         ixBS5MZ/LAgIxa1qlU2UFVY0jKY0HHUeYfys7miw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230331034533epcas5p42e24d471b4f55e276e7f390c3d10e82b~RZDlA-oRN2090220902epcas5p4T;
        Fri, 31 Mar 2023 03:45:33 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PnmQg5kZ6z4x9Px; Fri, 31 Mar
        2023 03:45:31 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.DA.10528.95756246; Fri, 31 Mar 2023 12:45:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230331034528epcas5p4402a10e327a2286f4e488afa9ffb7c71~RZDhGtWPw2090220902epcas5p4K;
        Fri, 31 Mar 2023 03:45:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230331034528epsmtrp133e203de59d01225a86ad9e11e4c836d~RZDhGAqjM1855118551epsmtrp1G;
        Fri, 31 Mar 2023 03:45:28 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-02-642657599bc9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.52.31821.85756246; Fri, 31 Mar 2023 12:45:28 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230331034527epsmtip1a600fe981a0628595a5b230ed2140d19~RZDf3hw941713117131epsmtip1a;
        Fri, 31 Mar 2023 03:45:27 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     shinichiro.kawasaki@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        mcgrof@kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH blktests 1/2] common,fio: helper for version check
Date:   Fri, 31 Mar 2023 09:14:13 +0530
Message-Id: <20230331034414.42024-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331034414.42024-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmum5kuFqKwZOdAhZH/79ls9h7S9ti
        /rKn7BY3JjxltNg3y9OB1WPTqk42j81L6j36tqxi9Pi8Sc6j/UA3UwBrVLZNRmpiSmqRQmpe
        cn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBmJYWyxJxSoFBAYnGxkr6d
        TVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xv4bC9kLHrJV3Hij
        0sA4l7WLkZNDQsBE4vKlDiCbi0NIYDejxNnW1UwQzidGiWnLPrJAOJ8ZJRpav7DDtExd858Z
        IrGLUeLK169McFWzFzQydjFycLAJaEpcmFwK0iAiIC+xcnYz2D5mgUqJFU0HwQYJCzhJbFj6
        kRHEZhFQlej4+QWshlfAQmL7292MEMvkJWZe+g5WzylgKdG6eSszRI2gxMmZT1ggZspLNG+d
        DXaQhMAldoll+34zg9wgIeAi0TjPFWKOsMSr41ugHpCSeNnfBmUnS1yaeY4Jwi6ReLznIJRt
        L9F6qh9sDDPQK+t36UOs4pPo/f2ECWI6r0RHmxBEtaLEvUlPoSEqLvFwxhIo20Oi4fU+Rkjo
        9DBKHFnfwjKBUX4Wkg9mIflgFsK2BYzMqxglUwuKc9NTi00LDPNSy+HRmpyfu4kRnPy0PHcw
        3n3wQe8QIxMH4yFGCQ5mJRHeQmPVFCHelMTKqtSi/Pii0pzU4kOMpsAgnsgsJZqcD0y/eSXx
        hiaWBiZmZmYmlsZmhkrivOq2J5OFBNITS1KzU1MLUotg+pg4OKUamOacyPvLdEHS7ESGJdv5
        NFMW86X1kRI3Gne+Pyycbrenp9Xr+T6GW/dvuFYHz49pcROb2PL2qAXng+0esxb/mLu5VDHW
        euaUJZJfXkvUzTneZXbr9LwZW9kYfv+LPvPF9Zui6pTf4bGG5RHK2swV72uFG14lTwm5FV16
        +PCPbwtOfK02jjt6xaCsOfijZ9TCmFOLPV4z/d3FYzf/nsbr3bG2+Vuqgt3nvXU9rHB4Qt39
        4BMfejQCz8c8vtVWdtzANsnlEt/3a7dDj5T/3shcvfj0tGauf0evye2qNp0p/XNqnYKB44pJ
        ogtfc5hPObFjUtzRd93rbO0ju+98iLt/PS3rk/2VNG2N/W5PDk81E9iuxFKckWioxVxUnAgA
        ZwPJTwcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSnG5EuFqKwclmPYuj/9+yWey9pW0x
        f9lTdosbE54yWuyb5enA6rFpVSebx+Yl9R59W1YxenzeJOfRfqCbKYA1issmJTUnsyy1SN8u
        gStj/42F7AUP2SpuvFFpYJzL2sXIySEhYCIxdc1/5i5GLg4hgR2MEntf3GOGSIhLNF/7wQ5h
        C0us/PecHaLoI6PE0qXrGLsYOTjYBDQlLkwuBakREZCXWDm7GWwos0CtxLSZt8BsYQEniQ1L
        PzKC2CwCqhIdP7+AxXkFLCS2v93NCDFfXmLmpe9guzgFLCVaN28Fu0EIqKZjRws7RL2gxMmZ
        T1gg5stLNG+dzTyBUWAWktQsJKkFjEyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC
        A1dLawfjnlUf9A4xMnEwHmKU4GBWEuEtNFZNEeJNSaysSi3Kjy8qzUktPsQozcGiJM57oetk
        vJBAemJJanZqakFqEUyWiYNTqoHJsMCnctpW0dYUt7MPmrf6vOlL/854Z2ng8oW1OT83LL3H
        eq3oS6kbj/TDRdL7Jnx9KTaz3uCOoF1r1/t4SykLZtOkslVdh681C+U93/fqbPcW4Vwd7627
        +hZ+6P748ESM/HJL80t1xczhn1k/3So44CsTKubow+UYJaSp4C0z4VT8yqavrJ1Xjr167nSF
        eaq3BfPjedVVBjeOLoyes9LejGNC22aHkNY41z/HCrfIP5wR7rTxAsfGFb4iAfOMFr1sVJwc
        u1T/qaLva6lXxbOmrq3YGjZfOrBw7oK8E9OqpnVOnJr1Y4ba26kKnWue3lX7oTp7itClPv5Z
        3/aF2Cts8DT/+iC0q3WPWuyKvXcOKbEUZyQaajEXFScCAFSbdG3LAgAA
X-CMS-MailID: 20230331034528epcas5p4402a10e327a2286f4e488afa9ffb7c71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331034528epcas5p4402a10e327a2286f4e488afa9ffb7c71
References: <20230331034414.42024-1-joshi.k@samsung.com>
        <CGME20230331034528epcas5p4402a10e327a2286f4e488afa9ffb7c71@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add new helper _have_fio_ver which checks whether installed fio version
is greater than or equal to input.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 common/fio | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/fio b/common/fio
index bed76d5..67c5339 100644
--- a/common/fio
+++ b/common/fio
@@ -25,6 +25,20 @@ _have_fio_zbd_zonemode() {
 	fi
 	return 0
 }
+# Check whether the version of the fio is greater than or equal to $1.$2.$3
+_have_fio_ver() {
+	local d=$1 e=$2 f=$3
+
+	_have_fio || return $?
+
+	IFS='.' read -r a b c < <(fio --version | cut -c 5- | sed 's/-.*//')
+	if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
+	then
+		SKIP_REASONS+=("fio version too old")
+		return 1
+	fi
+	return 0
+}
 
 declare -A FIO_TERSE_FIELDS
 FIO_TERSE_FIELDS=(
-- 
2.25.1

