Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C5BC07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 18:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103EA20851
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 18:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="sn6YdPjw";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="JuTT6zAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103EA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeLKSX0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:23:26 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:45814 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbeLKSX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 13:23:26 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBIH9ES015210;
        Tue, 11 Dec 2018 10:22:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=C/LyDRiJZLNVKSqeoHLocP30/+z/L/A/Xb/auia+byg=;
 b=sn6YdPjw2WhEdE5cLfBIhJEzlcyT+UHFaKuOwtIXIM0lDXNWIFovZFL9oGJVK5ErfWOd
 vA8z/dQiwt0PmzoF988qZM8p1BXqbWSP22Oip+xcdqlsTfZJlvXShnyxNnn7iDW/7dQd
 gcHIeJGsrr8ht4UVHT6uXIrN9kFGTKFQcWlb7rqqRVK8DlUBh//gX8ihq3ETGUOUpZwd
 TIRVhY/frzefy7CszRsN3nxEkJdBm7rDTkPOvYWLBlM0n6HukMC6trbPbcZOSmOKbOo8
 XpZrZw+VRGW6mOgdJyet7zp2Xr2zYDRApoZeNYzwOH6RuitdtW8zON7z25zv1V4GAtiO lQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2056.outbound.protection.outlook.com [104.47.38.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2p9wg9drf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Dec 2018 10:22:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/LyDRiJZLNVKSqeoHLocP30/+z/L/A/Xb/auia+byg=;
 b=JuTT6zAo5e7kOW0sZDjV8igDKBdicf4lF6kqVsT4AoW0S1ptXQfkXrkxZcCbQ48PqSxi6JjZAt0bazSw3dv9RK7TMJzVMx7/2h3f1aOg3DFeMMdVFSh9O+ItgFNCoD5EeOMg+Q9qu5+i+5veGKtgi8zE2U7qG8hIdx+g+TyQRDM=
Received: from CO2PR07MB2469.namprd07.prod.outlook.com (10.166.200.139) by
 CO2PR07MB524.namprd07.prod.outlook.com (10.141.198.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 18:22:28 +0000
Received: from CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::406a:f22b:dc72:d2e1]) by CO2PR07MB2469.namprd07.prod.outlook.com
 ([fe80::406a:f22b:dc72:d2e1%9]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 18:22:28 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "jbacik@fb.com" <jbacik@fb.com>,
        "michaelcallahan@fb.com" <michaelcallahan@fb.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shli@fb.com" <shli@fb.com>,
        "dennisszhou@gmail.com" <dennisszhou@gmail.com>,
        Alan Douglas <adouglas@cadence.com>,
        Janek Kotas <jank@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: RE: [PATCH 0/2] scsi: ufs: add real time/inline crypto support to UFS
 HCD
Thread-Topic: [PATCH 0/2] scsi: ufs: add real time/inline crypto support to
 UFS HCD
Thread-Index: AQHUkTbszHelHW686ECcVzKJe8jJIaV5kw+AgAA+49A=
Date:   Tue, 11 Dec 2018 18:22:27 +0000
Message-ID: <CO2PR07MB24692595C49430F56CE5DAC2C1A60@CO2PR07MB2469.namprd07.prod.outlook.com>
References: <20181211094910.GA28288@lvlogina.cadence.com>
 <20181211140643.GA6576@infradead.org>
In-Reply-To: <20181211140643.GA6576@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iNTY5ZGVkZi1mZDcxLTExZTgtODRkZS0xMDY1MzBlNmVmM2VcYW1lLXRlc3RcYjU2OWRlZTAtZmQ3MS0xMWU4LTg0ZGUtMTA2NTMwZTZlZjNlYm9keS50eHQiIHN6PSIyMTY1IiB0PSIxMzE4OTAyNjE0NjMxNTUyMDIiIGg9IjVIem8rWk1LQUJGdFRHbFgxV1BQTWVxTXlqMD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB524;20:Y/TZXZrxj97ZG/aM9QPunfjzlLkNze+SRGZFOcrEgIlTuIogSJi8WPIvO94LiTLQbg3iUlxywf2ALO954EHxhym6pE6PNx+UV45gONNkAqnd64ApsXm0Er9qoxKup7fuYO+PdGJRyZuDoRZYjWDTe2WyZmTKuSahyW46SO98dKzIdlMkBx1jGQu1eKrv7WGk11QRtOrq/GJ5P3BuE67mH1ytAQwcs+V1AQA8NXAiuX+PbloTq7Y4vLXerSotKRkq
x-ms-office365-filtering-correlation-id: 5686e547-f165-4c6b-9184-08d65f959b68
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB524;
x-ms-traffictypediagnostic: CO2PR07MB524:
x-microsoft-antispam-prvs: <CO2PR07MB524095DA3B5EFB07D5ED801C1A60@CO2PR07MB524.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CO2PR07MB524;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB524;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(13464003)(199004)(189003)(36092001)(476003)(53936002)(5660300001)(11346002)(71200400001)(14454004)(6306002)(7416002)(6116002)(3846002)(39060400002)(6246003)(305945005)(966005)(486006)(33656002)(107886003)(74316002)(345774005)(478600001)(68736007)(4326008)(71190400001)(97736004)(105586002)(66066001)(106356001)(7736002)(2906002)(8676002)(81156014)(81166006)(8936002)(256004)(102836004)(55016002)(9686003)(76176011)(6436002)(25786009)(446003)(26005)(54906003)(6916009)(186003)(7696005)(99286004)(229853002)(6506007)(316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB524;H:CO2PR07MB2469.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Bt7dCUyMUK7gGZNnriTVFsLBzTVa+MJOimS74tKwhrUwHk5EO9RReQxvhp1db9N87L025CH7IC0MwTmWe4u7KtqfKUgHtlHEhQDbuos53O0AJNyY9a9JIWeMTli8mt9fiQ31fibODB4CVOdpNtx1LSswE8NkQ6hL8nNOAqxKuRpGFMFM22uYsU8p0ORGRhRf7wX/mP5wmTtbwHBlyzwpFXc7fD69gw5MWrjxg0ZOp/sER82Vg1/yDKTs8YmVx26o+90Q5kXh2oU72k/wG0LvxVPYpIUTD5fClYziBaNhWsWIsTgflMZ7vawGS9BJ5hQs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5686e547-f165-4c6b-9184-08d65f959b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 18:22:27.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB524
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110163
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

Thank you for comments.
My comments are inline below.

Regards,
Parshuram Thombare

>-----Original Message-----
>From: Christoph Hellwig <hch@infradead.org>
>Sent: Tuesday, December 11, 2018 7:37 PM
>To: Parshuram Raju Thombare <pthombar@cadence.com>
>Cc: axboe@kernel.dk; vinholikatti@gmail.com; jejb@linux.vnet.ibm.com;
>martin.petersen@oracle.com; mchehab+samsung@kernel.org;
>gregkh@linuxfoundation.org; davem@davemloft.net; akpm@linux-
>foundation.org; nicolas.ferre@microchip.com; arnd@arndb.de; linux-
>kernel@vger.kernel.org; linux-block@vger.kernel.org; linux-
>scsi@vger.kernel.org; tj@kernel.org; jbacik@fb.com; michaelcallahan@fb.com=
;
>snitzer@redhat.com; osandov@fb.com; keith.busch@intel.com;
>ming.lei@redhat.com; shli@fb.com; dennisszhou@gmail.com; Alan Douglas
><adouglas@cadence.com>; Janek Kotas <jank@cadence.com>; Rafal Ciepiela
><rafalc@cadence.com>
>Subject: Re: [PATCH 0/2] scsi: ufs: add real time/inline crypto support to=
 UFS HCD
>
>EXTERNAL MAIL
>
>
>Patch 1 is missing in your series.
>
>But even without looking at it I think your design doesn't make a whole lo=
t of
>sense.  If the encryption is implemented in the ufs driver you should not =
need
>device mapper support for it, just ufs driver support and maybe a little b=
lock layer
>glue.
[PATCH 1/2]  does nothing more than adding variable in 'struct bio'.=20
Here is link of it.
https://lkml.org/lkml/2018/12/11/193
One reason of using device mapper here is to use existing tools like 'dmset=
up', otherwise=20
some user space application is needed and may be some changes in block laye=
r to=20
pass the crypto information (crypto algorithm, key etc) till ufs driver.
Another reason is supporting multiple UFS devices. I think, as you said UFS=
 crypto support
can be added by some change in ufs driver and block layer glue. But to supp=
ort
multiple UFS crypto devices having different crypto configs (crypto algorit=
hms, key size etc),
crypto context need to be saved per crypto device which may need some chang=
es in block layer code.
