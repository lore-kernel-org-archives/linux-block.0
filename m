Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F10C3A5A2
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9DA233FD
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 21:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lpV338zF";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bGyQJ6H4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393631AbfHVV40 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:56:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393620AbfHVV40 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 17:56:26 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MLt1po011844;
        Thu, 22 Aug 2019 14:56:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cSvkLX/pqNwP8ZAIDv79N8/fMCzPdL/209qvaGbt6L8=;
 b=lpV338zFaoP9eILlWj7m/57J8QxJnh74atANiRS11MbHBwS2Uij4xSBV3mWlAGsGrSdK
 uxwbFcXmX6HWmCw4SLZGyLj5WJW5wWIT3IGgk3Iyg9EFtPd+t2+8KfVU7tvFKhA85021
 kAbogH5PrVblZo/qQHPreRYE2v/29Oyya4I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2uhxqy1dcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Aug 2019 14:56:19 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 22 Aug 2019 14:56:18 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 22 Aug 2019 14:56:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEKITrMfLZ5eZAkkSNvDBNeMGGlX1o6jNYE8EI6fVAFAFSH77SghRKvUwzicrpZETI5Nz1ZGR2xeFraZacrrVwbZHDZiSJVFebleFw20zfCuqrxhSHnNNVTrfcWu6f/3OgHPaiwfknTRXXk7WSXvWfwg5djk3H9F4eBdAa+MS5zIlg+jqcqUHPQ239OBARnZXZ3160MMcAVi4CPSumqPIBwKwakoHJ/NL2fvIxlqSwSmQRTM+wIxmD8S29qocfla0B+e+W1WL1gmRm3flgVyQURQ2gOKY1MfpC9Sci+3C9/k0AAjfckwOnN+GLFd9+y7u67E52pwMIyMCgpsQ6BcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSvkLX/pqNwP8ZAIDv79N8/fMCzPdL/209qvaGbt6L8=;
 b=BNFDtqSDkV9UgcReb5IGam0n71o+S0ulYHl5ElP3Kw2r83jtD/c7oOguZtP6i2ug4yyozfZnH1TnMkdPBzxhNrj11QiwNmEFERj8yL49u0Fyhp2sY06EBDdW+N9CO3lLnCfEChDpqUOwfbo9t5o0lJtXxulBqS3YoDfQ6RaQjSEk85pSAkU0peGSKQMZcMS/U3ChQypp6/SDjePfhJG8VV4X4oFBD7K7ZSgEixVdvpGowZObnUVgt34bGri30o0DaqG6OYl3gumt8RI5QEr+NWq+NYsL9zZ2moRNKQ73Y30NhzugLlMiNNow1N16W0cD1KoeJjS+IixvMMgNje658Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSvkLX/pqNwP8ZAIDv79N8/fMCzPdL/209qvaGbt6L8=;
 b=bGyQJ6H4JceG37StvXJZatx5kli2muQRe9aKmS73l+fuy9IX22V93nFL8ER+BCpYp+3w1BmT7RxzCScC1dHKlUtrLpvtjnnZtwn//IeuWltbPju89juwygDyTTAz/qogGq9g0QIYGYVei1JX5ImGDg9wSgWZdM0prROMjgZCEUw=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1167.namprd15.prod.outlook.com (10.175.3.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 21:56:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 21:56:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Jes Sorensen <jes.sorensen@gmail.com>
CC:     linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "jay.vosburgh@canonical.com" <jay.vosburgh@canonical.com>,
        "liu.song.a23@gmail.com" <liu.song.a23@gmail.com>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v3 2/2] mdadm: Introduce new array state 'broken' for
 raid0/linear
Thread-Topic: [PATCH v3 2/2] mdadm: Introduce new array state 'broken' for
 raid0/linear
Thread-Index: AQHVWQSaVS7Hxt6650SOpD/5Wg3LL6cHts+A
Date:   Thu, 22 Aug 2019 21:56:17 +0000
Message-ID: <060E4BAF-E16D-4ADF-AE93-39097DB739DD@fb.com>
References: <20190822161318.26236-1-gpiccoli@canonical.com>
 <20190822161318.26236-2-gpiccoli@canonical.com>
In-Reply-To: <20190822161318.26236-2-gpiccoli@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::8436]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cf5bbd9-9d34-4b6d-9f9f-08d7274b8f59
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1167;
x-ms-traffictypediagnostic: MWHPR15MB1167:
x-microsoft-antispam-prvs: <MWHPR15MB11677D20DBA6DF6A65A6E929B3A50@MWHPR15MB1167.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39860400002)(346002)(199004)(189003)(102836004)(305945005)(5660300002)(478600001)(53936002)(57306001)(33656002)(6436002)(2906002)(6246003)(6486002)(50226002)(36756003)(6512007)(14454004)(7736002)(64756008)(66476007)(256004)(14444005)(486006)(46003)(446003)(2616005)(11346002)(76176011)(476003)(71190400001)(76116006)(86362001)(66946007)(71200400001)(99286004)(6116002)(110136005)(4326008)(54906003)(25786009)(316002)(8936002)(81156014)(81166006)(8676002)(53546011)(229853002)(6506007)(186003)(66446008)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1167;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eTJn+bjEz3GNn3/wK80nu4HTJUeLVBEl2QnhColujcv1avotxBfNrak44crur5DZkyDcbCIziriQDMATcD4bcJLxtklw0U4HcjuoDq+Yf8nHTvmfP7t5lxLWNUQjWSb4jXDFPN1HAnYRDsaP96uM+LjuwWsDM3Xm4/045vRHcuayOSO0V5doOnsNgFZ0tissTVCnQ/1xs9r9NC9SWJXR+tVbNA43IsbFr8BhKX3nz9wgf0CXEzbOFmjLeg2V5Gr5H7weD+gNj3WEHgWhl0NIELtKv/cJfr/r7dHzo5H6rtoz/oO/DhCqNFARVtoBXi7qO5bSZGujCX/6XTR240rIpuaB/7Mot9u2YLFXxuGu3LXIwr+mAWCb66NU9peMUGYxNkp264oqwN707V5qOMhbE14OHAClyRIkkl12ObkXnTU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A4251BD5941054E95657177F60BA997@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf5bbd9-9d34-4b6d-9f9f-08d7274b8f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 21:56:17.6510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5rB9cv57FKmZT9EOA1Aknpba+0jo1KBiCufJy5ITDR8Hq2kgL3OYNEtgDC3J3K8c87NKYG2g26hmGMa5ssf+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=903 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220192
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Aug 22, 2019, at 9:13 AM, Guilherme G. Piccoli <gpiccoli@canonical.com=
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
> Cc: NeilBrown <neilb@suse.com>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>

CC Jes, who maintains mdadm.=20

