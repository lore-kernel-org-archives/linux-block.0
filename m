Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2ECC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 12:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348342AbiCOMdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348346AbiCOMdh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 08:33:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868EE53B42
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647347545; x=1678883545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ytTqWE8JeYlr5xaZAXx4BSRYK/mZe8c/Z6q/bk0F+c=;
  b=mDQcm8EJkMB6OyM21lwwlPfAMsWMgpTqLa9XJKYi7F0gxm1AlzwQKaox
   4KZjb4R4SXs6NARPU+TD7oSONFPzTSER6lOc+9JXza0Md0njqzEJT4aM5
   JFuV/SvZ1InpJnihDqRYqyic46xVG0gu72sP9Lzh+6T9eGYE8YSvD8VO2
   l/cFDq2ZjAs9whnS8rCWo+DCuPF+hmdfaB0Wc1DkHz8H9LeEc2W4VvCsA
   7Qf+V1e0y+IZNHkHSluFfMuiprdtngUcEe9OfVr2rxogDShUNL7ev8IyN
   4YVz/sj3tqT+4eSBYPS2wF0Lx550qyN+d42ScBWyD5IjnEA9V5xsosxqT
   A==;
X-IronPort-AV: E=Sophos;i="5.90,183,1643644800"; 
   d="scan'208";a="194324051"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 20:32:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvGfFwywom8qldkbl2vG9F9wHckUH7tO7k7QnOFb2ZEo62eUDWSyhT4P3PkWvCGhdlNvha4Th/RsrcYSr6+KQJTP39cj0bit99D2hhsTMbaWNMuSo6Ki7pAlzgSCgDvS9IwZxgrwqr2vADOfUVOgeogKgIfpLIv0Zy8TNtM4r5aT46lR7g+YszH7Lr9l7paTaEmPZ/WKCMLfgeIY/sIlELyqW6+MOf+X+rXZ08fpiOYgMqMO/V6zYcotjGjSpMqcL7d6Ym3sS3kbTS+5s2enTY4e7Kx9fpb8AMD2vLjSVhTdgcj+yNXtOocIpunwakZXjPhrRPn65hr/fgAACGMi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ytTqWE8JeYlr5xaZAXx4BSRYK/mZe8c/Z6q/bk0F+c=;
 b=ARhYSgrBz09myau4DWhuUpXtP9Su444BJFiBX6u8NKUoHgp0KJC/TU8hrMoTMs73oleVX17Xm70vEW+mmiYP/PKlwoguzaOhV9Wl3kFTH8+P4An6lHnmS0Cjlx8rGrSo4dfGDPqgY3iJo52gK8AWbI52fNpdlAEY+Qx4KpMGco8orgkjdteFsw8rc8+5jXXyWzeIrwFIQM4ErmL63oDsQtnhoyRy6TCBSJjl5k2jM5PA2F0rcSStzMMAYgKwQerr+5S7lJ6AQPYPfK0Ho16tLINnvyHOXR2jX348l0KfAbDcrhGGTQZ3G90DSed2bS8AD2/LHyOy0F1P1cQHckYglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ytTqWE8JeYlr5xaZAXx4BSRYK/mZe8c/Z6q/bk0F+c=;
 b=IM2rQvfmI+OYaOB1MF/6lN+8D+isyNLS3ZCjGe80mgRnlig31Fe1XW0GvEy0dO4hk5rx3Ua1NCOcaMR40DjlbTwlSdgDtfYuMMlUoiByYiqj9+5qcqBQx5ZPt75CgdHJY2rH/PeYvCwNvcnPlkz95d38OAInoQ4QcdxCqLUAQgM=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by DM6PR04MB6316.namprd04.prod.outlook.com (2603:10b6:5:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 12:32:18 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 12:32:18 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Topic: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Index: AQHYMw0pKwzLiS9sG0y93Ei4j88vWKy4YZeAgAA1PQCAAB3agIAB7+EAgAAI7YCAAAOigIAAB2QAgAAO1ACAAKBiAIADHl+AgAACrQCAADOIAIAAHFbggAB8RoCAAPimkA==
Date:   Tue, 15 Mar 2022 12:32:18 +0000
Message-ID: <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
In-Reply-To: <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea0bd3cb-a02a-4b02-6ab3-08da067fd862
x-ms-traffictypediagnostic: DM6PR04MB6316:EE_
x-microsoft-antispam-prvs: <DM6PR04MB631600DA597D51281F7BFCB9F1109@DM6PR04MB6316.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1gPXPZBgvWZJ16TlNPnftHbWJw3Sg8RNMIYy/ja551RIBi7SuL4dVOYul0dIzvhn4B2F0lL7Pbho91ulZ4QPZQ+72x+bf7xhvzuUSGJ65kYKrImquvgM8+auS//WtIcmrj5OzJy8Bnv0bPjpvz4O0+EIkZpAY8WruYTXH5plzDBdnJMcEw4MpxwCP5HhfUwYoYdP3ohRsaU3elI65HkHeBP+9yG2h7H16MI1eSCr1cWOQaF6BQRtVvkCYMAuaCLxwCIINZ0I6qt1ivsYn9sytSaaYqMKolGEiv5NFBJNAiF8Nx+kJbTs6+SEwaTd3J0Oy+SO5+0H7mzE/ZGuE+xKMABNEseI0X7MCMpUshXZ+J6kQGfpsxCpThQUd7s3RaK3GZxOAmKedLp5y/iEl263qVoh5jDzpGK8Lx5dgR1xv9hLtRkHsnauZNr4Y7Jthxnbq5wVFYXREa4wE60boI6FDY53PVyRlsBeN+akEnOSdDHMrSNCUMBk2AOZVFOCesJvjOoqg7pG31LCyqCqqq/Q6b1aYaJDXvUCgDeQRg0U4mFebZGi9RNCmAPv70vLNGZ8ipa61vOpQ5W+uxPPlLvvFdLQgdXWWSeRN4t6W/3h38dZx878nUTHthCgbJbm3SEKf8J8J+8LSZqV7AFHB6OAfz2MLAB58BhQtTDez7ydlbNOIkgpd9qI1TWEzjpggyu76c0uyhWFdo82EWQ6SlX4nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(82960400001)(122000001)(86362001)(38070700005)(9686003)(6916009)(186003)(26005)(54906003)(508600001)(71200400001)(7696005)(6506007)(66446008)(8676002)(4326008)(64756008)(66476007)(5660300002)(76116006)(66946007)(8936002)(52536014)(7416002)(66556008)(55016003)(316002)(83380400001)(85182001)(85202003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDlMTkJreVJDWjBNYmMyZzJRcTFFU2FTNmJndDdhZVBzS2htSlh3eWlyNlhZ?=
 =?utf-8?B?eE9hUithNDdZMTJPWlI4RXNDVUs4T01SM1FjSDhzb3pGdXAybG8ybDQ4TitZ?=
 =?utf-8?B?eXp1cXQxYVROTGlmd2hOMnI3REZKSDFCUmg4NFRuby8zQkZWdldVM0I1OEp1?=
 =?utf-8?B?dDhITnQzTjFDMUdOcGdoa2NMMVBLYjFSUm54ZC9mMkl4T1JIY3Q1MjhjRmVk?=
 =?utf-8?B?TlhvbDF2VW9QUGdPeFJtWDh3OHY2UXBLQm5DeTBLN3VmMjdzVDFtWmpWbkVH?=
 =?utf-8?B?OTUwdVNmVHorTjlqOXhNay9Sd0VuMURQT1lMUW5zeHFZR05ieTl6NThVYTFj?=
 =?utf-8?B?Rlc1eXNOVlFubXZlOXhjcFB3MHU3Q1FaTTMvWlU3K1VsUWU4aWcwUlJNUjdK?=
 =?utf-8?B?QXN1TEUvazFIYWhteGF5d0NXcS84UGxWak9Ra2JmMUxvNVdaS3I5SzV5cFFE?=
 =?utf-8?B?NVl1QmdNTGpuTHZ3b2FKNytYM3BoaXVTVjY1ZWVsb2I1ZkxMOGhuQzRHai9V?=
 =?utf-8?B?V0xLckdhYnU0TmQ0UjFpTUJoNDNzMEF0MkN2cmI3T3NOY0FycExSbnBXYVhW?=
 =?utf-8?B?WUpjTXlhYjRLZSs1S00vY1ZJL01nLy8ydERrNCtBcVRiZFNPd1pyS0hXbnNP?=
 =?utf-8?B?bEFrV3ZtTGN4dHp6YWZ4a2YzT3dZNFZaZHgwWXdVOVViWGRrRVl6bkY0TWhF?=
 =?utf-8?B?ZG15a3ZtU09CbzBzWU9WcHhjM3lTUVBBa0Fka29kMW15cnJ6UWRPdlMwTkpn?=
 =?utf-8?B?cHlETE9mcjlwdWxZWldEQm9hRWlNUGJmQnhDMytZUkFrUkM4THN5d2pGcVBr?=
 =?utf-8?B?ajRjbXk0SzdKbnhNUVZXa3ZBemxwVy9Jd0hBT1grbkZJTWdOS3dBaTNhc2Rr?=
 =?utf-8?B?eWRqSnBHZG5wQlJyaFRCNXMwZ3FMUDJYdzR4ekhmTENGRWc4NmxYLzc3dTZ4?=
 =?utf-8?B?eVliTW5HV09ZZE5HWW1XeWxwR0ZWcCtIbllQOW1hazNwSnNpLzNiYjI3cXIr?=
 =?utf-8?B?Q1lzUStiTmdYMU1jcExqOFFFeU5JVW5RTXRLYkpvaXVKSCtseGwzUmxxQm14?=
 =?utf-8?B?MGJwYjFsVnJMZnYwUXcrem05bUVvKzZmU1lQNkp2b2hvQi82QlJKTGVYMFNm?=
 =?utf-8?B?RVp0OThPb2Z4USt0eVluS2k2b3kvYjVLT3RBVDB0YUhvdGVYZFlLbkh2VHNs?=
 =?utf-8?B?NmdpaWlpNFM0WGxRN2lza3VTY1BnYWM3N0JHL2wwb29jeEs4U0JlenBYVlA5?=
 =?utf-8?B?VkNtZmlXd2d4TzJOUCt4V0wwTHpQVk9iUFdZNDhXMEpINktIUENPQVI2NUtX?=
 =?utf-8?B?a2N4b1Q2YXk2MGJ6ZjFjTFdtZ1hRQXhkTDNLNWM5Nzg4VitOb1hUMmRUR2VB?=
 =?utf-8?B?UTJtelkwS2hhR1B4RXdZTWM2N3l1NlFFWFVPajBMZ29hQ1o0eHFuRCtBaEFv?=
 =?utf-8?B?RTZLQW1tQVl5U1phd3haRm5NMG1wZW1hUytXRE10c1VyWDZQYXV4R3ptdDBV?=
 =?utf-8?B?bEt4US93SzNhUVlkQmM3aDlvMmNTcmpZa05VTmo2VkZkdUZ6eFR0dUFFRVpI?=
 =?utf-8?B?eVkxQXpSWEhwdy93UkljQ0FvbU1YRElnYkRMVUhBL3VGTngzSkxJbmk1ZnNo?=
 =?utf-8?B?U09yalpUQUNWZElZN1FkN3dlcHVhZUhJL1V2NXRwZ2hKdnYvdytxZ2Eyalkz?=
 =?utf-8?B?VmViUHBqcG0xUjExd09MelNWMlBIeXhpdlZTNysycU1IR3RFZE54aXcrOFZv?=
 =?utf-8?B?dmFMRlcwSmRQZHE5WUxHajFPTXFFTG5CUVZGTWlyT2l3ZTNGY25TajhnZVFM?=
 =?utf-8?B?TFBHZVkxSXVzSHdMZ0pQTmx2VzF4bU1STmdMejVaREl1WUcrSlkreFpwNjZw?=
 =?utf-8?B?dWh2SjRGN0NGL2dETGt5cERlaElPUURxUDd1bzdZVGxkNGxZMWRNWHV6cjdO?=
 =?utf-8?Q?+Urrsb77YNat2rp2kCzyqQTY7ZnsRflH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0bd3cb-a02a-4b02-6ab3-08da067fd862
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 12:32:18.6350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lT0Y7A+kIoZI04ARscXpSXjq8fSjH0azJWi4vVB0wM0IqtNNGzNDaVe2w+b/Kaevl93IgMko6Md9YDD8oYGQ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6316
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiA+R2l2ZW4gdGhlIGFib3ZlLCBhcHBsaWNhdGlvbnMgaGF2ZSB0byBiZSBjb25zY2lvdXMgb2Yg
em9uZXMgaW4gZ2VuZXJhbCBhbmQNCj4gd29yayB3aXRoaW4gdGhlaXIgYm91bmRhcmllcy4gSSBk
b24ndCB1bmRlcnN0YW5kIGhvdyBhcHBsaWNhdGlvbnMgY2FuIHdvcmsNCj4gd2l0aG91dCBoYXZp
bmcgcGVyLXpvbmUga25vd2xlZGdlLiBBbiBhcHBsaWNhdGlvbiB3b3VsZCBoYXZlIHRvIGtub3cg
YWJvdXQNCj4gem9uZXMgYW5kIHRoZWlyIHdyaXRlYWJsZSBjYXBhY2l0eS4gVG8gZGVjaWRlIHdo
ZXJlIGFuZCBob3cgZGF0YSBpcyB3cml0dGVuLA0KPiBhbiBhcHBsaWNhdGlvbiBtdXN0IG1hbmFn
ZSB3cml0aW5nIGFjcm9zcyB6b25lcywgc3BlY2lmaWMgb2ZmbGluZSB6b25lcywgYW5kDQo+IChj
dXJyZW50bHkpIGl0cyB3cml0ZWFibGUgY2FwYWNpdHkuIEkuZS4sIGtub3dsZWRnZSBhYm91dCB6
b25lcyBhbmQgaG9sZXMgaXMNCj4gcmVxdWlyZWQgZm9yIHdyaXRpbmcgdG8gem9uZWQgZGV2aWNl
cyBhbmQgaXNuJ3QgZWxpbWluYXRlZCBieSByZW1vdmluZyB0aGUgUE8yDQo+IHpvbmUgc2l6ZSBy
ZXF1aXJlbWVudC4NCj4gDQo+IFN1cHBvcnRpbmcgb2ZmbGluZXMgem9uZXMgaXMgb3B0aW9uYWwg
aW4gdGhlIFpOUyBzcGVjPyBXZSBhcmUgbm90IGNvbnNpZGVyaW5nDQo+IHN1cHBvcnRpbmcgdGhp
cyBpbiB0aGUgaG9zdC4gVGhpcyB3aWxsIGJlIGhhbmRsZWQgYnkgdGhlIGRldmljZSBmb3IgZXhh
Y3RseQ0KPiBtYWludGFpbmluZyB0aGUgU1cgc3RhY2sgc2ltcGxlci4NCg0KSXQgaXNuJ3Qgb3B0
aW9uYWwuIFRoZSBzcGVjIGFsbG93cyBhbnkgem9uZXMgdG8gZ28gdG8gUmVhZCBPbmx5IG9yIE9m
ZmxpbmUgc3RhdGUgYXQgYW55IHBvaW50IGluIHRpbWUuIEEgc3BlY2lmaWMgaW1wbGVtZW50YXRp
b24gbWlnaHQgZ2l2ZSBzb21lIGd1YXJhbnRlZXMgdG8gd2hlbiBzdWNoIHRyYW5zaXRpb25zIGhh
cHBlbnMsIGJ1dCBpdCBtdXN0IG5ldmVydGhlbGVzcyBtdXN0IGJlIG1hbmFnZWQgYnkgdGhlIGhv
c3Qgc29mdHdhcmUuIA0KDQpHaXZlbiB0aGF0LCBhbmQgdGhlIG5lZWQgdG8gbm90IGlzc3VlIHdy
aXRlcyB0aGF0IHNwYW5zIHpvbmVzLCBhbiBhcHBsaWNhdGlvbiB3b3VsZCBoYXZlIHRvIGF3YXJl
IG9mIHN1Y2ggYmVoYXZpb3JzLiBUaGUgaW5mb3JtYXRpb24gdG8gbWFrZSB0aG9zZSBkZWNpc2lv
bnMgYXJlIGluIGEgem9uZSdzIGF0dHJpYnV0ZXMsIGFuZCB0aHVzIGFwcGxpY2F0aW9ucyB3b3Vs
ZCBwdWxsIHRob3NlLCBpdCB3b3VsZCBhbHNvIGtub3cgdGhlIHdyaXRlYWJsZSBjYXBhYmlsaXR5
IG9mIGEgem9uZS4gU28sIGFsbCBpbiBhbGwsIGNyZWF0aW5nIHN1cHBvcnQgZm9yIE5QTzIgaXMg
c29tZXRoaW5nIHRoYXQgdGFrZXMgYSBsb3Qgb2Ygd29yaywgYnV0IG1pZ2h0IGhhdmUgbGl0dGxl
IHRvIG5vIGltcGFjdCBvbiB0aGUgb3ZlcmFsbCBzb2Z0d2FyZSBkZXNpZ24uIA0KDQo+ID4NCj4g
PkZvciB5ZWFycywgdGhlIFBPMiByZXF1aXJlbWVudCBoYXMgYmVlbiBrbm93biBpbiB0aGUgTGlu
dXggY29tbXVuaXR5IGFuZA0KPiBieSB0aGUgWk5TIFNTRCB2ZW5kb3JzLiBTb21lIFNTRCBpbXBs
ZW1lbnRvcnMgaGF2ZSBjaG9zZW4gbm90IHRvIHN1cHBvcnQNCj4gUE8yIHpvbmUgc2l6ZXMsIHdo
aWNoIGlzIGEgcGVyZmVjdGx5IHZhbGlkIGRlY2lzaW9uLiBCdXQgaXRzIGltcGxlbWVudG9ycw0K
PiBrbm93aW5nbHkgZGlkIHRoYXQgd2hpbGUga25vd2luZyB0aGF0IHRoZSBMaW51eCBrZXJuZWwg
ZGlkbid0IHN1cHBvcnQgaXQuDQo+ID4NCj4gPkkgd2FudCB0byB0dXJuIHRoZSBhcmd1bWVudCBh
cm91bmQgdG8gc2VlIGl0IGZyb20gdGhlIGtlcm5lbCBkZXZlbG9wZXIncyBwb2ludA0KPiBvZiB2
aWV3LiBUaGV5IGhhdmUgY29tbXVuaWNhdGVkIHRoZSBQTzIgcmVxdWlyZW1lbnQgY2xlYXJseSwg
dGhlcmUncyBnb29kDQo+IHByZWNlZGVuY2Ugd29ya2luZyB3aXRoIFBPMiB6b25lIHNpemVzLCBh
bmQgYXQgbGFzdCwgaG9sZXMgY2FuJ3QgYmUgYXZvaWRlZA0KPiBhbmQgYXJlIHBhcnQgb2YgdGhl
IG92ZXJhbGwgZGVzaWduIG9mIHpvbmVkIHN0b3JhZ2UgZGV2aWNlcy4gU28gd2h5IHNob3VsZCB0
aGUNCj4ga2VybmVsIGRldmVsb3BlcidzIHRha2Ugb24gdGhlIGxvbmctdGVybSBtYWludGVuYW5j
ZSBidXJkZW4gb2YgTlBPMiB6b25lDQo+IHNpemVzPw0KPiANCj4gWW91IGhhdmUgYSBnb29kIHBv
aW50LCBhbmQgdGhhdCBpcyB0aGUgcXVlc3Rpb24gd2UgbmVlZCB0byBoZWxwIGFuc3dlci4NCj4g
QXMgSSBzZWUgaXQsIHJlcXVpcmVtZW50cyBldm9sdmUgYW5kIHRoZSBrZXJuZWwgY2hhbmdlcyB3
aXRoIGl0IGFzIGxvbmcgYXMgdGhlcmUNCj4gYXJlIGFjdGl2ZSB1cHN0cmVhbSB1c2VycyBmb3Ig
aXQuDQoNClRydWUuIFRoZXJlJ3MgYWxzbyBhY3RpdmUgdXNlcnMgZm9yIFNTRHMgd2hpY2ggYXJl
IGN1c3RvbSAoZS5nLiwgbGFyZ2VyIHRoYW4gNEtpQiB3cml0ZXMgcmVxdWlyZWQpIC0gYnV0IHRo
ZXkgYXJlbid0IHN1cHBvcnRlZCBieSB0aGUgTGludXgga2VybmVsIGFuZCBpc24ndCBhY3RpdmVs
eSBiZWluZyB3b3JrZWQgb24gdG8gbXkga25vd2xlZGdlLiBXaGljaCBpcyBmaW5lLCBhcyB0aGUg
Y3VzdG9tZXJzIGFueXdheSB1c2VzIHRoaXMgaW4gdGhlaXIgb3duIHdheSwgYW5kIGRvbid0IG5l
ZWQgdGhlIExpbnV4IGtlcm5lbCBzdXBwb3J0Lg0KIA0KPiANCj4gVGhlIG1haW4gY29uc3RyYWlu
dCBmb3IgKDEpIFBPMiBpcyByZW1vdmVkIGluIHRoZSBibG9jayBsYXllciwgd2UgaGF2ZSAoMikg
TGludXggaG9zdHMNCj4gc3RhdGluZyB0aGF0IHVubWFwcGVkIExCQXMgYXJlIGEgcHJvYmxlbSwg
YW5kIHdlIGhhdmUgKDMpIEhXIHN1cHBvcnRpbmcNCj4gc2l6ZT1jYXBhY2l0eS4NCj4gDQo+IEkg
d291bGQgYmUgaGFwcHkgdG8gaGVhciB3aGF0IGVsc2UgeW91IHdvdWxkIGxpa2UgdG8gc2VlIGZv
ciB0aGlzIHRvIGJlIG9mIHVzZSB0bw0KPiB0aGUga2VybmVsIGNvbW11bml0eS4NCg0KKEFkZGVk
IG51bWJlcnMgdG8geW91ciBwYXJhZ3JhcGggYWJvdmUpDQoNCjEuIFRoZSBzeXNmcyBjaHVua3Np
emUgYXR0cmlidXRlIHdhcyAibWlzdXNlZCIgdG8gYWxzbyByZXByZXNlbnQgem9uZSBzaXplLiBX
aGF0IGhhcyBjaGFuZ2VkIGlzIHRoYXQgUkFJRCBjb250cm9sbGVycyBub3cgY2FuIHVzZSBhIE5Q
TzIgY2h1bmsgc2l6ZS4gVGhpcyB3YXNuJ3QgbWVhbnQgdG8gbmF0dXJhbGx5IGV4dGVuZCB0byB6
b25lcywgd2hpY2ggYXMgc2hvd24gaW4gdGhlIGN1cnJlbnQgcG9zdGVkIHBhdGNoc2V0LCBpcyBh
IGxvdCBtb3JlIHdvcmsuDQoyLiBCbyBtZW50aW9uZWQgdGhhdCB0aGUgc29mdHdhcmUgYWxyZWFk
eSBtYW5hZ2VzIGhvbGVzLiBJdCB0b29rIGEgYml0IG9mIHRpbWUgdG8gZ2V0IHJpZ2h0LCBidXQg
bm93IGl0IHdvcmtzLiBUaHVzLCB0aGUgc29mdHdhcmUgaW4gcXVlc3Rpb24gaXMgYWxyZWFkeSBj
YXBhYmxlIG9mIHdvcmtpbmcgd2l0aCBob2xlcy4gVGh1cywgZml4aW5nIHRoaXMsIHdvdWxkIHBy
ZXNlbnQgaXRzZWxmIGFzIGEgbWlub3Igb3B0aW1pemF0aW9uIG92ZXJhbGwuIEknbSBub3QgY29u
dmluY2VkIHRoZSB3b3JrIHRvIGRvIHRoaXMgaW4gdGhlIGtlcm5lbCBpcyBwcm9wb3J0aW9uYWwg
dG8gdGhlIGNoYW5nZSBpdCdsbCBtYWtlIHRvIHRoZSBhcHBsaWNhdGlvbnMuDQozLiBJJ20gaGFw
cHkgdG8gaGVhciB0aGF0LiBIb3dldmVyLCBJJ2xsIGxpa2UgdG8gcmVpdGVyYXRlIHRoZSBwb2lu
dCB0aGF0IHRoZSBQTzIgcmVxdWlyZW1lbnQgaGF2ZSBiZWVuIGtub3duIGZvciB5ZWFycy4gVGhh
dCB0aGVyZSdzIGEgZHJpdmUgZG9pbmcgTlBPMiB6b25lcyBpcyBncmVhdCwgYnV0IGEgZGVjaXNp
b24gd2FzIG1hZGUgYnkgdGhlIFNTRCBpbXBsZW1lbnRvcnMgdG8gbm90IHN1cHBvcnQgdGhlIExp
bnV4IGtlcm5lbCBnaXZlbiBpdHMgY3VycmVudCBpbXBsZW1lbnRhdGlvbi4gDQoNCkFsbCB0aGF0
IHNhaWQgLSBpZiB0aGVyZSBhcmUgcGVvcGxlIHdpbGxpbmcgdG8gZG8gdGhlIHdvcmsgYW5kIGl0
IGRvZXNuJ3QgaGF2ZSBhIG5lZ2F0aXZlIGltcGFjdCBvbiBwZXJmb3JtYW5jZSwgY29kZSBxdWFs
aXR5LCBtYWludGVuYW5jZSBjb21wbGV4aXR5LCBldGMuIHRoZW4gdGhlcmUgaXNuJ3QgYW55dGhp
bmcgc2F5aW5nIHN1cHBvcnQgY2FuJ3QgYmUgYWRkZWQgLSBidXQgaXQgZG9lcyBzZWVtIGxpa2Ug
aXTigJlzIGEgbG90IG9mIHdvcmssIGZvciBsaXR0bGUgb3ZlcmFsbCBiZW5lZml0cyB0byBhcHBs
aWNhdGlvbnMgYW5kIHRoZSBob3N0IHVzZXJzLg0KDQoNCg==
