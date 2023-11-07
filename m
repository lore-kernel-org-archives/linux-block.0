Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1DA31
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WLbpwJ9f";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="izYikuCO"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32598114
	for <linux-block@vger.kernel.org>; Mon,  6 Nov 2023 21:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699334963; x=1730870963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JIn7Ir88IS1XMt59AEJRrPbdqWUaRQqyyJfTwstDjeE=;
  b=WLbpwJ9ffOssyOOD9J9tmlcXHjyBKvTQGDvF7Pj+jkXIPSxdnltYL0Mk
   +kxT/c2OnolGJwBYdGYFRBx9hfN8LcdJQ8ke3B2TiUrbblZJJCmu1rh7S
   IkZEFhb5q50aL61lOWcYEqQOy70CkeBXISIrixK9medwIK/cor/eqpoz5
   l3kf/DC6Qrx8u8YJp8XBSBAlR+8FOYrdSTM5BQmQuouMIWL7c2WmFW4yr
   4+7d0ur32dXl6j96/7B7GXkANmhQftuRGrXa+Jsq4//ScvX5mxWGIEG11
   pUycH/M12mB9dncBTvjRz65WdQfHvH7LiHlf104zN9yZLnvUYyZXvbL0A
   w==;
X-CSE-ConnectionGUID: jAjNK0LwRwaNQ9NrINgZGw==
X-CSE-MsgGUID: dFryvE7gQUmgvOVwwU6FIg==
X-IronPort-AV: E=Sophos;i="6.03,282,1694707200"; 
   d="scan'208";a="1520392"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2023 13:29:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laLwLHu1b+jMbHZtB9e5mPpBhobuqAVyh7jAbQeRV6QPl6vbXaWBBESnBrR0pHRhqPn8d9hwBdKWFpWGexQhDhMbI93nhjcm+JNpUqEyhO5mRUsGM3qiLogM14eg6XnDQ9ijNUzythplSi9xORA/EOjuDB3ZmhO74/wNodURI3mawOsrjpucYPxC9kF2UJ0SnKusDVKz7quUwajQFmDly/Zq5LkKEqZdQy7TAatDlMCErhEP132u8OI7YmukSEpISC+h6lKzFI+SazQmFI7gkmDs4TEqEhhWimccRCyq51UEoMvxjCTJiPR256G+vW4Z1RV9I9jqSxsTNoVsRKlw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDMLaLZ3mbT4dUj4m/kXIOJLsCgBbTynbiOzlt7QTiE=;
 b=eIDRmBElvfkTh7W3F5aAJcNqVJVMeNytJJ0x/pobGfq6ssLhbqx7lRTmc8IxyQoEVERN6lCpyXj4zEzlIFkCnN025muJ81N01kbLJ18KkYl/rEx/VXy028mIbiLbavlyHvNYIESqyJUqiJlXxYkZHW0izVYFiFChlf5iYv2QOkfTBt7t/R/1FDb3tjkU+BpNPyevbcbas9C5gN4B8XwtkKDcXLxbfMnlCpjoxcb2ONB50BJflwrLjSkieKD9gzCNoHEYv4soCGcTUf/mXn7rnHbvnHopeVaScLf6o+3KXO6TuvzR2LCu1vx3BBxVwUYYsZswfy9o6ONg9zEZNEt/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDMLaLZ3mbT4dUj4m/kXIOJLsCgBbTynbiOzlt7QTiE=;
 b=izYikuCOIrJdIfdVz8tbqEwT0lhJB4dDnJ57vThsnOxbzCPZNnixgZWkiNomQpQJvCPInBqNA4NC7fkhi8zmxT1q0xSr7cjrQr8NmTZla4P/SbXYPNhtQYlnqpZFnxrglDaLSh7M74Nv59wGZxUK05uJljgz0fotsy1OqmA9V9E=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ2PR04MB8848.namprd04.prod.outlook.com (2603:10b6:a03:53a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 05:29:01 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 05:29:00 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] ublk/rc: prefer to rublk over miniublk
Thread-Topic: [PATCH blktests] ublk/rc: prefer to rublk over miniublk
Thread-Index: AQHaEEkuDleDrHoCgkiC14af8NolJbBuVgmA
Date: Tue, 7 Nov 2023 05:28:59 +0000
Message-ID: <snthk6n6lo6767rjxj7xeevgbebxjqzxhwouacqr3335l4xat3@hv4zaukbl6dy>
References: <20231106003523.1923694-1-ming.lei@redhat.com>
In-Reply-To: <20231106003523.1923694-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ2PR04MB8848:EE_
x-ms-office365-filtering-correlation-id: e1e949c4-543d-4f36-5a00-08dbdf527208
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4+POLyrY58UbIfL2xiGJ5k8TfgIbN0dJsvvn1liK7eaTDA4o0wzZ8VVy9OsfoPVKefOVsBl3YnJiqlHs46cZacgY/GKCYHG+BlcffKxccZ2IMo9FuhwNRRl1G/kS3qrtn2cS2vugf5auUPq7rE35gmcGzTwJoSciEngHDBWqB7iEi3ifGywgK9aEKAG+/a7pGyW61P+xLYKk3cFZ7smTXTsEFZlZCl1AmAHDz/2fvSHrpt9xLQ/kPa+LNuuXYPWTSK/vzYAGR2r7cqWprh5u162a1I6TGrBOF6UWYdmw5RXxuPGUycJa91nU9Vxe7592v5pkjxaz/KFYTXPFJJsueyp/PZUJqrUuFihHPKTQjQJB2WOrIpxQRwRLti1c57TCFlhxyWmC8U6ECHoDJVGfQhTofwQ3hDELLf+OSbXXLjb9DlTzAZa40dritYlCM9vW3vAjfD9NgJhH28u/td3BL7eDtOVw6kW4UE1APoHvvLfwMs/hIyZGSfleAJPunw9EfONAlC05xfuOYVAQlHQV5DDKxaIa/bqMrEB67g3kfYZ3DXqS+k/dSmwcSaVeQVVgLTfQAx+OPvkGb2rl8VaWPyUX9/e2GIsOBZBp+U4rL9k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(66946007)(91956017)(6512007)(9686003)(76116006)(26005)(478600001)(6506007)(71200400001)(8936002)(4326008)(8676002)(966005)(316002)(64756008)(66446008)(66556008)(6916009)(66476007)(44832011)(6486002)(5660300002)(41300700001)(38100700002)(86362001)(122000001)(82960400001)(2906002)(38070700009)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EmWbU2OupqR7hpfcpe5rQse9DLDuE1xQzCNWGvydukeN28T/OktdmxaTenwF?=
 =?us-ascii?Q?O5uqSXjjG22vyArOqamRD7ioB6jNUTynNqogkeFPuuafQpb6/82Oiu9g9FEq?=
 =?us-ascii?Q?/jCSS0kLeBL4NTUP+VPTVwJOBxlFDHA8TN8mtVfmxMVTO2PR0WDNnhKJqSXG?=
 =?us-ascii?Q?8ev3HrmPGuBemWFfQKJHmPesmcKalEf3iuZpdD9RLHSVcGJ1WUua3lWQ1Ef7?=
 =?us-ascii?Q?7Gr4R7qIGf81j8S8gXwiO9KL910KGGIdelthFVlOmjuFnSwaMV0r1nyzinVp?=
 =?us-ascii?Q?GbQqQU/JBHUHYFTWPnRQg59naZY0ekRMDBq+NDRKBeqIQMziQZ9Z116vmmQc?=
 =?us-ascii?Q?yGTtqz4zJH2V7Fk7v0o5HDL1vCQp812AlGt39XAyu3DcGknye0jWV+b0xt+Q?=
 =?us-ascii?Q?Sf8oavhzeRkUQt/aOtS7d5ORzAqTVZz8/S/vNrucQjShMFQt5Rt5b+BeCW0g?=
 =?us-ascii?Q?zn/tivIx/rYeC8CK6lfOgQVLVEjGuGcdwYm8Y8WfHo66X5IxaYhkZwSsf8eM?=
 =?us-ascii?Q?BFzSHiALHnFgO6/xRrMpnVfxqK6/hKSUxC/govVWutIyzS00M2aI04x/Ufzi?=
 =?us-ascii?Q?shqYjXLPC1FxX7DrKdNTUS50PukW9XAkqKYYIsSKPoIHbs8GbsGjRW19ViF8?=
 =?us-ascii?Q?jUbooSddeZgx2qkPEseecbqAS8P5P+/Ez7p1bGjmozFKCz91eVXgeE8vji6D?=
 =?us-ascii?Q?v0nQMXxqewPGPpsOPk5tN8HUTwsgI9C0E42oUop/Dse/AGEyT9qzGtwDaRyB?=
 =?us-ascii?Q?CIP+04w/f+qfNvC2depTITEbs+/65VaQ9vIKbaAIzwXAGWy3qCx5xSSXsCjZ?=
 =?us-ascii?Q?KLcLo1eUcJXc1b+8xymY/cw3Ep8K6xb8GWzYGnrcJeWAK3VKWl1ZR7HLF9mP?=
 =?us-ascii?Q?LkRHfY7eL9On9Cd8oWozM00iBcwZU3Bn52gtbe2Tj/Clq0n4Pw8+s8kjV7q+?=
 =?us-ascii?Q?nhD7GF4DuEJhHujxhfcAhLYfNEV36ahcPHzY6ZFZgDMmKLJamD7mKdnYqPa/?=
 =?us-ascii?Q?B7nmBb3coy9UMGS6sx1trJUGbDY2h2QOC2oGqWr5CXMlh9tx1hvzEqaBQgcw?=
 =?us-ascii?Q?lbbUpd3LuhX3Nkh+5z3M9bNJNccxJvF2K4PSaR7VHqcxLo/OI2sBUP6Yix27?=
 =?us-ascii?Q?rD0wi0KgNJLAcYlwj+ge2+KBFwO0EvtnL2dCOApyCrp4KYcdM8e6lc8y9DUl?=
 =?us-ascii?Q?sgsx+0apmmguQeeYae5P/UFoq3xzckyFdls+1XFhEawd8VyRwNX9hgd9+o7s?=
 =?us-ascii?Q?TH1gaFYBEK08M7EUk5AfA+Hy+mD42/jKgxCmXZyyjG/zzkU3fY6948yH4xYM?=
 =?us-ascii?Q?xseKMniBMjCxAt+OjBcLQrA2Mscv6vmGX1KtnuYsgM0P8XaAMfL4716Bsb6m?=
 =?us-ascii?Q?ZaZx37gm138jdoaWLgqMxihvYBU/a3ZIF8J/H2WAEdXDnu6lcNfeJQacPYSS?=
 =?us-ascii?Q?2qqlmguMLLnKKmgiqhoVAiussod+KWxGawVyWVjXIhsm6aMj5FojQldSdYR+?=
 =?us-ascii?Q?ixTVdnnC4jo4PqtmzGDse257x6HuvzggShTGY2sovZThAVisUc0AV2OQO+Wo?=
 =?us-ascii?Q?dlieW3UpdsxosiCMbxtSB6r2QL9k5Ad9x9KyqFouVsDYRyDEycXTx+LAirCv?=
 =?us-ascii?Q?UK0x6cbgfT8dnfla3jEf0j4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADCFCF3AAF8DC74D8E1728EC29313C04@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7mAZWzNVIL1n1i2B+gSXeWwTvyzYe0F/Q5E7l4+P2Yq51D8y/6fnlxHWu6s5SA3/JxCyS3Fdc9OL3w2mVESxg80oWW31u7urJZSEGFl23sv6RmAmkcUXRgYLm5050plGNm3zMYoZ7xvnIzGJuQ+FtzcfYBpmDcdfJHKz1GUCtlLcUceVEWvn7KjWg/tbEBO1oo424fGbXRffVfVOo6P9EVJFKzsvVkZPoZDN4TIzlBoGzkI1Unaj7ugMx05oeRG4RfHqbi8o1TtMdTf0vU1+4W5j7DiWynSwSECmnPv87FBcDGzDA6NoyjLJPrjHLuFwKS9/KVwouV8AnaCEOJgugRgyVezOhwLDfKVfqWLwSizHztdij9PF2MYZU6oRdn1UghBgom5Vt7gTNkMV9+YSX7bsr0BUuwGRUYIr1bTGSlV5w/R38XJ1G/P9F75BmCaUB3tvxvBmPbwfRTeirOmH/cLTqfsEodYbA5fqei/bRPaL7Yeu+JOyPrwvH2jg5ckK4QLbu4rTA+oYLlSWvmw2ikCXE4rEdXOcf6uMAfyVW3A5mc0xdN0V9s4+qRm3v0KrJ/koIi5bJl6trGCj1IyzmwHPp5ELI6J/+s36xW5NU+kufWKlN0t1wWn1d0gySND2dovlIOH9KYTrY0LuSKpsCTbyrf1l3JinntdrmbSZH3VQ/yFeMyI9gIzt7mr85ZWz1kPosOhuMs6ng03qyYhNx1ZEJBGcpb5W/jMa+QqLdUg+Ryeq0fb2wm4EhGGUr9QtveHjONuzFkl406CMAkO5D8xEEeNubxYBEEqoVkyuCFKO5Lmip+JM0pvGkUPZ0ZZv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e949c4-543d-4f36-5a00-08dbdf527208
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 05:28:59.6274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82H3QKl7cMk69B7OL9+sIJYHxuoiMrnZ5q11gPFeND/WKiDjMH04H8xuCn8y36y1FgyQiPtz6hI7K5+FVeg6/qcuOlzIUB5+K59loKKeOIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8848

On Nov 06, 2023 / 08:35, Ming Lei wrote:
> Add one wrapper script for using rublk to run ublk tests, and prefer
> to rublk because it is well implemented and more reliable.
>=20
> This way has been run for months in rublk's github CI test.
>=20
> https://github.com/ming1/rublk
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hi Ming, it sounds good to shift from miniublk to rublk to reduce maintenan=
ce
work of src/miniublk. I tried the patch, and found a couple of points to
improve.

1) The issue that Akinobu addressed with the commit 880fb6afff2e is observe=
d
   with rublk. I did the command lines below which were noted in his commit=
:

    $ modprobe -r scsi_debug
    $ modprobe scsi_debug sector_size=3D4096 dev_size_mb=3D2048
    $ mkfs.ext4 /dev/sdX
    $ mount /dev/sdX results/
    $ ./check ublk/003

  Then I observed the failure:

ublk/003 (test mounting block device exported by ublk)       [failed]
    runtime  0.529s  ...  0.465s
    --- tests/ublk/003.out      2023-09-05 10:05:11.292889193 +0900
    +++ /home/shin/Blktests/blktests/results/nodev/ublk/003.out.bad     202=
3-11-07 14:18:44.966654288 +0900
    @@ -1,2 +1,3 @@
     Running ublk/003
    +got , should be ext4
     Test complete

  So I guess rublk needs a similar fix as Akinobu did for miniublk.


2) I ran shellcheck for src/rublk_wrapper.sh and observed two meesages:

    src/rublk_wrapper.sh:10:12: error: Double quote array expansions to avo=
id re-splitting elements. [SC2068]
    src/rublk_wrapper.sh:32:7: note: Double quote to prevent globbing and w=
ord splitting. [SC2086]

I suggest to apply changes below to make the script a bit more robust.

diff --git a/Makefile b/Makefile
index 4bed1da..43f2ab0 100644
--- a/Makefile
+++ b/Makefile
@@ -19,7 +19,7 @@ SHELLCHECK_EXCLUDE :=3D SC2119
=20
 check:
 	shellcheck -x -e $(SHELLCHECK_EXCLUDE) -f gcc check new common/* \
-		tests/*/rc tests/*/[0-9]*[0-9]
+		tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
 	! grep TODO tests/*/rc tests/*/[0-9]*[0-9]
 	! find -name '*.out' -perm /u=3Dx+g=3Dx+o=3Dx -printf '%p is executable\n=
' | grep .
=20
diff --git a/src/rublk_wrapper.sh b/src/rublk_wrapper.sh
index 803743e..2e79a01 100755
--- a/src/rublk_wrapper.sh
+++ b/src/rublk_wrapper.sh
@@ -4,9 +4,9 @@
 #
 # rublk wrapper for adapting miniublk's command line
=20
-PARA=3D""
+PARA=3D()
 ACT=3D$1
-for arg in $@; do
+for arg in "$@"; do
 	if [ "$arg" =3D "-t" ]; then
 		continue
 	fi
@@ -23,9 +23,9 @@ for arg in $@; do
 		if [ "$arg" =3D "-f" ]; then
 			continue
 		fi
-		PARA+=3D" $arg"
+		PARA+=3D("$arg")
 	else
-		PARA+=3D" $arg"
+		PARA+=3D("$arg")
 	fi
 done
-rublk $PARA
+rublk "${PARA[@]}"=
