Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC05C7EE2E
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 06:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjB0GHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 01:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjB0GGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 01:06:54 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF7714215
        for <linux-block@vger.kernel.org>; Sun, 26 Feb 2023 22:06:26 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230227060623epoutp04c802796e8c8ab5efd852faa2319010ed~HmVasCqyy3038230382epoutp04Q
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 06:06:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230227060623epoutp04c802796e8c8ab5efd852faa2319010ed~HmVasCqyy3038230382epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677477983;
        bh=vIoz29UZVyH0q7ZSAtP9vZs7cGKZNreKhiGp8UZo6hM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GhRV2WLjaCJRdiKftdh3RlYyMptcYW2jIEgdZfpx1XNuVnaIuUyDTbCFRg2dsVx7+
         WBTh2Q3w9c4ca/wVMY6m4jM2m4RSaxhfyY051vD9/dPnN0ujDAlN4vP3a08z994r9t
         aumYsmXauBMLawStgVvaVBYb+C9YPn99oDiogcoY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230227060623epcas5p259b5a0842fd8074438b6a0ca34249f5f~HmVadMCvb1714017140epcas5p2h;
        Mon, 27 Feb 2023 06:06:23 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PQ93x40k4z4x9Ps; Mon, 27 Feb
        2023 06:06:21 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.64.06765.D584CF36; Mon, 27 Feb 2023 15:06:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230227060620epcas5p4af89e04919e22f1997abc1acf204f456~HmVXnYCZu2710627106epcas5p4L;
        Mon, 27 Feb 2023 06:06:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230227060620epsmtrp20bc61ed09fb99febc1a8d220cd1e8d16~HmVXmtwce2994029940epsmtrp2V;
        Mon, 27 Feb 2023 06:06:20 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-db-63fc485decab
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.05.05839.C584CF36; Mon, 27 Feb 2023 15:06:20 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230227060619epsmtip20d126896680ea8685c2cb8cc4f86d2e7~HmVW5-EfW0143701437epsmtip2i;
        Mon, 27 Feb 2023 06:06:19 +0000 (GMT)
Date:   Mon, 27 Feb 2023 11:35:47 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests v2 0/2] nvme: add test for unprivileged
 passthrough
Message-ID: <20230227060547.GA25049@green5>
MIME-Version: 1.0
In-Reply-To: <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmlm6sx59kg7VLZSxWrj7KZLH3lrbF
        /GVP2S32zfJ0YPHYvKTeY/fNBjaPz5vkPNoPdDMFsERl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGcsnHKSvWAze8WEQ31sDYyr2LoYOTkk
        BEwkVj89zN7FyMUhJLCbUWLXtRNMEM4nRolla09BOd8YJTqOLWOGaWl9MB+qZS+jxIfXB6Gc
        J4wSax6uYgKpYhFQlTi39QeQzcHBJqApcWFyKUhYRMBM4sqxN+wgYWaBRIlL9x1BwsICQRKr
        /00G6+QV0JY4tHA3M4QtKHFy5hMWEJtTwFli3+1LYHFRAWWJA9uOM0Hcc4td4tyeEAjbReL9
        2ivsELawxKvjW6BsKYnP7/ZCvZwscWnmOajeEonHew5C2fYSraf6weYzC2RI/F3/mwnC5pPo
        /f0E7BMJAV6JjjYhiHJFiXuTnrJC2OISD2csYYUo8ZBY+94EEiDTGCVeND1gncAoNwvJN7OQ
        bICwrSQ6PzSxzgIHirTE8n8cEKamxPpd+gsYWVcxSqYWFOempxabFhjnpZbDYzg5P3cTIzj9
        aXnvYHz04IPeIUYmDsZDjBIczEoivHdO/kgW4k1JrKxKLcqPLyrNSS0+xGgKjJuJzFKiyfnA
        BJxXEm9oYmlgYmZmZmJpbGaoJM6rbnsyWUggPbEkNTs1tSC1CKaPiYNTqoGJUVA57SDHI43I
        efsDQzeziRd/yWhjqvSV/fepsmPNV1m93sV5NTeMp25v9z/rXz5pn8FmT5Wz59g5fMxTSiKq
        K/sSTp7Qs2pga/Mpy76vns/KqJqyPz31cfCr2S075Z7P73BhibHnzqkx5djZ6lote3BX57Oo
        4gcmjH+PLzy4qXW9Vp/ihoJdHh8PxhX8OHvm7Y3O6ed4LPXO3psTOC1RKf7m81uppioNF003
        2Ur9vbRLdkrcu2ut/5WPMO83P+ymJuKhqv/f48bEfkcj/kD2NsMdZxamLhXh03PTfmsRKmT5
        zm79mjSJiQtdb044YHqx79zPD8Kvt7yqZRHPVZkV+1pX9N3RjcXTsyt7vJRYijMSDbWYi4oT
        AYGsYPkIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSvG6Mx59kg8X7xCxWrj7KZLH3lrbF
        /GVP2S32zfJ0YPHYvKTeY/fNBjaPz5vkPNoPdDMFsERx2aSk5mSWpRbp2yVwZUx9vpGt4ClL
        xZ3NR5gbGL8xdzFyckgImEi0PpjP3sXIxSEksJtR4uv1T6wQCXGJ5ms/2CFsYYmV/55DFT1i
        lFiwZhUbSIJFQFXi3NYfTF2MHBxsApoSFyaXgoRFBMwkrhx7A9bLLJAocfDPc7CZwgJBEqv/
        TWYCsXkFtCUOLdzNDDFzGqPEzM9vGSESghInZz5hgWg2k5i3+SEzyHxmAWmJ5f84QMKcAs4S
        +25fAntAVEBZ4sC240wTGAVnIemehaR7FkL3AkbmVYySqQXFuem5xYYFhnmp5XrFibnFpXnp
        esn5uZsYwUGtpbmDcfuqD3qHGJk4GA8xSnAwK4nw3jn5I1mINyWxsiq1KD++qDQntfgQozQH
        i5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJqYd6Vb/i+5PW/WRNdUzyXH57bxFi8Vm5ji0
        PTi+SnOiovKz45wcTxmb2Utm9YpcPqCxLHhPS0yqe/HbYB/TNjEP7t1GS57cylmvsC4+2Nsq
        d71Is+EKxXmJuYf53ncv2KtyO7vPqUhBdOYWLvOdd+M0W8y9JhjvDwnqOL760qZ2A9Y+XyeF
        /qxQub3vtZe/XPHjvLDpyifeOqJrneYmT1rm/OA8p5tjpG6mP3vFg2juwsWtiRu+GTje0Y3a
        vHPmxvbFHzlErvGdvKLNYLvqztf5brwdW3fxvDF6fWn164zz0mJ1M1YmbJ5V/kTl1tK4ZYLr
        bD+/1N904R/TrJnVLty9czXcJ6xS44621JF9r8RSnJFoqMVcVJwIABEkAqzZAgAA
X-CMS-MailID: 20230227060620epcas5p4af89e04919e22f1997abc1acf204f456
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_9769f_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214044749epcas5p4ac6bf441e046e3642b1633fd9cf7a72b
References: <CGME20230214044749epcas5p4ac6bf441e046e3642b1633fd9cf7a72b@epcas5p4.samsung.com>
        <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_9769f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, Feb 14, 2023 at 01:47:37PM +0900, Shin'ichiro Kawasaki wrote:
>Per suggestion by Kanchan, add a new test case to test unprivileged passthrough
>of NVME character devices. The first patch adds a feature to run commands with
>normal user privilege. The second patch adds the test case using the feature.
>
>Changes from v2:
>* Added the first patch to add normal user privilege support to blktests
>* Adjusted the test case to the functions for normal user privilege support

Thanks, this looks way better. And works fine in my setup.
If required,
Tested-by: Kanchan Joshi <joshi.k@samsung.com>

------IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_9769f_
Content-Type: text/plain; charset="utf-8"


------IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_9769f_--
