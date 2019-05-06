Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAD4C04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 20:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BB02087F
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 20:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEFUCo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 16:02:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:41052 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfEFUCo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 May 2019 16:02:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 13:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,439,1549958400"; 
   d="p7s'?scan'208";a="137519864"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2019 13:02:37 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 6 May 2019 13:02:37 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.27]) with mapi id 14.03.0415.000;
 Mon, 6 May 2019 13:02:36 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 1/3] block: sed-opal: add ioctl for done-mark of shadow
 mbr
Thread-Topic: [PATCH 1/3] block: sed-opal: add ioctl for done-mark of shadow
 mbr
Thread-Index: AQHU/6tmEtIp1537yEqob/W50qrDRqZfA0AA
Date:   Mon, 6 May 2019 20:02:36 +0000
Message-ID: <e032c71d0b3a49211cb5989fc5255dbcf70fdfae.camel@intel.com>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1556666459-17948-2-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1556666459-17948-2-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.159]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-yQjkPFjNItXQravISkN+"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-yQjkPFjNItXQravISkN+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

On Wed, 2019-05-01 at 01:20 +0200, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>=20
> Enable users to mark the shadow mbr as done without completely
> deactivating the shadow mbr feature. This may be useful on reboots,
> when the power to the disk is not disconnected in between and the
> shadow
> mbr stores the required boot files. Of course, this saves also the
> (few) commands required to enable the feature if it is already
> enabled
> and one only wants to mark the shadow mbr as done.
>=20
> Co-authored-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Signed-off-by: Jonas Rabenstein <
> jonas.rabenstein@studium.uni-erlangen.de>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> ---
>  block/sed-opal.c              | 27 +++++++++++++++++++++++++++
>  include/linux/sed-opal.h      |  1 +
>  include/uapi/linux/sed-opal.h | 12 ++++++++++++
>  3 files changed, 40 insertions(+)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index b1aa0cc25803..f1eb9c18e335 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -1986,6 +1986,30 @@ static int
> opal_enable_disable_shadow_mbr(struct opal_dev *dev,
>  	return ret;
>  }
> =20
> +static int opal_set_mbr_done(struct opal_dev *dev,
> +			     struct opal_mbr_done *mbr_done)
> +{
> +	u8 mbr_done_tf =3D mbr_done->done_flag =3D=3D OPAL_MBR_DONE ?
> +		OPAL_TRUE : OPAL_FALSE;
> +
> +	const struct opal_step mbr_steps[] =3D {
> +		{ start_admin1LSP_opal_session, &mbr_done->key },
> +		{ set_mbr_done, &mbr_done_tf },
> +		{ end_opal_session, }
> +	};
> +	int ret;
> +
> +	if (mbr_done->done_flag !=3D OPAL_MBR_DONE &&
> +	    mbr_done->done_flag !=3D OPAL_MBR_NOT_DONE)
> +		return -EINVAL;
> +
> +	mutex_lock(&dev->dev_lock);
> +	setup_opal_dev(dev);
> +	ret =3D execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
> +	mutex_unlock(&dev->dev_lock);
> +	return ret;
> +}
> +
>  static int opal_save(struct opal_dev *dev, struct opal_lock_unlock
> *lk_unlk)
>  {
>  	struct opal_suspend_data *suspend;
> @@ -2299,6 +2323,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned
> int cmd, void __user *arg)
>  	case IOC_OPAL_ENABLE_DISABLE_MBR:
>  		ret =3D opal_enable_disable_shadow_mbr(dev, p);
>  		break;
> +	case IOC_OPAL_MBR_DONE:
> +		ret =3D opal_set_mbr_done(dev, p);
> +		break;
>  	case IOC_OPAL_ERASE_LR:
>  		ret =3D opal_erase_locking_range(dev, p);
>  		break;
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index 04b124fca51e..42b2ce5da7b3 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -47,6 +47,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>  	case IOC_OPAL_ENABLE_DISABLE_MBR:
>  	case IOC_OPAL_ERASE_LR:
>  	case IOC_OPAL_SECURE_ERASE_LR:
> +	case IOC_OPAL_MBR_DONE:
>  		return true;
>  	}
>  	return false;
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-
> opal.h
> index e092e124dd16..81dd0e8886a1 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -29,6 +29,11 @@ enum opal_mbr {
>  	OPAL_MBR_DISABLE =3D 0x01,
>  };
> =20
> +enum opal_mbr_done_flag {
> +	OPAL_MBR_NOT_DONE =3D 0x0,
> +	OPAL_MBR_DONE =3D 0x01
> +};
> +
>  enum opal_user {
>  	OPAL_ADMIN1 =3D 0x0,
>  	OPAL_USER1 =3D 0x01,
> @@ -104,6 +109,12 @@ struct opal_mbr_data {
>  	__u8 __align[7];
>  };
> =20
> +struct opal_mbr_done {
> +	struct opal_key key;
> +	__u8 done_flag;
> +	__u8 __align[7];
> +};
> +
>  #define IOC_OPAL_SAVE		    _IOW('p', 220, struct
> opal_lock_unlock)
>  #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct
> opal_lock_unlock)
>  #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct
> opal_key)
> @@ -116,5 +127,6 @@ struct opal_mbr_data {
>  #define IOC_OPAL_ENABLE_DISABLE_MBR _IOW('p', 229, struct
> opal_mbr_data)
>  #define IOC_OPAL_ERASE_LR           _IOW('p', 230, struct
> opal_session_info)
>  #define IOC_OPAL_SECURE_ERASE_LR    _IOW('p', 231, struct
> opal_session_info)
> +#define IOC_OPAL_MBR_DONE           _IOW('p', 232, struct
> opal_mbr_done)
> =20
>  #endif /* _UAPI_SED_OPAL_H */

--=-yQjkPFjNItXQravISkN+
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDUwNjIwMDIyNFowIwYJ
KoZIhvcNAQkEMRYEFG3VjcddPPFxt1N0ijCL2VM86bO0MA0GCSqGSIb3DQEBAQUABIIBAC0yqTwD
IBsDesQwYrhOpcdaUabuBHHFdXqDefgTbEB38UhP93ejpBqHb27+quFkpfD3O2WtXrF3j9bkUur2
GC/AqJiYe2ESthQpVMwwCqsisco8Nk+YlJCElAdlWiCRwhloOdTUKu8tgREzLEX617vV92zs8nJr
0yggnsvZoCyu14s1YdqbYZRuCmG32WiForZh/GzvmCgKb7VrDKVzaieUm50+CJU7pm8o12Mlh3Oo
r00Sd3GZf7ve1/yqybn8yqY+i0HfZ3WHwIVx15CB3vZNR17e4Sqzk49fbs9nbDGFT8nsb4QtDqYn
kanrvJXyLRYS5/effFtQLpFqqoBoxQwAAAAAAAA=


--=-yQjkPFjNItXQravISkN+--
