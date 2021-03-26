Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEB7C433DB
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 02:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC84061A3E
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 02:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhCZCK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 22:10:58 -0400
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:43747
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230022AbhCZCKc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 22:10:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmoVwbLnETAzJB71PUVWWlloZcNxoc75GBohyMbc9eGaeGe4i1aI44aRWPO2p3BizI7YsJDc8v7+o09X8s80CyHPJj9CfmKX+/6U3oehMZCAs7neoOUd0sYHriTAp+SRR4y+8Or17ei1HKp01n2iITUTUQksEqsKkMev+ybiUfhwMBkMIoTTqVDa9Uk5E1s0dRzB2Hakudt9lwvrrx5/ctb7V0iVFHPK6jUKe68iiUxAog/VEKTXSZuEF5WPXSKhk/ziLuQWImz9Q+STXanB68yQi+/BEg64/tvWMM5SwntX9k+FBKqZ4prX5Cylw8luzCUlxY9it8WvSb9cMOd4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDHl+wL3pE5Iqt1O1cgMS1h4sm2Ga4ZA37+xRJB8uG4=;
 b=fMmxkIryPB8JRAhk8l6460Q7CV1ZEuaOtZc9a9rTQmA2ePPIW5CC09Jy9TW+2JrybHB1Yo/Kl4TR3k76KUuruflDs/f7ZCmxWWmhbw0JmngKa5Wd6g5kz19dwKXK8GRDHlyLPo8DtVQSITVXmH+NUUTKHdkvyiwhvWl2XltvDyqk8YbgwNiJQzMe5K3olXvzm1FYw9ETJ1KQl56weuF84mpj/SVK8PerZNanWXZSasbCAZ3v19q5qi0CNaSLEKMe73YZI4qxeW7DnLV7CGe+rNYJt5WBaNRtcTzJh+FW6C64m1mHrcjrotMQw3vUpUYFusXlvETIeRklDeQwJDcpPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDHl+wL3pE5Iqt1O1cgMS1h4sm2Ga4ZA37+xRJB8uG4=;
 b=DC8mzlzCujfU0hTFnyiFmurBA2ol+4Y9ozZeY7nW+Gp4Swz5+srnOrai/fw/qffuEchCjj9x+rh3HGqtVDIhk4Aw3q1aUKK5Vneb23vgXw35+0N5ycQpjiL0Q4C/MIJI+ceaGuNSAxWaqJDxZiZieuuhaJWeudxvodLVwgA5Eyg=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM5PR11MB1996.namprd11.prod.outlook.com (2603:10b6:3:13::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 02:10:29 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 02:10:29 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBsb29wOiBGaXggdXNlIG9mIHVuc2FmZSBsby0+bG9f?=
 =?gb2312?Q?mutex_locks?=
Thread-Topic: [PATCH] loop: Fix use of unsafe lo->lo_mutex locks
Thread-Index: AQHXIVhIOFjKQavTx0Ciyxtr6hqn7KqUrYiAgADY1kI=
Date:   Fri, 26 Mar 2021 02:10:29 +0000
Message-ID: <DM6PR11MB42021A8D248C5BD1D9E72C87FF619@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <20210325092203.10251-1-qiang.zhang@windriver.com>,<CA+CK2bCS9Ab+F9gzGEJejW6J3R26j1JNBOV3tvcR6+fz2uRfpw@mail.gmail.com>
In-Reply-To: <CA+CK2bCS9Ab+F9gzGEJejW6J3R26j1JNBOV3tvcR6+fz2uRfpw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15880919-2d51-48a9-8466-08d8effc5428
x-ms-traffictypediagnostic: DM5PR11MB1996:
x-microsoft-antispam-prvs: <DM5PR11MB1996C609BEC7FD96F11D7913FF619@DM5PR11MB1996.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tWMoAewnsyWPRDU+ZSLzRHmtJslCXBPRsz4h+qHEa09gxW7Cn7LPo/j31T8yu14fIu8bp5PscVP2zWYc6VSDCYBAzt5bLesi7VDH3jvw+5BwoOGqYexZbv9V8Ydc141+pcxBfNVj6zg9+fMnEsUDw1BPnetwtLdlZORrXoZ5SxBGjkLLgZSI6Ubx4KeAWvNCh7EA91tYLVdjaQv3FkPmXj0XLJLTmlJ/4es4Ggzfc+He+eMSCZnIDeogHxF5t/QI4NmipBYitlg47ilmncg5wKPu8rCNSRwj6BmQHf0FtCd4p+sP2ZPrPReFO1tXhhdMScgIrF8CONsj3Iy6bS0uQbO7q3u206Qrv9z6svyR5dIYJiB4PPzkhTuySh6v9G+Q7mEDq6mZArdmLg0Ai2KGVc2kE6zaEBFxGHYjB08FKvANWpAX76QSzm1IXR3khW+nzBdMdjNM/bIzxN7+FABkbp4zJYDCf0X3oaiZHhlR4LyfdxFmccCHKpqYeZvubDZELJ4C/wzWIK4yMKE5urp1+O9jhqw6Ssrcxh0ADbDoUVIU8XthTBFMXPs2g6nKqZ2DOgyW7hTsW6/YZvJcHrKX3AIE+NCSsSIIkMI/kNkaMOBr+MdqwBzsV8/2NKxEnihU538Zp/34gnR/ypT+T3LhWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(376002)(136003)(396003)(346002)(71200400001)(6916009)(316002)(54906003)(4326008)(5660300002)(83380400001)(224303003)(33656002)(91956017)(26005)(6506007)(55016002)(186003)(478600001)(76116006)(8936002)(86362001)(66446008)(52536014)(66476007)(66946007)(7696005)(66556008)(9686003)(64756008)(2906002)(38100700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?YTNPTVZVQm9oMzhRL2dGekRSVW9CTXlHVGczellNMVVncWhJNkttSXRDNzZS?=
 =?gb2312?B?Q3Q3dkNncXc5ZmFnekZmeGdvb3NwaTllK2UxeXNLR0FrVnk0ZmV6OE9Bb1FX?=
 =?gb2312?B?aW1vYndRTUFKSngvV2crMGFYYXhSUFBWbXo2UnNRaVZwcE1nNUYzazVnVUo1?=
 =?gb2312?B?RkJ6Qm43ekt1a0w1QzF3cWhDVUR6Umc1ZXVtNUVoYVlDUUFvSjE2TXlTT0Q0?=
 =?gb2312?B?U2tHZy9GdXdjY054bk5ycENOYkJuZmNnSHZlN0FCanVWWWJxOUYvZEtqRUEy?=
 =?gb2312?B?aDVqR3BxUkdlWG9DZXpxZUhkZTZvQkhhU3BmUzdjQnBUem5DRUJkNG5pTk5G?=
 =?gb2312?B?QXNsTnBhUUpDYUtPTmlXUU9xWXBtdmgzOG9GUVdPR2FTY3pORXNNM01vMUJt?=
 =?gb2312?B?dVJnWWt1emh6SDdFdFpYWlMvQWtrbnFkSWxFR0NWc2lkdHpKczlNNk5iRGxx?=
 =?gb2312?B?ZWtXcDFSUTk1RVFwTmc3L2FpR2gwVFNZYWxzREN0TEtqQjZjamlYM2lHVi9y?=
 =?gb2312?B?eVF6Q000UmJjUjdYTmlvM1lqWlB6cEdzRVhyVWo5NUZwSGtQQzduNHFwcGFt?=
 =?gb2312?B?amhaV05yYllZWktqV3NXaEJkUDVEZDlMeVkxODBZeW1XcmlUOEo3R01DTnBL?=
 =?gb2312?B?aXhVd1oxS25TQXFQWVNhRllVbEdYbEFQKzR6cmtRVUVjZ3BPaERMMmcyRC9z?=
 =?gb2312?B?OWtUSzhhUHJyVmRUOU1oTUN0eWczVjZsTU8yMWNKaHpyWldZdHd2Vm1aRVpT?=
 =?gb2312?B?OTU2eFJFUUV2a0kyYVdYbExqSzFKQksrTXZPOTNuMTNSRnhpYmJIUU1rTGlz?=
 =?gb2312?B?QTBzbXllSlIxZFVOTFFlMm84VjZXbjdWQTFhSUM3ZzB6SUV6NnpRZDJZZ3Fu?=
 =?gb2312?B?ZGVIY2RkU0dQM1lYSHBNbUQ1dmhEZitnTEZCNmVkbEN5SHZ3WFRmSzFhQ0VY?=
 =?gb2312?B?Y3hRaFdQOXRvRjBMTUNhb05MbUQ2dGIvQVhoRSsyNFRsc1pYREp3dkJQQzZE?=
 =?gb2312?B?ZFhOSEEzVmplZFdqN1FMTVNzN3ErbjQyM0ZYTXEyZkpyOVJMaVlvOFRiNmpy?=
 =?gb2312?B?WmxaQkttSWNCQmhOYkRhdCt5WU8wWXQxb3kzYlZjL0RSVWFJSWluQmlxSTZ6?=
 =?gb2312?B?RmdVVWw4dituc2hQd29MZ2FIU3p1QjlTNXNMNjdvSkRJa3FyMUxJU3U4blpG?=
 =?gb2312?B?WTZlVUFxZ2xqOURmOUs3MW5GMXZkcHNFaXlNc1pzOWpOcFB3Z2ZiY3prMmsw?=
 =?gb2312?B?VENVUmRiOFhzNkowZTREY1B6aXI4a1BaSFp2ZUpERE5KUU5HUGNxZ1Y0aDJJ?=
 =?gb2312?B?WXhKQkM5aFlNSXc4YVhoTFNTRWtHdElFRjRYQTRqVTNKdXVmNjZyZThlK1Zv?=
 =?gb2312?B?ZmNTcTNuU1p0OVF4T2syV0ttRGNTRE0wNG1LUnZaQTFDRndwVVVYMnQyMXlX?=
 =?gb2312?B?UHhYL3RMcTBKMURVSnRLckhwNVhUamJpZ1l5bjhJSzMwUFplUTNsRVl1ejU4?=
 =?gb2312?B?VHNjVGJ5NFhyekN1Wkw2cTlybXdGczdpRnhkbnVxbWJTQmVROXBkMWlGL1FB?=
 =?gb2312?B?L0lwQ2ZGd2JJdnpuQ0s1c1ZCN0NXc2hWdHlkYVVIUHpPK2taaXduQ0g0SFVD?=
 =?gb2312?B?cDBEdkNNR2lDZ0Q0WWN4OGV0cUJkRXJ0bGhCVjA0ajZST1RXOHB6R1Q1L216?=
 =?gb2312?B?bGtTMVYvRUZSQ2NDZXdLT2luUFNRZWRpRUFaeUNLb25QTEIreFpJTm4vbDlQ?=
 =?gb2312?Q?9yBLKCZMZVKX+/w+cg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15880919-2d51-48a9-8466-08d8effc5428
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 02:10:29.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+m/J/JQAmCfEbfUEfQVgV1TUKIqflStbWYg6kmujPF1oZlVgZATxSuVql5JczEs0PsksBPc03zxITHPJCltlpvSff2VNe+iOCJ0oN+FeyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1996
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogUGF2ZWwg
VGF0YXNoaW4gPHBhc2hhLnRhdGFzaGluQHNvbGVlbi5jb20+Creiy83KsbzkOiAyMDIxxOoz1MIy
NcjVIDIxOjA5CsrVvP7IyzogWmhhbmcsIFFpYW5nCrOty806IEplbnMgQXhib2U7IGxpbnV4LWJs
b2NrQHZnZXIua2VybmVsLm9yZzsgTEtNTArW98ziOiBSZTogW1BBVENIXSBsb29wOiBGaXggdXNl
IG9mIHVuc2FmZSBsby0+bG9fbXV0ZXggbG9ja3MKCltQbGVhc2Ugbm90ZTogVGhpcyBlLW1haWwg
aXMgZnJvbSBhbiBFWFRFUk5BTCBlLW1haWwgYWRkcmVzc10KCj5IaSBRaWFuZywKPgo+VGhhbmsg
eW91IGZvciByb290IGNhdXNpbmcgdGhpcyBpc3N1ZS4gRGlkIHlvdSBlbmNvdW50ZXIgdGhpcyBp
c3N1ZSA+b3IKPmZvdW5kIGJ5IGluc3BlY3Rpb24/CgpIaSBQYXNoYQoKICBJIGZvdW5kIHRoZSBw
cm9ibGVtIGR1cmluZyB0aGUgaW5zcGVjdGlvbiAKCj4KPkkgd291bGQgY2hhbmdlIHRoZSB0aXRs
ZSB0byB3aGF0IGFjdHVhbGx5IGJlaW5nIGNoYW5nZWQsIHNvbWV0aGluZyA+bGlrZToKPgo+bG9v
cDogY2FsbCBfX2xvb3BfY2xyX2ZkKCkgd2l0aCBsb19tdXRleCBsb2NrZWQgdG8gYXZvaWQgYXV0
b2NsZWFyID5yYWNlCgogIGFncmVlIGl0CiAKPgo+Cj4gICAuLi4uLi4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBrZnJlZShsbykKPiAgICAgICAgVUFGCj4KPiBXaGVuIGRp
ZmZlcmVudCB0YXNrcyBvbiB0d28gQ1BVcyBwZXJmb3JtIHRoZSBhYm92ZSBvcGVyYXRpb25zIG9u
IHRoZSBzYW1lCj4gbG8gZGV2aWNlLCBVQUYgbWF5IG9jY3VyLgo+Cj5QbGVhc2UgYWxzbyBleHBs
YWluIHRoZSBmaXg6Cj4KPkRvIG5vdCBkcm9wIGxvLT5sb19tdXRleCBiZWZvcmUgY2FsbGluZyBf
X2xvb3BfY2xyX2ZkKCksIHNvIHJlZmNudCA+YW5kCj5MT19GTEFHU19BVVRPQ0xFQVIgY2hlY2sg
aW4gbG9fcmVsZWFzZSBzdGF5IGluIHN5bmMuCgogIEkgd2lsbCBtb2RpZnkgaXQgYW5kIHJlc2Vu
ZCBpdAogCiAgVGhhbmtzCiAgUWlhbmcgCj4KPgo+IEZpeGVzOiA2Y2M4ZTc0MzA4MDEgKCJsb29w
OiBzY2FsZSBsb29wIGRldmljZSBieSBpbnRyb2R1Y2luZyBwZXIgZGV2aWNlIGxvY2siKQo+IFNp
Z25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KPiAtLS0KPiAg
ZHJpdmVycy9ibG9jay9sb29wLmMgfCAxMSArKysrLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
YmxvY2svbG9vcC5jIGIvZHJpdmVycy9ibG9jay9sb29wLmMKPiBpbmRleCBkNThkNjhmM2M3Y2Qu
LjU3MTJmMTY5OGE2NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Jsb2NrL2xvb3AuYwo+ICsrKyBi
L2RyaXZlcnMvYmxvY2svbG9vcC5jCj4gQEAgLTEyMDEsNyArMTIwMSw2IEBAIHN0YXRpYyBpbnQg
X19sb29wX2Nscl9mZChzdHJ1Y3QgbG9vcF9kZXZpY2UgKmxvLCBib29sIHJlbGVhc2UpCj4gICAg
ICAgICBib29sIHBhcnRzY2FuID0gZmFsc2U7Cj4gICAgICAgICBpbnQgbG9fbnVtYmVyOwo+Cj4g
LSAgICAgICBtdXRleF9sb2NrKCZsby0+bG9fbXV0ZXgpOwo+ICAgICAgICAgaWYgKFdBUk5fT05f
T05DRShsby0+bG9fc3RhdGUgIT0gTG9fcnVuZG93bikpIHsKPiAgICAgICAgICAgICAgICAgZXJy
ID0gLUVOWElPOwo+ICAgICAgICAgICAgICAgICBnb3RvIG91dF91bmxvY2s7Cj4gQEAgLTEyNTcs
NyArMTI1Niw2IEBAIHN0YXRpYyBpbnQgX19sb29wX2Nscl9mZChzdHJ1Y3QgbG9vcF9kZXZpY2Ug
KmxvLCBib29sIHJlbGVhc2UpCj4gICAgICAgICBsb19udW1iZXIgPSBsby0+bG9fbnVtYmVyOwo+
ICAgICAgICAgbG9vcF91bnByZXBhcmVfcXVldWUobG8pOwo+ICBvdXRfdW5sb2NrOgo+IC0gICAg
ICAgbXV0ZXhfdW5sb2NrKCZsby0+bG9fbXV0ZXgpOwo+ICAgICAgICAgaWYgKHBhcnRzY2FuKSB7
Cj4gICAgICAgICAgICAgICAgIC8qCj4gICAgICAgICAgICAgICAgICAqIGJkX211dGV4IGhhcyBi
ZWVuIGhlbGQgYWxyZWFkeSBpbiByZWxlYXNlIHBhdGgsIHNvIGRvbid0Cj4gQEAgLTEyODgsMTIg
KzEyODYsMTEgQEAgc3RhdGljIGludCBfX2xvb3BfY2xyX2ZkKHN0cnVjdCBsb29wX2RldmljZSAq
bG8sIGJvb2wgcmVsZWFzZSkKPiAgICAgICAgICAqIHByb3RlY3RzIHVzIGZyb20gYWxsIHRoZSBv
dGhlciBwbGFjZXMgdHJ5aW5nIHRvIGNoYW5nZSB0aGUgJ2xvJwo+ICAgICAgICAgICogZGV2aWNl
Lgo+ICAgICAgICAgICovCj4gLSAgICAgICBtdXRleF9sb2NrKCZsby0+bG9fbXV0ZXgpOwo+ICsK
PiAgICAgICAgIGxvLT5sb19mbGFncyA9IDA7Cj4gICAgICAgICBpZiAoIXBhcnRfc2hpZnQpCj4g
ICAgICAgICAgICAgICAgIGxvLT5sb19kaXNrLT5mbGFncyB8PSBHRU5IRF9GTF9OT19QQVJUX1ND
QU47Cj4gICAgICAgICBsby0+bG9fc3RhdGUgPSBMb191bmJvdW5kOwo+IC0gICAgICAgbXV0ZXhf
dW5sb2NrKCZsby0+bG9fbXV0ZXgpOwo+Cj4gICAgICAgICAvKgo+ICAgICAgICAgICogTmVlZCBu
b3QgaG9sZCBsb19tdXRleCB0byBmcHV0IGJhY2tpbmcgZmlsZS4gQ2FsbGluZyBmcHV0IGhvbGRp
bmcKPiBAQCAtMTMzMiw5ICsxMzI5LDEwIEBAIHN0YXRpYyBpbnQgbG9vcF9jbHJfZmQoc3RydWN0
IGxvb3BfZGV2aWNlICpsbykKPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gICAgICAgICB9
Cj4gICAgICAgICBsby0+bG9fc3RhdGUgPSBMb19ydW5kb3duOwo+ICsgICAgICAgZXJyID0gX19s
b29wX2Nscl9mZChsbywgZmFsc2UpOwo+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZsby0+bG9fbXV0
ZXgpOwo+Cj4gLSAgICAgICByZXR1cm4gX19sb29wX2Nscl9mZChsbywgZmFsc2UpOwo+ICsgICAg
ICAgcmV0dXJuIGVycjsKPiAgfQo+Cj4gIHN0YXRpYyBpbnQKPiBAQCAtMTkxNiwxMyArMTkxNCwx
MiBAQCBzdGF0aWMgdm9pZCBsb19yZWxlYXNlKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBmbW9kZV90
IG1vZGUpCj4gICAgICAgICAgICAgICAgIGlmIChsby0+bG9fc3RhdGUgIT0gTG9fYm91bmQpCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXRfdW5sb2NrOwo+ICAgICAgICAgICAgICAg
ICBsby0+bG9fc3RhdGUgPSBMb19ydW5kb3duOwo+IC0gICAgICAgICAgICAgICBtdXRleF91bmxv
Y2soJmxvLT5sb19tdXRleCk7Cj4gICAgICAgICAgICAgICAgIC8qCj4gICAgICAgICAgICAgICAg
ICAqIEluIGF1dG9jbGVhciBtb2RlLCBzdG9wIHRoZSBsb29wIHRocmVhZAo+ICAgICAgICAgICAg
ICAgICAgKiBhbmQgcmVtb3ZlIGNvbmZpZ3VyYXRpb24gYWZ0ZXIgbGFzdCBjbG9zZS4KPiAgICAg
ICAgICAgICAgICAgICovCj4gICAgICAgICAgICAgICAgIF9fbG9vcF9jbHJfZmQobG8sIHRydWUp
Owo+IC0gICAgICAgICAgICAgICByZXR1cm47Cj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0X3Vu
bG9jazsKPiAgICAgICAgIH0gZWxzZSBpZiAobG8tPmxvX3N0YXRlID09IExvX2JvdW5kKSB7Cj4g
ICAgICAgICAgICAgICAgIC8qCj4gICAgICAgICAgICAgICAgICAqIE90aGVyd2lzZSBrZWVwIHRo
cmVhZCAoaWYgcnVubmluZykgYW5kIGNvbmZpZywKPiAtLQo+IDIuMTcuMQo+Cj4KPkxHVE0KPlJl
dmlld2VkLWJ5OiBQYXZlbCBUYXRhc2hpbiA8cGFzaGEudGF0YXNoaW5Ac29sZWVuLmNvbT4KPgo+
VGhhbmsgeW91LAo+UGFzaGEK
