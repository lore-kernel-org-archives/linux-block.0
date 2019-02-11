Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E05C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 21:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADD1217D9
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 21:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfBKV1G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:27:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:3332 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfBKV1F (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 16:27:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 13:27:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="p7s'?scan'208";a="133482375"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga002.jf.intel.com with ESMTP; 11 Feb 2019 13:27:04 -0800
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 13:27:04 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.11]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.136]) with mapi id 14.03.0415.000;
 Mon, 11 Feb 2019 13:27:04 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 13/16] block: sed-opal: check size of shadow mbr
Thread-Topic: [PATCH v4 13/16] block: sed-opal: check size of shadow mbr
Thread-Index: AQHUum/0dH3ZWGnVH0m2fx7IN2xJnqXXFPIAgAL0OoCAAakdgA==
Date:   Mon, 11 Feb 2019 21:27:03 +0000
Message-ID: <1549920421.2868.6.camel@intel.com>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1549054223-12220-14-git-send-email-zub@linux.fjfi.cvut.cz>
         <1549666730.10972.60.camel@intel.com>
         <alpine.LRH.2.21.1902101921530.28071@linux.fjfi.cvut.cz>
In-Reply-To: <alpine.LRH.2.21.1902101921530.28071@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.157]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-uz6FPlKydUrlMcs6BTgf"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-uz6FPlKydUrlMcs6BTgf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-02-10 at 21:05 +0100, David Kozub wrote:
> On Fri, 8 Feb 2019, Derrick, Jonathan wrote:
>=20
> > On Fri, 2019-02-01 at 21:50 +0100, David Kozub wrote:
> > > From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > >=20
> > > Check whether the shadow mbr does fit in the provided space on
> > > the
> > > target. Also a proper firmware should handle this case and return
> > > an
> > > error we may prevent problems or even damage with crappy
> > > firmwares.
> > >=20
> > > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erl
> > > angen.de>
> > > Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> > > ---
> > >  block/opal_proto.h | 16 ++++++++++++++++
> > >  block/sed-opal.c   | 39 +++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 55 insertions(+)
> > >=20
> > > diff --git a/block/opal_proto.h b/block/opal_proto.h
> > > index b6e352cfe982..5e8df3245eb0 100644
> > > --- a/block/opal_proto.h
> > > +++ b/block/opal_proto.h
> > > @@ -106,6 +106,7 @@ enum opal_uid {
> > >  	OPAL_ENTERPRISE_BANDMASTER0_UID,
> > >  	OPAL_ENTERPRISE_ERASEMASTER_UID,
> > >  	/* tables */
> > > +	OPAL_TABLE_TABLE,
> > >  	OPAL_LOCKINGRANGE_GLOBAL,
> > >  	OPAL_LOCKINGRANGE_ACE_RDLOCKED,
> > >  	OPAL_LOCKINGRANGE_ACE_WRLOCKED,
> > > @@ -160,6 +161,21 @@ enum opal_token {
> > >  	OPAL_STARTCOLUMN =3D 0x03,
> > >  	OPAL_ENDCOLUMN =3D 0x04,
> > >  	OPAL_VALUES =3D 0x01,
> > > +	/* table table */
> > > +	OPAL_TABLE_UID =3D 0x00,
> > > +	OPAL_TABLE_NAME =3D 0x01,
> > > +	OPAL_TABLE_COMMON =3D 0x02,
> > > +	OPAL_TABLE_TEMPLATE =3D 0x03,
> > > +	OPAL_TABLE_KIND =3D 0x04,
> > > +	OPAL_TABLE_COLUMN =3D 0x05,
> > > +	OPAL_TABLE_COLUMNS =3D 0x06,
> > > +	OPAL_TABLE_ROWS =3D 0x07,
> > > +	OPAL_TABLE_ROWS_FREE =3D 0x08,
> > > +	OPAL_TABLE_ROW_BYTES =3D 0x09,
> > > +	OPAL_TABLE_LASTID =3D 0x0A,
> > > +	OPAL_TABLE_MIN =3D 0x0B,
> > > +	OPAL_TABLE_MAX =3D 0x0C,
> > > +
> > >  	/* authority table */
> > >  	OPAL_PIN =3D 0x03,
> > >  	/* locking tokens */
> > > diff --git a/block/sed-opal.c b/block/sed-opal.c
> > > index 2459ac4d523b..3493bb979978 100644
> > > --- a/block/sed-opal.c
> > > +++ b/block/sed-opal.c
> > > @@ -139,6 +139,8 @@ static const u8 opaluid[][OPAL_UID_LENGTH] =3D
> > > {
> > >=20
> > >  	/* tables */
> > >=20
> > > +	[OPAL_TABLE_TABLE]
> > > +		{ 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01
> > > },
> > >  	[OPAL_LOCKINGRANGE_GLOBAL] =3D
> > >  		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01
> > > },
> > >  	[OPAL_LOCKINGRANGE_ACE_RDLOCKED] =3D
> > > @@ -1120,6 +1122,29 @@ static int generic_get_column(struct
> > > opal_dev *dev, const u8 *table,
> > >  	return finalize_and_send(dev, parse_and_check_status);
> > >  }
> > >=20
> > > +/*
> > > + * see TCG SAS 5.3.2.3 for a description of the available
> > > columns
> > > + *
> > > + * the result is provided in dev->resp->tok[4]
> > > + */
> > > +static int generic_get_table_info(struct opal_dev *dev, enum
> > > opal_uid table,
> > > +				  u64 column)
> > > +{
> > > +	u8 uid[OPAL_UID_LENGTH];
> > > +	const unsigned int half =3D OPAL_UID_LENGTH/2;
> > > +
> > > +	/* sed-opal UIDs can be split in two halves:
> > > +	 *  first:  actual table index
> > > +	 *  second: relative index in the table
> > > +	 * so we have to get the first half of the
> > > OPAL_TABLE_TABLE and use the
> > > +	 * first part of the target table as relative index into
> > > that table
> > > +	 */
> > > +	memcpy(uid, opaluid[OPAL_TABLE_TABLE], half);
> > > +	memcpy(uid+half, opaluid[table], half);
> > > +
> > > +	return generic_get_column(dev, uid, column);
> > > +}
> > > +
> > >  static int gen_key(struct opal_dev *dev, void *data)
> > >  {
> > >  	u8 uid[OPAL_UID_LENGTH];
> > > @@ -1535,6 +1560,20 @@ static int write_shadow_mbr(struct
> > > opal_dev *dev, void *data)
> > >  	u64 len;
> > >  	int err =3D 0;
> > >=20
> > > +	/* do we fit in the available shadow mbr space? */
> > > +	err =3D generic_get_table_info(dev, OPAL_MBR,
> > > OPAL_TABLE_ROWS);
> >=20
> > Wouldn't you need to multiply this by result from
> > OPAL_TABLE_ROWBYTES?
> > What does ROWBYTES return for you?
>=20
> Hi Jon,
>=20
> reading the spec[1], I think it defines the MBR table to be a "byte
> table"=20
> (see 5.7.2.6 MBR (Byte Table)). For byte tables, it says (see
> 3.2.5.1=20
> Kinds of Tables) "A byte table has one unnamed column of type
> bytes_1." I=20
> think this implies that each row is 1 byte and so number of rows =3D
> size of=20
> table in rows.
>=20
> When I actually try to get OPAL_TABLE_ROWS abd OPAL_TABLE_ROWBYTES of
> the=20
> MBR table from a Samsung 840 EVO, I get:
> * OPAL_TABLE_ROWS 134217728 which is 128 MiB
> * OPAL_TABLE_ROWBYTES 0
>=20
> I'm not sure if I'm doing something wrong here. I just added:
>=20
>  	err =3D generic_get_table_info(dev, OPAL_MBR,
> OPAL_TABLE_ROW_BYTES);
>  	if (err) {
>  		pr_debug("MBR: could not get shadow row bytes
> size\n");
>  		return err;
>  	}
>=20
>  	row_bytes =3D response_get_u64(&dev->parsed, 4);
>=20
> Best regards,
> David
>=20
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_
> Architecture_Core_Spec_v2.01_r1.00.pdf

I also see ROWS=3D0x8000000 and ROWBYTES=3D0 on an Intel drive, so my
interpretation of rowbytes was probably incorrect.

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
--=-uz6FPlKydUrlMcs6BTgf
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
PNauajAtxgRKfqfSMb+IcL/VXiPtVZOxVq+CTZeDJkaEmn/79vg8OYxpR+YhFF+tGlKf/Zc4id1P
AgMBAAGjggI3MIICMzAdBgNVHQ4EFgQU4oawcWXM1cPGdwGcIszDfjORVZAwHwYDVR0jBBgwFoAU
HmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRl
bC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIw
SXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20v
MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9T
gpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsG
AQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBRBgNVHREESjBIoCoGCisGAQQB
gjcUAgOgHAwaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb22BGmpvbmF0aGFuLmRlcnJpY2tAaW50
ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQBxGkHe05DNpYel4b9WbbyQqD1G6y6YA6C93TjKULZi
p8+gO1LL096ixD44+frVm3jtXMikoadRHQJmBJdzsCywNE1KgtrYF0k4zRWr7a28nyfGgQe4UHHD
7ARyZFeGd7AKSQ1y4/LU57I2Aw2HKx9/PXavv1JXjjO2/bqTfnZDJTQmOQ0nvlO3/gvbbABxZHqz
NtfHZsQWS7s+Elk2xGUQ0Po2pMCQoaPo9R96mm+84UP9q3OvSqMoaZwfzoUeAx2wGJYl0h3S+ABr
CPVfCgq9qnmVCn5DyHWE3V/BRjJCoILLBLxAxnmSdH4pF6wJ6pYRLEw9qoyNhpzGUIJU/Lk1MYIC
FzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBD
bGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFs
IEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAMamAkocC+WQNPgAAAAAxqYwCQYFKw4DAhoFAKBdMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDIxMTIxMjcwMVowIwYJ
KoZIhvcNAQkEMRYEFPUDlYziGVVGbxBrsXiEHAGwtjaLMA0GCSqGSIb3DQEBAQUABIIBAIMEM3pM
9Cb/w41fk14iYkxUIcUsBBUhETEVlEh/6vySqub+XLFmI0Aj1D1GSOld2anUhCxOxFlJl8XGFRRG
vOWVUSyEDVPr9Bnqbj5RbNGtWvXQjkiqdm7TR6JPI7kR5hezrdRNXdqduUYePSo1PXybhnFA8u+m
jV620eRYP+pqVXQd/dHYsKPhiSZdie6Ir9JdRtkdwJGIsTPa+PKPdUQ6TgiG/RkNw9vGGV03k55I
+IbsW4aSfx1IA6pKu6lwjmt26EXvLgq93AbzoPFVyZmYlIKGi35AsOFSTEhAePUa9Q6r2NhEw2T8
oNnpUz1MkEoFjoA0NLwOrGMEyKjRY1sAAAAAAAA=


--=-uz6FPlKydUrlMcs6BTgf--
