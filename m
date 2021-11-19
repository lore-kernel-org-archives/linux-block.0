Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA4C433F5
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D0D61213
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 16:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbhKSQ7q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:59:46 -0500
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140]:32372 "EHLO
        esa.hc4959-67.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbhKSQ7p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 11:59:45 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Nov 2021 11:59:45 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1637341004; x=1668877004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hMG7GJ2v5Xvv6MTE4fKAKWcnuLxo6ANouehGnxpgsOU=;
  b=B2HKxkKqOAw22xG55e+/+inzNsmAxgVh4vXX3HAyAJp3fWl5syQFwmjy
   NJSljknwQvELSmR3GWG3I8twyxKgy0ljIq0164zBynhg40I8l/+1KEVf/
   bF+k4cevikYWrDuQKWNIlRp2nimITGK5F3MpDMwR9cwpviaFfChn0N6BD
   E=;
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 08:49:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOVKGVLZNpzjfaDHjS6IoS4vjH/3rVlzGtg62xvbYafZkF78dYkSBVn8/uhTFBEWbUzIszxr+xFqN2vwcQvDc68LZ3ahTi8NP4FahfbKYGIwugOm4unKt/RT9W+opVpa07D0rgmYefZlmc3jCqOWtztlKKj89yLV4zH9ty3Tc82CHeUgZhlI+uJsbnuawRdUiHIvM0iK2Odz7uCCHPivPIanTb/EAgz9rXTU0ru3bClPWRVD/teFU4neTzI1SlrXkosUen8o3Rm1wL+9JduurbdmFTEBN4CvXctMaN8TJOb6Wr+ulgaSMUAIIRZ9Y89LLwLocP81XS2tu9dYJuXnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMG7GJ2v5Xvv6MTE4fKAKWcnuLxo6ANouehGnxpgsOU=;
 b=H5iwaulHebHg2m/5kPhcgNaiiaSrTRczrrQ8W/PC8xQGffAA18VDasTh2iRzgelDc/s0vEJMQhfI7ejGMAia4n2gnYxEiB1+EIsGnkxif87GcEeBD99FV4yRz7Oo+9wngBSH9WAQbQbqZ2Sc6tBkcbzyU7DGdcP5T4nqKDoMxPjNS1yVDa7hP2ePE2igpNCbgSzjd1WpTWvS54ORdA1783VVrMWNtWkyjlab638qkWsbXvH5I0/QzEZg0csg/e3q9VZ3g38P8GspTxsfBD6bAnChRSvXCDTx1EJtZ/o+u8JzdLF7ikVdbBfBEH7yUEzqLsZKj4ma3AYmkfN5WrgPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMG7GJ2v5Xvv6MTE4fKAKWcnuLxo6ANouehGnxpgsOU=;
 b=bq/96AKIr8uaj9NCqp9YRafVB0D1W+PGIJX1GMS52k2eGD9Ki79f24SZA01IYUC2MrSkFRYlrrAGtY7fhm5sOjt/bQxB70wlHqSudjKMVJlcD8Wrq6BMQU0MJKkjokSeLlDWyGoeUYrg0bZpY/I2ccQEzXp2hKNsLG/2728hXOs=
Received: from BLAPR20MB3954.namprd20.prod.outlook.com (2603:10b6:208:331::13)
 by BLAPR20MB3969.namprd20.prod.outlook.com (2603:10b6:208:307::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 16:49:35 +0000
Received: from BLAPR20MB3954.namprd20.prod.outlook.com
 ([fe80::9c10:4bdc:7f1c:6351]) by BLAPR20MB3954.namprd20.prod.outlook.com
 ([fe80::9c10:4bdc:7f1c:6351%3]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 16:49:34 +0000
From:   Tim Walker <tim.t.walker@seagate.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: don't insert FUA request with data into scheduler
 queue
Thread-Topic: [PATCH] blk-mq: don't insert FUA request with data into
 scheduler queue
Thread-Index: AQHX3JFMHVHpph1UsEOPk1igXvdaHQ==
Date:   Fri, 19 Nov 2021 16:49:34 +0000
Message-ID: <3DEFF083-6C67-4864-81A5-454A7DAC16C0@seagate.com>
References: <20211118153041.2163228-1-ming.lei@redhat.com>
 <163732851304.44181.8545954410705439362.b4-ty@kernel.dk>
 <BFC93946-13B3-43EC-9E30-8A980CD5234F@seagate.com>
In-Reply-To: <BFC93946-13B3-43EC-9E30-8A980CD5234F@seagate.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.55.21111400
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37781393-2bd2-4c18-720f-08d9ab7c9124
x-ms-traffictypediagnostic: BLAPR20MB3969:
x-microsoft-antispam-prvs: <BLAPR20MB39693DF9D8728DA9AE86024AD79C9@BLAPR20MB3969.namprd20.prod.outlook.com>
stx-hosted-ironport-oubound: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJMEmtlYBE3P6x+ePZI5vRIXIxCa7SmofQ0IcBbzA4nZVXeEOdq2nxpwiUW4AuTdbOaC705olXgSSvULmIUgWi3P1Z2VmSP8h/1CULxffgyjhcB2k8HQ+OqYvnOxyd8BwYxHR2fL6ce8ds8XlHY+nVJbij1eDmcKE4F+EicyThgMq0yXYMF3RFd4E1HUya2ADbNqFslU4AMGqAIGGpqCA/W8haf6OoPPNKdmjm+08AfvgKybUAmo3nP+9sfX8bmZW+7ASnSnnX9k3te7kcMv4YRFQQk63gcMH6q4Ea/aVGbFJKQv7TX5fp0NoB9JkXYfCO7p5NSFjWWJwXIklE7claO/L1d0cRDAv57f9QRDP0DMm9d3+1A356xXhU92AbAQiJzl2bY4+pdTY9Hp7s5PuYW0k2MuOIpLph4Jyrkz2CvkyGrTFBP/7gQVuW5dp8Ovm3oS4TAymgJuz+8JVd9+nLiF3PM3csDS7ddDIgRcDetnoYT2bq9G0P0Yn+51Js5mnIzwpoLtKlVuGzg6O59+hNJ8khwPGxxGNZ7ZQl0Hi96LLAoaBrxZyesi1udwdk61rouHkLB4a3YhlN2b2VPdbiBVHXqmpB7Ech1F+t3zDL8PdETPbea2FESIypaKgxQjc4uNrhBxliJQkMMn9X0UknLM9Y7sB18CI7BcjViLnytg1FzsJujSga81RsYSyxuwAknL5yoU3lJLbEeJcl2Zcve440L06WgW/eIs4sOa+nrgNgq7QKGddkJwgN3uQH1N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR20MB3954.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(5660300002)(91956017)(2906002)(6506007)(38100700002)(4326008)(33656002)(316002)(64756008)(54906003)(76116006)(26005)(8676002)(86362001)(36756003)(2616005)(122000001)(6486002)(8936002)(83380400001)(186003)(66446008)(110136005)(66946007)(38070700005)(6512007)(66556008)(508600001)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1k0ak9PRUhjeks2bG05VUtwdVJzVmZkZE42K2lUM0s4L1FuT3FXV0JJa0J2?=
 =?utf-8?B?Qnh1MU9ST0ZxTUFDVW5qZzArc1RSbVcwYmtsL1d6cWt4VmNrRlR3R2xSaUFU?=
 =?utf-8?B?dUpWT2VaQlRmOWkyTU9oZVFua2VFWk5jOHMyU24rb1FoK1l3LzVJbWRzbEJm?=
 =?utf-8?B?YldXbUw5cXB0OW4ya3JxcE9sdUxrcnBZMjh1WmZiZ2NLb0diVEQyRUhFTStI?=
 =?utf-8?B?YWh5aytQTk9mSEVhd2V1d2JyNFRISDhMcXFHRjFxRzA3Z0Q1N3Bxd0ZzREkw?=
 =?utf-8?B?OC93RjdTRU85dXVlUG9DN25aL3VxYU1ubHZLbDB2WFFuaDUvWE9tOUpseDZE?=
 =?utf-8?B?MVI0Nm5vTnlFV0RvWTRWa3JHemNwUDhhMVhDZnBkYkRxY3lCT2Y3WWJNeHdV?=
 =?utf-8?B?RXBPZUVEeDIzaWIxRU1qMmdtRGF2OTdkZk1adW1vUkNkNDI1TmE1eVVNSEln?=
 =?utf-8?B?MnVOTVpNNkQ0dUpNZUVubUM4Z1ljOGJ2VHlNNUE4VjV1RTkrOG9nd29NbkxV?=
 =?utf-8?B?ZXdqNStxY253cHRLYkV6eFZ1blM2d0xqUEtoMS9HM2R2RFVOTi9kUVB1NE15?=
 =?utf-8?B?UkxvY1hCeVBGc0hoZkpVZU9FT1EzSE5nVEowOEwyZ0ZOZFJmR2FhOTVIYk8w?=
 =?utf-8?B?ejBGZ2N4QXlZcUEzbUpmbnlna2pQalJWVDJqVzUvMkxWcC92aTZRQTJpVThz?=
 =?utf-8?B?KzRzWUxNL05jMWEvTER3eDJCWWIvSlRqQnRqZndwK2l2eTJaTld1YkwvNm9n?=
 =?utf-8?B?N3Q2VDFVNVhnU1pLOEtGWU5kcmRSMUlXdW1pWnRJdnRNcU4zY1ljYUg0OCtp?=
 =?utf-8?B?QkhQSC9hYjNWVUE5NG5DcU1GSnZwckxBbXljWFMyc0V5UGNINEZ3MmpuS1lF?=
 =?utf-8?B?N2ZYTVZDTlgrcUdOcmhWMW11QXdhdHlqWVFwSzNvWkhLNjR6a3BYcStOd2xo?=
 =?utf-8?B?Nk90elZ2UXVYU0E1TytMNVppMldiK1VxbExKSmNpNi9pZG43dnpTRUwrSFQ4?=
 =?utf-8?B?WGdEUWVnK3Uwc1ZSTVdmTC9VWUhPOVlCMlo2em4xZW1IMGFUWTAyYktUcjM2?=
 =?utf-8?B?c25zN0dYSDZLUFIrYjZrUElCY1h6YktVWXZoc24wNzJkMWI2ZkJnUURXZnN3?=
 =?utf-8?B?K3FGenJNVUsvWWxWUkNXWFdEb0d4dEJubzMxZ1BQTHhNS1R0Z2h6VWlPU25a?=
 =?utf-8?B?NXlOVC9DZXRjYy8xM2t4NUJzUWc1TmpncUhSeHYvcVBpYUN2bmprcWNWZTYx?=
 =?utf-8?B?VVR4NzF3OFpYV1oydEsvNlI2TmxRL2UxbVVNV3FOZUs2VHZZS2ZVZ3Y1RDJT?=
 =?utf-8?B?UzRldmJHWEJ1cDI0WGw0citPZG9qM1ZGZmFZaGhwWStWenlSdWpnNHRxOVp0?=
 =?utf-8?B?bUFjR2ZCc2czYUcrenBmRFFUYzRHWTVodEhoL1RXSVMvcUJpM2w1T2JoUkww?=
 =?utf-8?B?aFZUS0pPSG1nNzJMd2RLVTdGUHpZM0V5R1ZlUk1MdU15ZFlwdmJGTS9TcWpP?=
 =?utf-8?B?SGxXaE94eHJ5WVhFZUFCWitvODMzM3p5VXgrSTdDNURoa1NMM0FtNUtIOS9B?=
 =?utf-8?B?VzNHdnVkQXBsd2I2eUF5WURuS1pKTEV2V3RYdTdnVGZJMWxpMnc4aDlsSUQ3?=
 =?utf-8?B?NUJ0UnRJN1dydENRWmdFMFBHaUl3bWRra20rcEFpMXNUbkt6UmNvdGtWZVl2?=
 =?utf-8?B?RktmRXE4ajNYWUFwY0xrK0k2WklERjZLbW5iU0NYK3pvUHRzR2JzWkJzaVJT?=
 =?utf-8?B?TGVkU2kvTmY5MmNndGw5YVJ0ZW1aRHFWYjRoeW5Kc0VEZDloY2VqUHR3cS9K?=
 =?utf-8?B?N0pQL293elJhUUVUQUlmN3ZOeElHMkxmZGxZejNiOHVkcktsbVgzOGRXcHlS?=
 =?utf-8?B?azVKRFRvQytkZUkwaVJYa1hLcXR4RENkcGp6RHYxWCtDMlc0S3J2cDZWZ2I5?=
 =?utf-8?B?NnJ6RGZnQ0I2M3JQR3JTU3N4YzBHdlRleU9TR29MTmY1eWthZXdZSFlobHNG?=
 =?utf-8?B?VW5zVTRaaWZlclRHWlRzdWk5Nllkb1llM0VOOHNTQ2FhSVh5VXRYdk5FWXRT?=
 =?utf-8?B?T0xBVEF1ZVR5dWhRdDBwQ1BaQjFlbDBQanpteTBDZVJ1YVlpdmVaYlpiQ2dC?=
 =?utf-8?B?QmJ6cXpLSXdxY2QxVEtUdUlFVmVTdHgwaERtS3JBUDQ0cllzM2dSMmtidy9I?=
 =?utf-8?B?a1BKNkJIWWFYMzFSVmRramd6SVdGQ3BtNmkzQnJmUENuMkNUbFE0ODNneXlh?=
 =?utf-8?Q?QtQI8b90iafXqxvWTV4VFkmEct+btU4zyOUUHCRi2Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CC8B245B4BCF249BE64202437C2823D@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR20MB3954.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37781393-2bd2-4c18-720f-08d9ab7c9124
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 16:49:34.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NlRy09/EbBTeV0rvZEIlZSITY04LhwZ0CpKabkvlC003WJqg41yAYbTuSdXh+z8gleF0kRS8rnrBBNMCh2fi8/6pmzqFwjzSESW+jDPuz4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR20MB3969
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCu+7v09uICAxOSBOb3YgMjAyMSBUaW0gV2Fsa2VyIHdyb3RlOg0KDQo+DQo+DQo+T24gVGh1
LCAxOCBOb3YgMjAyMSAyMzozMDo0MSArMDgwMCwgTWluZyBMZWkgd3JvdGU6DQo+PiBXZSBuZXZl
ciBpbnNlcnQgZmx1c2ggcmVxdWVzdCBpbnRvIHNjaGVkdWxlciBxdWV1ZSBiZWZvcmUuDQo+Pg0K
Pj4gUmVjZW50bHkgY29tbWl0IGQ5MmNhOWQ4MzQ4ZiAoImJsay1tcTogZG9uJ3QgaGFuZGxlIG5v
bi1mbHVzaCByZXF1ZXN0cyBpbg0KPj4gYmxrX2luc2VydF9mbHVzaCIpIHRyaWVzIHRvIGhhbmRs
ZSBGVUEgZGF0YSByZXF1ZXN0IGFzIG5vcm1hbCByZXF1ZXN0Lg0KPj4gVGhpcyB3YXkgaGFzIGNh
dXNlZCB3YXJuaW5nWzFdIGluIG1xLWRlYWRsaW5lIGRkX2V4aXRfc2NoZWQoKSBvciBpbyBoYW5n
IGluDQo+PiBjYXNlIG9mIGt5YmVyIHNpbmNlIFJRRl9FTFZQUklWIGlzbid0IHNldCBmb3IgZmx1
c2ggcmVxdWVzdCwgdGhlbg0KPj4gLT5maW5pc2hfcmVxdWVzdCB3b24ndCBiZSBjYWxsZWQuDQo+
Pg0KPj4gWy4uLl0NCj4NCj5BcHBsaWVkLCB0aGFua3MhDQo+DQo+WzEvMV0gYmxrLW1xOiBkb24n
dCBpbnNlcnQgRlVBIHJlcXVlc3Qgd2l0aCBkYXRhIGludG8gc2NoZWR1bGVyIHF1ZXVlDQo+ICAg
ICAgY29tbWl0OiAyYjUwNGJkNDg0MWJjY2JmM2ViODNjMWZlYzIyOWI2NTk1NmFkOGFkDQo+DQo+
QmVzdCByZWdhcmRzLA0KPi0tDQo+SmVucyBBeGJvZQ0KPg0KPg0KPg0KDQpJIGtub3cgdGhlIGRp
c2N1c3Npb24gaXMgb3ZlciwgYnV0IEkgY2FuJ3QgZmlndXJlIG91dCB3aHkgd2UgdHJlYXQgRlVB
IGFzIGEgZmx1c2guIEEgRlVBIHdyaXRlIG9ubHkgYXBwbGllcyB0byB0aGUgY29tbWFuZCBhdCBo
YW5kLCBhbmQgaXMgbm90IHJlcXVpcmVkIHRvIGZsdXNoIGFueSBwcmV2aW91cyBjb21tYW5kJ3Mg
ZGF0YSBmcm9tIHRoZSBkZXZpY2UncyB2b2xhdGlsZSB3cml0ZSBjYWNoZS4gU2ltaWxhcmx5IGZv
ciBhIHJlYWQgcmVxdWVzdCAtIHNlcnZpY2luZyBhIHJlYWQgZnJvbSBtZWRpYSBpcyByZWFsbHkg
bW9yZSB0aGUgcnVsZSB0aGFuIHRoZSBleGNlcHRpb24gKGxvdHMgb2Ygd29ya2xvYWQgZGVwZW5k
ZW5jaWVzIGhlcmUuLi4pLCBzbyB3aHkgd291bGQgYSBGVUEgcmVhZCBieXBhc3MgdGhlIHNjaGVk
dWxlcj8gVGhlIGRldmljZSBpcyBhbHdheXMgZnJlZSB0byBzZXJ2aWNlIGFueSByZXF1ZXN0IGZy
b20gbWVkaWEgb3IgY2FjaGUgKGFzIGxvbmcgYXMgaXQgZm9sbG93cyB0aGUgYXBwbGljYWJsZSB2
b2xhdGlsZSB3cml0ZSBhbmQgcmVhZCBjYWNoZSBzZXR0aW5ncyksIHNvIG5vcm1hbGx5IHdlIGRv
bid0IGtub3cgaG93IGl0IGlzIHRyZWF0aW5nIHRoZSByZXF1ZXN0LCBzbyBpdCBkb2Vzbid0IHNl
ZW0gdG8gbWF0dGVyLiANCg0KQ29uc2lkZXIgYSBGVUEgd3JpdGU6IFdoeSBkb2VzIHRoZSBmYWN0
IHRoYXQgd2UgaW50ZW5kIHRoYXQgd3JpdGUgdG8gYnlwYXNzIHRoZSBkZXZpY2Ugdm9sYXRpbGUg
d3JpdGUgY2FjaGUgbWVhbiBpdCBzaG91bGQgYnlwYXNzIHRoZSBzY2hlZHVsZXI/IEFsbCB0aGUg
b3RoZXIgdHJhZmZpYy1zaGFwaW5nIGFsZ29yaXRobXMgdGhhdCBoZWxwIGVmZmVjdGl2ZWx5IHNj
aGVkdWxlIHdyaXRlcyBhcmUgc3RpbGwgYXBwbGljYWJsZS4gRS5nLiB3ZSBrbm93IHdlIGNhbiBk
ZWxheS9jb2FsZXNjZSB0aGVtIGEgYml0IHRvIGFsbG93IHJlYWRzIHRvIGJlIHByaW9yaXRpemVk
LCBidXQgSSBjYW4ndCBmaWd1cmUgb3V0IHdoeSB3ZSB3b3VsZCBmYXN0LXRyYWNrIGEgRlVBIHdy
aXRlLiBJc24ndCB0aGUgdmFsdWUgdG8gdGhlIHN5c3RlbSBmb3Igc2NoZWR1bGluZyBzdGlsbCB2
YWxpZCwgZXZlbiB0aG91Z2ggd2UgYXJlIGZvcmNpbmcgdGhlIGRhdGEgdG8gZ28gdG8gbWVkaWE/
DQoNCkknbSBzdXJlIHRoZXJlIGlzIHNvbWUgZGV0YWlsIEkgYW0gbWlzc2luZyAtIGFueSBoZWxw
IHdvdWxkIGJlIGFwcHJlY2lhdGVkLiBUaGFua3MhDQoNCkJlc3QgcmVnYXJkcywNCi1UaW0NCg0K
DQo=
