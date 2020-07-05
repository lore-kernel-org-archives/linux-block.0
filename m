Return-Path: <SRS0=GQ+f=AQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481FCC433E0
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 19:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08362074F
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 19:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i0bmKAuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGETdl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:33:41 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38602 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgGETdk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Jul 2020 15:33:40 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200705193338epoutp02e74783490390c87897dbc9f8c5ebbe60~e8jLZ9Uq32710727107epoutp02n
        for <linux-block@vger.kernel.org>; Sun,  5 Jul 2020 19:33:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200705193338epoutp02e74783490390c87897dbc9f8c5ebbe60~e8jLZ9Uq32710727107epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593977618;
        bh=SyMl7bBNaD9Z9xCVsaajbmXskTQfdvRXW5zIIM5T2sY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=i0bmKAuh8rGWwY5J0ny+CPw6IDtTKjGkMzi8ACuEP8OgtU9+I5KNh30nbW0Qy7YEn
         ouXMYNgcX2l+dqTSwaBEUImVIzAIJZrlG3vnOGmPgMvxszXYzS0B9xerwDr+qHuhdr
         rrGNh2pJCMyupiLxkRCwHhk11WiQkKPwckeoZyjM=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200705193333epcas5p2f55f1788164e8bdc86339be76df8b452~e8jGv8g_X3112531125epcas5p2S;
        Sun,  5 Jul 2020 19:33:33 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.56.09475.D0B220F5; Mon,  6 Jul 2020 04:33:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200705193332epcas5p409173a9d12f203d3817305dd3250ca59~e8jFrKK-N1079210792epcas5p4S;
        Sun,  5 Jul 2020 19:33:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200705193332epsmtrp1c2d9bc67b21166afde626bd5d5757836~e8jFqUjNQ2501025010epsmtrp1m;
        Sun,  5 Jul 2020 19:33:32 +0000 (GMT)
X-AuditID: b6c32a4b-389ff70000002503-36-5f022b0d0703
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.B4.08382.B0B220F5; Mon,  6 Jul 2020 04:33:32 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200705193330epsmtip166b64ca6c2ff895983125b8c909de754~e8jEhUCT_2520125201epsmtip1b;
        Sun,  5 Jul 2020 19:33:30 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien.LeMoal@wdc.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2] Fix zone-append error code
Date:   Mon,  6 Jul 2020 00:59:52 +0530
Message-Id: <1593977393-21446-1-git-send-email-joshi.k@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmhi6vNlO8wdtZvBa/p09htVh9t5/N
        orX9G5PF0f9v2Sz23tK2uLxrDpvFlSmLmB3YPS6fLfXo27KK0ePzJjmP9gPdTAEsUVw2Kak5
        mWWpRfp2CVwZX86dYi24w1ix58dUlgbGZYxdjJwcEgImEg37F7B1MXJxCAnsZpT4Nv0llPOJ
        UWL9swOMEM43Rol1WycAORxgLS8maULE9zJKzN6/GarjM6PE1C0bmECK2AQ0JS5MLgVZISIg
        LLG/o5UFxGYWqJaYdPsWK4gtLKAn8Xv2byYQm0VAVeLLri3sIDavgLPEvsefWCHOk5O4ea6T
        GcJexC5x8HcdhO0iMXHSLzYIW1ji1XGIXgkBKYmX/W1QdrHErztHmUFukxDoYJS43jCTBSJh
        L3Fxz1+wO5mB7ly/Sx/iNj6J3t9PmCB+5JXoaBOCqFaUuDfpKdQ54hIPZyxhhSjxkJh+yxok
        LCQQK3F4yV/GCYwysxBmLmBkXMUomVpQnJueWmxaYJyXWq5XnJhbXJqXrpecn7uJERzNWt47
        GB89+KB3iJGJg/EQowQHs5IIb682Y7wQb0piZVVqUX58UWlOavEhRmkOFiVxXqUfZ+KEBNIT
        S1KzU1MLUotgskwcnFINTLyfzLrquNvu/3BfzHXt++SG7qVffK7M4/mnxrGrd8rbNhWVlDof
        rnWPy0wyhbPviL28u5KZJ+zMbsuSkJriVesPRWuF/1u2b12NK7fh4pddqjdO2ZQIPxfqfr2O
        e8eBS1M5V/Rv+PlJ/85Ck851ljk7UuprjW7yJb5Nerd1+ku19ocP7r3J4zBd5d6XwhV91zj8
        SIeiwtqlx+6q3a1knXVd6M7TX71+XlzsMvfdOJOOa1pVLl8c8sVJXMex12fBjdam2ZwfH723
        WRkrc9/nzen7HAo8Ze86jB7b6RYvnNAY6pJTXHn92VrFc0HvV/n1vDh31e5p0cT2PfvcLs/T
        thfg8pq+/UHa1Q9aj+ds1lNiKc5INNRiLipOBADQzFbmVQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKJMWRmVeSWpSXmKPExsWy7bCSnC6PNlO8Qd8zJovf06ewWqy+289m
        0dr+jcni6P+3bBZ7b2lbXN41h83iypRFzA7sHpfPlnr0bVnF6PF5k5xH+4FupgCWKC6blNSc
        zLLUIn27BK6ML+dOsRbcYazY82MqSwPjMsYuRg4OCQETiReTNLsYuTiEBHYzSkw/1wMU5wSK
        i0s0X/vBDmELS6z895wdougjo8Tn223MIM1sApoSFyaXgtSIANXs72hlAQkzC9RL9GxnAQkL
        C+hJ/J79mwnEZhFQlfiyawvYSF4BZ4l9jz+xQoyXk7h5rpN5AiPPAkaGVYySqQXFuem5xYYF
        hnmp5XrFibnFpXnpesn5uZsYwSGjpbmDcfuqD3qHGJk4GA8xSnAwK4nw9mozxgvxpiRWVqUW
        5ccXleakFh9ilOZgURLnvVG4ME5IID2xJDU7NbUgtQgmy8TBKdXAZNixsOm044e1VpNjfe3O
        vzvvtYg5Oti9WLn6xL7zmv7zlaZUHd37532PrrPiGdbIo/OthUKtsxa5H9u+NCSXfcGR2xXO
        8zN0RWurvrmLfuXlM4rZsSPOQeSmlqvtIe3HL76vtvta8T95uuaZedrzmXdqzlg9uyLF8cSF
        fbUx/Zp7/vFXztP7mnTiu/vSgzcjs614E/fkfJSde/xIemKvY3B1cuCutPScs8kiNvc6eA5I
        eE3ceXT2Pv/WuEU9K5YL7WuWC/zycP0No3MJ4k9u61xXn15RZJNtPbP66ra599Sux7aVXlb9
        qFbhftbdpOFLxKQE350y3hdNtIws/mxNipieP3GiZkbpzhtm+7qZlViKMxINtZiLihMBnJ2G
        GogCAAA=
X-CMS-MailID: 20200705193332epcas5p409173a9d12f203d3817305dd3250ca59
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200705193332epcas5p409173a9d12f203d3817305dd3250ca59
References: <CGME20200705193332epcas5p409173a9d12f203d3817305dd3250ca59@epcas5p4.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes since v1:
- updated commit description
- added reviewed-by

Kanchan Joshi (1):
  block: fix error code for zone-append

 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4

