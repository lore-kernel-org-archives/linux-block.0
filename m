Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A50ECAAD5
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 18:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIBS6p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiIBS6o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 14:58:44 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BFFEF003
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 11:58:38 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220902185836epoutp02cda589a9f16537a4f67fba35e43888ac~RIC1sQEzC1651316513epoutp02Y
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 18:58:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220902185836epoutp02cda589a9f16537a4f67fba35e43888ac~RIC1sQEzC1651316513epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662145116;
        bh=vZgFcYCNz9sOq+MfM6Ajj7GAN1JckOZLmNg/M/49pVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sIEAr6P+l0w7kITFlPXPjdcM8vt+dSZaFt6o3hDor0/TRpvLMq3fGfJRFconEvefz
         VsL1B+0QIBWZE+KLIR3/EKHc6Bgb0Rppkq52kvU+zsKcRnJyduSZIyIl2hw0z1Z+Q3
         zC4qTcp7HSfg/8BllKHHbmKVY1nBrAqMotdT458Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220902185836epcas5p3c1b776572fbff1ba86549b5016082c12~RIC1Ksq461157611576epcas5p3v;
        Fri,  2 Sep 2022 18:58:36 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MK6d573kpz4x9Pp; Fri,  2 Sep
        2022 18:58:33 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.8C.53458.95252136; Sat,  3 Sep 2022 03:58:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220902185833epcas5p4ca187bcdc8f38797277a32c7f1960e89~RICyaX88L2247722477epcas5p4b;
        Fri,  2 Sep 2022 18:58:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220902185833epsmtrp152dfd6b43b807b7c1a5e9f00b923fdff~RICyZ0NTP2258322583epsmtrp1I;
        Fri,  2 Sep 2022 18:58:33 +0000 (GMT)
X-AuditID: b6c32a4a-a5bff7000000d0d2-13-63125259e839
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.63.18644.95252136; Sat,  3 Sep 2022 03:58:33 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220902185832epsmtip13a646a5932ee7ead9891d72f5c46b4fe~RICx9km7u3256932569epsmtip1u;
        Fri,  2 Sep 2022 18:58:32 +0000 (GMT)
Date:   Sat, 3 Sep 2022 00:18:50 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH for-next] block: enable per-cpu bio caching for the fs
 bio set
Message-ID: <20220902184850.GB6902@test-zns>
MIME-Version: 1.0
In-Reply-To: <f2863702-e54c-cd74-efcf-8cb238be1a7c@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmum5kkFCywaWdlhar7/azWey9pe3A
        5HH5bKnH501yAUxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QMOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmp
        JVaGBgZGpkCFCdkZixviCrazVay684SxgfEMaxcjJ4eEgInEurbnQDYXh5DAbkaJV43fmCGc
        T4wSzZ1rWCCcz4wSP98sZYJpaTx3BqpqF6PEmaUTGSGcZ4wSTQ13mEGqWARUJBZc3weU4OBg
        E9CUuDC5FCQsIqAg0fN7JRuIzSxgL3Fm+1SwO4QFQiR2TD/KCGLzCuhIfJ3WDGULSpyc+YQF
        xOYUsJV48GYGWL2ogLLEgW3HmUD2SgjsYpf4uGM2G8R1LhK/9i6DulRY4tXxLewQtpTEy/42
        KDtZ4tLMc1A1JRKP9xyEsu0lWk/1M0MclyExa80VdgibT6L39xMmkF8kBHglOtqEIMoVJe5N
        egoNR3GJhzOWQNkeEtu6/0HDZAIwTJ4vZZ/AKDcLyT+zkKyAsK0kOj80sc4CWsEsIC2x/B8H
        hKkpsX6X/gJG1lWMkqkFxbnpqcWmBUZ5qeXwOE7Oz93ECE5uWl47GB8++KB3iJGJg/EQowQH
        s5II79TDAslCvCmJlVWpRfnxRaU5qcWHGE2B0TORWUo0OR+YXvNK4g1NLA1MzMzMTCyNzQyV
        xHmnaDMmCwmkJ5akZqemFqQWwfQxcXBKNTA5v1Jb42u/IYrtS1KfaZn+5HWq3psf/bt9qPvd
        lLqbmyZbxh2s3miw99z0p/ukgte72OnUXdRIc83Z9kTrXvZqjX8iml2mMzzfXV+gxDOtevZS
        FacDIuHt1dMEAzIWmIjIr9brqvKvm3636jHDjn3mKQ05xoK62t0eRVzTirqWnrn0N/nAphUu
        Hy6+m/Rl6we+snfdq0xfPlebVXub84ds6Q5tA5moffNezbzumK0SuWD12qOvO054WeR6boo+
        c/JbYGNMwVHTn3Vq3fODdiZacojHLFzQOd/Y/ZN7S8rVmv9+brUTVm+2y124gXWXoe67Uwt+
        9x7Y85IvbdHM80kabYkSIV+eVtQo/fm+ZE+rEktxRqKhFnNRcSIAQxMFgvcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnG5kkFCywa+5Yhar7/azWey9pe3A
        5HH5bKnH501yAUxRXDYpqTmZZalF+nYJXBkXOzezF7xkrjizZiZbA+MM5i5GTg4JAROJxnNn
        gGwuDiGBHYwSz3ZugUqISzRf+8EOYQtLrPz3HMjmACp6wiixJAskzCKgIrHg+j5GkDCbgKbE
        hcmlIGERAQWJnt8r2UBsZgF7iTPbp7KC2MICIRI7ph9lBLF5BXQkvk5rZoRYO4FRYsPeNqiE
        oMTJmU9YIJrNJOZtfsgMMp9ZQFpi+T8OkDCngK3EgzczwGaKCihLHNh2nGkCo+AsJN2zkHTP
        QuhewMi8ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOFS1tHYw7ln1Qe8QIxMH4yFG
        CQ5mJRHeqYcFkoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLg
        lGpgWiHsV/IohDHKo/F7hVjEmudyD3M7f3y52zRz7R7fNcmih8yfyN606j5UtWRW6omqTu1L
        0zjOcfk6LP/R/aNrT/8F/fQ1t2f2nZITnzCh94BVovL3gp9/eNW3bcvku7q+LvGPR2eN/YTy
        q+u5l3UfObJHYZqCY2zrQS3Dp0azCuT+bYpW2RP89vW3lJ71p6vPT3uVax8dZON41LcjWjxK
        SP/1PaWeWzrih6dpdf+M0/x1RX8id2V49YlZHpU9q1bu6TIJ+So45+aTiIyHgn+en3G9+WRO
        8eR77zbK2ta+tLWYsO9h1vLk6bWx5Rpeu+2YH8q4v3fb5/PKZCpfLWuksWmGpX/HusKZ+wye
        eE3pV2Ipzkg01GIuKk4EAOSHKyfEAgAA
X-CMS-MailID: 20220902185833epcas5p4ca187bcdc8f38797277a32c7f1960e89
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----zvU9B7RYhoxo0n0NtQiMJbd43ri29uhJZ9UzgKuz80Y8n-YR=_44437_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220902164254epcas5p42cc0e01559b6bce45d9bda336b091c5f
References: <CGME20220902164254epcas5p42cc0e01559b6bce45d9bda336b091c5f@epcas5p4.samsung.com>
        <f2863702-e54c-cd74-efcf-8cb238be1a7c@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------zvU9B7RYhoxo0n0NtQiMJbd43ri29uhJZ9UzgKuz80Y8n-YR=_44437_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Sep 02, 2022 at 10:42:45AM -0600, Jens Axboe wrote:
>This is useful for polled IO on a file, or for polled IO with the
>io_uring passthrough mechanism. If bio allocations are done with
>REQ_POLLED for those cases, then initializing the bio set with
>BIOSET_PERCPU_CACHE enables the local per-cpu cache which eliminates
>allocations (and frees) of bio structs when possible.
>
>Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

------zvU9B7RYhoxo0n0NtQiMJbd43ri29uhJZ9UzgKuz80Y8n-YR=_44437_
Content-Type: text/plain; charset="utf-8"


------zvU9B7RYhoxo0n0NtQiMJbd43ri29uhJZ9UzgKuz80Y8n-YR=_44437_--
