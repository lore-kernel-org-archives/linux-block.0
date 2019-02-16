Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9CDC43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 00:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66885222D0
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 00:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ELQf2rzc";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="h1bNUHbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbfBPA4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:56:22 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:41974 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726874AbfBPA4V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 19:56:21 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1G0oCKo004921;
        Fri, 15 Feb 2019 16:56:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Is+aP/eGGyr15NVg+3UjHXKb8RkQHsE+CTg/Z7Th9Gk=;
 b=ELQf2rzcuviR+trkRg+R2nJEY5qUGKuVJwURL1VeOff15vWTfiZTdwIxQs/UFVCAzUs9
 SD5C5gkq8mdNXgzSIRrH3466+uJKBlFcknEu3ajZUjQIJAxOmiifELMk9Fwdy4zKkTfs
 8aBxc+/xHXw5SYUCMX8Hpa4XG0WB7s+t0+Y8JlTOzsox9OvOZsqVhuVvAwlQNV+VeH40
 KGmkIct0CEpHvplYLu0N+Ee9dB2+DWHTbH0gEKM+F9Shrlsyi+tKhXd7CQ5c3Y78EdgK
 yJj7iocA2YQ6CoU6V1cc6ZU0KUVjxgorSrt3oWLtms5Npwt7MrSlGjRPM1+Q03HOYwgB MQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2qp1r7h5b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 16:56:13 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 15 Feb
 2019 16:56:12 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 15 Feb 2019 16:56:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is+aP/eGGyr15NVg+3UjHXKb8RkQHsE+CTg/Z7Th9Gk=;
 b=h1bNUHbpZW1bBX79kukBCX8Ch0bmyh/1EXlM1KjlwUsPSR3J+/WXLApN+zMXM7F45f09O2CLoRWk8bWKOIAjprgb57YnN/137d2V3EUcgqugEhkpEcehdHXyPy6vIFWX4yDzqWIJhPRU+3TQTJgaugQbhsW2mwrJk0xNOjFk+XU=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB2911.namprd18.prod.outlook.com (20.179.23.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.17; Sat, 16 Feb 2019 00:56:09 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::ade0:6f55:b806:f853]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::ade0:6f55:b806:f853%2]) with mapi id 15.20.1622.018; Sat, 16 Feb 2019
 00:56:09 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     Ming Lei <tom.leiming@gmail.com>, Meelis Roos <mroos@linux.ee>
CC:     Giridhar Malavali <gmalavali@marvell.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>,
        Himanshu Madhani <hmadhani@redhat.com>,
        "Ming Lei" <ming.lei@redhat.com>
Subject: Re: qla2xxx init warning with blk_mq at drivers/pci/msi.c:1273
 pci_irq_get_affinity+0xf4/0x120
Thread-Topic: qla2xxx init warning with blk_mq at drivers/pci/msi.c:1273
 pci_irq_get_affinity+0xf4/0x120
Thread-Index: AQHUwTw/T6g3PFHgWUa69clyfwITYaXa+CKAgAGJrICAAIWjAIAEFMcA
Date:   Sat, 16 Feb 2019 00:56:09 +0000
Message-ID: <BCC8BDF9-241A-4186-A73B-DEBEAFB1D3DB@marvell.com>
References: <c58b0ffc-434b-9db4-9ed5-07650368f336@linux.ee>
 <9D8CA1BB-21B3-42AD-B2A7-7986A40C06EB@marvell.com>
 <59ea474f-347e-185b-73c7-7fa7e6cfa7b4@linux.ee>
 <CACVXFVM04AW1vVcX4KCsi7eS1EWZcWkhUGYY5db=LJdmPGE4yw@mail.gmail.com>
In-Reply-To: <CACVXFVM04AW1vVcX4KCsi7eS1EWZcWkhUGYY5db=LJdmPGE4yw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bec5628-c3da-4812-9f32-08d693a98a0f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR18MB2911;
x-ms-traffictypediagnostic: MN2PR18MB2911:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;MN2PR18MB2911;20:Ljc0BV+TLzFzWq+Y9iw1ft6dk0igd4/FwQl9nWf0hDyIx+rOM2AVDnqJjHQ2GZ0vista5DZAQsG+IC9JO9iSDMRf0MxUkZmvYogv+CERsn/suAHchQFHsEFHoJu+ClibiWDqMgBsEkKxpY8+jZ8VnHuY5BM0mKOG0DaAPif/Fvw=
x-microsoft-antispam-prvs: <MN2PR18MB2911ACC59F66ACD029166F80D6610@MN2PR18MB2911.namprd18.prod.outlook.com>
x-forefront-prvs: 0950706AC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(51234002)(81156014)(54906003)(71200400001)(478600001)(14454004)(110136005)(25786009)(68736007)(66066001)(71190400001)(966005)(93886005)(316002)(6246003)(86362001)(97736004)(36756003)(106356001)(256004)(14444005)(105586002)(476003)(229853002)(446003)(6486002)(2906002)(82746002)(76176011)(6506007)(33656002)(83716004)(6436002)(102836004)(81166006)(7736002)(8676002)(8936002)(186003)(486006)(53936002)(4326008)(26005)(99286004)(6116002)(3846002)(53546011)(6306002)(45080400002)(11346002)(6512007)(2616005)(305945005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2911;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jReq7llsLvc5vLlD0j++WDRTG/2WAdzfHf2o2JlOrFLQk78xz4GoxSUIegKSJUjgg8yWfY7Q0knZaFdrn7VSJGS0FheWgyEvBxvpQ2XG+r0H45qiXeoSNGc/qoATDOdCYLKQqFr+cH7Rf65FKYFW6cnX2JLzggutLavP3cKaK0Qurk3+dauc3Ar2Qz1A4b9BKXUqRtJqRtqh03/RohF0wLYZdiV+x8Figc5Xv2w/+r2Jwh+HwqX6Sj8Oj6TGWWBnaKOpqeL1NJo28cWgx5SqBHW1Wy7miTwKddyNSCYReMBa3cuTlC0r6n+HYfOSJQGyJva7QLS+1TJB5tsJeA4ZLVGP4WppVyIETxsiK6O5Gc7zzj1ELfSdtHjAn87LiDJFEJV3RkG6GILlOi2Lo4rF0u8zBjTi9wyQ/005WTS3Vfw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1088A7F48372E543A56D37EB31F701F0@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bec5628-c3da-4812-9f32-08d693a98a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2019 00:56:09.2568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2911
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_17:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=938 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902160003
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgTWVlbGlzLA0KDQoNCu+7v09uIDIvMTIvMTksIDY6MzcgUE0sICJNaW5nIExlaSIgPHRvbS5s
ZWltaW5nQGdtYWlsLmNvbT4gd3JvdGU6DQoNCiAgICBFeHRlcm5hbCBFbWFpbA0KICAgIA0KICAg
IE9uIFdlZCwgRmViIDEzLCAyMDE5IGF0IDU6MzYgQU0gTWVlbGlzIFJvb3MgPG1yb29zQGxpbnV4
LmVlPiB3cm90ZToNCiAgICA+DQogICAgPiA+ICAgICAgSSB0ZXN0ZWQgdG9kYXlzIDUuMC4wLXJj
NS0wMDM1OC1nZGYzODY1ZiBvbiBteSBzcGFyY3MgYW5kIGEgY291cGxlIG9mIHNlcnZlcnMgdGhh
dCBoYXZlIHFsYTJ4eHgNCiAgICA+ID4gICAgICBGQyBhZGFwdGVyIGdhdmUgbWUgdGhpcyB3YXJu
aW5nOg0KICAgID4NCiAgICA+IE5vdyBJIGdvdCBhIHZlcnkgc2ltaWxhciBvbmUgb24gYW4geDg2
LTY0IHNlcnZlcjoNCiAgICA+DQogICAgPg0KICAgID4gWyAgIDE4LjQ3MjU2OF0gcWxhMnh4eCBb
MDAwMDowMDowMC4wXS0wMDA1OiA6IFFMb2dpYyBGaWJyZSBDaGFubmVsIEhCQSBEcml2ZXI6IDEw
LjAwLjAwLjEyLWsuDQogICAgPiBbICAgMTguNDc0MjcyXSBQQ0kgSW50ZXJydXB0IExpbmsgW0xO
S0RdIGVuYWJsZWQgYXQgSVJRIDE5DQogICAgPiBbICAgMTguNDc0MjcyXSBxbGEyeHh4IFswMDAw
OjA0OjAwLjBdLTAwMWQ6IDogRm91bmQgYW4gSVNQMjQzMiBpcnEgMTkgaW9iYXNlIDB4KF9fX19w
dHJ2YWxfX19fKS4NCiAgICA+IFsgICAxOC45MTcyOTNdIHNjc2kgaG9zdDM6IHFsYTJ4eHgNCiAg
ICA+IFsgICAxOC45MTc0MTJdIFdBUk5JTkc6IENQVTogMCBQSUQ6IDE2NTAgYXQgZHJpdmVycy9w
Y2kvbXNpLmM6MTI3MyBwY2lfaXJxX2dldF9hZmZpbml0eSsweDM1LzB4ODANCiAgICA+IFsgICAx
OC45MTc1NTRdIE1vZHVsZXMgbGlua2VkIGluOiBxbGEyeHh4KCspIHNjc2lfdHJhbnNwb3J0X2Zj
IGkyY19uZm9yY2UyIGUxMDAwIHBhdGFfYW1kIGs4dGVtcCBsaWJhdGEgaTJjX2NvcmUgaHdtb24g
Zm9yY2VkZXRoKCspIHBvd2Vybm93X2s4IHBjc3BrciBhdXRvZnM0DQogICAgPiBbICAgMTguOTE3
NzA4XSBDUFU6IDAgUElEOiAxNjUwIENvbW06IGt3b3JrZXIvMDozIE5vdCB0YWludGVkIDUuMC4w
LXJjNi0wMDAxMy1nYWEwYzM4Y2YzOWRlICMxNA0KICAgID4gWyAgIDE4LjkxNzg0OF0gSGFyZHdh
cmUgbmFtZTogU3VuIE1pY3Jvc3lzdGVtcyBTdW4gRmlyZSBYNDIwMCBNMi9TdW4gRmlyZSBYNDIw
MCBNMiAgICAgICAgICAgICAgICAgICAgICAgICwgQklPUyAwQUJKWDEwNCAwNC8wOS8yMDA5DQog
ICAgPiBbICAgMTguOTE4MDAyXSBXb3JrcXVldWU6IGV2ZW50cyB3b3JrX2Zvcl9jcHVfZm4NCiAg
ICA+IFsgICAxOC45MTgwODJdIFJJUDogMDAxMDpwY2lfaXJxX2dldF9hZmZpbml0eSsweDM1LzB4
ODANCiAgICA+IFsgICAxOC45MTgxNjRdIENvZGU6IDJlIDQ4IDhiIDg3IGI4IDAyIDAwIDAwIDQ4
IDhkIDhmIGI4IDAyIDAwIDAwIDQ4IDM5IGMxIDc0IDE2IDg1IGY2IDc0IDRlIDMxIGQyIGViIDA0
IDM5IGQ2IDc0IDQ2IDQ4IDhiIDAwIGZmIGMyIDQ4IDM5IGM4IDc1IGYyIDwwZj4gMGIgMzEgYzAg
YzMgODMgZTIgMDIgNDggYzcgYzAgYzAgNDYgZDUgYjggNzQgMjkgNDggOGIgOTcgYjggMDINCiAg
ICA+IFsgICAxOC45MTgzNzRdIFJTUDogMDAxODpmZmZmYTE1ZjQxMDhmY2IwIEVGTEFHUzogMDAw
MTAyNDYNCiAgICA+IFsgICAxOC45MTg0NjBdIFJBWDogZmZmZjk1ZTc5OTVmNTJiOCBSQlg6IDAw
MDAwMDAwMDAwMDAwMDAgUkNYOiBmZmZmOTVlNzk5NWY1MmI4DQogICAgPiBbICAgMTguOTE4NTQ3
XSBSRFg6IDAwMDAwMDAwMDAwMDAwMDIgUlNJOiAwMDAwMDAwMDAwMDAwMDAyIFJESTogZmZmZjk1
ZTc5OTVmNTAwMA0KICAgID4gWyAgIDE4LjkxODYyOV0gUkJQOiAwMDAwMDAwMDAwMDAwMDAwIFIw
ODogZmZmZmZmZmZmZmZmZmY4MCBSMDk6IGZmZmY5NWU3OTkwMDhlNjANCiAgICA+IFsgICAxOC45
MTg3MTJdIFIxMDogMDAwMDAwMDBiOTBiMGYwMSBSMTE6IGZmZmZhMTVmNDEwOGZhOTAgUjEyOiAw
MDAwMDAwMDAwMDAwMDAyDQogICAgPiBbICAgMTguOTE4Nzk1XSBSMTM6IGZmZmY5NWU3OTk1ZjUw
MDAgUjE0OiAwMDAwMDAwMGZmZmZmZmZmIFIxNTogZmZmZjk1ZTc5Njk4OTBhOA0KICAgID4gWyAg
IDE4LjkxODg3OF0gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY5NWU3OWI0MDAw
MDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KICAgID4gWyAgIDE4LjkxOTAxM10gQ1M6
ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KICAgID4gWyAg
IDE4LjkxOTEwM10gQ1IyOiAwMDAwN2YyMTNmYjYyMDAwIENSMzogMDAwMDAwMDIxN2RjMDAwMCBD
UjQ6IDAwMDAwMDAwMDAwMDA2ZjANCiAgICA+IFsgICAxOC45MTkxODVdIENhbGwgVHJhY2U6DQog
ICAgPiBbICAgMTguOTE5MjY5XSAgYmxrX21xX3BjaV9tYXBfcXVldWVzKzB4MzIvMHhjMA0KICAg
ID4gWyAgIDE4LjkxOTM1NF0gIGJsa19tcV9hbGxvY190YWdfc2V0KzB4MTJlLzB4MzQwDQogICAg
PiBbICAgMTguOTE5NDM3XSAgc2NzaV9hZGRfaG9zdF93aXRoX2RtYSsweGExLzB4MzEwDQogICAg
PiBbICAgMTguOTE5NTQ5XSAgcWxhMngwMF9wcm9iZV9vbmUrMHgxMjcyLzB4MjQwMCBbcWxhMnh4
eF0NCiAgICA+IFsgICAxOC45MTk2MzJdICA/IHRyeV90b193YWtlX3VwKzB4MmM4LzB4NmYwDQog
ICAgPiBbICAgMTguOTE5NzEwXSAgbG9jYWxfcGNpX3Byb2JlKzB4NGIvMHhiMA0KICAgID4gWyAg
IDE4LjkxOTc4N10gIHdvcmtfZm9yX2NwdV9mbisweDExLzB4MjANCiAgICA+IFsgICAxOC45MTk4
NjZdICBwcm9jZXNzX29uZV93b3JrKzB4MWQxLzB4MzYwDQogICAgPiBbICAgMTguOTE5OTQzXSAg
d29ya2VyX3RocmVhZCsweDIwZS8weDNmMA0KICAgID4gWyAgIDE4LjkyMDAyMF0gID8gd3FfY2Fs
Y19ub2RlX2NwdW1hc2srMHgxMTAvMHgxMTANCiAgICA+IFsgICAxOC45MjAxMDBdICBrdGhyZWFk
KzB4MTA5LzB4MTIwDQogICAgPiBbICAgMTguOTIwMTc2XSAgPyBrdGhyZWFkX2NyZWF0ZV9vbl9u
b2RlKzB4NjAvMHg2MA0KICAgID4gWyAgIDE4LjkyMDI1Nl0gIHJldF9mcm9tX2ZvcmsrMHgzNS8w
eDQwDQogICAgPiBbICAgMTguOTIwMzM0XSAtLS1bIGVuZCB0cmFjZSA1NmVkMjgxY2UyYzYxZTY5
IF0tLS0NCiAgICA+IFsgICAxOC45MjY5ODhdIHFsYTJ4eHggWzAwMDA6MDQ6MDAuMF0tMDBmYjoz
OiBRTG9naWMgUUxFMjQ2MCAtIFNHLShYKVBDSUUxRkMtUUY0LCBTdW4gU3RvcmFnZVRlayA0IEdi
IEZDIEVudGVycHJpc2UgUENJLUV4cHJlc3MgU2luZ2xlIENoYW5uZWwuDQogICAgPiBbICAgMTgu
OTI3MTQ4XSBxbGEyeHh4IFswMDAwOjA0OjAwLjBdLTAwZmM6MzogSVNQMjQzMjogUENJZSAoMi41
R1QvcyB4NCkgQCAwMDAwOjA0OjAwLjAgaGRtYSsgaG9zdCM9MyBmdz04LjA3LjAwICg5NDk2KS4N
CiAgICA+IFsgICAxOC45Mjc3NTddIHFsYTJ4eHggWzAwMDA6ODM6MDAuMF0tMDAxZDogOiBGb3Vu
ZCBhbiBJU1AyNDMyIGlycSAzMCBpb2Jhc2UgMHgoX19fX3B0cnZhbF9fX18pLg0KICAgID4gWyAg
IDE5LjM1MDMwM10gcWxhMnh4eCBbMDAwMDo4MzowMC4wXS0wMGZiOjQ6IFFMb2dpYyBRTEUyNDYw
IC0gU0ctKFgpUENJRTFGQy1RRjQsIFN1biBTdG9yYWdlVGVrIDQgR2IgRkMgRW50ZXJwcmlzZSBQ
Q0ktRXhwcmVzcyBTaW5nbGUgQ2hhbm5lbC4NCiAgICA+IFsgICAxOS4zNTA0NzRdIHFsYTJ4eHgg
WzAwMDA6ODM6MDAuMF0tMDBmYzo0OiBJU1AyNDMyOiBQQ0llICgyLjVHVC9zIHg0KSBAIDAwMDA6
ODM6MDAuMCBoZG1hKyBob3N0Iz00IGZ3PTguMDcuMDAgKDk0OTYpLg0KICAgID4gWyAgIDQwLjQy
MTE1MV0gcWxhMnh4eCBbMDAwMDowNDowMC4wXS04MDM4OjM6IENhYmxlIGlzIHVucGx1Z2dlZC4u
Lg0KICAgID4gWyAgIDQwLjgzNzE1OV0gcWxhMnh4eCBbMDAwMDo4MzowMC4wXS04MDM4OjQ6IENh
YmxlIGlzIHVucGx1Z2dlZC4uLg0KICAgIA0KICAgIFdlIHNhdyBzdWNoIGlzc3VlIHRvbyBpbiB3
aGljaCAubXNpeF9jb3VudCBpcyB0b28gc21hbGwsIGFuZCBlcXVhbCB0bw0KICAgIC5wcmVfdmVj
dG9ycywgYW5kIEhpbWFuc2h1IGlzIHdvcmtpbmcgb24gaXQuDQogICAgDQogICAgVGhhbmtzLA0K
ICAgIE1pbmcgTGVpDQogICAgDQpDYW4geW91IHRyeSBwYXRjaCBqdXN0IHBvc3RlZCBoZXJlLg0K
DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwODE2MTE1Lw0KDQpUaGFua3Ms
DQpIaW1hbnNodQ0KDQo=
