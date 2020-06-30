Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87035C433DF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559DD206B6
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 16:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yBXzpOLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgF3QhW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:37:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbgF3QhV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 12:37:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UGMquH118503;
        Tue, 30 Jun 2020 16:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=sZa1DpsT46cm95nMgqnXBq5wJ5uraMKxgQz6oQz4Xjk=;
 b=yBXzpOLB4ZT6AFZwsmYTMTYjl3pVmymT6/P18wcAp4hPrJ3hkTOXRG7K2ZrjL8l810B4
 qZnXYbS0tcOTrZNxa0LgzqkIl5wzCXjwjZh8sbjyjKDgQmvpe6Noly7kB+qIhRz71Ojz
 3tCfQwQQ9c4OhVu5F3039DH7S0pdz6aSPIm3iGlXrTjIpp5/mmg0docFkslb3r7JE1ir
 WmgNq3PQjsGvb7nZvnH51XsKp2YRMZYH3MoE1K4nVlbD/wXOvmZxQjIDw01iEb+geKGK
 zlWw1IcT8RrpoJaACtcMJ2j6T/ZKelIudTHXlx1gdvNjaIazwKg5ABLFcCnrG0/cCMAP eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31xx1dtgwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 16:36:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UGMqHm098206;
        Tue, 30 Jun 2020 16:36:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31y52j5k8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 16:36:53 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05UGanlB027142;
        Tue, 30 Jun 2020 16:36:51 GMT
Received: from dhcp-10-154-182-99.vpn.oracle.com (/10.154.182.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 16:36:49 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCHv4 5/5] nvme: support for zoned namespaces
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200629190641.1986462-6-kbusch@kernel.org>
Date:   Tue, 30 Jun 2020 11:36:47 -0500
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Keith Busch <keith.busch@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <23A2AC59-EC86-4C57-87B7-DD7F748486DC@oracle.com>
References: <20200629190641.1986462-1-kbusch@kernel.org>
 <20200629190641.1986462-6-kbusch@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=13 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=13 mlxlogscore=999 cotscore=-2147483648 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300116
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jun 29, 2020, at 2:06 PM, Keith Busch <kbusch@kernel.org> wrote:
>=20
> From: Keith Busch <keith.busch@wdc.com>
>=20
> Add support for NVM Express Zoned Namespaces (ZNS) Command Set defined
> in NVM Express TP4053. Zoned namespaces are discovered based on their
> Command Set Identifier reported in the namespaces Namespace
> Identification Descriptor list. A successfully discovered Zoned
> Namespace will be registered with the block layer as a host managed
> zoned block device with Zone Append command support. A namespace that
> does not support append is not supported by the driver.
>=20
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Javier Gonz=C3=A1lez <javier.gonz@samsung.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Keith Busch <keith.busch@wdc.com>
> ---
> block/Kconfig              |   5 +-
> drivers/nvme/host/Makefile |   1 +
> drivers/nvme/host/core.c   |  97 ++++++++++++--
> drivers/nvme/host/nvme.h   |  39 ++++++
> drivers/nvme/host/zns.c    | 253 +++++++++++++++++++++++++++++++++++++
> include/linux/nvme.h       | 111 ++++++++++++++++
> 6 files changed, 491 insertions(+), 15 deletions(-)
> create mode 100644 drivers/nvme/host/zns.c
>=20
> diff --git a/block/Kconfig b/block/Kconfig
> index 9357d7302398..bbad5e8bbffe 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -86,9 +86,10 @@ config BLK_DEV_ZONED
> 	select MQ_IOSCHED_DEADLINE
> 	help
> 	Block layer zoned block device support. This option enables
> -	support for ZAC/ZBC host-managed and host-aware zoned block =
devices.
> +	support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
> +	devices.
>=20
> -	Say yes here if you have a ZAC or ZBC storage device.
> +	Say yes here if you have a ZAC, ZBC, or ZNS storage device.
>=20
> config BLK_DEV_THROTTLING
> 	bool "Block layer bio throttling support"
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index fc7b26be692d..d7f6a87687b8 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -13,6 +13,7 @@ nvme-core-y				:=3D core.o
> nvme-core-$(CONFIG_TRACING)		+=3D trace.o
> nvme-core-$(CONFIG_NVME_MULTIPATH)	+=3D multipath.o
> nvme-core-$(CONFIG_NVM)			+=3D lightnvm.o
> +nvme-core-$(CONFIG_BLK_DEV_ZONED)	+=3D zns.o
> nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+=3D fault_inject.o
> nvme-core-$(CONFIG_NVME_HWMON)		+=3D hwmon.o
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a4a61d7e793d..02b4273a0b10 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -89,7 +89,7 @@ static dev_t nvme_chr_devt;
> static struct class *nvme_class;
> static struct class *nvme_subsys_class;
>=20
> -static int nvme_revalidate_disk(struct gendisk *disk);
> +static int _nvme_revalidate_disk(struct gendisk *disk);
> static void nvme_put_subsystem(struct nvme_subsystem *subsys);
> static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> 					   unsigned nsid);
> @@ -287,6 +287,10 @@ void nvme_complete_rq(struct request *req)
> 			nvme_retry_req(req);
> 			return;
> 		}
> +	} else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +		   req_op(req) =3D=3D REQ_OP_ZONE_APPEND) {
> +		req->__sector =3D nvme_lba_to_sect(req->q->queuedata,
> +			le64_to_cpu(nvme_req(req)->result.u64));
> 	}
>=20
> 	nvme_trace_bio_complete(req, status);
> @@ -673,7 +677,8 @@ static inline blk_status_t =
nvme_setup_write_zeroes(struct nvme_ns *ns,
> }
>=20
> static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
> -		struct request *req, struct nvme_command *cmnd)
> +		struct request *req, struct nvme_command *cmnd,
> +		enum nvme_opcode op)
> {
> 	struct nvme_ctrl *ctrl =3D ns->ctrl;
> 	u16 control =3D 0;
> @@ -687,7 +692,7 @@ static inline blk_status_t nvme_setup_rw(struct =
nvme_ns *ns,
> 	if (req->cmd_flags & REQ_RAHEAD)
> 		dsmgmt |=3D NVME_RW_DSM_FREQ_PREFETCH;
>=20
> -	cmnd->rw.opcode =3D (rq_data_dir(req) ? nvme_cmd_write : =
nvme_cmd_read);
> +	cmnd->rw.opcode =3D op;
> 	cmnd->rw.nsid =3D cpu_to_le32(ns->head->ns_id);
> 	cmnd->rw.slba =3D cpu_to_le64(nvme_sect_to_lba(ns, =
blk_rq_pos(req)));
> 	cmnd->rw.length =3D cpu_to_le16((blk_rq_bytes(req) >> =
ns->lba_shift) - 1);
> @@ -716,6 +721,8 @@ static inline blk_status_t nvme_setup_rw(struct =
nvme_ns *ns,
> 		case NVME_NS_DPS_PI_TYPE2:
> 			control |=3D NVME_RW_PRINFO_PRCHK_GUARD |
> 					NVME_RW_PRINFO_PRCHK_REF;
> +			if (op =3D=3D nvme_cmd_zone_append)
> +				control |=3D NVME_RW_APPEND_PIREMAP;
> 			cmnd->rw.reftag =3D =
cpu_to_le32(t10_pi_ref_tag(req));
> 			break;
> 		}
> @@ -756,6 +763,19 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, =
struct request *req,
> 	case REQ_OP_FLUSH:
> 		nvme_setup_flush(ns, cmd);
> 		break;
> +	case REQ_OP_ZONE_RESET_ALL:
> +	case REQ_OP_ZONE_RESET:
> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, =
NVME_ZONE_RESET);
> +		break;
> +	case REQ_OP_ZONE_OPEN:
> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, =
NVME_ZONE_OPEN);
> +		break;
> +	case REQ_OP_ZONE_CLOSE:
> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, =
NVME_ZONE_CLOSE);
> +		break;
> +	case REQ_OP_ZONE_FINISH:
> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, =
NVME_ZONE_FINISH);
> +		break;
> 	case REQ_OP_WRITE_ZEROES:
> 		ret =3D nvme_setup_write_zeroes(ns, req, cmd);
> 		break;
> @@ -763,8 +783,13 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, =
struct request *req,
> 		ret =3D nvme_setup_discard(ns, req, cmd);
> 		break;
> 	case REQ_OP_READ:
> +		ret =3D nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
> +		break;
> 	case REQ_OP_WRITE:
> -		ret =3D nvme_setup_rw(ns, req, cmd);
> +		ret =3D nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
> +		break;
> +	case REQ_OP_ZONE_APPEND:
> +		ret =3D nvme_setup_rw(ns, req, cmd, =
nvme_cmd_zone_append);
> 		break;
> 	default:
> 		WARN_ON_ONCE(1);
> @@ -1398,14 +1423,23 @@ static u32 nvme_passthru_start(struct =
nvme_ctrl *ctrl, struct nvme_ns *ns,
> 	return effects;
> }
>=20
> -static void nvme_update_formats(struct nvme_ctrl *ctrl)
> +static void nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects)
> {
> 	struct nvme_ns *ns;
>=20
> 	down_read(&ctrl->namespaces_rwsem);
> 	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		if (ns->disk && nvme_revalidate_disk(ns->disk))
> +		if (ns->disk && _nvme_revalidate_disk(ns->disk))
> 			nvme_set_queue_dying(ns);
> +		else if (blk_queue_is_zoned(ns->disk->queue)) {
> +			/*
> +			 * IO commands are required to fully revalidate =
a zoned
> +			 * device. Force the command effects to trigger =
rescan
> +			 * work so report zones can run in a context =
with
> +			 * unfrozen IO queues.
> +			 */
> +			*effects |=3D NVME_CMD_EFFECTS_NCC;
> +		}
> 	up_read(&ctrl->namespaces_rwsem);
> }
>=20
> @@ -1417,7 +1451,7 @@ static void nvme_passthru_end(struct nvme_ctrl =
*ctrl, u32 effects)
> 	 * this command.
> 	 */
> 	if (effects & NVME_CMD_EFFECTS_LBCC)
> -		nvme_update_formats(ctrl);
> +		nvme_update_formats(ctrl, &effects);
> 	if (effects & (NVME_CMD_EFFECTS_LBCC | =
NVME_CMD_EFFECTS_CSE_MASK)) {
> 		nvme_unfreeze(ctrl);
> 		nvme_mpath_unfreeze(ctrl->subsys);
> @@ -1532,7 +1566,7 @@ static int nvme_user_cmd64(struct nvme_ctrl =
*ctrl, struct nvme_ns *ns,
>  * Issue ioctl requests on the first available path.  Note that unlike =
normal
>  * block layer requests we will not retry failed request on another =
controller.
>  */
> -static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
> +struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
> 		struct nvme_ns_head **head, int *srcu_idx)
> {
> #ifdef CONFIG_NVME_MULTIPATH
> @@ -1552,7 +1586,7 @@ static struct nvme_ns =
*nvme_get_ns_from_disk(struct gendisk *disk,
> 	return disk->private_data;
> }
>=20
> -static void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)
> +void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)
> {
> 	if (head)
> 		srcu_read_unlock(&head->srcu, idx);
> @@ -1945,23 +1979,34 @@ static void nvme_update_disk_info(struct =
gendisk *disk,
>=20
> static int __nvme_revalidate_disk(struct gendisk *disk, struct =
nvme_id_ns *id)
> {
> +	unsigned lbaf =3D id->flbas & NVME_NS_FLBAS_LBA_MASK;
> 	struct nvme_ns *ns =3D disk->private_data;
> 	struct nvme_ctrl *ctrl =3D ns->ctrl;
> +	int ret;
> 	u32 iob;
>=20
> 	/*
> 	 * If identify namespace failed, use default 512 byte block size =
so
> 	 * block layer can use before failing read/write for 0 capacity.
> 	 */
> -	ns->lba_shift =3D id->lbaf[id->flbas & =
NVME_NS_FLBAS_LBA_MASK].ds;
> +	ns->lba_shift =3D id->lbaf[lbaf].ds;
> 	if (ns->lba_shift =3D=3D 0)
> 		ns->lba_shift =3D 9;
>=20
> 	switch (ns->head->ids.csi) {
> 	case NVME_CSI_NVM:
> 		break;
> +	case NVME_CSI_ZNS:
> +		ret =3D nvme_update_zone_info(disk, ns, lbaf);
> +		if (ret) {
> +			dev_warn(ctrl->device,
> +				"failed to add zoned namespace:%u =
ret:%d\n",
> +				ns->head->ns_id, ret);
> +			return ret;
> +		}
> +		break;
> 	default:
> -		dev_warn(ctrl->device, "unknown csi:%d ns:%d\n",
> +		dev_warn(ctrl->device, "unknown csi:%u ns:%u\n",
> 			ns->head->ids.csi, ns->head->ns_id);
> 		return -ENODEV;
> 	}
> @@ -1973,7 +2018,7 @@ static int __nvme_revalidate_disk(struct gendisk =
*disk, struct nvme_id_ns *id)
> 		iob =3D nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));
>=20
> 	ns->features =3D 0;
> -	ns->ms =3D le16_to_cpu(id->lbaf[id->flbas & =
NVME_NS_FLBAS_LBA_MASK].ms);
> +	ns->ms =3D le16_to_cpu(id->lbaf[lbaf].ms);
> 	/* the PI implementation requires metadata equal t10 pi tuple =
size */
> 	if (ns->ms =3D=3D sizeof(struct t10_pi_tuple))
> 		ns->pi_type =3D id->dps & NVME_NS_DPS_PI_MASK;
> @@ -2015,7 +2060,7 @@ static int __nvme_revalidate_disk(struct gendisk =
*disk, struct nvme_id_ns *id)
> 	return 0;
> }
>=20
> -static int nvme_revalidate_disk(struct gendisk *disk)
> +static int _nvme_revalidate_disk(struct gendisk *disk)
> {
> 	struct nvme_ns *ns =3D disk->private_data;
> 	struct nvme_ctrl *ctrl =3D ns->ctrl;
> @@ -2063,6 +2108,28 @@ static int nvme_revalidate_disk(struct gendisk =
*disk)
> 	return ret;
> }
>=20
> +static int nvme_revalidate_disk(struct gendisk *disk)
> +{
> +	int ret;
> +
> +	ret =3D _nvme_revalidate_disk(disk);
> +	if (ret)
> +		return ret;
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (blk_queue_is_zoned(disk->queue)) {
> +		struct nvme_ns *ns =3D disk->private_data;
> +		struct nvme_ctrl *ctrl =3D ns->ctrl;
> +
> +		ret =3D blk_revalidate_disk_zones(disk, NULL);
> +		if (!ret)
> +			blk_queue_max_zone_append_sectors(disk->queue,
> +							  =
ctrl->max_zone_append);
> +	}
> +#endif
> +	return ret;
> +}
> +
> static char nvme_pr_type(enum pr_type type)
> {
> 	switch (type) {
> @@ -2193,6 +2260,7 @@ static const struct block_device_operations =
nvme_fops =3D {
> 	.release	=3D nvme_release,
> 	.getgeo		=3D nvme_getgeo,
> 	.revalidate_disk=3D nvme_revalidate_disk,
> +	.report_zones	=3D nvme_report_zones,
> 	.pr_ops		=3D &nvme_pr_ops,
> };
>=20
> @@ -2218,6 +2286,7 @@ const struct block_device_operations =
nvme_ns_head_ops =3D {
> 	.ioctl		=3D nvme_ioctl,
> 	.compat_ioctl	=3D nvme_compat_ioctl,
> 	.getgeo		=3D nvme_getgeo,
> +	.report_zones	=3D nvme_report_zones,
> 	.pr_ops		=3D &nvme_pr_ops,
> };
> #endif /* CONFIG_NVME_MULTIPATH */
> @@ -4445,6 +4514,8 @@ static inline void _nvme_check_size(void)
> 	BUILD_BUG_ON(sizeof(struct nvme_command) !=3D 64);
> 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) !=3D =
NVME_IDENTIFY_DATA_SIZE);
> 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) !=3D =
NVME_IDENTIFY_DATA_SIZE);
> +	BUILD_BUG_ON(sizeof(struct nvme_id_ns_zns) !=3D =
NVME_IDENTIFY_DATA_SIZE);
> +	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_zns) !=3D =
NVME_IDENTIFY_DATA_SIZE);
> 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) !=3D 64);
> 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) !=3D 512);
> 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) !=3D 64);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index dd24a94c42ff..ed10bfff91e1 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -238,6 +238,9 @@ struct nvme_ctrl {
> 	u32 max_hw_sectors;
> 	u32 max_segments;
> 	u32 max_integrity_segments;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	u32 max_zone_append;
> +#endif
> 	u16 crdt[3];
> 	u16 oncs;
> 	u16 oacs;
> @@ -404,6 +407,9 @@ struct nvme_ns {
> 	u16 sgs;
> 	u32 sws;
> 	u8 pi_type;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	u64 zsze;
> +#endif
> 	unsigned long features;
> 	unsigned long flags;
> #define NVME_NS_REMOVING	0
> @@ -571,6 +577,9 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
>=20
> int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 =
lsp, u8 csi,
> 		void *log, size_t size, u64 offset);
> +struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
> +		struct nvme_ns_head **head, int *srcu_idx);
> +void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
>=20
> extern const struct attribute_group *nvme_ns_id_attr_groups[];
> extern const struct block_device_operations nvme_ns_head_ops;
> @@ -692,6 +701,36 @@ static inline void nvme_mpath_start_freeze(struct =
nvme_subsystem *subsys)
> }
> #endif /* CONFIG_NVME_MULTIPATH */
>=20
> +#ifdef CONFIG_BLK_DEV_ZONED
> +int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> +			  unsigned lbaf);
> +
> +int nvme_report_zones(struct gendisk *disk, sector_t sector,
> +		      unsigned int nr_zones, report_zones_cb cb, void =
*data);
> +
> +blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct =
request *req,
> +				       struct nvme_command *cmnd,
> +				       enum nvme_zone_mgmt_action =
action);
> +#else
> +#define nvme_report_zones NULL
> +
> +static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns =
*ns,
> +		struct request *req, struct nvme_command *cmnd,
> +		enum nvme_zone_mgmt_action action)
> +{
> +	return BLK_STS_NOTSUPP;
> +}
> +
> +static inline int nvme_update_zone_info(struct gendisk *disk,
> +					struct nvme_ns *ns,
> +					unsigned lbaf)
> +{
> +	dev_warn(ns->ctrl->device,
> +		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS =
devices\n");
> +	return -EPROTONOSUPPORT;
> +}
> +#endif
> +
> #ifdef CONFIG_NVM
> int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
> void nvme_nvm_unregister(struct nvme_ns *ns);
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> new file mode 100644
> index 000000000000..c033c60ce751
> --- /dev/null
> +++ b/drivers/nvme/host/zns.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/blkdev.h>
> +#include <linux/vmalloc.h>
> +#include "nvme.h"
> +
> +static int nvme_set_max_append(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_command c =3D { };
> +	struct nvme_id_ctrl_zns *id;
> +	int status;
> +
> +	id =3D kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id)
> +		return -ENOMEM;
> +
> +	c.identify.opcode =3D nvme_admin_identify;
> +	c.identify.cns =3D NVME_ID_CNS_CS_CTRL;
> +	c.identify.csi =3D NVME_CSI_ZNS;
> +
> +	status =3D nvme_submit_sync_cmd(ctrl->admin_q, &c, id, =
sizeof(*id));
> +	if (status) {
> +		kfree(id);
> +		return status;
> +	}
> +
> +	if (id->zasl)
> +		ctrl->max_zone_append =3D 1 << (id->zasl + 3);
> +	else
> +		ctrl->max_zone_append =3D ctrl->max_hw_sectors;
> +	kfree(id);
> +	return 0;
> +}
> +
> +int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> +			  unsigned lbaf)
> +{
> +	struct nvme_effects_log *log =3D ns->head->effects;
> +	struct request_queue *q =3D disk->queue;
> +	struct nvme_command c =3D { };
> +	struct nvme_id_ns_zns *id;
> +	int status;
> +
> +	/* Driver requires zone append support */
> +	if (!(log->iocs[nvme_cmd_zone_append] & NVME_CMD_EFFECTS_CSUPP)) =
{
> +		dev_warn(ns->ctrl->device,
> +			"append not supported for zoned namespace:%d\n",
> +			ns->head->ns_id);
> +		return -EINVAL;
> +	}
> +
> +	/* Lazily query controller append limit for the first zoned =
namespace */
> +	if (!ns->ctrl->max_zone_append) {
> +		status =3D nvme_set_max_append(ns->ctrl);
> +		if (status)
> +			return status;
> +	}
> +
> +	id =3D kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id)
> +		return -ENOMEM;
> +
> +	c.identify.opcode =3D nvme_admin_identify;
> +	c.identify.nsid =3D cpu_to_le32(ns->head->ns_id);
> +	c.identify.cns =3D NVME_ID_CNS_CS_NS;
> +	c.identify.csi =3D NVME_CSI_ZNS;
> +
> +	status =3D nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, id, =
sizeof(*id));
> +	if (status)
> +		goto free_data;
> +
> +	/*
> +	 * We currently do not handle devices requiring any of the zoned
> +	 * operation characteristics.
> +	 */
> +	if (id->zoc) {
> +		dev_warn(ns->ctrl->device,
> +			"zone operations:%x not supported for =
namespace:%u\n",
> +			le16_to_cpu(id->zoc), ns->head->ns_id);
> +		status =3D -EINVAL;
> +		goto free_data;
> +	}
> +
> +	ns->zsze =3D nvme_lba_to_sect(ns, =
le64_to_cpu(id->lbafe[lbaf].zsze));
> +	if (!is_power_of_2(ns->zsze)) {
> +		dev_warn(ns->ctrl->device,
> +			"invalid zone size:%llu for namespace:%u\n",
> +			ns->zsze, ns->head->ns_id);
> +		status =3D -EINVAL;
> +		goto free_data;
> +	}
> +
> +	q->limits.zoned =3D BLK_ZONED_HM;
> +	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> +free_data:
> +	kfree(id);
> +	return status;
> +}
> +
> +static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
> +					  unsigned int nr_zones, size_t =
*buflen)
> +{
> +	struct request_queue *q =3D ns->disk->queue;
> +	size_t bufsize;
> +	void *buf;
> +
> +	const size_t min_bufsize =3D sizeof(struct nvme_zone_report) +
> +				   sizeof(struct nvme_zone_descriptor);
> +
> +	nr_zones =3D min_t(unsigned int, nr_zones,
> +			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +
> +	bufsize =3D sizeof(struct nvme_zone_report) +
> +		nr_zones * sizeof(struct nvme_zone_descriptor);
> +	bufsize =3D min_t(size_t, bufsize,
> +			queue_max_hw_sectors(q) << SECTOR_SHIFT);
> +	bufsize =3D min_t(size_t, bufsize, queue_max_segments(q) << =
PAGE_SHIFT);
> +
> +	while (bufsize >=3D min_bufsize) {
> +		buf =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
> +		if (buf) {
> +			*buflen =3D bufsize;
> +			return buf;
> +		}
> +		bufsize >>=3D 1;
> +	}
> +	return NULL;
> +}
> +
> +static int __nvme_ns_report_zones(struct nvme_ns *ns, sector_t =
sector,
> +				  struct nvme_zone_report *report,
> +				  size_t buflen)
> +{
> +	struct nvme_command c =3D { };
> +	int ret;
> +
> +	c.zmr.opcode =3D nvme_cmd_zone_mgmt_recv;
> +	c.zmr.nsid =3D cpu_to_le32(ns->head->ns_id);
> +	c.zmr.slba =3D cpu_to_le64(nvme_sect_to_lba(ns, sector));
> +	c.zmr.numd =3D cpu_to_le32(nvme_bytes_to_numd(buflen));
> +	c.zmr.zra =3D NVME_ZRA_ZONE_REPORT;
> +	c.zmr.zrasf =3D NVME_ZRASF_ZONE_REPORT_ALL;
> +	c.zmr.pr =3D NVME_REPORT_ZONE_PARTIAL;
> +
> +	ret =3D nvme_submit_sync_cmd(ns->queue, &c, report, buflen);
> +	if (ret)
> +		return ret;
> +
> +	return le64_to_cpu(report->nr_zones);
> +}
> +
> +static int nvme_zone_parse_entry(struct nvme_ns *ns,
> +				 struct nvme_zone_descriptor *entry,
> +				 unsigned int idx, report_zones_cb cb,
> +				 void *data)
> +{
> +	struct blk_zone zone =3D { };
> +
> +	if ((entry->zt & 0xf) !=3D NVME_ZONE_TYPE_SEQWRITE_REQ) {
> +		dev_err(ns->ctrl->device, "invalid zone type %#x\n",
> +				entry->zt);
> +		return -EINVAL;
> +	}
> +
> +	zone.type =3D BLK_ZONE_TYPE_SEQWRITE_REQ;
> +	zone.cond =3D entry->zs >> 4;
> +	zone.len =3D ns->zsze;
> +	zone.capacity =3D nvme_lba_to_sect(ns, =
le64_to_cpu(entry->zcap));
> +	zone.start =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
> +	zone.wp =3D nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
> +
> +	return cb(&zone, idx, data);
> +}
> +
> +static int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
> +			unsigned int nr_zones, report_zones_cb cb, void =
*data)
> +{
> +	struct nvme_zone_report *report;
> +	int ret, zone_idx =3D 0;
> +	unsigned int nz, i;
> +	size_t buflen;
> +
> +	report =3D nvme_zns_alloc_report_buffer(ns, nr_zones, &buflen);
> +	if (!report)
> +		return -ENOMEM;
> +
> +	sector &=3D ~(ns->zsze - 1);
> +	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
> +		memset(report, 0, buflen);
> +		ret =3D __nvme_ns_report_zones(ns, sector, report, =
buflen);
> +		if (ret < 0)
> +			goto out_free;
> +
> +		nz =3D min_t(unsigned int, ret, nr_zones);
> +		if (!nz)
> +			break;
> +
> +		for (i =3D 0; i < nz && zone_idx < nr_zones; i++) {
> +			ret =3D nvme_zone_parse_entry(ns, =
&report->entries[i],
> +						    zone_idx, cb, data);
> +			if (ret)
> +				goto out_free;
> +			zone_idx++;
> +		}
> +
> +		sector +=3D ns->zsze * nz;
> +	}
> +
> +	if (zone_idx > 0)
> +		ret =3D zone_idx;
> +	else
> +		ret =3D -EINVAL;
> +out_free:
> +	kvfree(report);
> +	return ret;
> +}
> +
> +int nvme_report_zones(struct gendisk *disk, sector_t sector,
> +		      unsigned int nr_zones, report_zones_cb cb, void =
*data)
> +{
> +	struct nvme_ns_head *head =3D NULL;
> +	struct nvme_ns *ns;
> +	int srcu_idx, ret;
> +
> +	ns =3D nvme_get_ns_from_disk(disk, &head, &srcu_idx);
> +	if (unlikely(!ns))
> +		return -EWOULDBLOCK;
> +
> +	if (ns->head->ids.csi =3D=3D NVME_CSI_ZNS)
> +		ret =3D nvme_ns_report_zones(ns, sector, nr_zones, cb, =
data);
> +	else
> +		ret =3D -EINVAL;
> +	nvme_put_ns_from_disk(head, srcu_idx);
> +
> +	return ret;
> +}
> +
> +blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct =
request *req,
> +		struct nvme_command *c, enum nvme_zone_mgmt_action =
action)
> +{
> +	c->zms.opcode =3D nvme_cmd_zone_mgmt_send;
> +	c->zms.nsid =3D cpu_to_le32(ns->head->ns_id);
> +	c->zms.slba =3D cpu_to_le64(nvme_sect_to_lba(ns, =
blk_rq_pos(req)));
> +	c->zms.zsa =3D action;
> +
> +	if (req_op(req) =3D=3D REQ_OP_ZONE_RESET_ALL)
> +		c->zms.select_all =3D 1;
> +
> +	return BLK_STS_OK;
> +}
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 95cd03e240a1..1643005d21e3 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -374,6 +374,30 @@ struct nvme_id_ns {
> 	__u8			vs[3712];
> };
>=20
> +struct nvme_zns_lbafe {
> +	__le64			zsze;
> +	__u8			zdes;
> +	__u8			rsvd9[7];
> +};
> +
> +struct nvme_id_ns_zns {
> +	__le16			zoc;
> +	__le16			ozcs;
> +	__le32			mar;
> +	__le32			mor;
> +	__le32			rrl;
> +	__le32			frl;
> +	__u8			rsvd20[2796];
> +	struct nvme_zns_lbafe	lbafe[16];
> +	__u8			rsvd3072[768];
> +	__u8			vs[256];
> +};
> +
> +struct nvme_id_ctrl_zns {
> +	__u8	zasl;
> +	__u8	rsvd1[4095];
> +};
> +
> enum {
> 	NVME_ID_CNS_NS			=3D 0x00,
> 	NVME_ID_CNS_CTRL		=3D 0x01,
> @@ -392,6 +416,7 @@ enum {
>=20
> enum {
> 	NVME_CSI_NVM			=3D 0,
> +	NVME_CSI_ZNS			=3D 2,
> };
>=20
> enum {
> @@ -532,6 +557,27 @@ struct nvme_ana_rsp_hdr {
> 	__le16	rsvd10[3];
> };
>=20
> +struct nvme_zone_descriptor {
> +	__u8		zt;
> +	__u8		zs;
> +	__u8		za;
> +	__u8		rsvd3[5];
> +	__le64		zcap;
> +	__le64		zslba;
> +	__le64		wp;
> +	__u8		rsvd32[32];
> +};
> +
> +enum {
> +	NVME_ZONE_TYPE_SEQWRITE_REQ	=3D 0x2,
> +};
> +
> +struct nvme_zone_report {
> +	__le64		nr_zones;
> +	__u8		resv8[56];
> +	struct nvme_zone_descriptor entries[];
> +};
> +
> enum {
> 	NVME_SMART_CRIT_SPARE		=3D 1 << 0,
> 	NVME_SMART_CRIT_TEMPERATURE	=3D 1 << 1,
> @@ -626,6 +672,9 @@ enum nvme_opcode {
> 	nvme_cmd_resv_report	=3D 0x0e,
> 	nvme_cmd_resv_acquire	=3D 0x11,
> 	nvme_cmd_resv_release	=3D 0x15,
> +	nvme_cmd_zone_mgmt_send	=3D 0x79,
> +	nvme_cmd_zone_mgmt_recv	=3D 0x7a,
> +	nvme_cmd_zone_append	=3D 0x7d,
> };
>=20
> #define nvme_opcode_name(opcode)	{ opcode, #opcode }
> @@ -764,6 +813,7 @@ struct nvme_rw_command {
> enum {
> 	NVME_RW_LR			=3D 1 << 15,
> 	NVME_RW_FUA			=3D 1 << 14,
> +	NVME_RW_APPEND_PIREMAP		=3D 1 << 9,
> 	NVME_RW_DSM_FREQ_UNSPEC		=3D 0,
> 	NVME_RW_DSM_FREQ_TYPICAL	=3D 1,
> 	NVME_RW_DSM_FREQ_RARE		=3D 2,
> @@ -829,6 +879,53 @@ struct nvme_write_zeroes_cmd {
> 	__le16			appmask;
> };
>=20
> +enum nvme_zone_mgmt_action {
> +	NVME_ZONE_CLOSE		=3D 0x1,
> +	NVME_ZONE_FINISH	=3D 0x2,
> +	NVME_ZONE_OPEN		=3D 0x3,
> +	NVME_ZONE_RESET		=3D 0x4,
> +	NVME_ZONE_OFFLINE	=3D 0x5,
> +	NVME_ZONE_SET_DESC_EXT	=3D 0x10,
> +};
> +
> +struct nvme_zone_mgmt_send_cmd {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__le32			cdw2[2];
> +	__le64			metadata;
> +	union nvme_data_ptr	dptr;
> +	__le64			slba;
> +	__le32			cdw12;
> +	__u8			zsa;
> +	__u8			select_all;
> +	__u8			rsvd13[2];
> +	__le32			cdw14[2];
> +};
> +
> +struct nvme_zone_mgmt_recv_cmd {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__le64			rsvd2[2];
> +	union nvme_data_ptr	dptr;
> +	__le64			slba;
> +	__le32			numd;
> +	__u8			zra;
> +	__u8			zrasf;
> +	__u8			pr;
> +	__u8			rsvd13;
> +	__le32			cdw14[2];
> +};
> +
> +enum {
> +	NVME_ZRA_ZONE_REPORT		=3D 0,
> +	NVME_ZRASF_ZONE_REPORT_ALL	=3D 0,
> +	NVME_REPORT_ZONE_PARTIAL	=3D 1,
> +};
> +
> /* Features */
>=20
> enum {
> @@ -1300,6 +1397,8 @@ struct nvme_command {
> 		struct nvme_format_cmd format;
> 		struct nvme_dsm_cmd dsm;
> 		struct nvme_write_zeroes_cmd write_zeroes;
> +		struct nvme_zone_mgmt_send_cmd zms;
> +		struct nvme_zone_mgmt_recv_cmd zmr;
> 		struct nvme_abort_cmd abort;
> 		struct nvme_get_log_page_command get_log_page;
> 		struct nvmf_common_command fabrics;
> @@ -1433,6 +1532,18 @@ enum {
> 	NVME_SC_DISCOVERY_RESTART	=3D 0x190,
> 	NVME_SC_AUTH_REQUIRED		=3D 0x191,
>=20
> +	/*
> +	 * I/O Command Set Specific - Zoned commands:
> +	 */
> +	NVME_SC_ZONE_BOUNDARY_ERROR	=3D 0x1b8,
> +	NVME_SC_ZONE_FULL		=3D 0x1b9,
> +	NVME_SC_ZONE_READ_ONLY		=3D 0x1ba,
> +	NVME_SC_ZONE_OFFLINE		=3D 0x1bb,
> +	NVME_SC_ZONE_INVALID_WRITE	=3D 0x1bc,
> +	NVME_SC_ZONE_TOO_MANY_ACTIVE	=3D 0x1bd,
> +	NVME_SC_ZONE_TOO_MANY_OPEN	=3D 0x1be,
> +	NVME_SC_ZONE_INVALID_TRANSITION	=3D 0x1bf,
> +
> 	/*
> 	 * Media and Data Integrity Errors:
> 	 */
> --=20
> 2.24.1
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	Oracle Linux Engineering





