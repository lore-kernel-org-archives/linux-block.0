Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE3FC3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C01221019
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 16:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfHWQ6n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:58:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:50252 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbfHWQ6n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 12:58:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 09:58:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,422,1559545200"; 
   d="p7s'?scan'208";a="184262884"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga006.jf.intel.com with ESMTP; 23 Aug 2019 09:58:42 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 23 Aug 2019 09:58:42 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.119]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.73]) with mapi id 14.03.0439.000;
 Fri, 23 Aug 2019 09:58:42 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>
Subject: Re: [PATCH 3/3] block: sed-opal: Add support to read/write opal
 tables generically
Thread-Topic: [PATCH 3/3] block: sed-opal: Add support to read/write opal
 tables generically
Thread-Index: AQHVWFPv9reGpILH7UiRlHLlRaEEMKcJbLcA
Date:   Fri, 23 Aug 2019 16:58:41 +0000
Message-ID: <675202326ac755344e46bbd9fc9b76ce60eceac6.camel@intel.com>
References: <20190821191051.3535-1-revanth.rajashekar@intel.com>
         <20190821191051.3535-4-revanth.rajashekar@intel.com>
In-Reply-To: <20190821191051.3535-4-revanth.rajashekar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.165]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-JcPgA9RWLLWtEhy1jdmM"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-JcPgA9RWLLWtEhy1jdmM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+David

On Wed, 2019-08-21 at 13:10 -0600, Revanth Rajashekar wrote:
> This feature gives the user RW access to any opal table with admin1
> authority.
>=20
> The flags described in the new structure determines if the user
> wants to read/write the data. Flags are checked for valid values in
> order to allow future features to be added to the ioctl.
>=20
> Previously exposed opal UIDs allows the user to easily select the
> desired table to retrieve its UID.
>=20
> The ioctl provides a size and offset field and internally will loop
> data accesses to return the full data block.
>=20
> The ioctl provides a private field with the intentiont to accommodate
> any future expansions to the ioctl.
>=20
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
> ---
>  block/sed-opal.c              | 140 ++++++++++++++++++++++++++++++++++
>  include/linux/sed-opal.h      |   1 +
>  include/uapi/linux/sed-opal.h |  16 ++++
>  3 files changed, 157 insertions(+)
>=20
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 7179582730b6..3f41fc56f3cb 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -1896,6 +1896,108 @@ static int get_msid_cpin_pin(struct opal_dev *dev=
, void *data)
>  	return 0;
>  }
>=20
> +static int write_table_data(struct opal_dev *dev, void *data)
> +{
> +	struct opal_read_write_table *write_tbl =3D data;
> +
> +	return generic_table_write_data(dev, write_tbl->data, write_tbl->offset=
,
> +					write_tbl->size, write_tbl->table_uid);
> +}
> +
> +static int read_table_data_cont(struct opal_dev *dev)
> +{
> +	int err =3D 0;
> +	const char *data_read;
> +
> +	err =3D parse_and_check_status(dev);
> +	if (err)
> +		return err;
> +
> +	dev->prev_d_len =3D response_get_string(&dev->parsed, 1, &data_read);
> +
> +	dev->prev_data =3D data_read;
> +	if (!dev->prev_data) {
> +		pr_debug("%s: Couldn't read data from the table.\n", __func__);
> +		return OPAL_INVAL_PARAM;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * IO_BUFFER_LENGTH =3D 2048
> + * sizeof(header) =3D 56
> + * No. of Token Bytes in the Response =3D 11
> + * MAX size of data that can be carried in response buffer
> + * at a time is : 2048 - (56 + 11) =3D 1981 =3D 0x7BD.
> + */
> +#define OPAL_MAX_READ_TABLE (0x7BD)
This is the only part I'm concerned about, but I'm not aware of any
condition in the spec allowing for the response to have extra fields
that would overflow the buffer.



[snip]

--=-JcPgA9RWLLWtEhy1jdmM
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDgyMzE2NTg0MFowIwYJ
KoZIhvcNAQkEMRYEFN+UPR/o9P4mKtE0BjUV/EAHE014MA0GCSqGSIb3DQEBAQUABIIBACfpridZ
IJYUveWe4kI6KjVB3YgTzIzhXlv4ntimJHnoOjiZ9ZSqy1HlxZVXLPo7rYbX4aCguZntjMhPcJn7
o56hWB5ltlSVzkzJSMX+VvWQGHD9AHVNlqYDiHGifqIGzZnv67G5odrq1YR5woWb+2E/12RSfxF0
/CaIkhuRQiY2JMo0X/1KwNc1iVetP41HUWxCR8jnh4dO3Lz383XsNUpNXxR4Fbcy7mZA2g9g1fpV
INta81MiLOmouiFNO0Iu4WAkRTWcvmwPtVgYcWqk4cgU9Dqr4Kyj+LoSmszPcUzHu96/DxNEJGIh
ZaNSjoUz7siwqZAaj2p6TYscWAzZluwAAAAAAAA=


--=-JcPgA9RWLLWtEhy1jdmM--
