Return-Path: <adilger@dilger.ca>
Return-Path: <adilger@dilger.ca>
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <F554C3E7-F38E-4F9F-80BA-B82353FFA8C8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7A75E979-ECB6-406B-943E-722264776CDC";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
Date: Tue, 13 Jun 2017 15:12:57 -0600
In-Reply-To: <1497374123-15286-12-git-send-email-axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-12-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_7A75E979-ECB6-406B-943E-722264776CDC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
> This adds support for Directives in NVMe, particular for the Streams
> directive. We default to allocating 4 streams per name space, but
> it is configurable with the 'streams_per_ns' module option.
>=20
> If a write stream is set in a write, flag is as such before
> sending it to the device.
>=20
> Some debug stuff in this patch, dumping streams ID params when
> we load nvme.
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> drivers/nvme/host/core.c | 124 =
+++++++++++++++++++++++++++++++++++++++++++++++
> drivers/nvme/host/nvme.h |   1 +
> include/linux/nvme.h     |  48 ++++++++++++++++++
> 3 files changed, 173 insertions(+)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 903d5813023a..81225e7d4176 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1073,6 +1086,109 @@ static int nvme_revalidate_disk(struct gendisk =
*disk)
> 	return 0;
> }
>=20
> +static int nvme_enable_streams(struct nvme_ns *ns)
> +{
> +	struct nvme_command c;
> +
> +	memset(&c, 0, sizeof(c));
> +
> +	c.directive.opcode =3D nvme_admin_directive_send;
> +	c.directive.nsid =3D cpu_to_le32(ns->ns_id);
> +	c.directive.doper =3D NVME_DIR_SND_ID_OP_ENABLE;
> +	c.directive.dtype =3D NVME_DIR_IDENTIFY;
> +	c.directive.tdtype =3D NVME_DIR_STREAMS;
> +	c.directive.endir =3D NVME_DIR_ENDIR;
> +
> +	return nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL, 0);
> +}
> +
> +static int nvme_streams_params(struct nvme_ns *ns)
> +{
> +	struct nvme_ctrl *ctrl =3D ns->ctrl;
> +	struct streams_directive_params s;
> +	struct nvme_command c;
> +	int ret;
> +
> +	memset(&c, 0, sizeof(c));
> +	memset(&s, 0, sizeof(s));

Minor nit in a few places in this code - is it more efficient to =
initialize
these structs at declaration time instead of calling memset(), like:

	struct streams_directive_params s =3D {};
	struct nvme_command c =3D {};

or alternately initializing them fully at declaration time to avoid =
zeroing
fields that are immediately being set:

	struct nvme_command c =3D
	{
		.directive.opcode =3D nvme_admin_directive_recv;
		.directive.nsid =3D cpu_to_le32(ns->ns_id);
		.directive.numd =3D sizeof(s);
		.directive.doper =3D NVME_DIR_RCV_ST_OP_PARAM;
		.directive.dtype =3D NVME_DIR_STREAMS;
	};

Same for the other functions here.

Cheers, Andreas

> +
> +	c.directive.opcode =3D nvme_admin_directive_recv;
> +	c.directive.nsid =3D cpu_to_le32(ns->ns_id);
> +	c.directive.numd =3D sizeof(s);
> +	c.directive.doper =3D NVME_DIR_RCV_ST_OP_PARAM;
> +	c.directive.dtype =3D NVME_DIR_STREAMS;
> +
> +	ret =3D nvme_submit_sync_cmd(ctrl->admin_q, &c, &s, sizeof(s));
> +	if (ret)
> +		return ret;
> +
> +	s.msl =3D le16_to_cpu(s.msl);
> +	s.nssa =3D le16_to_cpu(s.nssa);
> +	s.nsso =3D le16_to_cpu(s.nsso);
> +	s.sws =3D le32_to_cpu(s.sws);
> +	s.sgs =3D le16_to_cpu(s.sgs);
> +	s.nsa =3D le16_to_cpu(s.nsa);
> +	s.nso =3D le16_to_cpu(s.nso);
> +
> +	dev_info(ctrl->device, "streams: msl=3D%u, nssa=3D%u, nsso=3D%u, =
sws=3D%u "
> +				"sgs=3D%u, nsa=3D%u, nso=3D%u\n", s.msl, =
s.nssa,
> +				s.nsso, s.sws, s.sgs, s.nsa, s.nso);
> +	return 0;
> +}
> +
> +static int nvme_streams_allocate(struct nvme_ns *ns, unsigned int =
streams)
> +{
> +	struct nvme_command c;
> +
> +	memset(&c, 0, sizeof(c));
> +
> +	c.directive.opcode =3D nvme_admin_directive_recv;
> +	c.directive.nsid =3D cpu_to_le32(ns->ns_id);
> +	c.directive.doper =3D NVME_DIR_RCV_ST_OP_RESOURCE;
> +	c.directive.dtype =3D NVME_DIR_STREAMS;
> +	c.directive.endir =3D streams;
> +
> +	return nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL, 0);
> +}
> +
> +static int nvme_streams_deallocate(struct nvme_ns *ns)
> +{
> +	struct nvme_command c;
> +
> +	memset(&c, 0, sizeof(c));
> +
> +	c.directive.opcode =3D nvme_admin_directive_send;
> +	c.directive.nsid =3D cpu_to_le32(ns->ns_id);
> +	c.directive.doper =3D NVME_DIR_SND_ST_OP_REL_RSC;
> +	c.directive.dtype =3D NVME_DIR_STREAMS;
> +
> +	return nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL, 0);
> +}
> +
> +static void nvme_config_streams(struct nvme_ns *ns)
> +{
> +	int ret;
> +
> +	ret =3D nvme_enable_streams(ns);
> +	if (ret)
> +		return;
> +
> +	ret =3D nvme_streams_params(ns);
> +	if (ret)
> +		return;
> +
> +	ret =3D nvme_streams_allocate(ns, streams_per_ns);
> +	if (ret)
> +		return;
> +
> +	ret =3D nvme_streams_params(ns);
> +	if (ret)
> +		return;
> +
> +	ns->streams =3D true;
> +	dev_info(ns->ctrl->device, "successfully enabled streams\n");
> +}
> +
> static char nvme_pr_type(enum pr_type type)
> {
> 	switch (type) {
> @@ -1606,6 +1722,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
> 	ctrl->sgls =3D le32_to_cpu(id->sgls);
> 	ctrl->kas =3D le16_to_cpu(id->kas);
>=20
> +	if (ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES)
> +		dev_info(ctrl->dev, "supports directives\n");
> +
> 	ctrl->npss =3D id->npss;
> 	prev_apsta =3D ctrl->apsta;
> 	if (ctrl->quirks & NVME_QUIRK_NO_APST) {
> @@ -2060,6 +2179,9 @@ static void nvme_alloc_ns(struct nvme_ctrl =
*ctrl, unsigned nsid)
> 		goto out_free_id;
> 	}
>=20
> +	if (ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES)
> +		nvme_config_streams(ns);
> +
> 	disk =3D alloc_disk_node(0, node);
> 	if (!disk)
> 		goto out_free_id;
> @@ -2112,6 +2234,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> 					&nvme_ns_attr_group);
> 		if (ns->ndev)
> 			nvme_nvm_unregister_sysfs(ns);
> +		if (ns->streams)
> +			nvme_streams_deallocate(ns);
> 		del_gendisk(ns->disk);
> 		blk_cleanup_queue(ns->queue);
> 	}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9d6a070d4391..c2d8d23c90de 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -195,6 +195,7 @@ struct nvme_ns {
> 	int lba_shift;
> 	u16 ms;
> 	bool ext;
> +	bool streams;
> 	u8 pi_type;
> 	unsigned long flags;
>=20
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b625bacf37ef..8b2f5b140134 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -245,6 +245,7 @@ enum {
> 	NVME_CTRL_ONCS_WRITE_ZEROES		=3D 1 << 3,
> 	NVME_CTRL_VWC_PRESENT			=3D 1 << 0,
> 	NVME_CTRL_OACS_SEC_SUPP                 =3D 1 << 0,
> +	NVME_CTRL_OACS_DIRECTIVES		=3D 1 << 5,
> 	NVME_CTRL_OACS_DBBUF_SUPP		=3D 1 << 7,
> };
>=20
> @@ -295,6 +296,19 @@ enum {
> };
>=20
> enum {
> +	NVME_DIR_IDENTIFY		=3D 0x00,
> +	NVME_DIR_STREAMS		=3D 0x01,
> +	NVME_DIR_SND_ID_OP_ENABLE	=3D 0x01,
> +	NVME_DIR_SND_ST_OP_REL_ID	=3D 0x01,
> +	NVME_DIR_SND_ST_OP_REL_RSC	=3D 0x02,
> +	NVME_DIR_RCV_ID_OP_PARAM	=3D 0x01,
> +	NVME_DIR_RCV_ST_OP_PARAM	=3D 0x01,
> +	NVME_DIR_RCV_ST_OP_STATUS	=3D 0x02,
> +	NVME_DIR_RCV_ST_OP_RESOURCE	=3D 0x03,
> +	NVME_DIR_ENDIR			=3D 0x01,
> +};
> +
> +enum {
> 	NVME_NS_FEAT_THIN	=3D 1 << 0,
> 	NVME_NS_FLBAS_LBA_MASK	=3D 0xf,
> 	NVME_NS_FLBAS_META_EXT	=3D 0x10,
> @@ -535,6 +549,7 @@ enum {
> 	NVME_RW_PRINFO_PRCHK_APP	=3D 1 << 11,
> 	NVME_RW_PRINFO_PRCHK_GUARD	=3D 1 << 12,
> 	NVME_RW_PRINFO_PRACT		=3D 1 << 13,
> +	NVME_RW_DTYPE_STREAMS		=3D 1 << 4,
> };
>=20
> struct nvme_dsm_cmd {
> @@ -604,6 +619,8 @@ enum nvme_admin_opcode {
> 	nvme_admin_download_fw		=3D 0x11,
> 	nvme_admin_ns_attach		=3D 0x15,
> 	nvme_admin_keep_alive		=3D 0x18,
> +	nvme_admin_directive_send	=3D 0x19,
> +	nvme_admin_directive_recv	=3D 0x1a,
> 	nvme_admin_dbbuf		=3D 0x7C,
> 	nvme_admin_format_nvm		=3D 0x80,
> 	nvme_admin_security_send	=3D 0x81,
> @@ -756,6 +773,24 @@ struct nvme_get_log_page_command {
> 	__u32			rsvd14[2];
> };
>=20
> +struct nvme_directive_cmd {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__u64			rsvd2[2];
> +	union nvme_data_ptr	dptr;
> +	__le32			numd;
> +	__u8			doper;
> +	__u8			dtype;
> +	__le16			dspec;
> +	__u8			endir;
> +	__u8			tdtype;
> +	__u16			rsvd15;
> +
> +	__u32			rsvd16[3];
> +};
> +
> /*
>  * Fabrics subcommands.
>  */
> @@ -886,6 +921,18 @@ struct nvme_dbbuf {
> 	__u32			rsvd12[6];
> };
>=20
> +struct streams_directive_params {
> +	__u16	msl;
> +	__u16	nssa;
> +	__u16	nsso;
> +	__u8	rsvd[10];
> +	__u32	sws;
> +	__u16	sgs;
> +	__u16	nsa;
> +	__u16	nso;
> +	__u8	rsvd2[6];
> +};
> +
> struct nvme_command {
> 	union {
> 		struct nvme_common_command common;
> @@ -906,6 +953,7 @@ struct nvme_command {
> 		struct nvmf_property_set_command prop_set;
> 		struct nvmf_property_get_command prop_get;
> 		struct nvme_dbbuf dbbuf;
> +		struct nvme_directive_cmd directive;
> 	};
> };
>=20
> --
> 2.7.4
>=20


Cheers, Andreas






--Apple-Mail=_7A75E979-ECB6-406B-943E-722264776CDC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZQFVZpIg59Q01vtYRAoCWAKDLAz/WOvqVpGq9bOs9gyXix93aFwCdEHuG
7DVuLZ005Fx6jWkolAMdvbg=
=wETh
-----END PGP SIGNATURE-----

--Apple-Mail=_7A75E979-ECB6-406B-943E-722264776CDC--
