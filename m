Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E76C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 07:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE8B20675
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 07:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PKxdsCUu";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Le4XRAOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfBUHMc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:12:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbfBUHMb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 02:12:31 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1L7AO4R014620;
        Wed, 20 Feb 2019 23:12:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=QM2KmMktQyTqOkac5MVHVmmOPxAW01oW2lszBWdrgCg=;
 b=PKxdsCUuhk48EEbFh9WBBKcWUmjXEzE+aIhxIyDgAgKTUAyNKzFUcgNJ377A6di//Cns
 6prEk4w+CEKISIJtFyxj5p8w+VkfMLN3FNnK00pyZBvwsZKJ5o0GY+mWbjhN+zMa0Ikm
 mq1xetLc25im0tE/zK5Rl7nZ7Y8OoL82MPA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qsmfj8e6v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 23:12:28 -0800
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 20 Feb 2019 23:12:27 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 20 Feb 2019 23:12:26 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 20 Feb 2019 23:12:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM2KmMktQyTqOkac5MVHVmmOPxAW01oW2lszBWdrgCg=;
 b=Le4XRAODnwFAol7uPG95bFUsSKNdW1hy0WeRayZByh7DvceUxKX/GrqDwis2xTkrO7jdFPA3fQ3+bpy/JrvgqnEggU2kS+9SaFeac83jw2W/tmdt/vjOGdTL9wJbI+ZSLY3EOwACCcyiRsdasfjoJlAAPQhP952sXsOY0Q4uWW4=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1642.namprd15.prod.outlook.com (10.175.105.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 07:12:12 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::c430:ec26:cf33:6560%7]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 07:12:12 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM TOPIC] A little TLC for Discard
Thread-Topic: [LSF/MM TOPIC] A little TLC for Discard
Thread-Index: AQHUyWicz5yTEs4TwE+QtrckK2kzfaXpveaA
Date:   Thu, 21 Feb 2019 07:12:12 +0000
Message-ID: <C0792A38-6393-42F6-8D7F-D4FD87847AE2@fb.com>
References: <20190220220633.GA98019@dennisz-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190220220633.GA98019@dennisz-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
x-originating-ip: [2620:10d:c090:180::1:7f2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1a72b44-4621-49d9-9762-08d697cbe6f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1642;
x-ms-traffictypediagnostic: DM5PR15MB1642:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1642;20:ASVIx2youj982lFmn8zfXnp1zSe8zbc7XPGkFo3e//3r5p7mOkaLX8GoQPgAEmWqlj+dc6nCb7MX9fQgVnxMNyEPrzhMT8FE0qjfydpEMOdkHuIxj0+b0ruMTCGe1IP+ySCjuVt0DYRB5WAf8OLeu6sFneP1fylBlhJIATgyBKE=
x-microsoft-antispam-prvs: <DM5PR15MB1642FB23E1C76DB382AC6F13B37E0@DM5PR15MB1642.namprd15.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(39860400002)(346002)(396003)(53754006)(189003)(199004)(76176011)(6116002)(82746002)(86362001)(97736004)(14454004)(53936002)(966005)(54906003)(316002)(106356001)(99286004)(105586002)(6916009)(256004)(33656002)(561944003)(36756003)(57306001)(186003)(71190400001)(71200400001)(5660300002)(6506007)(2616005)(486006)(25786009)(446003)(476003)(11346002)(53546011)(6512007)(102836004)(83716004)(7736002)(8676002)(6306002)(305945005)(2906002)(46003)(6436002)(4326008)(6246003)(229853002)(478600001)(8936002)(68736007)(81166006)(6486002)(81156014)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1642;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 50y8myGA1VPRYpEm7YKZ+pKZwp2htybAEQKSNSmM5XDzPvOdE2meJ2hcOxHzBRC3GqfzVLqFFe0bGT+aJ9b1wCzqxYfISw+Eyy4aJxj2rem+GKltlPttQ47dCwZEYqkppbaj2uBuRjz+NEIa4FN2uG+uD7cX6Rrbo05EIRphXVtE62NmIZ1g5F0nuATNHi63T7/WIR4SUR3QDjWLSSZ6ppnODHnZoy+mrskDI3K1YB65LFZPLe2XwktDHiB1HYlsRGqYHlywrGBg3K8vT/IWDxR4SpLIkQDhll1qLZW0FE11/AMWl9ePZhn9PDNqGptHpqTSlG/KBHgpJ4114ftMbXy1dtkn3H75K7nSaobE3sLY3JGLVuM5n6BtPIj6S7JcFDOvtaXLi9NXrFo1EE4q21z+mrIzgX/sLETq6x4FA+I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2A474DFB003CA45984FC425824CA7EF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a72b44-4621-49d9-9762-08d697cbe6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 07:12:12.5270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1642
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Feb 20, 2019, at 2:06 PM, Dennis Zhou <dennis@kernel.org> wrote:
>=20
> Hi everyone,
>=20
> Ric proposed a similar topic already [1], but I'd like to just add a
> little more to that discussion with a broader proposal for discussing
> discard.
>=20
> Proposal:
> Discard is a topic that seems to need a little bit of TLC from the
> kernel side. The two main approaches with discard are either to enable
> it as a mount option or to periodically run fstrim. At Facebook, we've
> seen performance wins with both enabling discard and disabling discard
> in favor of fstrim. I would like to find a middle ground where we don't
> have to have application developers performance tune for the hardware.
>=20
> XFS has had async discard support, but it has been problematic for our
> fleet. We were seeing bursts of large discard requests caused by async
> discard in XFS. This resulted in degraded drive performance increasing
> latency for dependent services.
>=20
> An alternative to discard is a filesystem level choice of reusing
> blocks. Rather than immediately issuing a discard, we can choose to
> reuse a block which will cause the underlying FTL to invalidate a block
> that we would have discarded. This saves the work done by the initial
> discard. There will have to be a balance here though with saving discard
> with hopes of reusing it and eventually issuing the discards.
>=20
> Another issue is each drive has its own proprietary FTL which introduces
> a wide variability of performance with discard. Some drives don't need
> discard to perform well and others need discard enabled. There is also a
> class of drives where discard is so not performant that it locks up the
> drive. I would like to discuss how we can quantify this and help tune
> discard within the kernel.
>=20
> In summary, I'd like to explore discard more and understand how we can
> build a more balanced discard experience where end users don't have to
> be super cognizant of the implications on their applications.
>=20
> [1] https://lore.kernel.org/linux-fsdevel/92ab41f7-35bc-0f56-056f-ed88526=
b8ea4@gmail.com/
>=20
> Thanks,
> Dennis

Maybe we should use BPF to handle complexity and variations?

Thanks,
Song=20

