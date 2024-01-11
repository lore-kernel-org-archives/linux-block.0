Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A4184D
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oW68ifVM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v4ru8V7N"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704948122; x=1736484122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yG4cYkpOmuK/SI9/tacK5HxClgfMlDfaIhxbO0aRL08=;
  b=oW68ifVMSd4FDQVUAFGPHBr3CKDFivSIztb6yW36qOB+NZErpZUVZ/ZA
   c2D3r8J25Kf5WpBedNdfpOXX7iSzuqgVjPM7DiNJOAYFyTGIjpw602STf
   /DRnWqvzgqV+QgBFOlMVJxA5Q8IhdCBn/SX8aMWokhHwYklQvfhUhYa76
   YpRlpHxEMwHLkLQU7jEyGQDzhV2Vn9tLw0rmy9rj1QSDIgYrjDwSWCo5k
   yoqtn3+9ZfdZ1ZYD9dX4nI/+vjDDNsog/DZCe7sI4VGlUlAR68snN67Y7
   zQGCLPExV03y5LV2vO2OdBbBJ4Hs2/QZhvKyni7//KBkKbjUyTLLnmtTA
   w==;
X-CSE-ConnectionGUID: 1KLBPcx9QKKCwaKTeo61Ww==
X-CSE-MsgGUID: xsf/Q/o8QUK4rW7v1AgiFg==
X-IronPort-AV: E=Sophos;i="6.04,185,1695657600"; 
   d="scan'208";a="6638324"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2024 12:41:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7/9gbltX3CxZTB+G/7a1Q/Sy3MoscNfapJivnJmXf0P77tivlPlW+Mz5sUkOekp6MKR3bcZ2Efnu3zwILZDlHTaIHB9b5rpSeaxyqHzBPQ6Oal2twXWLW9TBjfT73rJuQGThSkT78k+bwnRq71upU67Hxm6UH3weP9XJ52XjSmjG8rPZVJsMZSULaRDpkXl4mKdX1Rn+6MwPnqmvljNdlMzAeW6LdXhtJhkTLo+FcogyYQ78r8zrz5R2wAlh9YLYunuJXX6v0PCSG/I2Bg3rWelh9xvQN1UVV0Anfd+eMWmGmyD4+JM/KA3+NMpWhe7NEJVh0I5Q07tiHU+gng6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pVH40+gzxRl7FrxnO2acuznIHv1NN+oceRXcAsDcRM=;
 b=T3y2IjrYvgCAMDuaQsSjS+HviZfwNiKsuX6eT6fZqDdWyZih1aK48mivqbtSSY1lan9nllbfbzr4nSYgZMN6QTh2Vu5l2zEkBoAkP9bQ/gbMh4pAPOM5L8gPzJxcWmhI2kiFHEWnezU+6Y2TvttGwuLKweNaxsgXUV7zs6c6nGF9F4/R+ieuELTmNjLbtHc4vM2luHns05lNOmhlhb6EuBc8dvDTQqKOhnq0Ze9kFkXft3l9Oa5/WZZUyZ4wLyxku40mH8WpGurj0xVOBK5MIIrG0tzRPMRcI4KVShbYvWiF0p2rx/KUTRbbGPtB4lJcbnec14jxpw21+QqbM0kRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pVH40+gzxRl7FrxnO2acuznIHv1NN+oceRXcAsDcRM=;
 b=v4ru8V7NDLSDWX7oVQg7W+NeJ7aUuajyEZ1ZFSP07AnyEm3oWa5uQUtS46Q0cqkmC9ECfDt+OAwSd+KGaITV3qy2UNQM7Wvrx4e7d03ha6I5p2BTkuonvC5qPO8/zspkcxJWqRDh73z6klFeLGSzQo8bAOwtCvplDfkkqu+l9ko=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7720.namprd04.prod.outlook.com (2603:10b6:510:4c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Thu, 11 Jan 2024 04:41:57 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 04:41:57 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH] nvme: add nvme pci timeout testcase
Thread-Index: AQHaQ3lJXWqCfG9takit+D8rUbx257DS+LUAgADCrwCAAE6rgA==
Date: Thu, 11 Jan 2024 04:41:57 +0000
Message-ID: <vl5nvm2ozht52g4whdscteizyayeuyhgfi5yzpzvuboo474zmi@3eaabtwu375h>
References: <20240110035756.9537-1-kch@nvidia.com>
 <wa3xm2v53vsgcs3iv4f3fy477zza6uwxj64dwib6ib27kmkgxj@ovgndmtcpzch>
 <f730071b-1183-4266-8a12-0f044b8f9bc3@nvidia.com>
In-Reply-To: <f730071b-1183-4266-8a12-0f044b8f9bc3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7720:EE_
x-ms-office365-filtering-correlation-id: 49954d29-9b65-402c-62d6-08dc125fa4a6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1qHktDXnFwgFFZuE/YIsUmkPitJnoNwTsncMkkHv/2Rpahskglhc6mSQpWpfRKUbmCv4Yld7mVK1oURGMUxZSwSdwqK+OkxTB7zdjUZWtPKKRKQnV5r0bjkMdRpB5O8TFiOIWDB4ybSecKmKoEVK2aeAf1W9Z8udPimczbG0l0UUd/xdHTQETDdGDintLHmX0rNNT6VzhKgy6qtSp19VQzdDgW13rEuTsc6lvo7a80sc0vWgLhwc7E/H9hcReYdaJbQlfgmro4s4PO/MPjDgC5nodbAirX9iG1L6qBRRxM9ZKb2ijQGpHHL9+2EDozfTZNiucx9DvNA9jlXkUhmj6jyg1zzRhClK11TjteudQY8+LEmeZ+mKcHQgMXHmuGZczUa3rQh05EvCpCpbu8qYUH8FxxijmTLIwx7Ckdx5yW0FoNQ/UbKMSW4buAG5qNNtxCert0qzjQXsDX20ojtmqR4S66L69jYJRAPRO/xOqWlH5gWgiJBtol7sYthRHANJ2a6DgSlJMia+1YNGBOwBipafy8WiiTD33EB0Da6gOQxALZdd1OjEqh4DHFyKr49UOvnZwNEEmvsVOpm/bKuLHSeSKIi7wnMYrE5We3EAZtQD8Rs00foUefQmE/DRewlX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(53546011)(38100700002)(26005)(122000001)(33716001)(71200400001)(8676002)(4326008)(8936002)(5660300002)(41300700001)(2906002)(44832011)(6486002)(64756008)(6916009)(9686003)(6512007)(6506007)(478600001)(54906003)(66476007)(66446008)(316002)(66556008)(66946007)(76116006)(91956017)(86362001)(82960400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Flc4Bmtpnatlj2P2FMM7s2CkzMvrz9c/D7YBvude2xSdys8Mu0vFWVP81f4t?=
 =?us-ascii?Q?iM6+/vsa5/MltxN4iqLu4BFlorRhCs/YP+YSfeUbmr2u7CIhBMj4llHC9/rX?=
 =?us-ascii?Q?kg1MIWXVC1EQYgsa2lSwp/UyJT+PUFnzpF135TCh6btzZbhMqDDp3L04mF/P?=
 =?us-ascii?Q?2fEEKvJn9oHUpgLdBcAhV9wrUrvIhLWQPYreLEW0V+BY8Yybn620kdpj+P4E?=
 =?us-ascii?Q?+ZrZl4NAv55EwXyopin6/Nqy2sGFVtOYDYL/nh6C++FUu9KeF8Swr020sRki?=
 =?us-ascii?Q?Snxk6iXAKTRmNYByIysqpKAk/WqNibtfk3AX5Md6c4dtJ4ohlxBKCy46LWEI?=
 =?us-ascii?Q?0MBtbwWU8SUntuNKA//+EduiZDBzuw7C+8/9S9+76Ijj5b3hRizg3Ktba+W2?=
 =?us-ascii?Q?cluVwOfNO+BvisMbFLKtcE9WRrtBPGLx63GkEXb7WO2VU2kv3TJ5PUPWokwF?=
 =?us-ascii?Q?7kbQR2HqkVmNWum6UX5hCYQrrdigWLDFnorSCc7Y4uB5O3kH8Q3c7t+2qEhu?=
 =?us-ascii?Q?/CfVtVsJG2aLnWjXK3fbpeBNQkpd/SsKpru7G9ghTELWUByNLzpz5qGTsc9O?=
 =?us-ascii?Q?sZVW7yMzYeyazrYgjzn34wPe123Z4is+oKr3jXGvDrvGzIblr9itHQgPcBmT?=
 =?us-ascii?Q?O/gTH6TYKBwu/l/8u8fOqrCagT2PSHmlVihu3BLUl76nmCME+40Oj3iuO9FO?=
 =?us-ascii?Q?RVYDu85PxPiiOqWdXJXkTAA+dTe6fdmSyI6/Kql4brimqOsw0VqdTJ5pUA88?=
 =?us-ascii?Q?R6e9gZoO1XFmlwPBc38OWEr9s8xZ14WgcZarQFpx3iVCm/tb9gnPe41KLJPN?=
 =?us-ascii?Q?YU2cjmaIS8LdSFPYBlzVqxiAPsx/k56GoCpXyBAzhGlDqHwqXX7rEHBNmF4w?=
 =?us-ascii?Q?2sPlVoQiZSi46XNOEc3yJufPStOzuOoN7JtdOoPZfWIjQMQc7sIOQzhN+PZV?=
 =?us-ascii?Q?XGK3As9nVLCxXAbEK8yFwP//6opkcC8Ekg8JInT/4T6h7NCCfOJr4rMMQv5x?=
 =?us-ascii?Q?pFUIvdHI2BY/+nWkdy9iCIYGCCQAe4xkVhQBQSgKKsDkZvUETwFhkbNKuW0C?=
 =?us-ascii?Q?+6b0qd1ZPekt94YUSgZe4+5kOE/bheATqQX9V92HGguKgtuHxJvoEeqAD0lO?=
 =?us-ascii?Q?GiTj7e/Crf4G4pchPhd0CoZb/BKioho1MUUJzZVEDptZGcVvuqdKifGRBXhs?=
 =?us-ascii?Q?C4SBBEyKzoVTKAEYb5aEVqGyhi7Ea4b9H0WQRbRBY+rrwKALWdKua0AXP/74?=
 =?us-ascii?Q?ATWB15mG3xiIrlk7VM2Zy85pQjhW0JdKkEDerIdDEKKY0Nkm6Mk7fkZwtooq?=
 =?us-ascii?Q?iDi4v2F60wwEFkq7pQxozvhe2NPyucBsrL/qOwB1bAejXCq2Y/fCuPeTAqxX?=
 =?us-ascii?Q?IqJY76qIIWJ1Jiy5a5AGx4uMM4jJLB5cZS9mSQ6IgRWJBCiidR4o7cCzv5cu?=
 =?us-ascii?Q?OPqXvBg2RB/Uy7wwjRAtFa9Hk+aP6hUQCzieKEpADWp7cuDLiKITyYl4dNtH?=
 =?us-ascii?Q?Yl80Ejx6s9Ia+As0ub7+ww+lahcN4nnAK33W4hwiO/o3DKvB4hWpSaDKhD35?=
 =?us-ascii?Q?6+dBEXhGp23jHSaxk8mb2taTG14cf4IfGG5wsKrthR7CJA9AR5crZms3xC1d?=
 =?us-ascii?Q?wwL6tLy+h9bkEdmOGRymVec=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE59E749DEA18D4BA9805D958C34A0CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rgq5pJngZOui6a5uIJ834vabY6oKsr1+qvUev6QZntVYKUIahflvkPbb3cU4XNYZwybjYhvgADZLt8faa2G5vqL0lpry2IvoNWE6qIhe3zzDyVJwjBetojE39P1YfnkXA0M9+ycI7E1FsltOxgiiELCR608IYaKMYPmVLEY+ykCBiXRsIjYKIgv8EHH1v8xBJeXvhVnKAhRDDGF9HOWcq7INFC50Sy/Q5QJEyRchou7wJGODrFa29tP60TLxQ1xQRw3ysu14dRnZWFFj9v7B/PxknnF7yAkoF7zdheLxPNw+bYiam60rwyNn0mxvACA4VMgzAXL6+fO6I3pRw2FJdWykh/8X6vzmUwE4+NESbffA99t4GH/jZSUr6ffnBm6zUARsWQBsNUB6D5TNY27qYXJU1Y7sGgfKbArmiEMC/GTtAO+7+mpUvzpXZwajpulj6e4MxBQZYT/ooYIrVaKev4pr6jAcQFRPw7HdLnuxFKzzF1hXx8ghLEFPYfCLa51OSQi5zle/RGO0fob2S8wDxQwIjbaezZN3FywkLgO+3akOUFPLY8Zay6QwsDpmH5gdrotViUnWfCvwTs56wGyYESDU/66vrU74XCpDD3mZOb3+ra8w2/yB7pVqLBp5lT6u
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49954d29-9b65-402c-62d6-08dc125fa4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 04:41:57.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpIL3e3kodVa9vpw7kJ5u0ihNKGYvQS3oCJTs0lTRCooFNKNKPbjyJzmfm1UHzfaPgMVRGwwcTefpdquN2P34ChlLw5NgIPoB80jG3B67EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7720

On Jan 11, 2024 / 00:00, Chaitanya Kulkarni wrote:
> On 1/10/2024 4:23 AM, Shinichiro Kawasaki wrote:
> > Thanks again for this test case. Please find my review comments. Tomorr=
ow, I
> > will try to run this test case.
> >=20
> > On Jan 09, 2024 / 19:57, Chaitanya Kulkarni wrote:
> >> Trigger and test nvme-pci timeout with concurrent fio jobs.
> >=20
> > Is there any related kernel commit which motivated this test case? If s=
o,
> > can we add a kernel commit or e-mail discussion link as a reference?
> >=20
>=20
> no, this part if never tested on the regular basis as it has some
> complicated logic I believe it is much needed test ..

Okay, it's good to expand the test coverage.

...

> >> +}
> >> +
> >> +test() {
> >> +	local dev=3D"/dev/nvme0n1"
> >> +
> >> +	echo "Running ${TEST_NAME}"
> >> +
> >> +	echo 1 > /sys/block/nvme0n1/io-timeout-fail
> >> +
> >> +	echo 99 > /sys/kernel/debug/fail_io_timeout/probability
> >> +	echo 10 > /sys/kernel/debug/fail_io_timeout/interval
> >> +	echo -1 > /sys/kernel/debug/fail_io_timeout/times
> >> +	echo  0 > /sys/kernel/debug/fail_io_timeout/space
> >> +	echo  1 > /sys/kernel/debug/fail_io_timeout/verbose
> >=20
> > To avoid impact on following test cases, I suggest to restore the origi=
nal
> > values of the fail_io_timeout/* sysfs attributes above at the end of th=
is
> > test case. _nvme_err_inject_setup() and _nvme_err_inject_cleanup() in
> > test/nvme/rc do similar thing. We can add new helper functions in same =
manner.
>=20
> I can add the code for config and restore, but at this point there are
> no other testcases using this ?(correct me if I'm wrong),

This new test case is the only one user of fail_io_timeout, I believe.

> so instead of
> bloating the code in nvme/rc let's keep it for this testcase only ?
> and add common helpers code later once we have more users for this
> case ?

I think either way is good.

>=20
> >=20
> >> +
> >> +	# shellcheck disable=3DSC2046
> >> +	fio --bs=3D4k --rw=3Drandread --norandommap --numjobs=3D$(nproc) \
> >=20
> > Double quotes for "$(nproc)" will allow to remove the shellcheck except=
ion,
> > probably.
>=20
> not sure I understand this comment, can you please elaborate ?

I suggest this:

diff --git a/tests/nvme/050 b/tests/nvme/050
index ba54bcd..8e5acb2 100755
--- a/tests/nvme/050
+++ b/tests/nvme/050
@@ -28,8 +28,7 @@ test() {
 	echo  0 > /sys/kernel/debug/fail_io_timeout/space
 	echo  1 > /sys/kernel/debug/fail_io_timeout/verbose
=20
-	# shellcheck disable=3DSC2046
-	fio --bs=3D4k --rw=3Drandread --norandommap --numjobs=3D$(nproc) \
+	fio --bs=3D4k --rw=3Drandread --norandommap --numjobs=3D"$(nproc)" \
 	    --name=3Dreads --direct=3D1 --filename=3D${dev} --group_reporting \
 	    --time_based --runtime=3D1m 2>&1 | grep -q "Input/output error"
=20

>=20
> >=20
> >> +	    --name=3Dreads --direct=3D1 --filename=3D${dev} --group_reportin=
g \
> >> +	    --time_based --runtime=3D1m 2>&1 | grep -q "Input/output error"
> >> +
> >> +	# shellcheck disable=3DSC2181
> >> +	if [ $? -eq 0 ]; then
> >> +		echo "Test complete"
> >> +	else
> >> +		echo "Test failed"
> >> +	fi
> >> +	modprobe -r nvme
> >=20
> > If nvme driver is built-in, this unload command does not work.
> > Do we really need to unload nvme driver here?
> >=20
>=20
> Yes, post timeout handler execution we need to make sure that device
> can be removed at the time of module unload, perhaps there is a way to
> avoid this when nvme is a built-in module so that test will not execute
> above ? any suggestions ?

I see... One idea I can think of is to remove the device using PCI device
sysfs. How about the code below? block/011 does similar thing. To do that
for TEST_DEV, we can use _get_pci_from_dev_sysfs() in place of
_get_pci_from_dev_sysfs(). Does this meet your intent?

diff --git a/tests/nvme/050 b/tests/nvme/050
index 8e5acb2..592f167 100755
--- a/tests/nvme/050
+++ b/tests/nvme/050
@@ -17,6 +17,9 @@ requires() {
=20
 test() {
 	local dev=3D"/dev/nvme0n1"
+	local pdev
+
+	pdev=3D"$(_get_pci_from_dev_sysfs /dev/nvme0n1)"
=20
 	echo "Running ${TEST_NAME}"
=20
@@ -38,5 +41,11 @@ test() {
 	else
 		echo "Test failed"
 	fi
-	modprobe -r nvme
+
+	# Remove and rescan the NVME device to ensure that it has come back
+	echo 1 > "/sys/bus/pci/devices/$pdev/remove"
+	echo 1 > /sys/bus/pci/rescan
+	if [[ ! -b $TEST_DEV ]]; then
+		echo "Failed to regain $TEST_DEV"
+	fi
 }


BTW, when I ran the test case, I observed the test case failed. I took a qu=
ick
look, and saw the nvme driver reported I/O timeout in kernel messages. But =
fio
did not report the expected I/O error. Not sure why. I will look closer whe=
n I
check v2 patch.=
