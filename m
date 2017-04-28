Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35008 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030303AbdD1SKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 14:10:25 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 4/4] blk-mq: dump new introduced flag of
 BLK_MQ_F_SCHED_USE_HW_TAG
Date: Fri, 28 Apr 2017 18:10:22 +0000
Message-ID: <1493403021.2767.11.camel@sandisk.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
         <20170428151539.25514-5-ming.lei@redhat.com>
In-Reply-To: <20170428151539.25514-5-ming.lei@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-04-28 at 23:15 +0800, Ming Lei wrote:
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index bcd2a7d4a3a5..bc390847a60d 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -220,6 +220,7 @@ static const char *const hctx_flag_name[] =3D {
>  	[ilog2(BLK_MQ_F_SG_MERGE)]	=3D "SG_MERGE",
>  	[ilog2(BLK_MQ_F_BLOCKING)]	=3D "BLOCKING",
>  	[ilog2(BLK_MQ_F_NO_SCHED)]	=3D "NO_SCHED",
> +	[ilog2(BLK_MQ_F_SCHED_USE_HW_TAG)]	=3D "SCHED_USE_HW_TAG",
>  };
> =20
>  static int hctx_flags_show(struct seq_file *m, void *v)

Hello Ming,

Please combine patches 1/4 and 4/4.

Thanks,

Bart.=
