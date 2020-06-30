Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED9C433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 15:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6636C20663
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 15:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iKdGKowQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389733AbgF3PwH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:52:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53290 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389392AbgF3PwG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 11:52:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFgM3R007092;
        Tue, 30 Jun 2020 15:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=l+nM27v154Ab6vYD84h1apZ1w2UWGYZtigsUQevvdaQ=;
 b=iKdGKowQhqMpUP+kBE3wKvCUDng6+PF6f2SoM+ESoeh+iGC7jSk+FZcswh3skJlyQb7D
 Nytb1M4MJQ+mTU+JL//e850tg0anEocWIuObjUxhncgbG+SAFT5IEIEcW9uCxOpih7Xa
 x+rswA2vOMiak1Sxxh7ySO/ZdpIK5Xe7G5rZo+RNk382wLdiAZpg1Mv5YjwWSBPiKS/m
 tmzvLEX6gbvCZhrPoroH3lv2rimT3PkyHHtOS3vxhINy8fChaWTW7UJqnyX6S/G1TAO9
 c3RzOw2uNr0ej2Ca3UCRU2gZUQleoK0BIMsGYQNNcy4entweYwAxMzLJ+yJz5QGV71YB 4Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31wxrn5bu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 15:51:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFgxBm084065;
        Tue, 30 Jun 2020 15:51:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 31xg13r2s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 15:51:46 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05UFphh5022038;
        Tue, 30 Jun 2020 15:51:43 GMT
Received: from dhcp-10-154-182-99.vpn.oracle.com (/10.154.182.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 15:51:42 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCHv4 4/5] nvme: support for multi-command set effects
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200629190641.1986462-5-kbusch@kernel.org>
Date:   Tue, 30 Jun 2020 10:51:40 -0500
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Keith Busch <keith.busch@wdc.com>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EDBAF48-6130-4D33-8200-4905CD15244E@oracle.com>
References: <20200629190641.1986462-1-kbusch@kernel.org>
 <20200629190641.1986462-5-kbusch@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=11 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=11 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300113
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jun 29, 2020, at 2:06 PM, Keith Busch <kbusch@kernel.org> wrote:
>=20
> From: Keith Busch <keith.busch@wdc.com>
>=20
> The Commands Supported and Effects log page was extended with a CSI
> field that enables the host to query the log page for each command set
> supported. Retrieve this log page for each command set that an =
attached
> namespace supports, and save a pointer to that log in the namespace =
head.
>=20
> Reviewed-by: Javier Gonz=C3=A1lez <javier.gonz@samsung.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Keith Busch <keith.busch@wdc.com>
> ---
> drivers/nvme/host/core.c      | 79 ++++++++++++++++++++++++++---------
> drivers/nvme/host/hwmon.c     |  2 +-
> drivers/nvme/host/lightnvm.c  |  4 +-
> drivers/nvme/host/multipath.c |  2 +-
> drivers/nvme/host/nvme.h      | 10 ++++-
> include/linux/nvme.h          |  4 +-
> 6 files changed, 76 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b7d12eb42fd8..a4a61d7e793d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1370,8 +1370,8 @@ static u32 nvme_passthru_start(struct nvme_ctrl =
*ctrl, struct nvme_ns *ns,
> 	u32 effects =3D 0;
>=20
> 	if (ns) {
> -		if (ctrl->effects)
> -			effects =3D =
le32_to_cpu(ctrl->effects->iocs[opcode]);
> +		if (ns->head->effects)
> +			effects =3D =
le32_to_cpu(ns->head->effects->iocs[opcode]);
> 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | =
NVME_CMD_EFFECTS_LBCC))
> 			dev_warn(ctrl->device,
> 				 "IO command:%02x has unhandled =
effects:%08x\n",
> @@ -2850,7 +2850,7 @@ static int nvme_init_subsystem(struct nvme_ctrl =
*ctrl, struct nvme_id_ctrl *id)
> 	return ret;
> }
>=20
> -int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 =
lsp,
> +int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 =
lsp, u8 csi,
> 		void *log, size_t size, u64 offset)
> {
> 	struct nvme_command c =3D { };
> @@ -2864,27 +2864,55 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 =
nsid, u8 log_page, u8 lsp,
> 	c.get_log_page.numdu =3D cpu_to_le16(dwlen >> 16);
> 	c.get_log_page.lpol =3D cpu_to_le32(lower_32_bits(offset));
> 	c.get_log_page.lpou =3D cpu_to_le32(upper_32_bits(offset));
> +	c.get_log_page.csi =3D csi;
>=20
> 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
> }
>=20
> -static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
> +struct nvme_cel *nvme_find_cel(struct nvme_ctrl *ctrl, u8 csi)
> {
> +	struct nvme_cel *cel, *ret =3D NULL;
> +
> +	spin_lock(&ctrl->lock);
> +	list_for_each_entry(cel, &ctrl->cels, entry) {
> +		if (cel->csi =3D=3D csi) {
> +			ret =3D cel;
> +			break;
> +		}
> +	}
> +	spin_unlock(&ctrl->lock);
> +
> +	return ret;
> +}
> +
> +static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
> +				struct nvme_effects_log **log)
> +{
> +	struct nvme_cel *cel =3D nvme_find_cel(ctrl, csi);
> 	int ret;
>=20
> -	if (!ctrl->effects)
> -		ctrl->effects =3D kzalloc(sizeof(*ctrl->effects), =
GFP_KERNEL);
> +	if (cel)
> +		goto out;
>=20
> -	if (!ctrl->effects)
> -		return 0;
> +	cel =3D kzalloc(sizeof(*cel), GFP_KERNEL);
> +	if (!cel)
> +		return -ENOMEM;
>=20
> -	ret =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CMD_EFFECTS, =
0,
> -			ctrl->effects, sizeof(*ctrl->effects), 0);
> +	ret =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CMD_EFFECTS, =
0, csi,
> +			&cel->log, sizeof(cel->log), 0);
> 	if (ret) {
> -		kfree(ctrl->effects);
> -		ctrl->effects =3D NULL;
> +		kfree(cel);
> +		return ret;
> 	}
> -	return ret;
> +
> +	cel->csi =3D csi;
> +
> +	spin_lock(&ctrl->lock);
> +	list_add_tail(&cel->entry, &ctrl->cels);
> +	spin_unlock(&ctrl->lock);
> +out:
> +	*log =3D &cel->log;
> +	return 0;
> }
>=20
> /*
> @@ -2917,7 +2945,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
> 	}
>=20
> 	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
> -		ret =3D nvme_get_effects_log(ctrl);
> +		ret =3D nvme_get_effects_log(ctrl, NVME_CSI_NVM, =
&ctrl->effects);
> 		if (ret < 0)
> 			goto out_free;
> 	}
> @@ -3550,6 +3578,13 @@ static struct nvme_ns_head =
*nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
> 		goto out_cleanup_srcu;
> 	}
>=20
> +	if (head->ids.csi) {
> +		ret =3D nvme_get_effects_log(ctrl, head->ids.csi, =
&head->effects);
> +		if (ret)
> +			goto out_cleanup_srcu;
> +	} else
> +		head->effects =3D ctrl->effects;
> +
> 	ret =3D nvme_mpath_alloc_disk(ctrl, head);
> 	if (ret)
> 		goto out_cleanup_srcu;
> @@ -3890,8 +3925,8 @@ static void nvme_clear_changed_ns_log(struct =
nvme_ctrl *ctrl)
> 	 * raced with us in reading the log page, which could cause us =
to miss
> 	 * updates.
> 	 */
> -	error =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CHANGED_NS, =
0, log,
> -			log_size, 0);
> +	error =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CHANGED_NS, =
0,
> +			NVME_CSI_NVM, log, log_size, 0);
> 	if (error)
> 		dev_warn(ctrl->device,
> 			"reading changed ns log failed: %d\n", error);
> @@ -4035,8 +4070,8 @@ static void nvme_get_fw_slot_info(struct =
nvme_ctrl *ctrl)
> 	if (!log)
> 		return;
>=20
> -	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, log,
> -			sizeof(*log), 0))
> +	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, =
NVME_CSI_NVM,
> +			log, sizeof(*log), 0))
> 		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
> 	kfree(log);
> }
> @@ -4173,11 +4208,16 @@ static void nvme_free_ctrl(struct device *dev)
> 	struct nvme_ctrl *ctrl =3D
> 		container_of(dev, struct nvme_ctrl, ctrl_device);
> 	struct nvme_subsystem *subsys =3D ctrl->subsys;
> +	struct nvme_cel *cel, *next;
>=20
> 	if (subsys && ctrl->instance !=3D subsys->instance)
> 		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
>=20
> -	kfree(ctrl->effects);
> +	list_for_each_entry_safe(cel, next, &ctrl->cels, entry) {
> +		list_del(&cel->entry);
> +		kfree(cel);
> +	}
> +
> 	nvme_mpath_uninit(ctrl);
> 	__free_page(ctrl->discard_page);
>=20
> @@ -4208,6 +4248,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, =
struct device *dev,
> 	spin_lock_init(&ctrl->lock);
> 	mutex_init(&ctrl->scan_lock);
> 	INIT_LIST_HEAD(&ctrl->namespaces);
> +	INIT_LIST_HEAD(&ctrl->cels);
> 	init_rwsem(&ctrl->namespaces_rwsem);
> 	ctrl->dev =3D dev;
> 	ctrl->ops =3D ops;
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 2e6477ed420f..23ba8bf678ae 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -62,7 +62,7 @@ static int nvme_hwmon_get_smart_log(struct =
nvme_hwmon_data *data)
> 	int ret;
>=20
> 	ret =3D nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, =
0,
> -			   &data->log, sizeof(data->log), 0);
> +			   NVME_CSI_NVM, &data->log, sizeof(data->log), =
0);
>=20
> 	return ret <=3D 0 ? ret : -EIO;
> }
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index 69608755d415..8e562d0f2c30 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -593,8 +593,8 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev =
*ndev,
> 		dev_meta_off =3D dev_meta;
>=20
> 		ret =3D nvme_get_log(ctrl, ns->head->ns_id,
> -				NVME_NVM_LOG_REPORT_CHUNK, 0, dev_meta, =
len,
> -				offset);
> +				NVME_NVM_LOG_REPORT_CHUNK, 0, =
NVME_CSI_NVM,
> +				dev_meta, len, offset);
> 		if (ret) {
> 			dev_err(ctrl->device, "Get REPORT CHUNK log =
error\n");
> 			break;
> diff --git a/drivers/nvme/host/multipath.c =
b/drivers/nvme/host/multipath.c
> index 18d084ed497e..b551e9884430 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -529,7 +529,7 @@ static int nvme_read_ana_log(struct nvme_ctrl =
*ctrl)
> 	int error;
>=20
> 	mutex_lock(&ctrl->ana_lock);
> -	error =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA, 0,
> +	error =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA, 0, =
NVME_CSI_NVM,
> 			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
> 	if (error) {
> 		dev_warn(ctrl->device, "Failed to get ANA log: %d\n", =
error);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 4aa321b16eaa..dd24a94c42ff 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -191,6 +191,12 @@ struct nvme_fault_inject {
> #endif
> };
>=20
> +struct nvme_cel {
> +	struct list_head	entry;
> +	struct nvme_effects_log	log;
> +	u8			csi;
> +};
> +
> struct nvme_ctrl {
> 	bool comp_seen;
> 	enum nvme_ctrl_state state;
> @@ -257,6 +263,7 @@ struct nvme_ctrl {
> 	unsigned long quirks;
> 	struct nvme_id_power_state psd[32];
> 	struct nvme_effects_log *effects;
> +	struct list_head cels;
> 	struct work_struct scan_work;
> 	struct work_struct async_event_work;
> 	struct delayed_work ka_work;
> @@ -359,6 +366,7 @@ struct nvme_ns_head {
> 	struct kref		ref;
> 	bool			shared;
> 	int			instance;
> +	struct nvme_effects_log *effects;
> #ifdef CONFIG_NVME_MULTIPATH
> 	struct gendisk		*disk;
> 	struct bio_list		requeue_list;
> @@ -561,7 +569,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
> int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
> int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
>=20
> -int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 =
lsp,
> +int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 =
lsp, u8 csi,
> 		void *log, size_t size, u64 offset);
>=20
> extern const struct attribute_group *nvme_ns_id_attr_groups[];
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 81ffe5247505..95cd03e240a1 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1101,7 +1101,9 @@ struct nvme_get_log_page_command {
> 		};
> 		__le64 lpo;
> 	};
> -	__u32			rsvd14[2];
> +	__u8			rsvd14[3];
> +	__u8			csi;
> +	__u32			rsvd15;
> };
>=20
> struct nvme_directive_cmd {
> --=20
> 2.24.1
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	Oracle Linux Engineering





