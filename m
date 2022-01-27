Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F801C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 09:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiA0JJw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:09:52 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10636 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbiA0JJw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 04:09:52 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220127090949epoutp04f138750bba73f9b147e01847a6c9e336~OFYhkXEua2133821338epoutp04U
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 09:09:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220127090949epoutp04f138750bba73f9b147e01847a6c9e336~OFYhkXEua2133821338epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643274589;
        bh=veO4G93tLE5LctyDU90QucYWnKBAqRl6kjk9040VE5k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sI0EIXSEhJem8rZszTFWl1WSmi2IgLfSo1nNiG9pdV7slfCoKS1gbRyrm0yDLcCyu
         IHXcTjEmpA5Gxeiv3lNTgdBwjtFegWBVhbzImDIodqwVI39YfYruG8rdu6IqNr15Ep
         vTkG9HgFDuj+YGMHp+kGtVyn1kmIo3JuQBOiqWoI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220127090949epcas5p1d9241a1334f474b531e2705a64f5f6ae~OFYhIxXIa2673226732epcas5p16;
        Thu, 27 Jan 2022 09:09:49 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JkvtJ17vjz4x9QF; Thu, 27 Jan
        2022 09:09:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.29.06423.F4162F16; Thu, 27 Jan 2022 18:09:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220127083033epcas5p3ce9565e4b5e21e897571e48e73e4f9af~OE2PO9R3B0404904049epcas5p3t;
        Thu, 27 Jan 2022 08:30:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220127083033epsmtrp24bc3d438aec30eb4f06701aeb6a044be~OE2POL11S2526925269epsmtrp2H;
        Thu, 27 Jan 2022 08:30:33 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-30-61f2614ff86e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.85.29871.92852F16; Thu, 27 Jan 2022 17:30:33 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220127083032epsmtip2fc49d4438e4790e65a4c4ecba98435d1~OE2OT72ee2260922609epsmtip2m;
        Thu, 27 Jan 2022 08:30:32 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        joshiiitr@gmail.com
Subject: [PATCH 0/2] nvme-passthru with vectored-io
Date:   Thu, 27 Jan 2022 13:55:34 +0530
Message-Id: <20220127082536.7243-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmuq5/4qdEg619Qhar7/azWaxcfZTJ
        4vzbw0wWkw5dY7TYe0vbYv6yp+wObB47Z91l97h8ttRj06pONo/NS+o9dt9sYPP4vEkugC0q
        2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
        nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
        n46n7AV3WSoer/rE2sB4mbmLkZNDQsBE4vu+K+xdjFwcQgK7GSU271nNCuF8YpT4cvY6lPON
        UWLq3AZ2mJYDeyezQCT2MkqsX7scqv8zo8Tr6d+BHA4ONgFNiQuTS0FMEQEjidtvY0B6mQXC
        JA71TGEBsYUFjCW27PwHNpNFQFXiwIGfYCfxCphLzL5ykhFil7zEzEvf2SHighInZz5hgZgj
        L9G8dTYzyFoJgVPsEgsnb2MD2SUh4CIx804eRK+wxKvjW6BulpL4/G4vG4RdLPHrzlGo3g5G
        iesNM1kgEvYSF/f8ZQKZwwx0/vpd+hBhWYmpp9YxQezlk+j9/YQJIs4rsWMejK0ocW/SU1YI
        W1zi4YwlULaHxNJTZ8FuEBKIlfi/fSXLBEb5WUjemYXknVkImxcwMq9ilEwtKM5NTy02LTDM
        Sy2Hx2tyfu4mRnBK1PLcwXj3wQe9Q4xMHIyHGCU4mJVEeIW0PiYK8aYkVlalFuXHF5XmpBYf
        YjQFhvFEZinR5HxgUs4riTc0sTQwMTMzM7E0NjNUEuc9nb4hUUggPbEkNTs1tSC1CKaPiYNT
        qoGpROqRqJlGyp5z1Uysi/6cv/crR+acplrPBo/qgFMphlkS93frrXFOvBfMY3EhXX72xfBi
        4aYX3V9c34k9j1J15YtumZsRbqP58eq5KJmK8v1G04+bb4zJXbzCM3T55KK1Py5N6jZdNG2u
        5q1TF2UZdrHO1zaZt/7I7lT1nTaetyy3l7Ss1b3pvvLCw/Xyc9S6c1hP5ueutj3xb8eVK+z7
        95ypfj15/xOeJ1/7vr2Zqp1/YMo3WWaDUr7XEyRZOMWTRbz1i/WyrtQuWP1W63dhe87RtV8Z
        daQD0/a9LNjZdi5BKbTg9nGrKnmZA84fb3w/aSptam0+Tcl4D0togTj/2ZX7ov2UOSdtiNuU
        3TRLiaU4I9FQi7moOBEA3ZdGshIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvK5mxKdEgxV7xC1W3+1ns1i5+iiT
        xfm3h5ksJh26xmix95a2xfxlT9kd2Dx2zrrL7nH5bKnHplWdbB6bl9R77L7ZwObxeZNcAFsU
        l01Kak5mWWqRvl0CV8afjqfsBXdZKh6v+sTawHiZuYuRk0NCwETiwN7JLF2MXBxCArsZJa48
        XccIkRCXaL72gx3CFpZY+e85mC0k8JFRYvUr2S5GDg42AU2JC5NLQcIiAmYSCxbMYwGxmQUi
        JA5t2MQEYgsLGEts2fkPrJVFQFXiwIGfYHt5BcwlZl85CbVKXmLmpe/sEHFBiZMzn0DNkZdo
        3jqbeQIj3ywkqVlIUgsYmVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgQHp5bmDsbt
        qz7oHWJk4mA8xCjBwawkwiuk9TFRiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp
        2ampBalFMFkmDk6pBiZbvY9n76pOslMR/BPD+k6L7c+rrtyQRawx3954Z3z4phI9V3hfIsPe
        qV8FvPf31si9YywuV2mNYDe22nsitvIf9/NDqnJHtNSqVXnljNavE6xValuldfNYL9fNG3uv
        KWTeLl2/K6v9rVXnda1pDvXtXXLyXzevlj1tE2OzeY1NtGhf1seb8bnfw6dfMb7+9u99z4df
        Zi0SqXPcYTr/dlXK98lZ3azH9vo+PfRg9j/huTe4Zyksjs9443PsUKugp6DH7tLLthHzIksn
        dSeu/bW7hXWxA9sS70m1Z34pVe9e/cxrf8qLaUEPGuJifh41OC8185JP9s0q5s8zo5rvHnbb
        3NIxj+tI6Fs/ZYnDu3SVWIozEg21mIuKEwEWu5BuvQIAAA==
X-CMS-MailID: 20220127083033epcas5p3ce9565e4b5e21e897571e48e73e4f9af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220127083033epcas5p3ce9565e4b5e21e897571e48e73e4f9af
References: <CGME20220127083033epcas5p3ce9565e4b5e21e897571e48e73e4f9af@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe passthru takes a single buffer pointer.
This enables using multiple buffers for passthru, similiar to
readv/writev.

First patch is prep, while second one adds vectored-io abililty to
NVME_IOCTL_IO64_CMD.

Kanchan Joshi (2):
  block: introduce and export blk_rq_map_user_vec
  nvme: add vectored-io support for user passthru

 block/blk-map.c                 | 19 +++++++++++++++++++
 drivers/nvme/host/ioctl.c       |  9 ++++++---
 include/linux/blk-mq.h          |  2 ++
 include/uapi/linux/nvme_ioctl.h |  4 ++++
 4 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.25.1

