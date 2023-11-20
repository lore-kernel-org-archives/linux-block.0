Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jAUMeZUy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="stuygqFy"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053D5B5
	for <linux-block@vger.kernel.org>; Sun, 19 Nov 2023 23:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700466531; x=1732002531;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=jAUMeZUyVNslh8c2JArMlrBeUHl1MYpVhBRkzbcs/G8PR8mh5xG+2wCe
   LkDmG59iMnhTtoD4elK/klq019cwKhPVEXl2P5OKbrg4hrait7nq/+fxg
   jaOxS4EBYVUzFluH+DEOV00jJ5Ig7/FroyqOVSdw1fpTwC6x7aphIzJPn
   rn25r2tC5RCiJvFfCDTUBkOEVe35AlpNlJzhFQcCQqD9h49NLQfzk0AeN
   2Rxc6QXWEXlCLHsaPz1ddWhF+CyA/pNDtYQbiw8fPRZo3Ty5qKg2GMREq
   vrISlQ1BOQ69DNtmod51dyRUaN1rpUIazb/j0dumqjZhopFC4dDTYPYoW
   g==;
X-CSE-ConnectionGUID: 1HLWuhILTaOGUBN8DAt/yw==
X-CSE-MsgGUID: MNY4a5CzQj2arIoBBkUCUw==
X-IronPort-AV: E=Sophos;i="6.04,213,1695657600"; 
   d="scan'208";a="2910360"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2023 15:48:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLaVTutToQdtndlHsiknhyhDRQ67M8tFdEvJa5YnHtFsdS1WcWgwpbl/PoeC0dkDV+3ZeHNH74+jIX6u781kqYxClGBNjuspMUMi944PHGNAo6Va7Tw0hqt0+tPDEikWhKScYtFS3bj/aICuglXhP+TnvXKVZ/+NUqKfjvxeQM3Apuc9YuLaZM/kVowhuAoJn2UMMsTAXtx6F1XvYvrpWF+wzOTpAvQPSKOP3fIC+4m9CVx2idPMwRqdwXTBmnDwoqmhBPQADDG0ELb8gu2Nx40bwFa7koCywj83Qy/QwY1BkkbcAA7xY3fR8OKb7Fjf09yyrWlivZM/SerDe/4ABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=TcpdsNdlSr3oTma1N0mjyUQ4skjbjKczUZxWq4K9SGlFjcPCEZ9tlaECQK4NhP59f50S/S/5tH4ioz0zZEYjw0enyQU8DJlUx4xV95+vCDCQOa0/FCj1ag/qt8oGKmC9BZ0fo4wxc6qheN20bYA6AvBHtoxrhPW86i5qxKFikZ1fuL+JZW99NDIytNvvyFW1fT0X7FVFjj1dpbpaDDM4hKeeG3b0v8tlV8iNe9mSmteoFv3JrkXDem/VSQTR1irmQP0HC77t2e/AY+OYGY1mnxTdjKX7I+v4eNNIts3iWJzDlAJMOvhFCronMNcnnIzcwZhwDi3fDXTlDzXB1A/qfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=stuygqFy+PqiYrqDW8lYgB328yeIoZmQKVTFWet9PqWPzQYVmSmbXmk/bKBs/1Mt62AVVDgokonvFhChzzfOoY6I2zMlEfNLGKy3SGe9BYjKtNF1NGk39wMR4c95uOk+WJzX2ETRyIXj/L2VaQo6P/DvOD8ws3c8VU1Y6bqX2Oc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6444.namprd04.prod.outlook.com (2603:10b6:5:1e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 07:48:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ec9e:a2db:eb04:2cf9]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ec9e:a2db:eb04:2cf9%4]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 07:48:48 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Remove blk_set_runtime_active()
Thread-Topic: [PATCH] block: Remove blk_set_runtime_active()
Thread-Index: AQHaG4AT+QX52vuaVkW4z4DLAeJpuLCC1PyA
Date: Mon, 20 Nov 2023 07:48:48 +0000
Message-ID: <3dc5d0f7-91d1-44c4-8933-3d7be296a781@wdc.com>
References: <20231120070611.33951-1-dlemoal@kernel.org>
In-Reply-To: <20231120070611.33951-1-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6444:EE_
x-ms-office365-filtering-correlation-id: 47632074-ce34-4c4e-5899-08dbe99d217e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kx8npy7VKPC+M0UHGftIQ4MTLGHMEI42rIVgUSER4jqbE/4JE/lf/feLHq7SA8Z0WI193T3dKcHBjgSKEX7LNUpgH+l4glDMIoXPuWueMJe/oYPAbFYty44Ro6xEHJJQbygEyh0U/XoNt0PFyWgntgU4UDj+GYFhSyxQ3+4VicqBilBRf2AoVD9KEZx9tR8FGJwjs8/OKGDrczjgZHXr2XUdMvs0Sx6ouRReApVtBBmaENbLoKUS+4R357vIfd8rGwjXa+DzDD3mRu8TKbvaE3A3mEaJUhzKuYq9s5vH6ekjGsSRTcMWkSbVSXepnxkAvci4ckVNKuAQou2ZTyksW/d+mV5k7pUgfR8viJ/s+2Vy9RqmSvwIdouLx80ugqgqgpReieroswpUdZoc3W3QtXOM1EIq7CjPmywn66ykRsdUbxpdYl5L5Inwl7XKS7Yb7m6PngzKqIVUjFcqVTzCDgfMgCYe491m87MXS/RcBvYDioDd69JXOaLRYtNMVcjnO6O0KhAKm7ZRCa4SE4S4iVMGDmlybxSoecI+OXfet3YyNwSFGRvpDoQ8iumajtt5AOCs/gTVm2mvPF2z8bNznJfVYjnu4WqZhglneuVVIRDhFjLDaLs8ICLVaEseunlh2h7zKLKvZXyBazDmx384BbLGDy1EuTc6s8J+Zb9MxO09wm8A+jVFePRXybzkIEOx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(26005)(4270600006)(6512007)(38100700002)(76116006)(66556008)(64756008)(66946007)(66476007)(66446008)(8676002)(91956017)(110136005)(316002)(8936002)(6486002)(122000001)(6506007)(82960400001)(2616005)(478600001)(71200400001)(31696002)(5660300002)(19618925003)(558084003)(41300700001)(86362001)(36756003)(2906002)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHVER1pQTU5IQS8welEyS0pwdXl1RzQrbzFnRlljK2xYMlJzeHRweGFtckxm?=
 =?utf-8?B?L25tMXJVay9MTjM1VTFQZ1BVN2RkTFVZTEdKbVUvNlJsdjZJNGU5SngvRnBD?=
 =?utf-8?B?NStoalNSNSt0LzRaQjA2dC9CTXVoeVZTVTd3WGJDc3d1cWM3ZEU5RHJrczg4?=
 =?utf-8?B?TEV2Qlp0SjY5T0dpZkM4eTU2YjBSS0krM1VuaWxlUllOTlB6SmpDcmd2NkhU?=
 =?utf-8?B?QmVtczdjaW1Rd0NiWWZUT2FJMGVjSGhFSTgvU0o2YzJMMXlFalF0ZHNUdWdp?=
 =?utf-8?B?OWRnU1FHSkVkYll6WEMvT1pudWtadkpRZXFsdWtZRjNlbkZkMVpMaXFnc0Jv?=
 =?utf-8?B?R3l4VHFBSzR4aHo4YzBndmZudkx6KzUrUW5MeUQ5dDVNU1J2aTdMZkNVa2tM?=
 =?utf-8?B?TGgxM0tPOWpST0FhTUlFTjkvZWVDcHd5VWRHclR6ZVY1UWVoeExEUko3bE14?=
 =?utf-8?B?QXNYOWdQV2hrR290N2dSVXpuaDRGeHAxUXZmVFIwZTNkVktNOHRtYmtaM3Rj?=
 =?utf-8?B?NGZYMUxvaXc2Zy9aODJXR3pTTGRFYzA3ZUEwaU5sLy9JbWM5Q0V4UkVIUlYy?=
 =?utf-8?B?YnNCRVlQSlczUW5jUnJ0SmEwWHdlNi9lM2xWYzVrWXRwbjZjbjNPZE9Vd2R4?=
 =?utf-8?B?dlo4anVOMlEvUmxpb1NYWnVqcFRsZ1AyRjlVaEtLS3N5bmZ2cVM2UklLNmtx?=
 =?utf-8?B?QzlJK2xKMTNocGh0dDNYbkFZNXYxVHFiTFJwVGJqeXowYndHc0NqSEY2Wi9w?=
 =?utf-8?B?NUtOa1F3cmJySS9hWHlXRlhrenk0V0xyTjJ3ZUVXSVEwZjBGWHJ5UHU3d1Vz?=
 =?utf-8?B?OVpqdjI4Y3Q0VkhkZElya3hpbFJJWlFpbXpERElXZS9JY1VTdWFUSTBJNkJ1?=
 =?utf-8?B?TTlmRG5Ba3V1NlEyRW9JUXl2N2VoWU9jZG1PS3F0L3hYbDZZSityOTFmTFB0?=
 =?utf-8?B?N2JyeEM0c1ZXckVBTFdOZTBrOHhwNCszcVZ6R0FpdDdPMnErdWY3cEhUcDZ5?=
 =?utf-8?B?VlN5Z1dtY1Zwb3ZLL1UxaWpRR1A4clE4RTUwSkc0UUZIVE91WTV0bjJvT1NI?=
 =?utf-8?B?WXdmNEhUNGVHK0tYSk13c250Wkh1UG9vaFgrTDl6VkRWSjRQQ1hNODkyUUR5?=
 =?utf-8?B?R29jb2ltUkdNWitzS2pKOStBT2hpQTVHcFlZOTUycUZYejdCSlhscVgxV1A1?=
 =?utf-8?B?QXNyL3FVaVFDTlZEK0pKOXBhdlluTnRxSzFkZEhUNnZ0TnAzc20raVdaQUpJ?=
 =?utf-8?B?RXl0OTZJWS9QMEg3cXIyQmhQb0NMT2hvNTRqOTVseUJEZysyenVmRGt2a3NF?=
 =?utf-8?B?OEpKMy9SQXZYZVFLYW5EelBjMWNmc1Zva2c5ZGJKb1g2b0xCYXRnRzBrNjhR?=
 =?utf-8?B?UnpaYVkrYVlMYkR4UjlWOWhaaWtzQVB5RWJpUHVwNUIwNkFYbmlzZ0xQOTRl?=
 =?utf-8?B?YWpYclRZYjNCRWdLUzRWdGxhM2VjNFhkcG1Cbk9yWDJkd0t4Qmg5RWFGYkdu?=
 =?utf-8?B?bUx6Qjg2TTJ1RXhxdEtoNFY3WTFzMEJ6ZmFYNUJkdUNXMkJxU05SQ1hjQnU0?=
 =?utf-8?B?eGN1OGRtajdGMTlwZkhvdDVzQUtCS2Z0MHpocENEWjNnTmZWM2hhQjBRR0RO?=
 =?utf-8?B?UDlwMHBWV2ZzRzRqamNEMWhwSEpjL0JVRVY4SlpIZnhwRXY5QWIvT1VtRDdn?=
 =?utf-8?B?V1NTZzkvdUZUbzdUN1FPRFd4M1ppSnp1N0ZWLzZzYW1KdTBXVzB1cFRkYmND?=
 =?utf-8?B?UmtFdWFHdmx0SzFaTWUvcDNRS3g1R20vVG0wWDRrYUVIUVJua1ZxK0dkUXo4?=
 =?utf-8?B?VkM2ZjFTNVU0cXpETXBRNFlzNnlodkR4dWkwWnl1a2lTdk9SMDRoa09yU1RQ?=
 =?utf-8?B?d3BKMFJFQUZrZjhIdDkxcjNhelUyWnBuNllXS2ZWeXJydFZqNUdqMXg4T0p3?=
 =?utf-8?B?Q2VXaUFWSm1tK2dYVnI3dEFpd2o3VmpiNTI4Q1I0b0ZxVWJLc1dWcW93dWlC?=
 =?utf-8?B?cG0vTXczZW5OTVo2d3ZqNjhZaFY4anY4Q05XZS9LTVFGVUFva0R2MWV1STg1?=
 =?utf-8?B?U2NhQUJjRTdVSFNlSk9FYkx3U2RSb1B5T1NjM0lQNW9TeE1WRlFDL2RCaHpD?=
 =?utf-8?B?d0txSmtEam9aM1o3czA4Wll3UlRhRWFiZVYxNjl0M01UN2toUEdZOERQZnlZ?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8140167CD62D44A9C5D57428BFFC898@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i+wYlPuOaCPWLPt9dnYQ6U+Hh9FejJyzP4Qt7ELc0GVZZEF4ird6rmR0cR0QmLXjZaA5c8oWnJHfj9jsWCgqHWdJq39U2FXXtvg2APBIx+AWFxlUqut/o7epssqygmn7vf/v3VphGW6qInYGmQyj5vDFzcxgsUFDvDkoZ8S/qTBdNHoP+IkStK+P0j/OS2q/ddyACbp+7QbDIjPlVsGGHlmY+Z82q8n/HgiQuxHCom6oT4Op2tEs2tPzMKIx6jXcrBwLT4LVdQ2nmjnAqEny6BT5tpcn9BwfX+InzgfxDQ3d8RiyudLc1Y4rvIKkTv30YIsa1vCUphSzr8yUoGItE6BLw9YGsL51ZWJdFbSWEzqvkmbKGLeNjr0I73/q9hgOEycCKkubCv+4MaDtqAFD7HJVjF8wQ/xehm7zto5npk9kCt7+/h2F8HJNQ+/M3qP5RUTREmb5l05lv8qF1tsBWiQuajgULEBrLDnOMRSRFYux+U/GJyT1n8xURB7fhdyD8zPmMckm0IfM9hKwJc4FMeWEDNaT4fZabjt94V9THt/rGdU7QFvv32KGaKXhTFptcaOXd5vVh2ky8vvsyhZLlY8DlLD+D37HwanwqIsVpNlstnO4QG8fm1qcOxdbrW1Miep59xuS+MVcFxYiGlcLcEn2IjdcYSUwdS9EpPz2tYnC1//i7/HI0m3huhawneTbcpZLgjV15Tdbf6LlU4bdboOSh6l/FG5tcXDKMYYSP1kMAvvft5bSkUhpSfpkONU8GyYD/cQamLcuKU2cX6BCrQYxcZIGbHwatgbgQcbKVxCGzW4bRWePRvTL3pumYlZZs46yq+t6Bzvb/uNixjGnYA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47632074-ce34-4c4e-5899-08dbe99d217e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 07:48:48.3849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6l9yzIG3A4NJ0h3e/h/jR+R3ICFuKPjkeZ1fvHEPxmf59JeQYUPsHgX64AjpSB8aMkaJjplzE7/5LOyNxqmAilLaF8pLZf0RzfN5lZyAdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6444

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
