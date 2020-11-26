Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFA9C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E46B20DD4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hsui4iG0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uDJnW/ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgKZIjF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:39:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48289 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKZIjF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606379944; x=1637915944;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TzY2mD4vhDc7UzTHGCdNXFNoD7bf/NbYJClRRfxVxdo=;
  b=hsui4iG0Wwsh+tt/iLA/Pz547j1QmfkRsR5+IrbDmPjrYJZcDvUzYcD5
   6EsWozgNb3yZcLHCdl+90AVx3TszDdcfGrqHaWWN9/RqHjFtlEA5zDS7F
   9OY8T6XiP6XO+/0YTHGeTnj93/nvupvG7MzpkfkUhPxRQ344BT9V+8rvb
   1i+yK/dcwQJiB1ZnyytbmssVJ5RR+REz+umzt5msFlsNWKE1eFrx6uY8I
   c+lU9t1hOhHZw1MHS3SGLDBUYmwVjoDubOBlAX0KsCmks1FHJ8pRJ8w/i
   oVd+xYV9NrJX14UCi/JcjrbbZlXSUI+1/MrfcUpHQ5wWECKoqCXPQhEDb
   g==;
IronPort-SDR: GHaeoPkShx6TwwT4UFSgrf9ZIKiKdyJWL4/nPXXYojCFYSz3/8ceHgmWUZMp1wMltg4AEnR0ft
 o2BfLJLNiu+uRnzDFHmanNPWoIC9IdpyzmvQRHEV/TGlg+hEKZgPHuzhgXEzeCqQIRQcRm2az5
 bnj9OMTsEIc5Ema0+1h+N+5se4ciag863407H653FykYTFqZ1z9Yf4wQIRY8j/8os/QM5lhZe/
 SWv+dt2cgW9UmURQSj59oe0tXr8QaR71rpfHhy5h/i/W7JS7CSun+gFUXMLiSSqblvjcwOKC+9
 k+4=
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; 
   d="scan'208";a="153612223"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 16:39:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqHHSHMRVvm5D0BjLya3aN9+v4vLVPiQ9ZhM4U9h2EmpqOElkFN03Z7bPlOnvJKUs516JMB/NI2Fa5NYWR2jXoDgZ/haLf4aQw1gkze3z8HctMlW+8mtq03b6veyIXlJvRvw3G5zuRJrw5M+J5xfsgcS4dv848TicFt/zgWeTSPzg8dpCSu3ZOwT2Khn+b5GGkR+FnPe1g2gBvRIvVgQKJJ4uutQToTPgSRAt2i/wGXcVlCqa2swH20IhfbyT3xzxLRpzuaq1XWr0peRNZkCKmZSYmhyymaGrAofjiAuaupVs2xXV05iYZIO5wMXUqpadwBRgmJo5AdHClvow/ZmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYB0KMub6HtIrBCk5Hg4IuVtIuGUcPrEWJhHQ7BJBLU=;
 b=WOZYJZUrQwlI/srFa+lUgrzTlw2ATsYm5g8DoaMnZx3hzWmNuTq2n8jk6LZFX15glncB2lI/yD9OPtzZWtsfunKMPpJjAIrl9SkPeNimMYfqIsXWiVfM6DytN72TxoWR7yOdHXVstobwFwO51EadA/jNc3vL0t4PWr+s1r9ihPIHcPy8SEdd1Bjh13iV2WDV+FIdHLgLOIM3+uSTrER2fuho+GHr6m1GpGzV3wcPKWYBZY2uFBnv191/+/NVEN+xE0m9cHKs9ly8P2CjwGcHpenZ6uOVjfVrXQkP5ImtAl9q0zvtaefH9GlIYv+LA4s1LaEKmHo2u75fyuocX2RLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYB0KMub6HtIrBCk5Hg4IuVtIuGUcPrEWJhHQ7BJBLU=;
 b=uDJnW/hayY4s9poSKouj6saoOaN5lzwDWgsssgZjetXpylsPwLqj0KUMVzzRT89kAoV5glIHW4DTIeCfTe42Cj5mCgv2PeoYAThiK0D1MmBw6YoEVwSCXn5DjdxE5izx752N+vINfKVOpBZvCBS2Ndlse9CG9jbDRukzrRH6MEY=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7095.namprd04.prod.outlook.com (2603:10b6:610:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 08:39:02 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 08:39:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Thread-Topic: [PATCH 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Thread-Index: AQHWw53EeG9JwoSL4EOKKtisWWw/Bw==
Date:   Thu, 26 Nov 2020 08:39:02 +0000
Message-ID: <CH2PR04MB65225D95C5239E3936711B8AE7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-6-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01e0e922-5e8b-40c4-a728-08d891e6ba25
x-ms-traffictypediagnostic: CH2PR04MB7095:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB70953798ED572CDE66D5C343E7F90@CH2PR04MB7095.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ekT4xmDU4es+HJJuQ+x/+UnvI4nztbz1Eu1EXUDKT8OhXDTUFCT5NA2b3nrAepDOcodTBUn2gk3EIc/4jHWZTECydp+67r5X6aALVziIfk4QZRM7QMtEZcxRHF7gUCp2sHxUWIsO6sWV9u61PFnDk/9PAbCcaGZSpRgKcGXp4kD8OopR4/dURovl15kc5LsmygwZ83UMkFRj+3juuLz4iJy2c8v1yVF4AIZ7kolOK2rkqeJ0GSaHVGqwM5jR88TZaetqxxQt+B7oxMNl9FPXpiCkptmTpD+753fCi5sdgBEGRVNQ2cBvEObKPZs2gt3e+yG7JTDvR+875KepcE+n6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(86362001)(66946007)(6506007)(7696005)(83380400001)(53546011)(76116006)(33656002)(54906003)(66556008)(64756008)(66476007)(2906002)(71200400001)(186003)(66446008)(5660300002)(110136005)(478600001)(91956017)(4326008)(8936002)(8676002)(55016002)(9686003)(316002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jQDiCenMO1J39rucvjMOa5ddr5g9wi8CiuckmUE6yRrzw+23DaB2Xl2bCpW8?=
 =?us-ascii?Q?6Z9v6fVpejHqvUF1VK3muUzkAgKDNNeRfNM7ECmcbXUgGBnGNaYateigl5sw?=
 =?us-ascii?Q?Q5tBqTMfvUkMgZ2B0ILG1Qxi5EuCu/I4VNY+CySetxplhvvfM2Uxjh6KnCyJ?=
 =?us-ascii?Q?DTFgZJfWZ2M/1s2Fz0R5eplSXdKCr9smdv6qpC0TjPvHzarSNYdXIJ9MZ8sz?=
 =?us-ascii?Q?LQUEHJspkcqOWhUmV8UZHJkMWOVp1XmDudwjddYXpS/nG7IK8gQvS0qAAGrJ?=
 =?us-ascii?Q?RMRGhfny+rZdu+3Gnz2kKZa7sUyJHiGkVwfgIt+/FtEbATvgvHx0neG7mRRh?=
 =?us-ascii?Q?lLu7Sm8z76VW8+teCPIzKW6uLPvJ7v3DzGh+QlCBjMW2ciXstcK+wWYNOXa1?=
 =?us-ascii?Q?hRnoMq9yR5Q1MKuo6h4Z3JdYa8cwQrOdgRWH5DqWyQgLNAmeh9WPCince5Ca?=
 =?us-ascii?Q?qKkM7gkBVkM0yHZTLvuizB/sSp+zVarMwEtmacD+jW5WIkAd1v6bULc5scIV?=
 =?us-ascii?Q?Fw9798fMgT6iDY00/pN5KVMOM9HH8t7N5xnzWEGkUc2gz6jybbweaww6G9wY?=
 =?us-ascii?Q?GbV131W1sRWyugxjNut/ZsWrCeELpIph/jbUJx9yGg6kNuoCA+YJwgUeWsyX?=
 =?us-ascii?Q?m4zcyuD0dvogfT+As9TGHfdnQAinm4zGqn7modCwnSP+SgzhYx4eLvKy0IIw?=
 =?us-ascii?Q?mwgaEfTR7fSyptK5V2tofCqEjBb7r+1vBjS00hfzRglCspkAgMapXGZcL4Ha?=
 =?us-ascii?Q?NfIyyCU8VDxlGltdEaTJbiqS5itmyys/ygCK6vo8OhdrsyVC5JlCoAJxzkYH?=
 =?us-ascii?Q?+391N0ZkmT+4cQ1Pn+4z9hZq6Z/1cWoEeeUsKo8KPNMfzti1ht/kRgKO8s46?=
 =?us-ascii?Q?/c6zRDnhphhY2VFge2G5Yw4RC4UD3D8JIl4VKvFtpKQpBCzcCmc6ztUPLpu1?=
 =?us-ascii?Q?cxkbY81gl4oMCytbVP0/WSSgXrcTWfV7sY2LEu8HMPAXGh2vunOKodZO4fVp?=
 =?us-ascii?Q?OGYbx3nCX6VT+JIF1DQyRoIbpujuXyRaxu8UodcRiiqs+fYl8Rq7JKNUEm28?=
 =?us-ascii?Q?nmipj0if?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e0e922-5e8b-40c4-a728-08d891e6ba25
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 08:39:02.3046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gR5qdFtacdsP3N65dyB7IygjMZQ0xW0TlaKyRld13PQUtIWHXaKee5LQDcKfFn8fQsyVE6qMnTfTwG5euzTvaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7095
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/26 11:42, Chaitanya Kulkarni wrote:=0A=
> Update the nvmet_execute_identify() such that it can now handle=0A=
> NVME_ID_CNS_CS_CTRL when identify.cis is set to ZNS. This allows=0A=
> host to identify the support for ZNS.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/nvme/target/admin-cmd.c | 4 ++++=0A=
>  1 file changed, 4 insertions(+)=0A=
> =0A=
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c=0A=
> index d4fc1bb1a318..e7d2b96cda6b 100644=0A=
> --- a/drivers/nvme/target/admin-cmd.c=0A=
> +++ b/drivers/nvme/target/admin-cmd.c=0A=
> @@ -650,6 +650,10 @@ static void nvmet_execute_identify(struct nvmet_req =
*req)=0A=
>  		return nvmet_execute_identify_ns(req);=0A=
>  	case NVME_ID_CNS_CTRL:=0A=
>  		return nvmet_execute_identify_ctrl(req);=0A=
> +	case NVME_ID_CNS_CS_CTRL:=0A=
> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)=0A=
> +			return nvmet_execute_identify_cns_cs_ctrl(req);=0A=
=0A=
This function is defined in zns.c, but it could be used for other NS types =
than=0A=
ZNS, no ?=0A=
=0A=
> +		break;=0A=
>  	case NVME_ID_CNS_NS_ACTIVE_LIST:=0A=
>  		return nvmet_execute_identify_nslist(req);=0A=
>  	case NVME_ID_CNS_NS_DESC_LIST:=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
