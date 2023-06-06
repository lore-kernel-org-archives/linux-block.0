Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70934C7EE24
	for <linux-block@archiver.kernel.org>; Tue,  6 Jun 2023 05:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjFFFWw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jun 2023 01:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFFFWv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2023 01:22:51 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FBB18E
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 22:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1686028969; x=1717564969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+L/FpCPVzbK6qBLEICLThks8VKLhthp8XEejQc/InNU=;
  b=Ek63QCX260H/zyn+XqwKESa6WjxMCARlVJTLqzxRUbvAn3WT5WWOOrhU
   JLxEIIanlVqDEnMY33JL4rGRsCB9ggcD7jNOts04+WdyjGqCsnnAH5wvA
   pgT8saAvWJRiQt5OtVfIqoKhSi3KfELgppqlC4tJQrDg2huh3Vl/Sc6C3
   Yt5wczFaIRdo4dIQdo/Bk0jtfu+XL8QIvUCPf4+f9fmThSUbP16l1mgH4
   G8jonge8M46WYTEVxSLzlSdXaKGCUP86WpL8BKU3/PFSriaHbrv8hsWZl
   f39IL3kNgFjj7HxmAosBPeFCn2buHNwXrA3SoT8nm18F04nyuzEvzekwW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="86518470"
X-IronPort-AV: E=Sophos;i="6.00,219,1681138800"; 
   d="scan'208";a="86518470"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 14:22:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9vPDjhDKLvfZNLRPEdas73BIPHQYrBU0nzHwbUoMb3t3iaRUu6g+XMhYtagxaIAAHagZ8KyKw7h2Zr9vearc4R7ol6WQvQqHstVbOHj4v56ssDzXCCoHdWT5d/OFQBfyOsw0jaMgVC/fY0pUx0CpynwpqOtM5haRpCbhwYGnY1zKp1AFwPCyd/TJkqTQNrkBE90H8BL7igfwcWLhfd387yREXefLODVbr8oi+G7fyP13fDQ2V45dU3+1uhk69y1UrX+SDmClbWEX3CgOiAPPrqDsvXadTwNoG7jWNIkKUhlChoR+lsjUoFhiGaC2ZI3QlBQJhDf01g533wKNjDtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+L/FpCPVzbK6qBLEICLThks8VKLhthp8XEejQc/InNU=;
 b=h/GHIeKnyRKtNXEf6E0q5Ig4F2PU9rZHiWmVkdFya9lWtvDYlzMLfP1rqKLFUJHRXpcIzp1hsj47rZaa/NrmiAi8DUvwL6MkKUWnyQwE2H+3VJq71ReGr2Fsg9bWbQ/+doH9/bM6/1BC7nWLqgGT54lEKR7uzwEtazM4zmINFsdjTmYyXpDsaZQQ0C98xC5FBmS2j62Wt8L1mBC9yZKgyofPn2NmhLYffkf4/oOoBlQLAgsn+4QTtKWTfWjdgO93Lm+prfI2+nQTyq1PkEJQrePVRMaZKq++zsLxcRoyUGfUOHNv0/TGKSr0X6atweWZJMyh7/7XpXxG8dDMYQJuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYCPR01MB8039.jpnprd01.prod.outlook.com (2603:1096:400:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Tue, 6 Jun
 2023 05:22:43 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 05:22:43 +0000
From:   "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Topic: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Index: AQHZk1w4K9fdnrSfKEGv7XiKzcYEoq9z3PsAgAkERYCAAEOxAIAAH9EAgAACWoA=
Date:   Tue, 6 Jun 2023 05:22:43 +0000
Message-ID: <cbcafb8d-00e9-a94a-1507-a6f57d20d8fe@fujitsu.com>
References: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
 <446c46d8-fbc7-ecd2-8efa-1c9497e16851@grimberg.me>
 <eadb2514-f06d-7cb2-2cdb-04a6226edac8@nvidia.com>
 <2hx4a7yzh2edtegsrgt5pfjqfr6b3ysq4dxws5cchkmubnn7za@f5qg2sncndrv>
In-Reply-To: <2hx4a7yzh2edtegsrgt5pfjqfr6b3ysq4dxws5cchkmubnn7za@f5qg2sncndrv>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYCPR01MB8039:EE_
x-ms-office365-filtering-correlation-id: 81b64196-e89d-4a3c-309a-08db664e0e00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /XDgmx4taA6xiMrH64sYYB+R8hKLdFRpVmMlnOnUHxvfYXRapnrZ2ZHp6V90A5GbQLv/ioOUGpQJt4+ao8mJyVkv8kriYpWAu1MiJ5Qj2nOaQH5JqYrAQd/29PcjIFT2nvBDlYlFsvvH1TQmdki7JSVCRPLcgLz8QqkCIyyfgaS/40YPcycaClUUiB5GHVYhi9Ocq7hRXZSflXj0DnyFQk5owxyPblw+qGK5woSNYflUUcaOgTr6OirLo35b0OhFF20259wEaCqYo+SFB8434tjkVd1L6Dr5mALLAYGrzjuYJ9+tCAImKp+WVRvEYsYkc04Hur8/9XEUqqeqNqoaH9OsvAj889I3kX6a0pq7b+vpbB1NcMRJl2WQQ3obbM1NjwHR5AAiCAt/J3ZYXtZYPPc5lPiSyKAiqbJ7Xt1dEdjWD06Gyxs/bwRU2YmyQE8SEJnCHIHG7An1i3n2d5+bD/JoV2/kRIaF3b+CQ23GX+zpmBtB1ylEvilnlISCsFQTqHoAPj1bRP2QjarkoffZLqA+wkLtJB9SC+SunVSyql+nRhBeY9Api3wreG1bkQay2Bf0EET5N/K6+LJ51LkV8zabfm0NQw+PFH4eLVnc8vvBybQfR115O4+7d/HW75hDTWAzpUWMwZ7NmyTV7b+kJnGzWkrNKsCLlcdFc11p96g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10725.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(1590799018)(83380400001)(38070700005)(85182001)(36756003)(86362001)(31696002)(122000001)(38100700002)(82960400001)(478600001)(6486002)(71200400001)(2906002)(4326008)(91956017)(66476007)(64756008)(31686004)(66556008)(54906003)(316002)(66446008)(110136005)(5660300002)(41300700001)(8936002)(8676002)(2616005)(1580799015)(186003)(66946007)(76116006)(53546011)(6512007)(26005)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkRVQmV2bEZFR1Y5SThtZnJJcDNXbi9JNUhWeXNVRTBOZW45d2NpcjJIZWlH?=
 =?utf-8?B?SEJnN2pEeFFQbXNGNGNvZGFzcFFFQjAxN3kxWERJOWVGZEFVYmU4WjF3WVFU?=
 =?utf-8?B?V1dnWUVQWUI3eXNQWER6QlUzRGNKcGdFLzZpZnBhQ2tFSmQ5YmRUaW5qd2FY?=
 =?utf-8?B?MmJXMG5xMFpBUS90QlBKQ2tBWi9VL3QzeGh6U0xvenJGcDd0SkZySnJCcGph?=
 =?utf-8?B?bkFPR01oSjZtRG4vcHh3OEQ4SmJLdnJqUFIrSkVmWXZrTlc2UWFDQjIxWjV6?=
 =?utf-8?B?dHFLZUZETTc4a2I5bnJMWFptb0E5NlJUbTZidXdxbnVtTmthcU9zK1pDMnFD?=
 =?utf-8?B?QURCWlNkYjFWOWZwOW5mYksrUkhFeXVrZExSS0NiYlYwazFzVWFxTU1zZXJo?=
 =?utf-8?B?U015anUxTXlCb05DQzJFb3lHN1JCSzVPUUNXZmw0b2xYNk1ydVJ3dEFGQW1a?=
 =?utf-8?B?c0ZzMSsyVzRJWXFtcTVBdEpHR0JQWmRlMCtWUkNqMHBnVWdQb1BqVlV3V215?=
 =?utf-8?B?ZVh3WENrN2VmUzlXeS9URTUxTzhHdjUxTGdZZTd1ZkxkSE0xT0ZWTURsSUV4?=
 =?utf-8?B?amNGaTFnTEx3Q0xjYVZYaTFZdVBRRDUvMGkxM0w4Ym5FeTRKWU42bGpyRndL?=
 =?utf-8?B?Z1V5M21CRU1RUHRocFlsNlBoQmtaTWZjRjRIV0ViNk9NS0tyQWxyZ2pYSmoy?=
 =?utf-8?B?QUJ4N3BwbFYzcTBLMVViVjkraVA2THVRNjdXUXNGa2NEZXQ3VitPZ0VWdWRD?=
 =?utf-8?B?WFlMQ21ZYytxS3VmVWdzMXFnN25HMStUbmV0MitBNGR3Sjh0MWJWQ1MzQkRP?=
 =?utf-8?B?QjVQYU1tUFBLcHJLS1NobDdWZ3VlRFFkM05FOCttVEQ5MEN2TTdsbXZqR3Ir?=
 =?utf-8?B?ZmNXK25uSzNWejQyK003OVBFUDcyMUEwL2pvNEgrano2MDBtYUNwWW9mRGhO?=
 =?utf-8?B?U2pFMm9rTEl0aFd5NVp1TjlZc0V0eHRRWWdsMDByNGxlK2c1c2d2SXdaNFRT?=
 =?utf-8?B?THpqZjBJdVVtdDhDenVaTUJGQ2lCNndZRm1DWGV0TGwydThxeVIyK1hpTjdY?=
 =?utf-8?B?Nmx0cGo5ejVNZXoyRlVGRzhtR2RDMkxDYUVtN2w2ZHB5dHloZjNFeFdOUXYx?=
 =?utf-8?B?Q0ZxMmVNcXRsWldJNUd0M3orcEQzMndJc3lkMThub0JqUHNEWFRPM1VUTTla?=
 =?utf-8?B?MUR1NHdNa0ZwL0RJbTBYNXI1RENXTFBBYUtHOEsyM1QyenFMWCtsMk5vNUVH?=
 =?utf-8?B?R2xkZWlEQ0VuTnBqUmJWNkNYcVhpdGd6YmIxREd2MmhOMVhsMEdORlRrN3VP?=
 =?utf-8?B?d0FaTUwrZ1hKNXpPS3ZkSk5Lbm4zcUVJUzNReFdyZEh3b0VNWm9SQXRyVDdT?=
 =?utf-8?B?V2tkTkNtMUlhK1ZJaTVHbGpCejZIVGp3YUVsREtpbFpGQzcwT3ZUZ0N3amNm?=
 =?utf-8?B?bm54WisxTnowVkUxVm9DeGZyMnRoT1JRbU5ESi9xeW8rMEkrSVZ4UkZheFJB?=
 =?utf-8?B?bmY1OXNoZnphVmpMVjZNVWVkUDB2M3B2Q1hSbTRORmlIa2N4YXlGeVNjbnZE?=
 =?utf-8?B?alltNFdKZW50T3VNMlRzZGtUV1hrTWpmMzk5UzhmZ1BvdWFTc1AzYTJBTFFN?=
 =?utf-8?B?L3k5S3BZR2owR2ZhWG9zRDA4NUJNVzAzRDRMVE1OVGVhY1AyUzV3dTJjQmI5?=
 =?utf-8?B?bGYrcXVkc0RZaDFYb2VPaEJHNU83NFhianJ6eUl1eDJ1WVNKWFFmaXVNSHg1?=
 =?utf-8?B?ajhjWm9UOStrQjhGeWp4SXJKYTI2ajVwcHBydTdHZlJXbG9GSWlWWm82cGFB?=
 =?utf-8?B?VXRTTll4WXVvVWsrY050YXVyS2ZuQVZPY3FZcEp0UytoaEpHYXZOV2dvVlkr?=
 =?utf-8?B?b3RvZ2xoZ0NDNlpuNDNZWS9YSzZTZCtyUVIxM0dPL3BsVU0yUVJrL2hRRFJ5?=
 =?utf-8?B?cTkwZVl5Szd1dFhwS2NPMWtQek5xSnBSM0NEcEVPcUxsSXlDU0ZwWXFDZGJz?=
 =?utf-8?B?cFdSNWo1RWw3TnE1dlhua3lUa1ZGazRxdHAzWU9KWGMvSnR5T2ZoNENPS2Yz?=
 =?utf-8?B?WWEyeFUyWDhlRVFDWFNTNGYrYjB5QUlPVlVjQllHS2YyT2VTUmh1dVRhZm1D?=
 =?utf-8?B?VDQwZkx0enFDKzB5OVo5UGdaWlVLeWx2MHZEM2hERTlvbWpnNzRVU3cvckRw?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E43381CDBD1664C83B6530E6EC28003@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iLL9JYuqJFsId0/gmKcmNSIiHqUCAQ2/+ApOeqlixYgQ4mLRrZnnACSyWnIlRcXDbpbQws5Vd9QFU+OKf2Pch8r6layNf/aq+79KP19KbxUmLW+D8ZWH3Djy0EQI6Vmni0tsjIEnOjHQHuFEVyBFRnJP5gDcwISWi/kgoa2KPluOqUxZzz0aNLlxTVwfyJSpPBBXYGz2Ci0KZmpNZI9lhcZ1gySukmrjveBBFeVdzqkFlBHW+xxiyUO/OcNsJtJ2hktXBlu2g62surgwiaNUhuC4a8OnD8CR0JXY2d2xZnXCabXMi06G17EvFCOmRnFW1AriyDz4Nom7N+1X/QtS4JTfglb+bB6DW+R4CK1O5g+5kxsutjsdvGrUktEm4rvCr+qY9vt7iV7oM6a2jEtIEvDT7PSuxCh7q9Zhttezuf8FITRVcCDrMMax8L2QSsM9aHSA0Tl6fYgXP2tPY9EBV4Eo4jdZp7RngfZz8+tAalc3XgrhhjUwZzPLclJV0hm78S3fDMS1WeBG6h+H6bVkpUJbCuOXzE6V9y3gSlb3C8VSvRSSMF4DQxgn1JgHw8x2Qgm9EBN30vpNtTpOwxx+5dlDzg9Z1t3t7K+GfcGHaDzKErUxLCdaCOf+eFW06DwQHdqwAgGQuRnQZfzv1XgUiFOJRX8CxmfH+VHDld7Nb1n09C0/3/imAf5Sq/Dh6eVflTCsB1F6mdAhsaB2vJc0/MzurkC+mMusuM4RMunT5lOp4eef8F/5QCR1lRD5fo+Q/A5Z2zEVRGMXCCDnZ6KCFgQ75I9Ip0iZPGKbmF56U/9PImgKq5ub68pn27evUdIoqdPXBYTN4vHaXYsytaMyIp6bG7/7/HtNhqe8OTEGQ1x4i2SMEfr8sQALNOWZV1Inmf6H1s4sQTIqjSGvYjotPg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b64196-e89d-4a3c-309a-08db664e0e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 05:22:43.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nR2qyp+lroJ+ZH2p1VFnF6ddvskBSa7B3l88m7YfgLuVjZK/SJjOBqkuGXL8VciJQIsFxl3ApFHsbrol4J1sE+oGfk8rm5WSNv7IM02ZAys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8039
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCm9uIDIwMjMvMDYvMDYgMTM6MTQsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IE9u
IEp1biAwNiwgMjAyMyAvIDAzOjIwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBPbiA2
LzUvMjAyMyA0OjE4IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPj4+DQo+Pj4+IE9uIE1heSAz
MSwgMjAyMyAvIDA5OjA3LCBZYW5nIFh1IHdyb3RlOg0KPj4+Pj4gU2luY2UgY29tbWl0IDMyODk0
M2UzICgiVXBkYXRlIHRlc3RzIGZvciBkaXNjb3ZlcnkgbG9nIHBhZ2UgY2hhbmdlcyIpLA0KPj4+
Pj4gYmxrdGVzdHMgYWxzbyBpbmNsdWRlIHRoZSBkaXNjb3Zlcnkgc3Vic3lzdGVtIGl0c2VsZi4g
QnV0IGl0DQo+Pj4+PiB3aWxsIGxlYWQgdGhlc2UgY2FzZXMgZmFpbHMgb24gb2xkZXIgbnZtZS1j
bGkgc3lzdGVtLg0KPj4+Pg0KPj4+PiBUaGFua3MgZm9yIHRoaXMgcmVwb3J0LiBXaGF0IGlzIHRo
ZSBudm1lLWNsaSB2ZXJzaW9uIHdpdGggdGhlIGlzc3VlPw0KPj4+Pg0KPj4+Pj4NCj4+Pj4+IFRv
IGF2b2lkIHRoaXMsIGxpa2UgbnZtZS8wMDIsIHVzZSBfY2hlY2tfZ2VuY3RyIHRvIGNoZWNrIGlu
c3RlYWQgb2YNCj4+Pj4+IGNvbXBhcmluZyBtYW55IGRpc2NvdmVyeSBMb2cgRW50cnkgb3V0cHV0
Lg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVq
aXRzdS5jb20+DQo+Pj4+DQo+Pj4+IFRoZSBjaGFuZ2UgbG9va3MgZmluZSB0byBtZSwgYnV0IEkn
ZCB3YWl0IGZvciBjb21tZW50cyBieSBudm1lDQo+Pj4+IGRldmVsb3BlcnMuDQo+Pj4NCj4+PiBJ
J20gb2sgd2l0aCB0aGlzIGNoYW5nZSwgYnV0IElJUkMgQ2hhaXRhbnlhIHdhbnRlZCB0aGF0IHdl
IGtlZXAgY2hlY2tpbmcNCj4+PiB0aGUgZnVsbCBsb2ctcGFnZSBvdXRwdXQuLi4NCj4+DQo+PiB0
aGUgb3JpZ2luYWwgdGVzdGNhc2Ugd2FzIGRlc2lnbmVkIHRvIHZhbGlkYXRlIHRoZSBsb2cgcGFn
ZSBpbnRlcm5hbHMNCj4+IGFuZCAgdGhhdCBjb3JyZWN0bmVzcyBjYW5ub3QgYmUgZXN0YWJsaXNo
ZWQgd2l0aG91dCBsb29raW5nIGludG8gdGhlIGxvZw0KPj4gcGFnZS4NCj4+DQo+PiBidXQgZ2l2
ZW4gdGhhdCBob3cgbXVjaCBjaHVybiB0aGlzIGlzIGdlbmVyYXRpbmcgZXZleXRpbWUgc29tZXRo
aW5nDQo+PiBjaGFuZ2VzIGluIG52bWUtY2xpIG9yIGluIGtlcm5lbCBpbXBsZW1lbnRhdGlvbiBJ
J20gcmVhbGx5IHdvbmRlcmluZyBpcw0KPj4gdGhhdCB3b3J0aCBldmVyeW9uZSdzIHRpbWUgPw0K
Pj4NCj4+IFNhZ2kvU2hpbmljaGlybyBhbnkgdGhvdWdodHMgPw0KPiANCj4gSSBkb24ndCBoYXZl
IGZ1dHVyZSB2aWV3IGFib3V0IHRoZSBzdGFiaWxpdHkgb2YgdGhlIGxvZyBwYWdlLiBJIHdvdWxk
IGxpa2UgdG8NCj4gaGVhciBjYWxsIGJ5IFNhZ2kgYW5kL29yIG52bWUgZGV2ZWxvcGVycyBhYm91
dCBpdC4gSWYgd2UgZXhwZWN0IG1vcmUgbG9nIHBhZ2UNCj4gY2hhbmdlcywgWWFuZydzIGNoYW5n
ZSBpbiBibGt0ZXN0cyBzb3VuZHMgcmVhc29uYWJsZS4NCj4gDQo+IElmIHdlIGV4cGVjdCBubyBt
b3JlIGxvZyBwYWdlIGNoYW5nZXMgaW4gdGhlIGZ1dHVyZSwgd2UgY2FuIHRoaW5rIG9mIGFub3Ro
ZXINCj4gc29sdXRpb246IHNraXAgdGhlIHRlc3QgY2FzZXMgb24gb2xkZXIga2VybmVsIChvciBu
dm1lLWNsaSkuIEkgdGhpbmsgdGhlDQo+IGJsa3Rlc3RzIGNvbW1pdCAzMjg5NDNlMyAoIlVwZGF0
ZSB0ZXN0cyBmb3IgZGlzY292ZXJ5IGxvZyBwYWdlIGNoYW5nZXMiKQ0KPiBjb3JyZXNwb25kcyB0
byB0aGUga2VybmVsIGNvbW1pdCBlNWVhNDJmYWE3NzMgKCJudm1lOiBkaXNwbGF5IGNvcnJlY3Qg
c3Vic3lzdGVtDQo+IE5RTiIpLCBhcHBsaWVkIGluIHRoZSBrZXJuZWwgdmVyc2lvbiA1LjE2LiBT
byAiX2hhdmVfa3ZlciA1IDE2IiBmb3IgdGhlIHRlc3QNCj4gY2FzZXMgd2lsbCBhdm9pZCB0aGUg
ZmFpbHVyZSBZYW5nIG9ic2VydmVzLg0KPiANCj4gWWFuZywgbWF5IEkgY29uZmlybSB0aGUga2Vy
bmVsIHZlcnNpb24geW91IHVzZT8gSWYgeW91IHVzZSBSSEVMIDggYmFzZWQgT1MsIEkNCj4gdGhp
bmsgaXQgaXMgdjQuMTguDQoNClllcywgSSB1c2VkIFJIRUw4IGFuZCBkb24ndCBpbnRyb2R1Y2Ug
dGhpcyBrZXJuZWwgcGF0Y2guDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ==
