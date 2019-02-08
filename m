Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1887C282C2
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 00:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7036C21907
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 00:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfBHAoS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:44:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:31188 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfBHAoS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 19:44:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 16:44:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,346,1544515200"; 
   d="p7s'?scan'208";a="141640003"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga002.fm.intel.com with ESMTP; 07 Feb 2019 16:44:16 -0800
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 7 Feb 2019 16:44:16 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.140]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.164]) with mapi id 14.03.0415.000;
 Thu, 7 Feb 2019 16:44:15 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 10/16] block: sed-opal: add ioctl for done-mark of
 shadow mbr
Thread-Topic: [PATCH v4 10/16] block: sed-opal: add ioctl for done-mark of
 shadow mbr
Thread-Index: AQHUum/vKICuQBfDqUKoB3eYZlzOTqXQQ84AgAU+PQCAAB4CAA==
Date:   Fri, 8 Feb 2019 00:44:14 +0000
Message-ID: <1549586652.11868.12.camel@intel.com>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1549054223-12220-11-git-send-email-zub@linux.fjfi.cvut.cz>
         <20190204145244.GJ31132@infradead.org>
         <alpine.LRH.2.21.1902072247060.29258@linux.fjfi.cvut.cz>
In-Reply-To: <alpine.LRH.2.21.1902072247060.29258@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.58]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-GO1E+LvhCEAzokoCqgub"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-GO1E+LvhCEAzokoCqgub
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-02-07 at 23:56 +0100, David Kozub wrote:
> On Mon, 4 Feb 2019, Christoph Hellwig wrote:
>=20
> > On Fri, Feb 01, 2019 at 09:50:17PM +0100, David Kozub wrote:
> > > From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > >=20
> > > Enable users to mark the shadow mbr as done without completely
> > > deactivating the shadow mbr feature. This may be useful on reboots,
> > > when the power to the disk is not disconnected in between and the sha=
dow
> > > mbr stores the required boot files. Of course, this saves also the
> > > (few) commands required to enable the feature if it is already enable=
d
> > > and one only wants to mark the shadow mbr as done.
> > >=20
> > > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlange=
n.de>
> > > Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> > > ---
> > >  block/sed-opal.c              | 33 +++++++++++++++++++++++++++++++--
> > >  include/linux/sed-opal.h      |  1 +
> > >  include/uapi/linux/sed-opal.h |  1 +
> > >  3 files changed, 33 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/block/sed-opal.c b/block/sed-opal.c
> > > index 4b0a63b9d7c9..e03838cfd31b 100644
> > > --- a/block/sed-opal.c
> > > +++ b/block/sed-opal.c
> > > @@ -1996,13 +1996,39 @@ static int opal_erase_locking_range(struct op=
al_dev *dev,
> > >  static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
> > >  					  struct opal_mbr_data *opal_mbr)
> > >  {
> > > +	u8 token =3D opal_mbr->enable_disable =3D=3D OPAL_MBR_ENABLE
> > > +		? OPAL_TRUE : OPAL_FALSE;
> > >  	const struct opal_step mbr_steps[] =3D {
> > >  		{ opal_discovery0, },
> > >  		{ start_admin1LSP_opal_session, &opal_mbr->key },
> > > -		{ set_mbr_done, &opal_mbr->enable_disable },
> > > +		{ set_mbr_done, &token },
> > >  		{ end_opal_session, },
> > >  		{ start_admin1LSP_opal_session, &opal_mbr->key },
> > > -		{ set_mbr_enable_disable, &opal_mbr->enable_disable },
> > > +		{ set_mbr_enable_disable, &token },
> > > +		{ end_opal_session, },
> > > +		{ NULL, }
> >=20
> > This seems to be a change of what we pass to set_mbr_done /
> > set_mbr_enable_disable and not really related to the new functionality
> > here, so it should be split into a separate patch.
> >=20
> > That being said if we really care about this translation between
> > the two sets of constants, why not do it inside
> > set_mbr_done and set_mbr_enable_disable?
>=20
> Hi Christoph,
>=20
> I agree, this should be split. Furthermore I think I found an issue here:=
=20
> OPAL_MBR_ENABLE and OPAL_MBR_DISABLE are defined as follows:
>=20
> enum opal_mbr {
>  	OPAL_MBR_ENABLE =3D 0x0,
>  	OPAL_MBR_DISABLE =3D 0x01,
> };
>=20
> ... while OPAL_TRUE and OPAL_FALSE tokens are:
>=20
>  	OPAL_TRUE =3D 0x01,
>  	OPAL_FALSE =3D 0x00,
>=20
> so in the current code in kernel, when the IOCTL input is directly passed=
=20
> in place of the TRUE/FALSE tokens (in opal_enable_disable_shadow_mbr),=
=20
> passing OPAL_MBR_ENABLE (0) to IOC_OPAL_ENABLE_DISABLE_MBR ends up being=
=20
> interpreted as OPAL_FALSE (0) and passing OPAL_MBR_DISABLE (1) ended up=
=20
> being interpreted as OPAL_TRUE (1). So the behavior is:
>=20
> OPAL_MBR_ENABLE: set MBR enable to OPAL_FALSE and done to OPAL_FALSE
> OPAL_MBR_DISABLE: set MBR enable to OPAL_TRUE and done to OPAL_TRUE
>=20
> Am I missing something here? This seems wrong to me. And I think this=20
> patch actually changes it by introducing:
>=20
> +    u8 token =3D opal_mbr->enable_disable =3D=3D OPAL_MBR_ENABLE
> +            ? OPAL_TRUE : OPAL_FALSE;
>=20
> which is essentially a negation (map 0 to 1 and 1 to 0).
>=20
> I had a strange feeling of IOC_OPAL_ENABLE_DISABLE_MBR behaving=20
> incorrectly when I first tried it. But when I checked later I was not abl=
e=20
> to reproduce it - probably originally I tested without this patch.
>=20
> With regard to the new IOC_OPAL_MBR_STATUS: I find the usage of=20
> OPAL_MBR_ENABLE/DISABLE for this confusing: what should passing=20
> OPAL_MBR_ENABLE do? Should it enable the shadow MBR? Or should it=20
> enable the MBR-done flag? I think the implementation in this patch=20
> interprets OPAL_MBR_ENABLE as 'set the "done" flag to true', thus hiding=
=20
> the shadow MBR. But this is not obvious looking at the IOCTL name.
>=20
> What if I introduced two new constants for this? OPAL_MBR_DONE and=20
> OPAL_MBR_NOT_DONE? Maybe the IOCTL could be renamed too -=20
> IOC_OPAL_MBR_DONE? Or is it only me who finds this confusing?
>=20
> Best regards,
> David

Hi David,

Based on the spec and appnote [1], it does look like sed-opal-temp is
providing the inverted value for shadow mbr enable:

        if (cfg.enable_mbr)
                mbr.enable_disable =3D OPAL_MBR_ENABLE;
        else   =20
                mbr.enable_disable =3D OPAL_MBR_DISABLE;

where
enum opal_mbr {
        OPAL_MBR_ENABLE =3D 0x0,
        OPAL_MBR_DISABLE =3D 0x01,
};

The appnote says as much:
3.2.9.4
Enable the MBR Shadowing feature
session[TSN:HSN] -> MBRControl_UID.Set[Values =3D [Enable =3D TRUE]]
0000 00000000 07FE0000 00000000 00000000
0010 00000048 00001001 00000001 00000000
0020 00000000 00000000 00000030 00000000
0030 00000000 00000024 F8A80000 08030000
0040 0001A800 00000600 000017F0 F201F0F2
0050 0101F3F1 F3F1F9F0 000000F1 00000000
      ^ ^
01: Tiny Atom Token: Name: =E2=80=9CEnable=E2=80=9D
01: Tiny Atom Token: Value: <1> (True)

In order to keep the userspace interface consistent, I'll ACK your
change in this patch, unless Scott can fill me in on why this looks
wrong but is actually right.

We have 7 bytes in the opal_mbr_data struct we could use for DONE/NOT
DONE. I'm not sure how to go about keeping it consistent with old uapi,
although arguably opal_enable_disable_shadow_mbr is already doing the
wrong thing with DONE and ENABLE so it's low impact.

Acked-by: Jon Derrick <jonathan.derrick@intel.com>

[1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Opal_S=
SC_Application_Note_1-00_1-00-Final.pdf
--=-GO1E+LvhCEAzokoCqgub
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDIwODAwNDQxMlowIwYJ
KoZIhvcNAQkEMRYEFK1dI1BbUni35Yi2QM56o+rpwOTTMA0GCSqGSIb3DQEBAQUABIIBABX0Os8X
uOfO0Jo3DjuQbzQp9QrzobGY/jQYlnsbRsh8SVpAGpBT2QKOT11VtyKs9S4jc/b64aAbHVw7qQ//
Q7x24RmhLUD3PSY/aYgl9kES/R6+s7iTnxLT1GiADPIKRmW2PdO3tQelh+UH81kHlYoalNZhNTSo
h49tqRYemILvRK+YDFsqw3DyJVOkqAs6nu+UBGjaLw9zm7xMoDAKYgv9Xw13dN55OXNvdZ6F/mrM
+BNsdT/otZbeLCFCN1/k61eRXyCSNK7MBshgW5okl2ZmLXengZ9RWqGtMW6+mm/zvxwNO79PDkOg
QA2MZMMcvvr4l1Ebt+GnjTdyT8iwnswAAAAAAAA=


--=-GO1E+LvhCEAzokoCqgub--
