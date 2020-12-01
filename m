Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A34C64E8A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 05:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3CD2168B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 05:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="BCHGf9oW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="N36KLJrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgLAFpk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 00:45:40 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25543 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgLAFpj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 00:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606801887; x=1638337887;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=INg4bDOSzrG++0IVKgsJiIm+GvygEsoscYQuYSgQb+0=;
  b=BCHGf9oWuza7mrrmHvCyj2zza+UrFDZX6tbHJnYoB06gvZgDIMz7UoMJ
   BXOXJbEuk0v7rLzOFEX1E/98xnCNvFgGPg8gzplbz4VT52A+yQdmkS4Fa
   2GIgQLoyntL0wp2zNGC46JtF2ElRQb66HCpJHgidxpho+Qd8PSOqQC65/
   PojXI85+UYr4vLzbZyk0BKM8TtgY1I5ABSY2lERvwaGkOEbPIB9PHdA5i
   NsgMJTjXim+3z7mBcBtpuIQarDlwC5EoLX8xuMxMyO6A2ZiUr3JOoo+hE
   P/gNQS/pEpwc+RRIP7zxwfxNOJ6O5/xS1/63OUC315BbihKlcMfMd6Moe
   g==;
IronPort-SDR: LZ4LEfz+xE8LO7i1CTelToBZlTvhw5fFbEIGuFUDn73FVOjN42Ok9Mu+tm3daMVbsziHAWcfJL
 HwBTVMWISZmR+CDOmJuBCgxNH1bLjZTC0vOAKnk43xDHfQ5ZqFhFYgAXfPWtV4G87CJ5osvcXt
 VqPetiaIY22FhRYh51mGWBrMXf5bnYJMCPibHTi2wklq1cjVg0XBa6h1Jmap9IZG6esllB5pdM
 +xpQ/FJMNRwGFu33TO/0cFKBWHemvNzrTGr6GV1afrl2LuijciMBEcDVjyjwm+OiCNAJ+5blEm
 vSs=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="257565194"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 13:49:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dswEgEi5p9U9ocR5UQgp/yP1Nh5sThtcReDzqMP0F6YuYW9QmCHVa1hgJfOgSDj8M2Tuh9YdImTUtFqHU+7Fo6l+dB+nKK17FxwCBYkOG2ty4tva79h8nRMwfavNgavd/LdBUR39YeEbECYzKoIZFD4NaaesKuIYODD029h6o1azM6h8dUzSBNfzd39IKzueERwIQX2ZZVtJkrOIYWnDsvtPkwPY+wc5EvEynOYVEhmMa/JVK7zo9f04Xb0XLEU1DJ6LEmk7//DeqwxxpW90OkugRRsc6IWwWoY9ebySZ9wzkc2NK2bdFCPP2t2DzRCFxhJkTs4TQz+1HrH4MH700A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEREm6/G4ovBRc25uwuDBwpY606wS+kKKe8eerZs1r4=;
 b=JfRK9KexXhdLmF8gAeScsBfbOaQI7Tj+d4CMayIe41mlUep3NIFiOZEIuCbZEEbd42tFwuNWiJzmK3R5MSBvuSNsPBQKkOWG/SmufhrrUTcEIl/4CJSFJmyujctd2Wj1PIn4svNEVSO5pmXRNMXByw6E8w3kbm9gzVbrzToCLxOA5R6Aow1LRUGKzXgVamdCKJutyDR5kMcNu7Hbhsb8oCbERJQFP0K3MSF0ghV7XGQ/lIUZnStgCABk3KQZCBrt3w15U5AKZ3rLPhpfNrNNvPAZZAd2vVjwAzC02iHyX6xsKe00YgrUYJnWAPPKgHm/g0bDi7B8Y5iny5xMPikgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEREm6/G4ovBRc25uwuDBwpY606wS+kKKe8eerZs1r4=;
 b=N36KLJrODq5jfrL5clujW9zTQryJI1YP5LCp60aN7QWBotyXP5TVl9l40h8KaRg8zLYuPXAVH3gUegme9+mpZhkVWagW13JLpVgc0igO62DRBvbNelp5WQRacgzpKAyTopp9iDaGyOGHDW4Ch76syLNASM1DJd7RU6H3uT4dj3k=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6885.namprd04.prod.outlook.com (2603:10b6:610:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Tue, 1 Dec
 2020 05:44:31 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 1 Dec 2020
 05:44:30 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWxskIQyfbJcgpJ0mkN6+CY3xyrg==
Date:   Tue, 1 Dec 2020 05:44:30 +0000
Message-ID: <CH2PR04MB6522A475CD3F0F4D123E913BE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-3-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB652237C06F44FF3C9B6DDD11E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49654A4ECB46346E8445D8AA86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5865e20-f2a8-4299-8635-08d895bc2cbb
x-ms-traffictypediagnostic: CH2PR04MB6885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB688553B6A623AF829F0CEE9FE7F40@CH2PR04MB6885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGvprKV0DawBnhwdltlw07LbLL35e7H7XidICGuRJL0s6yY7wceNBbkFEc3mUtOlyXfFBAkUXenTLZhER8Z0GRQiYtr4Y3SBclxmFlmYIvrfCcQA75KAz7Yr7C2UeiWisIjt/HkZyR+NUTQCN88iiUiD64WJqccr6fiDpOONG6D8outM69LRPDLjUbqvE0ckn3tPGi0ui6j77UkcpVx4yBfuE2IE9xSffTVbCuSa0rSX96Yb4uZCYHYAVwvm6Ap0BzWG55ArWHmjXiYkRFNBEczTtV41X0aHrzMJC2sa8c3R9NQxzp00ZlS/nOQHIxBbK4TjVc8eHx+8+DE7WKeKMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(55016002)(9686003)(76116006)(30864003)(83380400001)(53546011)(8936002)(6506007)(7696005)(66946007)(52536014)(64756008)(66556008)(478600001)(66446008)(66476007)(4326008)(91956017)(5660300002)(2906002)(33656002)(86362001)(71200400001)(8676002)(26005)(316002)(186003)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EooiXuBt+qmLqW0diETtCdQnZsY2DC7dFbRtjNGEx0f0rQUnCka8gy1cZgbJ?=
 =?us-ascii?Q?rdsVATblkY1YdB7MLrswujcpL5jUdiWBfhrs24HXkFOw5SqS28MRXpGqJoGM?=
 =?us-ascii?Q?EVPChFDs0JMaQVmgZCVKut5vanpm+KE7jWo8eU/rvkHiCrdMWIm7KWgnIbrx?=
 =?us-ascii?Q?NFampWkWhRtIJ+8OUTuPOjI8ezN3JbY2N8TqtyNskM5QEaSv2FOCQYlen6+G?=
 =?us-ascii?Q?5VPZshIsiAAawqD4a1dxc4Ov3uVfJfVMDNJEY0MXoleDdkYxccEAGI0O+5HQ?=
 =?us-ascii?Q?0PC70hA559G7sNFzYrAh+NfuikfXJMHVjaJdswlUXaz9mMgt/yje/TDUSdCA?=
 =?us-ascii?Q?tI902x+Pgkub1xCQM6oyKL6ehuBFahmMSf2ACkB9Kp6+R7g6+frbbkrHuW6q?=
 =?us-ascii?Q?P86PkMyYqJrdSj+WrM1Jcq8CeXrbXNlDh7LdDpq76htU7I+0zk1ssdvJOgG7?=
 =?us-ascii?Q?Uuoh3Sx+H1FxBrjiglbb+N2LQNF5/UA31x51ntKUghiYfsys4YZhnRpIx/au?=
 =?us-ascii?Q?OU9hMWjV9fPbq9/tR8jfv6/hTg1GqjLei/yDlAwmEokz1EHzVc9OU/jQZ0gA?=
 =?us-ascii?Q?R1ydpx34KLHSrKxGbPqiccGH8H/+IAc75qd7uVSdonNG5oQEtfBPGlmB+y9C?=
 =?us-ascii?Q?CznDflh/KrmNxxN5eGpBGL6229chZ3bmfRcWsAUEvQMW74UHeuUO2vaR8OY+?=
 =?us-ascii?Q?9iIr8qE3bO2OjNdtLFQph22XUzzfe534fOwUzs0nynBpq5C1NIJ/MfI7kFi5?=
 =?us-ascii?Q?3/wYJaeLqqP7w4LXU9t0YZEzJOT2F9cOiT9V15VuQRvT03Y1OXr0tQl08NH8?=
 =?us-ascii?Q?lKwHwvhW06mGI1WTzAdFQ8jWCWypMcrWbknAUzvD5GtXSFdEvTOAbrWCCS3Y?=
 =?us-ascii?Q?7nW/bEGcjntXNAbKbni7h6IFshz//4zGCBUtuHcIBIum1EEdhOSNC0f2pH51?=
 =?us-ascii?Q?nVlEzfEOpqpPFbLPP2Vf0QamIJwZqp7wetb3gXlHK/dtLrb5XYXJXa+v03tl?=
 =?us-ascii?Q?Id64?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5865e20-f2a8-4299-8635-08d895bc2cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 05:44:30.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQ6gu6KJVTMNVVAuWQ7VrdfIRyHpRVDjhxtJRJYSoboeoivAoe4sLBnkHI6BkPsCfdiZTsbzFlMm0hrMFNP6bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6885
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/12/01 12:38, Chaitanya Kulkarni wrote:=0A=
[...]=0A=
>>> +	 * namespaces.=0A=
>>> +	 */=0A=
>>> +	min_zasl =3D ns->zasl =3D nvmet_zasl(queue_max_zone_append_sectors(q)=
);=0A=
>>> +=0A=
>>> +	xa_for_each(&(ns->subsys->namespaces), idx, ins) {=0A=
>>> +		struct request_queue *iq =3D ins->bdev->bd_disk->queue;=0A=
>>> +		unsigned int imax_za_sects =3D queue_max_zone_append_sectors(iq);=0A=
>>> +		u8 izasl =3D nvmet_zasl(imax_za_sects);=0A=
>>> +=0A=
>>> +		if (!bdev_is_zoned(ins->bdev))=0A=
>>> +			continue;=0A=
>>> +=0A=
>>> +		min_zasl =3D min_zasl > izasl ? izasl : min_zasl;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	ns->subsys->id_ctrl_zns.zasl =3D min_t(u8, min_zasl, bio_max_zasl);=
=0A=
>> I do not understand what bio_max_zasl is used for here, as it does not r=
epresent=0A=
>> anything related to the zoned namespaces backends.=0A=
> If we don't consider the bio max zasl then we will get the request more t=
han=0A=
> one bio can handle for zone append and will lead to bio split whichneeds =
to=0A=
> be avoided.=0A=
=0A=
Why ? zasl comes from the target backend max zone append sectors, which we=
=0A=
already know is OK and does not lead to BIO splitting for zone append. So w=
hy do=0A=
you need an extra verification against that bio_max_zasl ?=0A=
=0A=
>>> +}> +=0A=
>>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)=0A=
>>> +{=0A=
>>> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {=0A=
>>> +		pr_err("block devices with conventional zones are not supported.");=
=0A=
>>> +		return false;=0A=
>>> +	}=0A=
>> It may be better to move this test in nvmet_bdev_validate_zns_zones(), s=
o that=0A=
>> all backend zone configuration checks are together.=0A=
> Okay.=0A=
>>> +=0A=
>>> +	if (!nvmet_bdev_validate_zns_zones(ns))=0A=
>>> +		return false;=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * For ZBC and ZAC devices, writes into sequential zones must be alig=
ned=0A=
>>> +	 * to the device physical block size. So use this value as the logica=
l=0A=
>>> +	 * block size to avoid errors.=0A=
>>> +	 */=0A=
>>> +	ns->blksize_shift =3D blksize_bits(bdev_physical_block_size(ns->bdev)=
);=0A=
>>> +=0A=
>>> +	nvmet_zns_update_zasl(ns);=0A=
>>> +=0A=
>>> +	return true;=0A=
>>> +}=0A=
>>> +=0A=
>>> +/*=0A=
>>> + * ZNS related Admin and I/O command handlers.=0A=
>>> + */=0A=
>>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;=0A=
>>> +	struct nvme_id_ctrl_zns *id;=0A=
>>> +	u16 status =3D 0;=0A=
>>> +	u8 mdts;=0A=
>>> +=0A=
>>> +	id =3D kzalloc(sizeof(*id), GFP_KERNEL);=0A=
>>> +	if (!id) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * Even though this function sets Zone Append Size Limit to 0,=0A=
>>> +	 * the 0 value here indicates that the maximum data transfer size for=
=0A=
>>> +	 * the Zone Append command is indicated by the ctrl=0A=
>>> +	 * Maximum Data Transfer Size (MDTS).=0A=
>>> +	 */=0A=
>> I do not understand this comment. It does not really exactly match what =
the code=0A=
>> below is doing.=0A=
> Let me fix the code and the comment in next version.=0A=
>>> +=0A=
>>> +	mdts =3D ctrl->ops->get_mdts ? ctrl->ops->get_mdts(ctrl) : 0;=0A=
>>> +=0A=
>>> +	id->zasl =3D min_t(u8, mdts, req->sq->ctrl->subsys->id_ctrl_zns.zasl)=
;=0A=
>>> +=0A=
>>> +	status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));=0A=
>>> +=0A=
>>> +	kfree(id);=0A=
>>> +out:=0A=
>>> +	nvmet_req_complete(req, status);=0A=
>>> +}=0A=
>>> +=0A=
>>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +	struct nvme_id_ns_zns *id_zns;=0A=
>>> +	u16 status =3D 0;=0A=
>>> +	u64 zsze;=0A=
>>> +=0A=
>>> +	if (le32_to_cpu(req->cmd->identify.nsid) =3D=3D NVME_NSID_ALL) {=0A=
>>> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
>>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	id_zns =3D kzalloc(sizeof(*id_zns), GFP_KERNEL);=0A=
>>> +	if (!id_zns) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	req->ns =3D nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.ns=
id);=0A=
>>> +	if (!req->ns) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto done;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	if (!bdev_is_zoned(nvmet_bdev(req))) {=0A=
>>> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
>>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
>>> +		goto done;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	nvmet_ns_revalidate(req->ns);=0A=
>>> +	zsze =3D (bdev_zone_sectors(nvmet_bdev(req)) << 9) >>=0A=
>>> +					req->ns->blksize_shift;=0A=
>>> +	id_zns->lbafe[0].zsze =3D cpu_to_le64(zsze);=0A=
>>> +	id_zns->mor =3D cpu_to_le32(bdev_max_open_zones(nvmet_bdev(req)));=0A=
>>> +	id_zns->mar =3D cpu_to_le32(bdev_max_active_zones(nvmet_bdev(req)));=
=0A=
>>> +=0A=
>>> +done:=0A=
>>> +	status =3D nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));=0A=
>>> +	kfree(id_zns);=0A=
>>> +out:=0A=
>>> +	nvmet_req_complete(req, status);=0A=
>>> +}=0A=
>>> +=0A=
>>> +struct nvmet_report_zone_data {=0A=
>>> +	struct nvmet_ns *ns;=0A=
>>> +	struct nvme_zone_report *rz;=0A=
>>> +};=0A=
>>> +=0A=
>>> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned int =
idx,=0A=
>>> +				     void *data)=0A=
>>> +{=0A=
>>> +	struct nvmet_report_zone_data *report_zone_data =3D data;=0A=
>>> +	struct nvme_zone_descriptor *entries =3D report_zone_data->rz->entrie=
s;=0A=
>>> +	struct nvmet_ns *ns =3D report_zone_data->ns;=0A=
>>> +=0A=
>>> +	entries[idx].zcap =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity))=
;=0A=
>>> +	entries[idx].zslba =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->start));=
=0A=
>>> +	entries[idx].wp =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));=0A=
>>> +	entries[idx].za =3D z->reset ? 1 << 2 : 0;=0A=
>>> +	entries[idx].zt =3D z->type;=0A=
>>> +	entries[idx].zs =3D z->cond << 4;=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +	u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;=0A=
>> size_t ?=0A=
> Yes.=0A=
>>> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };=0A=
>>> +	struct nvme_zone_mgmt_recv_cmd *zmr =3D &req->cmd->zmr;=0A=
>>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, le64_to_cpu(zmr->slba));=
=0A=
>>> +	unsigned int nr_zones =3D bufsize / nvmet_zones_to_desc_size(1);=0A=
>> I think this is wrong since nvmet_zones_to_desc_size includes sizeof(str=
uct=0A=
>> nvme_zone_report). I think what you want here is:=0A=
>>=0A=
>> nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /=0A=
>> 	sizeof(struct nvme_zone_descriptor);=0A=
>>=0A=
>> And then you can get rid of nvmet_zones_to_desc_size();=0A=
> Yes, it doesn't need nvmet_zones_to_desc_size() anymore from v1.=0A=
>>> +	int reported_zones;Maybe there is better way.=0A=
>>> +	u16 status;=0A=
>>> +=0A=
>>> +	status =3D nvmet_bdev_zns_checks(req);=0A=
>>> +	if (status)=0A=
>>> +		goto out;=0A=
>>> +=0A=
>>> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);=0A=
>>> +	if (!data.rz) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	reported_zones =3D blkdev_report_zones(nvmet_bdev(req), sect, nr_zone=
s,=0A=
>>> +					     nvmet_bdev_report_zone_cb,=0A=
>>> +					     &data);=0A=
>>> +	if (reported_zones < 0) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto out_free_report_zones;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	data.rz->nr_zones =3D cpu_to_le64(reported_zones);=0A=
>>> +=0A=
>>> +	status =3D nvmet_copy_to_sgl(req, 0, data.rz, bufsize);=0A=
>>> +=0A=
>>> +out_free_report_zones:=0A=
>>> +	kvfree(data.rz);=0A=
>>> +out:=0A=
>>> +	nvmet_req_complete(req, status);=0A=
>>> +}=0A=
>>> +=0A=
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +	sector_t nr_sect =3D bdev_zone_sectors(nvmet_bdev(req));=0A=
>>> +	struct nvme_zone_mgmt_send_cmd *c =3D &req->cmd->zms;=0A=
>>> +	enum req_opf op =3D REQ_OP_LAST;=0A=
>>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>>> +	sector_t sect;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	sect =3D nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));=
=0A=
>>> +=0A=
>>> +	switch (c->zsa) {=0A=
>>> +	case NVME_ZONE_OPEN:=0A=
>>> +		op =3D REQ_OP_ZONE_OPEN;=0A=
>>> +		break;=0A=
>>> +	case NVME_ZONE_CLOSE:=0A=
>>> +		op =3D REQ_OP_ZONE_CLOSE;=0A=
>>> +		break;=0A=
>>> +	case NVME_ZONE_FINISH:=0A=
>>> +		op =3D REQ_OP_ZONE_FINISH;=0A=
>>> +		break;=0A=
>>> +	case NVME_ZONE_RESET:=0A=
>>> +		if (c->select_all)=0A=
>>> +			nr_sect =3D get_capacity(nvmet_bdev(req)->bd_disk);=0A=
>>> +		op =3D REQ_OP_ZONE_RESET;=0A=
>>> +		break;=0A=
>>> +	default:=0A=
>>> +		status =3D NVME_SC_INVALID_FIELD;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	ret =3D blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERN=
EL);=0A=
>>> +	if (ret)=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +=0A=
>>> +out:=0A=
>>> +	nvmet_req_complete(req, status);=0A=
>>> +}=0A=
>>> +=0A=
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +	unsigned long bv_cnt =3D req->sg_cnt;=0A=
>>> +	int op =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
>>> +	u64 slba =3D le64_to_cpu(req->cmd->rw.slba);=0A=
>>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, slba);=0A=
>>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>>> +	size_t mapped_data_len =3D 0;=0A=
>>> +	int sg_cnt =3D req->sg_cnt;=0A=
>>> +	struct scatterlist *sg;=0A=
>>> +	struct iov_iter from;=0A=
>>> +	struct bio_vec *bvec;=0A=
>>> +	size_t mapped_cnt;=0A=
>>> +	struct bio *bio;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))=0A=
>>> +		return;=0A=
>>> +=0A=
>>> +	/*=0A=
>>> +	 * When setting the ctrl->zasl we consider the BIO_MAX_PAGES so that =
we=0A=
>>> +	 * don't have to split the bio, i.e. we shouldn't get=0A=
>>> +	 * sg_cnt > BIO_MAX_PAGES since zasl on the host will limit the I/Os=
=0A=
>>> +	 * with the size that considers the BIO_MAX_PAGES.=0A=
>>> +	 */=0A=
>> What ? Unclear... You advertize max zone append as ctrl->zasl =3D min(al=
l ns max=0A=
>> zone append sectors). What does BIO_MAX_PAGES has to do with anything ?=
=0A=
> That is not true, ctrl->zasl is advertised=0A=
> min(min all ns max zone append sectors), bio_max_zasl) to avoid the=0A=
> splitting=0A=
> of the bio on the target side:-=0A=
=0A=
We already know that zasl for each NS, given by the max zone append sector =
of=0A=
the backends, are already OK, regardless of BIO_MAX_PAGES (see below).=0A=
=0A=
> =0A=
> See nvmet_zns_update_zasl()=0A=
> =0A=
> +	ns->subsys->id_ctrl_zns.zasl =3D min_t(u8, min_zasl, bio_max_zasl);=0A=
> =0A=
> Without considering the bio_max_pages we may have to set the ctrl->zasl=
=0A=
> value=0A=
> thatis > bio_max_pages_zasl, then we'll get a request that is greater=0A=
> than what=0A=
> one bio can handle, that will lead to splitting the bios, which we want t=
o=0A=
> avoid as per the comment in the V1.=0A=
> =0A=
> Can you please explain what is wrong with this approach which regulates t=
he=0A=
> zasl with all the possible namespaces zasl and bio_zasl?=0A=
=0A=
For starter, with multi-page bvecs now, I am not sure BIO_MAX_PAGES makes a=
ny=0A=
sense anymore. Next, on the target side, the max zone append sectors limit =
for=0A=
each NS guarantee that a single BIO can be used without splitting needed. T=
aking=0A=
the min  of all of them will NOT remove that guarantee. Hence I think that=
=0A=
BIO_MAX_PAGES has nothing to do in the middle of all this.=0A=
=0A=
> =0A=
> May be there is better way?=0A=
>>> +	if (!req->sg_cnt)=0A=
>>> +		goto out;=0A=
>>> +=0A=
>>> +	if (WARN_ON(req->sg_cnt > BIO_MAX_PAGES)) {=0A=
>>> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	bvec =3D kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);=0A=
>>> +	if (!bvec) {=0A=
>>> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {=0A=
>>> +		nvmet_file_init_bvec(bvec, sg);=0A=
>>> +		mapped_data_len +=3D bvec[mapped_cnt].bv_len;=0A=
>>> +		sg_cnt--;=0A=
>>> +		if (mapped_cnt =3D=3D bv_cnt)=0A=
>>> +			brhigh frequency I/O operationeak;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	if (WARN_ON(sg_cnt)) {=0A=
>>> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);=0A=
>>> +=0A=
>>> +	bio =3D bio_alloc(GFP_KERNEL, bv_cnt);=0A=
>>> +	bio_set_dev(bio, nvmet_bdev(req));=0A=
>>> +	bio->bi_iter.bi_sector =3D sect;=0A=
>>> +	bio->bi_opf =3D op;=0A=
>> The op variable is used only here. It is not necessary.=0A=
> Yes.=0A=
>>> +=0A=
>>> +	ret =3D  __bio_iov_append_get_pages(bio, &from);=0A=
>> I still do not see why bio_iov_iter_get_pages() does not work here. Woul=
d you=0A=
>> care to explain please ?=0A=
>>=0A=
> The same reason pointed out by the Johannes. Instead of calling wrapper,=
=0A=
> call the underlaying core API, since we don't care about the rest of the=
=0A=
> generic code. This also avoids an extra function callfor zone-append=0A=
> fast path.=0A=
=0A=
I am still not convinced that __bio_iov_append_get_pages() will do the righ=
t=0A=
thing as it lacks the loop that bio_iov_iter_get_pages() has.=0A=
=0A=
>>> +	if (unlikely(ret)) {=0A=
>>> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>>> +		bio_io_error(bio);=0A=
>>> +		goto bvec_free;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	ret =3D submit_bio_wait(bio);=0A=
>>> +	status =3D ret < 0 ? NVME_SC_INTERNAL : status;=0A=
>>> +	bio_put(bio);=0A=
>>> +=0A=
>>> +	sect +=3D (mapped_data_len >> 9);=0A=
>>> +	req->cqe->result.u64 =3D le64_to_cpu(nvmet_sect_to_lba(req->ns, sect)=
);=0A=
>>> +=0A=
>>> +bvec_free:=0A=
>>> +	kfree(bvec);=0A=
>>> +=0A=
>>> +out:=0A=
>>> +	nvmet_req_complete(req, status);=0A=
>>> +}=0A=
>>> +=0A=
>>> +#else  /* CONFIG_BLK_DEV_ZONED */=0A=
>>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +}=0A=
>>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +}=0A=
>>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)=0A=
>>> +{=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns)=0A=
>>> +{=0A=
>>> +	return false;=0A=
>>> +}=0A=
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +}=0A=
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +}=0A=
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +}=0A=
>>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)=0A=
>>> +{=0A=
>>> +}=0A=
>>> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
>>>=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
