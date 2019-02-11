Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DC2C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 17:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB439218AD
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 17:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfBKRWT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:22:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:3115 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfBKRWT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 12:22:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 09:22:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="p7s'?scan'208";a="142490310"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2019 09:22:17 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.11]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.35]) with mapi id 14.03.0415.000;
 Mon, 11 Feb 2019 09:22:17 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 15/16] block: sed-opal: don't repeat opal_discovery0
 in each steps array
Thread-Topic: [PATCH v4 15/16] block: sed-opal: don't repeat opal_discovery0
 in each steps array
Thread-Index: AQHUum/2nWJvb0JrekO2TcaIVNjqNqXQRkMAgACBSQCABk18gIACzUEAgAGLmIA=
Date:   Mon, 11 Feb 2019 17:22:16 +0000
Message-ID: <1549905731.2868.1.camel@intel.com>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
          <1549054223-12220-16-git-send-email-zub@linux.fjfi.cvut.cz>
          <20190204150132.GM31132@infradead.org>
          <alpine.LRH.2.21.1902042336331.10661@linux.fjfi.cvut.cz>
         <1549666749.10972.62.camel@intel.com>
         <alpine.LRH.2.21.1902101840020.28071@linux.fjfi.cvut.cz>
In-Reply-To: <alpine.LRH.2.21.1902101840020.28071@linux.fjfi.cvut.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.157]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-RYrHxVYtogaybJPjKbIc"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-RYrHxVYtogaybJPjKbIc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Sun, 2019-02-10 at 18:46 +0100, David Kozub wrote:
> On Fri, 8 Feb 2019, Derrick, Jonathan wrote:
>=20
> > On Mon, 2019-02-04 at 23:44 +0100, David Kozub wrote:
> > > On Mon, 4 Feb 2019, Christoph Hellwig wrote:
> > >=20
> > > > > +	/* first do a discovery0 */
> > > > > +	error =3D opal_discovery0_step(dev);
> > > > >=20
> > > > > +	for (state =3D 0; !error && state < n_steps; state++)
> > > > > +		error =3D execute_step(dev, &steps[state], state);
This was implemented in v4's 14/16, rather than this patch (15/16)

> > > > > +
> > > > > +	/*
> > > > > +	 * For each OPAL command the first step in steps starts some so=
rt of
> > > > > +	 * session. If an error occurred in the initial discovery0 or i=
f an
> > > > > +	 * error occurred in the first step (and thus stopping the loop=
 with
> > > > > +	 * state =3D=3D 1) then there was an error before or during the=
 attempt to
> > > > > +	 * start a session. Therefore we shouldn't attempt to terminate=
 a
> > > > > +	 * session, as one has not yet been created.
> > > > > +	 */
> > > > > +	if (error && state > 1)
> > > > > +		end_opal_session_error(dev);
> > > > >=20
> > > > >  	return error;
> > > >=20
> > > > The flow here is a little too condensed for my taste.  Why not the
> > > > plain obvoious, if a little longer:
> > > >=20
> > > > 	error =3D error =3D opal_discovery0_step(dev);
> > > > 	if (error)
> > > > 		return error;
> > > >=20
> > > > 	for (state =3D 0; state < n_steps; state++) {
> > > > 		error =3D execute_step(dev, &steps[state], state);
> > > > 		if (error)
> > > > 			goto out_error;
> > > > 	}
> > > >=20
> > > > 	return 0;
> > > >=20
> > > > out_error:
> > > > 	if (state > 1)
> > > > 		end_opal_session_error(dev);
> > > > 	return error;
> > >=20
> > > No problem, I can use this version. But I think there is a minor issu=
e -
> > > the same one I hit in my original change, just from the other directi=
on:
> > >=20
> > > If the loop succeds for the 0-th element of steps, and then fails for=
 the
> > > 1st element, then state equals 1 yet the session has been started, so=
 we
> > > should close it.
> > >=20
> > > I think the condition in out_error should be if (state > 0).
> > >=20
> > > Best regards,
> > > David
> >=20
> > Looks good with Christoph's suggestion (for 14/16) and your state check=
 fix
> >=20
> >=20
> > Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
>=20
> Hi Jon,
>=20
> What suggestion by Christoph you have in mind? I don't see any for 14/16.=
=20
> Currently, in my git repo, for this patch, I applied Christoph suggestion=
=20
> for this (15/16) patch + the "state > 0" fix. Is this what you mean?
>=20
> Best regards,
> David
--=-RYrHxVYtogaybJPjKbIc
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDIxMTE3MjIxMVowIwYJ
KoZIhvcNAQkEMRYEFJWC5vRXlLxr2aWRcueSxtaQoKE4MA0GCSqGSIb3DQEBAQUABIIBAHlLrnD1
Kp+7TWMszjMyQnIu2niGAItDVxzMOI+Uq3Z70VAUlNNFjn0H1LxJK0vjGCrZd65yF1sBVgHrrf/9
Pxm7nw3QmtPgzh3SoGz4/djvXEXSqGg8vyP7AlLoBcGH9XuCUcnmfuV36Fr6KdXgQ5bRqgaauCYk
fvdo8RRYIyBT9jZ2Ir7QmDTK+wJgyaQO/A+YBvwdR+0UsnWmX/r3FiDmKpq1B6VdBzHkoofxFw5u
yzVUu4THsqMSL94p2R9J2CLShN+/4sQvZl4PYOUJTQhFroKWbkz8f5zWGJc+aOS0wv83o8K7zQDk
VBmv1npXHcekG1Fxc9X23rXei33B9dYAAAAAAAA=


--=-RYrHxVYtogaybJPjKbIc--
