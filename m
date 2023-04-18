Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50797C77B76
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 12:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjDRMlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 08:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjDRMlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 08:41:19 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0486E146C1
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 05:41:11 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230418123148epoutp02ce8bab3b32afc735257a1edebc72c9c5~XB2MflvMl0870908709epoutp02q
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 12:31:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230418123148epoutp02ce8bab3b32afc735257a1edebc72c9c5~XB2MflvMl0870908709epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681821108;
        bh=1WRd5iEcmaNEFf0Z9O+4Q40zENmc+eV+2VGKGjrgUBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OXZT50kFmh+745VlsiYpm6nFrif11zTT6RxWGVeUJF1I5e6fnEGoXw1yjei3L0meT
         hJlT5oqLBjLrdq6YLKcK1ZoEDqBTDx9KtrpZ0TSP9Z8R7G+gq87eWqr7l1c+W2drSN
         SqrrBGtjbf2YcHYcIiRxaOFJ0IHROYokxNkCrn7s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230418123147epcas5p2d7ad8d98b29d88095db90a0871892d69~XB2MRX-Wg1589215892epcas5p2g;
        Tue, 18 Apr 2023 12:31:47 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Q13FZ59f8z4x9Px; Tue, 18 Apr
        2023 12:31:46 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.79.09987.2BD8E346; Tue, 18 Apr 2023 21:31:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230418123146epcas5p38b605ff4561743cae7025a744043c941~XB2K5Tvrq0836608366epcas5p3j;
        Tue, 18 Apr 2023 12:31:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230418123146epsmtrp189f4bcbad33c0dc79a0b047e2ef16d56~XB2K4pDEl2680126801epsmtrp1c;
        Tue, 18 Apr 2023 12:31:46 +0000 (GMT)
X-AuditID: b6c32a4b-a67fd70000002703-4e-643e8db28988
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.0B.08279.2BD8E346; Tue, 18 Apr 2023 21:31:46 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230418123145epsmtip281a72049f2eb50bed77fcf10eac688b0~XB2KPQRZM0356303563epsmtip2K;
        Tue, 18 Apr 2023 12:31:45 +0000 (GMT)
Date:   Tue, 18 Apr 2023 17:58:51 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     David Howells <dhowells@redhat.com>
Cc:     hch@lst.de, linux-block@vger.kernel.org
Subject: Re: How best to get the size of a blockdev from a file?
Message-ID: <20230418122833.GA14457@green245>
MIME-Version: 1.0
In-Reply-To: <1609851.1681812012@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmuu6mXrsUg98P1SzeNf1msVi5+iiT
        xd5b2g7MHrtvNrB5vN93lc3j8ya5AOaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11D
        SwtzJYW8xNxUWyUXnwBdt8wcoD1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKT
        Ar3ixNzi0rx0vbzUEitDAwMjU6DChOyM1sZG5oI+toq+608ZGxgXs3YxcnJICJhIrPt8nq2L
        kYtDSGA3o8SftQuYIZxPjBKzu84wQTjfGCVmXD7JDtPy/v1hZhBbSGAvo8TBpXUQRc8YJS5/
        f8oEkmARUJW437KEsYuRg4NNQFPiwuRSkLCIgLrEo2UbwXqZBbQlZt7ZxwZiCws4SMw/9wCs
        lVdAV2LXzw5WCFtQ4uTMJywgNqeAhcTEr3fBekUFlCUObDsOdpyEwDl2iesvNjFDHOcisWjr
        DxYIW1ji1fEtUEdLSbzsb4OykyUuzTzHBGGXSDzecxDKtpdoPdUPdVyGxOfrG9ggbD6J3t9P
        mEB+kRDglehoE4IoV5S4N+kpNBjFJR7OWAJle0hcvvqCHRIm3YwSt/5uZZ/AKDcLyT+zkKyA
        sK0kOj80sc4CWsEsIC2x/B8HhKkpsX6X/gJG1lWMkqkFxbnpqcWmBcZ5qeXwOE7Oz93ECE55
        Wt47GB89+KB3iJGJg/EQowQHs5II7xlXqxQh3pTEyqrUovz4otKc1OJDjKbA6JnILCWanA9M
        unkl8YYmlgYmZmZmJpbGZoZK4rzqtieThQTSE0tSs1NTC1KLYPqYODilGpjYAi6+V1id9Gdm
        iVC7eJJfjuh6KfmD699o/+PaYrBJsnl2QPxWazFXsXfJ007zfHE3uGPxJ23Lv9e2PJv5MlaU
        aWYolHd+sFiw+PnXT3VTFdILWuqPvAxg/Jp86IH+jHXLDijM+nZx86n/N39O9cnxvZyq16qw
        tfW65H5+v9B7/7586srkYJxobv1TvG5vTK7L0SX/9/fHV356Un3ARPP906sLGm6pmLkcMA6+
        ff5z7MlLC6Jf7zPbOYO9+M3y0zWzz0g5n13m9eakyOzidcyxIqo51/Z7XEs1rgpV5Mq6aXNt
        8SR/K0bPJX8n2k7XOt/A/vp7vXur68x3LEae+qa3F9Rcq4+WEd9+zZxPxGCSEktxRqKhFnNR
        cSIAmJyyEwIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSvO6mXrsUgxXPhCzeNf1msVi5+iiT
        xd5b2g7MHrtvNrB5vN93lc3j8ya5AOYoLpuU1JzMstQifbsEroyF53czFhxgrtjS+oG9gfE9
        UxcjJ4eEgInE+/eHmbsYuTiEBHYzSmy5/54dIiEu0XztB5QtLLHy33N2iKInjBJdvRcZQRIs
        AqoS91uWANkcHGwCmhIXJpeChEUE1CUeLdvIDGIzC2hLzLyzjw3EFhZwkJh/7gHYYl4BXYld
        PztYIWZ2M0o0nzjBDpEQlDg58wkLRLOZxLzND5lB5jMLSEss/8cBEuYUsJCY+PUu2HxRAWWJ
        A9uOM01gFJyFpHsWku5ZCN0LGJlXMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEB7GW
        5g7G7as+6B1iZOJgPMQowcGsJMJ7xtUqRYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC
        6YklqdmpqQWpRTBZJg5OqQYmVrNXU5oWMzWXplgvmxH/dynHQtsX7K8cC67EONQs3FpYvM9J
        xS58S9nXfYrtC7gWLOhqXb44J+Zgy77bc8QmXJskfVSEbfF1u6U/3v3irTZokYiuZ9taN2e7
        tc/PEJYvITt9w0+flmrbwfioMDch7eqt6hPzHW6oVoeLTOGRUy1ebhAz+8QPzrIM590f2w89
        vODjeLt/SqBSf3/t/+1Bs3p9EhM41FSEtkxOez29c/GV9a9sU1a2Z/yYPW2iVa+19dG0KauK
        zZQ+VVw78GGV3enF351vhxgzuxrpPDCcdGXBj3+rvXiyfuz/tahY1qzc/ef0iEdu0k3CjyTC
        VRzf7zQ0ttK51LVSvUiY98YBJZbijERDLeai4kQAiwHoi9ECAAA=
X-CMS-MailID: 20230418123146epcas5p38b605ff4561743cae7025a744043c941
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----M1XhpxpcEzXMl-TZDJz3dv6uQhpc8LNXMKbaeBmU9jEugurT=_27504_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230418100108epcas5p2d0f2a7a274e78731373986b3d4fced9b
References: <CGME20230418100108epcas5p2d0f2a7a274e78731373986b3d4fced9b@epcas5p2.samsung.com>
        <1609851.1681812012@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------M1XhpxpcEzXMl-TZDJz3dv6uQhpc8LNXMKbaeBmU9jEugurT=_27504_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, Apr 18, 2023 at 11:00:12AM +0100, David Howells wrote:
>Hi Christoph,
>
>It seems that my use of i_size_read(file_inode(in)) in filemap_splice_read()
>to get the size of the file to be spliced from doesn't work in the case of
>blockdevs and it always returns 0.
>
>What would be the best way to get the blockdev size?  Look at
>file->f_mapping->i_size maybe?

bdev_nr_bytes(I_BDEV(file->f_mapping->host))
should work I suppose.

------M1XhpxpcEzXMl-TZDJz3dv6uQhpc8LNXMKbaeBmU9jEugurT=_27504_
Content-Type: text/plain; charset="utf-8"


------M1XhpxpcEzXMl-TZDJz3dv6uQhpc8LNXMKbaeBmU9jEugurT=_27504_--
