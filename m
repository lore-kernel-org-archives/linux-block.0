Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A2FC43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 14:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiGOOL2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiGOOL1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 10:11:27 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A668719
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 07:11:25 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220715141123usoutp0294302e2b8dadbe256a89ca9b336c0745~CBhEY14S22919229192usoutp02U;
        Fri, 15 Jul 2022 14:11:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220715141123usoutp0294302e2b8dadbe256a89ca9b336c0745~CBhEY14S22919229192usoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657894283;
        bh=vEWsSvfEgLJjkqhMQ/C+2oKeyEtz+dCjbqhU81ckiWg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=kVZUAXY/66Zf4PdiPkDafe7f/AkmREraPDwSiDG4+Emsgn8qTcGEU/2xp2AYjDyb5
         6aWeSWAh1sBnpMhnYrZR1HFROtLdDs7HIUrO9yOpkpiaBnFYFTt7lcY5xRnkFkZUru
         COoAjlIF8/UGzmy5gslDKmbbgDTyldAqqYINesSo=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220715141123uscas1p147d523bd69c99a5582920f5eaff4dc5f~CBhENkoPU2979629796uscas1p19;
        Fri, 15 Jul 2022 14:11:23 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 69.D0.09749.A8571D26; Fri,
        15 Jul 2022 10:11:22 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220715141122uscas1p1c68970850027f9f96f39ad9fa29308b3~CBhD4xKSk0812008120uscas1p1q;
        Fri, 15 Jul 2022 14:11:22 +0000 (GMT)
X-AuditID: cbfec370-a6bff70000002615-91-62d1758a737b
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 85.B2.57470.A8571D26; Fri,
        15 Jul 2022 10:11:22 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 15 Jul 2022 07:11:21 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Fri,
        15 Jul 2022 07:11:21 -0700
From:   Vincent Fu <vincent.fu@samsung.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH] null_blk: cleanup null_init_tag_set
Thread-Topic: [PATCH] null_blk: cleanup null_init_tag_set
Thread-Index: AQHYl/m57wZJcmIIdkaHW0K26T6Hdq1/dzpA
Date:   Fri, 15 Jul 2022 14:11:21 +0000
Message-ID: <c109ba5ec91c4fffb1ae834d50076dda@samsung.com>
In-Reply-To: <20220715031916.151469-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduzrOd3u0otJBstnMFqsvtvPZrH3lrbF
        ocnNTA7MHpfPlnq833eVzePzJrkA5igum5TUnMyy1CJ9uwSujDMfn7EXPBSsWHVgJVsD402+
        LkZODgkBE4ljR5pYuxi5OIQEVjJKHN8wE8ppZZI4uOovI0zVs7bXTBCJtYwSs3YcYYFwPjFK
        PHx4HMpZxihx8f9toBYODjYBTYm3+wtAukUEHCTWve8Am8QsYC+x93YrmC0sYCHx9MpiVoga
        S4nlRx9C2UYSu3vmM4HYLAKqEvc7j7KA2LwCVhInry4DszmB7GUL5rKD2IwCYhLfT61hgpgv
        LnHrCUSvhICgxKLZe5ghbDGJf7seskHYihL3v79kh6jXkViw+xMbhK0tsWzha2aIXYISJ2c+
        YYGol5Q4uOIG2I8SAlM5JO4dbWEH+VFCwEVi/j5oOEpL/L27jAmipp1RYu7GL1DNExglrj+R
        grCtJf51XoNazCfx99cjxgmMyrOQ3D0LyU2zkNw0C8lNCxhZVjGKlxYX56anFhvnpZbrFSfm
        Fpfmpesl5+duYgQmktP/DhfsYLx166PeIUYmDsZDjBIczEoivN2HziUJ8aYkVlalFuXHF5Xm
        pBYfYpTmYFES512WuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwJS41c+4yHST7pLu/p7S9IDGxRXz
        y2Q6mDITYoOuuzGWewZfOGx5+kzXsYhb8SyTNKxXW290dNLeLmx/VTXrXrSNw7+dYrv8d2ek
        tzz2ju6wTJD4n/5Qff+86OOzerfc+7fGMTe1fe2bev7gp1V7Zhq3BwkFX4pTFz/+54Ntcfai
        pUlHFQxXRrprbV3BO+tl9xOH8JuHEt4v13sXeffmtfdh1xe7PrROuOYTMEH1X4Lvj/5ZGRZz
        t1W6KbM3Pnh0JPvASRfmsyxpL2tEmZZOKOuI5RPQsZ316ybX+/a/J5Lltmd27L9tfjxqtYeJ
        7iWn01dPbtNmOVNZdaExZfOi47f3qwSbibP1GMxNcZhyS4mlOCPRUIu5qDgRAN5XVS6TAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWS2cA0Uber9GKSQecZDYvVd/vZLPbe0rY4
        NLmZyYHZ4/LZUo/3+66yeXzeJBfAHMVlk5Kak1mWWqRvl8CVcebjM/aCh4IVqw6sZGtgvMnX
        xcjJISFgIvGs7TVTFyMXh5DAakaJtcu2QDmfGCW+T9rNBuEsY5S4eGwScxcjBwebgKbE2/0F
        IN0iAg4S6953MILYzAL2Entvt4LZwgIWEk+vLGaFqLGUWH70IZRtJLG7Zz4TiM0ioCpxv/Mo
        C4jNK2AlcfLqMhaIXb2MEot+XQUr4gRKLFswlx3EZhQQk/h+ag0TxDJxiVtPIAZJCAhILNlz
        nhnCFpV4+fgfK4StKHH/+0t2iHodiQW7P7FB2NoSyxa+ZoZYLChxcuYTFoh6SYmDK26wTGAU
        n4VkxSwk7bOQtM9C0r6AkWUVo3hpcXFuekWxUV5quV5xYm5xaV66XnJ+7iZGYLSd/nc4egfj
        7Vsf9Q4xMnEwHmKU4GBWEuHtPnQuSYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvy6iJ8UIC6Ykl
        qdmpqQWpRTBZJg5OqQYmB8tjboHXyj7e/bPUWnxT1YWX5RKrcv3NzwSYBbfcfxImzf3OOJGd
        UfrfkboXL81U4oPNpxrOUD3z69GOU14cwQ0+ciJCfh4J8y/vY9mT3XvP6VKF+ZS+z1vPHVj+
        q2nN/ikqDx5ufz8xPNLT+N715aV5Tzy9tY0D12YkFH/S/rU/6tzBl+y12dWTv/y/YmUS+LXq
        t2RV0HaTYN9nyVVbt3YVzZjZIrxGe9o9Ez+HM5mb1m/5lNw/NfbphmXbOx/+Y6/+8mjq7MWl
        9zab5jmft377iFeuzLGm8AbrWnMvHYb4lvkfIvuON+gJ/yvf9Upils5TZxH+XIOLH7en/Cg8
        5PW0i6cxMOvWrMV6j+/LK7EUZyQaajEXFScCAL8zUIIlAwAA
X-CMS-MailID: 20220715141122uscas1p1c68970850027f9f96f39ad9fa29308b3
CMS-TYPE: 301P
X-CMS-RootMailID: 20220715031940uscas1p27e74dec9ebf60d454441271aabe147de
References: <CGME20220715031940uscas1p27e74dec9ebf60d454441271aabe147de@uscas1p2.samsung.com>
        <20220715031916.151469-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -----Original Message-----
> From: Ming Lei [mailto:ming.lei@redhat.com]
> Sent: Thursday, July 14, 2022 11:19 PM
> To: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org; Ming Lei <ming.lei@redhat.com>;
> Vincent Fu <vincent.fu@samsung.com>
> Subject: [PATCH] null_blk: cleanup null_init_tag_set
>=20
> The passed 'nullb' can be NULL, so cause null ptr reference.
>=20
> Fix the issue, meantime cleanup null_init_tag_set for avoiding to add
> similar issue in future.
>=20
> Cc: Vincent Fu <vincent.fu@samsung.com>
> Fixes: 37ae152c7a0d ("null_blk: add configfs variables for 2 options")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/null_blk/main.c | 49 ++++++++++++++++++++++-----------
> --
>  1 file changed, 31 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
> index c955a07dba2d..a08856b121b3 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1898,31 +1898,44 @@ static int null_gendisk_register(struct nullb
> *nullb)
>=20
>  static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set
> *set)
>  {
> +	unsigned int flags =3D BLK_MQ_F_SHOULD_MERGE;
> +	int hw_queues, numa_node;
> +	unsigned int queue_depth;
>  	int poll_queues;
>=20
> +	if (nullb) {
> +		hw_queues =3D nullb->dev->submit_queues;
> +		poll_queues =3D nullb->dev->poll_queues;
> +		queue_depth =3D nullb->dev->hw_queue_depth;
> +		numa_node =3D nullb->dev->home_node;
> +		if (nullb->dev->no_sched)
> +			flags |=3D BLK_MQ_F_NO_SCHED;
> +		if (nullb->dev->shared_tag_bitmap)
> +			flags |=3D BLK_MQ_F_TAG_HCTX_SHARED;
> +		if (nullb->dev->blocking)
> +			flags |=3D BLK_MQ_F_BLOCKING;
> +	} else {
> +		hw_queues =3D g_submit_queues;
> +		poll_queues =3D g_poll_queues;
> +		queue_depth =3D g_hw_queue_depth;
> +		numa_node =3D g_home_node;
> +		if (g_blocking)
> +			flags |=3D BLK_MQ_F_BLOCKING;
> +	}
> +

Ming, thank you for fixing the mess I created.

I believe that even when 'nullb' is NULL we should still set the
BLK_MQ_F_NO_SCHED and BLK_MQ_F_TAG_HCTX_SHARED flags based on the values of
g_no_sched and g_shared_tag_bitmap, respectively. Is that not right?

Vincent
