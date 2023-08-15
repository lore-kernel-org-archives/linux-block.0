Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA3C001E0
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 10:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbjHOKAm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Aug 2023 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbjHOKAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 06:00:15 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B641B6
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 03:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692093613; x=1723629613;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=Q6zpBDoNMTvrLcuykkE1y0qAYP3HaCR7Uoa3mCNBBzhZrH/1t5+fz/84
   HzhZb47SUzWJkTI5Ca2ka+oGM5v3SUPc8T2DQy7226h6xpOEXNao1h8HR
   yJ4P+gpPp7foFXfgeDS+YXXfF+7ygwjcZ2zQXMCF9KGOYyIUDR6h4NEJN
   exwVFy10EGmMF7c8deUD3pIQFi2RjzbEhFLD8h88g/tqK8vbE/FrV/Uis
   Ablos7nfZisV743Rg1BS6yMPoba4sFy6Yiq0pO9KEKLyLZcs/5GkmQk4E
   hqtUeq+KKOh25zQJnKLE2KJ/Ktu0Ggr5G4BsOIKihBg1F4twIeDYyCIgv
   g==;
X-IronPort-AV: E=Sophos;i="6.01,174,1684771200"; 
   d="scan'208";a="346340038"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2023 18:00:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+ZZgoNDVzdXv6ToQpPd9DSHPfst/HJ/wnwriF3KKHvHBKp0Kt/1nCj+MizMI41CFp2ESs6zqAEI+TK718ugB+WctBQAZOkoWNCd44MTmCviRRKM/TqenkMlyZK0K0yK1ichcx1mypsmOCbX4mUKAwb9bJbvAVgRD0c+xXse79L+2/+T8Dy1VD0xmXOOm33Rm6HqvHAfWIR4tR50ka3flgMBGUZm0Mp9f2zft7DvZPEAKZwlzkzoQ4OIIktm6K/1i80LgthFHnfBE7B8KXZDMJAdqN5DgtTzXRMyOoTuruSHH+j/t2JS/3wOyTmda3kYg4Opl2rKDwJt3UYKhWt+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=IB8Ff+uwbuiVlNL2xXWg0w31dA06Q4Kcv42Fs7K6cmhDoPMWDdNeysLjClroSRHKsDQoQncy1P4yE6Y4cL5sI9h8IxiEpytg/zegwvKMv1iNb5BdpV5pXepkbQnX0A9zCqRSNzxQYMBZbYcdY6tr9Eq+6gA0it3JWIrQu6XOS1sXucuuurJu2XWjgjssKIim9STEJEVqB00lBYG7XYlMM+xg1qlIlhRlv6qvob4099SqXgaKF7h0UzNzl8chQtPBrbIAM8lnObkKsikQWscR2duHgN+XlDy507dZYGd7/hXpaxaDT5mAOCFOkmG53GtRT4t91ZBEGFYTwOReTQbj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=vueSO8g37jfAyaCrqaDdOrnechmn1amm8MkjeFlXLroNl2anuBH0Sc086ZVYyT3BOhqaqVI9Qw2tfifLzbPkU+2O9hyAugk8y0q7zhGiLHFYt30lFtHtrZkkVVUWnFMyUywskmquE7sPBTNjGzHTGLbknJcOuVK7KoZ5s0F+tZg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6848.namprd04.prod.outlook.com (2603:10b6:208:1e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:00:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 10:00:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/5] block: use PAGE_SECTORS_SHIFT to set limits
Thread-Topic: [PATCH 1/5] block: use PAGE_SECTORS_SHIFT to set limits
Thread-Index: AQHZyiHP4axzZfisfUOpDLQmhW6MaK/rKkcA
Date:   Tue, 15 Aug 2023 10:00:09 +0000
Message-ID: <78d6ed0d-a1f4-4493-a7c6-e2a7c7118066@wdc.com>
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-2-dlemoal@kernel.org>
In-Reply-To: <20230808135702.628588-2-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6848:EE_
x-ms-office365-filtering-correlation-id: 021d5b09-62e0-4fe5-681b-08db9d7668dc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XgQeKyAqUEELQHAqQdszrihJK8L8mXb/UzTzRxLryn+6BgSi2KplydQNaqywaaq90MySFyauHMaL1PRX/bpdjjIxZh11PQUiVyQrhDITVDNcZOMMkHjQyieRNGhG9Rgqz6BkhgmUCUizCj/ltA6PZw3ljjGF4Yef6cOUmZCZ0JC1x4uFFnvMNCZx6q+qczNDEjA/KdMP4240y6A1sHRySPpk8Uzk1psWNpvK4ylLOBRh1IepB44iK0fijuxppY3aAKUNfMzByIaP1hQMqCP0V5B4wcnTUW42XmFbGFJunf2Dd0kfdO/nNkPX4EtWuUTqU+ib0nVMPB29qB47Ce8EoceGHwZOOxAzqu4dHcghnOnsY5NUAJIpHXUfy69mWttGNM2hUXOZuY/xaXBoz7K6G5n6Yco4W0cDhpR44kJhew6kMunL3U26i47ovLHDBjDo9bPOvEvD/LvZbQV4bq5s6YXPXUkqn1MoKdbx/0MmoK6yJnOraZzbC2wuDKIgGIEJlZ2GxuNNM/mstxqCbijIscQt0Lgkw2Fp5O4fMinxR5W7cLYtX9/B9cyNG0CMaPB0AFaqarKt2WoNYeoE1uWxvUS5eNVC2asHM/2tfpydgarZapTokk3nHREFIrmU8qbQrsnmlOrybbaZPdPXUToLdwvVrcYtHhYxeTa3mnvbf0BloHFS6LLbUa5DetY1ZIxX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(136003)(346002)(186006)(1800799006)(451199021)(19618925003)(2906002)(316002)(66946007)(76116006)(64756008)(66446008)(66556008)(66476007)(41300700001)(6486002)(71200400001)(6506007)(478600001)(4270600006)(91956017)(110136005)(6512007)(2616005)(86362001)(31696002)(5660300002)(36756003)(558084003)(8936002)(8676002)(82960400001)(38100700002)(38070700005)(122000001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVl4Q2xqSTdWM3lESTBydUsybEZJWSsrTGpHVHZ4L21YRXg0c3YyaUNqV1Jp?=
 =?utf-8?B?UGRkdmJqQUZKNEJIVlVRN2RhTzFkR1dML3E0YWVYUzYzWVVZb1pydlVSTVpm?=
 =?utf-8?B?c2loS1hKeitzR3R0bHF3a2UxVkpNTWgvMXNGWWh1M2FMVGdJNHV1T3lDaUtE?=
 =?utf-8?B?Y1JBdWI5RVV6UDd2dnZwSXV2WHE5dVd3WFkwSkxyU3EySzhPcVZ3aUZ3dXli?=
 =?utf-8?B?L0RWWWpzU3V2Q1lqZnRsbE44Qm5tNjFMK0V4U1pXbjNBQ3RYNDF0VksrYjMz?=
 =?utf-8?B?ZG1sVVZFbEFHRVJPUldab1dOM3ZmcmtMdjYwWXJlL3pJMUVMaS9OVUlFcjhP?=
 =?utf-8?B?VjlDem1IbE5zaWFPSTFnV1BLZFZVNVVpUXRiS0lRTlJESmtqbEhKNXpsZWox?=
 =?utf-8?B?YjNpVTZuTnBIaThveU1aU291U2xuQXhSRGFwS2RmNWJPMUszNzJWT1pFTUdp?=
 =?utf-8?B?eUZBa0g2bncrUDM4eGhrYitZMUM1dW9OU3dKOStnejdmL0p4UVBUdkpEdFlV?=
 =?utf-8?B?VDN6NncxRnYzckdqK2VsSlNzaFl2aURUMS93VjlaamdldDNrTkNoT3QwYXFx?=
 =?utf-8?B?Y2kyc2ZxbjBWYkVMNUFIcW14VmFCTW02Q0NNU25GTk8zT01jSDN3ZnliYWdE?=
 =?utf-8?B?YTFNN1hXOUhkTnpBbTJvUERSZW5KaUNtUGM5R1BTOFV2YXg1Si94M0R4OTF4?=
 =?utf-8?B?UTdPSTBUUE1HVFZJRVl5WGZGdlFnMGFuc2c1dVJmNlhUcXljYkVRZGhlQXBB?=
 =?utf-8?B?di9OVUhvM3R6TS96RDhIRDdoTkRJOGdGdFFJMXg5VjBDREJvME4vYjhEUkVX?=
 =?utf-8?B?RDZ2MzBucWRlVXNvYnRhZEkxNHJUdXljSVcxcmxTT3JSWkdWOWhTRkpwaE5s?=
 =?utf-8?B?YXNJL04vaHAvL3B3NGtXemVXeG5MVnZUb0JacjRsZWMraFI1RDAvNXM5Q3FI?=
 =?utf-8?B?cDV1aVpxSDNIMGdmYWVUdXJabnYzVW9qc01ZM2pKSkptR0hXMXlHRFQ0Unpl?=
 =?utf-8?B?RlVUSWRDdll3RXRuN1RPekRTVm41dGdEOHZpZHFTSldGcGhYclRQQVBCMks0?=
 =?utf-8?B?NzF3QzF5VXQyelV6dUF4RmxOOWpxOWdLalViMFJYRTZFdFlvckFQZnFZcC9z?=
 =?utf-8?B?L0VNeXd6NzZzcU9xeTRCc3dMdkZ2SUM2VWdUUWx5SWNoK0hmUDJUdUMwSEFU?=
 =?utf-8?B?WUJsakpQTlJBaTlUekJMc1o5aDk1c3RPcGYwK1I5NjVPeWcwcmxnakg0U29S?=
 =?utf-8?B?aDZpeWZibXJsenU0ZjJ3djlzT1pHcytCLzNBMTdqTTRTUzdFbUJob3ozaFFO?=
 =?utf-8?B?d21yNEVjTHR2ekpUNi9iM0lEL2xDdTgyZnY4NDhBaGlrMGRYUWRwdldKa3Vv?=
 =?utf-8?B?cVBqMmUycDRyN1o5M2tsMHFVUU9QbWZoT3YreFBrSVlyamh3N3FMQzdBdE9t?=
 =?utf-8?B?cExWSUc3MDB1YWJsdVl1OTNXYXNjREdiYkg1OTlBL28xV2Z6cTBqU21hTWlz?=
 =?utf-8?B?alhRalVsNVdVNjl3UGVJN3FkbnRKcW91aENma212bERIWlpZajQ0ZG9HQnJx?=
 =?utf-8?B?QjErY05HbkprOGp2Ym9lSWRmQVVqTXdxbVM2N2pHVFBjc2s0YTFzK25HUkNR?=
 =?utf-8?B?Y05YWjJhV2IyTlZCaXpldnpLbXVJTkZuTnAxeTc2dzhGNEZGU0J2bktUQ1lD?=
 =?utf-8?B?dGlIUTBmWEVQZmJGSEJWVStJazlVNHlIbm4wOVhzVzY5cmxLM3habmxSaTBs?=
 =?utf-8?B?eFE1eFVpTURnWkk2dFNJS2gyRTlwQzZUWnRwbzFjSC9waytQVGxDZkZuK24y?=
 =?utf-8?B?cks5Rm92QTlzMFVZbHFySGh4SnJ2eXM2WkEwWnNJYlB3QlRFVzBtV1N3Zkgz?=
 =?utf-8?B?dmpoaktpMndRQTE2UVF3SU9UKzhrQXljaDRIRzJuVFJvaUFObm93bDBSdmFr?=
 =?utf-8?B?cjgrWVdKY1poSWJTNUxoR1JTL2hjWGswVncySnlsK0ZhRG82OTU0UjdjWmtv?=
 =?utf-8?B?VmpFU1h4MTN4b2gzZnFRNldyK3BZdFF6UXBiMnVCZ1oxQStsc0tuUVdsQVJM?=
 =?utf-8?B?K0JwNmRzTzQwd1Y4N09JRWZKR2NDcHRFRTBVRGxGYWo2M3JRa3NNWUIzNUZB?=
 =?utf-8?B?UWJNZ1JKMThxTFNWZHJ4RncxUkp0Ty9xeHFjaG5MZjhxMG5uYTVZdzZBL1Fq?=
 =?utf-8?B?Qno1QW54VXZITWdIdUdYVmJ4bGFROHhYTGVZWEdpcUNXTWRPYllXcEVEVmVP?=
 =?utf-8?B?RlhkdmJaSk1NYjJwK0JTZWN5RFNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EA3A4EDD53C8B4EA2A966F145DF688E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jLwtjgO6wYxHKTHA4vU/70mUUQA8XeojlZjn04ng39pAanVnGgYOe88xE1cB+enJBjyBoxg4ii/7IRwqYAjuCeYM5c8/ae0t+ibBdCM1zNF6eBjaqfr0F/s6D1k/DnZ5l9g1xx47POrYOjlDxzQ9eS8b76+xI4q/Tz5JOD+jb3nUGq1+Oy9l3kYa5dggbfuwFpa1loWabAWu8oBj3gdR+Xur37xC921eIcQjrxpxz9kAnOS+kHY/wH8yR9LRJ2YNdI3l6v1S8q62knspLwz+QRVRdpJXtrGrMYD0o83zpk3PWfBwNDFBY+FTR+SbLKlVVhmeseDDj22gkYO21BpfvJRPFkg1pgMNgVk/zSVvUxGqAp5uPkaMbys5zRACQ9lUxhNHFJKhQjCrEG2e02bqe2DNt+WgL5TQdUBGnafNv/DBt1hv8x9CEozgjuhrZan6WzuBE2378VN4OXDDxdjfNQuweYXNcapOF2BRjPaXlxdGVmUCZefzQwICASPHbL2DGhQ2eg9dyZEysiFa45677jR13HybrskwePU2FKdEe3qZ+QioyAANu5iSeA7fHmL5oimb2E3o6hj1IaZwTlOVKxG6JK55HLr1d/6IL3lYgyoD77A+we/dbwVhG04qNGkzzDqJHbSQTxbRu4UJpAYsC57f3VVedqIFp2e9aROrnveE9e6xw3A/zJiei39+sXYZwTuZaBKD03y6gB8KwQx5IA0YCkqXC/FgF0rt3OJ3a3R6EYCKdrLx8L7pwuA7auxo5ZjdmhuZ768Dr7zioQYdVBgKIR4azsfS+2/YkkfYnc0WefdODbg46uEdv5xwuzqntNAjPFPWskVhC5vRP2Gv5w==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021d5b09-62e0-4fe5-681b-08db9d7668dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 10:00:09.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdDgGCkwcWGvudLdZ8c2npPU7Uq0E1VpxtI2IMBHprAEk341XGJpEFjaGCEj0l5hd++jpG+yCp36r3iEu3TeEq7HhGTm0GblInk27xC+PTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6848
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
