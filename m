Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225A1C77B7F
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 10:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjEQKCy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 06:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjEQKCx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 06:02:53 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9084F2738
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 03:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684317772; x=1715853772;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=mwTIrGB97+oVTWTPf0wHE5nB2zSEhu1al427AvcfANI1cXOOIkFeuvcC
   eSIb622Rt0rmvCN2f/cfbU7x8c4a3C+VTmKzFkUtIgyt9zXKEko1xL6l7
   p8kNc4bYbDtqPsNW8nf0ZD7qlFy2X7JQor1JHtpZmIpVJY7tQRkslOPZK
   tPEUJJewl4CKueyh+X1NGRY3E4TN90fbi+fT2nhOMq+XT4QaXgXWB13H3
   iokUiCRvI0zbag4Ab8nMgmuVEIwERbL/iMZJYs0QP7YDDZxaR3vdq7NtJ
   uSLj+e9pO+YZBV6IfSdw0UBneeh4glcOOX2N8KLT3Tr85eNe8C9FXBQXa
   A==;
X-IronPort-AV: E=Sophos;i="5.99,281,1677513600"; 
   d="scan'208";a="230910875"
Received: from mail-dm6nam04lp2046.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.46])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2023 18:02:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCsmTWj5aQkL++OtVjaaixkpDyM1LN+t6kInK7kTimEuAAE4NpegLDalpjTsJeLVOeZeSjvLhWWu1PzvgqK0cuGC0HWY/7JgdayME/l+Uov4Bpp6iHGHbnyV/Eggqmw4OJOKav6P8Q8l3GVwQiGh+F4S83m7kVMNToBnInHPp0dS7lHbXNIkt1IOEu9xEpcogKkl5vHIO+/RerP+Ca5C9uFgO0VrM3zfwgRvZGjvwcxdrZS/AEQFVriewgyNHOUSVUWWgc00bw6OX3eIfAXT3IuYq6xJHHGOxYznlkwd1DKryZN+ScvRofLNfEQ3DFZn9RztyJ2TjGglIelo0hpIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=J0hHBAhPbociE+kLQpjCYMKxLOnXv/lgQAgq6EOShPyPEiGHPGzy0hfHhpdnoakKs+0aFgMjQwp5/Zebwmhf34xB2CapZkYsyuzfPMLXAh+V89gScMfmsbEnrMofyGXKBGeUU3k9OpqaVMZHYQGexdkipiGI2sVyNvXDkke7uMqHjuHNlSvL/4tXygyQaqm6g+uhkWnCX1ZP/yCnupz5bL4EnE75l5KkbDcl1BeJbFauYAbI123AjuPS3jycN6ZXP8XgOQewIisL/CcITgodkv5ky1O+3YBoscv7pKLkjuH2nWvs6WLHToOoFq3k1Mdojit92eGMd/fNaIFO5R/rzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=mlHbsWbWIn3CjSyvalT/ThfWB/skn7ZrpJ/oYRdsDfHOErSpRqbFFMBz0HntKwz478G5AVvii30sJVqmG+YxTqhdA63oznR6ePs4d4yRvm0ZI2Lm1SSF3MEHHBMPt9FT8duE/675Gz0VXo01zuFjn9DY/Afz5Y+dbF2ZLW7Us1w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6851.namprd04.prod.outlook.com (2603:10b6:a03:220::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 10:02:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 10:02:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v5 04/11] block: Introduce blk_rq_is_seq_zoned_write()
Thread-Topic: [PATCH v5 04/11] block: Introduce blk_rq_is_seq_zoned_write()
Thread-Index: AQHZiEZ+RVuskXXAMEq9UXh/TgQAYq9ePOaA
Date:   Wed, 17 May 2023 10:02:46 +0000
Message-ID: <620bba4f-29ec-1d1f-7ea2-09d19f4297ab@wdc.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-5-bvanassche@acm.org>
In-Reply-To: <20230516223323.1383342-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6851:EE_
x-ms-office365-filtering-correlation-id: 2517da36-2ca6-4b45-14d3-08db56bddd4e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8rC0nS22c2qhDpErl4WqIdevzPPM5G7JmLXSDwGCImx4GbhfLndSB7ZW0bPM2TxoOj1/oT4TVmRjb4y5OkjJiiBGv1LL4pjZgvEUOgTQ58/WU3mugjFialY/sul17ZTy6W1Zx9t8/Ly/frDmg1I/eMmhHl6llF6jTO3lZV0Ry+DuVKvbCm5JJuBMPiPDGK/LrR6eab9KB6La5wQ1ItBJNpbn9XPSeWY68wOFAsL4dB6VJ0/AUEPITwfFLXWTHnZeg7xdIT4uUunBnTiaDV/OPe9Mpa4mie/tMKKRqrzdmaOk/3V0SJ2X0c7+9q7+bg5TLPHzyxUjnjv/UxDXM1VagPdgMRmKF4I88QhgGrlDA4IJqS8ynuK9vjfs9VDlq1r/w+DWK0/tI/ykf96LlJdLN+KcOJmmWX+55SZCbjgv6bcMuL69v5UXTmdq8O9N/DgT1jEHDScPnmsInQUXFLxXMK9hn2gWZWMDool4BeqoFMDx8jxsg75/nCE2VVkvkfoVPzwQZWUjHT/6gjHRDnR1IK/KeoVk6w350l6EUF2dFJ2pujitczTpiid90gEP+ZfgofGnvuMo1jRiUTRd9r7Wlb0e8HhuFBacBjA2PI/rrY9U8FpJe9VedLqcWU7nynmWB/+WRH65M+16ZhOQrNHbwIiY/A3pnQRh2+Gx0Uol0hJMjA75Tk+w8PAvM3pGAhNJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(31686004)(122000001)(82960400001)(558084003)(41300700001)(8676002)(2906002)(8936002)(36756003)(5660300002)(31696002)(86362001)(316002)(38070700005)(38100700002)(4326008)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(91956017)(4270600006)(6512007)(6506007)(186003)(19618925003)(478600001)(2616005)(54906003)(6486002)(71200400001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2JZQWFTcy9KTExSTS9KT2VHYUdsaUdxcEVTWEFvSU0wdlBGd2ZGNnJCaEZH?=
 =?utf-8?B?aGliYTl5Mkc0L25Ka2F1Z1RQbkV3b0YxbldQWVFyeUhOUG1IZ3FJU0dGODZk?=
 =?utf-8?B?b29KeUtkTVk2azZUR1lPWlFYVVBGRVY1TitVUWNyNHFBTHkwQ2J0Q3d6L3dZ?=
 =?utf-8?B?eTVYVnc2YnBHVDhBZXVLZW56N2x5L25hZUNQNE04bVdmK2NjeGFHejdnekxB?=
 =?utf-8?B?T2cxaEZUNkhwWE9PcjRWZFo1RFNTUi9VRHUwdUt6d2VkQVUwdHpGSldRZlgx?=
 =?utf-8?B?Kzl3RzVKMHRaNlRFeElNNVIyblNHYjd4blhkR1A3OHljWTZ4NWdtYzRuQzdX?=
 =?utf-8?B?VWgzbU9HOHRqREIyd1JuaFAxQzRmMDk5U3ZDWG14QW9qNktEVzhRQXI5Rkg5?=
 =?utf-8?B?SEhpVSsyeGxrL2tGVHFXZ01Jem45UHlSaUdWeW93dklSV3pRQSsrZFAwRlFw?=
 =?utf-8?B?OHVqckNDRmlRa0h4VU1aclhQTDFjNEg5ZkdNRW9tYTNsalhJNHJXUmxvaURG?=
 =?utf-8?B?K2R0QVZERTBGWXJGVWd4cDVNVnhkWHVNcEk0Y0FXRVcvNURCQVpLdzVWeHZO?=
 =?utf-8?B?RU4wd0ZjT2lzWC85clU4QVBuZGUzMENEYzkxMDZHbmRxelB6Q2IxSzc0dC9Z?=
 =?utf-8?B?RzlUR0kvSkppek1HVCtHZUZpd1ZUZncxTWtpUXFDbGpHN0c4VE9HNkI4UUkx?=
 =?utf-8?B?NDNqNXNpb1BOS093ZGpLV0xWdndqZjB3QWN3bTVFVFNENVhCdnZwbGdsbE5W?=
 =?utf-8?B?bGRrNS81aURtb20wcW05RE5vK1FhK20yS0M4L1NuM2JBWkRUa3Vrb0Z3U1hX?=
 =?utf-8?B?Q0RlU1FvMkozeTlFc0grQ2dDVGZEaVZLbndKVXlVM1hBWmZyam9GS2VDMDdM?=
 =?utf-8?B?TndSenJGUnViZHkwOXNJME15Qy8rN2RWV2Vpa0NhdWd3VFcxOTM5OCt6WVJK?=
 =?utf-8?B?MXc5Y08xME5xa0hQdzJQcmJaYjhjZnF4VHJpVjFwT05nN2Ezbm9YTnFSR2ds?=
 =?utf-8?B?RXdjMFNXM2d2SEdZUTJKalRZeExjSUx2N21CWm01bXpaUUxXZ3lKSlFQWTRk?=
 =?utf-8?B?ZlV2VncxZUZnRzUrMllNTVEwckdyR2h4S0tMVnFDZklxdHlwT2xhMTdKS284?=
 =?utf-8?B?QXpjelBRd2JFNWN1SkNpcEVaakVxa2ZURDJmaHN3djFiYW9RWFpINGZBc2VI?=
 =?utf-8?B?a0NKU1hqVTkwR0dpa3kwVkM0SXd6aXZrNjM1YkZpQWhjcnZvUVNqdXNwUDZp?=
 =?utf-8?B?WVA3MmR6eVhKV0NzMllQZ3BtRWtKVm1aSnl3VDRPS0J2QTUrVkt0dDVia1li?=
 =?utf-8?B?dlFRVVBOanlXUlQxYVc2Z3BDTHJOeVZBbWtZMmN5c0x4eFZhTVl3NnBFL0ky?=
 =?utf-8?B?Ui9wczIwZk53aEFPM0xFakEyMFZoSzM3cjJpVHB6TUI2V1BNL21rMC92NzNB?=
 =?utf-8?B?YURhOVNmN3ZqaHF2bGY2cnA4STFFYjVkRWJkdHo4dm5XWnc5TE5oNHVBeGRF?=
 =?utf-8?B?UnpLeERvRjZMeEljRDRWTkViZEtodFd4Z29IUTk1bm1ISnZRanJBRldabHVP?=
 =?utf-8?B?VDUzVlBzKzZ3T1gxNmdQNUREd0RnNCtEMmFUalhTMWYyZGVzZW9kb3ZlajJE?=
 =?utf-8?B?bEZMM0dlNGJhbXFXejFyOVJQNC9vNWlQNTMvK2RVQ0RoU3BlZy9VcFJLZWs1?=
 =?utf-8?B?eEhLbzdMSVFWcG1JYk9UM1d0NHM3YVhSOFFEeURPYjV3SHkxeWd4RTJQN1lZ?=
 =?utf-8?B?Z29uZ0J0bkpDUWxVYVZHMkZna3hwSWFRQUZiajBWVVlXV1g0Q1Z0TTRaRlRi?=
 =?utf-8?B?Q2RtYXpxaWRXdGhLcnBsSG1nV2NZQ2k1REJjejBOL3pKVG84MktmNjVtQzVq?=
 =?utf-8?B?SHRiVWY2M1BWcjlEbi9rN3UwMVhtaHJGM0IvUHB1QkpOS2pZL3RhWlFzeGw0?=
 =?utf-8?B?YVFac2QvUHVDZkswenZIc1hxYTdPbThob05CY2cyRmxJVWJsaDA3L2Jhc1FJ?=
 =?utf-8?B?MHJIOHlZMkdaZFVYZzY4OEF2UVEvTndHeGZMd1kwTWpSSzkzZ1czZDU5NEZi?=
 =?utf-8?B?VG5nMGVjTUFlQVF0cG9TeE4wQ1ZzSDY2blpvdUgvRytBU0JRQUxHZ2lYQ3Ur?=
 =?utf-8?B?RkZlangyNCtWN2ZHTzl1VXlSWnRzOG1iRTFvNEI4OWR4RnJOd1RhbEE5VmE4?=
 =?utf-8?B?YXg1czRkMHg5b2VOUVU1R003bnRWamswMWlhQUMyckgyU3REQmhtVkFuTXRI?=
 =?utf-8?B?QVo1cHBxbXhVU1lSZU54V2ppaDNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A257E4131F3A247B29A09D8DBB0BB94@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lb9wDDnOOHdYCpFcneHlqRF8U80CXuuL7MUGBP6ddycSlYOqWDnyiA5nTi9dUoYTHzH187cT86aXzk8V2SKvjHnr2ed0TGRD7iUfdbXuCJtLsmAfbI/ONpkKZawqbdFt7NNDthvT6ssgEmTqP1gxJt5mCT9DILtY+QDwEZcoe+j4/FptGaV5+/Ak5DWLMkq+60KuDpYK8eSt5KpzSlvS1r/8okwLlArTkbrlx9XY6iftUH0WAeSdENIUoavTFjnUkZI2h3kb1NZxETHjR9p7YwrJvr+xtPBhiMgrGTXL7sQUeFmo0lvsUZZsjK+VpGG/eDPlLz9+KCCAMkjqN0ivHjsJ8zp+zxetaP18wcg1yFtixGd9hjHi3e+z2v7I5UJsgCQ4sPALsMAIVQXTqDp74Hbwx7+bZ/ChMUHofga/ofTF/QqNeEW8LOhscTPh8sEEQs1U1z4jsGSgc4We/HN/K6cKftAxNAM29VBvL2qk4PBVhQKvLM/utbQJHJuxr2yVwSFG5OZxnwIw4NNpoVcZUz3S1IzoHLwxHH6h7MYnsFtufMsGb9wnxPnYvSOqJsOjh2qfQWZAa4FS5y2rjMbfysS97hjr0meAebGtIPfyNes9pRUgHFQAQmBpPunNEoTP93g5Nhn84800FxYR0etF5U/Lx9pZrrOREj+Ay1EEq766ES2gsPMRzxBZ7fs1gqP8EM2p3unmhPAlMpPjUxFVhlSOVHEiourg1kyd6ZcqQXClgZ7kiNO9bJ4dd2ULN0i6BQaqYGQgBicI4/X/p2DyFY7yV094T5rFXjBBFF/V+Kf47MnS7868ZyBoW9JjMEb5748vCZk2lQfWSrWQVMBtWSl6iz2a8Oa9Bl/6kObqf/eknAlmymookzSwc91PKInb2v7Z262yePmlcd3+RNYIew==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2517da36-2ca6-4b45-14d3-08db56bddd4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 10:02:46.4197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2ndDbQdpd7q91xwSbzMgSbWfvOfy0qeGNvQLqgqFSMpNYhEq2ylGChVVoKzTDPS89oAs7P7mplXKdHOBjdAVjFyrgLRxjUYE4qLFp8ja9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6851
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
