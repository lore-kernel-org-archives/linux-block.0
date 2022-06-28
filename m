Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E59CC43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 00:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiF1Ag0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiF1AgZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 20:36:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94AE17597
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 17:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIvhc2sbub+ZVOU9cjKOPkE6tedKnaI5UFgCetNeUPqk9ot7EnM9WiDYAWuePY46vMntZFsKBrpJoofwIfRqnEeMKrMM/oG9ZCIE3DthSoEqVjymMn1ObaIzdUvYpe7qOHVP3QBkz5dipxaJLgucXDYoXcuU3iD3Y4RBz8UTohiz5w3I5cdx+WT2Kf5PO8VPFnicGdi8XoMB/YO5TaAxlx5fEtq0FK4n4+/IXOVTnvPzL9zy8lgMj3RGeZQkQR9EY83WWD3Whins1Z9Vz0Bzpd+pS61yzeJ+Pwasn0e4v1Ur9xx6W1GhT3xOqE9iyELAV1THTcvF4CvNFWkXqQt8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQYuWi8nr2BlxNnYNPSb1TlRtNI3oaQY7xHuiBTHP98=;
 b=juK7TumU/XGHFXrezqOlI35/XmdXUXnZGj/qbp+Juu/ktu9OF47YJNGDA2Et+Fuw44UgkintlHsHuQT9lLS0sULd2cEDC17E0gp+AMQPpPQFzlWaBy1+OGQ6DqOP3iXtbM3LKYYfbJeAMFbRlQ6LcDGJfWEdVzf+DwQKz9vUXeEbcEZxPHhN1p4y/CIFhDDX3AB5smeTyQx1XyTpRReeWmmj4MxQGdCOa/TENmWmNEl29QyAgY5TyS+PKyQIaaNkyqK2Guz2QtcK3IJpTDeH+Jr8O6eBbUGPbwMnsUItha/m1QWTaE4162b4GjnfxcXvyRG2P/El6JhrzdQgs/WyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQYuWi8nr2BlxNnYNPSb1TlRtNI3oaQY7xHuiBTHP98=;
 b=rOYpLJ4oU9uK+VblmeKPqKX5MQ6nJl/xkjI/OJVA9IUCTWvERokesR3np2eM+km5brLTQKV65XMAA5IoTSQm+VTcAk4Mds2eRjPisrbLB1iRTFduVcMj/sjaLFte9epK1K+QF1WwngiIH9ESSnaVWhCNTVMfWOixLiVIlNdPINqWiabiqZJlBSqIBgbudb0YAQPRAWqwrYk2Qgj36SecZicLyc8eRxL6xPFQFeUPA/h/kZrh9gR0kAW75E4gVJvN/tI5PugBLzc2oLRiitH1rXFQPy+wScIuA7DrXmDkCl0xnxJaHNNE9K/edUSYvnqiESlsqnJ3rOq+CyngoJ1maA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 00:36:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 00:36:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v3 3/8] block: Introduce a request queue flag for
 pipelining zoned writes
Thread-Topic: [PATCH v3 3/8] block: Introduce a request queue flag for
 pipelining zoned writes
Thread-Index: AQHYioTwxYccDjWss0WZuFJz904tBa1j+SOA
Date:   Tue, 28 Jun 2022 00:36:21 +0000
Message-ID: <a7f3169c-2e67-7d7f-e9d4-09a5a38a7e1b@nvidia.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-4-bvanassche@acm.org>
In-Reply-To: <20220627234335.1714393-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c09c7a1c-0c86-41d5-9a6d-08da589e398b
x-ms-traffictypediagnostic: BL0PR12MB4931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GFrq6aTgc+jB7/DzjvgpUr6DaYFjjH+WpnQLFvYRI5MPqxO2X1+IJbHIRyzjkVM0XBrw7hfB6O42tHEcT8j04Zz/KGfRyb5/eZiX/AQeRbmfCpVV3uuau1NK9tOh9TGzFKd4Z+Lq1edQI0WyGyoLwlN0R1PTE40rydz66R571bOFBFrAgXgetUrKrCsTKcguL8Daaqqix++gNenmBu9nW0fFfCbFi7A2bxJGquXjSzDbcObTkTZBmkD/Iv6y3YOaP3/xFw3Tk+kR30S08QFV/2LvHxuoqdf7+L2eBiMTZkpnXWeNNvbBN/7AOoZ4PeezkwqJJk+rmNNfvfKveAIjBQvidwRHHpUW0fAo1wJu1LR0onqs13LE2MsAWJEnli3vTe7laHa9se8CH4tAM72u2+ZA+40uhav0gArCuUnKsmWwYppJT0em7oNsZ6KQkxhYB1eI8nUFA0Z7QsET5GQGSSDX33TZ641ejprybFN4tAw0OW+pW4aRzlvHG/9jLqz4hjKwdJtfrKQpUWgYoYn/5qkhwKEawBCo9WB2EUG0dcI7vOKOP5SRSYi2sG12ykP6EXDmXjRWhXBLipKgghmcdEL7+nI8IGjdDuIYOR8jUpNbFujDTKiyJY5/pYVbVGe8FsXjkwbjUe1wfU4Bk86/WxXdzfkPNNqksJUQEgWWnXtBnwnrCozW9tg/kMDOFmHNsagCthG6aNfXDmjHGnI0f5yTSUAkqEdqxKB8b6MDWqLuZDvlyWN6/K71wPGZ8AQ76ytgqaa6seqyjRUAan54UBmGjdU+YxiVfp0fUBdUdXncug/uKL78YfxLu22NO5dy8DBSaFJPBaSTZrAYjDmkx112QiaZntCz7vTDY8kqsvs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(66476007)(316002)(2906002)(66446008)(66946007)(66556008)(91956017)(64756008)(122000001)(8936002)(31686004)(4744005)(76116006)(38100700002)(38070700005)(4326008)(31696002)(8676002)(5660300002)(6512007)(36756003)(86362001)(71200400001)(83380400001)(186003)(6506007)(478600001)(6486002)(41300700001)(2616005)(54906003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aENtNzBTdU5HVFowY0ZIcVRSODFxRlhxc1pIcTI3Z0dNa1Q3VDNvZ2lzZjJD?=
 =?utf-8?B?NnRVSlQySDl0bGFtQVYrcmRZWHFlY2NzcDUxMDUxNVRuQmZBR3RFQ0d1L1dn?=
 =?utf-8?B?Y3VmSEd5MEp0bDQwOE5VaDZBcStCRkRQdEF4d3F5L1dIdk1nWFpLTGNlQU95?=
 =?utf-8?B?RGc1Q1dsWWVYZVRvV2lSbnp1cmxkL3BGcm15RURXWGZpNkYrQUlWcmprbTZt?=
 =?utf-8?B?OVdSbW8vTXBEUXlyYlZmdTl0MW1pVk5vS2hrd3R5V2pXbGNXVHNxYkNLRk9u?=
 =?utf-8?B?QVd0Qm1HZVdBclozWVJ6dWhUdmsweEM1ZE9ic1BxNGVFeXE4Rk4xU1RiSVBW?=
 =?utf-8?B?U1F6TkY3bXZ5OU01YXJjcWxnOFRBbkRwZGw4WEhIRkF5SmdJUThVTUUrem9z?=
 =?utf-8?B?VFppaUxwVVF2K0llYVdyL01PYVVuWnVjOHpTVW4weUtkUUNnYmpVdm9WSVB1?=
 =?utf-8?B?YXRsSG1WZEJUUnRvTThISFNsTTJsK3BTVWZpdGlDOVFDVUc5TjBnOHhRMkd5?=
 =?utf-8?B?bGZVWTNidk9mZDlEUUtTUncyaWUxQmhzdURmREtPazhhS2Fiek1YNTE0TXlP?=
 =?utf-8?B?c0Y5bklzMzlNWmRuNEpPRGhQZE91UmtUaHNhb3padkF4WEVhUEw1OHBiRys2?=
 =?utf-8?B?WE1RblFkN2cycG1wbTkwZkhPaDdJNjN6YWF3QnNTYm4yUlBDNTNIVXdhS3Fa?=
 =?utf-8?B?aDk3V095L05UUmxCRkwyQ3VvdWJ4RUpSN2t2YmVPV3dLNmJtUUdOdW5SY1Rh?=
 =?utf-8?B?aWxqQzEwV0Q5cWZNMG5aTllublk3d1J5eUh0TW1BM1lxSVVIUTQrbDBnY1BM?=
 =?utf-8?B?dUFETWNDSlExckQ1akVUdnNDMFk2MWhjVkd6ZjdyZVhMTHd1eXQ5RStReG5U?=
 =?utf-8?B?OGZpcE9mTW1TaVppOEJ4eDVsWlhSUGMzWitCM0dGZmNENEZEMGVmT2MvUXU0?=
 =?utf-8?B?eDg0dW1Id3dhZlQ4NGhwS0RIZkFaTGt3NGZxTmU0bTVZZm1zRU83YXZ3VGVx?=
 =?utf-8?B?UE0yZk5ST0JOMHZ0N2Y4dnljVGxOVTZmVmdlOVJWakRpYTdHamtqR0JqWGpk?=
 =?utf-8?B?cWZSclhuN3hhUGgyVW1EVk5HUGppRlV4N3hKRTVaRFlYQThFT1hqK296VmlV?=
 =?utf-8?B?U3l2TmlEVnFKWFovRWs2cTc5SWJ2OFpYSVYwdG93L0JURjRCa0wrTEo5ckxy?=
 =?utf-8?B?WXV5MG1LK0ZEbzU3NytvQldVS2FmaGhQVnBEQXJaTTN3S2J4S2FUU3V5RnAv?=
 =?utf-8?B?OW9pWXRxTWk5SDlLcTJLT0E0aGVSM3hMWEdiczl4WE9hblplNkJMdE8zaFZY?=
 =?utf-8?B?YTNKVms2WllZWWxXS2lGNFlSTGI2VVBPMS84eDg5eGdYaTBwNk5UUC9zRGxD?=
 =?utf-8?B?Q1h4M0VXaXYvekNHdXFnQW5KcFJLUzdDQnZLOGppOHh0bkI1VFNCbkpaOFVx?=
 =?utf-8?B?VFYwU1lwMW5Zb2FJcmJqVlJoajNyakdheHVQSnV3L2FFanFjTitoVE9aUHg1?=
 =?utf-8?B?K0lDdFpWT2Z6VlVlNWhOajFTVDR0WmVMTVptWG4rSU5sYWZncW1aNmVGcEFn?=
 =?utf-8?B?Y2k0dVorQVFJMjM0eHJoSitMUWxCQVhUNXBJbU1nRU0yS0RxdkhLWUhzU1Rx?=
 =?utf-8?B?ZHl2TGRHeFRKbWQxUHpBWDU1RUx2Z1JNWmYxT2wvMU1Eb09pZ0dNRlNaa1Vu?=
 =?utf-8?B?R21vVERNaWJrR1p3UzhLSWM3aFpMRDBVenJ2aXNNNGVNRXNtbmp5bFN2dE80?=
 =?utf-8?B?RW1jRkszS0tUUWNvelNhclgyNVA0S1RtbmRuTXI1SzNjTzJMYVhRbS94ZFZp?=
 =?utf-8?B?ekhyb0UwRzFlSzJtWTVHTWRaRHVHSVNyS2dHODVnU0I3Mnp1WDZBV0thNGNF?=
 =?utf-8?B?WVBMbUJPUS9CWTRMSXREVGFBblZhQ3dubmNYaGZNbjdnL2lyR1NpTWtBZzRt?=
 =?utf-8?B?aks3Z1BOWTFXUFcwZWZKUndBT1c5d04vSmh4S20wOFFqbEFtOHM3K2N5VUV0?=
 =?utf-8?B?YnVBbEhTbC9SRGNEM1k5a042U2kySlBKQTdGSEowRGNBMmx3bHNNYTYrM1Ba?=
 =?utf-8?B?S01PNWJ2NUp0bUcwNG9iSGFmTERmbEFVMFlxQkVGTWRmOHhERzYxcVlCODNM?=
 =?utf-8?B?dUdIbHdRVlhBSDdOejFaNjRZZG5PSkxZVUVRenJTTWNPTXVONTUvcHYwWmpl?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F2052EBBC2126469C46C01A6D0E7E9C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09c7a1c-0c86-41d5-9a6d-08da589e398b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 00:36:21.9561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFrwlt5IIF80bqNZK5sgLsrAmqEMtJszMimeaAK/8DSP8rA+/db2gZHVHcIiEPc75SRMJUkYN16vsTFbxq1uXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+ICAgI2RlZmluZSBRVUVVRV9GTEFHX1NRX1NDSEVEICAgICAzMAkvKiBzaW5nbGUgcXVldWUg
c3R5bGUgaW8gZGlzcGF0Y2ggKi8NCj4gKy8qIFdyaXRlcyBmb3Igc2VxdWVudGlhbCB3cml0ZSBy
ZXF1aXJlZCB6b25lcyBtYXkgYmUgcGlwZWxpbmVkLiAqLw0KPiArI2RlZmluZSBRVUVVRV9GTEFH
X1BJUEVMSU5FX1pPTkVEX1dSSVRFUyAzMQ0KPiAgIA0KPiAgICNkZWZpbmUgUVVFVUVfRkxBR19N
UV9ERUZBVUxUCSgoMSA8PCBRVUVVRV9GTEFHX0lPX1NUQVQpIHwJCVwNCj4gICAJCQkJICgxIDw8
IFFVRVVFX0ZMQUdfU0FNRV9DT01QKSB8CQlcDQo+IEBAIC02MjMsNiArNjI1LDExIEBAIGJvb2wg
YmxrX3F1ZXVlX2ZsYWdfdGVzdF9hbmRfc2V0KHVuc2lnbmVkIGludCBmbGFnLCBzdHJ1Y3QgcmVx
dWVzdF9xdWV1ZSAqcSk7DQo+ICAgI2RlZmluZSBibGtfcXVldWVfbm93YWl0KHEpCXRlc3RfYml0
KFFVRVVFX0ZMQUdfTk9XQUlULCAmKHEpLT5xdWV1ZV9mbGFncykNCj4gICAjZGVmaW5lIGJsa19x
dWV1ZV9zcV9zY2hlZChxKQl0ZXN0X2JpdChRVUVVRV9GTEFHX1NRX1NDSEVELCAmKHEpLT5xdWV1
ZV9mbGFncykNCj4gICANCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBibGtfcXVldWVfcGlwZWxpbmVf
em9uZWRfd3JpdGVzKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQ0KPiArew0KPiArCXJldHVybiB0
ZXN0X2JpdChRVUVVRV9GTEFHX1BJUEVMSU5FX1pPTkVEX1dSSVRFUywgJihxKS0+cXVldWVfZmxh
Z3MpOw0KPiArfQ0KPiArDQoNCiBGcm9tIHRoZSBjb21tZW50cyB0aGF0IEkndmUgcmVjZWl2ZWQs
IHdoZW4gaW50cm9kdWNpbmcgYSBuZXcgaGVscGVyIG9yDQphIGZsYWcgc2hvdWxkIGJlIGEgcGFy
dCBvZiB0aGUgcGF0Y2ggdGhhdCBhY3R1YWxseSB1c2VzIGl0LA0KaXMgdGhlcmUgYSBzcGVjaWZp
YyByZWFzb24gdGhhdCB0aGlzIGhhcyBtYWRlIGFzIGEgc2VwYXJhdGUgcGF0Y2ggPw0KDQotY2sN
Cg0K
