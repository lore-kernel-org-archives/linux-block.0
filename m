Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518FEC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 21:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiDRV44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 17:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiDRV4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 17:56:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C2410FD6
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 14:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOHTvDoMlak5XHISkzy6kO1qySpfkrBfP2eeFWSiP7N0VoDCmpkEVoUj9PUMRZRF9abe1FKlOmalWvt7Ok6zW4N0jJOLySGpDg3ramoGnDMZgX99Ib/6bic95VbdpyVndVFVJjUtMlZ1aA3kvxjwEtIzRZtdC4U7agjVJxtli1o7z3co3soDyGS0y+qBMqUQhzPXqeqy0Kcmi/FIEXDic2TsuEyRtOQNiIL3JSlg1n/cMU2FXXO4vyeOvoSNN+kDhU6JzsWxDcKilMkIVvcVNH0PitSPkJzUhxcLD4luGDVj8j501UARBaCHnU2qXYQwfQ52JnVsP6LUSP7/uIeixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nh4m8y0CzD6dunweUAvuiirjfwKFv/BcMLknQk+OOso=;
 b=mV7nzixp9l6dS8pvVdO+/L/m0ktobA9ZC4tttEW2i2dYrcTlYefCOrEii5u5skiObg4I8MjhI2TfAqoXBF+3X4dpaUBkhNNPbOx9uaNjLUSO71VV+7nokNA6SY8Tf/LeaVDa2DDW/DxpwBFLDJZ6190kZAJ5L+L9p8nHQI1h3K4BriXZKJtEn7iU/TjtKlTelW3fm1QOUHrOl04Vgm16tipNzcq4Wzbn7o5rrMLwPaHapNlPg63ehrmUvjM3BuSm6iMI2F9A2USBBNPqsScd0cx8/9bfKluO+1+0f+BlEyh61dfUirna93Hc4IGsoVbzPm77UCUdj1Grt2UIBufaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nh4m8y0CzD6dunweUAvuiirjfwKFv/BcMLknQk+OOso=;
 b=GkN9we6DSVRoRCyJEZG8xDJcYIERtVDe5I32guBZmLP6WAo0eRL1QIdihLfNnNG94N47w1wfXhFBKb/W9J/K80eP6yxfMI3zM2lnbjPdReYKZngi9ZNY5cIsL8eYiO1+FgogcwZRKveECVOMu9V8l1qgLVDmFgeK4MiC1G7qzvMlK4c1OMZOH14msmkcPv7W5seM5Hj1oB+Ta3ThHIWy7yWN6lEUsUzC+Dq60++KMvx7aOco9aBptZ1J0GI+mSYXnSrbBxvmq1t9P//0qbRfOlGONKtT+OU5+rvPvX8vICqFHFb8x2+TUQ/SCXkjsL6juIklvtXd56lDN247OMA7Nw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 21:54:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 21:54:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: Nullblk configfs oddities
Thread-Topic: Nullblk configfs oddities
Thread-Index: AQHYU2ydI4s+Wsq5v0O87IRvshUvLqz2NtQA
Date:   Mon, 18 Apr 2022 21:54:12 +0000
Message-ID: <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
References: <Yl3aQQtPQvkskXcP@localhost.localdomain>
In-Reply-To: <Yl3aQQtPQvkskXcP@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb4643fe-5dcf-4fcb-2398-08da2185f9a1
x-ms-traffictypediagnostic: DM6PR12MB4107:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4107757B7F98F41BD53818F9A3F39@DM6PR12MB4107.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4hB+8maQuJ0KTCsfNCQlnk2Zf+fL5/yNTojfySekNRCgUWvQxw3AKFB6vIANe/ZnUxHxyQ8DJ6/CDNRCTpOrh5dqJSUNDEAlX13dX3prM6DSpvwMQPXLK3cAjWYBQDsWUxHYNXi4byVPHd82fdJdxO/pJgVf9XnoyYLnwGlfD2BxUlHDHSpWF+lw5Uhch2MV56g8VlXVUdUze0/+fq/6fU+cS5V5gkXUSlZqCpCJY2xTuuocjdBPdKVnWPbjPXdMepiYdLqWlnm20E1423rgkJKbN++F1U0sI3yH+omN/BKVaSa68mTvEyvr3dN+iGskhwXTSLE14WZ1GH3PTpJgLyCfrnwzjv5w2yUnBgne6zfaw4O75ucfHgXbqvP0R5tu8LAGuZXh4LGsYETfSrj/u79qpNJSwMwxmsAN1Cr8tjXUDnANBXJciAx5TUIR/T1rLpNAsT7lhTTiESvwBPPnzHszFUyIyBYFhVHUZfhPK06pg38T5zA+3dBiTe6mpayln0IpGEZdLn34Dh5OBn3vBJq8Nt6EMp/jj73iO9KXMMkUYxJqCQjdLG3h2MgD/qkTrIiqZXuzBxV0aLzc2JwYKwHPaw+e+NFSKsY6om0QJl7cWBlVsRJ8IFsWtrodNGrGS30Fg1DpXDesnmxh6gVVyiIMFIl24WpE5ave3I8mHMhJWdzvxD2aPHZCOp61d0CSrBCzgMzoyysYFwzBVh4NE8stl/57L53lxIE6KAivTAR27VDYpUZ2ViGeGOnBm01cIz1HTJjrAmc8m49STIw9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(66946007)(83380400001)(53546011)(86362001)(5660300002)(66446008)(8676002)(64756008)(2616005)(76116006)(54906003)(36756003)(66476007)(91956017)(186003)(71200400001)(3480700007)(2906002)(316002)(6486002)(508600001)(31696002)(6512007)(7116003)(6916009)(122000001)(6506007)(31686004)(38070700005)(38100700002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG9Na1VTWFV3NE41TGJNaDF1VFN4dzhFdWNjckk1ZU92WWJFVHd2UGNCb0gz?=
 =?utf-8?B?NmdHOUdVMHpMYVpNU1pQZnM5VGNDaEhtb1RqUTFCZWk3VmNHWkNCQzBDNjRY?=
 =?utf-8?B?WS9RemZQUmgyMEpyZUwrWmlPUlVHbGd6NnIxN1pQYUNQQmdkRVNNTWNCeU03?=
 =?utf-8?B?Mk9XUWdWOUVGK29sakxqcDZqZWZIY1VLZ3MwUVRzdUc0aFl2cmNRRlBEeFdK?=
 =?utf-8?B?WUxyYzNjRXBoM2NzZ2p1d0V1THczTmVrUk51bWZsdGh6TFVPU09uUFpvMXJ5?=
 =?utf-8?B?UTRYeXRNNlhmOXEzRVdtTVExRGMxSGlac1cwQjRMMU5GbklhQXBBZlNyYU1v?=
 =?utf-8?B?WnFqOVpIejdadEdua3I0M05DaWNPRGN6eU40bXFxWXhvalE1UjZadGdrMU5R?=
 =?utf-8?B?dmxFeElwTzdpYUhUdzIvdmhyRnlDY2VtaGZ1THJNT1VaSkpmTjhLeWphZkZh?=
 =?utf-8?B?ZEhXYVNjVVo3ZEtUM2UwckI3TmYySlEzQ0hPcXFEcVc4L3ZVQWN3OWk5Mk9B?=
 =?utf-8?B?N2JEdXpsL0VEVkw4TGVhMmt3ZFNBNk9tMnhpUnJSZFpYV2o4N1U5Q1BIY0Y3?=
 =?utf-8?B?Snh1OVgvaG5vNjdmMGdRU3FGY1B4VlZud1pZVFVwcXNYdmhtamlMV3g3YXQ5?=
 =?utf-8?B?Y1NnMWpBQU5iZ0pYd0oxM2F4ZENEYkZZZDFmRnJxakg0YzhWMGp3S0VHdHk0?=
 =?utf-8?B?cHJlcjRpK05wNS9KRW45VXczSThKbmc1clZYMWFQZlMzNkVWYWdQTmhMY1B3?=
 =?utf-8?B?TlFtUG1ubCt3M3ZTTW15cVczTHNkRzJkdkdnTVhOc3dFWDdnRHlqYWd4aU1B?=
 =?utf-8?B?L0cxdjZ1aVJ5Y3d2eGxtekhiajZuWjl4cmwzRkVqUjArdTBRWmFlQWtoMHk3?=
 =?utf-8?B?U0greUV1M2pyODY0b29tbjJtQm9GbWZLWGUxUzB4bTBRRUFoZTRLNDlTbFQx?=
 =?utf-8?B?Y2c3cmZBeGJkSTNXUkFMOUJMMlBwVGxaYzBYdlZMOXpuckVrT0JvcHFxRDlV?=
 =?utf-8?B?Z0tiNEtpaXFQZG43Mm91Y0lmamlSL1lIOHVONzh4VGt3NlVBYitnRm9oOWg1?=
 =?utf-8?B?YnNLTlM0WDBYYlFTeVgvV2ZUZ2xQYXVDdzBXaTNqL29sMllUcHpZUDlVK3dM?=
 =?utf-8?B?ZFU2K1ZGN2lkUHVSSXY1RXpRQXlRb1ZUM0xMUDFKZGFzUmlaT0MyWTdtRTVT?=
 =?utf-8?B?MUdEVzhLczMwSjJLT3pwdk5FdUFZeHJVMVFTcGZTa1RpYjEvTU5ibTV6WHB6?=
 =?utf-8?B?anYvVGM2WXpDS3orUjRqRHR6M1FyNGZlbjN1M0p5ZFVFNEdNOWk4NkZ1WkRx?=
 =?utf-8?B?VkxyU0ZYbDMyeHlYN1pWQ1MvSnVRZHVTalNibzJMVW80cTBLUldOSVNiVDly?=
 =?utf-8?B?azJscDQwSkRNcHZPdEtCOHB2c2RRMTBCdXcyMHZHRi9FaGlPTmFJaE1saWV0?=
 =?utf-8?B?UkNiN0d6RGVuRGRncnFxcVZ2bDNIWU8wYmk3V2NiTHNpYWZjTkN3MkJ6dWhi?=
 =?utf-8?B?eitjcDlNU2xJTFJPSm1KVWdPczl6cHlSczdUNmFJMm54UzFWcjZkMUdBeUJX?=
 =?utf-8?B?THNqdFVKRzJjZTFyanc2c1dIK21kdm4zY1BzNWRuTGZIVDFOd3Z2WlhJREYz?=
 =?utf-8?B?T3dlQ0tWb1dOZDlIdkNuS1V3T2haVGZyUXNuakh0YXlpY0Z1UnM5VUJzWGpO?=
 =?utf-8?B?TzNNUVdUZStncUZrNGs4UUJ1SUFRemZXb29oYWpyNEFYSHMzMzYyZHNteCtH?=
 =?utf-8?B?MWpxNmoxTHRWbnVqQlJ6MHRqT0hLOVg0TTNYWFBCbTZOVkdXdkZVWno0TmEz?=
 =?utf-8?B?aXFBbUxKdXZJV2RLZnloaDBxd0VlK1RXSEJEWGJvajNkZE9CeFRybE1STEE4?=
 =?utf-8?B?ZUpKb3Z5V095MFJQcGUxdTVFcVA3dEd5SEVJU3lWR3pRSzlucHhXWVk0dTJD?=
 =?utf-8?B?WnpQQjZoMGM2ckpyL3Q0RUYzSGYvcTlLMXVVVlhhZnpPNnh6TVd0em1kOExG?=
 =?utf-8?B?Y2dFK2RoSFZtOTdMeFZpNmt3RjAxbjBvWXF2clMrcC9zZkM4Qy9hN1JJU1NU?=
 =?utf-8?B?YjFINnFxekxwaW8xaXlNOGpQT2tRcEpiaHQwRnQxZFFsZExSWnBhaXpzMXRa?=
 =?utf-8?B?Tlk1bjRhT0RONTNCa01Ob3NSSm9BWC96c21reEQrR21zL1ZIcEZTQWJxQ0ZW?=
 =?utf-8?B?Q1Q0ZFMrUjFxc3d3NkpoRUlaZ3lGVzJza0ZLckhTb3czck1yWVVEWVUrTVNJ?=
 =?utf-8?B?T3ZjbXIySHBDaFY5ck54TDA4VXduY0ZLUnllMGg0MlJ4T05vOVQ5OFB5TmtX?=
 =?utf-8?B?OCttY1kzVlFYeUc2bko4TzJ0TzVYV2ZPditGVFk5a1prOVdFb0dyZG1MWlFE?=
 =?utf-8?Q?Ry2D+y3w7txpYs0w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B29E1E19BD0C884BA0D2C7AC0B025F54@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4643fe-5dcf-4fcb-2398-08da2185f9a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 21:54:12.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ccB92xQH0M3eG9qBvVwSJNe55RIbbhcQVQ4S5RXFDNZN4ThrN5zcetInsuJUe2c94rpsK3vCUkjwf1B2wREJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xOC8yMiAxNDozOCwgSm9zZWYgQmFjaWsgd3JvdGU6DQo+IEhlbGxvLA0KPiANCj4gSSdt
IHRyeWluZyB0byBhZGQgYSB0ZXN0IHRvIGZzcGVyZiBhbmQgaXQgcmVxdWlyZXMgdGhlIHVzZSBv
ZiBudWxsYmxrLiAgSSdtDQo+IHRyeWluZyB0byB1c2UgdGhlIGNvbmZpZ2ZzIHRoaW5nLCBhbmQg
aXQncyBkb2luZyBzb21lIG9kZCB0aGluZ3MuICBNeSBiYXNpYw0KPiByZXByb2R1Y2VyIGlzDQo+
IA0KPiBtb2Rwcm9iZSBudWxsX2Jsaw0KPiBta2RpciAvc3lzL2tlcm5lbC9jb25maWcvbnVsbGIv
bnVsbGIwDQo+IGVjaG8gc29tZSBzaGl0IGludG8gdGhlIGNvbmZpZw0KPiBlY2hvIDEgPiAvc3lz
L2tlcm5lbC9jb25maWcvbnVsbGIvbnVsbGIwL3Bvd2VyDQo+IA0KPiBOb3cgbnVsbF9ibGsgYXBw
YXJlbnRseSBkZWZhdWx0cyB0byBucl9kZXZpY2VzID09IDEsIHNvIGl0IGNyZWF0ZXMgbnVsbGIw
IG9uDQo+IG1vZHByb2JlLiAgQnV0IHRoaXMgZG9lc24ndCBzaG93IHVwIGluIHRoZSBjb25maWdm
cyBkaXJlY3RvcnkuICBUaGVyZSdzIG5vIHdheQ0KPiB0byBmaW5kIHRoaXMgb3V0IHVudGlsIHdo
ZW4gSSB0cnkgdG8gbWtmcyBteSBudWxsYjAgYW5kIGl0IGRvZXNuJ3Qgd29yay4gIFRoZQ0KPiBh
Ym92ZSBzdGVwcyBnZXRzIG15IGRldmljZSBjcmVhdGVkIGF0IC9kZXYvbnVsbGIxLCBidXQgdGhl
cmUncyBubyBhY3R1YWwgd2F5IHRvDQo+IGZpZ3VyZSBvdXQgdGhhdCdzIHdoYXQgaGFwcGVuZWQu
ICBJZiBJIGRvIHNvbWV0aGluZyBsaWtlDQo+IC9zeXMva2VybmVsL2NvbmZpZy9udWxsYi9udWxs
YmZzcGVyZiBJIHN0aWxsIGp1c3QgZ2V0IG51bGxiPG51bWJlcj4sIEkgZG9uJ3QgZ2V0DQo+IG15
IGZhbmN5IG5hbWUuDQo+IA0KDQp3aGVuIHlvdSBsb2FkIG1vZHVsZSB3aXRoIGRlZmF1bHQgbW9k
dWxlIHBhcmFtZXRlciBpdCB3aWxsIGNyZWF0ZSBhIA0KZGVmYXVsdCBkZXZpY2Ugd2l0aCBubyBt
ZW1vcnkgYmFja2VkIG1vZGUsIHRoYXQgd2lsbCBub3QgYmUgdmlzaWJsZSBpbiANCnRoZSBjb25m
aWdmcy4NCg0KU28geW91IG5lZWQgdG8gbG9hZCB0aGUgbW9kdWxlIHdpdGggbnJfZGV2aWNlcz0w
IHRoYXQgd2lsbCBwcmV2ZW50IHRoZSANCm51bGxfYmxrIHRvIGNyZWF0ZSB0aGUgZGVmYXVsdCBk
ZXZpY2Ugd2hpY2ggaXMgbm90IG1lbW9yeSBiYWNrZWQgYW5kIG5vdCANCnByZXNlbnQgaW4gdGhl
IGNvbmZpZ2ZzOi0NCg0KbGludXgtYmxvY2sgKGZvci1uZXh0KSAjIG1vZHByb2JlIG51bGxfYmxr
DQpsaW51eC1ibG9jayAoZm9yLW5leHQpICMgbHNibGsNCk5BTUUgICAgTUFKOk1JTiBSTSAgU0la
RSBSTyBUWVBFIE1PVU5UUE9JTlQNCnNkYSAgICAgICA4OjAgICAgMCAgIDUwRyAgMCBkaXNrDQri
lJzilIBzZGExICAgIDg6MSAgICAwICAgIDFHICAwIHBhcnQgL2Jvb3QNCuKUlOKUgHNkYTIgICAg
ODoyICAgIDAgICA0OUcgIDAgcGFydCAvaG9tZQ0Kc2RiICAgICAgIDg6MTYgICAwICAxMDBHICAw
IGRpc2sgL21udC9kYXRhDQpzcjAgICAgICAxMTowICAgIDEgMTAyNE0gIDAgcm9tDQpudWxsYjAg
IDI1MDowICAgIDAgIDI1MEcgIDAgZGlzayA8LS0tLS0tLS0tLS0tLS0tLS0tLQ0KenJhbTAgICAy
NTE6MCAgICAwICAgIDhHICAwIGRpc2sgW1NXQVBdDQp2ZGEgICAgIDI1MjowICAgIDAgIDUxMk0g
IDAgZGlzaw0KbnZtZTBuMSAyNTk6MCAgICAwICAgIDFHICAwIGRpc2sNCmxpbnV4LWJsb2NrIChm
b3ItbmV4dCkgIyB0cmVlIGNvbmZpZw0KY29uZmlnDQrilJTilIDilIAgbnVsbGINCiAgICAg4pSU
4pSA4pSAIGZlYXR1cmVzDQoNCjEgZGlyZWN0b3J5LCAxIGZpbGUNCmxpbnV4LWJsb2NrIChmb3It
bmV4dCkgIyBtb2Rwcm9iZSAgLXIgbnVsbF9ibGsNCmxpbnV4LWJsb2NrIChmb3ItbmV4dCkgIyBt
b2Rwcm9iZSBudWxsX2JsayBucl9kZXZpY2VzPTANCmxpbnV4LWJsb2NrIChmb3ItbmV4dCkgIyBs
c2Jsaw0KTkFNRSAgICBNQUo6TUlOIFJNICBTSVpFIFJPIFRZUEUgTU9VTlRQT0lOVA0Kc2RhICAg
ICAgIDg6MCAgICAwICAgNTBHICAwIGRpc2sNCuKUnOKUgHNkYTEgICAgODoxICAgIDAgICAgMUcg
IDAgcGFydCAvYm9vdA0K4pSU4pSAc2RhMiAgICA4OjIgICAgMCAgIDQ5RyAgMCBwYXJ0IC9ob21l
DQpzZGIgICAgICAgODoxNiAgIDAgIDEwMEcgIDAgZGlzayAvbW50L2RhdGENCnNyMCAgICAgIDEx
OjAgICAgMSAxMDI0TSAgMCByb20NCnpyYW0wICAgMjUxOjAgICAgMCAgICA4RyAgMCBkaXNrIFtT
V0FQXQ0KdmRhICAgICAyNTI6MCAgICAwICA1MTJNICAwIGRpc2sNCm52bWUwbjEgMjU5OjAgICAg
MCAgICAxRyAgMCBkaXNrDQpsaW51eC1ibG9jayAoZm9yLW5leHQpICMgdHJlZSBjb25maWcNCmNv
bmZpZw0K4pSU4pSA4pSAIG51bGxiDQogICAgIOKUlOKUgOKUgCBmZWF0dXJlcw0KDQoxIGRpcmVj
dG9yeSwgMSBmaWxlDQpsaW51eC1ibG9jayAoZm9yLW5leHQpICMNCg0KLWNrDQoNCg==
