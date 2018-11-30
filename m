Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D6FC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAE120867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="R4DSMMiE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="A0sih81e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAE120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeLADFM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:05:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55592 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726572AbeLADFM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 22:05:12 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAUFn8cV021223;
        Fri, 30 Nov 2018 07:55:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FyI44Kl81qmIVJcyaWZUZftZF1YSLaVhITjqVvrAQqU=;
 b=R4DSMMiEfZyaaoLlMsfhys2KavDmt8yO4OmfwEB0s+ksNOgcZWc3gmeyPJtO1pt3xB35
 /lCEagWjawBbDbp9QIGN/ZEyxsQQT9LYWhI+c5Kkn0cok7gi49XznyCtQT1LNgK1dJp1
 u9Ps0zNvudi0f+iwvZXuFIu5cvwiIptzSZs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p36barbw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 30 Nov 2018 07:55:02 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 30 Nov 2018 07:55:00 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 30 Nov 2018 07:55:00 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 30 Nov 2018 07:55:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyI44Kl81qmIVJcyaWZUZftZF1YSLaVhITjqVvrAQqU=;
 b=A0sih81eqEQXEnSdYd5BAGFoRDr3wLp8IPSVGAG/mDyjLahxTOukHiwTI9KMYlT4cccH0MI0girrVUbTz93eeYFVagevoYpLap1i+bfSlW8dV261tM8Re+guMHGr3x1yrCmBipSLvuup0NwaYUh8sbjN7I/CacrAxWQpancCWAU=
Received: from MWHPR15MB1470.namprd15.prod.outlook.com (10.173.234.148) by
 MWHPR15MB1502.namprd15.prod.outlook.com (10.173.235.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Fri, 30 Nov 2018 15:20:20 +0000
Received: from MWHPR15MB1470.namprd15.prod.outlook.com
 ([fe80::1ced:6764:bf7f:15f3]) by MWHPR15MB1470.namprd15.prod.outlook.com
 ([fe80::1ced:6764:bf7f:15f3%9]) with mapi id 15.20.1382.020; Fri, 30 Nov 2018
 15:20:20 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
CC:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/13] block: move queues types to the block layer
Thread-Topic: [PATCH 01/13] block: move queues types to the block layer
Thread-Index: AQHUiBekNufv0tFZikKkocWWcUPRhaVnMWgAgADD2oCAAHrwAA==
Date:   Fri, 30 Nov 2018 15:20:19 +0000
Message-ID: <00bcc7f1-9d2b-ceb8-49d6-b3c857fd2df7@fb.com>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
 <20181129201914.GB9377@localhost.localdomain> <20181130080013.GB18936@lst.de>
In-Reply-To: <20181130080013.GB18936@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::19) To MWHPR15MB1470.namprd15.prod.outlook.com
 (2603:10b6:300:bd::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.160.245.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1502;20:6+C+JJVIV5eXMFSyovISkHfd34QK31ZivNQA++51hc4k7ph6iB28a2yDXCi90tE9HduquRt0I88TtHxcathBu46g1owbyasfNURrWdNx7qh4jQrSIDmuSS18yrvMVTtPd0JpxbTrbrUy35fQU97SpnxXORy+5RVfnRmgtJxQeRI=
x-ms-office365-filtering-correlation-id: 2ade6fdb-4109-45a7-1fc1-08d656d756c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1502;
x-ms-traffictypediagnostic: MWHPR15MB1502:
x-microsoft-antispam-prvs: <MWHPR15MB1502C447BBCD2D385835516DC0D30@MWHPR15MB1502.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231453)(999002)(11241501185)(944501466)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1502;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1502;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(476003)(2906002)(99286004)(6246003)(93886005)(3846002)(6116002)(14454004)(2616005)(81166006)(110136005)(81156014)(54906003)(31686004)(316002)(486006)(186003)(68736007)(36756003)(478600001)(66066001)(97736004)(8936002)(6512007)(86362001)(8676002)(53936002)(25786009)(106356001)(6506007)(7736002)(5660300001)(386003)(305945005)(6436002)(105586002)(26005)(229853002)(76176011)(71200400001)(53546011)(31696002)(6486002)(71190400001)(446003)(4326008)(52116002)(11346002)(256004)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1502;H:MWHPR15MB1470.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kxmvKWoP9CwTvsR3TDL2jBaL2LBlv3Twl3g9RkmlMLVGwdnYZoLimuLwJDLid7zRuoBMe8tCc4q5YyAwepa+1ZlKrMUwnNtBRQLVGpuPoAhkIlouveE7SfAqqR9OlzguxmiWV/ZsWF6KXWMB4m8YQxjRLQ8B3hNzL+Qhr6HpbRVWlgrDOIbXgYg0PTTKJEMpnKo4U6odvb/g3pcDnobEsnUu3rZNFNE0JtmtIFOBF/JCekl0MCLS2+ifybDK0DKV6r39zte5o266eIZDCtlHFrRXte7yVYY6P03/biejwKfVt/E7n68xBu/IkreGIxyu2PTzRAljatazFrt0nxfl5AT3tHpRj96h9tKQ9O9rLSs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <28491CC44F7D07448FF1DC85BE633460@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ade6fdb-4109-45a7-1fc1-08d656d756c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 15:20:19.9639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1502
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-30_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMzAvMTggMTowMCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFRodSwg
Tm92IDI5LCAyMDE4IGF0IDAxOjE5OjE0UE0gLTA3MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4g
T24gVGh1LCBOb3YgMjksIDIwMTggYXQgMDg6MTI6NThQTSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6DQo+Pj4gK2VudW0gaGN0eF90eXBlIHsNCj4+PiArCUhDVFhfVFlQRV9ERUZBVUxU
LAkvKiBhbGwgSS9PIG5vdCBvdGhlcndpc2UgYWNjb3VudGVkIGZvciAqLw0KPj4+ICsJSENUWF9U
WVBFX1JFQUQsCQkvKiBqdXN0IGZvciBSRUFEIEkvTyAqLw0KPj4+ICsJSENUWF9UWVBFX1BPTEws
CQkvKiBwb2xsZWQgSS9PIG9mIGFueSBraW5kICovDQo+Pj4gKw0KPj4+ICsJSENUWF9NQVhfVFlQ
RVMsDQo+Pj4gIH07DQo+Pg0KPj4gV2VsbCwgdGhlcmUgZ29lcyBteSBwbGFuIHRvIHVzZSB0aGlz
IHdpdGggV2VpZ2h0ZWQtUm91bmQtUm9iaW4gTlZNZSBJTw0KPj4gcXVldWVzIQ0KPiANCj4gV28g
YmV0d2VlbiB3aGF0IGRvIHlvdSBldmVuIHdhbnQgdG8gcm91bmQgcm9iaW4/ICBJZiBpdCBpcyBi
ZXR3ZWVuDQo+IHJlYWRzIGFuZCB3cml0ZXMgdGhhdCdzIGVhc3kuICBJZiB3ZSB3YW50IHByaW9y
aXR5IHJlYWRzIG9yIHdyaXRlcw0KPiAoc2VwYXJhdGUgZnJvbSBwb2xsaW5nKSB0aGF0J3MgYWxz
byBzdGlsbCBmYWlybHkgZWFzaWx5Lg0KPiANCj4gQnR3LCBvbmUgdGhpbmcgSSB3YW50ZWQgdG8g
dHJ5IG9uY2UgSSBnZXQgaG9sZCBvZiB0aGUgcmlnaHQgaGFyZHdhcmUNCj4gaXMgdG8gbWFyayB0
aGUgcG9sbCBxdWV1ZXMgYXMgcHJpb3JpdHkgcXVldWVzIGFuZCBzZWUgaWYgdGhhdCBtYWtlcw0K
PiBhbnkgZGlmZmVyZW50cyBpbiBwb2xsIElPUFMvbGF0ZW5jeS4NCg0KUHJvYmFibHkgbm90IGEg
bG90LCBpZiBhbnl0aGluZy4gT25seSBmb3IgaGVhdmlseSBtaXhlZCBjYXNlcyBJJ2QNCnN1c3Bl
Y3QgaXQgdG8gbWFrZSBhIGRpZmZlcmVuY2UuIEkgY2FuIHJ1biBzb21lIHRlc3RzIHdpdGggaXQu
DQoNCkFuZCBiZXdhcmUgdGhhdCBJJ3ZlIHNlZW4gd2VpcmQgcXVldWUgcHJpb3JpdHkgaXNzdWVz
LCBhbGEgdGhlIG9uZQ0KZml4ZWQgYnk6DQoNCmNvbW1pdCA5YWJkNjhlZjQ1NGM4MjRiZmQxODYy
OTAzMzM2N2I0MzgyYjVmMzkwICh0YWc6IGZvci1saW51cy0yMDE4MDUxMSkNCkF1dGhvcjogSmVu
cyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KRGF0ZTogICBUdWUgTWF5IDggMTA6MjU6MTUgMjAx
OCAtMDYwMA0KDQogICAgbnZtZTogYWRkIHF1aXJrIHRvIGZvcmNlIG1lZGl1bSBwcmlvcml0eSBm
b3IgU1EgY3JlYXRpb24NCg0KU28gd2UgbmVlZCB0byBiZSBjYXJlZnVsIHdpdGggZW5hYmxpbmcg
cHJpb3JpdGllcywgSSBzdXNwZWN0LiBIb3BlZnVsbHkNCnRoYXQncyBhIHN0YW5kYWxvbmUgY2Fz
ZS4NCg0KLS0gDQpKZW5zIEF4Ym9lDQoNCg==
