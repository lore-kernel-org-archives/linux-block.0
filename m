Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34036C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 09:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F4E20850
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 09:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="CKMAZQ2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F4E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbeLGJNC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:13:02 -0500
Received: from mail-eopbgr730055.outbound.protection.outlook.com ([40.107.73.55]:38992
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbeLGJNB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 04:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xROTJtYPcOEnOQ8JBp/k5b984ONAXib8/yfTP9VXK3U=;
 b=CKMAZQ2NH/FNBNHe3AQ3xAVjr2Bb9vaIgqPSvpED47nf79QoASp0giAaYC3JxLe/P41Vlzi8u8IbJVMts7TNh9P+KHCw7wIsgAZbOp6eFV8l1L2Tlxj+qPBzYqVyN2/6T+wQDzDikwhsP8A6ptI246BzhR34U79J96mXAnreNl4=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB6235.namprd06.prod.outlook.com (20.178.226.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Fri, 7 Dec 2018 09:12:57 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c841:4bd1:3b20:e7ea]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c841:4bd1:3b20:e7ea%4]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 09:12:56 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH 2/2] lightnvm: pblk: Ensure that bio is not freed on
 recovery
Thread-Topic: [PATCH 2/2] lightnvm: pblk: Ensure that bio is not freed on
 recovery
Thread-Index: AQHUjXuU53X24u9Ju0aGLrIsj6MreaVy/xyA
Date:   Fri, 7 Dec 2018 09:12:56 +0000
Message-ID: <A790DB4E-9DD0-40CE-94D9-631E0C28D2D6@cnexlabs.com>
References: <20181206154559.5642-1-igor.j.konopko@intel.com>
 <20181206154559.5642-2-igor.j.konopko@intel.com>
In-Reply-To: <20181206154559.5642-2-igor.j.konopko@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB6235;6:pf5DwFXkr0AkxjOEPP+AxHJFqEx7kEVslWQCar993XDs0D2LZseNr+y7Vx94vAwrnrBN5OiASzyBIP/iJmy1MBqksHAuMyhZRGMKum4xxR5yrSOohCiMlPccP/AVp6n38NdIwuP5BSwajypg0m1f5zSWr4yK6vZgsgqOppm9ZHKWrI7O+yGOnVyrRRf3HJg4jCDd0BxcD8gLB529ZLoycogISOv5DtCCxabIhD6XWbhbLynhOiLf0gyASUDpCvTS18ecmwlBUK0Ckm12IeHItmKNYjGxMtWMa0vPx6z3RLrkYN/3IruFrQIFGObXbEfAL8RgOmwgSqxJ9kMnJVSJDSlW4y1uFiPdqKDomBzbYmS+SoApIXQ/iYXq27NrvRNYC5w7z5v2x3KrVveTEIEorsmA/5AXkFQqNqXpO1PREYe3PpvL+FCDoQNrC6NpST4uFFssVMaXBjPvotpByKAl3w==;5:SzQIWdio8Pi4k8bZTXRcsn7XEmzf0K1TLA4B3WqSa5aXP8Gpf34XI7XpJLMw7Sliy3zKdcxkzigochHGapDlCvCc05gPSJSFW8F7NMkOEB2eeT3+jjxeWpc9/prdFY16+DMdC1IW3n/iZNvQBa4UrfFw22yOwizSXzSaUy3oSLE=;7:sZHKFtikL7Z/UjOf5rwNVyR697akn1wNhlwv3x9r/E2P4Db9kDVrbEJqCj8oyS4g3kSoZMlx052R9TU/M/lkjqqnz9GwObUK5Ec2h9cEb5CLOLl3+CCf5f/41Pkbfgv3iGa6mbAAsUFz2Dj31enMag==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39840400004)(346002)(199004)(189003)(71200400001)(4326008)(71190400001)(53936002)(6246003)(105586002)(106356001)(66066001)(107886003)(5660300001)(478600001)(68736007)(256004)(99936001)(186003)(82746002)(7736002)(6512007)(102836004)(14454004)(26005)(305945005)(76176011)(6506007)(99286004)(8936002)(8676002)(6916009)(476003)(97736004)(81166006)(33656002)(81156014)(6486002)(25786009)(54906003)(316002)(3846002)(6116002)(83716004)(486006)(11346002)(2616005)(36756003)(446003)(6436002)(2906002)(229853002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB6235;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 1780a2de-bd41-4ee1-2979-08d65c242d39
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM6PR06MB6235;
x-ms-traffictypediagnostic: DM6PR06MB6235:
x-microsoft-antispam-prvs: <DM6PR06MB623552E6760B84701BF480D0BAAA0@DM6PR06MB6235.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501520)(4983020)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB6235;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB6235;
x-forefront-prvs: 0879599414
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6QwJq4lhmY6hum/FiQ5QYBEh7s/8zscnJZH5KJJN2ad7DLh5sqLhi0rgSD+XSgOGfveEgS9zAYihDnI65DwSWZCdhDxhjLMDYUcDo+MhGscj/8UDHCspp3SgoAUnk+EoFJ3dD8rsPu3cBwIxgxtnYhgoMyLk6EnPsKtlI8+F7kgXa8AZUNridrjdvcCzfuZGtO1UHCDEj6WTvctd5YP6RkDIjgCAsSIjo3hcXiD4V6yvUsKIi//uruSSmvDr3OKw3jnio1Z7dm3J30jH2Vw+EMRWaZbRY0uCE2McaqdhcZxe9V5ZRN4lW0C6/neWqaB/BTGOsB9jjAiqheUvRkaW4PDOWqTiPxLF0ZFEiT5bWu0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_92B95E6C-B0B4-4175-85C2-50F321128559";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1780a2de-bd41-4ee1-2979-08d65c242d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 09:12:56.5396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6235
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Apple-Mail=_92B95E6C-B0B4-4175-85C2-50F321128559
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 6 Dec 2018, at 16.45, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> When we are using PBLK with 0 sized metadata during recovery
> process we need to reference a last page of bio. Currently
> KASAN reports use-after-free in that case, since bio is
> freed on IO completion.
>=20
> This patch adds addtional bio reference to ensure, that we
> can still use bio memory after IO completion. It also ensures
> that we are not reusing the same bio on retry_rq path.
>=20
> Reported-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-recovery.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 009faf5db40f..3fcf062d752c 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -376,12 +376,14 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
> 		rq_ppas =3D pblk->min_write_pgs;
> 	rq_len =3D rq_ppas * geo->csecs;
>=20
> +retry_rq:
> 	bio =3D bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
> 	if (IS_ERR(bio))
> 		return PTR_ERR(bio);
>=20
> 	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> 	bio_set_op_attrs(bio, REQ_OP_READ, 0);
> +	bio_get(bio);
>=20
> 	rqd->bio =3D bio;
> 	rqd->opcode =3D NVM_OP_PREAD;
> @@ -394,7 +396,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	if (pblk_io_aligned(pblk, rq_ppas))
> 		rqd->is_seq =3D 1;
>=20
> -retry_rq:
> 	for (i =3D 0; i < rqd->nr_ppas; ) {
> 		struct ppa_addr ppa;
> 		int pos;
> @@ -417,6 +418,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	if (ret) {
> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
> 		bio_put(bio);
> +		bio_put(bio);
> 		return ret;
> 	}
>=20
> @@ -428,19 +430,25 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
>=20
> 		if (padded) {
> 			pblk_log_read_err(pblk, rqd);
> +			bio_put(bio);
> 			return -EINTR;
> 		}
>=20
> 		pad_distance =3D pblk_pad_distance(pblk, line);
> 		ret =3D pblk_recov_pad_line(pblk, line, pad_distance);
> -		if (ret)
> +		if (ret) {
> +			bio_put(bio);
> 			return ret;
> +		}
>=20
> 		padded =3D true;
> +		bio_put(bio);
> 		goto retry_rq;
> 	}
>=20
> 	pblk_get_packed_meta(pblk, rqd);
> +	bio_put(bio);
> +
> 	for (i =3D 0; i < rqd->nr_ppas; i++) {
> 		struct pblk_sec_meta *meta =3D pblk_get_meta(pblk, =
meta_list, i);
> 		u64 lba =3D le64_to_cpu(meta->lba);
> --
> 2.17.1

Both patches in this series look good, but since they are fixes to the
patches you sent for this window, I would suggest that you merge them
into the original set and resend. We can then test the series again and
make sure there are no regressions from V1.

Matias: would this work for you? The current series in your branch is
broken as is.

Thanks,
Javier


--Apple-Mail=_92B95E6C-B0B4-4175-85C2-50F321128559
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlwKOZcACgkQIX4xUKFR
nnRb1RAAy7oX9MUTdURdFVk+jiqqxgXqu/EFeNRlX+BjhzgyaKpvxMncMR/OchRU
fDupoh1Ym0UMg/+FL6XU2RQJoLGx7QADpOiVFjccb8m0s3zzqAEk05suijlm+CaV
lGefQpyTSjhFYzWELXGMDOBKtTlpWIrkS0lG42JvSDkcqo58hIKXFMmL9e33zz/F
IDafa4kY14WLxI+Rm5dSTAurVXtS+3vVXsNpkkSD16+ONOVbzdB1dZ+z6bs0QsAq
vn22H90t+K0bdMFgoAhLAsR7uBdLFZ52OvFBesYyFuk3CkKjXTdR3UOzL/d06SoC
RAYWI4AWEwuKdhfIlRucDlpPXQNibJEstwAy5FIeaOz69oKV8HdtEniWr9Sw9JQ7
+i6/3xq+wjKG9Bc7oAZrZR2zfgt0pX5GFw4k0iogKiu43j4ADvntMBS1LWZExwC7
iix5foHUYf8EUcvN0B+hvyhiaIOmtR0iYXj/tixID7L9G4olzXjBprZDdXJrzm0/
8xCXHlSChaqLWApem4v7wZXs02bXAo4myv12/aoyVET1I533lXJ5tszIUjdpWD+/
ncuaHDGMlJAlN2rNE7NGOT1bw01jZgRqSQVJ6/51tZ7NJbx3bKC/NulIutkmG6hK
Fu08ShP9Y8XqXGIanXE6NNH1BmLtmd0lsIBkypJc1sqDa6DTh8g=
=WASw
-----END PGP SIGNATURE-----

--Apple-Mail=_92B95E6C-B0B4-4175-85C2-50F321128559--
