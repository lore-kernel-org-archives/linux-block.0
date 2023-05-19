Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113E7C77B7F
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjESGSe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESGSd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:18:33 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B81A6
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:18:32 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230519061831epoutp03733d737e8ef2e6d50cc408115178a4ee~gdwH_6v6l1573215732epoutp03c
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 06:18:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230519061831epoutp03733d737e8ef2e6d50cc408115178a4ee~gdwH_6v6l1573215732epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684477111;
        bh=oOF8MuPYOH2An8FWy5GwcVNNVNFi8i99I8IMaZDpLXQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ZFW+ok8u6aWDnXq/bFqDzvB7hNNBCwlTB0quG5tRyBjHUwXAKZ6g0i7lkUbnDIcTC
         1LsmeumezxhvIaB+3bFjtSvzWQeRbLOljfdY+aTk2xrOQXjRGTWuf5GZ0CujvrU6I7
         wqqhJj3ShZNwjb/dGC5ICqX0cCP30pfAZDhF2U/Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230519061830epcas2p42864d349775d887be283c45d38cd6a51~gdwHvosY13044730447epcas2p4Z;
        Fri, 19 May 2023 06:18:30 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QMxVZ3Xk6z4x9Q7; Fri, 19 May
        2023 06:18:30 +0000 (GMT)
X-AuditID: b6c32a47-157fd70000001ce0-d2-646714b5e7fb
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.27.07392.5B417646; Fri, 19 May 2023 15:18:29 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 6/8] block: downgrade a bio_full call in bio_add_page
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230512133901.1053543-7-hch@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230519061828epcms2p79630836e3368c284fc35649401fbb575@epcms2p7>
Date:   Fri, 19 May 2023 15:18:28 +0900
X-CMS-MailID: 20230519061828epcms2p79630836e3368c284fc35649401fbb575
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmme5WkfQUg53/bSxW3+1ns3h5SNNi
        5eqjTBZ7b2k7sHhcPlvqsftmA5tH35ZVjB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdcfnWZscCnYkbTROYGRocuRk4OCQET
        iR8LHzJ3MXJxCAnsYJTY8OgtSxcjBwevgKDE3x3CIDXCAp4Sv568YQGxhQSUJM6tmcUIUiIs
        YCBxq9ccJMwmoCfxc8kMNhBbRMBBYvaGpWA2s4C9xN7brYwQq3glZrQ/ZYGwpSW2L98KFucU
        MJKYsvUfO0RcQ+LHsl5mCFtU4ubqt+ww9vtj86HmiEi03jsLVSMo8eDnbqi4pMShQ1/ZQE6T
        EMiX2HAgECJcI/F2+QGoEn2Jax0bwU7gFfCVePHwNdgnLAKqEo+alSBKXCROLdvKDHG9vMT2
        t3OYQUqYBTQl1u/ShxiuLHHkFgtEBZ9Ex+G/7DD/NWz8jZW9Y94TJohWNYlFTUYTGJVnIcJ4
        FpJVsxBWLWBkXsUollpQnJueWmxUYAyP1OT83E2M4CSn5b6DccbbD3qHGJk4GA8xSnAwK4nw
        BvYlpwjxpiRWVqUW5ccXleakFh9iNAX6cSKzlGhyPjDN5pXEG5pYGpiYmRmaG5kamCuJ80rb
        nkwWEkhPLEnNTk0tSC2C6WPi4JRqYAorEVluPifUOVz0Y0dS+MaOiZxXmbRncp/8epzxzfzv
        U69f5DCYG7fYe3msTEdzmKJn5OOEoP6AsNltM+8fiQw4nZT1OVHw4+d1DpLnv/Lml/FX5lS9
        fZMXr264L/yia6QPb5IRq0BX4UOZf3EVe3NMjhhIyjo+vWpXW/VpCt8iw7o6t3dcRp03BJaz
        9Mcm7X8xVfmDvPr9bVf2uAfsMH6bzfn8oNuGRp/6LyeXN+7c9ZM3N3JH6rPOhVf7zRbtF2BT
        v7fYsHcN//JddevP7o71vviKuehv1IKpvb+rtHz0Hz3zOviW/dyxx70WKSo3A8VUL1836jhk
        ra617TZTxbszYa11mSdsS4/Lzpm3QImlOCPRUIu5qDgRAOToeEr7AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230512133923epcas2p4eb995198552f36562733bf45058451a7
References: <20230512133901.1053543-7-hch@lst.de>
        <20230512133901.1053543-1-hch@lst.de>
        <CGME20230512133923epcas2p4eb995198552f36562733bf45058451a7@epcms2p7>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me,

Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
