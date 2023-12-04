Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qx8rIYtJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KYmNmnMP"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1813AD5
	for <linux-block@vger.kernel.org>; Sun,  3 Dec 2023 16:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701650636; x=1733186636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ag78+RT0/aTf7Wa6YbyniEk43/GRg1S8JYbju/3UPmc=;
  b=Qx8rIYtJJzWuiJ6BPk7veW+DcIv1o657NcGg9foNDCOYbutweophNVuC
   BHkqQsdFpb1a5jpnvHv2FKQE4Znswq/TJA+qlX+7M4DDI7jQ+oCZNfRIi
   iQkRBwchtte1SjAEQdgXl2NmTJo2Bwi3tpu5VI0Xn0fP9geNeCF7c6aok
   KhNdrW0QPAjibmyNGyEmYnNzU4FgvFEb78RKbfxj331IQGoyYRY92zUAY
   F2Wl5lJfIHjTV5+HGoa7yy1h5VyOzyIIKBieHuNs2H356AcgFjAIKyt6v
   CSV9b8g+bsiMDS3KDmWQw3nNScItb/uZ3QFHzd/oux79TWNQlvn6cCCWL
   A==;
X-CSE-ConnectionGUID: KP7qL5QlQPq0xHaMZyIhTA==
X-CSE-MsgGUID: 1ik0FRvAQ5m5Cda8qOoazQ==
X-IronPort-AV: E=Sophos;i="6.04,248,1695657600"; 
   d="scan'208";a="4039593"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2023 08:43:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kql2wWEBdUrWsqIAzomOO+A3FGPr3yaAjew5S5Mcv0yPJQLLdslRitcKW7fDCC4/2w5E9Be4JSxBRQbSghN2ofRiQfwuT3Z5cOvpB/hDuZvGfRJhPhm08+LbBI7LZdTecbJVIRlmQG73o8UNJlzQtKnDdkDqiGgEdDAS2vXXo0Dz2IVGEdcgZEmXlFiGC8CiBIiukU7JGIgfF6M+s190o2hAahfVeMkPWGsN7sJGq2pyAtBthaEm48dkBx+c2VCN9A8v++VqU3N8yTpxrpDiozFu/mrTwSln1i6H2ID0kV+2nvyFRAR7Cl4h1pIhjuFsRZZ2BoHo/GbYTvbv7dDnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nHyGqUm0aa82GWFzZvn1ltgdbZxNVEl3cJ/ZnCud0E=;
 b=Nmz2sZoVXUiBNmHiUGo62E7IeMnVguu0ESVEuXfJhb/zmNyLBdTGBPiP3uAi6Qs99Xh32kQWcyDC3wBOYQhF2E1etxXqcBnbRAdJd937TwaR0ezK1FKItn/QcA2mh/IbgsgBJwWhu4bozkFjemcfN1l5W0YyZXOpfo8sithQGHN3oEUKNITlH37uTfSR7PqEEVaQK6Gi/S4Anb1W+YPtwev3mHW9tYHfdHvkD9B6SpVWoWj0L5R21a5Ig41AurMUic1XEEGEQmOP6SN1IXTFg98MibensqBb+L/G2JFNeV1dqWyhpMC084XuwKT0EsyP1lNZdPGj+W6obrY4aZc7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nHyGqUm0aa82GWFzZvn1ltgdbZxNVEl3cJ/ZnCud0E=;
 b=KYmNmnMPN7hkd3v/+EURIdJjA4cWKnpyVHLY6X5RrEwGJyNjc0F54ONaCvcF+gm0jXLMAUiaxzEIq+T0PJJx70EkAlPvQ5O0Xmu0ApgMyCtT5qdvrtd/VeHH3L/7bMWUfY70G8KKpMzYGUrE9FGXJKO/xJEqo34FCFfwR9rriMc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Mon, 4 Dec 2023 00:43:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 00:43:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests 1/2] block/011: recover test target devices to
 online or live status
Thread-Topic: [PATCH blktests 1/2] block/011: recover test target devices to
 online or live status
Thread-Index: AQHaIq9GYW2l8a89cEqlTX8HuFD6orCRl9GAgAa4uYA=
Date: Mon, 4 Dec 2023 00:43:53 +0000
Message-ID: <7tjxwoswch6pwt3xmi4naeifo6mw5vukr5pgb7zffgstuamwru@6buajfuk44e2>
References: <20231129103145.655612-1-shinichiro.kawasaki@wdc.com>
 <20231129103145.655612-2-shinichiro.kawasaki@wdc.com>
 <6acd5220-e053-482e-902c-a86297fd95e6@acm.org>
In-Reply-To: <6acd5220-e053-482e-902c-a86297fd95e6@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA0PR04MB7418:EE_
x-ms-office365-filtering-correlation-id: 45e10dec-d8d4-4285-05b8-08dbf4621768
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bTsHFfH/avSKP0fJSR/TraiKVcSkFM9qtrLi4ps8PIltv07s+7os4/QiJBkils9fzDllwmk5MB5UZPbcbXAgyrCCBQW5q6HKkypGETqLE7nNAqdrYovvwhJnhpuddhbgR7bTgm+OV3HwmIUFTIXXNCOxGna3h0tdbkwPNmnS87569yh3RVPAg4sd0EVlp3IC7/fyHmFc5Cfw1T3X7Cvo+y/rxrvE0pOEB2ZIPS36ou4TOlirujOZ8NA8fNC+Vc++9aWeKhG5BaHxkUivXsl45FZEP/wnessTB8fm2VYGc0M+7ifBoUFm1fsY3kDlXk9vEsMCxUFZNhB8GkrERvO0wGvVduiANVK8juOb1wvd2xZZwgJvuOYwDWUKsq6Ljy1H4omyPqUSRDoTrWV1OtzPLycpO8pY/FYABwjB0GXTU2CM7ezdBdgsZtLs5vGCg+BDuogM8fOJTu5xWPqGALepbYR5PIevoGabOJlnC2J+NE1uJwVymOyf/aCxETVWrMbjIWMsLZhIKRXGl6+mDppyTdgCOCPk+FPJSzcwVtd7ICEleRklvyYetHniOkj0AtI3p/z9XW7g9MYJdoSOJFrZTnKnTrJMNndSPorNoNO5fTL1tHewySk1VYpsEl72ffYwU3ja2xSTUSZ8aZDBK2f28w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(316002)(71200400001)(66946007)(66446008)(66476007)(76116006)(66556008)(54906003)(6916009)(64756008)(91956017)(6486002)(478600001)(5660300002)(38070700009)(41300700001)(33716001)(2906002)(4744005)(8676002)(8936002)(4326008)(86362001)(44832011)(82960400001)(26005)(53546011)(122000001)(9686003)(6512007)(6506007)(38100700002)(30963002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V5LtpcQlj7b5m6Cnhlydmla1Jzi4JJqvtrcT8rrSmR6moMnsLN/lO2tdVUtX?=
 =?us-ascii?Q?kJPHCS4vKGfL2eGPQBzkSZS+riQrusIdgojRAx06qqhT3Spj/YFbRe/5QPhz?=
 =?us-ascii?Q?vP3PcfBtLQ6Fw+ckkdRW+SjbbiyW1umlJBW0js/ORiIQVMTPReeNwdJzY4c1?=
 =?us-ascii?Q?OrJ/actKa0gUKUMwdN9E5z6fp+UPTm1n0trJ+x7z7H92g25kDgmxHxro1u8J?=
 =?us-ascii?Q?mrV/+jACq1kyN4fjYrF9egGuAu5z6xpfLxQS8uHOLNxzQP3b/AUK3pwcqWFR?=
 =?us-ascii?Q?MphXW7Ujb//dSQtoS4hMJtlZY8ZDSCe5ZzSVa2xvFe19Eg/cOtmNElJfShdI?=
 =?us-ascii?Q?BnZkEYSpHcERX1pKERqkynMKHbvJ4CFH9pK9F+y6V7O02GCQRPsg3vwWklYa?=
 =?us-ascii?Q?MDlFqfEPeA+pi/Bu4yVO3lvAEa7I2OXE7XKUkE8S4Y+FfFxFlfBp+yax3bIz?=
 =?us-ascii?Q?I8w3j5w9KTWu9xw8BA6XsFC69WwIh94Giiw/N66ndQr19b5zCvWkCZkvW08c?=
 =?us-ascii?Q?uWI/sV+NGVGSfSFHJYt9kv6QgilxcWS3Z7SQXrG9VWK5BBYe3XVEMU3vv3Wd?=
 =?us-ascii?Q?vpEsc9NSDzJhBI58E37+iJcH+nLyaOhpCl2cbs1w/ecG1FpNav/LlzqAbnd0?=
 =?us-ascii?Q?q8/KVkUfkVPv+Vkk65Y5+FD/HS56MKdpgYdbHSx5BUj6E+UmFtmBxpiCpIZ+?=
 =?us-ascii?Q?doj4+/tw6K/uBpND73cxeg8f61CIjupoZ66TuE+2o2M/URB/NieQcWbgM18U?=
 =?us-ascii?Q?hxd4jJzeNqn3a804rfNF6sB2/Q/2q5XrKU/zPlaXh9Oxi74io8jwo+fxtYcK?=
 =?us-ascii?Q?UpSC25p8Vlsn+4v0NkJuNdT0nDSYjDD5K2KhnjQOEbS60eIWMkRlrbt+jDZ/?=
 =?us-ascii?Q?h2DNJNCHaABHrarEh9Mv+erUMF7goAFfJ+o0Op/u8aQy2GXZKf9FhMVzNbcS?=
 =?us-ascii?Q?2yv4yoFUw7aVgQQUV/kqjS3fkQlgZ+Yrl9BBqzer16l9v6fdZa22bxDsed2L?=
 =?us-ascii?Q?UM0eU7mNzkg8ZgYGNDF+jYSX7uzPltAVEc2Cu5Td8I/W8AC+nmw8PSTqKC29?=
 =?us-ascii?Q?bOy+CTHr3VbBe+2hbKQTx416bEnoPH8TZPR3wsFPs3slxBpv5rEpcHNYUDf6?=
 =?us-ascii?Q?jN2MBp7dnsr4X5MQohhWGxCiOXxOvR98OmkOwOghM89KPIofrSWPmBzwkeE5?=
 =?us-ascii?Q?spopbLG3180BiMiwvQksliaWuKVgZRLetWOiJGgzXQHkgIsNnr3rEfWWqthN?=
 =?us-ascii?Q?GJRZMeIvJGStnPgBv5CZlRPXIC1GwSCNRR/1EIUriJ/B+GXE/3ld2iGBUj1H?=
 =?us-ascii?Q?mbc/wW/950XbMiMNilv+DnkPsVDqRIFBfIPqbjOFUZySmkXhBS9++8AEOpCB?=
 =?us-ascii?Q?ovYQDcbBJDeCg0MGekStGEe47c8MkXlF5jUVd+jNtdTA7Ag4hHJenRdpVTfB?=
 =?us-ascii?Q?fpt8Xiy9QNjNT5QoGShWEi1uYOvrypNToGOTh+ZLxChruo2D7N3i2fCF1jKw?=
 =?us-ascii?Q?BmfKnWcxNWgP1iHMt6GYhLWCbwa1SMv61b+Dp0EGMn6UvSuWUML29kgD4hIi?=
 =?us-ascii?Q?AiUcU9zVpPvcN12kPmIUC2jV1zDDN1oHmPp8okEFfJKGImKwgcLgzni6Ov0F?=
 =?us-ascii?Q?02V37sb6fqFEmIQwaguOZss=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B884F7BFB24A94B8D6CA2E6C536A70E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QCvkN3TAOe/y1nK1fP8u5TjF7gAP38owEt8lqtYrS/BuS3+XyFNqlfAkKGxBzwacc8Oqe2riGaqmS5/1AHHU/+ou0r13FrSOR26vAyQfm1HQ70MnLfKw2YoVuWz0yEwLCTR4WrX6lOy4Gi9F0ZpXKC9vBmdnKVuJYLqiyvX9KpqkXFS/4F6NTkZfcpCSWGypqcUJvHNTz9YLVN2M0Udn/4FbNi2W3fwhhdJ0fsAEfg1CgzrLPGvB1tcyLtSVLXGCJjvTx9sONVD14LaCNAnuJ9kyL94kwNRKNZwexqV6tEkZAW1FERbB9v/7WokyLPmNcaK1BeLRk+G/Ft6oGDakw6a2U12QKH76X8JGYU2GoZg6OEkEYr7rrQNIZ6wyjeRbZJzj9PI7VARqE9C2Al+sY6aJExHselOfYuxEx9eofi4fAwqglIO0uHDYgergT6a9ZqkTgDVzoAfoM6i52yXcAASArzFIFjfZmZbsCrPkexQ68o5cH9huhEhenxfmLOzDj3+cSe7GUsko/JPBkif06jEoOFQOngmE3LlWjdMxtRs0jx61v2FuZ2KjJmbU3BRfAwqunhOSc8RjxYaMbjTXKE/X4wQGnr8tWLg+qX6N/MMlV4lZ7mAeYgbmzLA1WieBq2OqgnV4871s/bzh7VHCMAmuX8f6nu1Be+t4gacQFdLbZhF2mDhpVuCSrDPeTgCBAr6yMEzt5vE54eCg4tnU/8OIW0wZ3Oi7/v8RrKcI0PcJ9EZGjjV+8ssRdeu8kvINm5Rc76SPjg0K2HEF6BmJQmw4lr/E6AiL+k1Z/HlcIM8tfxvoL56RnKQblyYPS9y1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e10dec-d8d4-4285-05b8-08dbf4621768
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 00:43:53.9457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIMFn1oDTEtdWj59zpFENtYI84fR5TXmpOXjBIBM9w/FhHYCaaQcbgyWj5nz+fZyjC3DKlL6sGd8qYHRk3na06LzkFXofH4ohzsO0FwkG4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7418

On Nov 29, 2023 / 10:05, Bart Van Assche wrote:
> On 11/29/23 02:31, Shin'ichiro Kawasaki wrote:
> > +	if [[ -r $TEST_DEV_SYSFS/device/state ]]; then
> > +		state=3D$(cat "$TEST_DEV_SYSFS/device/state")
>=20
> Why the separate -r test and cat instead of this?
>=20
> state=3D$({ cat "$TEST_DEV_SYSFS/device/state"; } 2>/dev/null)

Thanks Bart, this looks the better. Will reflect this change.=
