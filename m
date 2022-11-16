Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD10C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 17:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKPRWm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 12:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiKPRWl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 12:22:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E917DCD3
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 09:22:36 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGH4UhC021257;
        Wed, 16 Nov 2022 17:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cLo4m0hMoqAq2TOfl+MAq+iJkvC222tvZwG7T1wUkDs=;
 b=HBaCMjZC0Xa9O9wLS8nwrBC4HZg1nPJEKErFiJ6bH8BynqaTYjHuqaWq+a2Ma0tq8jIc
 uBgAJ8Rn+7eDNYgbfJ36lNhKydLobO7ON0yiQ8Pu5p7G7iCuDEbSfuCoby+16oa05jX3
 TTdCEhp5SxoeMw4VzM33HGFj5+RnlH5QKSTqNRBwjTnIFt4Jx2vJQU2xFPVmVCZZhCri
 3te251PgtkYLOISRXCvcjlEifCtdQgUva1XK02saxml7YlUQ0c14dGI0el5+7UCEt2GN
 5Bq3vnjZ9HjbPzXX15MGxkxgOTp57XffPKN/VKg8OvzHl/5sKYF8lKWHI8brTUeJgOcn GA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3ns5u1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 17:22:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AGGiKcj012445;
        Wed, 16 Nov 2022 17:22:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xe2kqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 17:22:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STR4/J0XD7lZcGFCiCM5s91wqOC1aIdjCoCScfu32n7aUkBSydFAWg7gsJXKoxMQHGs5A5spoPeEYkYF6n+0g+7QvMmPqTYlpTJ+EVyeVikZmZ34V+VbiFLw4HCohnBCIYKnuBzAKmnXOaYb/DShP2Ji3ZXM0La/DT/PUpsHjQ38PYSKt3BgtDLXumFY+nL6dkBnNuvWUTI619Lp5U2G3XDi7ovQqBC7rdSXID7IncE0X1+GehlsRrMSynzn87RBziLIfneK/OToqOlsN/Z+zVqwb56CU4lhGQPOYnD2CZ6k4yiNDn/LDJ38/iSlFFFr8HL1cI6714JGB7tfj07RDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLo4m0hMoqAq2TOfl+MAq+iJkvC222tvZwG7T1wUkDs=;
 b=C5YFn/QUDM/8gf2mft4poy4ubepqniqeV6Onf4c0qVCSUFfq7iArPzpVAuL0YlsuKu38Ny/MjylVyLRy27tXZBX5oTMOJ/JJTtbhLpCUz7PrjbsgEfm8ydpBtkivdKptpLVucEUAYrP9rFSCJ44FoXABaHOqFDdrc452+BV84uj6bK3Ylsl9x4CEIYBEtpcQ+SPMoe5uz1vhkXnw8DFezNXHnQ+ndxVzcrHymsti31a0ZDi6z6VoqbLXfbutlKMPFKfXWrUYTTxSBsKIlZk6Z/IZZBGV5p2BdweY6MX3g1M6jGjTJr/a7WL8cthxaX53/Uv8sxnuNNSv+cActhS62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLo4m0hMoqAq2TOfl+MAq+iJkvC222tvZwG7T1wUkDs=;
 b=ppg/YaaGDMZN+oXt6v9oM6L8VDSJN3MR+9Z6loJ5WuWPDnDRtYEjDj4lCsKRT5KxjpKf8OsGzVWLKXOThkmJRB37i1+1XE8G2hu2LGUm0Z9y6oYfHehnU1PayMbvMmE3lyImWLE2VH3A4dErqrz05leWoQyoddKJ0++vKEI7DZU=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 17:22:22 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::7f62:c8b3:46e4:ed1d]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::7f62:c8b3:46e4:ed1d%9]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 17:22:22 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] tests/nvme: Remove test output for passthrough error
 logging
Thread-Topic: [PATCH] tests/nvme: Remove test output for passthrough error
 logging
Thread-Index: AQHY+VAjTUDmk2YWWEKPDn4a2YSEUq5A8e6AgADSCYCAAAlggA==
Date:   Wed, 16 Nov 2022 17:22:22 +0000
Message-ID: <3CF838C2-0594-4EDC-BC4A-809267F65219@oracle.com>
References: <20221116001234.581003-1-alan.adamson@oracle.com>
 <20221116041701.mu4osauvwqsbvjau@shindev>
 <Y3UUb9RvkmS2OuYp@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y3UUb9RvkmS2OuYp@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5550:EE_|SJ0PR10MB4750:EE_
x-ms-office365-filtering-correlation-id: f42ad426-b5d8-4486-ca5c-08dac7f71f9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1anwuJ/mHtR5adbRW16xvSjWloUS6NIl0hou6LPduuoS+y86e2rTMOVxYBraPcLMTgskwlFKTMN63y1Bg8hfhjTm34i1rgFC/bEf9JIucRcsIPwifOc21WFOspXBM8LKDpEjS5MoHMdM/NVTS7+57d66i+NcnCrbtYp3mmKrFs94ikVWbcD1l8ra1p5V6SIvRDKxtx0DQEG7aNck4+qj7vsO8gVEha+MsKGbbCa7HPUtyZWuR3HCNjib9KjwmzaXbLfDP+ehOrT9NfwPi01Dh4Ok2nDekz/rMR+DGos6wd3EtA3mKSeUpdiFoC5rQ9R7UHyCETG0NE6EkRiu5Md38sOQ4gD+FmdOf6zFeX0D4WbaptSAmIGoCdQ6xnxYBxt52hH91jIR5RCTtL56Xgck0u0a4Khb000+mF6cQD5QOhF45PiDGn6idxb+DRKbjyKUUyrJ1GOgNW4gCCalPnQXqBeGWTKnUxF2XQ8dGf9RLiMxIQ285p51z3QwZOoaRmozr+xL59pFwCtSAIZbFvYpE6n1J0J5I6s+gkwNi5LehVT166JS21Sz4LFVTg/W4N1NxG+bhhjcnqAlpRnYQzd9umHkuo34c8j83NPr0scA25vLRTZqTp85DbxaphRtFU3JgnG7qNv2z7i7PjGvQmbmsmCHhdDHur4G25hzLpMwjtUPmDCeoZ3uE+oAsYvrjvMUICKWZTzzMENo80pUeAfusoTtnpCE9yuUplSFq1+U45whIHlOBJ/VkggCTKd2M//wV0n4WKMW24kdNxzrTzrkt5/2YUG6arh+NMTY0wCTfI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199015)(86362001)(33656002)(8936002)(66556008)(83380400001)(122000001)(38100700002)(5660300002)(44832011)(2906002)(66946007)(8676002)(64756008)(4326008)(76116006)(66446008)(41300700001)(38070700005)(91956017)(6512007)(186003)(53546011)(36756003)(6506007)(6916009)(2616005)(54906003)(316002)(478600001)(6486002)(71200400001)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0M3QWtpbFJYUjVNYkk2K0JRNFB2cE1JdkR4MGVFK3lQRGQ5SWIyVlhkQ1VI?=
 =?utf-8?B?RW1Gc3dkVjdacVF0MUcrNkU1VWVKZTJZdWZrL2VxMHUvOWhLVTZqNW1WWFA4?=
 =?utf-8?B?ZUtYZTZ1L3RYV0VVbGt1L0lnWlQxZHVhM3QvbFRwMEw3c2ZxR3REbzEvZ2hB?=
 =?utf-8?B?aDk4cXdFanNSbnBMSjZZN09FZmpneVp2VmRFWjRaMTd1SkJSVlhSZllBaWMr?=
 =?utf-8?B?cnZzcG5OSDNGM0RSV3VhSmNaTGhNSVdmRXV6Z0N4QzZzY0t0ais3Nk1PeVg3?=
 =?utf-8?B?QzN1b1pyMmZOc3FHQ0ZFME04QjFicjA1WHZ6SEFmU2lGNDlDOGRja05GRkUw?=
 =?utf-8?B?dHh0SDhDNWQ1TlVLMlBLQmhNREVFTlBRaHRpRWRvSFh5cU1BUmlsb29ubU1a?=
 =?utf-8?B?RDBZa3p3Rzh0V1pRZyszQU1Ia1J1V3pzVHl0VDA0NDVoNjBhQnA0cjZHaDhF?=
 =?utf-8?B?V2pIWjRYRHJYVTlLVlAxN1Z4RWp4WStFeVEyT0g2QWlXeGdHdWdIZEVFL0s0?=
 =?utf-8?B?ejZsY1FaaEp1YnF0aG00cUJBdm1rdnBvdW13dkxsS3dxTVdwOElCMHBRYm12?=
 =?utf-8?B?SUZVV28wczYwcUZFdEQyU3owMjYrZ2Z6RTdCTVNZcG5HTXUvVklMOU1kWWVa?=
 =?utf-8?B?QUVtbmkxcGRicVl1eWRjVCtoQUdvaWFsL0hYNFNqbENwb3ExUzBqVVpKSjA0?=
 =?utf-8?B?TGlKeVppWXFGamIxUllPekh1c1VxOGdSbjFUL3h0RVZSN201dldvNU5jdVJm?=
 =?utf-8?B?Z252VFhNNWxvNWZhZzUvTmpMRUREWVIvbVZpTFpXenVhYkEvZnpISU5BVThq?=
 =?utf-8?B?VWhiN08yVlV4MVpSSytSeTEyUGNOcndTOEdZSGpIV01oY1phREJsVjcxOHpo?=
 =?utf-8?B?S3BhRlhqWmUrQk5zenZvRVdwOFVzMlVETHZlQ28xMFNyeFpmdENTR1o0LzhQ?=
 =?utf-8?B?eWpXamR3VmhCcXVCenpqZUhUMDgrK0o4Wk9EdEtabXNUblVvK1ZrTFMycUxx?=
 =?utf-8?B?dU56Vm01d2pCeWV5MWJyL3ZFUW50UG5ZVzcycjZnbHU3bmdhbGc4Y29CNXdt?=
 =?utf-8?B?Ulk2MzBzTS91SGcyNGlteFRmUVVLTXAyM3o0L0h4WjdnQlBjM1JGVjkreGpn?=
 =?utf-8?B?aGFQQnA2VDJ3RWU3Q3E5WXR2SDBxSGVmSjBmTzZzeGhlMjRMTk5Ca3Q2TUpB?=
 =?utf-8?B?WjhYQUpObEhVRXNock82RzVkbllCYkJjRkM1emplaHN1SUZUQXZFcGNjYklR?=
 =?utf-8?B?cXhjbERrZElmT0dvOHZDYUdsZFJZT0tXVW1EWUhaUlZzTnY1MXVTdmdyKzFD?=
 =?utf-8?B?VjNQL2hlektXUEFoSFlMOGtnSG44VkdBSmpaellEYWZPazJsVEZiUi9MT1B0?=
 =?utf-8?B?SHlBd255Ry9IdzcyU2o0TkdoS2ltempvOEcwNXREZjhPLzRBV0g3VHY3WTRI?=
 =?utf-8?B?NmFCM1ZHV0RKN3VKd1hrUCtPcWFYV0RQOVgzTDJOZDlLTXY2Vk9MWURobjF2?=
 =?utf-8?B?bnVDNmJxZEVmc21jK1FvcDlxbWpPTkFPbVdoaEI4akRSOCtPa0VDTFVQUWpL?=
 =?utf-8?B?T0FqUmdhUkJQL1lDcUxPY3pWQTZleWFSNzQyaWJmbk9kVHlhUCt2clRnUzlH?=
 =?utf-8?B?ZjZRYTZvZEhseTJiSlpFeDZiUVc3WGkxNWNmbFQ2Y0QvanF5alIySzQyc1ZZ?=
 =?utf-8?B?YXY4S3F0OGV0blFNMEFoMEJJWEtSNjZtTTFLQm1CRkpZNkdWaTFZNDlMNkpJ?=
 =?utf-8?B?WnZEM1ZXQWsvZFVMTzlWTDJPZ0RkdmtuV1NPS2FmSmRtZWMwQ0E1V0paUWJy?=
 =?utf-8?B?VDRMRys3QytET28xTjlzNnNYREJ3QkxFT0FZanFvV1BCMHdQWW9HZkFlR2Y2?=
 =?utf-8?B?UXdXRUFabmFYeGk4eWRNeDJwNjhvRGJnWDdyT1RxdlhQM0RPRjFac0cwTU5S?=
 =?utf-8?B?VjBhNUJNcWRJbWFVVjJTemVDSDVXeWlhOWREaXBTd3FrMHhKZGY5Rm5uTmtk?=
 =?utf-8?B?bGF1bDN5S3BpYSt0NklDcVMva0drVFFsMUFzd3lhaXRwVEF0b2d5dC9UemFn?=
 =?utf-8?B?RjZKTWFOaGpqUFJpa3JkWDZBaTRJU2ZsY091amVyY2laUkFEWnNnMVJCK2ht?=
 =?utf-8?B?N1kxR3VIV1YwZURRVDc0UWd3R2EzSlJWcDhSenc5TSs5RVJjVE1ObHNWZHVW?=
 =?utf-8?Q?U3lePdnVuW8dt7wgkwAG8ezijBj6ul4Rs9jzNLuDWdXk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16B1E1AD6F77E54CA6E59BE6C39040D1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VAo9H3jLihHnsul9M+SeNxkWjmPtSNeWw0yR+NqQYMRfUbl1PlyU+r5w16WYLH7yyMXyn0UbbPFsrWOBOnSgVKqVkKTjLncFE68fqtP6U1xpCe66wkucfnWmEsNMCJvS4R9ZXh+ov7XS9DVt7e0q8yMYExjyI38zx/N2YHGI7qy0HWk2TtUYnYbazqgL1zJzGCmAhIIxrvetqhiuszf/yHpLCvpjsaMIviiIo2IqBn+DpCBdqthWFKKsbLULt/KdZLRFjr91mgCvfUvp9l1tgJsv3wyJAZyLYluFLcGzTmHQfUhmpfOGTEa/1rnbM4MrlfQ/Zs4W5g+ymnJoHfyUWI3R56GkNL0PHykuAlQUOkWFXrP/yUkwAJJrfM9s5jAYFn5GgbFR3PqtffEBO6ddd5SJRi3lpTKkLNfCxVvRulDgO6xlGh/TqCo0LGqIsi/u3JNXZgGmswWFdo3DCG07ufzRl4595GXjtHnFG8MUwUeMtTwWcS4dYq1rG/idgDRDfFNcGE2k55hOG0hx9C99PFxikTr4h+EhaDnKpKnZzDrkGj1TuzZr9yoyfAAkWSClVuQ/kMSzkK/d7uadnb5urOx7npMVukrEt3rye5cc7dIAQV4Nfj1XqD3acR6fwNWWyOjqqdlAQE76riKI4lNeSIfFiwiUVp8oIhck2rbc7+WfAIxzjb5kuaz983s10s9wN8hHxAuTY+FoQg0N39ueaNoiyAPZZ5WGQ67HgkyzZuUZ7//cArQysbxGP+i7t6i1bmeFTbf6gPkjdk1BYHd/rk4mU2IDrd6ageuMcbJkF9ES+doE7VCQ8h7aUeaLoq4fzobZ66IzxFSDu9iznv5fEXtgx7IlH2gKhMk2ihcxvxJIqinJS8cZslU9KVNdsxwf
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42ad426-b5d8-4486-ca5c-08dac7f71f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 17:22:22.6995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXPltB4YOWKUf0s+JiPm939Fba7whZwELIYyTJjXfX3BgxkFArr03XJIC1X9zxgWbJiDcS0SsUnd1RL/1KxCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160120
X-Proofpoint-GUID: EGOqogGC002jAs_Gy98WkqdFI9ffT6mc
X-Proofpoint-ORIG-GUID: EGOqogGC002jAs_Gy98WkqdFI9ffT6mc
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gT24gTm92IDE2LCAyMDIyLCBhdCA4OjQ4IEFNLCBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBOb3YgMTYsIDIwMjIgYXQgMDQ6MTc6MDNB
TSArMDAwMCwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4+IE9uIE5vdiAxNSwgMjAyMiAv
IDE2OjEyLCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+Pj4gQ29tbWl0IGQ3YWM4ZGNhOTM4YyAoIm52
bWU6IHF1aWV0IHVzZXIgcGFzc3Rocm91Z2ggY29tbWFuZCBlcnJvcnMiKQ0KPj4+IGRpc2FibGVk
IGVycm9yIGxvZ2dpbmcgZm9yIHBhc3N0aHJvdWdoIGNvbW1hbmRzIHNvIHRoZSBhc3NvY2lhdGVk
DQo+Pj4gZXJyb3Igb3V0cHV0IGluIG52bWUvMDM5Lm91dCBzaG91bGQgYmUgcmVtb3ZlZC4NCj4+
PiANCj4+PiBXaGVuIGFuIGVycm9yIGxvZ2dpbmcgb3B0LWluIG1lY2hhbmlzbSBmb3IgcGFzc3Ro
cm91Z2ggY29tbWFuZHMgaXMNCj4+PiBwcm92aWRlZCwgdGhlIGVycm9yIG91dHB1dCBjYW4gYmUg
YWRkZWQgYmFjay4NCj4+IA0KPj4gVGhhbmtzIGZvciB0aGlzIHF1aWNrIGFjdGlvbi4gVGhpcyB0
d28tc3RlcHMgYXBwcm9hY2ggbG9va3MgZ29vZCBmb3IgbWUuDQo+PiANCj4+IEkgY29uZmlybWVk
IHRoZSBmaXggYXZvaWRzIHRoZSBmYWlsdXJlIHdpdGggdjYuMS1yYzUga2VybmVsLiBBbHNvLCBJ
IG9ic2VydmUNCj4+IHRoaXMgZml4IG1ha2VzIHRoZSB0ZXN0IGNhc2UgZmFpbCB3aXRoIHY2LjAg
a2VybmVsLiBJIHN1Z2dlc3QgdG8gc2tpcCB0aGUgdGVzdA0KPj4gY2FzZSB3aXRoIGtlcm5lbCB2
Ni4wIG9yIG9sZGVyLCBhcHBseWluZyB0aGUgaHVuayBiZWxvdy4gQ291bGQgeW91IHJlcG9zdCB2
Mg0KPj4gd2l0aCB0aGlzIGNoYW5nZT8gT3IgaWYgeW91IHdhbnQsIEkgY2FuIGFwcGx5IGl0IHRv
Z2V0aGVyIHdpdGggdjEuIFBsZWFzZSBsZXQNCj4+IG1lIGtub3cgeW91ciBwcmVmZXJlbmNlLg0K
PiANCj4gSXQgc291bmRzIGxpa2Ugc29tZSBmdXR1cmUgY2FzZSBtaWdodCBhbGxvdyB0aGVzZSBl
cnJvcnMgdG8gbG9nIGluIHNvbWUNCj4gY2lyY3Vtc3RhbmNlcywgc28gSSdtIG5vdCBzdXJlIHRo
ZSB0ZXN0IGNhc2Ugc2hvdWxkIGJlIHNvIGRlcGVuZGVudCBvbg0KPiBzZWVpbmcgb3Igbm90IHNl
ZWluZyB0aGVzZSBtZXNzYWdlcy4gSXMgdGhlcmUgYSBtZWNoYW5pc20gdG8gc2F5IHRoZXNlDQo+
IGFyZSBvcHRpb25hbCBtZXNzYWdlcyB0aGF0IG1heSBvciBtYXkgbm90IHNob3cgdXA/DQoNCldl
IGNvdWxkIGp1c3QgcmVtb3ZlIHRoZSB0ZXN0cyBmb3Igbm93IHdoaWNoIHdvdWxkIGFsc28gd29y
ayBmb3IgcHJlLTYuMSBhbmQgYWRkIHRoZW0gYmFjaw0Kd2hlbiB0aGUgZnV0dXJlIGNhc2Ugc2hv
d3MgdXAgKEhvcGVmdWxseSBzb29uIC0gSeKAmW0gd29ya2luZyBvbiBpdCkuICBUaGUgdGVzdCB3
aWxsIGJlIGNoYW5nZWQNCnRvIHRlc3QgdGhlIG9wdGVkLWluIGFuZCBvcHRlZC1vdXQgbWVjaGFu
aXNtLg0KDQpBbGFuDQoNCg==
