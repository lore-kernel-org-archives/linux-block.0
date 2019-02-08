Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF51BC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9441F21841
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBHW7W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:59:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:10805 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfBHW7W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 17:59:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 14:59:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="p7s'?scan'208";a="142777209"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2019 14:59:21 -0800
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 8 Feb 2019 14:59:21 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.11]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.53]) with mapi id 14.03.0415.000;
 Fri, 8 Feb 2019 14:59:20 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 16/16] block: sed-opal: rename next to execute_steps
Thread-Topic: [PATCH v4 16/16] block: sed-opal: rename next to execute_steps
Thread-Index: AQHUvHtpXRh3Cnvke0+xrQTl6wy9laXXEPwA
Date:   Fri, 8 Feb 2019 22:59:20 +0000
Message-ID: <1549666758.10972.63.camel@intel.com>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1549054223-12220-17-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1549054223-12220-17-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.141]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-IJaCfD7/EgX5owy+HXuX"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-IJaCfD7/EgX5owy+HXuX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

On Fri, 2019-02-01 at 21:50 +0100, David Kozub wrote:
> As the function is responsible for executing the individual steps supplie=
d
> in the steps argument, execute_steps is a more descriptive name than the
> rather generic next.
>=20
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> ---
>  block/sed-opal.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 3362741dd198..c09149dd5e0a 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -401,8 +401,8 @@ static int execute_step(struct opal_dev *dev,
>  	return error;
>  }
> =20
> -static int next(struct opal_dev *dev, const struct opal_step *steps,
> -		size_t n_steps)
> +static int execute_steps(struct opal_dev *dev,
> +			 const struct opal_step *steps, size_t n_steps)
>  {
>  	size_t state;
>  	int error;
> @@ -2034,7 +2034,7 @@ static int opal_secure_erase_locking_range(struct o=
pal_dev *dev,
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, erase_steps, ARRAY_SIZE(erase_steps));
> +	ret =3D execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2051,7 +2051,7 @@ static int opal_erase_locking_range(struct opal_dev=
 *dev,
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, erase_steps, ARRAY_SIZE(erase_steps));
> +	ret =3D execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2077,7 +2077,7 @@ static int opal_enable_disable_shadow_mbr(struct op=
al_dev *dev,
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
> +	ret =3D execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2099,7 +2099,7 @@ static int opal_mbr_status(struct opal_dev *dev, st=
ruct opal_mbr_data *opal_mbr)
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
> +	ret =3D execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2122,7 +2122,7 @@ static int opal_write_shadow_mbr(struct opal_dev *d=
ev,
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
> +	ret =3D execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2174,7 +2174,7 @@ static int opal_add_user_to_lr(struct opal_dev *dev=
,
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, steps, ARRAY_SIZE(steps));
> +	ret =3D execute_steps(dev, steps, ARRAY_SIZE(steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2189,7 +2189,7 @@ static int opal_reverttper(struct opal_dev *dev, st=
ruct opal_key *opal)
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, revert_steps, ARRAY_SIZE(revert_steps));
> +	ret =3D execute_steps(dev, revert_steps, ARRAY_SIZE(revert_steps));
>  	mutex_unlock(&dev->dev_lock);
> =20
>  	/*
> @@ -2217,10 +2217,11 @@ static int __opal_lock_unlock(struct opal_dev *de=
v,
>  	};
> =20
>  	if (lk_unlk->session.sum)
> -		return next(dev, unlock_sum_steps,
> -			    ARRAY_SIZE(unlock_sum_steps));
> +		return execute_steps(dev, unlock_sum_steps,
> +				     ARRAY_SIZE(unlock_sum_steps));
>  	else
> -		return next(dev, unlock_steps, ARRAY_SIZE(unlock_steps));
> +		return execute_steps(dev, unlock_steps,
> +				     ARRAY_SIZE(unlock_steps));
>  }
> =20
>  static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *ke=
y)
> @@ -2232,7 +2233,7 @@ static int __opal_set_mbr_done(struct opal_dev *dev=
, struct opal_key *key)
>  		{ end_opal_session, }
>  	};
> =20
> -	return next(dev, mbrdone_step, ARRAY_SIZE(mbrdone_step));
> +	return execute_steps(dev, mbrdone_step, ARRAY_SIZE(mbrdone_step));
>  }
> =20
>  static int opal_lock_unlock(struct opal_dev *dev,
> @@ -2267,7 +2268,7 @@ static int opal_take_ownership(struct opal_dev *dev=
, struct opal_key *opal)
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, owner_steps, ARRAY_SIZE(owner_steps));
> +	ret =3D execute_steps(dev, owner_steps, ARRAY_SIZE(owner_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2288,7 +2289,7 @@ static int opal_activate_lsp(struct opal_dev *dev,
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, active_steps, ARRAY_SIZE(active_steps));
> +	ret =3D execute_steps(dev, active_steps, ARRAY_SIZE(active_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2305,7 +2306,7 @@ static int opal_setup_locking_range(struct opal_dev=
 *dev,
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, lr_steps, ARRAY_SIZE(lr_steps));
> +	ret =3D execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2327,7 +2328,7 @@ static int opal_set_new_pw(struct opal_dev *dev, st=
ruct opal_new_pw *opal_pw)
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, pw_steps, ARRAY_SIZE(pw_steps));
> +	ret =3D execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
> @@ -2351,7 +2352,7 @@ static int opal_activate_user(struct opal_dev *dev,
> =20
>  	mutex_lock(&dev->dev_lock);
>  	setup_opal_dev(dev);
> -	ret =3D next(dev, act_steps, ARRAY_SIZE(act_steps));
> +	ret =3D execute_steps(dev, act_steps, ARRAY_SIZE(act_steps));
>  	mutex_unlock(&dev->dev_lock);
>  	return ret;
>  }
--=-IJaCfD7/EgX5owy+HXuX
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDIwODIyNTkxOFowIwYJ
KoZIhvcNAQkEMRYEFP03nbEtCaMNLBC1eOsaoyAszXZbMA0GCSqGSIb3DQEBAQUABIIBAJ3yjEeR
6L17b7IZxaV3+y3y6ck5xmaspHA3phUtFK7LFV0lBEVGMnGgpy0CRlgW8fxGfQ7CR8udLWQ8Qpur
ovasPhOAGy69+AUjZ6JeTFMrVgnEH+a7hUcv2i0Dvk/vocKsU5/K1aAMulkqounIfh5nGGxxfezL
JiN9BSZGp5dqgDi5UxZyC8OIaJVRN0DmYCAjsWSCywXfDLyq4EudaMAHoKSuXzsm392aTskqMfez
b7ShMHCkoVLSe9iKap2SQJ2I6LnEhouqyxSOGPv0Iuue+1KAw75xtRVpXV0EyjmEGLaRR3WXWpvY
4enH5ZG8xjVr7/Pl+avNMxKs0+n/nr4AAAAAAAA=


--=-IJaCfD7/EgX5owy+HXuX--
