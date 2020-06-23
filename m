Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CDCC433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 11:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0542A20724
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 11:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Dz5yaFSD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L8Dxfap1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbgFWLZ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:25:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27848 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbgFWLZ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 07:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592911556; x=1624447556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qP+io50GQmO1eay304FugpOIYbWbOv0NHRCBKbRNooc=;
  b=Dz5yaFSD2mNBQtAcYhbHhp51MX1XURd6gKfYBtLf6/D/z4Ju3rNCpnat
   qGYWyN8YNGnpHWGxnpNq/wLE5N7T55g9dfoM1AjakM/o5AhnnTgxJdmvD
   rsEyRRHu5GpeDspPv8cktr/hJ1WkIwHj+r4yx5fRSdax3qNEb1cTVFa/K
   gvUgv9LgzfQLr0gjAlhfh2acbUSjKFD81KKhFC0yrPkMW4/Gol+YbHlrf
   opgEJF8pc+ZtnZgtZX2qeYSmaL4hfqLcxq2DKszWR/1TrLBQtdwiYJEKN
   rk4gEGoVEK1dCNB2iuxlkKiS6BgxxnRHl7iiqnGTQ+nsFzvvlTRc8vw19
   A==;
IronPort-SDR: kczeERMC+EiFx7RnIXUKqGXU7uckIP0UwjXq6DC4qQtiPpqAhT5PlhQbxsZlUiiK7gGu1Z7yw6
 NMU0iGdoxvXynCCW3+KgDZeI5HU29iXG6kX6NUYpetJXHH53lAMh6rF576UiDlpAJH1VJ2U9V4
 aArX/B0L0HoxDSNUIxxXxSFyw2bZ649mI1HpZwkbE2mv7cH7K9JiaqHUX0Z8HLVI4wnkSpeiav
 pUNuvTM/liZfX3mwVyAkZz5bhzePVQOiGqnCQ1MXaED/7s8sGsjTlEK2N/y0MXxZ16FoGYKOtk
 0S4=
X-IronPort-AV: E=Sophos;i="5.75,271,1589212800"; 
   d="scan'208";a="145010042"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2020 19:25:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL7s2Yjf+tC+KZto6Q5illbCqRhsXvSjGwSPDNnwqxv1z+XDrBzRhyaI/6ar9yYiZupt08QPHf0YEIqrbdjfwHSmUguB4RdhsqZfPn8wVuAatwTItJ7nEo5g7Xdk0sBAQ1Y2dy2dNWI55UaOrGuEoqtuDWozIqGO4rQ+SaJJqGxOARroGDlQ/tHCrXeQ38IVhLnFs+3xaSdVFqvNdAZK54z0vh0/G8Hd649HWqAIQ3u0gFwdauJ+MmnWai4lPkCGi1FG09AozZJ34EB2Va1IzolnUmqyoTbzJm2lmf07AG1vp3/4nOQ01NNmtbYOm1F3wplPc4n1Xak0P5eXZlwM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivu/6aoU4W+fhUp1ZMLoN0rwxe29/76lbQk+uHWAZqE=;
 b=C3SSgEhHxlXWxUvimKFZa79fNunmeFRKNk1DHeWl4GOB+jckVbk8iDeuEuTFNiLTT2ljfkVkUbGAQeifD3Exy4vDVARvOiQ1SkUV08ncGi04b5eW4B7wL/hTU6FYKlwkPa3m9yXOvFgTqidIujE1FG0TnkXjw+60qdmc1ytlcsWK0Xa2dmlUQaVvpGkJ/Q5Oci+E36Qk/2/Jil58FKQvbf1AQRSij0rr1ILRoVxwtJUGAUZ5rwod7ZifQdFHt53xjKQUMPNGXuux7gbQBdrV9w1riA6KBXuWS2/sdPkbxP3/TcD7aUZXjgeMGMNNLU0XB0bMuI3doCpCruHTRpTt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivu/6aoU4W+fhUp1ZMLoN0rwxe29/76lbQk+uHWAZqE=;
 b=L8Dxfap15R0nMaPjfroANyyzUm2muxnR5VF1R5hT1Le8fggzOshNMV8SLKC6Lq9XePTkh2KD4D+wZtMLnYYfTEZq92Sm9J7qNDAHbia6e7xkam67J6zkkJVMWttii3QCgZ0DsxoliKreQryQpxVkxKTlmiPlcR/Bxh7I7fhXBtU=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB5720.namprd04.prod.outlook.com (2603:10b6:a03:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 11:25:53 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:25:53 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
Thread-Topic: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
Thread-Index: AQHWSLHEI+avTIAeykKLqw+a7Aouuqjl5jmAgAAqfYA=
Date:   Tue, 23 Jun 2020 11:25:53 +0000
Message-ID: <20200623112551.GB117742@localhost.localdomain>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
In-Reply-To: <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc41a4ea-079d-4f14-3970-08d8176830e6
x-ms-traffictypediagnostic: BYAPR04MB5720:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5720573AECA5D0B3667035C7F2940@BYAPR04MB5720.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M4LWpLYUPagBfuggNaYN5Ua1D3NvFOh7jb20nPVveBColjdWnmIbKY3j0yQFuF9tz+1sa2XCLLU7LNGbQlceDsNbsHKsCa37LjKDMANuWgm0KYA/xK9t6gA36wNfCO7xWo+vWjYVifP744sqxKyPQtDK16cm+xX1tnkYenKBYOGNFFzftaMVCvA+Dc4ePGUad+iMx7VqjNo8SvY8xd4BzZzUBUvYmgiTV3cqQo5CKVkZg4sMU1kqMMhdfoDi/8/bqO2mCRyM+w1NqtXWOQHhhOakLv++4vB9+bHlw8Y2hWP91SoOTOBpggkXIvzaOMEJqno1kbCjFALEWi3NFQWfFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5112.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(6486002)(54906003)(6512007)(2906002)(9686003)(71200400001)(83380400001)(66574015)(186003)(8936002)(26005)(53546011)(6506007)(8676002)(33656002)(6916009)(478600001)(86362001)(316002)(64756008)(66556008)(5660300002)(66446008)(4326008)(91956017)(76116006)(66476007)(1076003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: S7ku93rQ/Bwq3iEiayVjPu04binmXSZD3WBEVUQVdt3wlDZzv/xf/bLSrrQKRnv22MzsKbtUfuUCDv6Emew92zGL5iu8VLovhx0fmkkpF50pjzrliWhTQxMIra4WWUiQioq+uWmwXwG0fl44REhEwPMjyO9Y6qlQTO88kfMl2bzGnACpSBSZjIWkRo3w4A9SK/wyj2Ny1cG4ybtpqfttFmdDz76H7BFASerWdQwetIHlGslZkurexXOHi8ghcz5BQ2PnlzApP4vHj4DY9l01k7fm824wO2N2HVeK2bp01yc2wn9v8XuTdWnsx6xJuXemiJWnQEMS28su72nWUchYm/rklSHvdO5tprDcMVwPOsi7NQbL9jW7fFLODqwWo+c5yQD7b00fRtryEI3WM5k0tjZFiPnKD6xIf4A2YOfGTooZufyt+WuUvvmISWDCaYjbUH7bbcuhssftapkkHPTv8nBv3NyJ2YtTed2UmxvLEMRyWRcCctv3d1DyZ9jFt3LS
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <80F43E0608092F4CA992F58C4A43D0B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc41a4ea-079d-4f14-3970-08d8176830e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 11:25:53.4692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2u5FY5M2I6Hw7uGLK76tNXPQkLe3wDmpM0Qdq4O92h649G31mgiU754ZaCijp5kLP+hBoeFi2g0wlr1L7SLPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5720
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 23, 2020 at 01:53:47AM -0700, Sagi Grimberg wrote:
>=20
>=20
> On 6/22/20 9:25 AM, Keith Busch wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > Implements support for the I/O Command Sets command set. The command se=
t
> > introduces a method to enumerate multiple command sets per namespace. I=
f
> > the command set is exposed, this method for enumeration will be used
> > instead of the traditional method that uses the CC.CSS register command
> > set register for command set identification.
> >=20
> > For namespaces where the Command Set Identifier is not supported or
> > recognized, the specific namespace will not be created.
> >=20
> > Reviewed-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Reviewed-by: Matias Bj=F8rling <matias.bjorling@wdc.com>
> > Reviewed-by: Daniel Wagner <dwagner@suse.de>
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >   drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++------=
-
> >   drivers/nvme/host/nvme.h |  1 +
> >   include/linux/nvme.h     | 19 ++++++++++++++--
> >   3 files changed, 58 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 9491dbcfe81a..45a3cb5a35bd 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1056,8 +1056,13 @@ static int nvme_identify_ctrl(struct nvme_ctrl *=
dev, struct nvme_id_ctrl **id)
> >   	return error;
> >   }
> > +static bool nvme_multi_css(struct nvme_ctrl *ctrl)
> > +{
> > +	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) =3D=3D NVME_CC_CSS_CSI;
> > +}
> > +
> >   static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_n=
s_ids *ids,
> > -		struct nvme_ns_id_desc *cur)
> > +		struct nvme_ns_id_desc *cur, bool *csi_seen)
> >   {
> >   	const char *warn_str =3D "ctrl returned bogus length:";
> >   	void *data =3D cur;
> > @@ -1087,6 +1092,15 @@ static int nvme_process_ns_desc(struct nvme_ctrl=
 *ctrl, struct nvme_ns_ids *ids,
> >   		}
> >   		uuid_copy(&ids->uuid, data + sizeof(*cur));
> >   		return NVME_NIDT_UUID_LEN;
> > +	case NVME_NIDT_CSI:
> > +		if (cur->nidl !=3D NVME_NIDT_CSI_LEN) {
> > +			dev_warn(ctrl->device, "%s %d for NVME_NIDT_CSI\n",
> > +				 warn_str, cur->nidl);
> > +			return -1;
> > +		}
> > +		memcpy(&ids->csi, data + sizeof(*cur), NVME_NIDT_CSI_LEN);
> > +		*csi_seen =3D true;
> > +		return NVME_NIDT_CSI_LEN;
> >   	default:
> >   		/* Skip unknown types */
> >   		return cur->nidl;
> > @@ -1097,10 +1111,9 @@ static int nvme_identify_ns_descs(struct nvme_ct=
rl *ctrl, unsigned nsid,
> >   		struct nvme_ns_ids *ids)
> >   {
> >   	struct nvme_command c =3D { };
> > -	int status;
> > +	bool csi_seen =3D false;
> > +	int status, pos, len;
> >   	void *data;
> > -	int pos;
> > -	int len;
> >   	c.identify.opcode =3D nvme_admin_identify;
> >   	c.identify.nsid =3D cpu_to_le32(nsid);
> > @@ -1130,13 +1143,19 @@ static int nvme_identify_ns_descs(struct nvme_c=
trl *ctrl, unsigned nsid,
> >   		if (cur->nidl =3D=3D 0)
> >   			break;
> > -		len =3D nvme_process_ns_desc(ctrl, ids, cur);
> > +		len =3D nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
> >   		if (len < 0)
> >   			goto free_data;
> >   		len +=3D sizeof(*cur);
> >   	}
> >   free_data:
> > +	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
>=20
> We will clear the status if we detect a path error, that is to
> avoid needlessly removing the ns for path failures, so you should
> check at the goto site.

The problem is that this check has to be done after checking all the ns des=
cs,
so this check to be done as the final thing, at least after processing all =
the
ns descs. No matter if nvme_process_ns_desc() returned an error, or if
simply NVME_NIDT_CSI wasn't part of the ns desc list, so the loop reached t=
he
end without error.

Even if the nvme command failed and the status was cleared:

                if (status > 0 && !(status & NVME_SC_DNR))
                        status =3D 0;

we still need to return an error, if (nvme_multi_css(ctrl) && !csi_seen).
(Not reporting a CSI when nvme_multi_css() is enabled, is fatal.)

That is why the code looks like it does.

I guess we could do something like this, which does the same thing,
but perhaps is a bit clearer:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e95f0c498a6b..bef687b9a277 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1160,8 +1160,10 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *=
ctrl, unsigned nsid,
                  * Don't treat an error as fatal, as we potentially alread=
y
                  * have a NGUID or EUI-64.
                  */
-               if (status > 0 && !(status & NVME_SC_DNR))
+               if (status > 0 && !(status & NVME_SC_DNR)) {
                        status =3D 0;
+                       goto csi_check;
+               }
                goto free_data;
        }

@@ -1173,17 +1175,17 @@ static int nvme_identify_ns_descs(struct nvme_ctrl =
*ctrl, unsigned nsid,

                len =3D nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
                if (len < 0)
-                       goto free_data;
+                       goto csi_check;

                len +=3D sizeof(*cur);
        }
-free_data:
-       if (!status && nvme_multi_css(ctrl) && !csi_seen) {
+csi_check:
+       if (nvme_multi_css(ctrl) && !csi_seen) {
                dev_warn(ctrl->device, "Command set not reported for nsid:%=
d\n",
                         nsid);
                status =3D -EINVAL;
        }
-
+free_data:
        kfree(data);
        return status;
 }


>=20
> > +		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
> > +			 nsid);
> > +		status =3D -EINVAL;
> > +	}
> > +
> >   	kfree(data);
> >   	return status;
> >   }
> > @@ -1792,7 +1811,7 @@ static int nvme_report_ns_ids(struct nvme_ctrl *c=
trl, unsigned int nsid,
> >   		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
> >   	if (ctrl->vs >=3D NVME_VS(1, 2, 0))
> >   		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
> > -	if (ctrl->vs >=3D NVME_VS(1, 3, 0))
> > +	if (ctrl->vs >=3D NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
> >   		return nvme_identify_ns_descs(ctrl, nsid, ids);
> >   	return 0;
> >   }
> > @@ -1808,7 +1827,8 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids =
*a, struct nvme_ns_ids *b)
> >   {
> >   	return uuid_equal(&a->uuid, &b->uuid) &&
> >   		memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) =3D=3D 0 &&
> > -		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) =3D=3D 0;
> > +		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) =3D=3D 0 &&
> > +		a->csi =3D=3D b->csi;
> >   }
> >   static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_=
ns *ns,
> > @@ -1930,6 +1950,15 @@ static int __nvme_revalidate_disk(struct gendisk=
 *disk, struct nvme_id_ns *id)
> >   	if (ns->lba_shift =3D=3D 0)
> >   		ns->lba_shift =3D 9;
> > +	switch (ns->head->ids.csi) {
> > +	case NVME_CSI_NVM:
> > +		break;
> > +	default:
> > +		dev_warn(ctrl->device, "unknown csi:%d ns:%d\n",
> > +			ns->head->ids.csi, ns->head->ns_id);
> > +		return -ENODEV;
> > +	}
>=20
> Not sure we need a switch-case statement for a single case target...

I would consider it two cases. A supported CSI or a non-supported CSI
(which means any CSI value !=3D NVME_CSI_NVM).

However, a follow up patch (patch 5/5 in this series) adds another case
to this switch-case statement (NVME_CSI_ZNS).

I guess this patch could have used an if-else statement, and patch 5/5
replaced the if-statement with a switch-case.
However, since a patch in the same series actually adds another case,
I think that it is more clear this way.
(A switch-case with only two cases added, in a patch that is not the last
one in the series, suggests (at least to me), that it will most likely be
extended in a following patch.)


Kind regards,
Niklas=
