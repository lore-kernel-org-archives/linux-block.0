Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D262C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 20:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0A321104
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 20:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lWFZZjxy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jMxJj3+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0A321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeK3HcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:32:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44488 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbeK3HcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 02:32:14 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wATKNjTT013920;
        Thu, 29 Nov 2018 12:25:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Wk9oB1NKUxg0ci76UgqHOeZUMiignrI5F6NvmB00JhU=;
 b=lWFZZjxyy1aRSNDgZNqK6Wsk4g9gS9QmpE1NVj1F3yEJq+AzBj1GAzGn1OPCUj5iz+qf
 DBBVomHgOjN5BUta/JOmp56h4/nMdK9z8TzZVuaqk7PidLF0Gg/Zpo+xNPv7i3JEbuZH
 KP5g26jj8sEE2odPN7noq/aIFQXbokbrOD8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p2mv9rjj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Nov 2018 12:25:12 -0800
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 29 Nov 2018 12:25:11 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 29 Nov 2018 12:25:11 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 29 Nov 2018 12:25:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk9oB1NKUxg0ci76UgqHOeZUMiignrI5F6NvmB00JhU=;
 b=jMxJj3+ucE9ZcLKw3FWOdP+MgGK3Jss72y0KL8GOZbOUf4QBJFmJHt5gt/1uj2hlP5hKB04ddwfCiycPHkayiKiIjeGJHibBwSW/GQW9yI7wkzOLHEHaAVWth/C3uk0DzuZAgubU5oNvjjnagw7Xd95xJjNjRsDSrjYkdMvkOw8=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.161.20) by
 CY4PR15MB1752.namprd15.prod.outlook.com (10.174.53.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 20:25:10 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::6c4b:dae9:81dc:f850]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::6c4b:dae9:81dc:f850%5]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 20:25:10 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
CC:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/13] block: move queues types to the block layer
Thread-Topic: [PATCH 01/13] block: move queues types to the block layer
Thread-Index: AQHUiBekNufv0tFZikKkocWWcUPRhaVnMWgAgAABpgA=
Date:   Thu, 29 Nov 2018 20:25:10 +0000
Message-ID: <74fb1df7-f1c4-93e9-0340-4c11e5147a9d@fb.com>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
 <20181129201914.GB9377@localhost.localdomain>
In-Reply-To: <20181129201914.GB9377@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR1301CA0031.namprd13.prod.outlook.com
 (2603:10b6:4:2a::44) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fe::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.160.245.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1752;20:7gpwroUQhkQHlbGv1k0wkXdDwzFQIkYkH9M8FwmequdBOddKrfyrNQUmEoIzLfkqWOFhiKRSZPZ981lgQOUnjhdwhOZznahlcM4wge7VnTapmj1xFlk4vj+RME3I7JVwCZbYhayR6CUG5rsWospZwP/4XiuAWNg1gQFbPlsYSlQ=
x-ms-office365-filtering-correlation-id: 2992ff30-5d69-4c43-1f19-08d65638c24f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1752;
x-ms-traffictypediagnostic: CY4PR15MB1752:
x-microsoft-antispam-prvs: <CY4PR15MB1752DD8F123E632B8D6950E1C0D20@CY4PR15MB1752.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231453)(999002)(11241501185)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1752;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1752;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(396003)(346002)(136003)(199004)(189003)(256004)(14444005)(186003)(6436002)(6486002)(229853002)(71200400001)(26005)(25786009)(71190400001)(478600001)(31696002)(6246003)(4326008)(14454004)(6116002)(6512007)(2906002)(3846002)(86362001)(110136005)(316002)(5660300001)(54906003)(97736004)(36756003)(76176011)(106356001)(8676002)(52116002)(53936002)(105586002)(53546011)(305945005)(102836004)(81156014)(81166006)(386003)(6506007)(99286004)(66066001)(31686004)(476003)(2616005)(7736002)(11346002)(486006)(68736007)(446003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1752;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZmqQbnCCMdtSzNf6rhYdBuaOXkB1XbrlCsZNQ/VMBPy+iGm38XkyBspjrIjTkQZxljU/wtDdEwP7usvOgUj6XyTJ/cuBjrOReTy57N76YWbHiWeiisAG2P0sq2/Z0MQqYlLJpawjPS2caC4ETZskUHPy5NNT7Ol73iubwbaLdy4GacmRkOFBUtvUcMQ8SuRCjyOT7Th7/ItWnulvmxbtg7VdnzVgXZWlxvIF7sibtFVocnlK0Ek2WscHtmEWYJ4v1in4Th7XhpbZC71phnh/M6lQnEqkTtOy48+AekWfsllNFd+iO3ndxF5ErINjgnGJOW0mMkrjzB2jW0kCg7iYWy9q8GACbmgQjPR0s/J43bo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF535FE4890D4F4793C6D6D80FB1B561@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2992ff30-5d69-4c43-1f19-08d65638c24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 20:25:10.1220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1752
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMjkvMTggMToxOSBQTSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFRodSwgTm92IDI5
LCAyMDE4IGF0IDA4OjEyOjU4UE0gKzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4g
K2VudW0gaGN0eF90eXBlIHsNCj4+ICsJSENUWF9UWVBFX0RFRkFVTFQsCS8qIGFsbCBJL08gbm90
IG90aGVyd2lzZSBhY2NvdW50ZWQgZm9yICovDQo+PiArCUhDVFhfVFlQRV9SRUFELAkJLyoganVz
dCBmb3IgUkVBRCBJL08gKi8NCj4+ICsJSENUWF9UWVBFX1BPTEwsCQkvKiBwb2xsZWQgSS9PIG9m
IGFueSBraW5kICovDQo+PiArDQo+PiArCUhDVFhfTUFYX1RZUEVTLA0KPj4gIH07DQo+IA0KPiBX
ZWxsLCB0aGVyZSBnb2VzIG15IHBsYW4gdG8gdXNlIHRoaXMgd2l0aCBXZWlnaHRlZC1Sb3VuZC1S
b2JpbiBOVk1lIElPDQo+IHF1ZXVlcyENCj4gDQo+IEknbSBub3QgdGhhdCBzYWQgYWJvdXQgaXQs
IHRob3VnaC4NCg0KVGhhdCdzIHdoeSBJIHdhbnRlZCB0aGVzZSB0byBiZSBkcml2ZXIgcHJpdmF0
ZSwgc28geW91IGNvdWxkIGp1c3QgZXhwYW5kDQphdCB3aWxsLiBCdXQgaXQncyBub3QgbGlrZSB3
ZSBjYW4ndCBkbyB0aGF0IG5vdywgd2UnbGwganVzdCBhZGQgc29tZQ0KZXh0cmEgdHlwZXMgaW4g
aGVyZS4gVGhlIGRvd25zaWRlIGlzIHRoYXQgaWYgd2UgaGF2ZSBhIGJ1bmNoIG9mIGRyaXZlcnMN
CmhhdmluZyBkaXMtc2VwYXJhdGUgcXVldWVzLCB0aGVuIHdlIGVuZCB1cCB3aXRoIGEgYmlnZ2Vy
IE1BWCBudW1iZXIgdGhhbg0Kd2Ugd291bGQgaGF2ZSB3aXRoIGRyaXZlciBwcml2YXRlIHF1ZXVl
cy4NCg0KSU9XLCBJIGRvbid0IHRoaW5rIHRoaXMgaXMgcnVpbmluZyBhbnl0aGluZyBmb3IgeW91
Lg0KDQotLSANCkplbnMgQXhib2UNCg0K
