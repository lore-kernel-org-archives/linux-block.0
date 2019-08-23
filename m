Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB970C3A5A4
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 16:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F00722CEC
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 16:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eAPWsKdU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PJ0jGxpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436806AbfHWQhf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:37:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390933AbfHWQhf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 12:37:35 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x7NGYUNV006428;
        Fri, 23 Aug 2019 09:37:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=S7dohe8uITRs+AHJftfknOpf2FxvOuDwhIPSj5VoGwg=;
 b=eAPWsKdUr/fguWop9q62iuhUhuH2Dc7QjXrc8Ju9Sp89z5mYdxpCZnyDJaHFdFo0+bfe
 z8CYDBDo9cl+ae4yeEcjYbJtewxi3zoIxh3s15iEv15yCHlRT/n8l6S9naiUxXgfTn9n
 Ssy62f9p1wMAN8r22zGPRTA3PMSnkuhFlzs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2ujjnm8b51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Aug 2019 09:37:29 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 23 Aug 2019 09:37:28 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 23 Aug 2019 09:37:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2mrc2616QymdEdfBUfa77PcAdN8Xsco1/bmW7aVs7snD/sjs+a8Umwt99nRNN/ogpYB8t19M0SnE3u5LLn0OUvK1ZxNVz+4RiD54DqVpObv7LxnZ3akB9gk4+v/WpgAnqJjf++HHuAUjA/NjzIqzybLI4NZAgkGSNmufBNvt6SrGmf9T3h22TEqX5ahIiXmCtNORNJwtLvp4swwHvmbl0XPLBgHywOOaEff9dCAgsll4zAWOr0/rEPNBbdUwlqLAFyAqTUMflSV+PJYi7uVQphOzKV0TKpDLCsg/bR+ZlDbZAecmRtt04J6vOLuRX+4qIi8PspZ+HFroBr4mwx/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7dohe8uITRs+AHJftfknOpf2FxvOuDwhIPSj5VoGwg=;
 b=gcgcqj6/CzyDVgZWAwPyuQYDh5pbVakgyS/lHomeIZeencs8NybgJp/1mN2S7SRt3SGIcBbQ7QeKMBN4uQoHcsuMF61MNxcZWeG2JUadSJ/R7V4U15s0f78orivf99GeJ2B7ttqxqE/vVfc0jqyXnG28TeGoTP+I3hxFKhe7wyEbImHMvS3ULKq7H8WLDugDRZ13wBY+kcRBiivdAq+FvoR1/B5WBFhYO3J72h1g6ZT0G2SMxlvnCkMCSdZprQeqxQG+9EoQFb5Oj0AM5qbuD7lKD0577vq1LeRFKt07NX15dK6A0ZX3I2Nb+jJzI3t0Co8a0Ne9Z1g71GvTYgQjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7dohe8uITRs+AHJftfknOpf2FxvOuDwhIPSj5VoGwg=;
 b=PJ0jGxpNOsnku4oFyzHx2t3kyxwLj09t3X0LNo8unmPppUdrN4Kr7F6nwgX48jy8xvXKbi3rlCM9eGW5WlpBlc8JACpZ3vx4KuAMB5PwjT85piOyC8SuFU55mVzX1MxVKHlpKAumRbtzmBtfkNdM2yRg5ZkbG+WByFRjhiEiydg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1728.namprd15.prod.outlook.com (10.174.98.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 16:37:26 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 16:37:26 +0000
From:   Song Liu <songliubraving@fb.com>
To:     NeilBrown <neilb@suse.com>
CC:     Coly Li <colyli@suse.de>, linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC] How to handle an ugly md raid0 sector map bug ?
Thread-Topic: [RFC] How to handle an ugly md raid0 sector map bug ?
Thread-Index: AQHVWNXFc8cICUByoEiFXxVSkRSaLqcH2lYAgAEWFYA=
Date:   Fri, 23 Aug 2019 16:37:26 +0000
Message-ID: <FBF1B443-64C9-472A-9F41-5303738C0DC7@fb.com>
References: <10ca59ff-f1ba-1464-030a-0d73ff25d2de@suse.de>
 <87blwghhq7.fsf@notabene.neil.brown.name>
In-Reply-To: <87blwghhq7.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::333a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10955a99-be48-48ae-8bc7-08d727e82eda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1728;
x-ms-traffictypediagnostic: MWHPR15MB1728:
x-microsoft-antispam-prvs: <MWHPR15MB1728B2D67D327EE22BA78C08B3A40@MWHPR15MB1728.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(189003)(46003)(53936002)(8676002)(81166006)(6116002)(6246003)(2906002)(81156014)(8936002)(2616005)(476003)(25786009)(6436002)(76116006)(4326008)(5660300002)(66476007)(66946007)(66556008)(66446008)(486006)(64756008)(316002)(6486002)(6916009)(57306001)(6512007)(36756003)(86362001)(76176011)(99286004)(50226002)(54906003)(229853002)(102836004)(305945005)(256004)(14444005)(7736002)(6506007)(53546011)(186003)(33656002)(14454004)(478600001)(446003)(11346002)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1728;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lh0ig04HNWqTIVf4FOHDWbentFfBGXmf6Gz47XPtGQ0DRvHDGtGZ9cfYCoCZnoyMaLS8FPJzWDai4xmOPOWpcV1no/qQ6b+6xhnfazrkgWRgM37+cMKsNayiOiYb0i6jOTHhEUjyMY/bhT9OT1vL6jHiVya5rZLCATM5Dn1nElfPuHUDa73lISyCP/Yd+9Ty2RVrVvWS2yIRFYyCQTj6xUleQ+HtjOyYTZqP5HvfL/bgUtw4W2SoaMtkR7xvMM+88f1QY8v+shHt1HLHW5g22c5r4Gz6Wap1qjCO0J2VM0SP2Kza0UcKPCfoHy608A0k3KRwap2jLjoSkZ4A7qyvslW8efYr6aEH9k/SY9n25p3u5WRWtiHEn/Id+Ugm3fGnedvzLIyKayijETqLECXPUsn85dzaJmg+aWHKW9jnDqg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <437C62CD0A0963469347DBC7388614D2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10955a99-be48-48ae-8bc7-08d727e82eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 16:37:26.6930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lS2KAFhhdnfKZlnE2HQ9CRMUOzY9fa0/8v6wKVCFZpnEhRtC+Y4h+MH7dRPps8L/UbEJgBVolGa9s2+u8hKa6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1728
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230162
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Coly and Neil.=20

> On Aug 22, 2019, at 5:02 PM, NeilBrown <neilb@suse.com> wrote:
>=20
> On Thu, Aug 22 2019, Coly Li wrote:
>=20
>> Hi folks,
>>=20
>> First line: This bug only influences md raid0 device which applies all
>> the following conditions,
>> 1) Assembled by component disks with different sizes.
>> 2) Created and used under Linux kernel before (including) Linux v3.12,
>> then upgrade to Linux kernel after (including) Linux v3.13.
>> 3) New data are written to md raid0 in new kernel >=3D Linux v3.13.
>> Then the md raid0 may have inconsistent sector mapping and experience
>> data corruption.
>>=20
>> Recently I receive a bug report that customer encounter file system
>> corruption after upgrading their kernel from Linux 3.12 to 4.4. It turns
>> out to be the underlying md raid0 corruption after the kernel upgrade.
>>=20
>> I find it is because a sector map bug in md raid0 code include and
>> before Linux v3.12. Here is the buggy code piece I copied from stable
>> Linux v3.12.74 drivers/md/raid0.c:raid0_make_request(),
>>=20
>> 547         sector_offset =3D bio->bi_sector;
>> 548         zone =3D find_zone(mddev->private, &sector_offset);
>> 549         tmp_dev =3D map_sector(mddev, zone, bio->bi_sector,
>> 550                              &sector_offset);
>=20
> I don't think this code is buggy.  The mapping may not be the mapping
> you would expect, but it is the mapping that md/raid0 had always used up
> to this time.
>=20
>>=20
>> At line 548 after find_zone() returns, sector_offset is updated to be an
>> offset inside current zone. Then at line 549 the third parameter of
>> calling map_sector() should be the updated sector_offset, but
>> bio->bi_sector (original LBA or md raid0 device) is used. If the raid0
>> device has *multiple zones*, except the first zone, the mapping <dev,
>> sector> pair returned by map_sector() for all rested zones are
>> unexpected and wrong.
>>=20
>> The buggy code was introduced since Linux v2.6.31 in commit fbb704efb784
>> ("md: raid0 :Enables chunk size other than powers of 2."), unfortunate
>> the mistaken mapping calculation has stable and unique result too, so it
>> works without obvious problem until commit 20d0189b1012 ("block:
>> Introduce new bio_split()") merged into Linux v3.13.
>>=20
>> This patch fixed the mistaken mapping in the following lines of change,
>> 654 -       sector_offset =3D bio->bi_iter.bi_sector;
>> 655 -       zone =3D find_zone(mddev->private, &sector_offset);
>> 656 -       tmp_dev =3D map_sector(mddev, zone, bio->bi_iter.bi_sector,
>> 657 -                            &sector_offset);
>>=20
>> 694 +               zone =3D find_zone(mddev->private, &sector);
>> 695 +               tmp_dev =3D map_sector(mddev, zone, sector, &sector)=
;
>> At line 695 of this patch, the third parameter of calling map_sector()
>> is fixed to 'sector', this is the correct value which contains the
>> sector offset inside the corresponding zone.
>=20
> This is buggy because, as you say, the third argument to map_sector has
> changed.
> Previously it was bio->bi_iter.bi_sector.  Now it is 'sector' which
> find_zone has just modified.
>=20
>>=20
>> The this patch implicitly *changes* md raid0 on-disk layout. If a md
>> raid0 has component disks with *different* sizes, then it will contain
>> multiple zones. If such multiple zones raid0 device is created before
>> Linux v3.13, all data chunks after first zone will be mapped to
>> different location in kernel after (including) Linux v3.13. The result
>> is, data written in the LBA after first zone will be treated as
>> corruption. A worse case is, if the md raid0 has data chunks filled in
>> first md raid0 zone in Linux v3.12 (or earlier kernels), then update to
>> Linux v3.13 (or later kernels) and fill more data chunks in second and
>> rested zone. Then in neither Linux v3.12 no Linux v3.13, there is always
>> partial data corrupted.
>>=20
>> Currently there is no way to tell whether a md raid0 device is mapped in
>> wrong calculation in kernel before (including) Linux v3.12 or in correct
>> calculation in kernels after (including) Linux v3.13. If a md raid0
>> device (contains multiple zones) created and used crossing these kernel
>> version, there is possibility and different mapping calculation
>> generation different/inconsistent on-disk layout in different md raid0
>> zones, and results data corruption.
>>=20
>> For our enterprise Linux products we can handle it properly for a few
>> product number of kernels. But for upstream and stable kernels, I don't
>> have idea how to fix this ugly problem in a generic way.
>>=20
>> Neil Brown discussed with me offline, he proposed a temporary workaround
>> that only permit to assemble md raid0 device with identical component
>> disk size, and reject to assemble md raid0 device with component disks
>> with different sizes. We can stop this workaround when there is a proper
>> way to fix the problem.
>>=20
>> I suggest our developer community to work together for a solution, this
>> is the motivation I post this email for your comments.
>=20
> There are four separate cases that we need to consider:
> - v1.x metadata
> - v0.90 metadata
> - LVM metadata (via dm-raid)
> - no metadata (array created with "mdadm --build").
>=20
> For v1.x metadata, I think we can add a new "feature_map" flag.
> If this flag isn't set, raid0 with non-uniform device sizes will not be
> assembled.
> If it is set, then:
>  if 'layout' is 0, use the old mapping
>  if 'layout' is 1, use the new mapping
>=20
> For v0.90 metadata we don't have feature-flags.  We could
> The gvalid_words field is unused and always set to zero.
> So we could start storing some feature bits there.
>=20
> For LVM/dm-raid, I suspect it doesn't support varying
> sized devices, but we would need to check.
>=20
> For "no metadata" arrays ... we could possibly just stop supporting
> them - I doubt they are used much.

So for an existing array, we really cannot tell whether it is broken or=20
not, right? If this is the case, we only need to worry about new arrays.

For new arrays, I guess we can only allow v1.x raid0 to have non-uniform
devices sizes, and use the new feature_map bit.=20

Would this work? If so, we only have 1 case to work on.=20

Thanks,
Song
