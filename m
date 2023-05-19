Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DDDC77B7F
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjESGIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjESGIf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:08:35 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86C210DC
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:08:32 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230519060830epoutp012c5460d73775cd37352b655795230134~gdnYVia6j2316423164epoutp01Y
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 06:08:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230519060830epoutp012c5460d73775cd37352b655795230134~gdnYVia6j2316423164epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684476510;
        bh=oOF8MuPYOH2An8FWy5GwcVNNVNFi8i99I8IMaZDpLXQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=BBBq09nKk5p6mu45dJLiznMr5eB7q6eMD43MnOqs5hEgec0ETzR9bQBH+fGXzrRPN
         tAGuZakHoMS+oUNtZds2ZJ+qdIvoayqdiYKog5Xqk2dcNiT0OWgUV4gywqlJw9StFY
         nKQrSu7AtoRe2CqPGRuSXpT5g7VJhyQ23koax+PY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230519060829epcas2p12f97b157fff55b9260052e11a4ae7de5~gdnYHnDMy3080130801epcas2p1V;
        Fri, 19 May 2023 06:08:29 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QMxH14MzWz4x9Q2; Fri, 19 May
        2023 06:08:29 +0000 (GMT)
X-AuditID: b6c32a48-9f1ff7000000acbc-98-6467125d98b8
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.F3.44220.D5217646; Fri, 19 May 2023 15:08:29 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 3/8] block: move the BIO_CLONED checks out of
 __bio_try_merge_page
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230512133901.1053543-4-hch@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230519060829epcms2p607c2602822c54fcc4b3c2d18754e72d5@epcms2p6>
Date:   Fri, 19 May 2023 15:08:29 +0900
X-CMS-MailID: 20230519060829epcms2p607c2602822c54fcc4b3c2d18754e72d5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmuW6sUHqKweG/yhar7/azWbw8pGmx
        cvVRJou9t7QdWDwuny312H2zgc2jb8sqRo/Pm+QCWKKybTJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otL
        bJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjMuv7rMWOBTMaNpInMDo0MXIyeHhICJ
        xL8LzexdjFwcQgI7GCU27t/O2sXIwcErICjxd4cwSI2wQITE5sc7WEFsIQEliXNrZjGClAgL
        GEjc6jUHCbMJ6En8XDKDDcQWEXCQmL1hKZjNLGAvsfd2KyPEKl6JGe1PWSBsaYnty7eCxTkF
        jCRe7z/IDhHXkPixrJcZwhaVuLn6LTuM/f7YfKg5IhKt985C1QhKPPi5GyouKXHo0Fc2kNMk
        BPIlNhwIhAjXSLxdfgCqRF/iWsdGsBN4BXwlejYtBbNZBFQlvmz5DnWai8S9y5eYIc6Xl9j+
        dg4zyEhmAU2J9bv0IaYrSxy5xQJRwSfRcfgvO8yDDRt/Y2XvmPeECaJVTWJRk9EERuVZiECe
        hWTVLIRVCxiZVzGKpRYU56anFhsVmMBjNTk/dxMjOM1peexgnP32g94hRiYOxkOMEhzMSiK8
        gX3JKUK8KYmVValF+fFFpTmpxYcYTYGenMgsJZqcD0y0eSXxhiaWBiZmZobmRqYG5krivB87
        lFOEBNITS1KzU1MLUotg+pg4OKUamBZPPzF38pXLSw5MXnTy45TiqV/2cLt6/tm87t3a96dc
        9U4G8PxwPjxZ4G+z5gK/T2c7J9vdCj94Pd+rNnHh23M9zPIFp/93prVZGjjqS0if36J55dqm
        903KOtVzWaLyfz943vVOVqtd8YjE5ua+y/8sJu5lEnS7fJj96KPfuy/UJXzm0ezdwZwvtn/d
        Y8UzYjsTWTgSTuV7rrr1dLXLdz5Py8J5Mezb//tqXzz7MuXeU7Vw+0zFU9oJ9++vFFtQsJH3
        7ps/x3jaC8s2qBls6vZhPO7/80PJa4vTuU+dIvxa1D+IJSUpSs3d8atrw/7WakWlL9rl7aza
        mp21L/4umeAWt51v2/Xm7wI8ot1H395SYinOSDTUYi4qTgQAqBtnNvwDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230512133922epcas2p4aee762c8074df76d3a8efb6a51a377c7
References: <20230512133901.1053543-4-hch@lst.de>
        <20230512133901.1053543-1-hch@lst.de>
        <CGME20230512133922epcas2p4aee762c8074df76d3a8efb6a51a377c7@epcms2p6>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me,

Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
