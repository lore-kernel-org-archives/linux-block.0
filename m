Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE126C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 07:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43274216C4
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 07:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cPCJozz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgLAHMs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:12:48 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:27773 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbgLAHMs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 02:12:48 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201201071204epoutp023427d60759c571cf903aa69f5fd97d97~MhjPmSEGl0231102311epoutp02u
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 07:12:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201201071204epoutp023427d60759c571cf903aa69f5fd97d97~MhjPmSEGl0231102311epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606806724;
        bh=dSZxR9MSN2+0IuqkpjmxEKtgOBexygC82P18mNnNo3g=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cPCJozz9Rfe5jeTCY3DBgbiX3V0TPYxdepTNL4wQJERFipU+drSwd9G+X+i+4lqhz
         Jj/tW46qvVlCegG8DAdzcQwrqsqb+AKELh4wK0DtGry+FwSa5Y85X5XjKhJoKthOk9
         lWqOwJsiHf5XCiXwcOTB5vCRQWNwReh/leKChE+M=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20201201071203epcas5p496c4b86aed88c66d1f3ccd3cc619f031~MhjOy_Dfw1118911189epcas5p4J;
        Tue,  1 Dec 2020 07:12:03 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.00.50652.3CCE5CF5; Tue,  1 Dec 2020 16:12:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20201201054049epcas5p2e0118abda14aaf8d8bdcfb543bc330fc~MgTkfg-1Y2045320453epcas5p2l;
        Tue,  1 Dec 2020 05:40:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201201054049epsmtrp2fa8c3b202a21b2bfab414a41b419e895~MgTkevAtx1422914229epsmtrp22;
        Tue,  1 Dec 2020 05:40:49 +0000 (GMT)
X-AuditID: b6c32a4a-6c9ff7000000c5dc-7c-5fc5ecc3c8b8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.6E.13470.167D5CF5; Tue,  1 Dec 2020 14:40:49 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201201054045epsmtip2a51dd3abb6c426536449e143900b0656~MgTgupi9U0384403844epsmtip2k;
        Tue,  1 Dec 2020 05:40:45 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, selvajove@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [RFC PATCH 0/2] add simple copy support
Date:   Tue,  1 Dec 2020 11:09:47 +0530
Message-Id: <20201201053949.143175-1-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7bCmhu7hN0fjDR7sUrFYfbefzaK1/RuT
        xcrVR5ksHt/5zG5x9P9bNotJh64xWuy9pW1xedccNov5y56yW2z7PZ/Z4sqURcwW616/Z7F4
        8P46u8XrHyfZHPg8ds66y+5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaPvi2rGD0+b5LzaD/Q
        zRTAGcVlk5Kak1mWWqRvl8CVMW2ZXcEXvoqruw+yNTCe4e5i5OSQEDCROHRoCROILSSwm1Hi
        6qraLkYuIPsTo0TnnFmMEM43RokDDz6ywXQs3beEHSKxl1GivfMpE4TzmVHi2YFlLCBVbAK6
        EteWbAKzRQSUJP6ub2IBKWIWmM8kMfn2VVaQhLCAgURb72ywIhYBVYmdz8+yg9i8AnYSyxa9
        YIRYJy8x89J3qLigxMmZT8DqmYHizVtnM0PUrOSQeLwiCMJ2kVjy8BUThC0s8er4FnYIW0ri
        87u9UC+USzzrnAZV08Ao0fe+HMK2l7i45y9QnANovqbE+l36EGFZiamn1jFBrOWT6P39BKqV
        V2LHvCdg5RICahKntptBhGUkPhzeBbXJQ6Jr5w5WSPDGSiw4Npd9AqP8LCTPzELyzCyExQsY
        mVcxSqYWFOempxabFhjlpZbrFSfmFpfmpesl5+duYgQnLy2vHYwPH3zQO8TIxMF4iFGCg1lJ
        hJfl35F4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxKP87ECQmkJ5akZqemFqQWwWSZODilGphW
        sivwXPGfu9133mIp/91uPsWRG2yXTMuauXya2uPfuk71kRw/gw/W/lAPq1ReuLJz95SJeXer
        W7l+siw78Mj398zaK5unz7jXFXf82eweMduzcxa2N/K4TLXTWn31o5Tf6n8Ny/8Kl5UIrr/M
        o8fYmlVS9SKmumOpaIl34koB+ecC8z5+Pz0z/sbixoKU/ulxCwQKhc//YRB518Lo7q+QEOSW
        8vhUk+dSySZ+//VrJv/b3CLcd/nSthDN2ROyIha5HGxMi/7yY5I817MVvJ5GGqlX7k6OOXdD
        /fDD+D2rw6paXhpITYtULtZtv/ujzcg5+7Kg4LvFj+NvptrYP78cVa7w2f3cNh27f3c3pTAq
        sRRnJBpqMRcVJwIAT3iO0M0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSvG7i9aPxBivu8lmsvtvPZtHa/o3J
        YuXqo0wWj+98Zrc4+v8tm8WkQ9cYLfbe0ra4vGsOm8X8ZU/ZLbb9ns9scWXKImaLda/fs1g8
        eH+d3eL1j5NsDnweO2fdZfc4f28ji8fls6Uem1Z1snlsXlLvsftmA5tH35ZVjB6fN8l5tB/o
        ZgrgjOKySUnNySxLLdK3S+DKmLbMruALX8XV3QfZGhjPcHcxcnJICJhILN23hL2LkYtDSGA3
        o8TFDz2MEAkZibV3O9kgbGGJlf+eQxV9ZJQ4OuURWIJNQFfi2pJNLCC2iICSxN/1TSwgRcwC
        65kkdm38AlYkLGAg0dY7G6yIRUBVYufzs+wgNq+AncSyRS+gtslLzLz0HSouKHFy5hOgeg6g
        QeoS6+cJgYSZgUqat85mnsDIPwtJ1SyEqllIqhYwMq9ilEwtKM5Nzy02LDDMSy3XK07MLS7N
        S9dLzs/dxAiOHS3NHYzbV33QO8TIxMF4iFGCg1lJhJfl35F4Id6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rw3ChfGCQmkJ5akZqemFqQWwWSZODilGpiS2hRC5zmuuyOe8+Cki2Dh8aKzX68UKm1+
        8PSpcMD3As+2HV8Nnh+JcIprfXvsidXsJFdTtissur/kHNMSNEUiNyRLrjoSazLTVrr641Rp
        Iz6/NUyzHJrufZnwz3zXhoJ9u89emWXy9frst2fyV3usjg5KmqK3a+1Oh/2yHz2WMC9e0txW
        vWRHGm8pA0dbsjdX4+Fb5vOj407rrhezUFG626egnaT3emL9POckC3mRVSs60uTyL1RLLl4z
        0XjxU6dWbc+pN999CI3j+1UkXzGPS316Q/yvrWlBCw2f1TLMXWJ2Kfic+v6v1zrli8NTDRa/
        4Os7zle3Yx3Lw1WK/rtbQg9z7vlykPvj8eOX2X4rsRRnJBpqMRcVJwIArIYlzAwDAAA=
X-CMS-MailID: 20201201054049epcas5p2e0118abda14aaf8d8bdcfb543bc330fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201201054049epcas5p2e0118abda14aaf8d8bdcfb543bc330fc
References: <CGME20201201054049epcas5p2e0118abda14aaf8d8bdcfb543bc330fc@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patchset tries to add support for TP4065a ("Simple Copy Command"),
v2020.05.04 ("Ratified")

The Specification can be found in following link.
https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip

This is an RFC. Looking forward for any feedbacks or other alternate
designs for plumbing simple copy to IO stack.

Simple copy command is a copy offloading operation and is  used to copy
multiple contiguous ranges (source_ranges) of LBA's to a single destination
LBA within the device reducing traffic between host and device.

This implementation accepts destination, no of sources and arrays of
source ranges from application and attach it as payload to the bio and
submits to the device.

Following limits are added to queue limits and are exposed in sysfs
to userspace
	- *max_copy_sectors* limits the sum of all source_range length
	- *max_copy_nr_ranges* limits the number of source ranges
	- *max_copy_range_sectors* limit the maximum number of sectors
		that can constitute a single source range.


SelvaKumar S (2):
  block: add simple copy support
  nvme: add simple copy support

 block/blk-core.c          | 104 +++++++++++++++++++++++++++++++---
 block/blk-lib.c           | 116 ++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |   2 +
 block/blk-settings.c      |  11 ++++
 block/blk-sysfs.c         |  23 ++++++++
 block/blk-zoned.c         |   1 +
 block/bounce.c            |   1 +
 block/ioctl.c             |  43 ++++++++++++++
 drivers/nvme/host/core.c  |  91 ++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h  |   4 ++
 include/linux/bio.h       |   1 +
 include/linux/blk_types.h |   7 +++
 include/linux/blkdev.h    |  15 +++++
 include/linux/nvme.h      |  45 +++++++++++++--
 include/uapi/linux/fs.h   |  21 +++++++
 15 files changed, 473 insertions(+), 12 deletions(-)

-- 
2.25.1

