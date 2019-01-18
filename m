Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF0C07EBF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13E320896
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nqj4MrOR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XJKWJeE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfARTKs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:10:48 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36130 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbfARTKr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 14:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547838670; x=1579374670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NfbzGNNjPR8kChZasInzoYeopGGIUkGMpKZdGjX4Bg0=;
  b=Nqj4MrORWJEuVKl+98KW4jOlX2p7SRZiVmirZ69fRlAA+e1tXXRdyBlc
   6vud4aiukTvoUSo7FNxVJojUDIZSndxTI1LINqFS/tYKi5fpi3L99fDdh
   gtJv5u1NcacHqX0UGqsByH/2f55SdJBMLgeD+eenvmoASsyqUuMsAJL6j
   kTJxhfO11IupNnXbmPx1nkthElVM6a405jDoWxEY1ycIr8RpxgvDykj+p
   6Tdl0wax23RFQKf0MM256RbOCScpyeRy3mCveYEpKMNdPHPlLvhhyehOi
   77US0HLJFuiXYR08CoSux57FRuR/GVnI9XY4DNtU8PYjLDMcPhCX3zQR2
   g==;
X-IronPort-AV: E=Sophos;i="5.56,491,1539619200"; 
   d="scan'208";a="197251304"
Received: from mail-by2nam05lp2057.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.57])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2019 03:11:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hYpYFqTSYyofRGf+hwSEXmdFA3Q7SdsApxICZpq/Q4=;
 b=XJKWJeE16ZexWmttXXfk1oa8cOWRxMChInasTEuT1lO2acU8VjbN0B0xXDT6z0EMBB72GspkWV8KgBZ38r+KU+fxExAcRM6cyOfL9GpkYdRrOPt4JvtrZoQOKg0UnjO7Z1PQY3IskAGADhf/Fra+FZVxPmSVI6bYs7NGItl0JL8=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4135.namprd04.prod.outlook.com (20.176.250.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Fri, 18 Jan 2019 19:10:43 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667%3]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 19:10:43 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Omar Sandoval <osandov@osandov.com>
CC:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: Re: [PATCH blktests 1/2] nvme: enable buffered_io for file-backed
 namespaces
Thread-Topic: [PATCH blktests 1/2] nvme: enable buffered_io for file-backed
 namespaces
Thread-Index: AQHUrmR4qRT1ezDLmE2OtZRZp8tpgKW0H7twgAB/IYCAAMZo/w==
Date:   Fri, 18 Jan 2019 19:10:43 +0000
Message-ID: <BYAPR04MB4502509DB53BE33C7383F7CF869C0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190117125906.15479-1-jthumshirn@suse.de>
 <BYAPR04MB45024AB8410374A9B1AD81A186830@BYAPR04MB4502.namprd04.prod.outlook.com>,<20beebf9-f582-08b3-1905-8a246f12268e@suse.de>
In-Reply-To: <20beebf9-f582-08b3-1905-8a246f12268e@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4135;6:s0lWeqZAWdc5I3eavqbNR6WPZ3IsU6U/ijRRmUq28qfN82160E/sZ3ukUEnFW2jYEzzJTBuxmCOe/yV5H31UTRt9Msgbiszs0NrQpLSUGl8qOvT9cTPdtxZQWTYfXWSSxIfp+MrBGgYQ3xnNZHDMWwFoD9ssHbg0j8YAFqZpBxSd4eNlGVSbtBmkrGMtdw3qLzySeGkErIbgqBx1ovYTj9tmL7zFQW1DVt0Mjfjlzf4aI93YwIMjCRex2D0z+ZMd1kv02yOoubGNTJ+tCy2UuS4QrRCrzBCRLljwi9wrDJJk/l4H3gPQMbU/NoK0stuTSkt55L6MuEoJD61M7SCk7UCXevf4dL6dqoxCQFtXONbKQlezRpWl9hEAhXNktX1hIZNKACp0cO8/2PQ3nT05FfbEHw/NAetXsjbTMaDEgJRvTFFbRemdaKHsFnfZp8XhGnnz5lt62tcUdlKByD1LAg==;5:TQQJ7agjIlE9r9ZWAJ0CaAGrfhiAnRoQUqF7nF1u8NYsQ9gbUmwGSiDGceeCCvudyPYQG7GkYWGW1G6Iv4FvdnNPd4ct/6YM0gsawZc2qixiNSq2dqOimfaXIfSc6dk9M27d2JtRMNyruo0K654ynfVIps/59j4xFc5Ak5IrGj2G4C2m1UnmpsKTn9HD9r+M4gWUIkaczX4Nxca3E3o5XA==;7:VstamRtI1XRr4h4Sjo6oTP4u6lF6w5wONnuuSr3hxjK8Lgcov1o0cupTU6uA6TSOXgAB8BYGE1h2kk/hd5GnDkkwZiA6s2AQRuOu5Uog7LoGRl+dr70GI60zT56T1JOkiZBEDMWjrZvZ8ER2UZh8sg==
x-ms-office365-filtering-correlation-id: 04742c69-afed-4345-f2b4-08d67d78a4e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4135;
x-ms-traffictypediagnostic: BYAPR04MB4135:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB41350AC478ABBFBC54638C75869C0@BYAPR04MB4135.namprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(26005)(3846002)(97736004)(25786009)(99286004)(4326008)(66066001)(6116002)(102836004)(14454004)(53546011)(6506007)(5660300001)(53936002)(478600001)(76176011)(186003)(6246003)(105586002)(7696005)(33656002)(256004)(72206003)(110136005)(106356001)(8936002)(86362001)(55016002)(316002)(74316002)(229853002)(9686003)(486006)(81166006)(68736007)(8676002)(11346002)(2906002)(81156014)(7736002)(71190400001)(6436002)(446003)(476003)(54906003)(71200400001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4135;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hFaQNver//qjyvE1htiKZdLc6e1FMMogFXLTXKS7T87VS09TkAxMRn307pkPL4CUZLZgqprIIWeHF5L3GR4ksP6WEtuzeR8Q9I3Mvs7tB8JM/29Iy/pyUeIIF50S/wlgBVkxeUdvmXv7CsbrHG5yS4U1xmtr0mOzVYqKO3yalCToV4UkXujCjKbiKz4UmK+Vebp5+iKkVxMuOYY7aLhqYRZCg6InC94d1Ig4Hf5JVqKNwNsascNnMth918DzUteWcDY4o5fmlEkMqyERkEhXOanYqrhabOdJ1NxJdSd8DGXYIMFYQpDHep/1fUG+TPNPTtbTCiGJYDr+lGqjXLUeHQsD7nGEd4SBn9t9lomonObOFjYRB14CVdw3WZCpOzpBtpBL2O7D3gefg0J7Aw6cK+H2dKANLzZdqCMAeKr1L9Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04742c69-afed-4345-f2b4-08d67d78a4e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 19:10:43.3171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4135
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

xfstest has the following nicely written routine may be we can re-use that?

from  git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git, ${XFSTEST_HOME}=
/common/rc :-


  2185	# check that kernel and filesystem support direct I/O
  2186	_require_odirect()
  2187	{
  2188		if [ $FSTYP =3D "ext4" ] ; then
  2189			if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"; then
  2190				_notrun "ext4 encryption doesn't support O_DIRECT"
  2191			elif echo "$MOUNT_OPTIONS" | grep -q "data=3Djournal"; then
  2192				_notrun "ext4 data journaling doesn't support O_DIRECT"
  2193			fi
  2194		fi
  2195		local testfile=3D$TEST_DIR/$$.direct
  2196		$XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
  2197		if [ $? -ne 0 ]; then
  2198			_notrun "O_DIRECT is not supported"
  2199		fi
  2200		rm -f $testfile 2>&1 > /dev/null
  2201	}
  2202=09

This will require to have xfs_io program.


From: Johannes Thumshirn <jthumshirn@suse.de>
Sent: Thursday, January 17, 2019 11:17 PM
To: Chaitanya Kulkarni; Omar Sandoval
Cc: Linux Block Layer Mailinglist; Linux NVMe Mailinglist; Anthony Iliopoul=
os
Subject: Re: [PATCH blktests 1/2] nvme: enable buffered_io for file-backed =
namespaces
=A0=20
=20
On 18/01/2019 00:46, Chaitanya Kulkarni wrote:
> This will force the user to run all tests in the buffered_io mode.
>=20
> What we really need is a config for the nvme category option which user c=
an set and decide
> whether to run buffered_io or direct_io, you can set by default to the bu=
ffered_io mode.

We could also introduce a check if we can use direct IO on the
underlying FS, but the only way I can think of from a shell script is
doing a 'dd of=3D$TMPDIR/testfile oflag=3Ddirect' and then populate the
result to the helper functions.

Chaitanya, Omar any ideas?

--=20
Johannes Thumshirn=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 SUSE Labs Filesystems
jthumshirn@suse.de=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
    =
