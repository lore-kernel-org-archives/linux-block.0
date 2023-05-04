Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADBBC7EE21
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 08:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjEDIZf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjEDIY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 04:24:57 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA926B8
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 01:18:17 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230504081814euoutp02abc86559cf673288e6dd3802ed688df9~b4tXnVCql1688416884euoutp02I
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 08:18:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230504081814euoutp02abc86559cf673288e6dd3802ed688df9~b4tXnVCql1688416884euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683188294;
        bh=2S+vXMgV+9nZdpyHYBC3wNWYN0tVgvNlVLU62JHlSto=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=H+XPh3CyOrDI/qPYP38sCaZGR7ubALwQGKTyDEqy3UC76AgB0mP9rW11M/n1lssPs
         2LGn1HuWN3wbyfCC8DEkBhhcwiB9j7pAX+Jnsy4/+bXkpIITowjmTjH/CZk5a6M869
         KoayfY+yOROosmoJtumffxmWaYPGyHDL2MSLLi6o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230504081813eucas1p16726a03b240ccb5e26cc37d229402d7e~b4tXKpEpJ0395703957eucas1p1M;
        Thu,  4 May 2023 08:18:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DC.48.37758.54A63546; Thu,  4
        May 2023 09:18:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230504081813eucas1p2e0d84c9ce312234e3f055715450726ae~b4tWym8P61863118631eucas1p2h;
        Thu,  4 May 2023 08:18:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230504081813eusmtrp288b560b45cdb18eec265aaae6a1f856d~b4tWx_rJi0723907239eusmtrp2i;
        Thu,  4 May 2023 08:18:13 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-9a-64536a4570ca
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 85.4D.14344.54A63546; Thu,  4
        May 2023 09:18:13 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230504081812eusmtip279451a9a5b8bc47c13d768da0651031a~b4tWkrJRt0627206272eusmtip2b;
        Thu,  4 May 2023 08:18:12 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 4 May 2023 09:18:12 +0100
Message-ID: <4ebe73b3-dc59-fe59-bb6a-69a775069b78@samsung.com>
Date:   Thu, 4 May 2023 10:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/11] block: Fix the type of the second
 bdev_op_is_zoned_write() argument
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230503225208.2439206-3-bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7quWcEpBgu3KFmsvtvPZjHtw09m
        i99nzzNbrFx9lMniyfpZzBZ/u+4xWey9pW1xaHIzkwOHx+Ur3h6Xz5Z6bFrVyeax+2YDm8fO
        1vusHu/3XWXz+LxJzqP9QDdTAEcUl01Kak5mWWqRvl0CV8bPlx+YCs6yVLRcesDSwPiBuYuR
        k0NCwETixIJ21i5GLg4hgRWMEt+nXWOGcL4wSiyc9Roq85lR4uvd63At/z5vZYRILGeUOLr7
        Dhtc1ev7r9khnB1AzqH1YC28AnYSe6/sYAOxWQRUJLYen88KEReUODnzCQuILSoQLbF43xQw
        W1ggWeLXmRVg9cwC4hK3nsxnArFFBNwkGq7uAtvGLPCWUeLwrjYgh4ODTUBLorGTHaSGU8BK
        ou/tG3aIXnmJ7W/nQJ2tKDHp5ntWCLtW4tSWW0wgcyQEpnNKnNt2hhEi4SKx5VwjO4QtLPHq
        +BYoW0bi/06IIyQEqiWe3vjNDNHcwijRv3M92BESAtYSfWdyQExmAU2J9bv0IcodJY48nMcI
        UcEnceOtIMRpfBKTtk1nnsCoOgspJGYh+XgWkg9mIQxdwMiyilE8tbQ4Nz212DgvtVyvODG3
        uDQvXS85P3cTIzBRnf53/OsOxhWvPuodYmTiYDzEKMHBrCTC+6HQL0WINyWxsiq1KD++qDQn
        tfgQozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QD01bOz/fWXXybW7n29SX2Z8vZ8tdI
        LOhRjpt28ICTCu/G9693RF8o9T9dvXm5P9fl29Oze21afGPsCrj/rNBp1vqxIy3/P2dWtx7b
        RIM13zx//ryTlp8rqe7udd79Sqv8tAj1H7NbysrCGnI+tX1YwHs1ps98wlJLbdc1H6danmGe
        z/6ssijZIMeob9O/u1u4l/1q2ufwYpqcVP+1g+k6E9h2yb0U2PysdVHQy6kbxD57ul/9fHTr
        ComgGQcTc3fyKj4w+bHI9dZR0aU61YeefSh9ZnanfNKJnYkma46pb5fcvESv8uXnrkVbAryN
        stj9xFX3uyw+uHtOglM8R9nd96ud3sZHiAkX9LBd+Dzl/kklluKMREMt5qLiRADpZi7FwwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7quWcEpBj/6WC1W3+1ns5j24Sez
        xe+z55ktVq4+ymTxZP0sZou/XfeYLPbe0rY4NLmZyYHD4/IVb4/LZ0s9Nq3qZPPYfbOBzWNn
        631Wj/f7rrJ5fN4k59F+oJspgCNKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srI
        VEnfziYlNSezLLVI3y5BL+Pnyw9MBWdZKlouPWBpYPzA3MXIySEhYCLx7/NWRhBbSGApo8S/
        u5IQcRmJjV+uskLYwhJ/rnWxdTFyAdV8ZJT4/v0XM0TDDkaJb3MNQWxeATuJvVd2sIHYLAIq
        EluPz2eFiAtKnJz5hAXEFhWIlrix/BsTiC0skCzx68wKsHpmAXGJW0/mg8VFBNwkGq7uAlvG
        LPCaUaJj50QWiM17GSVOnVgEVMXBwSagJdHYyQ7SwClgJdH39g07xCBNidbtv6FseYntb+dA
        fakoMenme6hvaiU+/33GOIFRdBaS+2YhuWMWklGzkIxawMiyilEktbQ4Nz232EivODG3uDQv
        XS85P3cTIzC+tx37uWUH48pXH/UOMTJxMB5ilOBgVhLh/VDolyLEm5JYWZValB9fVJqTWnyI
        0RQYSBOZpUST84EJJq8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1Oq
        gUklx6r31FXNywlNa5OPfHZNeZ76T0bGKfa8cc2W6TUztYvycpfqzsqYoz1phUL/t3eLnJuL
        rNhDq+XPVXqKzny7fH+tSlBOVtMT4ccvEljKGjInlrBerfB9yW+/63f6C66TR0X/S6+conlz
        nUnuuz29G68opkntOTN93zuRmk3vJs0Ra9JuNPL28i1Wbha7Oj3vm/gbCTt+7fkXzy9xj1Vk
        nOV3k6n7zJ7Fu5k3mzPmXDVY+jrp0vnPwfINKXWfvqsJr3yk8iZ9ntMVHutVry6svHh+mauh
        6TL90pYFCjlhwem+kfWJnws+3bh4U+jwv5dTkn25U76lubasrzc4ymlZpc+5cpFVZtDhFKFt
        okosxRmJhlrMRcWJAIbnl3V4AwAA
X-CMS-MailID: 20230504081813eucas1p2e0d84c9ce312234e3f055715450726ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230503225219eucas1p12084e1dfec954d1bfe984c4ed1c215f7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230503225219eucas1p12084e1dfec954d1bfe984c4ed1c215f7
References: <20230503225208.2439206-1-bvanassche@acm.org>
        <CGME20230503225219eucas1p12084e1dfec954d1bfe984c4ed1c215f7@eucas1p1.samsung.com>
        <20230503225208.2439206-3-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Change the type of the second argument of bdev_op_is_zoned_write() from
> blk_opf_t into enum req_op because this function expects an operation
> without flags as second argument.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Pankaj Raghav <p.raghav@samsung.com>
> Fixes: 8cafdb5ab94c ("block: adapt blk_mq_plug() to not plug for writes that require a zone lock")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
