Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF36AC678D5
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 11:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCGLvb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 06:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjCGLvJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 06:51:09 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C18738B4
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 03:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678189802; x=1709725802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fqpcM6izLyo883gQVNu9I3PTQ+Tp6gdepgfr5xe/rho=;
  b=LnXKTcMXbzwBNm8qhbOO+NOFhni/AnSMnGHM3G0KxuSsaHIP4St9QSo2
   zdMRFx4W4TMya2LPKGX513gc6X85uoP/a4v9+iL5z/jNDyCOo+osPBlSO
   6Uq7i0/98WIibRwTJZjHQXx2lY/OD1Ee3AVIJQZrdPPRPBMfpPTcUgSap
   WLBLrubV9gFNBZBSpcPQsIHOB9ipshfK4jBtEJkn90R5juXv6+LEPHPfH
   LrmZAnhCYlL7WERpErVSGgg4/06wzJY9U9riwiTPKlrYPCfiXnWRHXVqt
   uhwBxV5KA4UMj7ybPOrUhZnL47jv9114isae/2ZsgOG5bQc6p+aZee0zd
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,240,1673884800"; 
   d="scan'208";a="229959888"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2023 19:49:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEv4GjjKjcC5sE5Xc3tNc3sK4RFIZMfJXnJNBJJZU39IYzDLQlNueck2NAqeFhwNLd25/3s2TQ/TZEoiUXbnfd9xiN2SKEK2bRCa5DtrIx0VC38cl3Kze2Ll0iLnA+yu4pJq4RXCtUKV0sET/9M3HOxjnc0r7a2OAfHX5gAJ5I4DwiDpyOCIBPeGSUlVugd7CKTh5y1L52YFJ4sVn5m+NuYAaM3qar3iKf/jeXEiOM5XRie1oLY/zg+5pt5/Z/7qx7UulW3yTCWe7Ni6knwQdrnMZ8XkBX1G/1Tx8NPAZOh5BiIz+OORkZ0UAQpQLwl6xEvqqpLMKVrnfQBQ0O/VuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqpcM6izLyo883gQVNu9I3PTQ+Tp6gdepgfr5xe/rho=;
 b=fjiqfGXzh6ND22vVkY2o01vUV8ac52e5Qx4QSxfukggDzFvolRBUw+qPXjpWK7sMEHF4cWIEbyiDWNJ2BnO9rYGeY3Louh3KX+/pcPpvfvCkwWjR5PoN6gzBWDOjH3wd5NkXUiRfAqE0rgkwFEbmUGC3W3ZKPdJNiws+MDcBWJJChcUETayRAmcj52g2yBxwWFixTycK12V03NOEP02oLx3lH7PQhqMdMBptfX84QgTF/wcA+mC7r7tBYXp2SPgv6WQC3zM79/+ZeeisXjDc6NfAuAcZXvrdOcSrDqXiBq7gLiM6sve3LDiFrVy0gNm6AD8vvBcokZEAQH9a2C5RMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqpcM6izLyo883gQVNu9I3PTQ+Tp6gdepgfr5xe/rho=;
 b=ZxYFMu7JysegyVARQrkTF1tYuNE2OO7CijBKCoq6thsWHPXlPvsEYrd/IFcrivjsv5Pc9y0Bum7JDdNl8LmRqRXRjXWfAcMDj89Y8Cm3d1M6gWjCVQ77SgvE4DaTSKGyjfTAuxbqOvGMKOYm9ebSYHoSN3ylOO8/6hq9W93RT0o=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6089.namprd04.prod.outlook.com (2603:10b6:5:128::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 7 Mar 2023 11:49:49 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%9]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 11:49:49 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
CC:     Jan Kara <jack@suse.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] BUG: KASAN: slab-use-after-free in
 bfq_setup_cooperator
Thread-Topic: [bug report] BUG: KASAN: slab-use-after-free in
 bfq_setup_cooperator
Thread-Index: AQHZUMSAZFA8a8YrAESPLW4VjNB6Ja7vBESAgAAEZACAAAZZgIAADGQAgAACPoCAABargA==
Date:   Tue, 7 Mar 2023 11:49:49 +0000
Message-ID: <20230307114949.mh7fbo4e2zepcllg@shindev>
References: <20230307071448.rzihxbm4jhbf5krj@shindev>
 <220e7ee3-e294-753f-d9df-8957a8f047e9@huaweicloud.com>
 <20230307091336.p2mzdo225zkoldmd@shindev>
 <076cb738-6f44-e731-d2a6-cad4ff464ae1@huaweicloud.com>
 <20230307102040.3t6qiojxj72fqrlc@quack3>
 <73a84d09-9b64-f23a-1d24-a41cc1187b4b@huaweicloud.com>
In-Reply-To: <73a84d09-9b64-f23a-1d24-a41cc1187b4b@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6089:EE_
x-ms-office365-filtering-correlation-id: a200515e-3ec6-4df3-4d20-08db1f020e8b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wsky4J8fx3jsyQ1K1ZpmuF0Paf0vsU4XgurbR5pQVI+JJxHBb74S01lpWPEvLQNm2i0ZTdAlPCUZsuo1K2zwD5nOvjeH7BzbFtf71CPt9HBYgp7BJmAoHldiI5HQGOCjH2mgRS7jMXGtG5rhQ2ztLQuWS8b4mdDpkg+dNiAgQd3e9hE1O3jgeWR05VJlNivCLKyjFnxbI2jGUco4gjUX8Jr4HLliqiUjT6fJP3S2tZPC7VUDjTXopRFSbEZjlyl2pG2jGnwpynCKNcqWSDEBllRMWOLJShgkYjx34KNa7CkdHeU1HUV4qEPqJSeYWEGmLcWjfzJOZJw7prkZ6J7myKTk/VDhxewIyucHVsyWoKD8bkWk5lOq2Q6RE9m8Ixm+oLKlokA8/hj5kfCSy6VACZOE9nwQv59EOnb8QXtQn8hxpUkPa3y1DgilXJgB7/5TmdcjLDlu2jA707oYJoAS6OmwzbuZ5v9pPo3vEJvfisyiT8e5KzdhmO8NuD5KoAr5OG7n7qs8ZvZegy3SwgD3sjyPpAlaEg7hM3rhAOnGAJd2WPj6jMVVDkpUs2C8J10PXz5bUf31aOOCOPh2/6EBZ1L0RpQOcrADlP3ChPIb8RD3zkak3MSi7jJiMllw7SMKKIf4mc+NeCfMbHV/dddbboyDsrlzts1Q92Hrg6M0+Ly6gmgahGT92AajMPfChI84aIg1GOlgUeiWnXBvv6CrmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199018)(9686003)(64756008)(186003)(91956017)(122000001)(38070700005)(38100700002)(66946007)(66556008)(8936002)(66476007)(8676002)(2906002)(41300700001)(4326008)(26005)(478600001)(82960400001)(44832011)(76116006)(5660300002)(6916009)(71200400001)(1076003)(6506007)(6512007)(66446008)(6486002)(316002)(86362001)(33716001)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW1sRFF5UjVKRFlSbnJsblAwUUJiNEFleWsyNnJwVlFwM2VNbHJrWWIrMmtU?=
 =?utf-8?B?cU5vSnVDdFJPVHFlT3FaYXJ0SkxWcmt3YTliY0lCTThYMDdnQ28xTUoxVytM?=
 =?utf-8?B?TlByZFVsdTB6cGNTcFBDekpEMVlObmxVc3ZQc1FMWDdYZFFlTitYRXV3VTdI?=
 =?utf-8?B?aDVMaXhncWwxQWt2dE5QTzFxUFNad2h3L0Q1UkROTEE2WloyUDdKd0t4ODhs?=
 =?utf-8?B?NXF0bFJaZ1FFemhCQm5Eb0dDb0FlaVJ6c1psNU4xRWUvUXkwUGM3N3dnU0V0?=
 =?utf-8?B?S0tGUnlscXhyUGJuUm9DN1VqUGZhOVB3ejZGbHQzVXpYeEErSXpZeE0zbzl4?=
 =?utf-8?B?T1BYU3gxeVI2RGNxQTVCeitsMXlwOFlPKzh0VC9raUptTjVBYS9vZW9IWVpL?=
 =?utf-8?B?UDBmVmEzTjc5Q3dEengyZmIvYkl0UENpdnMwUi9LbEFIbjh2QnNGZ3RLMDhF?=
 =?utf-8?B?R3ZpM0VTMlVxQ2YxcGFaZ1JyRjQwZHhpUFlPcGJsS3BWVmhWSCtXaGhzOWdD?=
 =?utf-8?B?ZW95RVZQT1BOZTZhT3Rsdm9DYlI5bHFuSU56VktOejUyTVFEcW8yaFhNeWg5?=
 =?utf-8?B?SUhCNW5pUjhERG03WGhHV3U0RzQybTZZU2lKRWpFSTVNajIydStFYStQVExh?=
 =?utf-8?B?R21xell4Q1d3Qm5Jck9oSno1aTFsbmtqalVsbUxkRDcwd1Z2d0p2SkFaYmdU?=
 =?utf-8?B?clR5ZCsrTCtRYXVHQjZjcDV4Tit3Y1JScU1mL2hyVkZOK3N0N1dzaEpRNUZZ?=
 =?utf-8?B?Q1AyU05QYm1GZnNjWjZ0NjZKc09veEVKZ2NqdjJ4WUsyazlRN2N1RnA5OUhW?=
 =?utf-8?B?SU9hUFlyMkluZE0ySTZiTkovaGN0VHNkK2ZMREZ4dUNGUDJlSitpaWhFSm13?=
 =?utf-8?B?eHBYbVlvaDNFNXozaGtRWjllRjY1M2NWUnNTY3poejBTVTN3aEpZRDZVaTdx?=
 =?utf-8?B?N29GNWhLbm5qRTN6a3BIRjNBc1pnOFVoRlVKWjJBZ2x4anhlRGRSNmhOZ2VY?=
 =?utf-8?B?aDBsd2lPVHA5azBvcFRtbnNFaWNpNTBrTEJCdWRpODFpNlZ0NU1CK3F5VjVX?=
 =?utf-8?B?cjBuN0pCYWFVcldMb1MxY0UrOUNRbSt0VnloMGp3aVZwYTdFOVU1UkxRQXl6?=
 =?utf-8?B?KzdDNG1Gb2huK1c3WE1kQ3BLMzJ6NUtSejI0YmNURHZubXFxV3BBMlVXM3F2?=
 =?utf-8?B?NEZrK2E5K0doSG92L2daRGdVb0djQWlaWDRZNlEraC95SXA0VVhLRzR2SUp2?=
 =?utf-8?B?SmM1RStvTGk3ODU2ejZwLzVjdzlRNVRNUElZaGRkOUNDQXZJSlV0MW5wTWtU?=
 =?utf-8?B?LzBzdzlabjAzNVVnV1UvWXUxSURTNlY4OTJkVzN2SGp3V0hoL2Jld3owZ2RB?=
 =?utf-8?B?TUo5U0JBTzIyTWdhZXY4UlRFZ2dKejh5SExiS29vS1ZVZkRieEN3YTdHWG4y?=
 =?utf-8?B?Zzg0azhSMHV2VjIxdzQ5MkVRUm5KQ3FIOFpsR0k0c0xKQWF5TWd0UGlrODJz?=
 =?utf-8?B?eTVaUnBTK2dTcVY4VlNKWkZvSlplWXpiTnFLSGg4aHNabjViMEIwcTNWM09i?=
 =?utf-8?B?NzkyVkdoc2xLOEZuQS9oNzZ2MjRMbHkrYTVLNlNQS1RxUWVZb2JiWjNTbGdT?=
 =?utf-8?B?TVg0R05PUjJwMUtBWVVraHJiUjVVMnA2Q3I4OVNsZGZzS3YvUGRkcFpMQi9w?=
 =?utf-8?B?REJGT0VKSWRKZkU3Q0xTMlRQNVBlTThreFk2TG9MUjJxVUNpVnErK2RNdHFv?=
 =?utf-8?B?NDJSQ01CNklIOUJtd3BVQkF1RGZNMVlRRGY5ek9tTUEwN2JRVGlHMExXYVVJ?=
 =?utf-8?B?QVBCQW9iVUNEaURQUytZcTJVNCswUEVEQkxDNjlYdU1vVTBNbnlFc1NBKzFs?=
 =?utf-8?B?Yjk2akR1cjBieXN4eUFSMmtkajZ3VFU2ZW1MVUQrTFZhengvVkNTSExXMStV?=
 =?utf-8?B?UmVHdjBRZkFZdmJSVjZFNU5nQXBTNWtsSEFib1lxTTZPSnFyUlJqOG4rdE5k?=
 =?utf-8?B?WjQ1Z1FNS0NTQXNDelppanFtU29zb01sTXVUSUhodFNzZXM5djNOQ29XWG4z?=
 =?utf-8?B?L1hzbU9Qa3pydWNnRUJxZURkak9wUFRMcEZxQ2tYY3NZZWh0VEZTd1hseTJG?=
 =?utf-8?B?OGgvc1Y3VEgzMVk5RitTUC9SaFgzZ01PMzlSWTJzVG82djlMVHBGUjZBYVFo?=
 =?utf-8?Q?IPmA7rBQrLGYJXKdp7rc44Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3D72A2FAD82A54EBB4123D49AD96A74@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NFE5NEhwaGF3b2szdDNRL3NVVlFhTW9OQ0Y2WWJIbHVaV2hza2l6TTU4VU9Q?=
 =?utf-8?B?VXhkajVDeE1iUWRKOUR1Zk9rMnNPYU9PK0d6ZTcvUUkvaDNSSkRWYkwzdk1W?=
 =?utf-8?B?azhxVVlkclVpT01SZEFEYXRTdTRnL1kvVTZWWlk4bndMZzdRcnFuSmU5NVl5?=
 =?utf-8?B?MVAyVUJoaVBsWkFaTWdaeE5LMmUvTDFvRm1SVm8wb1Q0aDEveTNhbHBxbE5u?=
 =?utf-8?B?K2p1SWxmNWxEeGh2L2xlSEZoeXZLd0RGMTNUMitxNzJwVjV6aUtyTWxQcC83?=
 =?utf-8?B?cllRdi85MFpLZ0Fxbnp6aGlpUnpqQmczSW9aRHhpZWxFSW0yZCs3bUttWE5p?=
 =?utf-8?B?b0diTE9JWnplc0hrSzloeHkwbUZyZWswbGxtakFaREcrdElGMnRYVHVGcXpF?=
 =?utf-8?B?UndyVmQ1M0k1SWY5M1pNaHhpZ2N2dUd2YkVSZDJndWxzNTdIaEJRd1VvZ0lF?=
 =?utf-8?B?MlNBN0ZERlJSbXA3VGJZYnExUEhEU3lIajRTcVNqUG5mbHZLSXkrSzhibHd5?=
 =?utf-8?B?STMwNkdTc1grc09kVnJ1UlNXOWhWUXhJeUVaN3pvYkxJVnltdWhZVDhQdjBZ?=
 =?utf-8?B?L0JWdUt5R0h1cCtLZ1V6WGtaa0NPSU53VHhHdWRoaEp6anF1WTJvQXBxdFNs?=
 =?utf-8?B?Uk1Za1kreHAvWHNQeGFBQ3J3eTJmSjFQSDhySVZMYzB4a3JWVk1tNFdTcVUz?=
 =?utf-8?B?VTZKVGxjU0hydVF3YlpmMWYvc0hDVDZLVVhERkErNEZ4Q1NEZDZjZmQvWEVi?=
 =?utf-8?B?N1djYi80SHZNUElKRXhWSFBBNHEybkhCMjFrZVNTWktwWk9wTU5sRXZRNWlG?=
 =?utf-8?B?ZmtLcHpqQ0J5cWtIWm5TWWxMaXNlMElTTk56Vm9LQzUzSGh3UVNBa09IZVdX?=
 =?utf-8?B?Q2lsZ2ZnSzNGT0xvbGdNMllXS0g4ZThRL05vVnh2NFEwZTYyNlFPNkd2NC9x?=
 =?utf-8?B?OGM2N2UzZFZpYy9SVU1jTlR1TWUwUEFGeHRVdHlUS21wYkhuMDBFbkhmbFJ3?=
 =?utf-8?B?SzIzT3RDaWpsV1daWWRScGZVTG5EK2c1ZjFKOGRrYUJ3aTV2Tm91a3c4ODdz?=
 =?utf-8?B?TlZ0a05NVWwzaW56c2h3bmpNcXY4RzdFc1k3UnRFUnZVZ2dnSXMzTERncmdq?=
 =?utf-8?B?b2FwWU4xZ0xsNGxmWkt4UFRZbmtjZnp3VkdCUktKU2RhTWxVQmJ6TFJGTVFD?=
 =?utf-8?B?Unl5VURtV3BjdHVVMlBtN0FNcTJPYmZRREVIODd2aTJQT3FQR1pYUkVHbFBE?=
 =?utf-8?B?R3JpL3loYm53VXZyNTlpdkQvckhWbDRsd2g5dngwMDhST2ZRR2E5MnR5blNT?=
 =?utf-8?B?NUhTSU9QWVBKbzBQOU9Id0YyOUpTMU1LUkpsRi8yT2R3VlRNeDJhRCtEaldS?=
 =?utf-8?B?dXBKY2ovOFA2Y2c9PQ==?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a200515e-3ec6-4df3-4d20-08db1f020e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 11:49:49.6838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RqU0VqkMpaTeP+Nb+NDLKw4/JqH6eDpICO1QyshDiQGZZpMTfRCTOxYXGyUdDf+dz0e0i0wTgx7WmL9AbVGUjpojmwzLsZwfMEJFocMBoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6089
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gTWFyIDA3LCAyMDIzIC8gMTg6MjgsIFl1IEt1YWkgd3JvdGU6DQo+IEhpLCBKYW4NCj4gDQo+
IOWcqCAyMDIzLzAzLzA3IDE4OjIwLCBKYW4gS2FyYSDlhpnpgZM6DQoNClsuLi5dDQoNCj4gPiBT
byByYXRoZXIgZG9pbmcgc29tZXRoaW5nIGxpa2U6DQo+ID4gDQo+ID4gCQliZnFxX2RhdGEtPnN0
YWJsZV9tZXJnZV9iZnFxID0gTlVMTDsNCj4gPiAJCW5ld19iZnFxID0gYmZxX3NldHVwX3N0YWJs
ZV9tZXJnZShiZnFkLCBiZnFxLA0KPiA+IAkJCQkJCSAgc3RhYmxlX21lcmdlX2JmcXEsIGJmcXFf
ZGF0YSk7DQo+ID4gCQliZnFfcHV0X3N0YWJsZV9yZWYoc3RhYmxlX21lcmdlX2JmcXEpOw0KPiA+
IAkJcmV0dXJuIG5ld19iZnFxOw0KPiA+IA0KPiA+IHNob3VsZCB3b3JrIGluIGJmcV9zZXR1cF9j
b29wZXJhdG9yKCkuDQo+IA0KPiBZZXMsIHRoaXMgd2lsbCB3b3JrLg0KDQpCYXNlZCBvbiB0aGUg
ZGVzY3JpcHRpb24gYWJvdmUsIEkgcXVpY2tseSBjcmVhdGVkIHRoZSBkaXJ0eSBwYXRjaCBiZWxv
dywgYW5kDQpjb25maXJtZWQgaXQgYXZvaWRzIHRoZSBCVUcuIExvb2tzIGdvb2QuIEphbiwgWXUs
IHRoYW5rcyBmb3IgdGhlIHF1aWNrIGFjdGlvbnMuDQpMZXQgbWUgd2FpdCBmb3IgdGhlIGZvcm1h
bCBwYXRjaC4NCg0KZGlmZiAtLWdpdCBhL2Jsb2NrL2JmcS1pb3NjaGVkLmMgYi9ibG9jay9iZnEt
aW9zY2hlZC5jDQppbmRleCA4YThkNDQ0MTUxOWMuLjUwZWI0MzVlZmVkMCAxMDA2NDQNCi0tLSBh
L2Jsb2NrL2JmcS1pb3NjaGVkLmMNCisrKyBiL2Jsb2NrL2JmcS1pb3NjaGVkLmMNCkBAIC0yOTMy
LDE1ICsyOTMyLDE1IEBAIGJmcV9zZXR1cF9jb29wZXJhdG9yKHN0cnVjdCBiZnFfZGF0YSAqYmZx
ZCwgc3RydWN0IGJmcV9xdWV1ZSAqYmZxcSwNCiAJCQkJCSAgIG1zZWNzX3RvX2ppZmZpZXMoYmZx
X2xhdGVfc3RhYmxlX21lcmdpbmcpKSkgew0KIAkJCXN0cnVjdCBiZnFfcXVldWUgKnN0YWJsZV9t
ZXJnZV9iZnFxID0NCiAJCQkJYmZxcV9kYXRhLT5zdGFibGVfbWVyZ2VfYmZxcTsNCisJCQlzdGF0
aWMgc3RydWN0IGJmcV9xdWV1ZSAqbmV3X2JmcXE7DQogDQogCQkJLyogZGVzY2hlZHVsZSBzdGFi
bGUgbWVyZ2UsIGJlY2F1c2UgZG9uZSBvciBhYm9ydGVkIGhlcmUgKi8NCi0JCQliZnFfcHV0X3N0
YWJsZV9yZWYoc3RhYmxlX21lcmdlX2JmcXEpOw0KLQ0KIAkJCWJmcXFfZGF0YS0+c3RhYmxlX21l
cmdlX2JmcXEgPSBOVUxMOw0KLQ0KLQkJCXJldHVybiBiZnFfc2V0dXBfc3RhYmxlX21lcmdlKGJm
cWQsIGJmcXEsDQotCQkJCQkJICAgICAgc3RhYmxlX21lcmdlX2JmcXEsDQotCQkJCQkJICAgICAg
YmZxcV9kYXRhKTsNCisJCQluZXdfYmZxcSA9IGJmcV9zZXR1cF9zdGFibGVfbWVyZ2UoYmZxZCwg
YmZxcSwNCisJCQkJCQkJICBzdGFibGVfbWVyZ2VfYmZxcSwNCisJCQkJCQkJICBiZnFxX2RhdGEp
Ow0KKwkJCWJmcV9wdXRfc3RhYmxlX3JlZihzdGFibGVfbWVyZ2VfYmZxcSk7DQorCQkJcmV0dXJu
IG5ld19iZnFxOw0KIAkJfQ0KIAl9DQogDQoNCg0KLS0gDQpTaGluJ2ljaGlybyBLYXdhc2FraQ==
