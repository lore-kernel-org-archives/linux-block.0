Return-Path: <Avri.Altman@sandisk.com>
From: Avri Altman <Avri.Altman@sandisk.com>
To: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian
 Hunter <adrian.hunter@intel.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann
	<arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo
 Valente <paolo.valente@linaro.org>
Subject: RE: [PATCH 5/5] mmc: block: move multi-ioctl() to use block layer
Date: Fri, 12 May 2017 21:09:22 +0000
Message-ID: <BY2PR0401MB09019584ED8645C66540EA5CE5E20@BY2PR0401MB0901.namprd04.prod.outlook.com>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <20170510082418.10513-6-linus.walleij@linaro.org>
In-Reply-To: <20170510082418.10513-6-linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Linus Walleij
> Sent: Wednesday, May 10, 2017 11:24 AM
> To: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>;
> Adrian Hunter <adrian.hunter@intel.com>
> Cc: linux-block@vger.kernel.org; Jens Axboe <axboe@kernel.dk>; Christoph
> Hellwig <hch@lst.de>; Arnd Bergmann <arnd@arndb.de>; Bartlomiej
> Zolnierkiewicz <b.zolnierkie@samsung.com>; Paolo Valente
> <paolo.valente@linaro.org>; Linus Walleij <linus.walleij@linaro.org>
> Subject: [PATCH 5/5] mmc: block: move multi-ioctl() to use block layer
>=20
> This switches also the multiple-command ioctl() call to issue all ioctl()=
s
> through the block layer instead of going directly to the device.
>=20
> We extend the passed argument with an argument count and loop over all
> passed commands in the ioctl() issue function called from the block layer=
.
>=20
> By doing this we are again loosening the grip on the big host lock, since=
 two
> calls to mmc_get_card()/mmc_put_card() are removed.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/block.c | 38 +++++++++++++++++++++++++-------------
>  drivers/mmc/core/queue.h |  3 ++-
>  2 files changed, 27 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 640db4f57a31..152de904d5e4 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -563,6 +563,7 @@ static int mmc_blk_ioctl_cmd(struct block_device
> *bdev,
>  			     struct mmc_ioc_cmd __user *ic_ptr)  {
>  	struct mmc_blk_ioc_data *idata;
> +	struct mmc_blk_ioc_data *idatas[1];
>  	struct mmc_blk_data *md;
>  	struct mmc_queue *mq;
>  	struct mmc_card *card;
> @@ -600,7 +601,9 @@ static int mmc_blk_ioctl_cmd(struct block_device
> *bdev,
>  	req =3D blk_get_request(mq->queue,
>  		idata->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
>  		__GFP_RECLAIM);
> -	req_to_mq_rq(req)->idata =3D idata;
> +	idatas[0] =3D idata;
> +	req_to_mq_rq(req)->idata =3D idatas;
> +	req_to_mq_rq(req)->ioc_count =3D 1;
>  	blk_execute_rq(mq->queue, NULL, req, 0);
>  	ioc_err =3D req_to_mq_rq(req)->ioc_result;
>  	err =3D mmc_blk_ioctl_copy_to_user(ic_ptr, idata); @@ -622,14 +625,17
> @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,  static void
> mmc_blk_ioctl_cmd_issue(struct mmc_queue *mq, struct request *req)  {
>  	struct mmc_queue_req *mq_rq;
> -	struct mmc_blk_ioc_data *idata;
>  	struct mmc_card *card =3D mq->card;
>  	struct mmc_blk_data *md =3D mq->blkdata;
>  	int ioc_err;
> +	int i;
>=20
>  	mq_rq =3D req_to_mq_rq(req);
> -	idata =3D mq_rq->idata;
> -	ioc_err =3D __mmc_blk_ioctl_cmd(card, md, idata);
> +	for (i =3D 0; i < mq_rq->ioc_count; i++) {
> +		ioc_err =3D __mmc_blk_ioctl_cmd(card, md, mq_rq->idata[i]);
> +		if (ioc_err)
> +			break;
> +	}
>  	mq_rq->ioc_result =3D ioc_err;
>=20
>  	/* Always switch back to main area after RPMB access */ @@ -646,8
> +652,10 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>  	struct mmc_ioc_cmd __user *cmds =3D user->cmds;
>  	struct mmc_card *card;
>  	struct mmc_blk_data *md;
> +	struct mmc_queue *mq;
>  	int i, err =3D 0, ioc_err =3D 0;
>  	__u64 num_of_cmds;
> +	struct request *req;
>=20
>  	/*
>  	 * The caller must have CAP_SYS_RAWIO, and must be calling this on
> the @@ -689,21 +697,25 @@ static int mmc_blk_ioctl_multi_cmd(struct
> block_device *bdev,
>  		goto cmd_done;
>  	}
>=20
> -	mmc_get_card(card);
> -
> -	for (i =3D 0; i < num_of_cmds && !ioc_err; i++)
> -		ioc_err =3D __mmc_blk_ioctl_cmd(card, md, idata[i]);
> -
> -	/* Always switch back to main area after RPMB access */
> -	if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
> -		mmc_blk_part_switch(card, dev_get_drvdata(&card->dev));
>=20
> -	mmc_put_card(card);
> +	/*
> +	 * Dispatch the ioctl()s into the block request queue.
> +	 */
> +	mq =3D &md->queue;
> +	req =3D blk_get_request(mq->queue,
> +		idata[0]->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
> +		__GFP_RECLAIM);
It is possible, e.g. as in RPMB access, that some commands are read and som=
e are write.
Not sure that it makes any difference, because once it get back to mmc_blk_=
ioctl_cmd_issue(),
The correct mmc requests will be issued anyway?

> +	req_to_mq_rq(req)->idata =3D idata;
> +	req_to_mq_rq(req)->ioc_count =3D num_of_cmds;
> +	blk_execute_rq(mq->queue, NULL, req, 0);
> +	ioc_err =3D req_to_mq_rq(req)->ioc_result;
>=20
>  	/* copy to user if data and response */
>  	for (i =3D 0; i < num_of_cmds && !err; i++)
>  		err =3D mmc_blk_ioctl_copy_to_user(&cmds[i], idata[i]);
>=20
> +	blk_put_request(req);
> +
>  cmd_done:
>  	mmc_blk_put(md);
>  cmd_err:
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h index
> aeb3408dc85e..7015df6681c3 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -42,7 +42,8 @@ struct mmc_queue_req {
>  	unsigned int		bounce_sg_len;
>  	struct mmc_async_req	areq;
>  	int			ioc_result;
> -	struct mmc_blk_ioc_data	*idata;
> +	struct mmc_blk_ioc_data	**idata;
> +	unsigned int		ioc_count;
>  };
>=20
>  struct mmc_queue {
> --
> 2.9.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in t=
he
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
