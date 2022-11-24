Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73910C4332F
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 07:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKXHvL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Nov 2022 02:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKXHvK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2022 02:51:10 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1C11FCEB
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 23:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669276270; x=1700812270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=flJgo5KAHfQT0V+fQ7BNk0yjfmwMlnOOj/A7x30Uq0k=;
  b=gzXKwR952qEB4xlJm11F7krfVHv/BRDFZ34aBkcBx348ueZ1NmnZIJf7
   U7XCBzS8WoFij93gEgqwT1RWXRp7Yo57C55K/jo1LhORnI9S4pogq4I5t
   AdlR7PEk9vmJO9HTsfa/c7TLbnfTh3feCnrh5yZByi5NbtyTM7SwPOw1b
   uBEu7DmSju07jv5KoC7Q3wZGt8WYSXF9RRO5PsfOiCJ1fzi4pq9B04NnE
   OeTb92SukKakg44yEfsJ7V1NzXK+dIsRKVJwLXybuAoxd3gfe1o95aD3Q
   jOnIkY+RpNW9Cw2ZD3TA50VBKq8r/XG9U4BJ+lZIpo5lY8oIeEehAEmft
   w==;
X-IronPort-AV: E=Sophos;i="5.96,189,1665417600"; 
   d="scan'208";a="222224496"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2022 15:51:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h31+bUkLDbQySuuLkz+UBXr5SawSNc4pB0YE/mlboHdojjUSZDjBfwVHgnSP2Ka+iVnbz2dInTsGqTobWNcMX96nL8tROo2MZcGq/s0ZXqkjLqmmdWuBE6TS6CA3gfB+d3vD0LT5WJ13L3F966d+UZ5N9Paxb1dfXKA++DcdYQiSMnNRfj7Ou7TP2G0xigQZzF6wQVy3aaMiH9VFjtAA7mzYKwKOAm2+DX9TzKOjBFdZuM5Y6iax/nwvyxMbifAeez6YjTvzh6YYg8HTUIEeOhZv8HqylZ82xG0txDVqE90/QhDxTo8m3qvvA2GuEHvguFSpO7saPWQPax5MwciRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flJgo5KAHfQT0V+fQ7BNk0yjfmwMlnOOj/A7x30Uq0k=;
 b=DGuatHoOlOQU+Xm01U8v0qt6csP5eOP1q2g/AcOabyY6NQ+QGFRUfSaDGlc2P3VPLUyaRv/WfEmeEQhdduvRgtYJ2sIvr7Scuj5mRQLnKcwITRXy3szShIKkD5OLv3e3lv2qksRH7HE5dagrhpLGFhmKGNZMN1NioVtSifzjoTSxPuKP5a2jWAeF+4MzoNYegvWNiiI491hZaD6cec6pv9rZDZvdtcrLlcExZPi56+mit4v7Og7PRLaeGBNhT5Z2t9BGLQW53f5Bw+2CeZASAhR/bFl7Gbu/oPQ7QkzO4yESLPnpgZhWJvMh1jBtk5m4OkTExFXeBDHJoW5489mMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flJgo5KAHfQT0V+fQ7BNk0yjfmwMlnOOj/A7x30Uq0k=;
 b=rlhfwkfcyx68zQYRwmAChVk0RaNUHkrYypM/NgPuahYpsf1CZOZ125C9Htx367jOPVUiSrKqU5SDjs9EhGbZUrySaRTqoBl2WoFCZ1XangNLSrXiluKnq7Zj/qB6boUDXjKrW9iDZFOt0BvTYC+xGMuIAbgDO6gt2H8HrOg2nAY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6777.namprd04.prod.outlook.com (2603:10b6:5:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 07:51:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%8]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 07:51:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 0/2] mq-deadline fixes
Thread-Topic: [PATCH 0/2] mq-deadline fixes
Thread-Index: AQHY/6ouBRK9J2oA+U2yxIxlBAC4hK5Ns68A
Date:   Thu, 24 Nov 2022 07:51:06 +0000
Message-ID: <53843682-fae1-7283-8ca2-7ff140efcf51@wdc.com>
References: <20221124021208.242541-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221124021208.242541-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6777:EE_
x-ms-office365-filtering-correlation-id: 12792797-d144-4ddc-4ae7-08dacdf0a4ba
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+6Q3pC6IuQsBn5N6LPMeS8IkGdhlzw2KifPiwAWmPKY5/CC73x4bvQ6vLi7ocCg5q4LE9Jp9DpIPS0NTHrX/jxjaUJPjY+ELGbWVPxE708gyOKNFmJDpwLakneASO3g9iQXvESPS0JtV1QnWCrcIOEdX5aeOAsCyRErvleWZALKS0i/LQFxRK8YbRnH4Zuw8z5zZ92q7q5vhbSO7O+jg5l2R1HpSjYQYaSsWwhu57678DVI+HvQd22eFD5QnDokTpD6j9jBjso0S6p3PMsj0F/cIpocJ4fwDa3IqPBLmrEOe/7BX6N67tVXwDh3U6LD1Ce1Cs0u7X95lAIQiVz+bWbnbbdTb0MJ4stHdWiqbjUcnspKsIisAgRpmf/zpQkThQTx0yDpAIhCtyQAeXsOSNI6AB3xzDqp7paYEbg5pdAtSi4+/4GzV5ckGME5q8ryjpGImuwK+WF5Iv2UylxmZAl/vMytVYEyC3uBH3r/5uCrH11CeNMpE0NrjPmDtPg0MlNZRdl4oNFCK8SoTVum/Jg/xw/HCt3Mp/AiDAF1ofdE4Gjjk1+wlUDiGR+yPcH/9IGnKpakLqlqGJd6NQ8DTwEJmNlxY1u2E9Q4BpygSZQ2pbvzwl+G1yViG7EShEOtpywqtNsHK1d4LhVuKbc9U8XT7t05Uskxa5Edx0QmizONTLlt2OY/S4zBP3a46/ZY0krxi0h4P27TPJFHmvtU0qzLyY/O0R6ByjtM4bx0cfOiXLt7K8vuJ9o1O4riC6OofWWUAcKlrJH7AnW27PlZaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199015)(31686004)(83380400001)(86362001)(31696002)(110136005)(6506007)(71200400001)(6486002)(38070700005)(36756003)(38100700002)(122000001)(82960400001)(2616005)(186003)(4744005)(5660300002)(53546011)(6512007)(478600001)(66556008)(66476007)(66446008)(64756008)(91956017)(8676002)(76116006)(66946007)(316002)(2906002)(4326008)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1IzYU12SDJLekpYT3lSN3FXR0hwZWtDUUVtVWF6MWd3d3cwcTRzb3BHMjV5?=
 =?utf-8?B?enlKWUt6OS9lK2o3NXVFM2hiNjQ0am1SSWdLMU1hT0IrN0tHMThQYWQzRXdZ?=
 =?utf-8?B?SVNxZW1XQitxR2daYi94U0tLZnozR0MzU3BSdFVyUmZjaWxtbGc1ZjFqQVNV?=
 =?utf-8?B?QWNBN0JIN2lxSG5ReTVMSTNqcEgrYzliWlByMHRyTnNLTVZqV3J6RjFiZjg5?=
 =?utf-8?B?Q3A3eDFNekdzWDJjbzR2NXhZaHlBQTVVeWRHZU9LQlRzS0x2dlIvQjlPYXF6?=
 =?utf-8?B?SjFOOS8yMGMxWXBHR2h5bDBXZDZnTTdmYzlqRFpQYnExVkdmOFM4VFVJb29l?=
 =?utf-8?B?by9oTS9obXZoSHNGNVNEbTkwOFQ3YUZ6c0hpM1NkcC9FYVYyVHhJTGhXY3cy?=
 =?utf-8?B?WjBkK2ptc0JITGszNGNuQ2tuNnBQUEpLbjVkbGxDamlseWtvV2FmbmxFU3U1?=
 =?utf-8?B?bFMrWHBRcnRUUnRud05rYnozVVhMQ1k0NmY2RklCSEdDSEh3TEZzWFFOekIr?=
 =?utf-8?B?clZ2RFk0blFiS0VNZEZodmo1bW1LRkZpMXc3dDExMFNMaExZbVJ4ZHk2dFpa?=
 =?utf-8?B?c09WSTIvSjFkd2d5QUdiNXM0dFI3MHlBQ1pEOVUxcFRlT3Y5UnBNeFBYYXBl?=
 =?utf-8?B?aWZOSnVLaEI4Q1BuRm1wa3JTN0FzUnVyQ1dqdlE0ejFmY1MvYUlqYXhxUVJT?=
 =?utf-8?B?RFYzMU1QelNzcjJ1UmJDY2JYVHhZTStJUk9hcFUxOS9RK0ZRV1F1bEpjcGZO?=
 =?utf-8?B?RWJDd0YycFZqWERCZ2NXU2ZIUXQxejBkay94NUJmSmE5WC9paFZHL0ZoMXhV?=
 =?utf-8?B?TzdhblYwS0dwT2N1NytxN1ZXVjhtb2twSmIxQzBHa1h5MzVqZFdRZ0RVdGVP?=
 =?utf-8?B?RitpcEowVFFTVTlYMis0dEMzekVsRWd6dlo3dkVMa0gybC9PMWRhN1haR3hy?=
 =?utf-8?B?RktSVW5CSHZHd091Q28zTmd4Tm10QnNYK3c3SjRUM0FzSDNBYUZMN2FOSmRV?=
 =?utf-8?B?TlhieXB6SFF5Z0luTWpyOUxzc3paYWkwU3gvazROQnE1SG9ucEMvSjY1MmRW?=
 =?utf-8?B?MlNzT09SRjF6RlZnSzJNOWRUK0Y0UTRyd0dZUTRiSXZqb0FDYitLVXhUQzdZ?=
 =?utf-8?B?ODdyektrRFJxelJqMlUxSEhpRGxzeSs3M1NkOE5BTzh2OUw0U0hPZGNUd0Za?=
 =?utf-8?B?OUJBRUFiR09rMS9yTlhWZFVRNlJwSndaVXNVVHhCRDBTNFk4c1F6UXlYdi9F?=
 =?utf-8?B?ZzJoamYyeThyYUtaYXpDdEUwNmJ5MWQ3bjVPajdFRG5ORTBPS3pyVUgxMHpR?=
 =?utf-8?B?SWRGa1BzVWc2ODVXSHg3ak55UG9MRVM0WmoyMHdWcG9sajBPTytjUjFLQWx4?=
 =?utf-8?B?eC9KU1ovamR0NWR0bnFtV09SVVFNeUxwOXIzWWsrNzRPNVdxR2RacnduN1hq?=
 =?utf-8?B?VXdoS0lkSStNYWtJL3k4WGdmclc5bmt4TE1UdFZkTWl3bzhRUzBoYVJlVWhx?=
 =?utf-8?B?Szh3d2x3VzJRQTBUa0Z5algxVGRyUktabVhKcHNSYk5DSG5HdTlxNms5ZkRv?=
 =?utf-8?B?aGkwNUZhRzVBSnJ0TWltbW5IYTNlcVIyZjR4dDVPTVBrbHRWNHg4MG1wdSts?=
 =?utf-8?B?T2NwWGd6NU5UZEJSMmpRYkI0M0pVbXBHV2R6WEFUYW5uTlJVNkdtRndWYXRW?=
 =?utf-8?B?ZGhKZ2ZvbGlyYXhLNlZOd0plNzNwQ1A5VmpDRlFScU9HM2x0QTJRaFloaHJa?=
 =?utf-8?B?OHgzZk93OUNmbWlmQnB4TkpERGRYRjBQNHJKTTVMQ0dpaVFuWWdtclkrbytS?=
 =?utf-8?B?L0c3R3dDYlhueGFwSXdEa2RmdnVYZTh6emY3WVZsUy9wOUtMZTlIM2t4N2xm?=
 =?utf-8?B?dFdjQlNxOWJhcGlUV3NwTGJua1RpdWlOTEZpLzEzMlhnR0VKTjN2d2lKVFlq?=
 =?utf-8?B?SndXTFFYWmJOTlNVOGszMmNzS0Zua2JNeFI3TGRORWxFT0xxbWtic045bmpI?=
 =?utf-8?B?Z2tVUFJwZHdSOXQrbnB1azB5UkJ4NXAwbUc2N1dKVFpNR05LRFJueTVOVlI4?=
 =?utf-8?B?Q3EzTW5OeTVuWFdqVTZVWjhNYnJ6TFMyQ01SdGJmcTJGemhHMGtrREFIN0pF?=
 =?utf-8?B?Y0tocDNHWTlHeWs4SDRlTlFKUlFPait5cUpWVEloRXN6c1Q4WUd1aVJNaVNL?=
 =?utf-8?B?ZnB2QVlZWkEvN1ZBWjUzaGZKeDJWUkU1ckpLOFhPNmxsa1l4Y0xWaFZnOWRQ?=
 =?utf-8?Q?bGTId35ZRM2YtzP5agmGZxsBeQfwcLC0CI397yUNSM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0F2C00C1A0C6E4C8620E0C61AF6A960@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Cn5dLWbGLZ29S/eDObHL96AWYHGZdhXLV3v8snZHxIohVr7iGPxtRxUyqqMFNG2pNhufkIG1U+eUCVf9SQdmJj/8Wm6+3zacrCr7iTRhlkJ0Edfffb6gCksW/ztv7zNU2heIPder3wEq7buiSeBZ4h4k962++hVg61VLrZaFoWrjga1RXd6zpk13Sst+ZO9I28zEgqNJyxDLk7RJOubtjTxY64t2Tg9sMvRySrsPLBBZs7JU9q1DoR2dl+GfV2Vou+KD1iIfQQ0hwfJ4USy90VxyO2B/gfwtil+Az0UYL8GLkJeUc05vi0i8M7+VMgHXXH14vuijUrBfPnDA/8VNGhb1OmHRv3HOMxiZlwpZe04cfks+ar+sjJNLpCTAo+vBcT8OQ6M5uW5hjrbvR/3+ABGyFdSjiXh7ov1K0jB4oXx/hnLlzornSUCFG7DdpQbDtynNeSUF1NDUzaANbW/5wXxz6ivmG5LdesY6hRO7NwZdCenrs9X1xbs8hv4jLFWF89UWo1yIn1shxbyrLBp8xI06ue7dndgjwtFMJqQSMtrmR6eTIlSWxuAsFYsROYgC74+2DVXi6zb3NNvRaQQbLaTkrOWH+k+j4p4JenEs3x2B25JYEuSkhc+HArsKPbEeX5KxV3RoPBmJPXm4Y1jTM0UFSqJzYkYbLhs/b4jFITc50NByBe8O2L7HkPXfBzIUQhG3WmTWKnoMYvlBbXjIJTDabK6W5w1j+8Uf6Kpq4w6EgCNDd/xZtghkD9dw4Tzs8AcejJgoeDQpB9TEJyzk3QA011mn6D4RUHCqyNJOmVoeKZTUsU+fR+LBWDPpUyXCW2CkmUPBkYBCSrG225Vxqw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12792797-d144-4ddc-4ae7-08dacdf0a4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 07:51:06.5551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxVSHmG1BEtKvyCJdilJ3y/Eq06zh4D9e5i1Y9bRdeduGiifYmZeLMDm1KggDaO3o8I/li3xY5AO5elBc4q1il32TxGecRw6t9DRKgzozt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6777
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMjQuMTEuMjIgMDM6MTIsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBBIGNvdXBsZSBvZiBw
YXRjaGVzIHRvIGZpeCAoMSkgYSBwb3RlbnRpYWwgcHJvYmxlbSB3aXRoIG1xLWRlYWRsaW5lIElP
DQo+IHByaW9yaXR5IGhhbmRsaW5nIGFuZCAoMikgdG8gaW1wcm92ZSB3cml0ZSBwZXJmb3JtYW5j
ZSB3aXRoIEhERHMuDQo+IFdoaWxlIHRoZSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudCBwYXRjaCBp
cyB0ZWNobmljYWxseSBub3QgYSBidWcgZml4LA0KPiB0aGUgaW1wcm92ZW1lbnQgaXMgc28gc2ln
bmlmaWNhbnQgd2l0aCBzb21lIEhERHMgdGhhdCBJIGFkZGVkIGNjLXN0YWJsZQ0KPiB0YWcgdG8g
Z2V0IHRoZSBwYXRjaCBhZGRlZCB0byBMVFMga2VybmVscy4NCj4gDQo+IERhbWllbiBMZSBNb2Fs
ICgyKToNCj4gICBibG9jazogbXEtZGVhZGxpbmU6IEZpeCBkZF9maW5pc2hfcmVxdWVzdCgpIGZv
ciB6b25lZCBkZXZpY2VzDQo+ICAgYmxvY2s6IG1xLWRlYWRsaW5lOiBEbyBub3QgYnJlYWsgc2Vx
dWVudGlhbCB3cml0ZSBzdHJlYW1zIHRvIHpvbmVkDQo+ICAgICBIRERzDQo+IA0KPiAgYmxvY2sv
bXEtZGVhZGxpbmUuYyB8IDgzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+IA0KDQpGb3IgdGhlIHNlcmllcywNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hp
cm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K
