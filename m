Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FEBC04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 19:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C44621479
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 19:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfEITbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 15:31:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:60788 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfEITbP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 May 2019 15:31:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 12:31:14 -0700
X-ExtLoop1: 1
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2019 12:31:14 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 9 May 2019 12:31:13 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.162]) with mapi id 14.03.0415.000;
 Thu, 9 May 2019 12:31:13 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
Thread-Topic: [PATCH 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
Thread-Index: AQHU/6tnJPjYcz7aREior5rwNXuvoqZWv1iAgAOVRYCAAsM0AIAGmZiA
Date:   Thu, 9 May 2019 19:31:12 +0000
Message-ID: <8342e25cc9d6e84c620d54c6cbe0f7244ebb7de1.camel@intel.com>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
         <20190501134917.GC24132@infradead.org>
         <alpine.LRH.2.21.1905032058110.30331@linux.fjfi.cvut.cz>
         <20190505144330.GB1030@hacktheplanet>
In-Reply-To: <20190505144330.GB1030@hacktheplanet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.4.116]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-YCN78LGfkXmWnf27gyZc"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-YCN78LGfkXmWnf27gyZc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-05-05 at 10:43 -0400, Scott Bauer wrote:
> On Fri, May 03, 2019 at 10:32:19PM +0200, David Kozub wrote:
> > On Wed, 1 May 2019, Christoph Hellwig wrote:
> >=20
> > > > I successfully tested toggling the MBR done flag and writing
> > > > the shadow MBR
> > > > using some tools I hacked together[4] with a Samsung SSD 850
> > > > EVO drive.
> > >=20
> > > Can you submit the tool to util-linux so that we get it into
> > > distros?
> >=20
> > There is already Scott's sed-opal-temp[1] and a fork by Jonas that
> > adds
> > support for older version of these new IOCTLs[2]. There was already
> > some
> > discussion of getting that to util-linux.[3]
> >=20
> > While I like my hack, sed-opal-temp can do much more (my tool
> > supports just
> > the few things I actually use). But there are two things which sed-
> > opal-temp
> > currently lacks which my hack has:
> >=20
> > * It can use a PBKDF2 hash (salted by disk serial number) of the
> > password
> >   rather than the password directly. This makes it compatible with
> > sedutil
> >   and I think it's also better practice (as firmware can contain
> > many
> >   surprises).
> >=20
> > * It contains a 'PBA' (pre-boot authorization) tool. A tool
> > intended to be
> >   run from shadow mbr that asks for a password and uses it to
> > unlock all
> >   disks and set shadow mbr done flag, so after restart the computer
> > boots
> >   into the real OS.
> >=20
> > @Scott: What are your plans with sed-opal-temp? If you want I can
> > update
> > Jonas' patches to the adapted IOCTLs. What are your thoughts on PW
> > hashing
> > and a PBA tool?
>=20
> I will accept any and all patches to sed opal tooling, I am not
> picky. I will
> also give up maintainership of it is someone else feels they can
> (rightfully
> so) do a better job.
>=20
> Jon sent me a patch for the tool that will deal with writing to the
> shadow MBR,
> so once we know these patches are going in i'll pull that patch into
> the tool.
>=20
> Then I guess that leaves PBKDF2 which I don't think will be too hard
> to pull in.
>=20
> With regard to your PBA tool, is that actually being run post-
> uefi/pre-linux?
> IE are we writing your tool into the SMBR and that's what is being
> run on bootup?
>=20
> Jon, if you think it's a good idea can you ask David if Revanth or
> you wants
> to take over the tooling? Or if anyone else here wants to own it then
> let me know.
>=20

I'll get back to you on this. Let me know if it begins to pick up a lot
of steam and I can prioritize this.

--=-YCN78LGfkXmWnf27gyZc
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDUwOTE5MzA0N1owIwYJ
KoZIhvcNAQkEMRYEFHk98NfJtBUAjEXUevIjndasiw+KMA0GCSqGSIb3DQEBAQUABIIBACu252H6
bgx5XVoe9fEE74XocWaW+nCjI5pO8ExMcRfchJW5IN77Z1oKHpT6k09Pb/tzmeOc5xDDMCHMabGY
o2diY+d61+7XfZg/obHbMK4T0JSpKX69JO1c9460y7/2Zcl8DWaerq0Tl37JQNetqnUy7MmG0fFa
XjntwcxkxmD7PjKX/JL7n9TcpwmCEQvp5fV/5Bj6In7ceUpJ6QPEIwG9EkidIfK8nAHjKw5zwpJJ
ccztCt3n8CVvZa3OMy0YsJz7rqWonmIEieeD0YJ2CLOYcGkdYVBm8LOwGCKcZ4g7Yrc14zcqZGs8
3SlbjGy3TBKMIJJYTlRRaC4pyjMrelEAAAAAAAA=


--=-YCN78LGfkXmWnf27gyZc--
