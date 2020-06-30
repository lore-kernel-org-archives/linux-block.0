Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F673C433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 15:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362832074F
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 15:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="grDb0cS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389701AbgF3PsA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:48:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49284 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389628AbgF3Pr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 11:47:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFgoRA007308;
        Tue, 30 Jun 2020 15:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=5VsvcKz91eBwIblXryzrwyXAQNKprZ5QCQU5+QArr/A=;
 b=grDb0cS5rTRSjeNLS7sErljiDhguOu3CTK65Heos/0LwG6ktCLReH+dCUdgCMs74xm9P
 /MbloTed4wqdoYk006EyPorc5iLhHgS3k6JwOhHY5fgJ6UiOM/4SdjfAZriMYPQfmCPU
 16BGxWYCHNm95H+nx0MlX9VxZUii7aYk3PMyn+KychQmMTOo7G3JfbAxROpKQKCHCmCt
 +zI1zhwQOD/AHhKv5UsId2vnm4RsfDU7o7kB1OCBhbrVO46/up+zvzWfm5u+z9LMJKiI
 JHEMd12mOkwroFMeTCGwASP3961rqXIWnpnos8vSO8DbLsy/dhvKHe84eqk4I09Uvbot XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31wxrn5ax4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 15:47:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFgxhl084060;
        Tue, 30 Jun 2020 15:45:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31xg13qtg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 15:45:36 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05UFjXkn015178;
        Tue, 30 Jun 2020 15:45:34 GMT
Received: from dhcp-10-154-182-99.vpn.oracle.com (/10.154.182.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 15:45:33 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCHv4 3/5] nvme: implement I/O Command Sets Command Set
 support
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200629190641.1986462-4-kbusch@kernel.org>
Date:   Tue, 30 Jun 2020 10:45:31 -0500
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Niklas Cassel <niklas.cassel@wdc.com>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <50ECB21A-E2DA-4B2D-B5CE-603694DFB224@oracle.com>
References: <20200629190641.1986462-1-kbusch@kernel.org>
 <20200629190641.1986462-4-kbusch@kernel.org>
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
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Implements support for the I/O Command Sets command set. The command =
set
> introduces a method to enumerate multiple command sets per namespace. =
If
> the command set is exposed, this method for enumeration will be used
> instead of the traditional method that uses the CC.CSS register =
command
> set register for command set identification.
>=20
> For namespaces where the Command Set Identifier is not supported or
> recognized, the specific namespace will not be created.
>=20
> Reviewed-by: Javier Gonz=C3=A1lez <javier.gonz@samsung.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Matias Bj=C3=B8rling <matias.bjorling@wdc.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> drivers/nvme/host/core.c | 53 ++++++++++++++++++++++++++++++++--------
> drivers/nvme/host/nvme.h |  1 +
> include/linux/nvme.h     | 19 ++++++++++++--
> 3 files changed, 61 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 701763910e48..b7d12eb42fd8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1056,8 +1056,13 @@ static int nvme_identify_ctrl(struct nvme_ctrl =
*dev, struct nvme_id_ctrl **id)
> 	return error;
> }
>=20
> +static bool nvme_multi_css(struct nvme_ctrl *ctrl)
> +{
> +	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) =3D=3D =
NVME_CC_CSS_CSI;
> +}
> +
> static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct =
nvme_ns_ids *ids,
> -		struct nvme_ns_id_desc *cur)
> +		struct nvme_ns_id_desc *cur, bool *csi_seen)
> {
> 	const char *warn_str =3D "ctrl returned bogus length:";
> 	void *data =3D cur;
> @@ -1087,6 +1092,15 @@ static int nvme_process_ns_desc(struct =
nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
> 		}
> 		uuid_copy(&ids->uuid, data + sizeof(*cur));
> 		return NVME_NIDT_UUID_LEN;
> +	case NVME_NIDT_CSI:
> +		if (cur->nidl !=3D NVME_NIDT_CSI_LEN) {
> +			dev_warn(ctrl->device, "%s %d for =
NVME_NIDT_CSI\n",
> +				 warn_str, cur->nidl);
> +			return -1;
> +		}
> +		memcpy(&ids->csi, data + sizeof(*cur), =
NVME_NIDT_CSI_LEN);
> +		*csi_seen =3D true;
> +		return NVME_NIDT_CSI_LEN;
> 	default:
> 		/* Skip unknown types */
> 		return cur->nidl;
> @@ -1097,10 +1111,9 @@ static int nvme_identify_ns_descs(struct =
nvme_ctrl *ctrl, unsigned nsid,
> 		struct nvme_ns_ids *ids)
> {
> 	struct nvme_command c =3D { };
> -	int status;
> +	bool csi_seen =3D false;
> +	int status, pos, len;
> 	void *data;
> -	int pos;
> -	int len;
>=20
> 	c.identify.opcode =3D nvme_admin_identify;
> 	c.identify.nsid =3D cpu_to_le32(nsid);
> @@ -1125,7 +1138,7 @@ static int nvme_identify_ns_descs(struct =
nvme_ctrl *ctrl, unsigned nsid,
> 		  * device just because of a temporal retry-able error =
(such
> 		  * as path of transport errors).
> 		  */
> -		if (status > 0 && (status & NVME_SC_DNR))
> +		if (status > 0 && (status & NVME_SC_DNR) && =
!nvme_multi_css(ctrl))
> 			status =3D 0;
> 		goto free_data;
> 	}
> @@ -1136,12 +1149,19 @@ static int nvme_identify_ns_descs(struct =
nvme_ctrl *ctrl, unsigned nsid,
> 		if (cur->nidl =3D=3D 0)
> 			break;
>=20
> -		len =3D nvme_process_ns_desc(ctrl, ids, cur);
> +		len =3D nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
> 		if (len < 0)
> -			goto free_data;
> +			break;
>=20
> 		len +=3D sizeof(*cur);
> 	}
> +
> +	if (nvme_multi_css(ctrl) && !csi_seen) {
> +		dev_warn(ctrl->device, "Command set not reported for =
nsid:%d\n",
> +			 nsid);
> +		status =3D -EINVAL;
> +	}
> +
> free_data:
> 	kfree(data);
> 	return status;
> @@ -1798,7 +1818,7 @@ static int nvme_report_ns_ids(struct nvme_ctrl =
*ctrl, unsigned int nsid,
> 		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
> 	if (ctrl->vs >=3D NVME_VS(1, 2, 0))
> 		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
> -	if (ctrl->vs >=3D NVME_VS(1, 3, 0))
> +	if (ctrl->vs >=3D NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
> 		return nvme_identify_ns_descs(ctrl, nsid, ids);
> 	return 0;
> }
> @@ -1814,7 +1834,8 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids =
*a, struct nvme_ns_ids *b)
> {
> 	return uuid_equal(&a->uuid, &b->uuid) &&
> 		memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) =3D=3D 0 =
&&
> -		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) =3D=3D 0;
> +		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) =3D=3D 0 =
&&
> +		a->csi =3D=3D b->csi;
> }
>=20
> static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct =
nvme_ns *ns,
> @@ -1936,6 +1957,15 @@ static int __nvme_revalidate_disk(struct =
gendisk *disk, struct nvme_id_ns *id)
> 	if (ns->lba_shift =3D=3D 0)
> 		ns->lba_shift =3D 9;
>=20
> +	switch (ns->head->ids.csi) {
> +	case NVME_CSI_NVM:
> +		break;
> +	default:
> +		dev_warn(ctrl->device, "unknown csi:%d ns:%d\n",
> +			ns->head->ids.csi, ns->head->ns_id);
> +		return -ENODEV;
> +	}
> +
> 	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
> 	    is_power_of_2(ctrl->max_hw_sectors))
> 		iob =3D ctrl->max_hw_sectors;
> @@ -2269,7 +2299,10 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>=20
> 	ctrl->page_size =3D 1 << page_shift;
>=20
> -	ctrl->ctrl_config =3D NVME_CC_CSS_NVM;
> +	if (NVME_CAP_CSS(ctrl->cap) & NVME_CAP_CSS_CSI)
> +		ctrl->ctrl_config =3D NVME_CC_CSS_CSI;
> +	else
> +		ctrl->ctrl_config =3D NVME_CC_CSS_NVM;
> 	ctrl->ctrl_config |=3D (page_shift - 12) << NVME_CC_MPS_SHIFT;
> 	ctrl->ctrl_config |=3D NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
> 	ctrl->ctrl_config |=3D NVME_CC_IOSQES | NVME_CC_IOCQES;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 919ebaf3fdef..4aa321b16eaa 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -339,6 +339,7 @@ struct nvme_ns_ids {
> 	u8	eui64[8];
> 	u8	nguid[16];
> 	uuid_t	uuid;
> +	u8	csi;
> };
>=20
> /*
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 5ce51ab4c50e..81ffe5247505 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -132,6 +132,7 @@ enum {
> #define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
> #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
> #define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
> +#define NVME_CAP_CSS(cap)	(((cap) >> 37) & 0xff)
> #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
> #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
>=20
> @@ -162,7 +163,6 @@ enum {
>=20
> enum {
> 	NVME_CC_ENABLE		=3D 1 << 0,
> -	NVME_CC_CSS_NVM		=3D 0 << 4,
> 	NVME_CC_EN_SHIFT	=3D 0,
> 	NVME_CC_CSS_SHIFT	=3D 4,
> 	NVME_CC_MPS_SHIFT	=3D 7,
> @@ -170,6 +170,9 @@ enum {
> 	NVME_CC_SHN_SHIFT	=3D 14,
> 	NVME_CC_IOSQES_SHIFT	=3D 16,
> 	NVME_CC_IOCQES_SHIFT	=3D 20,
> +	NVME_CC_CSS_NVM		=3D 0 << NVME_CC_CSS_SHIFT,
> +	NVME_CC_CSS_CSI		=3D 6 << NVME_CC_CSS_SHIFT,
> +	NVME_CC_CSS_MASK	=3D 7 << NVME_CC_CSS_SHIFT,
> 	NVME_CC_AMS_RR		=3D 0 << NVME_CC_AMS_SHIFT,
> 	NVME_CC_AMS_WRRU	=3D 1 << NVME_CC_AMS_SHIFT,
> 	NVME_CC_AMS_VS		=3D 7 << NVME_CC_AMS_SHIFT,
> @@ -179,6 +182,8 @@ enum {
> 	NVME_CC_SHN_MASK	=3D 3 << NVME_CC_SHN_SHIFT,
> 	NVME_CC_IOSQES		=3D NVME_NVM_IOSQES << =
NVME_CC_IOSQES_SHIFT,
> 	NVME_CC_IOCQES		=3D NVME_NVM_IOCQES << =
NVME_CC_IOCQES_SHIFT,
> +	NVME_CAP_CSS_NVM	=3D 1 << 0,
> +	NVME_CAP_CSS_CSI	=3D 1 << 6,
> 	NVME_CSTS_RDY		=3D 1 << 0,
> 	NVME_CSTS_CFS		=3D 1 << 1,
> 	NVME_CSTS_NSSRO		=3D 1 << 4,
> @@ -374,6 +379,8 @@ enum {
> 	NVME_ID_CNS_CTRL		=3D 0x01,
> 	NVME_ID_CNS_NS_ACTIVE_LIST	=3D 0x02,
> 	NVME_ID_CNS_NS_DESC_LIST	=3D 0x03,
> +	NVME_ID_CNS_CS_NS		=3D 0x05,
> +	NVME_ID_CNS_CS_CTRL		=3D 0x06,
> 	NVME_ID_CNS_NS_PRESENT_LIST	=3D 0x10,
> 	NVME_ID_CNS_NS_PRESENT		=3D 0x11,
> 	NVME_ID_CNS_CTRL_NS_LIST	=3D 0x12,
> @@ -383,6 +390,10 @@ enum {
> 	NVME_ID_CNS_UUID_LIST		=3D 0x17,
> };
>=20
> +enum {
> +	NVME_CSI_NVM			=3D 0,
> +};
> +
> enum {
> 	NVME_DIR_IDENTIFY		=3D 0x00,
> 	NVME_DIR_STREAMS		=3D 0x01,
> @@ -435,11 +446,13 @@ struct nvme_ns_id_desc {
> #define NVME_NIDT_EUI64_LEN	8
> #define NVME_NIDT_NGUID_LEN	16
> #define NVME_NIDT_UUID_LEN	16
> +#define NVME_NIDT_CSI_LEN	1
>=20
> enum {
> 	NVME_NIDT_EUI64		=3D 0x01,
> 	NVME_NIDT_NGUID		=3D 0x02,
> 	NVME_NIDT_UUID		=3D 0x03,
> +	NVME_NIDT_CSI		=3D 0x04,
> };
>=20
> struct nvme_smart_log {
> @@ -972,7 +985,9 @@ struct nvme_identify {
> 	__u8			cns;
> 	__u8			rsvd3;
> 	__le16			ctrlid;
> -	__u32			rsvd11[5];
> +	__u8			rsvd11[3];
> +	__u8			csi;
> +	__u32			rsvd12[4];
> };
>=20
> #define NVME_IDENTIFY_DATA_SIZE 4096
> --=20
> 2.24.1
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	Oracle Linux Engineering





