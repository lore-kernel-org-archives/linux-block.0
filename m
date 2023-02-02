Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A50C05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 11:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBBL5B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 06:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBBL5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 06:57:00 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A01BBB86
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 03:56:58 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230202115656euoutp02b863d01618633eaa3eed8d80f7ca1fff~---WHAe9r2770927709euoutp02X
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 11:56:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230202115656euoutp02b863d01618633eaa3eed8d80f7ca1fff~---WHAe9r2770927709euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675339016;
        bh=uZd+VUE41+PDYbgmL6AnfmRpQyAZtSSYsvWLe5oSEp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=By+GQfK4yWmMK2gffQVCsc+T1hcckSjB9NCn2Hou51pz03/oyjA1j8sAWnQfGztwd
         yNWQnqb6ctatVByx49Pq+wljW18aYdd8c0q/NV1+kppG4KU6N7VbNtsu6F109h92na
         /q5FdRYg9IIDpIj5UaLL6PuBv8HyQtOX5Yq7AKa4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230202115656eucas1p17bae0db6f8fa53a7d1aa19f9dcf8f085~---V9xDPv2943629436eucas1p1b;
        Thu,  2 Feb 2023 11:56:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A1.82.01471.805ABD36; Thu,  2
        Feb 2023 11:56:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230202115655eucas1p173ffc747caa69a038e1e86357caf0cb5~---VUQEv_2942129421eucas1p11;
        Thu,  2 Feb 2023 11:56:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230202115655eusmtrp2fcf3f59e5ff7065cee840aa2aff3fb31~---VToNvb0993109931eusmtrp2c;
        Thu,  2 Feb 2023 11:56:55 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-15-63dba5085c0e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4C.FF.02722.705ABD36; Thu,  2
        Feb 2023 11:56:55 +0000 (GMT)
Received: from localhost (unknown [106.210.248.10]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230202115655eusmtip14547d8bfd5bc14c68e8806c5e64a04df~---U7N-GG2082220822eusmtip1K;
        Thu,  2 Feb 2023 11:56:55 +0000 (GMT)
Date:   Thu, 2 Feb 2023 17:26:52 +0530
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Juhyung Park <qkrwngud825@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] block: remove more NULL checks after bdev_get_queue()
Message-ID: <20230202115652.nh464rwc6jxw25e6@quentin>
MIME-Version: 1.0
In-Reply-To: <20230202091151.855784-1-qkrwngud825@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOV2OpbeTDRr3c1usvtvPZrH3lrbF
        56Ut7BZHHy9kc2Dx2DnrLrvH5bOlHn1bVjF6fN4kF8ASxWWTkpqTWZZapG+XwJVxafF7loIT
        bBXH71xja2C8w9rFyMkhIWAi8WzaI7YuRi4OIYEVjBI3z51ggXC+MEp0Tmpmh3A+M0p8b9zB
        AtNy+clNZojEckaJCytXQPW/YJRYO/8EM0gVi4CKxLppjYxdjBwcbAJaEo2d7CBhEQENidYL
        51lAwswCERKPD6uBmMICXhK3bsuCVPAKmEqsOPSVHcIWlDg58wlYNaeAjUT7Aw+IC+ZySPzs
        SYOwXSRWrNsL9YywxKvjW9ghbBmJ/zvnM0HY1RJPb/wGu1hCoIVRon/nejaQmRIC1hJ9Z3JA
        apgFMiTOL54A9aGjxPETN1ggSvgkbrwVhCjhk5i0bTozRJhXoqNNCKJaSWLnzydQWyUkLjfN
        gZriIfH8yWNo0PQzSsw9OZFpAqP8LCSPzUKyGcLWkViw+xPbLHDwSEss/8cBYWpKrN+lv4CR
        dRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgOjn97/inHYxzX33UO8TIxMF4iFGCg1lJ
        hPfKvNvJQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQWwWSZODilGpgW
        /CgskTJzvd/39fUr2foDe04+2tmvq3dL1mri/YzV/u5xD6L695kv2Jfz8lK7yoO/xbOE38pm
        eAdKik4xdSsSPid0wTLs56xZQguPSz78JbZNs3rv9gncltaHF2mY6erkfdAXu1nac+BCV5N+
        6ieBqSEqe871bX9Zu8VvwfOlH+rMHheJJ03+wyu85Zy9zPLObXv8mP7FKDG4+kazBKrcDp93
        s/vmBL2r7xbxMPeHXeh9vV7r5q0ZLx+efVm91kOk3Y3NqV5n54MP0xorU5lvHG97NGth5/fr
        13X/KE52PyYkfHl9b/Le+XftXHvmhbnNK/GPDK1mmyrTK8hqxxHQxbwpwLbIXoRvbY3plhtK
        LMUZiYZazEXFiQCSmkB6lgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t/xu7rsS28nG7z7J2ex+m4/m8XeW9oW
        n5e2sFscfbyQzYHFY+esu+wel8+WevRtWcXo8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G3yMP2As6WCrOvW5lbmDcytzFyMkhIWAi
        cfnJTSCbi0NIYCmjxMYNX1ghEhIStxc2MULYwhJ/rnWxQRQ9Y5T4/eASC0iCRUBFYt20RqAi
        Dg42AS2Jxk52kLCIgIZE64XzYCXMAhESs65eZwYpERbwkrh1WxYkzCtgKrHi0FewciEBa4lZ
        O94zQ8QFJU7OfALVqiVx499LJpBWZgFpieX/OEBMTgEbifYHHhMYBWYhaZiFpGEWQsMCRuZV
        jCKppcW56bnFhnrFibnFpXnpesn5uZsYgWG/7djPzTsY5736qHeIkYmD8RCjBAezkgjvlXm3
        k4V4UxIrq1KL8uOLSnNSiw8xmgK9O5FZSjQ5Hxh5eSXxhmYGpoYmZpYGppZmxkrivJ4FHYlC
        AumJJanZqakFqUUwfUwcnFINTIXrl7g45BSHTl7abenxbdIm/jMO/JN+nPW7c2GZ5pIrCk3r
        K3ceNmgJ9bg3c73hzncKUYst1s990JHx+lEqd9dZw3l9z53dZpk1vvP4mXpk+8xLqV5Li6Mz
        bx+bwtQjsymi74TH2w3r/ILlGTY2Tr6W7ngzL8XXdsk3bVHVs0osU16pcH6PFnL7erHj/r9w
        7mNx/xvsg/ZpRAv9t/snfiTDe+d5/vmsB7ZEakoyHjua7PexxHwe51HtravDA2bP/cRzPMun
        O3tlZpfQjlfaTP9iIrtafjt5BQor7rt73GzhIuZ5vxx/TFkYmvfmzWbnkn9r1Hc03mAUu1ty
        +I7E2pCF8n4FL7svcs5fkaj84pgSS3FGoqEWc1FxIgDlFpIeBAMAAA==
X-CMS-MailID: 20230202115655eucas1p173ffc747caa69a038e1e86357caf0cb5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----ne2T92axF1zxmICHxTGG9HmPt4_QlnxLDzDMENhgOSO8xpR3=_8e964_"
X-RootMTR: 20230202115655eucas1p173ffc747caa69a038e1e86357caf0cb5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230202115655eucas1p173ffc747caa69a038e1e86357caf0cb5
References: <20230202091151.855784-1-qkrwngud825@gmail.com>
        <CGME20230202115655eucas1p173ffc747caa69a038e1e86357caf0cb5@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------ne2T92axF1zxmICHxTGG9HmPt4_QlnxLDzDMENhgOSO8xpR3=_8e964_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Feb 02, 2023 at 06:11:51PM +0900, Juhyung Park wrote:
> bdev_get_queue() never returns NULL. Several commits [1][2] have been made
> before to remove such superfluous checks, but some still remained.
> 
> [1] commit ec9fd2a13d74 ("blk-lib: don't check bdev_get_queue() NULL check")
> [2] commit fea127b36c93 ("block: remove superfluous check for request queue in bdev_is_zoned()")
> 
> Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

------ne2T92axF1zxmICHxTGG9HmPt4_QlnxLDzDMENhgOSO8xpR3=_8e964_
Content-Type: text/plain; charset="utf-8"


------ne2T92axF1zxmICHxTGG9HmPt4_QlnxLDzDMENhgOSO8xpR3=_8e964_--
