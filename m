Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FE3C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A385321841
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 22:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfBHW60 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:58:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:4117 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfBHW60 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 17:58:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 14:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="p7s'?scan'208";a="298333918"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2019 14:58:25 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 8 Feb 2019 14:58:25 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.11]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.135]) with mapi id 14.03.0415.000;
 Fri, 8 Feb 2019 14:58:25 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 11/16] block: sed-opal: ioctl for writing to shadow
 mbr
Thread-Topic: [PATCH v4 11/16] block: sed-opal: ioctl for writing to shadow
 mbr
Thread-Index: AQHUum/3m7/0sZHXEUu0DOXeRXchm6XXFNAA
Date:   Fri, 8 Feb 2019 22:58:24 +0000
Message-ID: <1549666702.10972.58.camel@intel.com>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <1549054223-12220-12-git-send-email-zub@linux.fjfi.cvut.cz>
In-Reply-To: <1549054223-12220-12-git-send-email-zub@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.141]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-kCHKGD753HausSkTSeZl"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-kCHKGD753HausSkTSeZl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-02-01 at 21:50 +0100, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
>=20
> Allow modification of the shadow mbr. If the shadow mbr is not marked as
> done, this data will be presented read only as the device content. Only
> after marking the shadow mbr as done and unlocking a locking range the
> actual content is accessible.
>=20
> Co-authored-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de=
>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> ---
>  block/sed-opal.c              | 89 ++++++++++++++++++++++++++++++++++-
>  include/linux/sed-opal.h      |  1 +
>  include/uapi/linux/sed-opal.h |  8 ++++
>  3 files changed, 97 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index e03838cfd31b..88c84906ce98 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -34,6 +34,9 @@
>  #define IO_BUFFER_LENGTH 2048
>  #define MAX_TOKS 64
> =20
> +/* Number of bytes needed by cmd_finalize. */
> +#define CMD_FINALIZE_BYTES_NEEDED 7
> +
>  struct opal_step {
>  	int (*fn)(struct opal_dev *dev, void *data);
>  	void *data;
> @@ -668,7 +671,11 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hs=
n, u32 tsn)
>  	struct opal_header *hdr;
>  	int err =3D 0;
> =20
> -	/* close the parameter list opened from cmd_start */
> +	/*
> +	 * Close the parameter list opened from cmd_start.
> +	 * The number of bytes added must be equal to
> +	 * CMD_FINALIZE_BYTES_NEEDED.
> +	 */
>  	add_token_u8(&err, cmd, OPAL_ENDLIST);
> =20
>  	add_token_u8(&err, cmd, OPAL_ENDOFDATA);
> @@ -1500,6 +1507,58 @@ static int set_mbr_enable_disable(struct opal_dev =
*dev, void *data)
>  	return finalize_and_send(dev, parse_and_check_status);
>  }
> =20
> +static int write_shadow_mbr(struct opal_dev *dev, void *data)
> +{
> +	struct opal_shadow_mbr *shadow =3D data;
> +	const u8 __user *src;
> +	u8 *dst;
> +	size_t off =3D 0;
> +	u64 len;
> +	int err =3D 0;
> +
> +	/* do the actual transmission(s) */
> +	src =3D (u8 *) shadow->data;
> +	while (off < shadow->size) {
> +		err =3D cmd_start(dev, opaluid[OPAL_MBR], opalmethod[OPAL_SET]);
> +		add_token_u8(&err, dev, OPAL_STARTNAME);
> +		add_token_u8(&err, dev, OPAL_WHERE);
> +		add_token_u64(&err, dev, shadow->offset + off);
> +		add_token_u8(&err, dev, OPAL_ENDNAME);
> +
> +		add_token_u8(&err, dev, OPAL_STARTNAME);
> +		add_token_u8(&err, dev, OPAL_VALUES);
> +
> +		/*
> +		 * The bytestring header is either 1 or 2 bytes, so assume 2.
> +		 * There also needs to be enough space to accommodate the
> +		 * trailing OPAL_ENDNAME (1 byte) and tokens added by
> +		 * cmd_finalize.
> +		 */
> +		len =3D min(remaining_size(dev) - (2+1+CMD_FINALIZE_BYTES_NEEDED),
> +			  (size_t)(shadow->size - off));
> +		pr_debug("MBR: write bytes %zu+%llu/%llu\n",
> +			 off, len, shadow->size);
> +
> +		dst =3D add_bytestring_header(&err, dev, len);
> +		if (!dst)
> +			break;
> +		if (copy_from_user(dst, src + off, len))
> +			err =3D -EFAULT;
> +		dev->pos +=3D len;
> +
> +		add_token_u8(&err, dev, OPAL_ENDNAME);
> +		if (err)
> +			break;
> +
> +		err =3D finalize_and_send(dev, parse_and_check_status);
> +		if (err)
> +			break;
> +
> +		off +=3D len;
> +	}
> +	return err;
> +}
> +
>  static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
>  			  struct opal_dev *dev)
>  {
> @@ -2045,6 +2104,31 @@ static int opal_mbr_status(struct opal_dev *dev, s=
truct opal_mbr_data *opal_mbr)
>  	return ret;
>  }
> =20
> +static int opal_write_shadow_mbr(struct opal_dev *dev,
> +				 struct opal_shadow_mbr *info)
> +{
> +	const struct opal_step mbr_steps[] =3D {
> +		{ opal_discovery0, },
> +		{ start_admin1LSP_opal_session, &info->key },
> +		{ write_shadow_mbr, info },
> +		{ end_opal_session, },
> +		{ NULL, }
> +	};
> +	int ret;
> +
> +	if (info->size =3D=3D 0)
> +		return 0;
> +
> +	if (!access_ok(info->data, info->size))
> +		return -EINVAL;
-EFAULT?

> +
> +	mutex_lock(&dev->dev_lock);
> +	setup_opal_dev(dev, mbr_steps);
> +	ret =3D next(dev);
> +	mutex_unlock(&dev->dev_lock);
> +	return ret;
> +}
> +
>  static int opal_save(struct opal_dev *dev, struct opal_lock_unlock *lk_u=
nlk)
>  {
>  	struct opal_suspend_data *suspend;
> @@ -2378,6 +2462,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cm=
d, void __user *arg)
>  	case IOC_OPAL_MBR_STATUS:
>  		ret =3D opal_mbr_status(dev, p);
>  		break;
> +	case IOC_OPAL_WRITE_SHADOW_MBR:
> +		ret =3D opal_write_shadow_mbr(dev, p);
> +		break;
>  	case IOC_OPAL_ERASE_LR:
>  		ret =3D opal_erase_locking_range(dev, p);
>  		break;
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index b38dc602cae3..cf08cdc13cbd 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -47,6 +47,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>  	case IOC_OPAL_ENABLE_DISABLE_MBR:
>  	case IOC_OPAL_ERASE_LR:
>  	case IOC_OPAL_SECURE_ERASE_LR:
> +	case IOC_OPAL_WRITE_SHADOW_MBR:
>  	case IOC_OPAL_MBR_STATUS:
>  		return true;
>  	}
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.=
h
> index 0cb9890cdc04..8e84307f66d4 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -104,6 +104,13 @@ struct opal_mbr_data {
>  	__u8 __align[7];
>  };
> =20
> +struct opal_shadow_mbr {
> +	struct opal_key key;
> +	const __u64 data;
> +	__u64 offset;
> +	__u64 size;
> +};
> +
>  #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
>  #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
>  #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
> @@ -117,5 +124,6 @@ struct opal_mbr_data {
>  #define IOC_OPAL_ERASE_LR           _IOW('p', 230, struct opal_session_i=
nfo)
>  #define IOC_OPAL_SECURE_ERASE_LR    _IOW('p', 231, struct opal_session_i=
nfo)
>  #define IOC_OPAL_MBR_STATUS         _IOW('p', 232, struct opal_mbr_data)
> +#define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 233, struct opal_shadow_mb=
r)
> =20
>  #endif /* _UAPI_SED_OPAL_H */
Otherwise looks good

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>


--=-kCHKGD753HausSkTSeZl
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDIwODIyNTgyMlowIwYJ
KoZIhvcNAQkEMRYEFHC+XLjM8JbU7cE4PxefOHhE3oAxMA0GCSqGSIb3DQEBAQUABIIBABWp77AS
WytRUJPeuuBHBuur3iCAfpFrFoB4Pbr4LgxjJkfWqQtA6FgNdMYenPqb8fHN2XWDPoE1GRFrWaoV
gR5pz6M9RVppSrrA/fCisOUTZ/MBxIKl3uZqmHOgkuhR7Pc+wCATsV49rlr3v8yis9nKCVFwWOlA
sRNf+4V8pYHm7ibaJmmbq7yoggtxzvLGLtjNm1REAK7puD7hu7dQ/K4V9+0NsDOx2SFj4sMES0g1
8uQKCGfReFKiGDVIF+ZEKnjL6jkBWlfLWFa33lI300gcQ5Fzag7xpuhKQJHvd+ZHswjHzUqliP4F
Ul0BF90d4M4EeqrtiuqzyMkHi/4tc2cAAAAAAAA=


--=-kCHKGD753HausSkTSeZl--
