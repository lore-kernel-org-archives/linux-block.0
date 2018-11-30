Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB33AC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A233920868
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="blEhttnt";
	dkim=temperror (0-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cUAip+A1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A233920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeLACbB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:31:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbeLACbB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 21:31:01 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAUFJGPJ025261;
        Fri, 30 Nov 2018 07:20:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=IFU7vFSCKctizIKdSnrOwwtZ18s40Vaog5/6Z+EJygU=;
 b=blEhttntItDCnTWbdl6e21m75HkeUKm0z0+x0s2qcIJde6EJ2srDcyNJfziOUtPEOc4k
 HIMvadothvNgpxLGHEw/8kAVuh89JeIRJSfapCqhl6r6HpxIqQNZf8NQKr1lFXTAnkkQ
 NEClsrIenYTVSkC3ONJpJmjf+C2faGHTQyE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p34wqghpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 30 Nov 2018 07:20:54 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 30 Nov 2018 07:20:53 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 30 Nov 2018 07:20:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFU7vFSCKctizIKdSnrOwwtZ18s40Vaog5/6Z+EJygU=;
 b=cUAip+A1udYjvoNr78nMu8uCvqWPomu4nxmyhR9OBrU1BX4JcmnpFi5jRluBgVlhZOLZYdkYOJyRZe031zEii1/rB2JUUiw9hq3j8wrM7+zfeE0sn50oPg5Cv25+lPklvWzePuFB9oIKykTCccW30wh8qCswaellsEI4NSAKRL0=
Received: from MWHPR15MB1470.namprd15.prod.outlook.com (10.173.234.148) by
 MWHPR15MB1502.namprd15.prod.outlook.com (10.173.235.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Fri, 30 Nov 2018 15:20:51 +0000
Received: from MWHPR15MB1470.namprd15.prod.outlook.com
 ([fe80::1ced:6764:bf7f:15f3]) by MWHPR15MB1470.namprd15.prod.outlook.com
 ([fe80::1ced:6764:bf7f:15f3%9]) with mapi id 15.20.1382.020; Fri, 30 Nov 2018
 15:20:51 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Max Gurtovoy" <maxg@mellanox.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/13] block: move queues types to the block layer
Thread-Topic: [PATCH 01/13] block: move queues types to the block layer
Thread-Index: AQHUiBekNufv0tFZikKkocWWcUPRhaVnKUQAgADK1ICAAHxCgA==
Date:   Fri, 30 Nov 2018 15:20:51 +0000
Message-ID: <9b289631-6c4f-e410-f63c-d1e1f54dc1c5@fb.com>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
 <c20e4d66-0fc5-ab65-2805-c4b22012c1c5@fb.com> <20181130075603.GA18936@lst.de>
In-Reply-To: <20181130075603.GA18936@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To MWHPR15MB1470.namprd15.prod.outlook.com
 (2603:10b6:300:bd::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [216.160.245.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1502;20:iAtAsbrLZ7gS1QFuXN9GUhD/06e7Jyv4Ryaw3lzzadbi7CaDyv1vGI0lmd6FaUiFTXk23cnpYSsJQBI7r3na+JqSIXD6SX4STiU7IydldKRyA6hKg7PFyiDpCIwMbNmJ0PoKXt/2YgMLNjOamLk5nNvT94E4THquZ0QukGVqbL4=
x-ms-office365-filtering-correlation-id: 75b766a4-c1fe-4fb5-1fec-08d656d769b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1502;
x-ms-traffictypediagnostic: MWHPR15MB1502:
x-microsoft-antispam-prvs: <MWHPR15MB15029758EAC567150B84FB09C0D30@MWHPR15MB1502.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231453)(999002)(11241501185)(944501466)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1502;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1502;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(476003)(2906002)(99286004)(6246003)(93886005)(3846002)(6116002)(14454004)(2616005)(81166006)(81156014)(54906003)(31686004)(316002)(486006)(186003)(68736007)(36756003)(478600001)(66066001)(97736004)(8936002)(6512007)(86362001)(8676002)(53936002)(25786009)(106356001)(6506007)(7736002)(5660300001)(386003)(305945005)(6436002)(105586002)(26005)(229853002)(76176011)(71200400001)(53546011)(31696002)(6486002)(71190400001)(6916009)(446003)(4326008)(52116002)(11346002)(256004)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1502;H:MWHPR15MB1470.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XAYnmpBQKf1I9kRJ0uVEZFA9EzGf9Eb03lI/TL9xTvYEN9NSXhgpT4eOYM0fqJqYO5uv0KZF7oqyU1eg0thDoLpbFH2AfKULJBPkpH4OJ1CpCOrDPKbyzRLrV9F+WLl+suuoP4rquWDQtMZh7siL9h4eozIWj7np6qJ/2N7ig0jY1FM15LPnSNH5DaMacnTNtwD7GAcVu749gPDPL81+i6mEoLeWXYBF4szeFLjHlBBgSNVmZJGUPq7lTR9H4MdaPtZn01oG91QI0TxdZUrbXAhoBW5p39jJ2X4BWjXZwQQzzfNkohI9LfGSTSytsIF+Ob9m8srDCauY8cA5stiamuJFkOS8vXBwPg2nQR/BgcI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CD52B4A0DC5324F88D05257F7AA3815@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b766a4-c1fe-4fb5-1fec-08d656d769b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 15:20:51.5439
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

T24gMTEvMzAvMTggMTI6NTYgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUaHUs
IE5vdiAyOSwgMjAxOCBhdCAwNzo1MDowOVBNICswMDAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPj4+
IGluIG91ciBwb3N0LXNwZWN0cmUgd29ybGQuICBBbHNvIGhhdmluZyB0b28gbWFueSBxdWV1ZSB0
eXBlIGlzIGp1c3QNCj4+PiBnb2luZyB0byBjcmVhdGUgY29uZnVzaW9uLCBzbyBJJ2QgcmF0aGVy
IG1hbmFnZSB0aGVtIGNlbnRyYWxseS4NCj4+Pg0KPj4+IE5vdGUgdGhhdCB0aGUgcXVldWUgdHlw
ZSBuYW1pbmcgYW5kIG9yZGVyaW5nIGNoYW5nZXMgYSBiaXQgLSB0aGUNCj4+PiBmaXJzdCBpbmRl
eCBub3cgaXMgdGhlIGRlZmF1bHkgcXVldWUgZm9yIGV2ZXJ5dGhpbmcgbm90IGV4cGxpY2l0bHkN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eDQo+Pg0KPj4gZGVmYXVsdA0KPiAN
Cj4gRml4ZWQuDQo+IA0KPj4gU2lkZSBub3QsIHNob3VsZCBwcm9iYWJseSBtYWtlIHRoZSBzeXNm
cyAndHlwZScgYXR0cmlidXRlIGEgc3RyaW5nDQo+PiBhdCB0aGlzIHBvaW50Lg0KPiANCj4gRml4
ZWQgYXMgd2VsbC4NCg0KVGhhbmtzIC0gYXJlIHlvdSBnb2luZyB0byBwb3N0IGEgdjM/IFdvdWxk
IGxpa2UgdG8gZ2V0IHRoaXMgc3RhZ2VkLg0KDQoNCi0tIA0KSmVucyBBeGJvZQ0KDQo=
