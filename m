Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47637C49ED9
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B92206A5
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 15:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fQFltN1l";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="B/eHwJ3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436647AbfIJPqC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:46:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36734 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbfIJPqB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 11:46:01 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AFjXA1008138;
        Tue, 10 Sep 2019 08:45:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=MqB4O7U0Nqk2CM5qpwFvNPMYBahUgSyopIztqGRrerM=;
 b=fQFltN1lTAc9tPEpyhk/pcV+ZPkM5/wQsVkLfkSxodEnzoYusNFYtz1guBMir9CZqvZP
 nUE5D7IQHcFOQc2LUZXUqBi7jqyez2P1h5jXckdt/osAbNboLd4o52/lRsIgornYQ5Vj
 NrAxy365wr7Dd8q8dKTS+McJgXPz+EnEM+U= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uwrs8njc6-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 08:45:55 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 10 Sep 2019 08:45:37 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Sep 2019 08:45:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBG0kvCin2XA9MFnJpRyK4vhu6PACzS2dQEHKMYAOKejbqmNli8XzzVeWqu6IsrpdGDPbOaTHEe/91WJPZ2w5RxHlTBxeYnn6VLgC3q16TgH3fzFyBWeRXkJ15U2y2S8+vR43m8F/HAI9NIETjAQv1LtYEbK7ZMgSYx5Rd9xoPuZBaSU62mcijve2OpUnkPVLWQztUoJYrGZ5QJ2VFVVWV/uByqOLWKrb32m0KX5w0wKrwNlcRW6OAZPrEPUgUbX62EnVlzTeTOozwHbGQiP03H4XMLLxdj0ohRqPM0Rgdn1JuOWbNa7s9ftfNpWFDGMZ+ZeO2cKGnxrw2JxITd9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqB4O7U0Nqk2CM5qpwFvNPMYBahUgSyopIztqGRrerM=;
 b=kWoOppU4GFvcmkx2Q4i6ShD27gU2FbVkJpbPlO8RIbB31XvLI982M1LbpbxYoNvCMk1ZsJLXGp1xX1gAWt7IPog21fgBvJGNpCKH3pxFFeKjh8RLLfmnoRGRUm59cSMTdKdXmN8n0inZytTwELrMsL/AWn5/b0Bxsd2Vnpw1hc26uJFQFvBADlYgv+eqwUs4VpnjllbybLIVWuKmWOFYC/hieZTg/Fj2SgHzAf0VG8lBLcNrfYfKqxKTO9m+dCq4IMoHpJlvl4St+ZvZ1tBssXmWZBQ3nE2iaMPhuH39soTBYswYZVu1LueRRY5m7yDh3zKIISX9Fyid6czTFEaeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqB4O7U0Nqk2CM5qpwFvNPMYBahUgSyopIztqGRrerM=;
 b=B/eHwJ3JNjZ4k2G3yr6CgzNcSVwdLa/SwXQu/y05IHsUayb9HfZxcofrgiyaMqJhJiQFvR3JsuWmezbmPffrRshlSZDdf9Ps6IzthA0tgpLtrGFhaQRhnIejKRapL5FrUWPuw7z8mDncWVes8b5HB8z2VB7+RtLo5/Qq9fgaJ1s=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1727.namprd15.prod.outlook.com (10.174.96.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Tue, 10 Sep 2019 15:45:36 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 15:45:36 +0000
From:   Song Liu <songliubraving@fb.com>
To:     NeilBrown <neilb@suse.de>, Guoqing Jiang <jgq516@gmail.com>
CC:     Coly Li <colyli@suse.de>, NeilBrown <neilb@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH] md/raid0: avoid RAID0 data corruption due to layout
 confusion.
Thread-Topic: [PATCH] md/raid0: avoid RAID0 data corruption due to layout
 confusion.
Thread-Index: AQHVZtvuq+/vbU8ZR0SmUI7K9ys1D6cjb+CAgACQdACAAQ+GgA==
Date:   Tue, 10 Sep 2019 15:45:36 +0000
Message-ID: <33AD3B45-E20D-4019-91FA-CA90B9B3C3A9@fb.com>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de>
 <87blwghhq7.fsf@notabene.neil.brown.name>
 <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com>
 <f3c41c4b-5b1d-bd2f-ad2d-9aa5108ad798@suse.de>
 <9008538C-A2BE-429C-A90E-18FBB91E7B34@fb.com>
 <bede41a5-45c5-0ea0-25af-964bb854a94c@suse.de>
 <87pnkaardl.fsf@notabene.neil.brown.name>
 <242E3FBD-C969-44E1-8DC7-BFE9E7CBE7FD@fb.com>
 <87ftl5avtx.fsf@notabene.neil.brown.name>
In-Reply-To: <87ftl5avtx.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c092:180::1:cd76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bdff2e5-de21-4a2d-4772-08d73605ec5f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1727;
x-ms-traffictypediagnostic: MWHPR15MB1727:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1727451ECA7C48BAA5DC04DEB3B60@MWHPR15MB1727.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(136003)(346002)(51914003)(199004)(189003)(46003)(2616005)(53936002)(86362001)(486006)(476003)(446003)(6246003)(11346002)(33656002)(6486002)(71200400001)(71190400001)(5660300002)(256004)(6306002)(25786009)(229853002)(4326008)(6512007)(91956017)(66556008)(66476007)(64756008)(50226002)(76116006)(66446008)(99286004)(14454004)(966005)(76176011)(8936002)(54906003)(478600001)(7736002)(305945005)(6436002)(8676002)(81156014)(186003)(6116002)(81166006)(2906002)(36756003)(6506007)(53546011)(102836004)(66946007)(110136005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1727;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sNX/WqircJOekVfo8hHlZEG6mn875O5aIx2gYUxkxh5GamzjFB0AazZhMkHACsXjFzAElqpNvAw6eRROrvxJKsW8p77D14IdfgS1Q0fZ4hTKAPEAUaKD/PsNpDHSPTTIhCdh+FqEJUy4cKbge7r5tTRs3e1WHCwhykVM9n6bq6Bbv/YfeomWhGlGNxEQgGmNqp0MqZhGzeVkfxVmSFuqSBH8+LzL1V2JaYL/ZQSYGfnBLK89m4PXbNfk5j6aTXQvLokHeMtcwvH5VmwVc6AziKeKF3RUAymtNVLjR+3zCCGpELjqPsDFQr9uOgPdT/vP6Z9lXwnkgvn1EuP2HfqK9+pU8XLP4+r1r/5iJBGe2RUsM4F5kNAylGlG0vkVDZvUEHphEbD2E1QfX+aQYV9hgIiHPbt/0m3qTIMqq7AbE+E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D15D8757B3FC1546BD475AEB07161B59@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdff2e5-de21-4a2d-4772-08d73605ec5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 15:45:36.3058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yY2YtLB44hbbBsdtAFvbXMIrCC7WQ8jDmXLVLf6+YCQFR9si+qxOJe87CGntbIaALBscNACRdxUOxk/BsusqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1727
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_11:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100149
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Sep 10, 2019, at 12:33 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Mon, Sep 09 2019, Song Liu wrote:
>=20
>> Hi Neil,
>>=20
>>> On Sep 9, 2019, at 7:57 AM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>>=20
>>> If the drives in a RAID0 are not all the same size, the array is
>>> divided into zones.
>>> The first zone covers all drives, to the size of the smallest.
>>> The second zone covers all drives larger than the smallest, up to
>>> the size of the second smallest - etc.
>>>=20
>>> A change in Linux 3.14 unintentionally changed the layout for the
>>> second and subsequent zones.  All the correct data is still stored, but
>>> each chunk may be assigned to a different device than in pre-3.14 kerne=
ls.
>>> This can lead to data corruption.
>>>=20
>>> It is not possible to determine what layout to use - it depends which
>>> kernel the data was written by.
>>> So we add a module parameter to allow the old (0) or new (1) layout to =
be
>>> specified, and refused to assemble an affected array if that parameter =
is
>>> not set.
>>>=20
>>> Fixes: 20d0189b1012 ("block: Introduce new bio_split()")
>>> cc: stable@vger.kernel.org (3.14+)
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>=20
>> Thanks for the patches. They look great. However, I am having problem
>> apply them (not sure whether it is a problem on my side). Could you=20
>> please push it somewhere so I can use cherry-pick instead?
>=20
> I rebased them on block/for-next, fixed the problems that Guoqing found,
> and pushed them to=20
>  https://github.com/neilbrown/linux md/raid0
>=20
> NeilBrown

Thanks Neil!

Guoqing, if this looks good, please reply with your Reviewed-by
or Acked-by.=20

Thanks,
Song

