Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C7C43334
	for <linux-block@archiver.kernel.org>; Mon,  6 Jun 2022 11:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiFFLon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jun 2022 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiFFLon (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jun 2022 07:44:43 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEEC21B12A
        for <linux-block@vger.kernel.org>; Mon,  6 Jun 2022 04:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654515881; x=1686051881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TzOuPTpQyquz4a7AyaE24NqGyIaG+CCMaQjMI7ELlBg=;
  b=Kq8AyOs7cpPsDxxEXOcccO95i5ZYy5wZxyJ6LTfPaHv7yDeUqE5hK5Ga
   3WwCelsZDwGoX5QOZWdML+mw4Q3qNdIUplJ9IpQNnn66jL6+LNPqjgTkL
   QSDhhQ3LChhBBchG1h/jQT3s5EjnlDO37i+cUr1B7Z1YjsWdSTnEW1qTQ
   ekXB/OWMULYJfDix5PnxjqqJ9UbA69yUItECrVts4BHyb/dW/3Hqd4wet
   uxtjdKUJZ4mbgKSOi5eWI5p1Yf3FLsc2FRWLq1IteuloFRKwqlCvI41p4
   qP3Oj+goTHBRQs6rZGXde1q5ve6h5RU1nFW0iWCy1RH1VJ34TPTaDoEoE
   A==;
X-IronPort-AV: E=Sophos;i="5.91,280,1647273600"; 
   d="scan'208";a="314416500"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2022 19:44:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE1lO2eGpXCE8Zar6T7U7fhd5omEw+MNpXoHFteJ9aU7+FWIrFwTnNDDUN5ssJ/XATwReUFwdUt0L12l7uBvTqoDtwMsADIHvXjU1kcZKsAH0bB3snNMNwO20hDsrZySqh6OAzYV4iTiW2xB3lS7FDzmZp3LSjq88JXTjuf8t8tXLFAioxkwV/sScbeUIi3y1ge2CV/PWnH5s4vI5iABmHV8unz1gaqMElkkO1ApCHyBU3XnrOEmwfL6hlGP/XR04dzoCGdWrgTQy6+uNt94lK4WF8ZhOSGuoLu4N2/xfz8/wL+waPOTADuM4Uc2hR/PFLEjMml4EPFCw9s7tLYG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzOuPTpQyquz4a7AyaE24NqGyIaG+CCMaQjMI7ELlBg=;
 b=O4Hw/pvIdiRr8R4Pa/Naa2K1eKh2jFUzQQXEJ/CwtF/LQRY3+gRIli9X6V9Pm5jDfcJUJriwGUJqggUc5JLYw/igR18YXf/nlKN1+qFFl4fQc4B0l9Pw+etaF5w9wMagC02qOwvvXvQjWv4oUJj6hhgZT4Yvnn0QrZk75fJ9pnEAQATdDBM0sYMUi8tfQvOv8d6QrBvpyOn6w6V4GqJjfRi6a148d16oLsWKn8wh2sZgVm7QecvlFVfQlQP9x5FsG4t0BQIZw2GluBGUKWWdBLPzeYbnjetbAxzqc7ZoSzXzwgOXpr29P5E+ZyplVXi3uOH+wWgvuCSF7TGFn5yp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzOuPTpQyquz4a7AyaE24NqGyIaG+CCMaQjMI7ELlBg=;
 b=mA5vuASNKMaePKjBtga6QTDufKDpfA5mIgCr9YwEFBUMEuuaS+DQnfDqIAoyttxcP/vCCiPYH0LFGkHwXefuF5/mgwpNVn+YOMItZ0/Wm7wT8BieWxuaH6cE8HjdDJXuXFRpVtRZhkUh1j7JY9WdnMWBmNvQOibPXRTQqEosYIE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7608.namprd04.prod.outlook.com (2603:10b6:510:53::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Mon, 6 Jun 2022 11:44:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5314.015; Mon, 6 Jun 2022
 11:44:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: allow to run most tests with built-in null_blk
Thread-Topic: allow to run most tests with built-in null_blk
Thread-Index: AQHYdwY8YSYeBkquLEe02NQOsCZv9q1CR40A
Date:   Mon, 6 Jun 2022 11:44:38 +0000
Message-ID: <20220606114438.ia2q2bnlpkmrgcqk@shindev>
References: <20220603045558.466760-1-hch@lst.de>
In-Reply-To: <20220603045558.466760-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97fe9e48-3a05-4b27-5c5a-08da47b1f005
x-ms-traffictypediagnostic: PH0PR04MB7608:EE_
x-microsoft-antispam-prvs: <PH0PR04MB76080D1D5970378AA4251305EDA29@PH0PR04MB7608.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkl2SOPjFbDP0I1msTIi9QBw6LAWbU1y6VS7tsl4cnb77z+kTCeP/utWIPfQGneP17cnAlTptfJmqKFsz6AVjtBaUkl9l7T3aPT26ZeFg3Ouds0UiXMjk/AMelhyBPJNa+7IHwTwPmSVxzPAou9nJvKmAXiZQUuxUwT9qmIqnRli56RK7HLesnK4F6TrnG/ZeiSrQ5raHOJTNjy1BtR5Eis2HIeNqo/j+8mp8IXVHRK1AM4AVqNCf06XBo47BGZ/vHGysrY8cpoQNZXeWfZK16PHBtzdtGhN54vOZcT/aZVjJNiTPVe7b5+gqjfmOTQJrnPn0xXngmIW55VKYFlxhlvbBWsMfI8TC4M3Q+OwY+oVjX1NFE+XeVlwDhLaxohKTm61D5C6uFF6h4x2htoiS+yageqpU0HXmQJFyelwPfylbGlXgf8m8WT3MNL3biAgiHGKKrRmYoq5alOR4c5dK3fRCyrO/XbBA+hfEgQHrIcH9a7hm5Nx+cUJfj4xcF8NbLBYdmyUMDjplUfle761VAZxjVJqdk6wxEKqt/EbYDtadAWZc7Q6XYYZHN/xDWyZcb6RxoFszMtKTbVVx2hxXZVGbte2ErPZvJyibDODEsBddQE8+uZqIjuVVnX6B3v/6e+5HoRXoHjLU4WmirdX6NUneXB7iKNJs9J/Cf0PkOyAyiFut66XM0d2LXfCYXbDQcaFpM80h2L19zXSGiUcvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(8936002)(4326008)(66446008)(76116006)(5660300002)(66476007)(38100700002)(91956017)(508600001)(82960400001)(6486002)(66946007)(64756008)(86362001)(44832011)(122000001)(8676002)(66556008)(33716001)(71200400001)(38070700005)(83380400001)(2906002)(6506007)(186003)(9686003)(6512007)(26005)(316002)(6916009)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW5sT1pwbXZQSjB2eWRwS2p6WVdManVNelRJV1pqZGhTUm9TbGFUdW1xamdV?=
 =?utf-8?B?WmMvTHZFa1RVYUs1OUFFWUNhcEl6TW8zd29LZEpwUURzYXpSMmtaRnFvYVlL?=
 =?utf-8?B?OUFiVWtMNXFlUTdxamF1SEZMdFhkY1E3dlYwT045VlF0YnFJckdpTjlFbEda?=
 =?utf-8?B?UTZiaThBaHNtejUxb0pnODBUMjczVzQrZTNNeVpEcEhWUDFNL0dIL3J4WTlJ?=
 =?utf-8?B?b0pldXBnN3Q4WFZ4a1NqNm9MYm1lQW5yNTFNOCt1ZnRhL0RUdm5kUkwxUGR0?=
 =?utf-8?B?bmVwZXZCVEpMdllIM093dFEvRmxydHo5aFpkMEtWVEpNTXR3VkFxMXd3Zm9Z?=
 =?utf-8?B?ZzRxVG1XUlh6SXNKc0xLUUtoRDRuSmF6WmIrcWhBZStWaDRNOEVlakptQnZV?=
 =?utf-8?B?T2EwWWpxMHdBV0YyTjVmUzh2bzBnSTg2by8wcjRiZjhmcmdlWVVGeHUwWmZZ?=
 =?utf-8?B?ZnlSMGVYM0F0THZHOHc0a2VSWWNpUGprQU1vVVhpRzBUblhtTGF5eEVZZWF5?=
 =?utf-8?B?RU1Jd1ZzZGV1ZlNHUkEvQ0hQZnBiZlJGdHp6VzN5aVR6WWlnelp5RG1QRVhw?=
 =?utf-8?B?cVU0ajVOcnBhb1NuM3VVWktPTFJBKzY3blZDekxIWDhlMk4xQmluM1NIb1hL?=
 =?utf-8?B?Q1MrTjU1NVFJaHYzSkFVQ3BUaU5MM05ER1pKL0hZNzIwZGFGc0RNYXZFQWYw?=
 =?utf-8?B?Tm94Ukl4ZlpIK0RYdUZPTEFFZCtaWG9KUWZqZXBKVk5pWW9xaVRnZkRUdmcv?=
 =?utf-8?B?Y0xqU01ESm5iaHZ5VCt1NzZlOGhLeFRGUld5cjRKTGhXN2pBTnVCNVVJNG41?=
 =?utf-8?B?Snd1UWtpUUt3UW9jTDloWVFGZ3RlM1BZL3ZjNjd5RnJ2Rm1xalZ4MnRzbm9i?=
 =?utf-8?B?THBidDVUQjZFTWRSRWhFNmVwaURvNWhtMlZ1eVBKelZGZzNRcWI1ZU9iYjhn?=
 =?utf-8?B?M1BxWWQ0SkF6YXV1elVDeWtnK3RBUXkxUURIbmlRNGdyTDZQWC9mbkp0YzhJ?=
 =?utf-8?B?cENCU00xVU8xc016Ynp5aTFDY0dOcm9yL3htekJtcTdjcG9JZmtxRHR6ay82?=
 =?utf-8?B?Z3ZNVzEzRWZYbUVoZ0xITTZvdVJId1RWWUZkL3VyWnJUeDdHYmFPanRaY0V0?=
 =?utf-8?B?bzJBTEVSZy9hYW1yRGJ2WFZhbXhiWmsxZFZpVVRDYUtUZWhnaU9PTXh6bG42?=
 =?utf-8?B?SUZUeld3ZGVkbFNpWHFjdnhvaW5XaVVYK2llNk8yZjRGRmc1cGxxN3A5TXhV?=
 =?utf-8?B?a0pyYXRpamhpalhqb1pSRjB6V29jSk5acnBNSjFVTmVEOE9ndVFwemYvemto?=
 =?utf-8?B?dHJmRGxmVEZhZnFlSk9KbjYzbzdGekxkdFE2bWtUTmJ4Z2hOWENwbzdteDlO?=
 =?utf-8?B?MTd4MGloUHpzQVc0UUsrOHRYa0xxamRzbEltN0hZaVlMVThna3lmcnVnTEV1?=
 =?utf-8?B?OUpraHBzTmVqcUJhbVFrK2pzWXRNT1FLbkxmZHRSZ3AxMlJnNkFuczRBdFR4?=
 =?utf-8?B?dkxUNHZaM2w4N1lzWlFBeUMyRG0zRDZJV1lmUHczbjRGYVc2anBkYmFLQ2dQ?=
 =?utf-8?B?TXlOY2Z0YzE0OGZsUzdJbDZhTDQyNytma0FWWFpTTURub3NKWmpXb01WcTA5?=
 =?utf-8?B?TWt5cThGK0wxWHFyUXZFZ2NQeS9UeFBKeHBuTGNURDhMeks3QkQxVFY0Zm5J?=
 =?utf-8?B?QVFEUElLcW82WVpLMlM0Rys4K1BXcXJ1K2FMQm1vN082N0Y2V0tiN1F0Wkdi?=
 =?utf-8?B?UzlsbU03UTdaZHByS2R3dnpUQ3hBTlNQbkJJUlRSNE5BRHh3UnlVREdHbW41?=
 =?utf-8?B?RnY3cmtCQ2RCaUM3T3llaFFJVlo0NmFuZDQxT082SXJmVTd0L1NyL2Z6MGhz?=
 =?utf-8?B?SGdtM205Y05CbmJjWDkwNFdweVpWWmlwN2lHRFpTSjJacDVBUUZXUEpkT3c2?=
 =?utf-8?B?eUlQbFhGUGVMTmgyelZVTDBLMVFWcVl4NzlRRnFla1M3ZGR6RjlwVnc2eElR?=
 =?utf-8?B?dWJ3aEFtQWsxREx5UkNyL01KTDcydnJEcHV1ekpZVDVUcHBFVWozZ1ZJQTFT?=
 =?utf-8?B?WDZkZ2xKYjBkT0MwWFFXUE9JM3VWRXh6WUI1N1phb1JUeWpkUFU4SlRUeUJE?=
 =?utf-8?B?YnZGdG5UTXVTMHdQTGoySEZZV1N3Zzc3a3hnZENJa0NBbCtqdXpDVkU5SUJZ?=
 =?utf-8?B?WU10T3FyQVFNWi9TQ2w5d29YTEN5bVV2N2hCcXlPa1Z2RnRvRGRQQ0t4LzF5?=
 =?utf-8?B?NWxWVHhnc1prM2tpcTVxSmEwTFoxUzR5NUUrMm5nVTFJU2tVM21tSkFJcVdI?=
 =?utf-8?B?bjRucFVhcEJLeTB4S3RpVk1nRnMzaVI3NEx0dUUxbGFNVUwrWG95c053WWE5?=
 =?utf-8?Q?u7oeLivI1uYzkUdjH2ezikkLxsUmuEsNsCL1F?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5501D0D3B681DA43BFDEFE183378DFDB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fe9e48-3a05-4b27-5c5a-08da47b1f005
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 11:44:38.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tH5fwyfU4o+gdPObuqX1zyurEgEXtDQ7F8GzE/kpnTQl2yoCz7R6n8frFntdx1xkGRhKiyH3doAhauNr/+jmnsC4YtkgoqEWd1Oso7gsJDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7608
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gSnVuIDAzLCAyMDIyIC8gMDY6NTUsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIaSBT
aGluJ2ljaGlybywNCj4gDQo+IHRoaXMgc2VyaWVzIHVwZGF0ZXMgbW9zdCB0ZXN0cyB0aGF0IHVz
ZSBudWxsX2JsayBzbyB0aGF0IHRoZXkgY2FuDQo+IHdvcmsgd2l0aCBhIGJ1aWx0LWluIG51bGxf
YmxrIGRyaXZlci4gIFRoZSBvbmNlcyB0aGF0IHJlcXVpcmUNCj4gc2hhcmVkX3RhZ3Mgb3IgZmFp
bHVyZSBpbmplY3Rpb24sIHdoaWNoIGN1cnJlbnRseSBjYW4gb25seSBiZQ0KPiBjb250cm9sbGVk
IHRocm91Z2ggbW9kdWxlIHBhcmFtZXRlcnMgc3RpbGwgcmVxdWlyZSBhIG1vZHVsZSB1bnRpbA0K
PiB0aGUga2VybmVsIGlzIHVwZGF0ZWQgKHdoaWNoIEkgcGxhbiB0byBsb29rIGludG8pLg0KDQpI
aSBDaHJpc3RvcGgsDQoNClRoYW5rcyBmb3IgdGhlIHNlcmllcy4gSSByYW4gdGVzdHMgd2l0aCB0
aGlzIHNlcmllcyBpbiBteSB0ZXN0IHN5c3RlbSBhbmQgZm91bmQNCnR3byBwcm9ibGVtcy4gIENv
dWxkIHlvdSByZXZpc2UgdGhlIHNlcmllcyB0byBhZGRyZXNzIHRoZW0/DQoNCg0KMSkgbnVsbF9i
bGsgYnVpbHQtaW46IHNvbWUgdGVzdCBjYXNlcyBmYWlsIHdpdGggbW9kcHJvYmUgbWVzc2FnZQ0K
DQpXaXRoIHRoZSBzZXJpZXMgYW5kIG51bGxfYmxrIGRyaXZlciBidWlsdC1pbiwgSSBzdGlsbCBv
YnNlcnZlIGEgbnVtYmVyIG9mIHRlc3QNCmNhc2VzIHdpdGggbnVsbF9ibGsgZmFpbC4gVGhlIGVy
cm9yIG1lc3NhZ2Ugd2FzIGZvbGxvd3M6DQoNCiAgICArbW9kcHJvYmU6IEZBVEFMOiBNb2R1bGUg
bnVsbF9ibGsgaXMgYnVpbHRpbi4NCg0KSSBmb3VuZCB0aGUgbW9kcHJvYmUgLXIgY29tbWFuZCBp
biBfZXhpdF9udWxsX2JsaygpIHJlcG9ydHMgdGhlIG1lc3NhZ2UuIFdpdGgNCnRoZSBhZGRpdGlv
bmFsIGhhbmsgYmVsb3csIHRoZSBtZXNzYWdlIGdvZXMgYXdheSBhbmQgSSBvYnNlcnZlIG1hbnkg
cGFzc2VzLg0KDQpkaWZmIC0tZ2l0IGEvY29tbW9uL251bGxfYmxrIGIvY29tbW9uL251bGxfYmxr
DQppbmRleCBjODIzMjdkLi5hNDM1MTQ3IDEwMDY0NA0KLS0tIGEvY29tbW9uL251bGxfYmxrDQor
KysgYi9jb21tb24vbnVsbF9ibGsNCkBAIC01NCw1ICs1NCw1IEBAIF9jb25maWd1cmVfbnVsbF9i
bGsoKSB7DQogX2V4aXRfbnVsbF9ibGsoKSB7DQogICAgICAgIF9yZW1vdmVfbnVsbF9ibGtfZGV2
aWNlcw0KICAgICAgICB1ZGV2YWRtIHNldHRsZQ0KLSAgICAgICBtb2Rwcm9iZSAtciBudWxsX2Js
aw0KKyAgICAgICBtb2Rwcm9iZSAtcXIgbnVsbF9ibGsNCiB9DQoNCkkgZ3Vlc3MgdGhlIGhhbmsg
d2FzIGp1c3Qgc2xpcHBlZCBvdXQgZnJvbSBvbmUgb2YgeW91ciBwYXRjaGVzLiAybmQgcGF0Y2gs
DQpwcm9iYWJseS4NCg0KDQoyKSBudWxsX2JsayBtb2R1bGU6IGJsb2NrLzAyMyBhbmQgb3RoZXIg
dGVzdCBjYXNlcyB3aXRoIENBTl9CRV9aT05FRD0xIGZhaWwNCg0KVGhlIHRlc3QgY2FzZXMgZmFp
bCB3aXRoIHRoaXMgbWVzc2FnZToNCg0KbWtkaXI6IGNhbm5vdCBjcmVhdGUgZGlyZWN0b3J5IOKA
mC9zeXMva2VybmVsL2NvbmZpZy9udWxsYi9udWxsYjHigJk6IE5vIHN1Y2ggZmlsZSBvciBkaXJl
Y3RvcnkNCg0KSWYgbnVsbF9ibGsgaXMgYSBtb2R1bGUsIF9jb25maWd1cmVfbnVsbF9ibGsgYXNz
dW1lcyB0aGF0IHRoZSBtb2R1bGUgaXMgYWxyZWFkeQ0KbG9hZGVkLiBUaGlzIGlzIHRydWUgZm9y
IG1vc3Qgb2YgdGhlIHRlc3QgY2FzZXMgc2luY2UgX2hhdmVfbnVsbF9ibGsgY2FsbGVkIGluDQpy
ZXF1aXJlcygpIGxvYWRzIHRoZSBtb2R1bGUuIEJ1dCBpdCBpcyBub3QgdHJ1ZSBmb3IgYmxvY2sv
MDIzIHNpbmNlIHRoaXMgdGVzdA0KY2FzZSByZXBlYXRzIF9jb25maWd1cmVfbnVsbF9ibGsgYW5k
IF9leGl0X251bGxfYmxrIGluIGEgbG9vcC4gQXQgdGhlIDJuZCBhbmQNCmxhdGVyIHJlcGV0aXRp
b24gb2YgdGhlIGxvb3AsIF9leGl0X251bGxfYmxrIHVubG9hZGVkIG51bGxfYmxrIG1vZHVsZSBh
bmQgdGhlDQphc3N1bXB0aW9uIGlzIGJyb2tlbi4gSGVuY2UgdGhlIGVycm9yLg0KDQpBbHNvLCB3
aGVuIFJVTl9aT05FRF9URVNUUz0xIGlzIHNldCBpbiBjb25maWcsIHRlc3QgY2FzZXMgd2l0aCBD
QU5fQkVfWk9ORUQ9MSwNCihibG9jay97MDA2LDAxNiwwMTcsMDIwLDAyMSwwMjN9KSwgcmVwZWF0
cyB0aGUgdGVzdCBjYXNlIHR3aWNlLCBvbmNlIGZvciByZWd1bGFyDQpudWxsX2JsayBhbmQgMm5k
IGZvciB6b25lZCBudWxsX2Jsay4gVGhlIDJuZCBydW4gd2l0aCB6b25lZF9udWxsX2JsayBmYWls
cyB3aXRoDQp0aGUgc3ltcHRvbSBhYm92ZS4NCg0KSSBzdWdnZXN0IHRvIGFkZCBvbmUgbW9yZSBj
b21taXQgYXMgZm9sbG93cy4gSXQgbWFrZXMgX2NvbmZpZ3VyZV9udWxsX2JsayBjaGVjaw0KdGhh
dCBudWxsX2JsayBtb2R1bGUgaXMgbG9hZGVkLiBJZiBub3QsIGxvYWRlcyB0aGUgbW9kdWxlLg0K
DQpkaWZmIC0tZ2l0IGEvY29tbW9uL251bGxfYmxrIGIvY29tbW9uL251bGxfYmxrDQppbmRleCBh
NDM1MTQ3Li42YmUxMDgxIDEwMDY0NA0KLS0tIGEvY29tbW9uL251bGxfYmxrDQorKysgYi9jb21t
b24vbnVsbF9ibGsNCkBAIC0zNiw2ICszNiw4IEBAIF9pbml0X251bGxfYmxrKCkgew0KIF9jb25m
aWd1cmVfbnVsbF9ibGsoKSB7DQogICAgICAgIGxvY2FsIG51bGxiPS9zeXMva2VybmVsL2NvbmZp
Zy9udWxsYi8kMSBwYXJhbSB2YWwNCg0KKyAgICAgICBbWyAhIC1kIC9zeXMvbW9kdWxlL251bGxf
YmxrIF1dICYmIG1vZHByb2JlIC1xIG51bGxfYmxrDQorDQogICAgICAgIHNoaWZ0DQogICAgICAg
IG1rZGlyICIkbnVsbGIiIHx8IHJldHVybiAkPw0KDQoNCk9uIHRvcCBvZiB0aGUgdHdvIHByb2Js
ZW1zIGFib3ZlLCBJIG1hZGUgY29tbWVudHMgb24gdGhlIGxhc3QgcGF0Y2guIE90aGVyIHRoYW4N
CnRoYXQsIHRoZSBzZXJpZXMgbG9va3MgZ29vZCB0byBtZS4gVGhhbmtzIQ0KDQotLSANClNoaW4n
aWNoaXJvIEthd2FzYWtp
