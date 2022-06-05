Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C07C433EF
	for <linux-block@archiver.kernel.org>; Sun,  5 Jun 2022 23:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbiFEXXF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Jun 2022 19:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348570AbiFEXXE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Jun 2022 19:23:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342EF1FCE6
        for <linux-block@vger.kernel.org>; Sun,  5 Jun 2022 16:23:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0hHRlLTI6Oqp3iXYv1hLQVu9dylca4/DK3foYqDQ799kL35I0ySA27uCTcaUw+A3AB6dtxQT/4fDT+aEUF6yjib7RleKRY7kNMa7W7mrpqj8MyIUTG3JdBr63ntAkZjPFsc8s1/t6v/rh67wfjaEBMM8j2XrIg11a+xsZocSJZ/Xf3UvGIRYO2UYer10jT9h2GFDS1dAS+DOJmftD0rmtNTMSp9T39G+JMGdrmtKlPbZtsS8Z7ta/Y+fpJCC5s84fPmd2AZn2RmoV63qripkYUAcrPboou8y4vF73mkvPAxmlDKXj9731Tte5xJDO2BMuxYT3o1ixgYCSxh64O7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xZcLYy/UXkTWD0cWI8ePq3zeoCKVyqM1qMSSidwka8=;
 b=mn7HbcgbYaENHDIFxnaZKkkOYUu7w0drI1/4/CpJ3kdPTjxaldBZoAwghd3nUU3TOe7Ho/Jqu/QY9lAe3hTfIlFmBt2br1dx8YH722hmGqnjaRShCMaYvIwA4Fuhx4zYgL+FoB+0UJgndTp4U+oYxfMhr6E7Q0nEszkkfApl3pda+b8HL3TWb2dMnJg6RF4scrvfp7GHG6sJtXqS/J3oJdgMQo7DlqJ3M8fFuMs6wTkIFcjwFcyqK1Mm3PtWyE7HKypliVgVxUOi68op9fgRJjl4L8ULytxXwFIAxLVhc6wpyvJw4vU0w1BJrgNm3m2VRoWkrzTavLQNlxJ471zckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xZcLYy/UXkTWD0cWI8ePq3zeoCKVyqM1qMSSidwka8=;
 b=VicEbX1CMCSeJQkuA16fkmGsV9SQXUa+mxPKdmYIcf6isp5suxy/RenddVh57AL5quaDTFKM/RgorYLVe5nuRAuxGXf424Gmh2o+tlBfhx3zYgTHBQmtgjALNp1bs1nC5txo7HJOKZhN8bsBCweZlMaMzODdeUb3ZrWvYtfjBXWo4Z+Cle5Mb6yGz7/3H9fbizCrLWv44sbx6GbKH6IKTeZXXKUTO9Hp437DWb2BGWh5q7y6and/P8gIe1Fojv4xh4aLT5yN+PDO3f82UYmV1oiOQ2sBOWAedCh5yql+28MIe8TDoaI6RUgaxMaZX/mfi9Z12l+M2gWyuwQs/oklig==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Sun, 5 Jun
 2022 23:23:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Sun, 5 Jun 2022
 23:23:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH blktests] nvme/033: Remove volatile output
Thread-Topic: [PATCH blktests] nvme/033: Remove volatile output
Thread-Index: AQHYeC0Zx//CHU8PaEWiGsMKauZppa1BdgmA
Date:   Sun, 5 Jun 2022 23:22:59 +0000
Message-ID: <41fc2524-3b7d-dbcb-04c6-9dc803dccddb@nvidia.com>
References: <20220604160638.1118-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220604160638.1118-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 648911bb-f3e6-486c-bb43-08da474a54b2
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_
x-microsoft-antispam-prvs: <CY5PR12MB6369C438E6780BE3B5330C31A3A39@CY5PR12MB6369.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHenkidaanP1vq/SccDAhm0TVDqR7dfLVLb9GnkHZIXx4hBqOTVgUnMxjJxdY2y1zTi492/D6nszttLYa5HuZqcjSAravOSlhSL8KEkNydpJ8WLmnqOWnXuWQlDe/RRFlaD8QfTll3ofKZxq0XY1xzidfd1wjMeM37r4NuDE8JlAdPmj26rOz1nXbH0d0wlJ8hAsRCfp7HmFgvnpsyJw1EYMpCyNGKg6xquzw/mIvA1zQhD+yKU1XrNKpPkJyTBr9icJlE4Z0+F1bgJG0lN74lJwaAd+vM4z8BShEZH7jou9Q25lmzy1abc5eDfZl0WD+/LcSqbHKUkWbwiggxCx6DfZgxO2cgdt09JX3P3xfKGpXQffTBP5wq8D+PNttej46eAOXg0N19f1LdeZYNtY70DMqTByXutOkxWZhOIbgFgG1CFvrJiu1Tz3ImM1FQeOHjsbcpc3bmAPIsIjkyV+hdYWn6PkKjUojGmcashZ7AN2dWlFwSwmsfSR6SFbJpVrK3G8CeNpfHONyz4IY7H4OKGe+bUDWMX3ILv4sujfXeM+G6Mk3WM92ByPiIBGzCmHZei/OhAi35r9dgKngJuqdLkc2fjZD6vcRq5UKnvS3P5NHJPMP7Bl1iRtfdAei9xb0hKzYBiJ7XZIYaeie3KIFGui/qVZ2tO1jYKXDeDDmatbosWRmHF0D3+5PsYG5rcJUDINuXd3GKvju27HugtXSlufnYBlwIaaxoOieec01Y0AEWmDlktcwZKsYLg0kLAC0qW9of2XHLIlvMnxBhN+LA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(122000001)(186003)(4744005)(38070700005)(71200400001)(6486002)(6506007)(31686004)(83380400001)(38100700002)(2616005)(6512007)(53546011)(36756003)(26005)(508600001)(31696002)(4326008)(86362001)(8936002)(91956017)(8676002)(76116006)(66476007)(66556008)(64756008)(66946007)(66446008)(5660300002)(54906003)(316002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGdLMnEzOTRMOUZ6eEY1Zk14MlFMUDhwam5CSnIvVXlyd0RiM3k3M1I4ek9B?=
 =?utf-8?B?UXU0MnVIZUxucm5NTzlzc3pEQnBudy9LeWg3Y1gzc2Vua1c4ei9DNWl6T1JN?=
 =?utf-8?B?b3M1ck1LUVB4TlA1aDlTYUJNa2hRM254c3Q0RFY0eEpnQjFmQmxUUWh0L2hO?=
 =?utf-8?B?cUI3MlVGRm1lZEZZWE9ObDVnSkxVWERwUWIwSzJRS0ZiWUMzSDZqQW5VUWxQ?=
 =?utf-8?B?cmdRa1hLU2ZLR0g2QXpKYUlKQUs0UURRd0FocFVseHlCOGhLd2Q3VGJ6aGhM?=
 =?utf-8?B?amxscFowWWJsTmFqWDdRK2NQamdVSVJYZFpyYk9KUld4cGxKc2JWaEJ3M2JD?=
 =?utf-8?B?dXU5VnczS282bXJ3aFZvR2ozWkxnYXVSSVRIVHUvbTl3S2pVMEFRcE0yeXI3?=
 =?utf-8?B?M0QrVkc1MlVnbUVYRTVmMTFmOEpPY3M1NytHNGg1WkkreXlIM1JZN3pvYTY1?=
 =?utf-8?B?VTJPcE9MZXpOK1d4L3JBZ3pMbUJSaElJVUtaWFFMVklQTmtSamk3U0U2Qmdx?=
 =?utf-8?B?dmdCVEViK3U1OVN5bmVtRnlndWNISE9TR2tYSUt2K0hHelB5UTI0Y0o5b2c2?=
 =?utf-8?B?S3orb2Z6QkNtTlZqS3hGbm0xS0ljWUR2RU50OTdEVkkvUHAvMUltUXMrbURw?=
 =?utf-8?B?eENMM2V5VTIyb0xWN1VsZFpxMGpOdFRUNlZFQ3NhSHlJQlhPTjI1WmdWVWxD?=
 =?utf-8?B?WFJEbTBYQ0ZWSm1tYnduS1FuemQrWDlmOSs5WGZTenFiTVFxZE5sd0RuZm4z?=
 =?utf-8?B?WUdiTndZdmNpK2R1Y2FvbXZGL3FmcDNSdnlraGxTQzl4TE83YTRFMmp1V3Rw?=
 =?utf-8?B?QmN2bUpINU16T0pmWHpwZGRQdVo2eWZCRXdwYkkya3RhRmE3Q2s4Q002SmJZ?=
 =?utf-8?B?SFphdUs3NWtRU1NYWFp0enlQc2JlKzZMQVhuY3ZEM2hOLzR1TzN5a0xqdmRz?=
 =?utf-8?B?L0xnRGJCZ1BkMnJxd2tzOFdObWc5VzdZNmNSbjhPNnB3c0IvbUFYY3VGTnU4?=
 =?utf-8?B?MWtXb0hUaFZ6cFo4ZnNpenI4UkNCRHdWbkhJQ2dlUEM0WFpIY2w4TWZjaFcr?=
 =?utf-8?B?eC91cVFEczZEZll5SnZuRVArMlNRUVpXT2NBSzNPYTJxb0c3d25VLzEva2Vn?=
 =?utf-8?B?cFd6azRzZ0xzb1hsTTRYZG5OTWo4U3dYNmtoc1dJMUhCcHRpRGoyeUdzMXZG?=
 =?utf-8?B?ajl4dEtRSjIvQkJnc0NKbzJBUXNBcVJRWjhIZmJORFFvRmtsNWdiNGNFeUwr?=
 =?utf-8?B?dTdUajlIMlRsQlAyTW9UMnBCRWRiUlhUZEJiL29leVJDejlZa095a282dkpv?=
 =?utf-8?B?SGlHb0tSbCt4NE9yOXNQbnFQQnJZOTRxdDFSN0FNVmdFZkJoSFlGSjdoRmM5?=
 =?utf-8?B?NDJ1T0drNkJMemNUbk5xSXlLQmpKNll1ck5YM2ZJTUtybkk1Qnp4SlhYUmlq?=
 =?utf-8?B?R2FqMitMYkR5UjlJemsrNVl2cmJEZWdpZHJ5VVh3LzhGK3dnemYzdktBMFhz?=
 =?utf-8?B?Snc1TjlPQ01xTitPOTZXVmRSR250QVF0VCt3THUxck4yWmdmY1l0bkFKc0dm?=
 =?utf-8?B?TDZmMk5mVUtLem15Z204WkJQVEhQRXpUN0FwUHNrdWZlMVJmYjY5ZkxHcjRw?=
 =?utf-8?B?MWlyQzFqV0dWTVkxcUtKak1rTlQvMnNldFBDQkNjaHVSdDJHSElPQS9TdXJ5?=
 =?utf-8?B?U2ViMGpLTmNCcEwyWmRheWc0Qk5GVUV3NkRWdU9kaVN3MEIweTlpZkwvTnJQ?=
 =?utf-8?B?eVlONnNKYzRHNmVta29DeHVEaFl4cmpWbU9RREtKcVZneWpXVzRuSlVjRU1y?=
 =?utf-8?B?MHhTbmxvNytvK2tvZUtiYmt1M1FqNVhUVlRITWlnN0pSckxnejRZbm1FVlFj?=
 =?utf-8?B?WHB6emdRMHBkSUdGZlZyemJVOUd1dkdad0E3OFYzaW5UWG1FM2I2bmNVWVlO?=
 =?utf-8?B?dWZXTllPQUtKMXpKeUxxWFE3aEhqK1BubEVyZUdaK2JJTTdFcXo2K1hFUnhE?=
 =?utf-8?B?dElhZXdoci94QktqTm5YcVFuZDBFVnhad0pPVGZGVHJoUCt6aSszOEJvdnFP?=
 =?utf-8?B?blRidEZPVHB0bjVGeG5aTmFpaUQwQlZ6eFhqUGRzOUgwejVFdlpkMkg2S1V1?=
 =?utf-8?B?Mk9FMXRGWGk0NWpJaVAydWQyR1JPUktLVlRQT3BGdUNRY2Nlc2c2WTk3UGlJ?=
 =?utf-8?B?aG1mOTVSSFl1bStyY2lrT2MwZGRLd0dZUUVVUno2OXQ2Nm9HQXlJSVowd1lo?=
 =?utf-8?B?QVd4VEZXN2VobWQyU2JQZDRSd0JwbkZhSEJtdThTYU4zTjBDV2xVZkRmaC9s?=
 =?utf-8?B?TGtjRlI1ckUvZjNKNjY0Wi9NWk5pOE5MVk13VmVzSlJDUE5ReFp6QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <601FF3E99034F645B4E915DA4D976781@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648911bb-f3e6-486c-bb43-08da474a54b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2022 23:22:59.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +S04Wa6GKPPxrVVJiClOeYfzmY4zhwxm15yuzK0M9TINDZiT2c6iCRJ2I9w98ZsQWLIuWL1Uy5Ui2ROoEPKyHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi80LzIyIDA5OjA2LCBYaWFvIFlhbmcgd3JvdGU6DQo+IFRoZSBvdXRwdXQgb2YgX252bWVf
ZGlzY292ZXIoKSB3aWxsIGJlIGNoYW5nZWQgYWNjb3JkaW5nIHRvDQo+ICR7bnZtZV90cnR5cGV9
IGFuZCB0aGUgbnVtYmVyIG9mIE5JQ3MuIEZvciBleGFtcGxlOiBudm1lLzAzMw0KPiB3aXRoIG52
bWVfdHJ0eXBlPXRjcCBhbmQgdHdvIE5JQ3MgZ290IHRoZSBmb2xsb3dpbmcgZXJyb3I6DQo+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIFJ1bm5p
bmcgbnZtZS8wMzMNCj4gLURpc2NvdmVyeSBMb2cgTnVtYmVyIG9mIFJlY29yZHMgMSwgR2VuZXJh
dGlvbiBjb3VudGVyIFgNCj4gK0Rpc2NvdmVyeSBMb2cgTnVtYmVyIG9mIFJlY29yZHMgMiwgR2Vu
ZXJhdGlvbiBjb3VudGVyIFgNCj4gICA9PT09PURpc2NvdmVyeSBMb2cgRW50cnkgMD09PT09PQ0K
PiAtdHJ0eXBlOiAgbG9vcA0KPiArdHJ0eXBlOiAgdGNwDQo+ICtzdWJucW46ICBucW4uMjAxNC0w
OC5vcmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkNCj4gKz09PT09RGlzY292ZXJ5IExvZyBFbnRyeSAx
PT09PT09DQo+ICt0cnR5cGU6ICB0Y3ANCj4gICBzdWJucW46ICBibGt0ZXN0cy1zdWJzeXN0ZW0t
MQ0KPiAgIE5RTjpibGt0ZXN0cy1zdWJzeXN0ZW0tMSBkaXNjb25uZWN0ZWQgMSBjb250cm9sbGVy
KHMpDQo+ICAgVGVzdCBjb21wbGV0ZQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IFJlbW92ZSB2b2xhdGlsZSBvdXRwdXQgdG8gZml4IHRo
ZSBpc3N1ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRz
dS5jb20+DQo+IC0tLQ0KPiAgIHRlc3RzL252bWUvMDMzICAgICB8IDIgLS0NCj4gICB0ZXN0cy9u
dm1lLzAzMy5vdXQgfCA0IC0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0p
DQo+IA0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
