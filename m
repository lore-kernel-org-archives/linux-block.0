Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4D8C3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 21:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7536222CF8
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 21:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Di8Hi0P0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bl9ZEPoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfICV5B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:57:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41374 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbfICV5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Sep 2019 17:57:00 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83LtYvN013876;
        Tue, 3 Sep 2019 14:56:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ryFHb4Q/c8EEyIZNE5ad6Kn69I8Ia0hGduIMd7KO+bY=;
 b=Di8Hi0P0T2ZYoTphkELXRUIy8u+iDztIzf2r3WjRSSBTMQzVZjejxQzzNxfdiVRZKqlC
 oV9y3G0rVTPzbOUrHOHpirigSXjGn29qX2r/B4w+miodQfyKtEfLfTemDJPm2IVbIkpI
 N8mPdyHngSsHo2LrHLIVQ8hfUs6ho1Hbzhs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2usqs7am34-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 14:56:28 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 3 Sep 2019 14:56:27 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 3 Sep 2019 14:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyY2hsWwokI8KXPmK2rb9sMm4Y9OuJxXvLw9SJHc1RBeBQ51KexNPWH1qtzIkvK9f3diUBrRhsx6UirDCkl7pCzQ4Huz++nJMpMd42rHEpwS60KWrKgATEHFvzXcI9Xi/AcSXk0BgbLoVqFiR0uQBWB9BeNbOOiVB5jey80vm2M0bELYeQz+OfpJbay/RL31NQ1K+B+6aA+OaiJ/I3pKz4+sjAZ4l5qjOz87hhCK5z9AQcVXemhXeiUTKtCrtQ9oIh+iCRwDn1vtV6Klt4gklJK4KQEzVu7ITokge0AWwuewsfHje9uAvnAesgX3zbsHdLnZmEYNvpsxodma215kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryFHb4Q/c8EEyIZNE5ad6Kn69I8Ia0hGduIMd7KO+bY=;
 b=geCnnmI/2yWMllbjaFM7VvfoiakiFaPD1VIupKjn/8ljTeZlZKw3JYhjN1bc7Lxx7QOVQUzIoOX4r8XBE/B3fWyFYi3Dthhk/uXK9FgQFzX90WB11o6QzbBceVtDYiWWHpldRzXwdf4LpvXVPaK4BzBO15aJjrYXx9aYesr6SDXchdWw+I8HTYBkgErD5RNYv/g+nMoxjdOT6p6yIpsughxAx7vXQh9Cm0Vt297+MsKJFACwUVASoHR2jqNBppC5YMVf+fI+35AtbuV7QrkKFUnbcVei5UyApUqAbAHHov4+MfGmIgaZ7xgT4QJEOMrPnSX9ZVNWCCBFQbP1i1bm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryFHb4Q/c8EEyIZNE5ad6Kn69I8Ia0hGduIMd7KO+bY=;
 b=bl9ZEPoDqQb8i4CY3OxmhhUvn1cMbf+teFUr/HNXG1uAcaJ6d1+usw24pPhtoEm6O30eIr78/1DssMHl6vjAza8eDxvYsVnd0OJHJ12A6XYoYxz8sr4KiTHXlFdRvj6Lrk2J1wbiiMsg8EsxxXp1cmCfTtKNg3MKV/PhXPYcpgk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1295.namprd15.prod.outlook.com (10.175.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Tue, 3 Sep 2019 21:56:26 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 21:56:26 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jay.vosburgh@canonical.com" <jay.vosburgh@canonical.com>,
        "liu.song.a23@gmail.com" <liu.song.a23@gmail.com>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        "jes.sorensen@gmail.com" <jes.sorensen@gmail.com>,
        NeilBrown <neilb@suse.de>
Subject: Re: [PATCH v4 1/2] md raid0/linear: Mark array as 'broken' and fail
 BIOs if a member is gone
Thread-Topic: [PATCH v4 1/2] md raid0/linear: Mark array as 'broken' and fail
 BIOs if a member is gone
Thread-Index: AQHVYpC0zfxAhEUkzE+4bGia4xat3acaf7qA
Date:   Tue, 3 Sep 2019 21:56:26 +0000
Message-ID: <E393EAA5-6A9D-464A-A70E-56A258559712@fb.com>
References: <20190903194901.13524-1-gpiccoli@canonical.com>
In-Reply-To: <20190903194901.13524-1-gpiccoli@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::1:c3ed]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6f0f101-b8ce-4383-9cf3-08d730b9919d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1295;
x-ms-traffictypediagnostic: MWHPR15MB1295:
x-microsoft-antispam-prvs: <MWHPR15MB1295846D1D2C5084E1808006B3B90@MWHPR15MB1295.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(46003)(186003)(4326008)(99286004)(50226002)(14454004)(478600001)(8936002)(256004)(316002)(14444005)(305945005)(71190400001)(71200400001)(6512007)(7736002)(36756003)(86362001)(102836004)(6246003)(2906002)(54906003)(33656002)(76176011)(5660300002)(486006)(6506007)(76116006)(8676002)(81156014)(6436002)(11346002)(476003)(2616005)(53936002)(81166006)(229853002)(25786009)(446003)(6486002)(6916009)(66946007)(66446008)(64756008)(66556008)(66476007)(6116002)(57306001)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1295;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KSs2vdN1Brpd22icsPkDIHhvqa7K7e7N5d9GLtjP97TF/E2Tg8Wv24Wu7X0+otjtdjKDS12V4qBpC429iFrEzDiG37QgBvifTgFQfQ+MSgk219CqAS1bauqtamgdR/vB8HOk9DJFMYR8pl4y98+jJeCbrj2BcZTRTr/yt+FwJWhCTSYeUzybS9ti2+lYuI+Pt02F46e/7A04gZ8TvuJ56hDvJeGANXcAQbAoxhGUXqKkejEK7XFhYsygFT5TNhT1OcImUiBIfB3STXKm6yU52viveJL5puxr1naCUnKO0uFz6F+ieEgG/ew/jbOv1l746qqhN3GN6h/3K2LOmm2fDhkVKqkvGeLmAMA7a72bPd0mWdL76P2xbknrnu+yBX/sHfEeAtxUpK8Jz75JrVJcHGNDgtix+kz7Go9uCQBUcSA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB31AF236DA4D745910BA0DA75430503@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f0f101-b8ce-4383-9cf3-08d730b9919d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 21:56:26.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpRhbbHrKIFhkLabFsm5A0CIP099HUr/r/IkbSXDVM18mkBGzuZ8KSjJeph+bZzp/cdf1pI8Rc55sKAsKuNUlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1295
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_05:2019-09-03,2019-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909030217
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Sep 3, 2019, at 12:49 PM, Guilherme G. Piccoli <gpiccoli@canonical.com=
> wrote:
>=20
> Currently md raid0/linear are not provided with any mechanism to validate
> if an array member got removed or failed. The driver keeps sending BIOs
> regardless of the state of array members, and kernel shows state 'clean'
> in the 'array_state' sysfs attribute. This leads to the following
> situation: if a raid0/linear array member is removed and the array is
> mounted, some user writing to this array won't realize that errors are
> happening unless they check dmesg or perform one fsync per written file.
> Despite udev signaling the member device is gone, 'mdadm' cannot issue th=
e
> STOP_ARRAY ioctl successfully, given the array is mounted.
>=20
> In other words, no -EIO is returned and writes (except direct ones) appea=
r
> normal. Meaning the user might think the wrote data is correctly stored i=
n
> the array, but instead garbage was written given that raid0 does strippin=
g
> (and so, it requires all its members to be working in order to not corrup=
t
> data). For md/linear, writes to the available members will work fine, but
> if the writes go to the missing member(s), it'll cause a file corruption
> situation, whereas the portion of the writes to the missing devices aren'=
t
> written effectively.
>=20
> This patch changes this behavior: we check if the block device's gendisk
> is UP when submitting the BIO to the array member, and if it isn't, we fl=
ag
> the md device as MD_BROKEN and fail subsequent I/Os to that device; a rea=
d
> request to the array requiring data from a valid member is still complete=
d.
> While flagging the device as MD_BROKEN, we also show a rate-limited warni=
ng
> in the kernel log.
>=20
> A new array state 'broken' was added too: it mimics the state 'clean' in
> every aspect, being useful only to distinguish if the array has some memb=
er
> missing. We rely on the MD_BROKEN flag to put the array in the 'broken'
> state. This state cannot be written in 'array_state' as it just shows
> one or more members of the array are missing but acts like 'clean', it
> wouldn't make sense to write it.
>=20
> With this patch, the filesystem reacts much faster to the event of missin=
g
> array member: after some I/O errors, ext4 for instance aborts the journal
> and prevents corruption. Without this change, we're able to keep writing
> in the disk and after a machine reboot, e2fsck shows some severe fs error=
s
> that demand fixing. This patch was tested in ext4 and xfs filesystems, an=
d
> requires a 'mdadm' counterpart to handle the 'broken' state.
>=20
> Cc: Song Liu <songliubraving@fb.com>
> Reviewed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>

Applied to md-next.=20

Thanks!=
