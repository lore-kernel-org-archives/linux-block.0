Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A641BC433ED
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 06:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F1460FDC
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 06:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhETG0l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 02:26:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32660 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhETG0i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 02:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621491917; x=1653027917;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BfQNZXABlWjC2KuuAakBStQGSiyNc0dVA4hEPxlyGPA=;
  b=SzjPScFeahWHeLTc77ju4HkvLl+iJxI4FpkEdWJue8IZ4iKCjfMjNU8s
   GpyTf2SoRadrJALkiezYQ8JnaV5dq4KSt96alwsO7zcSd537xOXOsMIP1
   BiilfjrRb6meEOWr7GZAWKmMhPp7ArarzWS1kJQ5/411lsulavfwtisQ6
   kJ5XwDt6yn8kzem1bvMqWwl4HWLWuHLAWocfNFq+GiVtFGPKhu3t+gZ6W
   5xCrvlTMU6an/m4qL9Eaa0Qve2sUa7+fvWQphMnCXjgePmsXmiQWawLdg
   5MnIBNbxXLvl2IdeovNbRup8uZFXT+WyS5ASsc97KMRErjxMJS4+NuVwC
   w==;
IronPort-SDR: 1Rktxno8og90cmWXgF3EeG5HOHQwq3T9dcPen6iLa9tDQQdwgSNAWF4hoaqNuljauvZJY8D9mx
 VxBlTlevbhVn1Dl9QK12BMDnAOozxIi/1KpwVAjK50uax3jgmNmS6gAbNOxyGuv5d8YU+f8uKZ
 AYgrgTEl94diBK+M2jORewJJbA2sKWA3WWpSh9v4FQQek1Zb3sa9wunGBOEEwezevDC6Kxnm39
 PL9EqAGFBGjbyAMYsJksPDdIndQtzy/0rr3In+H+eNraQvwAYh7samwKxoSIkTlrynf0DvncNP
 pMc=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="280054094"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:25:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDZ2NhVvIJ9yDydQdGLzqWOI02MiJR4dswB9GL2JLThD9Fy3lzu0ot7lXlSoMMXhGYUPIZ9fHWBCs9h3lH17c+8Gafz+wAntnoznvKYB3NcZZZuN3t5/f0J7UjO2jSoy5krj04veJTwlxs2Ya1dfCWFk66WugluxzeR1dBZjq1zJixeDxPqwVLAebwrJ3I3wTWb4LZfhISWLz3b9q+3RHDX64QS2a9KklOV01PdL8xT27R3kyJcKTZxPDmexFad9juBDu3GS4Agqqjqm8itELeLhfcE/3QKqJvrqyjPLDNkAwIIK060GKVLnuKIbH5OibpPJq8mrKsg/mzJhWKdrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqlKg1guSPgOjcdbXODIEEc7W4Lx7BvotkCbvOdEwS4=;
 b=VpOwFGvfdcW2FvjpVrZf1gQaeRfW4vfwk4J/GRtspKIOBII2vUqttA4i85Zt6p/78RIzSLFTg6FYpoRR8kNO6dDl3zRsANTEyV2M4VKBwaH3WQ/1he5URIH9QAgn4WnB6E/BhTlgZJZLRKkWEU8ibpT64TI882Kil8muZ8IS+N+oUtj6ff7h3yfp5LIgLR+UTTiXA2gr85+HMDo4wim2+Qp4WkwB2rzfduFOpPvi2ShN8mZJmX0E85/e/oIfGqooMSGjcWJ4jwS+ccLdjOLn38PXfFvLZI4xdCaYblW80hvL9zFlT576ZuIZgAq6QV9Rlxse8K3LzsVJmiBOs/XlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqlKg1guSPgOjcdbXODIEEc7W4Lx7BvotkCbvOdEwS4=;
 b=TLWLMR6UIO76mggjEPiUTQpQTCwIxrTy5/bFjCEYRW7soti9EPmPp/Nwsztg1+Sv+G+YxF39W2w0cl/N1Y0ZDrYVMc4n/GPkfAKfjGFhokXcwCTHaeF0RBkeqmD7UvicBn0ayc+4IpuPhtlcx1kJpTuBTg7H9hw3yRkInkkbm5I=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6622.namprd04.prod.outlook.com (2603:10b6:5:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 06:25:16 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 06:25:16 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 10/11] dm: introduce zone append emulation
Thread-Topic: [PATCH v2 10/11] dm: introduce zone append emulation
Thread-Index: AQHXTS/HzFxr6ld09EaK3LHUbCl8CQ==
Date:   Thu, 20 May 2021 06:25:16 +0000
Message-ID: <DM6PR04MB7081B70FFD57914608B0349AE72A9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
 <20210520042228.974083-11-damien.lemoal@wdc.com>
 <68203e46-01bc-011c-ab8e-9c94ca60adce@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:d5e8:c272:2ab7:c99a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd9889b5-e5be-407a-d858-08d91b58087f
x-ms-traffictypediagnostic: DM6PR04MB6622:
x-microsoft-antispam-prvs: <DM6PR04MB66229A62007958503B87AC95E72A9@DM6PR04MB6622.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +tAdES7IZGfXyjDY9ceH8FB1lExk/c4YxiT+5RPpd5ZjCTKC6djgEZP4Q0jehejImovsQ0rDQ4xVsT41BJgJ/RRQJmm13eALJ6/mGeBKoS1eOstL49ThlslWGTvIDdbSrAqK9DPGMAh+rgXhr5tVSctMLKArks9ioIhjZZsL87dbKQ4tOjIN4XvO4JvFv1lsOcH212jgfsivM0RP9uCPdCGxhcVrnyKi33QDIHucDAOhe6Ldbq+vO7BFoVYtGl/Y419TPTNT8h//tv+QL53WPEk28olBoj2tj+G/zS5ZkVPu+QU7XOPTGXd7sOFUrRCEYZpfjjhHu9dIdkYaMf3lYW15tDnYr9CPp0kJHywjHtDKDS32eVXy1DrWCGoJ/hyCpaFcIGFcSIDuXgTXj3/1+RGA26DBGvn/KRyIHVj6oTUNi+j2OMRiRISmGs5XOM/ngM4lmoayScMpdk+xCJKNm3+2ImB8vCq6sOenYmChZ4c5pnKKzslXJTuKwur260t3ETvxwZpSvZdXnbL5e+T9cXzE21zw75eRg+BhJSRf1TsXH5QfqJRgPcMxBl3cB3yMQHpm38oE2yaOFsKvJg47n8Z5Mn/nQE87MknwM0BrgkA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(53546011)(6506007)(8936002)(122000001)(38100700002)(66476007)(66556008)(64756008)(478600001)(66446008)(8676002)(186003)(83380400001)(5660300002)(2906002)(7696005)(76116006)(66946007)(33656002)(110136005)(91956017)(86362001)(316002)(71200400001)(9686003)(52536014)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BBhDpS2ALrl5v3r+7HcypraSTJjqLkleHCQeFAtK7zc5JTzWOmFBakv7451x?=
 =?us-ascii?Q?vtaQm2As4/+h+I3FJ8PWbBvxlWGcDLT9vV5dxwbnd1E1kafFlVNctpuj7m/b?=
 =?us-ascii?Q?FNkbfTY7KXVAMQerh+upENTmK07Lucoi/3fDXT1aKT+MHzHlLyurnokjwdSr?=
 =?us-ascii?Q?/eTkFg2Ar/Ton9J+e+fGsKk4dArQbSAYo1WcuaYefz2Ful4MhWEC7Z4V7wmq?=
 =?us-ascii?Q?/vDVOraUYQWyrkO2+Jo0N7QYExQwJ1zOyhlQbdJLasxH1zmeSO9vhI5aWYUG?=
 =?us-ascii?Q?BKf0u+RQiJN+l0P350I0nYpd0YvpAIRKawgNYEYMeAy2WzfWZr5Al1GPXT56?=
 =?us-ascii?Q?tbUhqg2l52qrxJkMrqYmcQNcBd0O625DMTUfKNSnCczuK87tAYKLd6pluGpA?=
 =?us-ascii?Q?3At89lPAl7QmO+WWXoV3HL5DhxS49/AajkrAbymXa3NY7iQSBNDGIOsY3HAY?=
 =?us-ascii?Q?9OFALJ9qCZAz+AWug6hXVDiUD2I0uMJs5jGQq63rjRpxae71L8OholHQKEqf?=
 =?us-ascii?Q?do2dIAPKjXKXLpUvfEvBuD6Gii/D+5cxHtDDqgbyNOLE9vbtMjJwh7+wt8yP?=
 =?us-ascii?Q?CXNcxgPJTSh7QlEqK7orehiDR7OA7q2fZWmiFjwtYHxqB1Jv7ZUBchOtrRjS?=
 =?us-ascii?Q?SWqgTkdFPDxIgibatz5DQ9hq4BJwjJS+n2U1vxwEQcRICMu66USBGjXlktSN?=
 =?us-ascii?Q?KfPtiyuCJW8MsF0eT0iOm7DF4M0hspg73Aryu/SDjj0T4d2yTDH/29dJ9vti?=
 =?us-ascii?Q?s70UVvjAP90e/m1VIXGC1zQBvf1olHEy6JdPOV/DSoTLV1U5qtmhQbDmKymv?=
 =?us-ascii?Q?I7Y5MZfEWYSRCXTi6eiaR7CFxYtTHAEMdlOAyZp2yGKvrntQlEIfR30WXpB+?=
 =?us-ascii?Q?pK7ptT3LPfrk2rjmL6aPDw4FHw9/Q+r7o+uzirRjQB0GHuIdnepnjlxsIJFg?=
 =?us-ascii?Q?CbDw+v8rVX9LVXlY58Te5G0KfA2sUg8dkxLcTN7o3w8USrdLs1Jd7o0Pubf7?=
 =?us-ascii?Q?2M0JyPbm4Nu5I/5q97AKzfoXr1WhpfsBxPKweUnw5+zsVDPD0jurXz7Wyy09?=
 =?us-ascii?Q?XrH35c0jNSIzXyXY+pkhafmMw4iN9kmbgdfMIQMGAOWqBgNYXw/IlCz37YXb?=
 =?us-ascii?Q?NdKCENRMcLg1aWYoP3g7D2PSVoOycf0FG6mI/kRVoGlgbF4jPG6gBO9Sdl/A?=
 =?us-ascii?Q?eVAXXq2yIRi5b+dik5vaNa9EVT8f+cF6Vq1w7z4k+rguPn69GKxePhLx3wOK?=
 =?us-ascii?Q?M0i44Dvl0KyFqXiT6X6x2mEbmSRO/FF4lH/M/w0Aqc9m2kfIsnjTtJNKj6bJ?=
 =?us-ascii?Q?8QBKtzvah4nySPUPY/mTcnoSpjCmKsFgj2DW675tMWhSy1TECZ3glpI2tve8?=
 =?us-ascii?Q?2UAYz+dFFqXuQrPv5UTS2rjTeq0t+RAF234FCRMN4uqOJuQ6Aw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9889b5-e5be-407a-d858-08d91b58087f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 06:25:16.1775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4J/XWjIiod9Z98o5EIWmood+/g8m5mKW29D0MGu5gdsnOt/F+PomYImZZC/DzRrL0TTZTcjk0oi+T+Q0wa4PHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6622
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/20 15:10, Hannes Reinecke wrote:=0A=
[...]=0A=
>> +/*=0A=
>> + * First phase of BIO mapping for targets with zone append emulation:=
=0A=
>> + * check all BIO that change a zone writer pointer and change zone=0A=
>> + * append operations into regular write operations.=0A=
>> + */=0A=
>> +static bool dm_zone_map_bio_begin(struct mapped_device *md,=0A=
>> +				  struct bio *orig_bio, struct bio *clone)=0A=
>> +{=0A=
>> +	sector_t zone_sectors =3D blk_queue_zone_sectors(md->queue);=0A=
>> +	unsigned int zno =3D bio_zone_no(orig_bio);=0A=
>> +	unsigned long flags;=0A=
>> +	bool good_io =3D false;=0A=
>> +=0A=
>> +	spin_lock_irqsave(&md->zwp_offset_lock, flags);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * If the target zone is in an error state, recover by inspecting the=
=0A=
>> +	 * zone to get its current write pointer position. Note that since the=
=0A=
>> +	 * target zone is already locked, a BIO issuing context should never=
=0A=
>> +	 * see the zone write in the DM_ZONE_UPDATING_WP_OFST state.=0A=
>> +	 */=0A=
>> +	if (md->zwp_offset[zno] =3D=3D DM_ZONE_INVALID_WP_OFST) {=0A=
>> +		unsigned int wp_offset;=0A=
>> +		int ret;=0A=
>> +=0A=
>> +		md->zwp_offset[zno] =3D DM_ZONE_UPDATING_WP_OFST;=0A=
>> +=0A=
>> +		spin_unlock_irqrestore(&md->zwp_offset_lock, flags);=0A=
>> +		ret =3D dm_update_zone_wp_offset(md, zno, &wp_offset);=0A=
>> +		spin_lock_irqsave(&md->zwp_offset_lock, flags);=0A=
>> +=0A=
>> +		if (ret) {=0A=
>> +			md->zwp_offset[zno] =3D DM_ZONE_INVALID_WP_OFST;=0A=
>> +			goto out;=0A=
>> +		}=0A=
>> +		md->zwp_offset[zno] =3D wp_offset;=0A=
>> +	} else if (md->zwp_offset[zno] =3D=3D DM_ZONE_UPDATING_WP_OFST) {=0A=
>> +		DMWARN_LIMIT("Invalid DM_ZONE_UPDATING_WP_OFST state");=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	switch (bio_op(orig_bio)) {=0A=
>> +	case REQ_OP_WRITE_ZEROES:=0A=
>> +	case REQ_OP_WRITE_SAME:=0A=
>> +	case REQ_OP_WRITE:=0A=
>> +		break;=0A=
>> +	case REQ_OP_ZONE_RESET:=0A=
>> +	case REQ_OP_ZONE_FINISH:=0A=
>> +		goto good;=0A=
>> +	case REQ_OP_ZONE_APPEND:=0A=
>> +		/*=0A=
>> +		 * Change zone append operations into a non-mergeable regular=0A=
>> +		 * writes directed at the current write pointer position of the=0A=
>> +		 * target zone.=0A=
>> +		 */=0A=
>> +		clone->bi_opf =3D REQ_OP_WRITE | REQ_NOMERGE |=0A=
>> +			(orig_bio->bi_opf & (~REQ_OP_MASK));=0A=
>> +		clone->bi_iter.bi_sector =3D=0A=
>> +			orig_bio->bi_iter.bi_sector + md->zwp_offset[zno];=0A=
>> +		break;=0A=
>> +	default:=0A=
>> +		DMWARN_LIMIT("Invalid BIO operation");=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	/* Cannot write to a full zone */=0A=
>> +	if (md->zwp_offset[zno] >=3D zone_sectors)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	/* Writes must be aligned to the zone write pointer */=0A=
>> +	if ((clone->bi_iter.bi_sector & (zone_sectors - 1)) !=3D md->zwp_offse=
t[zno])=0A=
>> +		goto out;=0A=
>> +=0A=
>> +good:=0A=
>> +	good_io =3D true;=0A=
>> +=0A=
>> +out:=0A=
>> +	spin_unlock_irqrestore(&md->zwp_offset_lock, flags);=0A=
> =0A=
> I'm not happy with the spinlock. Can't the same effect be achieved with =
=0A=
> some clever READ_ONCE()/WRITE_ONCE/cmpexch magic?=0A=
> Especially as you have a separate 'zone lock' mechanism ...=0A=
=0A=
hmmm... Let me see. Given that what the bio completion is relatively simple=
, it=0A=
may be possible. With more coffee, I amy be able to come up with something =
clever.=0A=
=0A=
> =0A=
>> +=0A=
>> +	return good_io;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Second phase of BIO mapping for targets with zone append emulation:=
=0A=
>> + * update the zone write pointer offset array to account for the additi=
onal=0A=
>> + * data written to a zone. Note that at this point, the remapped clone =
BIO=0A=
>> + * may already have completed, so we do not touch it.=0A=
>> + */=0A=
>> +static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,=0A=
>> +					struct bio *orig_bio,=0A=
>> +					unsigned int nr_sectors)=0A=
>> +{=0A=
>> +	unsigned int zno =3D bio_zone_no(orig_bio);=0A=
>> +	blk_status_t sts =3D BLK_STS_OK;=0A=
>> +	unsigned long flags;=0A=
>> +=0A=
>> +	spin_lock_irqsave(&md->zwp_offset_lock, flags);=0A=
>> +=0A=
>> +	/* Update the zone wp offset */=0A=
>> +	switch (bio_op(orig_bio)) {=0A=
>> +	case REQ_OP_ZONE_RESET:=0A=
>> +		md->zwp_offset[zno] =3D 0;=0A=
>> +		break;=0A=
>> +	case REQ_OP_ZONE_FINISH:=0A=
>> +		md->zwp_offset[zno] =3D blk_queue_zone_sectors(md->queue);=0A=
>> +		break;=0A=
>> +	case REQ_OP_WRITE_ZEROES:=0A=
>> +	case REQ_OP_WRITE_SAME:=0A=
>> +	case REQ_OP_WRITE:=0A=
>> +		md->zwp_offset[zno] +=3D nr_sectors;=0A=
>> +		break;=0A=
>> +	case REQ_OP_ZONE_APPEND:=0A=
>> +		/*=0A=
>> +		 * Check that the target did not truncate the write operation=0A=
>> +		 * emulating a zone append.=0A=
>> +		 */=0A=
>> +		if (nr_sectors !=3D bio_sectors(orig_bio)) {=0A=
>> +			DMWARN_LIMIT("Truncated write for zone append");=0A=
>> +			sts =3D BLK_STS_IOERR;=0A=
>> +			break;=0A=
>> +		}=0A=
>> +		md->zwp_offset[zno] +=3D nr_sectors;=0A=
>> +		break;=0A=
>> +	default:=0A=
>> +		DMWARN_LIMIT("Invalid BIO operation");=0A=
>> +		sts =3D BLK_STS_IOERR;=0A=
>> +		break;=0A=
>> +	}=0A=
>> +=0A=
>> +	spin_unlock_irqrestore(&md->zwp_offset_lock, flags);=0A=
> =0A=
> You don't need the spinlock here; using WRITE_ONCE() should be sufficient=
.=0A=
=0A=
If other references to zwp_offset use READ_ONCE(), no ?=0A=
=0A=
[...]=0A=
>> +void dm_zone_endio(struct dm_io *io, struct bio *clone)=0A=
>> +{=0A=
>> +	struct mapped_device *md =3D io->md;=0A=
>> +	struct request_queue *q =3D md->queue;=0A=
>> +	struct bio *orig_bio =3D io->orig_bio;=0A=
>> +	unsigned long flags;=0A=
>> +	unsigned int zno;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * For targets that do not emulate zone append, we only need to=0A=
>> +	 * handle native zone-append bios.=0A=
>> +	 */=0A=
>> +	if (!dm_emulate_zone_append(md)) {=0A=
>> +		/*=0A=
>> +		 * Get the offset within the zone of the written sector=0A=
>> +		 * and add that to the original bio sector position.=0A=
>> +		 */=0A=
>> +		if (clone->bi_status =3D=3D BLK_STS_OK &&=0A=
>> +		    bio_op(clone) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
>> +			sector_t mask =3D (sector_t)blk_queue_zone_sectors(q) - 1;=0A=
>> +=0A=
>> +			orig_bio->bi_iter.bi_sector +=3D=0A=
>> +				clone->bi_iter.bi_sector & mask;=0A=
>> +		}=0A=
>> +=0A=
>> +		return;=0A=
>> +	}=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * For targets that do emulate zone append, if the clone BIO does not=
=0A=
>> +	 * own the target zone write lock, we have nothing to do.=0A=
>> +	 */=0A=
>> +	if (!bio_flagged(clone, BIO_ZONE_WRITE_LOCKED))=0A=
>> +		return;=0A=
>> +=0A=
>> +	zno =3D bio_zone_no(orig_bio);=0A=
>> +=0A=
>> +	spin_lock_irqsave(&md->zwp_offset_lock, flags);=0A=
>> +	if (clone->bi_status !=3D BLK_STS_OK) {=0A=
>> +		/*=0A=
>> +		 * BIOs that modify a zone write pointer may leave the zone=0A=
>> +		 * in an unknown state in case of failure (e.g. the write=0A=
>> +		 * pointer was only partially advanced). In this case, set=0A=
>> +		 * the target zone write pointer as invalid unless it is=0A=
>> +		 * already being updated.=0A=
>> +		 */=0A=
>> +		if (md->zwp_offset[zno] !=3D DM_ZONE_UPDATING_WP_OFST)=0A=
>> +			md->zwp_offset[zno] =3D DM_ZONE_INVALID_WP_OFST;=0A=
>> +	} else if (bio_op(orig_bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
>> +		/*=0A=
>> +		 * Get the written sector for zone append operation that were=0A=
>> +		 * emulated using regular write operations.=0A=
>> +		 */=0A=
>> +		if (WARN_ON_ONCE(md->zwp_offset[zno] < bio_sectors(orig_bio)))=0A=
>> +			md->zwp_offset[zno] =3D DM_ZONE_INVALID_WP_OFST;=0A=
>> +		else=0A=
>> +			orig_bio->bi_iter.bi_sector +=3D=0A=
>> +				md->zwp_offset[zno] - bio_sectors(orig_bio);=0A=
>> +	}=0A=
>> +	spin_unlock_irqrestore(&md->zwp_offset_lock, flags);=0A=
>> +=0A=
> =0A=
> Similar comments to the spinlock here.=0A=
=0A=
OK.=0A=
=0A=
Thanks for the review.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
