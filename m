Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D4FC3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 18:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7020622CEB
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 18:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="roUApnaF";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HZOfpqpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfHSS5R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:57:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727957AbfHSS5R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 14:57:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JIgviV020701;
        Mon, 19 Aug 2019 11:57:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HemAzY1xqV3LbQHU39NMEHvxOrQpU3qZPtC7PFBUnIg=;
 b=roUApnaFvJ0p6ac7HDMwTk8x3QK70jsM7Esign/PvjlBo93u3jPqMGVk/9xpn7NF02Do
 DH9rwiG2xADW6J+g8/wRRxYBXS5nXVUkZK+6+/EQh+ehNvMFqHuZGDnr8HwCupX38oVY
 3ZKT9KZZpY1xOAGfBVV8Pg+tTm76z6D29zk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ufxcp0wp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 11:57:07 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 19 Aug 2019 11:57:06 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 19 Aug 2019 11:57:06 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 19 Aug 2019 11:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws1D4v9ObgXFLYmL6PcMgNdi+BZ6rgzvs2D6MVn3L6VXE6FrnwhnxKVShJh/uGYynbOYT1RcbBcuc28nONc9Vw8mg+W60drQPPHNJ2m9YQg1KlH479pV536mqd6+AoPUX7WrD+LOzn3Np0hUHj3nZXf3DBVilwN2TdGLp57p111/pJTsQ+6ae2r8tVXF4D/jZ3JRxaLqNCTR8d3DoBsTLcS5d1f5h2+LQRcSYE0tK9l/Mx16v56NDrHNRIkzVR6wIzbqi+uTvGz14hxxHy4A1AxEJQo//Vknv4CGC+cQPR1fKsydBFpOZKrA5Qcb6Mcn4nlGy9Xwd/9rE7wPc6eDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HemAzY1xqV3LbQHU39NMEHvxOrQpU3qZPtC7PFBUnIg=;
 b=DOA53sOT1sspT2JdaaFpT3i9r4oYoFU/fVO5txM6GOmwUD9mpv2HFRk8+XfOM7X3Z6ofd2AseGZLYAmdKgtK49+fk2SjVYrgDvK3zAONb1YaQCDqrfqafuwjeXH+iwhqqlqQ4gAB4CoKbElnTmo2EGHsjU3Ho4S4tOlANsxl/m3XvOqeMbI84XtOovCfAYmmFaO5exQebJIlLmJln7gWG2Hz3e+OlrUvRbbsJHP0diM/8g7Uo7XHwPPXiJ7jCt506Cqza7UzmfamFu0hnaFWB8sNpF9miIHS7E4PwFlnqiTLXfZAVttQsc97LOOXn12ZrSWuWmd0N7Lm6mROReuOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HemAzY1xqV3LbQHU39NMEHvxOrQpU3qZPtC7PFBUnIg=;
 b=HZOfpqpEzekHVvTyx4uXV0EEeX+InfwBwsh3iLOmPPuG90CAr1GSLCEN1tzn+ufv2rQgCnMMDZW6KTaFQz1pGYKH8QSddYec0umD6corv+7EXRfyT3dU/p3mO/QvgiryFyv9eN+LoWsrmGM74dqTVwc8e2JVpl89Fk7pc89oct0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1616.namprd15.prod.outlook.com (10.175.142.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 18:57:05 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 18:57:04 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
CC:     Song Liu <liu.song.a23@gmail.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v2 1/2] md raid0/linear: Introduce new array state
 'broken'
Thread-Topic: [PATCH v2 1/2] md raid0/linear: Introduce new array state
 'broken'
Thread-Index: AQHVVDhL8QBv9Z+6F0SUg0XP9Q0BPacCynMAgAAFiwCAAAdYgA==
Date:   Mon, 19 Aug 2019 18:57:04 +0000
Message-ID: <1725F15D-7CA2-4B8D-949A-4D8078D53AA9@fb.com>
References: <20190816134059.29751-1-gpiccoli@canonical.com>
 <CAPhsuW7aGze5p9DgNAe=KakJGXTNqRZpNCtvi8nKxzS2MPXrNQ@mail.gmail.com>
 <1f16110b-b798-806f-638b-57bbbedfea49@canonical.com>
In-Reply-To: <1f16110b-b798-806f-638b-57bbbedfea49@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:a981]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28c7ad66-b0b9-4019-ff2f-08d724d706f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1616;
x-ms-traffictypediagnostic: MWHPR15MB1616:
x-microsoft-antispam-prvs: <MWHPR15MB16160A09E6F0E0E52CC52341B3A80@MWHPR15MB1616.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(316002)(50226002)(99286004)(6486002)(478600001)(2906002)(71200400001)(86362001)(14454004)(71190400001)(54906003)(76176011)(229853002)(4744005)(8936002)(6436002)(76116006)(6916009)(66946007)(305945005)(81156014)(8676002)(66446008)(64756008)(81166006)(66556008)(66476007)(33656002)(6116002)(5660300002)(7736002)(186003)(57306001)(36756003)(102836004)(446003)(6246003)(46003)(6512007)(11346002)(53936002)(486006)(6506007)(2616005)(476003)(256004)(53546011)(25786009)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1616;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3cEvZHwSWK/qSUbeEIy2jiYl23YVwb77d02ZjD1GvFLHy37qqQqSopJzraVTakPluJbeHQBQjVPNPzD432nio+TmxRWgtzumW8s57Vg0HJX809nHLg8LmyY960tGglkikgH5vBONqIw2Zt/rbrGVhHV26O2ZljchDG9d15OzAUhgXMgC55K9f41MZV8qDwfU7BPe5zpEn/t8Z0LQeDTIc9qLkLP8daejJ3ARN/V3vMda9N+C8kRdewgY+tkGaN38iG9tqO2YLRZmTK2Bykk7a5P+no1wJlmOlW3uKFR3xXGuHo7GVIucHFR3xbOmgZpl7cNhTE6Spbp/fyLNuXQ21Zh+ye/VM2FGpfTeRYCV8Z+aOTQA44QEFkVupV/HD61l6LzeGC1DSb/s6a6YOZDfmBypGK7PYd2StnF1fI3EZZs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <551F59B2A4275A44AFBDA837E62AB277@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c7ad66-b0b9-4019-ff2f-08d724d706f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 18:57:04.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqd4WNwnQSwL2GqDaSwAhON+78Bb3+An3n5qhD8eQA5S4Uo1lcB5A1M9rQV00zysNqwoRjfDE6K6xrWf0w/Dpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1616
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190193
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Aug 19, 2019, at 11:30 AM, Guilherme G. Piccoli <gpiccoli@canonical.co=
m> wrote:
>=20
> On 19/08/2019 15:10, Song Liu wrote:
>> [...]
>>=20
>> If we merge this with the MD_BROKEN patch, would the code look simpler?
>>=20
>> Thanks,
>> Song
>>=20
>=20
> Hi Song, I don't believe it changes the complexity/"appearance" of the
> code. Both patches are "relatives" in the ideas' realm, but their code
> is different in nature. My goal in splitting them was to make more
> bisect-able changes.
>=20
> But feel free to merge them in a single patch or let me know if you
> prefer that way and I can do it.
>=20
> There's also a chance I haven't understood your statement/question
> correctly heh - if that's the case, please clarify me!

I was thinking, if we can set MD_BROKEN when the device fails, we can=20
just test MD_BROKEN in array_state_show() (instead of iterating through=20
all devices).=20

Would this work?

Thanks,
Song=
