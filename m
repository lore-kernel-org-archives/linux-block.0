Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42F425603
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300813; cv=fail; b=h8xQjmieP+am3jUxCwVLQ/i0xLVolWdMpydk46iJSjucD9LNrwKmerzFzMp3uCdU8rWwO7gVH/wwFVRXBqEtDCjBxn4LI+ejNdWszCxrtoOQFD4gdxJ9KxuCU9rsUZmYjkAEwE5rigKtkD/IzVglqfO1Fu9unxsMClT4A9VbrN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300813; c=relaxed/simple;
	bh=s6BCJ8VqS2+Hdxf6F/m8tn03aC3pir758gtiQYjnHoo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R+4tdqzd7BziUyVus1NVd+qrxwmhScFdZ80FTT9xu1HL3ytHqcXlyZ4EcP2GsKckhbq1P2aIO0uqdO1hLFoahcrar5u7fPHfaqYwHyToQZSHfYTg4oEC49+Sup7dV3IbhYaLt1qTfy/rUYVwbMc64laXbg1XkR0zJByGoKe91rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AwErvMpG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=m7RtIw9T; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AwErvMpG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m7RtIw9T"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707300811; x=1738836811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s6BCJ8VqS2+Hdxf6F/m8tn03aC3pir758gtiQYjnHoo=;
  b=AwErvMpGBBfLMHP7xk1z8iivgHzx47k8K30c4E0FQ1qVRv+SmVF2QA+S
   VnqBHPMVro6CtvLBmdZfTwr7bqkQT/kHmplzbxSr9x8HIO/JEIKBG33u4
   4aZJWEV8ZMS0lzjjmE40FwzIaNfa3zeWrAcD49ESatqLlZZ8vs5lV4IpG
   UmV68wEDyZ6c50fyDqlsCUyaZmM2RGUVSxDpsvsteZqcTqITszbOgEnE4
   AybUYAjo9MjVRJLDT6Ls3ZNKGxzpWqyg2l0q4Z2RDvDCe7Fmfpea8y8X5
   iG948mvYWOzpZi35lG/gmRnLkWf/52JbVFll9zkBpSu1m+r1gAEHJ9KSp
   A==;
X-CSE-ConnectionGUID: 2DkD+KswQFqg1eFIiaegcw==
X-CSE-MsgGUID: xc7UXpyFRC+aNifxed+u1w==
X-IronPort-AV: E=Sophos;i="6.05,250,1701100800"; 
   d="scan'208";a="9247332"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2024 18:12:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFiA/BUw7BsuuaH48zvKXW+fMAslaEoChlH9ehnHopucMQ2ftE0K0N2769R+DfQH1hIWMyyv8uVBumlAv3BXtZUhE/H6uBVGUsJ9p2TDqLIBTkKVveMinIBb+59yu6Cm0PJELE9kSMYr8O9zZ2PpYbc3rPWqBbXxvN8+/NgQp30J13Fnrqvy75PBT6Ffmilk2FV3stLnzdkef95LpmkKSjAY8IniACAlFywhQXw30ukbEh6rPmKxSw022bqL6b6lK6s6jvSmQempWHnT1qchzr+uWRtbipSQOxZis/vKUmurGhbbUcFgYeJWfCSXXCd4cBOOwIMrm2ANXDfrwskG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6BCJ8VqS2+Hdxf6F/m8tn03aC3pir758gtiQYjnHoo=;
 b=fK5y8KN3XZ2SaygIiXJI6lmQlVM5MlV9ZcRZHIvca+HcCjMVnyLRb266EXtucKEwPKozR0+MR8zjikhyN3hKWjpRIdpQO/l9zvsI9dxRkPg6AnpnG1EZ1S64QGKCs95rX/8zi2hRam1v4CwAXW4H/yowiUxh44CPpfBm77OYTtVdWgJ3Hb+Ege+vqxf/hF2jeenfYe4ua/e0yqKVEaaO0XJt8NcZDYwAMlOhWUYmf74vOH2e3LTe8PiQvtgvURdo8ItDfZ3m716owJ+YqfDAbJt8aBViKaM2Bwict5xi+6RowdxkzHTW2HMi0eekAhy7B72V7e30VSYD8LnUDBJ8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6BCJ8VqS2+Hdxf6F/m8tn03aC3pir758gtiQYjnHoo=;
 b=m7RtIw9TlRAg+N6y9L87Tg3fwDoRS5ITaK664P05gZrNJcef/BlF5mOJrVkI8nHVSOkcVuBKKW9LV+u71ofTjYvw11z113TykFuqDyupoZLAJsoHY0kqaNK+VrttUFgJ3Znj8yI5XSCBFHTsu7hESiLB5ZbIHgRkz25Owz2qN9g=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6636.namprd04.prod.outlook.com (2603:10b6:5:24e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Wed, 7 Feb 2024 10:12:21 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 10:12:21 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 0/5] fc transport cleanups
Thread-Topic: [PATCH blktests v1 0/5] fc transport cleanups
Thread-Index: AQHaWP7PQBYQu0etsUSKalB9FheGYbD+qkcA
Date: Wed, 7 Feb 2024 10:12:21 +0000
Message-ID: <45kxzghfpf35wtl5kfes7c5zymio7dyurndabed3bqds7vzxz4@qmm6d4kfsg3i>
References: <20240206131655.32050-1-dwagner@suse.de>
In-Reply-To: <20240206131655.32050-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6636:EE_
x-ms-office365-filtering-correlation-id: 5a75f7e3-6f1e-40d4-860a-08dc27c545cd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lHOIbN0fjNf09AH2Ncr/5EasvmsNASnWUv4GpmNJ/2SVpLD3+YEVBZE1i/nLg6InBetg0vphhZFjaA3EUnsPDjjIrpK1YOHkAo4bOb44dEKfqUxENBwXDNZttEFDFHoTOY6khVjbzurhrI0jLw3aPRrbw4XzRnpFD+FESCYA9FVzk7M7z/9/3Igmy7GC7/8CfP4VrtVJL2V7VvqbpUuY2mKdANI0/ILKt20PEVTckiHAwhYkDOnL7SXXc+/TIexBVDCSqLE3zZ31dN8vhuGb/L6MoewT2h/5Bk2Q8Bs/WrALRpnScm/nidqBFgVA/Q4zO/mN6BrIO/8qmBAx0W8ANGcBq9pY2PPhN7kw+IxRFc6tP+McngdDbXX+554w3F3662HdT8clCIdsBLpQAAs7rGlkds7hQtjZcKG+/U1z+jDxII17nkeFHlhcc5gFGgk84t/Ty67otmrVCBRHnC6qd9mPD9L+yRUD2sV4wpuRQfUSda6GbwuYARgwL2ETk368FtNHBJRJlysn70YMgI2GQtx+T//fUf1XQjm1RH6P2NyIcPKoSe/pmjWY5q2sGcn2dqG0XKJBJ6p7aeWLCH1ZpI9afAIlNp4yy3iLZueVrpe5tUkp1UztX6ZCXERttsdm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82960400001)(86362001)(66476007)(76116006)(316002)(66556008)(64756008)(66446008)(6916009)(54906003)(478600001)(8936002)(8676002)(6486002)(4326008)(5660300002)(2906002)(4744005)(26005)(9686003)(38100700002)(6512007)(122000001)(6506007)(71200400001)(83380400001)(66946007)(44832011)(38070700009)(41300700001)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KXFRgahgOCqorpWlJQuM3iVANAZvzFabiIVNWDVpOENrNTULSQ6/Xoi4TwbE?=
 =?us-ascii?Q?NLwJHy0lxUs2oZPjRcFcpM3D9mMzd2vQRJT2/v67bf5YTpmcC5OBeNvtIUwX?=
 =?us-ascii?Q?YILgLzOlsrlSF3LvhbUQz3x3mtQUsO4KsfX+pJIiNUZmo+HxStBL3V9P6ugi?=
 =?us-ascii?Q?IByotphm62wcgbzS+BguPi6By9hlbK6jgT6u8lI+beNayDvrtTJ6Ps7LnEUq?=
 =?us-ascii?Q?uWB4cnYSySCFvOloWGYP6Iojvj9J1LaTBCh+AhaGyb25xsLJmkgC80Qc21XH?=
 =?us-ascii?Q?mTKV3FdlrV/wy6pfJBua9s2qAKKfBnsl87fucbJaVSyMrwIj5HeCJDQSJ6O7?=
 =?us-ascii?Q?Hl3OPYSXyrczXmrUaO6oSlT4ftZzg9x/e6KN2sYt7yF4u4E2BAbxGzosHlsv?=
 =?us-ascii?Q?8KnBLmUDELmjbr8ED+VAi+NYE+bA2FNA2oAmBWopbi2EywMIYSD+BUCEXaBg?=
 =?us-ascii?Q?riTzpZwc4xAjmUvlIrMLRuVbi3WXaOJBNWfpFucFoE4frHwMt4cQEgUfd5uz?=
 =?us-ascii?Q?upxfS4By5ECTJn/XEne6PmBhThh2Mv+kzKCQ8OFtlJ1anElL+1E3y/skf9IC?=
 =?us-ascii?Q?VgYC4eY8IVZQWQs64HBDtCpdFmWZe/9uyliefkb3kNAKSpy3AE9i35s9JMCM?=
 =?us-ascii?Q?PjybFF02rYQThdgNPm5G+kb4V1C4jE6Sjyzxz8+q7bweV8U6eebm9F1/RdHC?=
 =?us-ascii?Q?hTtlshFBtiMkvOO+P8fNN6DxzaittEOY2NhsBTh5e4J2GHW4V5mZcK9k98Zf?=
 =?us-ascii?Q?JeJQFpB7n5VHQXmmKPRcBydKLeT8zJbqTNrvl99s5lpFI0Tb+GmC6rOpVDEW?=
 =?us-ascii?Q?d0njzMNcGC253/ZSmr2+uElr/Z0r0l2LFYIRFrbWnzSvwCSlFUoUqlznsQry?=
 =?us-ascii?Q?DIJdycS7x7P6eR4wA8n4jKH2iK4pKBR4tgzMSuxCDc3qqdXZ4/9NTfVdWd0Y?=
 =?us-ascii?Q?RWb7c4tiMGl61ZWmJp4STdblJuHWXbdbfg53xuTpwBtl5pPqFK6N/rv6LRcc?=
 =?us-ascii?Q?R6yObBHRwlvYCR8RG5ICCx1Dbxu71/6wbrVOQOE5Qpdo9JEOumTdG4Vq179T?=
 =?us-ascii?Q?FuE0mlsuldRpxlx7MiEjBBvgSTbXeaXUzZZ8/NBIDOVrQglmb6YK/jfF74bz?=
 =?us-ascii?Q?aY83rmvdhxXa7+1JImhjNyFpbUkEN5gCsK6VVWXNfZ5VzOqi2SrFO/skSg+y?=
 =?us-ascii?Q?dpj+K7A2Hicz/Z20awZQ6YEATJR38s9fuM7hqOSW/126H+4DLKlA4yKpI+j3?=
 =?us-ascii?Q?t/28buPqJDiLuzR0mGUMfyZfMG9A3rlI2kzNxY10CqnnvR0vuVaDWliMGOYL?=
 =?us-ascii?Q?3D8LYNGBtjPCcuVUAnjt34tZMkqU2W9o/Egu9+wge7MMv9l+AOLZMtVoy7hr?=
 =?us-ascii?Q?LyHNo5TgDMFI5ZpdLN/b+rVubw/klteOH6v7DUzNZwFZuihRxiwYsjGUTDWn?=
 =?us-ascii?Q?fmTmDtT4bExzk/dSRlJxb/cZaaIxBuFk/zty8ZqnRT3j6f6QfYM+qZrJjxar?=
 =?us-ascii?Q?/BqyyywbHpb1fPBL9G9X0Amb5258M97aBcQI6vC7tIWg3fGOI6Ten78if0be?=
 =?us-ascii?Q?oyvlWtP5VzTU2MeHSLeWalWhgV8f+g4cB83mQ+DlXiDo6p5648ffxjF8eYl1?=
 =?us-ascii?Q?hMzHn6dGTwOHCgf+w41qBW8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB84404F9AD70344B77173C14DA778A2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w8V3eUphsF++hNyjIZPxFo6CUBU7DwsMyCbGD5QSxzevjcKwb12FU3ZgvY0/QxnXFsvp0OMtQPzYuyQhyp6nMigwGLudn7s/iPVXAwInu9/5OPZx4VYiePC7v37gHQKp/4Qq9xDD88QiLlhv5dNY9aFZ23fmG/M4lKqP6xxC3dQekxyjmMrv+C0/cLjziBSebsCJZerdarEX3Fz4tDxGfRkfrDYYDvfWwlfsHkfIfGB1bJllXm4gQYO7zmkGSCKpOHUPsWdFbkqGFqxcN0py5HM9LZlUDdUzD9lS/vBiSr55kMA9N3pfrqUmYSle2LxR0SG0iuifOIcfHu13otrRxvMfBlU1/JGgG2VvFNLG3uZ3xhCrPRQSfpSyR4+rS1JQIUsXw/vcqLHz+SfqEpTW01To1aq2y8Gt2abIC0eg1RuaBD682VcSkqBCKZecVopKGtnFiWCM6lStch7fpeQUm/m5TfEwU9YuH7ewaRrng+F8A8Eyqnl0CbPh3t1wZct0ljHwPb8OwzQPcu27P96BjIg8J36tJv7Kdu/qsdrrCVRx3ni75d+4rzDTCon42l3+P6rZyxcZNgtz44DY038AWtiZ3hM1gV2b8ycIj+8KZRQha4ujIkbU4goU5Aew69UQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a75f7e3-6f1e-40d4-860a-08dc27c545cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 10:12:21.2565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RdPaBp77YJsQ+U66vL7yn6AedHyka23vjt/GpXY6p0PhSeTxQyql2uZ26TfhJQYUdHf5pVHCdqn4JK1/oj7ON1f4mg3Fqof/vKFgDuVP00k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6636

On Feb 06, 2024 / 14:16, Daniel Wagner wrote:
> After the nvmet-fc fixes have been merged into kernel, it's time to get t=
he
> tests work smoothly with the fc transport. These fixes here are not neces=
sary IF
> the auto connect udev rule is disabled.
...
> The auth tests and queue count tests fail and I think from a quick look t=
hese
> failures are real. I did run these tests in a loop and didn't see any spo=
radic
> failures anymore. So I am confident that we finally have some progress in=
 this
> area.

Hi Daniel, this is great progress!

And thanks for the patches. I ran blktests with them, and got same result a=
s
yours. Nice :)

I made nit spelling comments in some of the commit messages. From code poin=
t of
view, the patches look good to me. Will wait some more days for more review=
s and
discussions.
