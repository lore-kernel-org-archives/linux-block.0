Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3238C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 16:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8565D21738
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 16:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qJWewBNp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fnlPratX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfAIQxx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:53:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54030 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbfAIQxx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jan 2019 11:53:53 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x09GQq7J016661;
        Wed, 9 Jan 2019 08:27:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=d9PFUBXtoaxJfpQ2odYsIUHCCRBlAq+TaZl7uUIz3Cg=;
 b=qJWewBNpQUN7azvTjo8oAVDkak95QMtz/BDlsrDEGjDeIMnTMyra/NGQHiDbRsD+vDRH
 v9B0DT+gT/c6A/DZXPSsXFbejgfKnPMuXd/LTVf8vYfR9HxPFXqvuQsHnKSTnjFPNota
 0W6YK3FbedsARIdBWmDSfMK4l1LNFiIX+6o= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2pwk0r8ceh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Jan 2019 08:27:32 -0800
Received: from frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 9 Jan 2019 08:27:31 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx03.TheFacebook.com (2620:10d:c0a1:f82::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 9 Jan 2019 08:27:31 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 9 Jan 2019 08:27:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9PFUBXtoaxJfpQ2odYsIUHCCRBlAq+TaZl7uUIz3Cg=;
 b=fnlPratX7exPlc0OhF1tR9dvb0gDEogDhkdYQOknFmSxlk6pkL96lYhX/0DpsBpF7i3mlgYDCIG5K3YrbupBR8tmmbzR6DKXYqwj2A77qMhQwu/ATAk0GakkhVj+LgrHv9G5Ec/tRI3M+Icv/wn9M/pRwUXOSATF44vQKtQnSXk=
Received: from DM5PR15MB1883.namprd15.prod.outlook.com (10.174.247.135) by
 DM5PR15MB1114.namprd15.prod.outlook.com (10.173.208.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Wed, 9 Jan 2019 16:27:29 +0000
Received: from DM5PR15MB1883.namprd15.prod.outlook.com
 ([fe80::3873:15f8:b15e:c9d]) by DM5PR15MB1883.namprd15.prod.outlook.com
 ([fe80::3873:15f8:b15e:c9d%2]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 16:27:29 +0000
From:   Chris Mason <clm@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "avi@scylladb.com" <avi@scylladb.com>
Subject: Re: [PATCHSET v1] io_uring IO interface
Thread-Topic: [PATCHSET v1] io_uring IO interface
Thread-Index: AQHUp3M7NOxyAR6/H0C4YAJT6ipU1aWnGgQAgAAHfoA=
Date:   Wed, 9 Jan 2019 16:27:29 +0000
Message-ID: <D240865C-6536-4838-AEEC-683DC45D0E19@fb.com>
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190109160036.GK6310@bombadil.infradead.org>
In-Reply-To: <20190109160036.GK6310@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.3r5579)
x-clientproxiedby: BN6PR0101CA0036.prod.exchangelabs.com
 (2603:10b6:405:2a::49) To DM5PR15MB1883.namprd15.prod.outlook.com
 (2603:10b6:4:4f::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:180::1:8edc]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1114;20:LC5lB1U6sxqSNuhNxoVqWApinfNFSdtb9efZk3af+dcYsZtsEFx546tE20lVBVfOeHdxfD+gv5f7Y3JV1qlUzLZZnXUUozo+KZGJXBVgDmMWAffPuEovC8zmUvZ3c5mo3fC1JHtKreE+7vN7RzPHsDT2jMWa8AR170fzo3XG8b0=
x-ms-office365-filtering-correlation-id: 262964af-4605-4190-d662-08d6764f5914
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1114;
x-ms-traffictypediagnostic: DM5PR15MB1114:
x-microsoft-antispam-prvs: <DM5PR15MB11148AFF03383356E23A499BD38B0@DM5PR15MB1114.namprd15.prod.outlook.com>
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(36756003)(83716004)(71190400001)(71200400001)(256004)(486006)(2616005)(11346002)(478600001)(446003)(97736004)(54906003)(4326008)(6116002)(46003)(316002)(966005)(186003)(25786009)(106356001)(105586002)(53546011)(305945005)(102836004)(7736002)(14454004)(86362001)(6916009)(6486002)(6246003)(229853002)(76176011)(386003)(52116002)(68736007)(5660300001)(6506007)(82746002)(6512007)(50226002)(8936002)(6306002)(2906002)(476003)(8676002)(53936002)(6436002)(99286004)(33656002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1114;H:DM5PR15MB1883.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZFmF75zM90j5651LC04EqySuQwKOj1bZCnsu8owKt3WN9EdIPbSNebA9bKrWTBPzg8nxZOcAHtVhwPOxHGD4oQV33wa3wZ8rPDSYk7v4HjQQS7z8AXEoF59RsrYO0qPQcS0SS6FKoP2NQA1zluzr4ng3Bhql3yr0BNC5gJn0JUg3JlqsfTrSJAc3+GFysNCMNJTO3/8WWbmLLL6W73Ke6b3S1AxXiQi2cWdmy056Ve1AodmQdX3+fNEqnn6HNa1LE10ZYjJq5bU+Om6+o2M1m0Oa4Bm95FiHdSZxPaYbZQtyJQa3z841wTB+gM/kK44X
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 262964af-4605-4190-d662-08d6764f5914
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 16:27:29.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1114
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9 Jan 2019, at 11:00, Matthew Wilcox wrote:

> On Tue, Jan 08, 2019 at 09:56:29AM -0700, Jens Axboe wrote:
>> After some arm twisting from Christoph, I finally caved and divorced=20
>> the
>> aio-poll patches from aio/libaio itself. The io_uring interface=20
>> itself
>> is useful and efficient, and after rebasing all the new goodies on=20
>> top
>> of that, there was little reason to retail the aio connection.
>>
>> Hence io_uring was born. This is what I previously called scqring for
>> aio, but now as a standalone entity. Patch #5 adds the core of this
>> interface, but in short, it has two main data structures:
>
> Please can we call it something that looks a little less like=20
> io_urine?
> aio_ring?  io_ring?  ring_io?

We must be using the same fonts, I've been harassing Jens with jokes=20
about this for days.  But, I totally missed the link between io_uring=20
and https://twitter.com/axboe/status/927571366085246976 until just now. =20
It's clear that Jens has been planning this for over a year, and he was=20
just waiting for us to catch on.


Really though, io_uring is growing on me.  The kernel is full of rings=20
and it does help set it apart.

-chris
