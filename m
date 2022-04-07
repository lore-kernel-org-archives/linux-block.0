Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A17C433F5
	for <linux-block@archiver.kernel.org>; Thu,  7 Apr 2022 20:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiDGUcs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Apr 2022 16:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiDGUcp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Apr 2022 16:32:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1667E305110
        for <linux-block@vger.kernel.org>; Thu,  7 Apr 2022 13:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKTGPhcnAYk+N/Bsz1pqbFKKg8Ycit8lIO/Rnp+sN8dth9n27G6HPQ7ex3gHD2OYHmiCie/uZQH8WK71PYGB1nKmfiTlAV8W6EUzoCCgHfGqvWl6mk6REkjf5oltz56WaBsqVQu2R51a1UPSswseMjEOHaT2gygAKKh9t5V36Utp2kcsReLxGlSKiFr2GLdiPovoc2SXLoEjxRmQ5a/km130jMQt0P+OIbXwqQ9va45jU1YMUNy81UgSbEHz9Ie+IW2OJFdR1R9yuZp/DXZv4aw0X92ZFtWRASCkQcUXqYDqwj4RmH6yalSLicHz2Gmxs72AeuEV+Usbu0gsVXxc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sT6Otm+dQPA3G9LZ10ndmCbaVN6Rtql3y7tLp6nEtN8=;
 b=jQSa0gwldNot4VdiASMdxbeXok9uapoWCbMRExfyRZSOFh3CuTPyO4qZto5fBjtFAm1PAZB0IIFkWyE0GYw6iozaPGa1oUe7vJUc8sCyFmTbs6P+z5+aLpsOxOmbpX5BYUSbQYe1x1VPQtGfMtJFvHVB2H/xx+ncVxkfgf7pKJGCInubtiyv9WmFv4/8N7WRcF0TUSYCQZolJU9JgVJy2t4ADFup71/VZxcJwRJwNFwZouMcUh3NlYW+iV6/RsT0y4iBUHTOc11T9rApmOPWkhrgJ4DIeBn80BGmeFNHJhl+fjaRW5NQf5Bw6q5z9qN3eYarx6MLPF8ns8eeOknqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT6Otm+dQPA3G9LZ10ndmCbaVN6Rtql3y7tLp6nEtN8=;
 b=hXCCooCSeNtjU1FjQHOTpS6a8j0a5wzYgsNrQsgdsCQMuWEZsRAv3723fROZDsK7yH6n806wFYtZR5AfZum/R8izB0Yzd4HF8PNL/IkQn2a61YSFMuqLro+LJ2ADx7nMaxGQgf53WbHF5MSpRy4E0X8r4L1xhBqTe4gf0rWtX0U7xETopJn6U7Z+PQkrLuH6rd2vI7ogU+4BZfyLR5fWly9bXTI5T4muYIy7+3OAtJ9d15wSfbKfq1ID4pcPLZ9h81wgK+4Ax91mwTLjfKY+b21DkCiz3yaQenpFcmi/hpUiguNwH7yIloHkXjUURkjH5HRObdQSwb0gB84agFXkSA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 19:36:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 19:36:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "elliott@hpe.com" <elliott@hpe.com>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v6 0/2] virtio-blk: support polling I/O and
 mq_ops->queue_rqs()
Thread-Topic: [PATCH v6 0/2] virtio-blk: support polling I/O and
 mq_ops->queue_rqs()
Thread-Index: AQHYSdw3ZzbMJFUzIky4jPf2FWUvN6zk2bIA
Date:   Thu, 7 Apr 2022 19:36:00 +0000
Message-ID: <3b36802a-94ca-776b-bc15-51f60fbbcf51@nvidia.com>
References: <20220406153207.163134-1-suwan.kim027@gmail.com>
In-Reply-To: <20220406153207.163134-1-suwan.kim027@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5eec079-6fcc-4f62-08bc-08da18cdd8b1
x-ms-traffictypediagnostic: MN2PR12MB4047:EE_
x-microsoft-antispam-prvs: <MN2PR12MB40477A7AADD62B055C819226A3E69@MN2PR12MB4047.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ml2ozgc9wl2FQxCCoKG1gW0zj7J/EvdmY1aut5fiBeR4IC7vE8hVM+fiZ781/V0HD8PU7I1N1eFtXanJDvTnVXzwCTXfETNmUVsq0xgNFBXl0TOuqXiLmP+N/utwliq9DI9NivsNcP9fyOOLTfApJH+AkPaFgXM/i3RgSCHSReYgcR5tlmu01qnC9jW2g53QWr9wfldzib74V2Dd4CexdeAJCGVOcgFkMW09W/DOAALsR1HyojwzQIeqEet8Z76DyipEkc6Hh8jgqC+zVjlFzNBZyXguGyocHvHXemuJ95wk/u4Z2EALnieX5UjA7JJysufsaWPC6qrQKOwA+/Qby4QteZjRd0NJJtl5b60OiDIbhIYOCBzncnegw/huV4kfrUaKPmCQvnDxQYzqhyFlLkCziMxQnFThkv9Iz/2VxWhzkxXHUhhcs6pWoiwJcn5U3U9gbz6icltZx0k/7kwy0FSI6HziN8lYwYz5o0aDTahj+6tqao/LpPovtF6dIQ3U9ie4LrxfJHmW3XDQkySqVQw4C4uQRUegF5PKWbVjsJ5s0bSB9TAyFuVp0nYkpI9+TpHz/itENpTrP4LVxTopAdHIkr0eNPsby0BYVZuInK7CePoZlQH6sC9pHliLjtF0/UAndfxti8DExwL7jDMkjAC4gNTrSRIOzaqlE9Hj+PqLde1oaXtwTAjWumju6HsIQtTG/OIg+SLaivCbTLakfyjt2jsCmvyY8eS720uilJPSsUV/OxHtGxUWzSf6asq/v+a/2EHElM3ZCECoJvJCZKOhAuDqqQik6+/LFvAM+wbLJ4hvI+kXk+XI/qI/UF4zKDbplrVvq7RujTTIAim8WBjtpDKlDibzNyO0o9K8Z9E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(36756003)(6512007)(6506007)(316002)(966005)(71200400001)(6486002)(107886003)(38100700002)(508600001)(54906003)(186003)(122000001)(6916009)(2906002)(91956017)(2616005)(8676002)(64756008)(4326008)(4744005)(66446008)(76116006)(38070700005)(86362001)(8936002)(7416002)(31696002)(66946007)(66556008)(66476007)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW0ybHFnTFlQRUlVb2lvd241ckpUQ0ZadW03ZHhXUmJwRUppcjdYOGYwdFZv?=
 =?utf-8?B?Wk1IakNtQ3I3YUNjSWhFa1daRHBCRnlmVzNzMVp5VG15VysvR1ZmMWdONTlE?=
 =?utf-8?B?WDhWU2ZPUVZoYnBqUzJ3VUNFNTZmQlBLNmlLbzVLeUFGKzhQWUM1N2V6QWVj?=
 =?utf-8?B?VmNQVE1IcThyL01ralUzMW5wVC9TWkNZUS84cjE1SW5DcHR4bEZvNmZzYUdY?=
 =?utf-8?B?bFBTTWJDYkNwY25aM1hnSC9MWEFBQkcrNE5ZYmVxMURzWmxhRnR4bkZYdlJX?=
 =?utf-8?B?dCtXR1A4UnkveGN0ell5S3dvSXVidGUzZlhYMzcyRjZ1dWJ6aS9TTVZNaC9W?=
 =?utf-8?B?VGRsWUwrYkdjRUVDSUR3WHV5KzE1NU1WSGw3ek5uSjZvMWtzOWpNN0tabVZu?=
 =?utf-8?B?Z1ZmTDhLYXN5U0dhR0tEY205bmRCS0xGaDhORG1iRGhuMkJTUVN6eGxuV1E3?=
 =?utf-8?B?dDY3eUs5SWJwUlo5cjBZUWdDQ3YwNjY1WE1QL3Q3cTBtczZrZlcvL3N5cUhn?=
 =?utf-8?B?NUw3QW11QzhDdWZqMlVFR09wZzliMzdEbzJEOU1nTzVjc05JeGduQ096Rkl3?=
 =?utf-8?B?OTJPOFl3RUhNdXExb2U4bXgrbk00THIxNWVMT3Y4WXlhUWNIQ1pqZ1pDeFlW?=
 =?utf-8?B?T1E3Q29uaTJPR3B4MGtWZ2cvMTRBdURzZjhNcGlnTTVHN2tSN2FxR3JtZENv?=
 =?utf-8?B?T3JKNHQ3ai93UjVncU5xUHRTcklFQ1FuNDRhcENpbjlBdUplNUxzbU1USjBm?=
 =?utf-8?B?eFlHOFVHcldDYlZCazNOcENGUTlQRjZmOHdqQVpQNWpJNGFSSDY0RjFJZnVF?=
 =?utf-8?B?R0V2Wm5vSnAzMVNjRXpCWXUvQ0ZCZ3B5THd5TVNKZTExZXJGck9NUlpoUnBo?=
 =?utf-8?B?MTd0bmV0RXdIZm9BRGMrak9qNzRCZzdDWTNVSmxhTjVScDRQQ1VPWjRRVkFw?=
 =?utf-8?B?V1VqMEpVeCs4SHFZblgvZXRIVlRJU1NIblhKMkFvcVpSRnJkRmxVeittOWkx?=
 =?utf-8?B?TmdHTlV3dHVhVm1ONlpXLzAxSFI5VFpHbGNkRlRBakhWMWpOam9mb1NVU1lZ?=
 =?utf-8?B?Q2NIQjIwekZpQWg0VGQvc3RBWVFhZTBQdE9WVE9JVFBsRW9DYkNraGNkM1d2?=
 =?utf-8?B?c3ZYVDhaVEhyL0d3U2JUY3VaSzRTbUdhRXZWTHg2bGJRSllaNGd2N2pNRWFH?=
 =?utf-8?B?NFNkR0w2MkMwRCs2bm1pd2FKeWUxdVdJWlRLejVYNlgxK1FRMVhwazhvaldW?=
 =?utf-8?B?MnFLMFA4WjZwSlBUdXJrTW92RWd5aTdvS0ZBUzJVTnJiTzJTVit5ZEZCTjVP?=
 =?utf-8?B?YzdhbmtIc1B1bHFzL2xWUm5Qalh6NENtMzlLMlVmeWRaUklTWG1NTk9hQmt6?=
 =?utf-8?B?UGdkM1FKSFhTc2cybnYyZDlGQXVUUTZSakVKNmk0NURVaUM1bTVtL1pNcjU0?=
 =?utf-8?B?Yko1Y2tJSS83TTA2dm1udGU3VVRwQWZQRkJZL1BGRWdlOWxhYUMvOGpCRzYr?=
 =?utf-8?B?SDl0VUxhdFI2SklRZWxBQnIzaTl0MkV5cWZ3TEZJU2R1TkVZWHdRbnQzdEZa?=
 =?utf-8?B?L0pYYmtFcElUeUNQdWRGdHJ4Z29QN29MeGN4UFZQWHFQb3BRbUdKRnBlYUs2?=
 =?utf-8?B?OHAyTU9UQjFGY0pEQTc2TmhKUmJZMXpobjRxbVVlRmhEbEVHTTRWMStIMTVH?=
 =?utf-8?B?YnljanJNbUVrLzBnMFRWQW9VSVJGK3dKQlZQNGFONHZJMUE0Y2FLMFhtbk4x?=
 =?utf-8?B?QVEvczJmUWJZSW9iYXR5QUt4cjhSSkFxZ1lhVmpZWmhoS21JUFg1NEJKbkY5?=
 =?utf-8?B?bU5kUTR0eklpYWE0ZFdCWXlPcSt3M2NlNUJYek4zSTRHTHVyODFOSm1vUWRw?=
 =?utf-8?B?K2NhMkV2WW9VVHNiSCt4d2tPUk1MSjc2U09nbUxSK2o2MXhPclVoSGdET2pw?=
 =?utf-8?B?UnU2L3IvYW5IMHNsZktqbzQrSVVTT21JbTYweE1GL29oTWVSSitHVFBzb1J5?=
 =?utf-8?B?eDk2MWRQYmMyU1F1NXlvSXFTV1RqeU9RZTFnR1lCVWdQbmpXMWFnTDZpc09l?=
 =?utf-8?B?M2g5WExqeEpMd1BaMGdNWE8xU2pQRjVQZmhCSStZNHlHMHFKL1JpankyemhF?=
 =?utf-8?B?UU9jbVFad0ZGNkM2TnZBNis1cFY3OExsZk1VL0tmYzRxdlRrOGx5U3J6MGhY?=
 =?utf-8?B?WW44UFIyeUF2UVduMWxkUkVqR1E4bThBcEo2c0dvOEJrN21wUWpPQ29INjN1?=
 =?utf-8?B?SzRSWC9pRWNpc3BUejU5RXVxcEJON3JWOTM4bVFScktvUnhKNnBMd1hYa1dG?=
 =?utf-8?B?akZZdjEwaWVQQjdzTHRkSEZER1ZwSDAzQlM3emRHNlNBcGg3dExwU002ejgv?=
 =?utf-8?Q?pn4JBhTgwxfeDhb1ZIaRVgd7OBCqcg0m0fWSGE6PpcPgt?=
x-ms-exchange-antispam-messagedata-1: QQxuP6mVgWMAzg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <586DEDBD04EA2B41930D0C613F621092@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5eec079-6fcc-4f62-08bc-08da18cdd8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 19:36:00.8252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKaFA/qS4dbMRqqJqm76FMRAM4lRqfkq1Qm1D0C3R3wczBeXjjZUp3rH4LE6laAJs21JZBO+Vt1MuEO2nYDRAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC82LzIyIDA4OjMyLCBTdXdhbiBLaW0gd3JvdGU6DQo+IFRoaXMgcGF0Y2ggc2VyaXNlIGFk
ZHMgc3VwcG9ydCBmb3IgcG9sbGluZyBJL08gYW5kIG1xX29wcy0+cXVldWVfcnFzKCkNCj4gdG8g
dmlydGlvLWJsayBkcml2ZXIuDQo+IA0KDQpUaGFua3MgZm9yIGRvaW5nIHRoaXMgd29yaywgY2Fu
IHlvdSBwbGVhc2UgYWRkIGEgYmxrdGVzdHMgWzFdDQpmb3IgdGhpcyBzbyBpdCB3aWxsIGdldCB0
ZXN0ZWQgYnkgZGlmZmVyZW50IHBwbCB1bmRlciBkaWZmZXJlbnQNCmVudmlyb25tZW50IGJ5IHZh
cmlvdXMgYmFja2VuZCBmb3IgZWFjaCByZWxlYXNlID8NCg0KUGxlYXNlIENDIG1lIGFuZCBPbWFy
IGZvciBibGt0ZXN0cyBJJ2xsIGJlIGhhcHB5IHRvIHJldmlldy4NCg0KLWNrDQoNClsxXSBodHRw
czovL2dpdGh1Yi5jb20vb3NhbmRvdi9ibGt0ZXN0cy5naXQNCg0KDQo=
