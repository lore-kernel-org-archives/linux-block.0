Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7951C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 12:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjDRL7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 07:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjDRL5r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 07:57:47 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C616A25A
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 04:54:27 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230418115423euoutp029b384b27cfa120d007adad405166b2f3~XBViOd-5o0631506315euoutp02c
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 11:54:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230418115423euoutp029b384b27cfa120d007adad405166b2f3~XBViOd-5o0631506315euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681818863;
        bh=uZTIN15FUrCZt6ZT7djzR3poFqTWXDeaDaq4u2/bwr8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=jLrIhoOgCV3BfU9+2fxgubBjGuAV2oX/n2wg2fXhrRlZfWjEzGHC3y5ZlWuVSHtvv
         DD7axuGKaSBqp/dUCFK0LbPGXaH3ru89nD+1fZW8sbDAUflztxH5coE/04jO62VzfI
         bVV25ZtU31C7gI1LgARnucsCpmeCI6U4W1lklz88=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230418115423eucas1p28845e879ed78d4d0b40be6d5a55861db~XBVh0lcOi0687806878eucas1p2Y;
        Tue, 18 Apr 2023 11:54:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E4.01.09966.FE48E346; Tue, 18
        Apr 2023 12:54:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230418115422eucas1p1cf843ce2362ef4b5937b0aad6f90e573~XBVhfvmhp3174231742eucas1p1Z;
        Tue, 18 Apr 2023 11:54:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230418115422eusmtrp1985d4c96fe9e1088f164dca654c50349~XBVhfCM183217932179eusmtrp1S;
        Tue, 18 Apr 2023 11:54:22 +0000 (GMT)
X-AuditID: cbfec7f4-55954a80000026ee-d3-643e84efdf52
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BC.63.22108.EE48E346; Tue, 18
        Apr 2023 12:54:22 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230418115422eusmtip1e5eaf4e13a68070fa6995eeef4fe5d4a~XBVhWjSAt1118811188eusmtip1x;
        Tue, 18 Apr 2023 11:54:22 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 18 Apr 2023 12:54:22 +0100
Date:   Tue, 18 Apr 2023 13:45:52 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
CC:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <dlemoal@kernel.org>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <yukuai3@huawei.com>,
        <p.raghav@samsung.com>
Subject: Re: [PATCH V2 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Message-ID: <20230418114552.4kx5huy2qo64dzjl@blixen>
MIME-Version: 1.0
In-Reply-To: <20230418042420.93629-2-kch@nvidia.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87rvW+xSDFpnClqsvtvPZjHtw09m
        iwf77S3+dt1jsnh6dRaTxd5b2hb7ZnlazFnI5sDhcfmKt0fLkbesHpfPlnpsWtXJ5tHb/I7N
        4/MmOY/2A91MAexRXDYpqTmZZalF+nYJXBkXN89jLtjIXLG40bCB8S9TFyMHh4SAicSeie5d
        jJwcQgIrGCW2b6vqYuQCsr8wSrxvP8gM4XxmlPi1oYsdpAqk4fui/awQieWMEh9P/WaFq2r7
        fZgRwtkCNGvOGlaQFhYBVYnZr+Yzg+xjE9CSaOwEmyQioC4x9UAPWDOzwGtGiZ+/zrCC1AgL
        eEps6dMBqeEF2vZn1x4WCFtQ4uTMJ2A2J1D8664tUBcpSTRsPsMCYddK7G0+wA4yU0LgA4fE
        1IXXmSASLhI3Dk1khbCFJV4dh2mWkTg9uQequVri6Y3fzBDNLYwS/TvXs0ECyVqi70wOSA2z
        QIbEki97oOY4Sux4P4kdooRP4sZbQYgSPolJ26YzQ4R5JTrahCCq1SRW33vDAhGWkTj3iW8C
        o9IsJI/NQjIfwtaRWLD7E9ssoA5mAWmJ5f84IExNifW79Bcwsq5iFE8tLc5NTy02ykst1ytO
        zC0uzUvXS87P3cQITFKn/x3/soNx+auPeocYmTgYDzFKcDArifCecbVKEeJNSaysSi3Kjy8q
        zUktPsQozcGiJM6rbXsyWUggPbEkNTs1tSC1CCbLxMEp1cA0a9GC2ucLihdmJpfmTV/9QGZr
        3Jm7c5jP35hz5YvaelWvdGWmh7I7Zz/MsWOpfBc7JWuh9xQrgQsu5rMFm1bH3Ju0X82h5u1e
        r/DzHz4ZT55kyt35OOeg/NqpGc/+vp+cd6BCROG4U6dI9wkX10NVp/ua395cE/no81yp6Y96
        M7JbrR7HmSY6c0Tevz9zYZu+ofi7JpPVP5OdQ1RPs9x8fnuV9MRI3UeyrBMsG0xfmfwwmpbd
        vVD0hPFrxX0+h7d8fLxPpZj5C1+W7KZnNnP5pO+UNGgHK/G3CNqsfR/37azqvInx4QW7fxi1
        3l69zWWni9ge8bU79yZaiMle0BL+suSSGcP9y4Lv2ux73gUrKLEUZyQaajEXFScCAMTl1JLB
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7rvWuxSDD5MtLBYfbefzWLah5/M
        Fg/221v87brHZPH06iwmi723tC32zfK0mLOQzYHD4/IVb4+WI29ZPS6fLfXYtKqTzaO3+R2b
        x+dNch7tB7qZAtij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMy
        y1KL9O0S9DIeLJzKXlBY8fn3XuYGxrAuRk4OCQETie+L9rN2MXJxCAksZZT41b2DESIhI7Hx
        y1VWCFtY4s+1LjaIoo+MEq+eTmcBSQgJbGGUmPkoDcRmEVCVmP1qPnMXIwcHm4CWRGMnO0hY
        REBdYuqBHrAFzAIvGSWWHPgFViMs4CmxpU8HpIYX6Ig/u/awgISFBGIlHl7whAgLSpyc+QRs
        E7OAjsSC3Z/YQEqYBaQllv/jAAlzAnV+3bWFHeJKJYmGzWdYIOxaic5Xp9kmMArPQjJpFpJJ
        sxAmLWBkXsUoklpanJueW2yoV5yYW1yal66XnJ+7iREYe9uO/dy8g3Heq496hxiZOBgPMUpw
        MCuJ8J5xtUoR4k1JrKxKLcqPLyrNSS0+xGgKDIeJzFKiyfnA6M8riTc0MzA1NDGzNDC1NDNW
        Euf1LOhIFBJITyxJzU5NLUgtgulj4uCUamASYxXo5pmpkX/F/Ev2FeMyLakodp+ij+fmqTDp
        cMs2bHoRxvLzokbBpRPMiTXtgVWXdMqmnHp9Sr3cydea8YRAvnlwtXva84vOq9mCha87PRaZ
        dX12ucuEI6rLxW3e3ZzrPy2mcu7U55283IvfJvAcMcu9Wn/tbbS/WK6yjdq56dfX3hV47iew
        NXnyrecdX965JD3MkvttzSnz+Wpw0OU1dmd2NM1pNSjf2TpLQ+9S9OQfWxXuLnl5xuBv04nS
        R65LU4pDHA8Zxu/dkzkpVqNS3OdkuNUR0XKl0zsrur9FsH+JCO3umfXkitLqqDI9/w03usSv
        5OhejXmwuuLlR7a3Z69aSJYGvbiubGSSXq3EUpyRaKjFXFScCABQ9T6cRgMAAA==
X-CMS-MailID: 20230418115422eucas1p1cf843ce2362ef4b5937b0aad6f90e573
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----FpY3PJutWHT.FUJYa--SeN9KPCWgRG3v2_zRI2jDLaEn3nif=_a5aea_"
X-RootMTR: 20230418115422eucas1p1cf843ce2362ef4b5937b0aad6f90e573
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230418115422eucas1p1cf843ce2362ef4b5937b0aad6f90e573
References: <20230418042420.93629-1-kch@nvidia.com>
        <20230418042420.93629-2-kch@nvidia.com>
        <CGME20230418115422eucas1p1cf843ce2362ef4b5937b0aad6f90e573@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------FpY3PJutWHT.FUJYa--SeN9KPCWgRG3v2_zRI2jDLaEn3nif=_a5aea_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Ah, I think I replied to your v1 patches but the same comments are also
applicable here.

-- 
Pankaj Raghav

------FpY3PJutWHT.FUJYa--SeN9KPCWgRG3v2_zRI2jDLaEn3nif=_a5aea_
Content-Type: text/plain; charset="utf-8"


------FpY3PJutWHT.FUJYa--SeN9KPCWgRG3v2_zRI2jDLaEn3nif=_a5aea_--
