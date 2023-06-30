Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605CDEB64D7
	for <linux-block@archiver.kernel.org>; Fri, 30 Jun 2023 16:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjF3Qem (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 12:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjF3Qek (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 12:34:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CA2707
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 09:34:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6a675743dso32174641fa.2
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2023 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688142877; x=1690734877;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnQibpmgJisTPwk0C1Ksa+yBQknxXVIpxNazF/UTqJs=;
        b=VYCJyYXe6JKycaBiL6GOSMgFUv83n4v2c4jiHHCJAQBzAbnKJ89C0T8xuym+2Z9UjZ
         jEaYefqpyqvuV3iO6q+W06ddjudNyVto+JIKwYrrGZSJdQ5koFBoOQvgv1O7HlHzIzAR
         gxhXZY4+AcEVs7W1JSheGdB8dByiDIVMVVcezvCEK8m5sYE5jnMhnay1rsLX0elZ7e0m
         ud2ZbKlcVcUYQJMXI6bYuQmvAKIltzI0mmUFUxUONgOltL6uio8uPBXtejrll9u8d+/n
         Xtf64C3yYGlEJCMYtUd6gm2yl8qQD04Y1gTzIXQ5UyohEWcYNZ5aSguSmAb7GEvXolzp
         IfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688142877; x=1690734877;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JnQibpmgJisTPwk0C1Ksa+yBQknxXVIpxNazF/UTqJs=;
        b=LvlW6p0NmZtuXimJ0Oez4zxLEAJGyfSaN+qthL8N+fhrX3jrHvyUSGSKDYso2lLkE+
         D6+i+pqC5OzPImp2Bj86QmpJ8bBfRc4Giq/AzbTMMpANiinZtm1HVX57+J2M1j0R/1It
         heN8Lmz/8jX8cKWGVS5sLZxFXydnATNAJW3lPqGQlEexTHKpVVuKTa6f1xtX2pdwsk9J
         IOmXceQqHCX/8OujbYgZ38FbIgMNJYCFs6SctMcW7xh8qwGBlQCyFPliCCU7006Gl5bh
         J3u2r9zOndmjOShwp9sk6dq54K/3QopXOfPZ2BJiLCzJw6I0US8H/EwDNPPLwSk7SkWC
         a+NA==
X-Gm-Message-State: ABy/qLauccuJUs4TQ8nRzt9NWFpTW26uRaFIl9tJFAP2JnJ1UsD47usl
        psOb+SqBRGjepqRNH3Enzj/A+Q==
X-Google-Smtp-Source: APBJJlFqg5EJqDrZtWjhFwq9PZBMnrUBat1YbZIfh3wtCg51bSE8Mr8c8vy+uhlCPFms4ysYn6snEw==
X-Received: by 2002:a2e:8786:0:b0:2b6:9a49:49f with SMTP id n6-20020a2e8786000000b002b69a49049fmr3086413lji.2.1688142876526;
        Fri, 30 Jun 2023 09:34:36 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id qc5-20020a170906d8a500b00992076f4a01sm4720106ejb.190.2023.06.30.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:34:36 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-5-nmi@metaspace.dk>
 <39701CAF-7AE2-4C83-A4DD-929A0A4FB8F0@wdc.com>
 <76a4ad50bb79acfe89e7d5d3a354d061@opensource.wdc.com>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     aravind.ramesh@opensource.wdc.com
Cc:     Hans.Holmberg@wdc.com, Aravind.Ramesh@wdc.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@infradead.org,
        Matias.Bjorling@wdc.com, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, gost.dev@samsung.com, minwoo.im.dev@gmail.com,
        ming.lei@redhat.com
Subject: Re: [PATCH v4 4/4] ublk: add zone append
Date:   Fri, 30 Jun 2023 18:33:40 +0200
In-reply-to: <76a4ad50bb79acfe89e7d5d3a354d061@opensource.wdc.com>
Message-ID: <873528ewo5.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


aravind.ramesh@opensource.wdc.com writes:

>> From: Andreas Hindborg <a.hindborg@samsung.com
>> <mailto:a.hindborg@samsung.com>>
>> Add zone append feature to ublk. This feature uses the `addr` field of `=
struct
>
> checkpatch.pl warns on the keeping the line within 75 characters.
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars=
 per
> line)

Thanks, I will make sure to rerun the checker. I thought I ran it
already =F0=9F=98=AC

BR Andreas

>
>> ublksrv_io_cmd`. Therefore ublk must be used with the user copy
>> feature (UBLK_F_USER_COPY) for zone append to be available. Without this
>> feature, ublk will fail zone append requests.
>> Suggested-by: Ming Lei <ming.lei@redhat.com <mailto:ming.lei@redhat.com>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com
>> <mailto:a.hindborg@samsung.com>>
>> ---
>> drivers/block/ublk_drv-zoned.c | 11 +++++++++
>> drivers/block/ublk_drv.c | 43 ++++++++++++++++++++++++++++++----
>> drivers/block/ublk_drv.h | 1 +
>> include/uapi/linux/ublk_cmd.h | 3 ++-
>> 4 files changed, 52 insertions(+), 6 deletions(-)
>> diff --git a/drivers/block/ublk_drv-zoned.c b/drivers/block/ublk_drv-zon=
ed.c
>> index ea86bf4b3681..007e8fc7ff25 100644
>> --- a/drivers/block/ublk_drv-zoned.c
>> +++ b/drivers/block/ublk_drv-zoned.c
>> @@ -16,6 +16,16 @@ void ublk_set_nr_zones(struct ublk_device *ub)
>> ub->ub_disk->nr_zones =3D p->dev_sectors / p->chunk_sectors;
>> }
>> +int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
>> +{
>> + const struct ublk_param_zoned *p =3D &ub->params.zoned;
>> +
>> + if (! p->max_zone_append_sectors)
>
> checkpatch.pl errors out here
> ERROR: space prohibited after that '!' (ctx:BxW)
> if (!p->max_zone_append_sectors)
>
>> + return -EINVAL;
>> +
>> + return 0;
>> +}
>> +
>> void ublk_dev_param_zoned_apply(struct ublk_device *ub)
>> {
>> const struct ublk_param_zoned *p =3D &ub->params.zoned;
>> @@ -23,6 +33,7 @@ void ublk_dev_param_zoned_apply(struct ublk_device *ub)
>> if (ub->dev_info.flags & UBLK_F_ZONED) {
>> disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
>> disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
>> + blk_queue_max_zone_append_sectors(ub->ub_disk->queue,
>> p->max_zone_append_sectors);
>> }
>> }
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 88fa39853c61..6a949669b47e 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -107,6 +107,11 @@ struct ublk_uring_cmd_pdu {
>> */
>> #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
>> +/*
>> + * Set when IO is Zone Append
>> + */
>> +#define UBLK_IO_FLAG_ZONE_APPEND 0x10
>> +
>> struct ublk_io {
>> /* userspace buffer address from io cmd */
>> __u64 addr;
>> @@ -230,6 +235,8 @@ static void ublk_dev_param_discard_apply(struct
>> ublk_device *ub)
>> static int ublk_validate_params(const struct ublk_device *ub)
>> {
>> + int ret =3D 0;
>> +
>> /* basic param is the only one which must be set */
>> if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
>> const struct ublk_param_basic *p =3D &ub->params.basic;
>> @@ -260,6 +267,13 @@ static int ublk_validate_params(const struct
>> ublk_device *ub)
>> if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
>> return -EINVAL;
>> + if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>> + (ub->params.types & UBLK_PARAM_TYPE_ZONED)) {
>> + ret =3D ublk_dev_param_zoned_validate(ub);
>> + if (ret)
>> + return ret;
>> + }
>> +
>> return 0;
>> }
>> @@ -690,6 +704,11 @@ static blk_status_t ublk_setup_iod(struct
>> ublk_queue *ubq, struct request *req)
>> return BLK_STS_IOERR;
>> }
>> case REQ_OP_ZONE_APPEND:
>> + if (!(ubq->dev->dev_info.flags & UBLK_F_USER_COPY))
>> + return BLK_STS_IOERR;
>> + ublk_op =3D UBLK_IO_OP_ZONE_APPEND;
>> + io->flags |=3D UBLK_IO_FLAG_ZONE_APPEND;
>> + break;
>> case REQ_OP_ZONE_RESET_ALL:
>> case REQ_OP_DRV_OUT:
>> /* We do not support zone append or reset_all yet */
>> @@ -1112,6 +1131,12 @@ static void ublk_commit_completion(struct
>> ublk_device *ub,
>> /* find the io request and complete */
>> req =3D blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
>> + if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
>> + if (io->flags & UBLK_IO_FLAG_ZONE_APPEND)
>> + req->__sector =3D ub_cmd->addr;
>> + io->flags &=3D ~UBLK_IO_FLAG_ZONE_APPEND;
>> + }
>> +
>> if (req && likely(!blk_should_fake_timeout(req->q)))
>> ublk_put_req_ref(ubq, req);
>> }
>> @@ -1411,7 +1436,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd,
>> ^ (_IOC_NR(cmd_op) =3D=3D UBLK_IO_NEED_GET_DATA))
>> goto out;
>> - if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
>> + if (ublk_support_user_copy(ubq) &&
>> + !(io->flags & UBLK_IO_FLAG_ZONE_APPEND) && ub_cmd->addr) {
>> ret =3D -EINVAL;
>> goto out;
>> }
>> @@ -1534,11 +1560,14 @@ static inline bool ublk_check_ubuf_dir(const
>> struct request *req,
>> int ubuf_dir)
>> {
>> /* copy ubuf to request pages */
>> - if (req_op(req) =3D=3D REQ_OP_READ && ubuf_dir =3D=3D ITER_SOURCE)
>> + if ((req_op(req) =3D=3D REQ_OP_READ || req_op(req) =3D=3D REQ_OP_DRV_I=
N) &&
>> + ubuf_dir =3D=3D ITER_SOURCE)
>> return true;
>> /* copy request pages to ubuf */
>> - if (req_op(req) =3D=3D REQ_OP_WRITE && ubuf_dir =3D=3D ITER_DEST)
>> + if ((req_op(req) =3D=3D REQ_OP_WRITE ||
>> + req_op(req) =3D=3D REQ_OP_ZONE_APPEND) &&
>> + ubuf_dir =3D=3D ITER_DEST)
>> return true;
>> return false;
>> @@ -1867,6 +1896,12 @@ static int ublk_ctrl_start_dev(struct
>> ublk_device *ub, struct io_uring_cmd *cmd)
>> ub->dev_info.ublksrv_pid =3D ublksrv_pid;
>> ub->ub_disk =3D disk;
>> + ub->dev_info.state =3D UBLK_S_DEV_LIVE;
>> + if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>> + ub->dev_info.flags & UBLK_F_ZONED) {
>> + disk_set_zoned(disk, BLK_ZONED_HM);
>> + }
>> +
>> ret =3D ublk_apply_params(ub);
>> if (ret)
>> goto out_put_disk;
>> @@ -1877,7 +1912,6 @@ static int ublk_ctrl_start_dev(struct
>> ublk_device *ub, struct io_uring_cmd *cmd)
>> if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>> ub->dev_info.flags & UBLK_F_ZONED) {
>> - disk_set_zoned(disk, BLK_ZONED_HM);
>> blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_WRI=
TE);
>> ret =3D ublk_revalidate_disk_zones(disk);
>> if (ret)
>> @@ -1885,7 +1919,6 @@ static int ublk_ctrl_start_dev(struct
>> ublk_device *ub, struct io_uring_cmd *cmd)
>> }
>> get_device(&ub->cdev_dev);
>> - ub->dev_info.state =3D UBLK_S_DEV_LIVE;
>> ret =3D add_disk(disk);
>> if (ret) {
>> /*
>> diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
>> index 7242430fd6b9..f55e1c25531d 100644
>> --- a/drivers/block/ublk_drv.h
>> +++ b/drivers/block/ublk_drv.h
>> @@ -56,6 +56,7 @@ struct ublk_rq_data {
>> };
>> void ublk_set_nr_zones(struct ublk_device *ub);
>> +int ublk_dev_param_zoned_validate(const struct ublk_device *ub);
>> void ublk_dev_param_zoned_apply(struct ublk_device *ub);
>> int ublk_revalidate_disk_zones(struct gendisk *disk);
>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd=
.h
>> index 436525afffe8..4b6ad0b28598 100644
>> --- a/include/uapi/linux/ublk_cmd.h
>> +++ b/include/uapi/linux/ublk_cmd.h
>> @@ -351,7 +351,8 @@ struct ublk_param_devt {
>> struct ublk_param_zoned {
>> __u32 max_open_zones;
>> __u32 max_active_zones;
>> - __u8 reserved[24];
>> + __u32 max_zone_append_sectors;
>> + __u8 reserved[20];
>> };
>> struct ublk_params {
>
> Regards,
> Aravind

