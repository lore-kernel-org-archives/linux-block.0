Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B07C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 12:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68246213A2
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 12:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="pHA9k0wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68246213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeK0Xzv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:55:51 -0500
Received: from mail-eopbgr790059.outbound.protection.outlook.com ([40.107.79.59]:45077
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729407AbeK0Xzv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 18:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKX6pLnihQFDoPvpXIaGWZinaTvYZnqPBVdlAxjqoMU=;
 b=pHA9k0wd95xqXoGTEB5rHGhXttJ769ugTjCENk6qDpNpN8Zeai2zrQ/1JQYenAmA85bhUNDC6G6j2Z7eS59tEBH5wARrKX0wl/TQp/G6tlBbVh6ADpagiDOc9uI4ZG3YKLuO+YVbNAIyFB2hApBimagwh09gKSxuiRt3SS/wzG4=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB4409.namprd06.prod.outlook.com (20.176.108.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 12:57:54 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c450:96ae:b322:78c7%4]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 12:57:54 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     Hua Su <suhua.tanke@gmail.com>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: adjust the position of the lock
Thread-Topic: [PATCH] lightnvm: pblk: adjust the position of the lock
Thread-Index: AQHUhfRSbN5Xcbn6ZEKx/nEy0nBdB6VjlbWA
Date:   Tue, 27 Nov 2018 12:57:54 +0000
Message-ID: <F75BC3C7-FACE-4C04-A9BE-5A3AA25D3466@cnexlabs.com>
References: <20181127015309.2374-1-suhua.tanke@gmail.com>
In-Reply-To: <20181127015309.2374-1-suhua.tanke@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB4409;6:IMKq6H64+kWxxQhxAd8YcrFjZmYuFQstKV3Gj25Ww9fBUdultIe4l/Gciad9h9ljG740dWi4IOXy1AyzGmZMNU6CM3E46VLl+Yt1rwb6T9Vr4QgnMbP76HAq75XlT5FeCLsq4aCDNUKw3Y8hMyUKdO9yS5JdIKM1Bz62/6t8fCUz8HCQrYN+6LtQqNav7e4vqbjmxHqHqj1kbIjN1GAKp0mBi0jZrgwj09qFBFvbnHUGZt1brPxJdIQi9BRd1p1r0JPsMjh5GUw9lM5oaCGirlJ2Xv4zPtt1nrO9nq1eGyNwJww+Shj2HFbbtZMmtrXFir8PnWFpdz2t7dL+/5SV2hGMiD3MP60co6uEN5Zsx3tL5KBBoXq36i+4XQ3pp3V+0JhcAbMCA2SHvOnnWIC8wnB93RHne+6S1w1NGzjb1t3gAKuBwHYDum1p6rjNp9sdSl8rEDf8tYzr684cr4XOcQ==;5:rcScULSC1p6MMfT94D1jeuH61/80266MA23tBvm5ZZlCvIBA2u8HLb6K21AcUiiIJvKVpTusTyWRGckBOAT1IhytKJLrynR8frCiG+GOg449hW5BjD/8YHclotvKBKmkY6cAV/s1D8J/c3/8tCCy6cJx/h52VNppx0l4fqquQWE=;7:3ph64oOAnk8PW8zDDTgZVTN05y6orIuW5IhzLIrB1nvwiMkSghLsxg1squW8pn6oO03CzfihYqXxTqV8Ep9U2XbgrMlo4mECC830TooBfI1NWJNoA3fnchPm7NdUa0FEadmavTc3B2GvRfZ2/GVJAw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 795aacde-5fa8-437f-5c94-08d65467f26e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM6PR06MB4409;
x-ms-traffictypediagnostic: DM6PR06MB4409:
x-microsoft-antispam-prvs: <DM6PR06MB4409A14A966E88A9992CDE82BAD00@DM6PR06MB4409.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3231443)(944501410)(4983020)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB4409;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB4409;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39840400004)(396003)(346002)(376002)(189003)(199004)(82746002)(6486002)(54906003)(6436002)(106356001)(105586002)(25786009)(478600001)(229853002)(316002)(14454004)(8936002)(6246003)(81156014)(8676002)(81166006)(5660300001)(86362001)(2906002)(3846002)(6116002)(39060400002)(4326008)(36756003)(99936001)(256004)(68736007)(305945005)(14444005)(7736002)(446003)(6916009)(53936002)(476003)(2616005)(33656002)(11346002)(186003)(97736004)(83716004)(71190400001)(71200400001)(486006)(66066001)(6512007)(102836004)(76176011)(99286004)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB4409;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jlKBtnd6e3Cf672QqxzJYeZF9+DhRknbrPjyfab6q/mxkS2EcLH9To7lQFEkF6YdbthAkXHqBL2tN6TmmOVq6vwPCSNdxa4L2n/RQZfcZqTDtI/5Lvq1+vkzqTlV133fzCzMuBdJhrV4jQtkhf5COTv0VHP3djwqcjJnDd5jQY2mOddhzbECMNz/EuqGgF1rIuWolqHOcRkj/D5S8T0WZ+K6n+i6VbcYeq69SgygT9o9qxFfSEmYgTFdo9sQ+T9lIuxPuP02r2r3CLLzGRzrp+xHfmhHHuD26rNQGbe8VZF7GnIVvM9xAS3bhn3i6AsjNU+f+WuV3L8RlCHjPdPgrUQqLWRjLhvemPDf1ZQR4y0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_7E0671A7-9ABE-4CCD-BEF5-B1A4E13A5E97";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795aacde-5fa8-437f-5c94-08d65467f26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 12:57:54.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4409
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Apple-Mail=_7E0671A7-9ABE-4CCD-BEF5-B1A4E13A5E97
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 27 Nov 2018, at 02.53, Hua Su <suhua.tanke@gmail.com> wrote:
>=20
> Add lock protection for list operations.
> Signed-off-by: Hua Su <suhua.tanke@gmail.com>
> ---
> drivers/lightnvm/pblk-core.c | 17 ++++++++++-------
> 1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 6944aac43b01..e490df217dac 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1286,24 +1286,27 @@ int pblk_line_recov_alloc(struct pblk *pblk, =
struct pblk_line *line)
> 	list_del(&line->list);
>=20
> 	ret =3D pblk_line_prepare(pblk, line);
> -	if (ret) {
> -		list_add(&line->list, &l_mg->free_list);
> -		spin_unlock(&l_mg->free_lock);
> -		return ret;
> -	}
> -	spin_unlock(&l_mg->free_lock);
> +	if (ret)
> +		goto out;
>=20
> 	ret =3D pblk_line_alloc_bitmaps(pblk, line);
> 	if (ret)
> -		return ret;
> +		goto out;
>=20
> 	if (!pblk_line_init_bb(pblk, line, 0)) {
> 		list_add(&line->list, &l_mg->free_list);
> +		spin_unlock(&l_mg->free_lock);
> 		return -EINTR;
> 	}
> +	spin_unlock(&l_mg->free_lock);
>=20
> 	pblk_rl_free_lines_dec(&pblk->rl, line, true);
> 	return 0;
> +
> +out:
> +	list_add(&line->list, &l_mg->free_list);
> +	spin_unlock(&l_mg->free_lock);
> +	return ret;
> }
>=20
> void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
> --
> 2.19.1

This path is only touched by the recovery path, which is single
threaded, so there is no race condition as is. Also, if recovery fails,
pblk will not create the instance at all. This said, it would be
good to protect the list_add on the pblk_line_init_bb() error path in
case this code is used for some other purpose in the future.

However, the implementation you propose has some issues due to the
extended critical zone, which covers pblk_line_alloc_bitmaps(). Here,
allocations are intentionally non-atomic (i.e., GFP_KERNEL).

You can instead do the following:

diff --git i/drivers/lightnvm/pblk-core.c w/drivers/lightnvm/pblk-core.c
index 615817bf97e3..02c4c1708c45 100644
--- i/drivers/lightnvm/pblk-core.c
+++ w/drivers/lightnvm/pblk-core.c
@@ -1301,15 +1301,22 @@ int pblk_line_recov_alloc(struct pblk *pblk, =
struct pblk_line *line)

        ret =3D pblk_line_alloc_bitmaps(pblk, line);
        if (ret)
-               return ret;
+               goto fail;

        if (!pblk_line_init_bb(pblk, line, 0)) {
-               list_add(&line->list, &l_mg->free_list);
-               return -EINTR;
+               ret =3D -EINTR;
+               goto fail;
        }

        pblk_rl_free_lines_dec(&pblk->rl, line, true);
        return 0;
+
+fail:
+       spin_lock(&l_mg->free_lock);
+       list_add(&line->list, &l_mg->free_list);
+       spin_unlock(&l_mg->free_lock);
+
+       return ret;
 }

 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)

Javier



--Apple-Mail=_7E0671A7-9ABE-4CCD-BEF5-B1A4E13A5E97
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlv9P1EACgkQIX4xUKFR
nnRz7hAAxigfcUs5U3+0LuiUY0IczNsKJkhBCIeHP7QrBKjbu0+yxNVEt6DBW4ir
+xpZ5e/m82Ea96Qa4PQcdm/W1HaHEUoZSCf4bB42xmMlXikRq9LfHqC2csTUczD6
ypHR2okCSc/xSQGfxsuSAkGstC0qUNLfK0Afv1FTg4WjVgQrRN/ddFwitj39idDl
gMoGtI9m0nTA3j4WtqsVS8VPeQDC/M0zRAVJ2nG6uC3izmlTOW+/BHLkAtbbSN0v
Tem3hNyRnBFAQam0uIvjD5rwox+keXFtmlAC1ETduSlIYyqIbCSChSjrLbXOxwHH
3KOGNzcvn7gs4YR1kLoQBROUvI8zXgUjh8g1OmVCKz/9ds/B3SFzZMqTNfIfI7wx
UkGAgKft/6N94TixVecJVGcnYC0EmfPIazdqEhqFCy+7HoLDqw708dkQx8TbmaYP
ioJBqpSRNq9witcXu8ZbGIUM7xyQza/+SpzmgFL6iePPE6GM/f9Xjm5VZ2eOVzUr
pTd7+gXuBV2gb9ZZh/D5joRw+bOqE7jRAMZfrzeU8x40EH7+v4qtK8pDZ3zj82xA
b0AYVRZ15ZMW3ZlPdatVlUnmgzBsJRAyVaSdBC0tWNEpX31ynYfqgQr3+faKLxGm
kXccckYANTg6DjyOKRykJph0rFpzmKPpHpjM7SRzkYqqzXBxkR8=
=/USj
-----END PGP SIGNATURE-----

--Apple-Mail=_7E0671A7-9ABE-4CCD-BEF5-B1A4E13A5E97--
