Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B48C3A5A9
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 15:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B134422CF5
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 15:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UAFjtQ3A";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bXK1CEer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfIDPw2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:52:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730384AbfIDPw1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 11:52:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x84FqCaF011552;
        Wed, 4 Sep 2019 08:52:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=I0EqiGf/OE+bKvwpTFSbj449/dU/+SySmyP7VJIM/7s=;
 b=UAFjtQ3Ayf4lmCqZ9vJQub90RKz40o6WXHWSKEPz4DqhH9eBfLZa1qYI0zPy4iTZ/F98
 w5424t8B+FunamAuKWPNhDR7sT8Q/aERuLMRIuhC/7RQ9MiiMgy3R+NDxmAm0kMi/A43
 BkSi+5HN4szJ5bC3viTB8KL4PnCmtPymkPI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2usqs7e6j4-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Sep 2019 08:52:15 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 4 Sep 2019 08:51:52 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 4 Sep 2019 08:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoS486xanOjRG9dU/ahr/qGmI1Yj2ZQiAk4g+HVXhlYDGpUIKKBJ0Dto4ejMtLFyRrRirzQ4HZuS8lVFI5XdvBIbY4VClqGQCErsW2oEoc8mi1o6EhPcQPhqcRaVrdJYg1KyZRoKcWHARpy7MwgUlEuL3M88CxhMeg5QzzWS8a6DBHgvscwA34w/hyzwQtFjbK30xcrPm3HFip/dFlo5WhHZGiDLbydHb/wh0CiLRD2HnEMp7NvdXJ8kzRNSO4fCv46ek4w0t2Ct7OsngcJRgq39rtouLXdHW0yuR6tSIgNdjqjnkO4BwVidwbTCqdmS3KgPxEame80/PfmQayFOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0EqiGf/OE+bKvwpTFSbj449/dU/+SySmyP7VJIM/7s=;
 b=AVmxsjai/7vtgoiLY/47+fk4yNqBm11UIan/Qg/I+ieUFuU1KL2mDjOix/mgBW2+owEPdhKKCovk/36dX3qeXMEKgahWibcfuLypDDdqH0A5HifaXcbQI5o6m8imTWLOw29MPW23N5QH9coFlTi3GGjutg3nkeRv8gEJzC1TFmZpSMi72IdKLyC43SQavjJ92DYpkTAqSexcpZk1/k22cb5xwufIBlSzXRpNDbRe0Zg9pjVmHnpaTRVI0QXwDG75U9UvGYSwJrIlE1U3r5nTLD6Rw3nSvnutJntRQ+tM4s7pjSJVDNgbK8C4AB+v22ivZOT4nMOU3fXR9pw/NRkbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0EqiGf/OE+bKvwpTFSbj449/dU/+SySmyP7VJIM/7s=;
 b=bXK1CEer9yYPOJBboO+2GQhdqqfUmkNCj+JuCswdkaUcAX3FMD0FZi0W2Sy70yWco5yp630oHyW3GLXLsVu9bms4beC2dTMFvCfrGuJe/Y7dG+bu3Fuvkj9/soWuh8JTq61jQ8/uTAyM23Q4SGY6Tx6n0nw4Z6co+XozPYQAfnw=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1854.namprd15.prod.outlook.com (10.174.96.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Wed, 4 Sep 2019 15:51:51 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 15:51:51 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Jes Sorensen <jsorensen@fb.com>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jay.vosburgh@canonical.com" <jay.vosburgh@canonical.com>,
        "liu.song.a23@gmail.com" <liu.song.a23@gmail.com>,
        "nfbrown@suse.com" <nfbrown@suse.com>,
        "jes.sorensen@gmail.com" <jes.sorensen@gmail.com>,
        NeilBrown <neilb@suse.de>
Subject: Re: [PATCH v4 2/2] mdadm: Introduce new array state 'broken' for
 raid0/linear
Thread-Topic: [PATCH v4 2/2] mdadm: Introduce new array state 'broken' for
 raid0/linear
Thread-Index: AQHVYpC9BL+movukAkyf47O/zAZ5aqcbrDIA
Date:   Wed, 4 Sep 2019 15:51:51 +0000
Message-ID: <A0D1B6AB-50CF-4B38-8452-A4E18AFDC8EB@fb.com>
References: <20190903194901.13524-1-gpiccoli@canonical.com>
 <20190903194901.13524-2-gpiccoli@canonical.com>
In-Reply-To: <20190903194901.13524-2-gpiccoli@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::f079]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e56be0d2-07d8-42fb-2978-08d7314fcdad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1854;
x-ms-traffictypediagnostic: MWHPR15MB1854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB185489B2757BAFADCC49169DB3B80@MWHPR15MB1854.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(50226002)(4326008)(81166006)(14454004)(7736002)(305945005)(81156014)(99286004)(6246003)(76176011)(86362001)(53936002)(229853002)(6636002)(66446008)(486006)(33656002)(316002)(476003)(14444005)(256004)(8936002)(446003)(2906002)(6486002)(54906003)(110136005)(2616005)(6436002)(6506007)(6512007)(11346002)(53546011)(57306001)(71190400001)(46003)(71200400001)(102836004)(8676002)(6116002)(66476007)(66556008)(478600001)(64756008)(5660300002)(186003)(25786009)(36756003)(76116006)(66946007)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1854;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sUiLnvFFEzs3LiNCqZDp7jqreJi97O/uGimmMu8prSQXVzMgNHwXlULM360uBX+JOm8od2B0+clH52+jfHiaXJT0d4hbZGdni9diAlnvozLvtxEuXdK8kUmRnjMrYk74C85iJRTY6+zQBGEJASGDtcrBqEaiSNpR5yIsCi28ZgNzK6oOlQU8WD9efUgsZi5BMrxSac7ECOywItoELCqSWSNbFaqAlRcxzaTZf4PdHuqJyj+1vShHlp1V/SqUZi83M9EmmIiYIQbTlY6YBQs3fb4nTkcjOHNqN1gFvXoTP7XWztUUBDl5ctuvhisMXa4GEHUq41XFRbcrmHSzF5Abr0jo7Uoq1kJcY9VNT7Co9I3399yYJAdZqLPoSgNTJeXf3NDTBlpEKCuHEeT8AsRxbZ7QRzLXxRyLGUrz6rebuEs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D616B14D23BF49478B91C4E7C7C5D6EC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e56be0d2-07d8-42fb-2978-08d7314fcdad
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 15:51:51.6930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QudCIenIMf9nfb8dCggBbvoXf1rpcUp6ouRnuYcII97QL8R/Wi34dFQhrhJVUK9JnRQJvbVomgZV90P1QtTBpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1854
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_04:2019-09-04,2019-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=955 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909040155
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Sep 3, 2019, at 12:49 PM, Guilherme G. Piccoli <gpiccoli@canonical.com=
> wrote:
>=20
> Currently if a md raid0/linear array gets one or more members removed whi=
le
> being mounted, kernel keeps showing state 'clean' in the 'array_state'
> sysfs attribute. Despite udev signaling the member device is gone, 'mdadm=
'
> cannot issue the STOP_ARRAY ioctl successfully, given the array is mounte=
d.
>=20
> Nothing else hints that something is wrong (except that the removed devic=
es
> don't show properly in the output of mdadm 'detail' command). There is no
> other property to be checked, and if user is not performing reads/writes
> to the array, even kernel log is quiet and doesn't give a clue about the
> missing member.
>=20
> This patch is the mdadm counterpart of kernel new array state 'broken'.
> The 'broken' state mimics the state 'clean' in every aspect, being useful
> only to distinguish if an array has some member missing. All necessary
> paths in mdadm were changed to deal with 'broken' state, and in case the
> tool runs in a kernel that is not updated, it'll work normally, i.e., it
> doesn't require the 'broken' state in order to work.
> Also, this patch changes the way the array state is showed in the 'detail=
'
> command (for raid0/linear only) - now it takes the 'array_state' sysfs
> attribute into account instead of only rely in the MD_SB_CLEAN flag.
>=20
> Cc: Jes Sorensen <jes.sorensen@gmail.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>

Acked-by: Song Liu <songliubraving@fb.com>

Jes, does this look good?

Thanks,
Song=
