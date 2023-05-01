Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F5EC77B73
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 19:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjEATEk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 15:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEATEi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 15:04:38 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C534A1706
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 12:04:33 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230501190429epoutp01289018920b54a421ace2152ea91d1a9d~bGlxGBjBT0882508825epoutp013
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 19:04:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230501190429epoutp01289018920b54a421ace2152ea91d1a9d~bGlxGBjBT0882508825epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1682967869;
        bh=id3BHKuHqvLmovPHVR4+pTpMJckMkvKSwTgE1pWDsCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vdmFdlS2npqemW6XHJSAaelT+MehotTXd72oQNFx/CiCwVSN6mJdR3fTW0xknmg9n
         DH0zOo2m+qdrGsw6lGheb2s6Bq9HZ3JLuKSuDe57wJHd03m8g8UB3JsawTVN2n+y6a
         PzGE4U4X1Vui+qBciRcFF/7J1Gj93u0seDP0xAl4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230501190428epcas5p3d768e318498c96b1246d3de4a7f2c1df~bGlwjjZIm2511425114epcas5p30;
        Mon,  1 May 2023 19:04:28 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Q9CLg3zlhz4x9Pq; Mon,  1 May
        2023 19:04:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.A4.55646.B3D00546; Tue,  2 May 2023 04:04:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230501190427epcas5p20862d47d222f96f3945f05b0b05df490~bGlu-Ir3y1543115431epcas5p2m;
        Mon,  1 May 2023 19:04:27 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230501190427epsmtrp2ed8ddb5f30f76986cb908b2bcb2805b9~bGlu_cs600276002760epsmtrp2f;
        Mon,  1 May 2023 19:04:27 +0000 (GMT)
X-AuditID: b6c32a4b-913ff7000001d95e-3d-64500d3bd599
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.03.28392.A3D00546; Tue,  2 May 2023 04:04:26 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230501190425epsmtip10390f01e40d5ecd369858828a534d34b~bGltp-Rg30863008630epsmtip16;
        Mon,  1 May 2023 19:04:25 +0000 (GMT)
Date:   Tue, 2 May 2023 00:31:28 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, xiaoguang.wang@linux.alibaba.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC 0/3] nvme uring passthrough diet
Message-ID: <20230501190109.GA14341@green245>
MIME-Version: 1.0
In-Reply-To: <20230501153306.537124-1-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmuq41b0CKwf8FMhar7/azWaxcfZTJ
        YtKha4wWZ64uZLHYe0vbYv6yp+wWm/6eZHJg97h8ttRj06pONo+dDy09Ni+p99h9s4HN49zF
        Co/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAblFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBka
        GBiZAhUmZGc0T7zPVvCTs2Li9cUsDYx7OLoYOTgkBEwkLu+o6GLk4hAS2M0ocePDalYI5xOj
        xNK3U1kgnM+MEosOXmLuYuQE62hc/R2qahejxIKz2xghnGeMEj3/fzKBVLEIqEhMmvGWHWQH
        m4CmxIXJpSBhEQFFifPAQACpZxZYzCjR8W4uK0hCWMBI4mTDHmaQel4BXYm33fYgYV4BQYmT
        M5+wgNicAmYSXf3/wY4QFVCWOLDtOBPIHAmBRg6JiX93sEH84yKxe4YbxKHCEq+Ob2GHsKUk
        Pr/bywZhJ0tcmnmOCcIukXi85yCUbS/ReqofbD6zQIbEy8O9UDafRO/vJ0wQ43klOtqEIMoV
        Je5NesoKYYtLPJyxBMr2kNh3YzM7JEg6GSWOPfrNNoFRbhaSd2YhWQFhW0l0fmhinQW0gllA
        WmL5Pw4IU1Ni/S79BYysqxglUwuKc9NTi00LjPNSy+FRnJyfu4kRnDi1vHcwPnrwQe8QIxMH
        4yFGCQ5mJRHeD4V+KUK8KYmVValF+fFFpTmpxYcYTYGxM5FZSjQ5H5i680riDU0sDUzMzMxM
        LI3NDJXEedVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MG2w09msx7j11/GjtmGld/SWTfZIKl0e
        xaCiPa3m06H2x1/mXVuiW/hTRfn82do32vvnR0dfaVPIiFKosbh/7XLcuSbuMNEIzjsry5tY
        1mwv/FaR5vh4f1bcnj4tjfmN6mw9MvfnxktbhH77yP5q2yfvdwfVPi/4u0cjt9fZ+LFO4IqU
        iBM9nnsW1C7M8+lUqNY5+bzfm+eOnGN4oE81R9jGe3O7Z/2I1bRRkTui8iDT/cuec/+5Alpv
        edZYW6jbvJNIZzE/dohvTUes8K/PR96lp79dwtZRX/Nj78TjGWKLxXa4frmRUv1gs6n/aaFp
        2RrPfB7NOLzkcZ7QJ8b+/1e6j1ZcunEuZfokm7rfekosxRmJhlrMRcWJAGS3uYMlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnK4Vb0CKQfc+G4vVd/vZLFauPspk
        MenQNUaLM1cXsljsvaVtMX/ZU3aLTX9PMjmwe1w+W+qxaVUnm8fOh5Yem5fUe+y+2cDmce5i
        hcfnTXIB7FFcNimpOZllqUX6dglcGRM3/mUrWM1e8fXkFNYGxg62LkZODgkBE4nG1d9ZQWwh
        gR2MEve2FkHExSWar/1gh7CFJVb+ew5kcwHVPGGUuH/1GgtIgkVARWLSjLdACQ4ONgFNiQuT
        S0HCIgKKEueBDgGpZxZYzCixsfMvI0hCWMBI4mTDHmaQel4BXYm33fYQMzsZJW5uWws2k1dA
        UOLkzCdgNrOAmcS8zQ/B6pkFpCWW/+MACXMChbv6/zOD2KICyhIHth1nmsAoOAtJ9ywk3bMQ
        uhcwMq9ilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOBS2tHYx7Vn3QO8TIxMF4iFGC
        g1lJhPdDoV+KEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxS
        DUxGK4+/zHG/c/OPwlRzVsm6+wbrDM65PmWNql92Ty5s3Xe/jK0rqiQZF3d6GM9UXKy3hvv6
        kX5l3wVKhocEipfxcO0Q+/mrK1XEJen67VvS3dMkmZKOcC720DOWSXbcLqjJJnnM1+CzYuGR
        3zzii8NPsrM88MiRFJ/5uXhF6LmK/tAI9vAjlxpSckPaYudum3Ozwr+h4q2r/5WFATxXuYw2
        8wl01Mtxz/15nIFpW6Ezz279ZfJc+eEzptub8S2b8uz65e2b2j7t3rGH5bht2w6JggkLtmQp
        vzW7wL3ItVv7S3RYeXRmobBGSC1fKZM+Z9tUmQMFE+Q32q8WX5cpYNvfttcsuF5P/KBr7V9j
        JZbijERDLeai4kQARLdsdvQCAAA=
X-CMS-MailID: 20230501190427epcas5p20862d47d222f96f3945f05b0b05df490
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_5b357_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230501154403epcas5p388c607114ad6f9d20dfd3ec958d88947
References: <CGME20230501154403epcas5p388c607114ad6f9d20dfd3ec958d88947@epcas5p3.samsung.com>
        <20230501153306.537124-1-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_5b357_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, May 01, 2023 at 08:33:03AM -0700, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>When you disable all the optional features in your kernel config and
>request queue, it looks like the normal request dispatching is just as
>fast as any attempts to bypass it. 

Did a quick run, and it is not the case.
For that workload [1], this one moves to 3.4M from 3M.
While pure bypass moved to 5M from 3M. Maybe it could have gone higher
than 5M (which was the HW limit); have not checked that part yet.

[1]
# t/io_uring -b512 -d64 -c2 -s2 -p1 -F1 -B1 -O0 -n1 -u1 -r4 -k0 /dev/ng0n1
submitter=0, tid=2935, file=/dev/ng0n1, node=-1
polled=1, fixedbufs=1/0, register_files=1, buffered=1, register_queues=0 QD=64
Engine=io_uring, sq_ring=64, cq_ring=64
IOPS=3.31M, BW=1616MiB/s, IOS/call=2/1
IOPS=3.36M, BW=1642MiB/s, IOS/call=2/2
IOPS=3.40M, BW=1661MiB/s, IOS/call=2/1
Exiting on timeout
Maximum IOPS=3.40M

------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_5b357_
Content-Type: text/plain; charset="utf-8"


------PdhGkLDwNmEstpipWwkisvJIpjwP47YWkcBE-d9KzOb1cur7=_5b357_--
