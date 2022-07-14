Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9541C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 16:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiGNQ0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGNQ0K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 12:26:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540715A45D
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 09:26:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EFsV84008512;
        Thu, 14 Jul 2022 16:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wZ3/sR7YlEK6ZNzvW3J+On1/6bWJzqvb93VxLOt6lbE=;
 b=R7FBcan8G46O93sgHizRndLmYmSKgmWxlMNHe70I4hHBHnYPFSPG0cZNxSDZ9v4dXfFT
 WW8hGEA6jbJoHpfDxW0K23nXXCFJ5nWULpfM6u/Vo/jh5op04Fg/awLThS8z2zV/3HdU
 qOmg6nB0j5dZ6ODApMGvRg0tuETkQSXoCxs7WaMQ4IwlQVz4uGBpo6WnqXVlTE2DrhS0
 JvS0BaDmJfRz2P6DzPUSDugIADVxSePhp/HUyv/pDOrWqQ7p5uhfAsdLdGyiAMduGnfb
 d2TijaEjSxfoisNcU/82XdXJlE1iXZNyl3XEhcJdVi2GjWKDUbtkY/jjvdYVB2pBfJzP Qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scdtba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 16:26:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EGFI3G020962;
        Thu, 14 Jul 2022 16:25:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70460j5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 16:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLb1xzqinY6fgt7BlVCZSDuS7bLq+AD5Zq8L+sIZnkgZ1lF8jaQSQZpNGdvYhk31pAA2cN2ukw/bNXr0HAWHfq26gViBZVcT/qm19AkE8kO6M7z2e8FKipXRHVs2QP8zhse6fkmB4jxYj5q7BMmvj0VW7+tESoncY2XfXAAp29aGMdtYbdOfTgGnIHhwRT7xsNwvTiWCYWo2HlA/kzU5GVSP60TzBpEREPnNZMvffDhjXG0HvnAGiAcSSjO60oqqWCt/ryCEeaGJhchVqEZ0Kzz8lkIU3DBAp98X3xjB7Zyd62CfyRJXhM2FUNZkoQgz5ZQ+EmP4+kRGugnp/UxT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZ3/sR7YlEK6ZNzvW3J+On1/6bWJzqvb93VxLOt6lbE=;
 b=ofXtWlDSoKswXDJcmNdK875Iq380MDqqnf5HUzcR1Wro2vob9Y+DGF3XHV3YDbpfEGuWs5aFiyuMTLqryet1NUnscsmpk9q52s8OMXe/SSQKeJUxFssDR6OGBK0YHlBjX1nq6Yn3MCJQHf6a3n1+wJt+MOfY6STuDgzzRd4i8fGzoicmaRJYcM7HOKv9OyR8zf3CxFE6AG6bYLvpun9ZWsJLHdFnelVs3+3i5Nwpv8hMFe6N8E3usWTWl4ht8osXN+FJh9C1KxikjIJKbNA5KsB8rXGUxXRUHb548qdYoLywaOO/3o5ZOBupUPrX/CLZbt7cxzMmZAQz3t+hRY4YXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ3/sR7YlEK6ZNzvW3J+On1/6bWJzqvb93VxLOt6lbE=;
 b=yUPzSYx94h7DBbgW0w5LyBqAIKgXOM1gwFHt63Bp4eI7xktZraFAsiJ3EPqU8+3srVS5DikzMyk6OzY6weX90jU/G8GZTVcddjPJVCnsHefgIQtZD+mR94p/sPEQ810QCC54+FSxj0n8IrereWDJLgcO/GwaH012vqM4GfJ2WQg=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by BLAPR10MB5331.namprd10.prod.outlook.com (2603:10b6:208:334::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 16:25:57 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::711c:ac02:36af:925c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::711c:ac02:36af:925c%3]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 16:25:57 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] tests/nvme: Set clear_ids for passthru targets
Thread-Topic: [PATCH] tests/nvme: Set clear_ids for passthru targets
Thread-Index: AQHYkLG+bIDx62xWtUmXo8eTsGiyYa1weoyAgAEGqgCADJoxgA==
Date:   Thu, 14 Jul 2022 16:25:57 +0000
Message-ID: <4AB40A37-F3CA-496D-80D9-13845D6DC3E1@oracle.com>
References: <20220705205632.1720-1-alan.adamson@oracle.com>
 <cd910676-cf1d-ae13-94f2-e1ccd59d431d@nvidia.com>
 <85D002C4-B3F7-4EE1-8C0B-B2E41F234046@oracle.com>
In-Reply-To: <85D002C4-B3F7-4EE1-8C0B-B2E41F234046@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf512eb4-3a4b-4be5-dd17-08da65b5885b
x-ms-traffictypediagnostic: BLAPR10MB5331:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Srz9bDykTIFEbareQSc/9dphM9pJvHR8gF/JU/kAu8lSLOr/6d0xoyFp43WwpipNGoZFgoJ+658RbQFZgrSZrUikwG8hjxm16DzdF/XOq4JooDJplmbZSpi26c78ikUX9mfqgAZseXQBUVBrMI/TVzYElZ9Es/dNWYwI/nV5ZPWVs7U2YpCpDGgoNzPc2wbDR/fL7/egA4rOu9LXMh/OHZPC5x0sGd5KRzRu+JZ3jR6Aumtflqgs6vtmhFxeWDVqHOZ9bJTs+3FNKqcLyJhYC4AWMIOoPjXIBguobt7qD+Qg7zj3lCCksORnTdnUa+F5idgayYhjdBlDJ2DQf9VqaEdc6qiIh7Agzse7xVpM9U7lwZj23ZWDLUTTxvQ37axvKwuJySlzDqXhmOAPJAsCV63xsPiRLqBm35wesq3YrklI3ss0vlriwnyVDfKu8J10mEMebRrZtl/SL8+ZOI7HqS3ybf+mFLXvwJCzWy6tZ0pMJRVWwvT0AYIXYu+xGFCDsCZEpWgmQnBH+H+z1mPvEj1Hmfw0XcDqkDlhx8jNQZylMtkM3APGPLgRIdnpOhJtsV9V5tPjZBCqPdpUpDBmrVKtDqmD+meJP+WxG34FOaOo17IObJlpMqprm4B2uWOYsGSOiliOABPWSHB4jor0HbBOF6erHeoJogElmVeY1yE/wtqyvoNmLFcr2eOtJmBZ6+3vuV6PsMiO3xrWt/h/N6raW9AdXh4TOZyl/c06XBzVd+qp6CnPZlOH3S51YWti0gnz24YRnqzooFQiqrA+nF7BPKp9PtNiC6w7bpal+aVWUQIndjnHL8+Jscm8XW1r4z6x9/GFQtFRwq3vrz1gk37ViPapsXZPDO3IjF0NyB4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(376002)(396003)(39860400002)(478600001)(38070700005)(44832011)(186003)(6506007)(6486002)(26005)(6512007)(76116006)(38100700002)(91956017)(316002)(110136005)(86362001)(71200400001)(53546011)(8676002)(64756008)(4326008)(5660300002)(2616005)(8936002)(66476007)(66946007)(66556008)(41300700001)(66446008)(83380400001)(36756003)(122000001)(33656002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXRucVNxcmk0SmxZNlhPK3gvN2lDaFZaMWRlTjZGbHBkb0FUSStGL3kvd3lK?=
 =?utf-8?B?dVNQSjl0b1VFUitrbHNVM2prclM0TEVta25JUHVoY3diaTg1K0lQdHlZRzgx?=
 =?utf-8?B?UFZlZiswZnV4N0pianhsQ0Y4VVFXZDdrTGMrd1hqUlVnTVJTS05PdDZjYWpX?=
 =?utf-8?B?c1RXbG1KblZuU0NFcmt6dk1aUnY4L1QzVVM0T3ZaNVp6TWxHZ3JYaVk1U2c5?=
 =?utf-8?B?TlZtUVhJTENtK3pIUDYzK3J4MHpDZkR1ZHdYT1cwU0l2dE1JblhGenFsM2g1?=
 =?utf-8?B?RkNhQU1jYWliem8xSUtBN0o5OGc0OS95cFVVUWtQajJpc0QwblNGdkE0NTBi?=
 =?utf-8?B?UkJMT3I1UmJXcC9LWitlOXVjcTYxei9oUTBoamZyV0pFcTUyc1ZJMmJad05I?=
 =?utf-8?B?WWtjZG9VNW41Y09aUFB2NTQ2U3pGMzRlbGdWMzB5TlJNQ0hNUEhzamNTeUhm?=
 =?utf-8?B?aXJWVGNCYnF1K2hNTDY0QjNIUDM2MlhWcmpUMitHTjZNTWMzbUlrNGVXdUQ4?=
 =?utf-8?B?NkdON0prTDJETVdVSzZacG5MWWMzbjJJQ1Mwb082WlFRYXpXVFM0aDNVWXFH?=
 =?utf-8?B?WGVOWlJsUHhqWW9XUXVDbHgybU05N2pvZTNMUmhtQjlrRGFYMThLakVyalg1?=
 =?utf-8?B?c1Jqa0dVMVBaeDQrWmNhVEVLRGsvSDZqVHR1cSsrSFQ0eFUweW81VVBBZHJP?=
 =?utf-8?B?eExSMHlFK1Y2ZU5jZ2RJUmVlcDZRd1JiZG8xR1hvUitaZW5JWm5vZVRjeGM5?=
 =?utf-8?B?cHF5Wkk3aVJ4enhkaUF2aVZIZ2tKR0psNzNGY1Q2N01aenZiZXloTXVobnB5?=
 =?utf-8?B?Z2VqOGM1NEc2MllvdExINE5xQzh0UXVDdi9RdHU0ZUloK1NpVDZVSVZnaTFi?=
 =?utf-8?B?TDZxTU5KdFArUEVlUFdsL3IvZFBIL3dOMysyVWZlMEx6enB3KzE2NVllN3pz?=
 =?utf-8?B?S2hoNGlNaFlZSWluT2hOYmtrZ05ORkc2NzRpbHQrakVqb1piOVlPcWVnMUVM?=
 =?utf-8?B?ZGJ6N2tlQWt3Y2xmWHdxM0JjdGZwWTh1VEx0K29LdkwrL1YyVWxiOGFpbXRr?=
 =?utf-8?B?NG90bWh2YlpzZTBYOTNENzFMZVhvMm4wRTJ4UVFCdTdwb2JZMWlwVStEcWlx?=
 =?utf-8?B?U29INmFldGFUcExIeFhiUHFIVDZUUHpRVmRWV0RIN3V4RkFZdDVWZGk5NE1D?=
 =?utf-8?B?T3JpdE84Q1F6dENqNlRGM0RFemlwMUFkQ2VSbldCaWxPMEVOTWpITEZtZEc5?=
 =?utf-8?B?ejg5cmRRV0pVbFJ2Q1o4dEx4eUNmS3V3aXZCckI5Y25MbnNjbU1FWVo1RnZZ?=
 =?utf-8?B?NTVqSHlEc2YzYmJIcVNhbFFRQllDZDlldkZXWElOQlZxNWhXQzBKcVVpanFU?=
 =?utf-8?B?elNYQi9ZQ1BaaEs2TlBvWkF0TTRJRlc1THNCczRySXFtN3IyMkgwL0ZkMEJ4?=
 =?utf-8?B?UmRxZHZZd3piNjg3V3VCdzYrTEp6WHl0aExscUtvV1lDRnVkYUlWTGYwMG0w?=
 =?utf-8?B?K2ZpbTdINnlvdUpHckRMUmVqckxrNjlSMWpILzZsbWZjeTVFbCtPdUdsQVdJ?=
 =?utf-8?B?d3U3MUlDZ0hETS9FZnF4SjArQURyaFFhelZZZ1dpNEw5NTlNRk9PWmR1S0c3?=
 =?utf-8?B?c3lua3BNSUw5MUxYR1hSdFgrUG82V2hYb2FwSTB5bUVVL21mcGRwSkFIV1Rx?=
 =?utf-8?B?RVZFWmJzK1BRNTgydFg5WHpWNlF0cE84YzA2SkpkMzFvbnRwSkoxMEt6dXJq?=
 =?utf-8?B?aW9KSkxnMXBVK2IvRFRQV0xGeS9RUlNlNEV4NStoeTBrSHB5N28ycGxOOGFw?=
 =?utf-8?B?MWlkZHlVeklBWXhHdkdOZUkyUTZBVG5DYVRIVlQ4SmFweHJkb1ozSnpYSVJC?=
 =?utf-8?B?RHhOTy9hbnNpQm9POHR5OXRVN1RyQ1dZRDdGL2lBTFI4c3l0dEFsQnJYSGlq?=
 =?utf-8?B?eHNwQ1hwUk5UMFdBU2FLWXZ5a0lleGxINmRCcGpuSEdSRGdob0I0L1ZSUk5Y?=
 =?utf-8?B?T0lCYzZMM3d2Skk1SFhSYUJqVUlraCtheUhvelorY09UMEcrTkVPcGJpTSs4?=
 =?utf-8?B?cHp1YUNyNHhERnp0L28vRUl5bG1aTGdPU1ZicS9ON0FwS213R3VGVHFjVzRS?=
 =?utf-8?B?SkdiWCtGaElJZ0VJUkxTRWNxdnM2YjNWa0FvQk1Mek5oSFdsdDhIc21OU1V0?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67EDAB6398C59F4EB59B68C4C88B36F3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf512eb4-3a4b-4be5-dd17-08da65b5885b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 16:25:57.6929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJacjKBTrVW8RGW6rvn7nP811jWJr84LeSEPzpf3xF7m1HufNdocKahfLrw4GH+P6BIJKRG3XgY8XWTh80WIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5331
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_13:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140071
X-Proofpoint-GUID: Yx6iEU53LaNxgO4R6CKaZQI0FRdNfEti
X-Proofpoint-ORIG-GUID: Yx6iEU53LaNxgO4R6CKaZQI0FRdNfEti
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gT24gSnVsIDYsIDIwMjIsIGF0IDg6NTggQU0sIEFsYW4gQWRhbXNvbiA8YWxhbi5hZGFt
c29uQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gSnVsIDUsIDIwMjIsIGF0
IDU6MTggUE0sIENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlha0BudmlkaWEuY29tPiB3cm90
ZToNCj4+IA0KPj4gT24gNy81LzIyIDEzOjU2LCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+Pj4gVGhp
cyBhbGxvd3MgdG8gY29ubmVjdCB0byBwYXNzdGhydSB0YXJnZXRzIHdoZW4gdGhlIGNsaWVudCBh
bmQgdGFyZ2V0DQo+Pj4gYXJlIG9uIHRoZSBzYW1lIGhvc3QuDQo+Pj4gDQo+Pj4gU2lnbmVkLW9m
Zi1ieTogQWxhbiBBZGFtc29uIDxhbGFuLmFkYW1zb25Ab3JhY2xlLmNvbT4NCj4+PiAtLS0NCj4+
PiB0ZXN0cy9udm1lL3JjIHwgMyArKysNCj4+PiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL252bWUvcmMgYi90ZXN0cy9udm1lL3Jj
DQo+Pj4gaW5kZXggNGJlYmJjNzYyY2JiLi41ZTUwZTY5ZmIzZjAgMTAwNjQ0DQo+Pj4gLS0tIGEv
dGVzdHMvbnZtZS9yYw0KPj4+ICsrKyBiL3Rlc3RzL252bWUvcmMNCj4+PiBAQCAtMzAzLDYgKzMw
Myw5IEBAIF9jcmVhdGVfbnZtZXRfcGFzc3RocnUoKSB7DQo+Pj4gDQo+Pj4gCV90ZXN0X2Rldl9u
dm1lX2N0cmwgPiAiJHtwYXNzdGhydV9wYXRofS9kZXZpY2VfcGF0aCINCj4+PiAJZWNobyAxID4g
IiR7cGFzc3RocnVfcGF0aH0vZW5hYmxlIg0KPj4+ICsJaWYgWyAtZiAiJHtwYXNzdGhydV9wYXRo
fS9jbGVhcl9pZHMiIF07IHRoZW4NCj4+PiArCQllY2hvIDEgPiAiJHtwYXNzdGhydV9wYXRofS9j
bGVhcl9pZHMiDQo+Pj4gKwlmaQ0KPj4+IH0NCj4+PiANCj4+PiBfcmVtb3ZlX252bWV0X3Bhc3No
dHJ1KCkgew0KPj4gDQo+PiB3aXRob3V0IGxvb2tpbmcgaW50byB0aGUgY29kZSwganVzdCB3b25k
ZXJpbmcgd2hldGhlciB3ZSBuZWVkDQo+PiBhbiBleHBsaWNpdCBjaGVjayB0byBlbnN1cmUgdGhh
dCBib3RoIGhvc3QgYW5kIHRhcmdldCBvbiB0aGUNCj4+IHNhbWUgbWFjaGluZSBzb21ldGhpbmcg
bGlrZSBjaGVja2luZyBudm1lX3RydHlwZT1sb29wID8NCj4gDQo+IElmIG52bWVfdHJ0eXBlPWxv
b3AsIHRoaXMgY29kZSBpc27igJl0IG5lY2Vzc2FyeSBiZWNhdXNlIGxvb3AgZGVmYXVsdHMNCj4g
dG8gY2xlYXJfaWRzLCBidXQgaXQgaXMgbmVjZXNzYXJ5IGZvciB0Y3AgYW5kIHJkbWEuICBUaGUg
Y2hlY2sgaXMNCj4gZm9yIG5lY2Vzc2FyeSB3aGVuIHJ1bm5pbmcgYSBwcmUgNS4xOSBrZXJuZWwg
d2hlcmUgY2xlYXJfaWRzDQo+IGlzbuKAmXQgcHJlc2VudCBqdXN0IHRvIHByZXZlbnQgYSBlcnJv
ciBtZXNzYWdlLg0KPiANCj4gQWxhbg0KDQpBbnkgb3RoZXIgY29tbWVudHMgb3IgZmVlZGJhY2s/
DQoNCkFsYW4NCg0K
