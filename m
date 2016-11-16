Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34712 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbcKPQr0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 11:47:26 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so13008138wme.1
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2016 08:47:25 -0800 (PST)
Subject: Re: [PATCH 5/5] nvmet: add support for the Write Zeroes command
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@fb.com
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-6-git-send-email-chaitanya.kulkarni@hgst.com>
Cc: martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6591bf30-6f66-c4e6-e304-9b580489a9b9@grimberg.me>
Date: Wed, 16 Nov 2016 18:47:22 +0200
MIME-Version: 1.0
In-Reply-To: <1479279039-25818-6-git-send-email-chaitanya.kulkarni@hgst.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> +static void nvmet_execute_write_zeroes(struct nvmet_req *req)
> +{
> +	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
> +	struct bio *bio = NULL;
> +	u16 status = NVME_SC_SUCCESS;
> +	sector_t sector;
> +	sector_t nr_sector;
> +
> +	sector = le64_to_cpu(write_zeroes->slba) <<
> +		(req->ns->blksize_shift - 9);
> +	nr_sector = (((sector_t)le32_to_cpu(write_zeroes->length)) <<
> +		(req->ns->blksize_shift - 9)) + 1;
> +
> +	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
> +				GFP_KERNEL, &bio, false))
> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> +
> +	if (bio) {
> +		bio->bi_private = req;
> +		bio->bi_end_io = nvmet_bio_done;
> +		if (status) {

if (status != NVME_SC_SUCCESS) can this happen?
can we end up with a bio if __blkdev_issue_zeroout
failed?

> +			bio->bi_error = -EIO;
> +			bio_endio(bio);

Something looks odd here, how does the status propagate in
this case?
