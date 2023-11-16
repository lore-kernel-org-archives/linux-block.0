Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CWUhrgyM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Gc8GA5HM"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C49DA
	for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 00:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700123819; x=1731659819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w+bvOaytCd0DDw/tOxQxclYBklHv6ZGDiJ771wRRaoo=;
  b=CWUhrgyMccvVBhsbo7Bcuc8wHHjhseP2mjBpPFLoYi9+AaS7IKwl3AZJ
   koE6BZj7e9NSqsMi1vzjNPkEvcK2HYBvI+PcHSKl4GLn//skAj780tg/g
   9uDv/yQgvCMk1eqY4b9WQIu9ph6cvmAA2CZP9ho7XZggbMnHWY3j6Aach
   RoPHHepPHToE1mAVjQJvjPkcHyc2LImJ4p+Cjq1x8Jx5hmMFovLJmolSf
   V06M0WEBYLXmB1hMwjQ+rouq+RfaUwb+uPWgb+U8L1z36JMjElBahgW40
   tjD++5uUyQXzZGRuXh8AKsTRtzSUE/1sGfPjUm4i/KSQRAWFROEargR/i
   w==;
X-CSE-ConnectionGUID: xrfqJZhcT++ypv8ZWy2oAw==
X-CSE-MsgGUID: xAcb5+pMTpy8gru94KTg0g==
X-IronPort-AV: E=Sophos;i="6.03,307,1694707200"; 
   d="scan'208";a="2400083"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2023 16:36:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1KfB74M6bkim5SGcj8/L7R4Hr1k4Sg1maSV75rz3XuxuPBJa/Lis+y9f9lUuTwZ8w8qu3t1zqmWNsAfdfkuatvXPYGkPAGTyvxkGxY/cUmCdOInKt4j1WuvFEc6l6GMrK1ZPMbF/oDvKrM5uTDKL2PRtp6j3N6JolwWSjL2EwvCx80UiOypQFua5HkaRgoI5RRaTRqOXZhhyf3bh9nEhZd6dL4yR3vN8H5O/QghvezhSjBt5dx8iQxOSQldplQ0HFJTkKCOyeGdNiT87ujHmyWEcNz4Mf/lSQDoZhQxWko1YljENEOFcCh0i/7AEwzuJX6hIkpIEQ3SFTyDUkV4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+bvOaytCd0DDw/tOxQxclYBklHv6ZGDiJ771wRRaoo=;
 b=gJR6ek95vv00fLI7v1fLMd0UNPvsAuCBLwDrSaiB88OOl9tQ9fuzZhaOg0iv1fw6RaGEIUHQUYRR/jayu2UPbE8vzFI4tPVYmGRvLZht9r7HFTkYf458AGLnlTXhHslxFWKKxK47Y+zGQQtWy2cGhYy1aS0o9ikwfb8ja4EN7RpgL5eR12drVc0qnvMZeO0Pfn7Q9/ms4twW69ySxEiwpRICh1YqHxXDy8sstEENWGExhU4pd9nt+fvVC0JN3ii89wmFLQ+wshNKBC8D8rTkFUwE9e7t/qihvXIkyaqkkdaPbKUVzeggTlDdwETrlIzRQt+QVrpRg9D8EnnIAim9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+bvOaytCd0DDw/tOxQxclYBklHv6ZGDiJ771wRRaoo=;
 b=Gc8GA5HMmjHxLToX5800bu4UwbUOR8S/mTqLFy++MB/zmjpOObirERUejUKPnwHwgIg3EQEt6OZXWK0z10WdjqxUokjWkVzVgBpUImlCHPaSE4720vbhYACYlcRmcA8WSGrHChtZ21WRZ4VR+MvycmAkSfvrteN1HPUXt/IN1Gs=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN7PR04MB8768.namprd04.prod.outlook.com (2603:10b6:806:2e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 08:36:57 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 08:36:57 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Daniel Wagner <dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Thread-Topic: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Thread-Index:
 AQHaF4fs31V751Pswky+3T/QxhjUILB64sUAgAAdzQCAAAmMAIAAZAsAgAAD/wCAAMKJAIAADycAgABLPICAABH3gA==
Date: Thu, 16 Nov 2023 08:36:57 +0000
Message-ID: <rhemqs37f4qog5xi5blwwdgaeam6yxbzlpshe4xk3fpfl3tgwc@qikpw4qoxb4b>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
 <20231115055220.2656965-3-shinichiro.kawasaki@wdc.com>
 <447d68cc-91d1-4d17-aec6-0105d3b188c5@suse.de>
 <xikiwdcssvdc2dvozscny73e7pxcdf7b7qx7oys34ote4cv4qo@3msll2uqsz7y>
 <ebf8d5ed-1fe6-4962-a363-5b11cd01bd70@suse.de>
 <bkd22lp42ewpp6u7lws2alcbfzjzt6yp7m3ou2ugdukiyuwqt5@pjnxq5uqnjlc>
 <fd9a0f77-116d-4eb6-ab3b-8af08dda878e@suse.de>
 <6fwo7puujh4dgoppilxwtg6t2d3sf7l7jp7ifyjprgj5litjtt@b6qoyootcnnr>
 <3c5daxlrkpyf6l3asotx7gqczqo32ffzjjvfoobchvwq56c4hv@r4llw3v2msvl>
 <ab72deff-d0e8-42bd-ba93-37f04350ce50@suse.de>
In-Reply-To: <ab72deff-d0e8-42bd-ba93-37f04350ce50@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN7PR04MB8768:EE_
x-ms-office365-filtering-correlation-id: e6a10866-a026-4980-7b9b-08dbe67f31ac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6f+9a98OvXvUgVz74nZzPj2CigiROLNKNLqln1j8V9KbOllosdvSgd3R0toovkl3eZ8sbB9M2UzMzlpRWVaAKsf8kdR08uETVrvZtSN9kbECKOXHdoGw2GJhTx7djeVvRUQo028p38iFexanAsl1T2RPtCBnuudbiEuhbdOm1W/3VO4lparQwrrzfMzMyrlbWa0CgMiC3Qkji8TSbkQdimacX9P2pEPzYwc01LDHZvd2X77O4eTA5z34zwJQ9dMDdWThtM2DgyFTXDOPW4fJSAy+hyf5suHGCZq8jdwMEBWw5O9Em/PPI5JB0qjwaT8mCSXm5jYRy5XNhDuM7qdQDc2P5VSDQfj2EW+DoZ96WMtEKyWsYkaEPhiMOQz7SSnm2t+ki55Pqdeh/M1cpLryPmYuPhoJ/LmP/f0KFJXeYqvPiJbdHRWpoMbVfTxpLQ2LugbSAOPJDyaf/14/EOGXe0v4U6gD4bQkMfCzAfymQwKs2cTbVeyEt2l9q7Z/XfUYOY+QYlzdKoWNdUs5ZDNyRXlbqY5amGRJJXQLcH+DQys6png0htH04AyKr2MfKM9EKXqCHeOTEBtjfiYCRD9dksvvYyRxz7/332YSyIlcjUwCvLcDip9IJTwxc5SBmnL3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(4326008)(8676002)(44832011)(5660300002)(86362001)(38100700002)(8936002)(6486002)(9686003)(6512007)(2906002)(66446008)(54906003)(66946007)(64756008)(66556008)(76116006)(316002)(6916009)(4744005)(41300700001)(82960400001)(26005)(83380400001)(38070700009)(66476007)(122000001)(91956017)(33716001)(71200400001)(478600001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9gZhtIG9mM3Qo2HITuNpyuhK5ZpvbbNl9K3G7+bgjD/zcvQaXpTyEX4e0eSd?=
 =?us-ascii?Q?qL7O7v1nEeVP4Osry6fAww3VqYwzg/RF+xYc68NJgqs3hXJ10rTTUN1cFRU2?=
 =?us-ascii?Q?KkIQaxWfnq+GyaaI6q9xOpiduIPbtKAr2QLehmlqmr5GRWBbAoaUSDkyvvDR?=
 =?us-ascii?Q?rEv41OGsD6aY3EzCVJhZZNklP/yi67txu8e8SqcFgtdsxr5aGVaeRYSwF7JL?=
 =?us-ascii?Q?aoN/qRFzU4Z4R0ZTPlLDd+ilkVwyQ4e99aEdkUkoYxEbQP2iHzCHnJr4/b5P?=
 =?us-ascii?Q?UzzittP+mU/vt8/GdDysADg8n8TZibkllz+cQY8HL0u5wtlTmdjSCWHqIC8Y?=
 =?us-ascii?Q?7jFc1I3TQSc1s5u4vPes31WICkbkLvlIDjDtRha/OZehZt15YY7W4ySK3ciI?=
 =?us-ascii?Q?H22LMYSBJFglPxNHPHg2L14r3+Uchp4tnBWKlBCHPjfeDidgF7RHZVu67RRV?=
 =?us-ascii?Q?Bds2hTN2ehu5rhErYYH0V0bONeQS/0inbgIVeT6bK+H+BuIiHlOhOx/ywuT6?=
 =?us-ascii?Q?VB52Y0wbtvz4W2QEUxwQF8TQsY56qGGwqIPoaAIOh2tzEqOqGvTijU1Kxjs+?=
 =?us-ascii?Q?hJmkdNMIlM6N9IjlFGrj6ZVOYEnKvSRlcHfLq8zeZ/xnIYD/ND6fJ3YiAT9h?=
 =?us-ascii?Q?XIEM3znmz1I+y3jiv/bHL2AWYpq4Gq1Cp8U8xP++YKB/35sV8sjAYzobEMAh?=
 =?us-ascii?Q?fwG0oroemb9UQ/GHG41AEdKR2kQosNV1DkXRNTGMyouYabskZWxy+3YIcsJM?=
 =?us-ascii?Q?EgQU6kDjk3odHCuqSuc8CzFPqOm4agd2M0/Ea0WDm6q+Bm5aqXgvTdi6ZTt2?=
 =?us-ascii?Q?1dNnutF7CnpYi+Roi7NnOH5xkK2v5rXmnmQsNkCPDL0IdUfwA/FwVasrbrsI?=
 =?us-ascii?Q?F+s7/Eh38/C2OlfwWckZcF6WAnGOVHIKl6bd2HUlMh4bYDsHulG5AyvZhF12?=
 =?us-ascii?Q?nexQ8FGVLEf3v7Hl4J6dOLV042BWg9eowlN+odR1MN20Lx3Qb6b8zNlM1rSE?=
 =?us-ascii?Q?vM7SdTwHmDfkGRWfhIw1D6wBmz/4lQe4uMSTKNYyLz/C3RWySLT4hzKMMMV5?=
 =?us-ascii?Q?i7hJph8vCkUPkAz0+/jJqMRjjYAktSPYiMfmOHP0hVv/R874VCHFHXBUjd7k?=
 =?us-ascii?Q?javWvhxK5lMzCJdr257kJGjgAtJsq8ySsUhrbb570LDIUdEZnkGHsNM66GVQ?=
 =?us-ascii?Q?mg75VI0ggKxiIG6QzfXLfzPP87zUAY6s8c7LS8CHb4TFEvONEs0A+/YueVDf?=
 =?us-ascii?Q?zhIPVmll7upg+JjyCM+q1q9SnwIgEsV8ZJfEpO53fP6lDw4L5F9+4OyLI9eb?=
 =?us-ascii?Q?3YYjA1/C1Y40GGsAtpTSxJaNcQ3LmQm46bYeisYBBNDT5xAHyuaD06y0Oy7u?=
 =?us-ascii?Q?U4buatu1+VYAzuItkuy9/JdySNFxa1Mel6pm2Bsu2LlH7zpqN51SeoSQIH+p?=
 =?us-ascii?Q?tJr+PViW6MlFMPKqljvVLKWfo+BeQi63F4rx0sn3ukHqlP5FUXFYWwUo7Zsy?=
 =?us-ascii?Q?EST49ury8MB1f17RHf6RooXOh6IIukC3U5iqJ62W0xRsylyftKsDf4LBtVwa?=
 =?us-ascii?Q?TWm32gIwZC/w8VjPSkJhJHMYZf4pZ11XsYHVJR7jdYM5f0jm2xJk+9F63vlz?=
 =?us-ascii?Q?AZFZfyN9qTNqRgEnhG3MhvA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8428C7E5FB64B7438F6039232B8949F8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ro5hQGboHT6wNHafbDBtUpVwHizbE9kHnKO+bnLfCwmNKJLj8pEgp9usl2OYRnYFBAhostO5RffXo060hZ7bq2snSrhi1konUXB5r7RnRuhVA1m1165sd5+1rVJ3A+E60nhsDCAVde85tf3ndhfGCDChkHDfdJF11hUlPuMEwcDEEZ8zR/SxLQA0AIbToRfvQeoXGFVpGMptatjAwqTjfGbub7XrbF5I+v32bkascjkd2Qn//mwdZQIKltJ9/pTkrHxGCS2+YBWda0nZLTuhrsuZYcBLie4OgP0kQQE20zHooKGQwuUuO9eIhNRjuff8kgF44Mvw/Vh0ieRFDZKMhno8WQr0AFup5p0V6FjeI7vjpUE4dicCcfh1EILO8NDulJRcocnJEoZ9hoZ7AkTNWZXI8evCHRltpisIpwytzA/iiPmbMtcWkel6VrjDONlZbfl6jclCjKTrBTSUHX4vUxsUaF0Es8RGaYwdWz8KPLLbqy/WmyjsFxdAf9/vhRW6YjxVJWPDhRLY073WWa4Z1XZa49/Y82tIUcDLnv7/GuUNxu3gWnVNUIA2lWl6iVD9TmJp21fXExOOAlE58H5p/kk9q9ibHv/sThjBUFB/BhUMyVow75gOubq/LJchEiuzdcUOTdN9EZsSZC9DI9ivRaYW9Wlc+XHWn2D4Rx9Fx+s5PLo6A0QrVdkewq1prMiV3EzBDxssGnxx1uQh9ViX/bIyQcNBvcT5P8BY1PLmOBI3DiAW3DKnmG+aXNzG3zq+2GsyWWUsaOT2/IVSjYQBm3bN8XPa+LxzJkMh7/IymhAo2UK4hl2cMq0/EO81c08zExq9Wq6oQ1n3Yw2mY/UhnM+Ot8ckFaIcr2KxVqmf5ccH24r41jnu62q7eN5HCMZ9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a10866-a026-4980-7b9b-08dbe67f31ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 08:36:57.1634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IHqizdJkhsiQveF60/wWRLgZOqVkPcPP2Rf9aEIINjLz47F8Chu4sqwTXEFc1kQBYXFIRWc8JZxM4q/F6m8sVWfI1NTzhQ5ndTPh9IR1nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8768

On Nov 16, 2023 / 08:32, Hannes Reinecke wrote:
[...]
> To step back a bit: why again do you want to run these tests on older
> kernels? If authentication is not present it's _quite_ pointless running
> them...
> So what's the rationale?

In this context, LTS kernel 6.1.y is in my mind as the older kernels. Accor=
ding
to the git log, nvme authentication was introduced with kernel v6.0. I have=
 just
built the kernel v6.1.62 and confirmed the it supports nvme authentication
(CONFIG_NVME_AUTH) and the test cases from nvme/041 to nvme/045 passes on i=
t.
