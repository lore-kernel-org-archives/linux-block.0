Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947FBC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 19:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA982064A
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 19:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YUiiSlrh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TO4x1N+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfHUTXP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:23:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42026 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729221AbfHUTXP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 15:23:15 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LJMfUu018765;
        Wed, 21 Aug 2019 12:22:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1hkm4N4H2Iv9ugUTAYzuWVynFqtaTJfOIA/LDSgeR1E=;
 b=YUiiSlrhEHyD2zvP+7sALajkAwB3HC9bdRSZ3IhiIVuIkC+/e246slvVcsqY8cKlHYuz
 XpVgjtyxG3pCL8iruDaBhGmKPQirS1Lu9RD4qbINf9TgiPjRk0nQw8DeNHJ6XKrVXOSl
 5ldFOaYbiSbsB7AhTEUNNk76gb7Lty5IGYo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uhbtg82qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 12:22:46 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 21 Aug 2019 12:22:45 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 21 Aug 2019 12:22:45 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 21 Aug 2019 12:22:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ym3xQ6d7ri+x2eQxTS9PRFrKuYvJR1vPkhaFWG+TPzdEA2ctRmBvfLKWe2zaIAmx+JDoKVrHN3OCfYVeb5TdwoaYnFzl5thzvCrr0/nZ83I7oovB8zsH0DURhFLNosv/UZM9PRyWB6aIDVaSttYlVQmrTabkJyy2ltd9T8VFsjMVYqILGyPxmLcp39lp5E6B22mUsF8ASX3kCS+F7uaco2fvd+eN+owEqMLAwgMJUtTQUu4vnQnLTjNgKWt4Sy3zvsboy6nIv8cMfE25yxSw+Q/uq6JtcLJX39settBmrfljrqW9M4tJID2FQj9CKmLgfxTZlf8xG+IiG5GZfSFntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hkm4N4H2Iv9ugUTAYzuWVynFqtaTJfOIA/LDSgeR1E=;
 b=N0i8li1PqpCFmg4P2mjPoofMl4FlYXFLQBV8nnS0X/7zTt8jSaC/Cg962fZjwGz5QH2sjLGGzIErvPeoYNWihh4OhQRqKF25dW9v8iSvGb5/ZrlChPZkf1aClSKawLe2TskLUHNczG2cFBpivgxRaoZYWp5QyQx6YMQ7Yf0twok4NY/fU9qq8Zz04+cgyJ3gmuAn51rS3Mh3qYTouxBbFDzq1f0i733bZXoayvtNKWKm02N99Lp1tzetq0rTTiPkhXkkdAb4L87bE1j0Qy3chVG4f5I6+z+C+fzxYuewN0Dbl4QUUxTrE7PK+aRjzDhzp+TLrMwzS4gXNk8Z7nYxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hkm4N4H2Iv9ugUTAYzuWVynFqtaTJfOIA/LDSgeR1E=;
 b=TO4x1N+IB2lqu0bqvcE0SlX0RZ/i0JKfGhNBVEtLvsEPF+PX3W6daX8fbuv+hCpqyQunEAXhV5gCzzP3Ya60TYI4fDrDZkiVpDQKs6TAXMvY4jE+QfhujMMj3tFm+0xgEGOK9cECYshitW/UwUiuaUy/Fl6Q249EJTypXobpq2o=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1871.namprd15.prod.outlook.com (10.174.255.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 19:22:43 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 19:22:43 +0000
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
Thread-Index: AQHVVDhL8QBv9Z+6F0SUg0XP9Q0BPacCynMAgAAFiwCAAAdYgIAAA/yAgAAuVwCAAqPugIAAIOWAgAAxWoCAAANVgA==
Date:   Wed, 21 Aug 2019 19:22:43 +0000
Message-ID: <EB40716A-CD63-46B1-97B8-B8C039E08548@fb.com>
References: <20190816134059.29751-1-gpiccoli@canonical.com>
 <CAPhsuW7aGze5p9DgNAe=KakJGXTNqRZpNCtvi8nKxzS2MPXrNQ@mail.gmail.com>
 <1f16110b-b798-806f-638b-57bbbedfea49@canonical.com>
 <1725F15D-7CA2-4B8D-949A-4D8078D53AA9@fb.com>
 <4c95f76c-dfbc-150c-2950-d34521d1e39d@canonical.com>
 <8E880472-67DA-4597-AFAD-0DAFFD223620@fb.com>
 <c35cd395-fc54-24c0-1175-d3ea0ab0413d@canonical.com>
 <B7287054-70AC-47A8-BA5A-4D3D7C3F689F@fb.com>
 <d0a3709e-c3a9-c0b1-c3c1-bf5a6d6932af@canonical.com>
In-Reply-To: <d0a3709e-c3a9-c0b1-c3c1-bf5a6d6932af@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::ede3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17d038a7-bd74-410e-4111-08d7266cf110
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1871;
x-ms-traffictypediagnostic: MWHPR15MB1871:
x-microsoft-antispam-prvs: <MWHPR15MB18719316A64B72FC03152646B3AA0@MWHPR15MB1871.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(376002)(396003)(199004)(189003)(53936002)(305945005)(86362001)(14454004)(486006)(316002)(33656002)(76116006)(6486002)(6916009)(478600001)(6246003)(256004)(99286004)(54906003)(53546011)(66476007)(66946007)(6506007)(102836004)(66556008)(6512007)(2906002)(46003)(71190400001)(186003)(8936002)(2616005)(6116002)(476003)(6436002)(71200400001)(446003)(11346002)(36756003)(57306001)(229853002)(7736002)(76176011)(4326008)(5660300002)(8676002)(64756008)(66446008)(50226002)(81166006)(25786009)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1871;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qeqv0N+yN3035SdOH2LlLgnbvc8XQngKJMUZu0PQkFpaVNUpOYFRQuaXADTqJuPCyjJBKs00eo475Wh3zHgw6KPv4xgmq1I668wjls1Tvo43ZkYJXxaaE+6HSnnNXd47Gurh8Hnq+xfyqGzw+eeLDgRrr1Rugf2gfdFX3Wly+/SORaQ9EMy6WxtbL6IHRfRhMhvXfTjXyDGMh6yGUkNos1y395pe8qVO3Rd7bYQ2DNkDLvlaX30s12wb/mL6mN2wL4ShRKK56V/kC3K5SvkPMfPKdGeSlL2krbygkA0L/aTv4n2yjr6xyd3sNEZYJddRerd14605kLF/b0TzU2V9U2NZHcMHGZpIrC2ge38uSzLKIKkxqhP+LAipk5MqO6TbiUTm6ZLlakXsy+rdwicw1UxNO+jFy20NA9FO9FHYff0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F5C655CFD9F70449BFB4A7427744196@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d038a7-bd74-410e-4111-08d7266cf110
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 19:22:43.7038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZMi8ip4QKM/pE5LkU0VAiSvyCp5HoYxmEoAc7R08dlU1E/3EJITS3lCeEdIlrv2KieayUX7Uz36EgFPcP00lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1871
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210186
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Aug 21, 2019, at 12:10 PM, Guilherme G. Piccoli <gpiccoli@canonical.co=
m> wrote:
>=20
> On 21/08/2019 13:14, Song Liu wrote:
>> [...]=20
>>=20
>> What do you mean by "not clear MD_BROKEN"? Do you mean we need to restar=
t
>> the array?=20
>>=20
>> IOW, the following won't work:
>>=20
>>  mdadm --fail /dev/md0 /dev/sdx
>>  mdadm --remove /dev/md0 /dev/sdx
>>  mdadm --add /dev/md0 /dev/sdx
>>=20
>> And we need the following instead:
>>=20
>>  mdadm --fail /dev/md0 /dev/sdx
>>  mdadm --remove /dev/md0 /dev/sdx
>>  mdadm --stop /dev/md0 /dev/sdx
>>  mdadm --add /dev/md0 /dev/sdx
>>  mdadm --run /dev/md0 /dev/sdx
>>=20
>> Thanks,
>> Song
>>=20
>=20
> Song, I've tried the first procedure (without the --stop) and failed to
> make it work on linear/raid0 arrays, even trying in vanilla kernel.
> What I could do is:
>=20
> 1) Mount an array and while writing, remove a member (nvme1n1 in my
> case); "mdadm --detail md0" will either show 'clean' state or 'broken'
> if we have my patch;
>=20
> 2) Unmount the array and run: "mdadm -If nvme1n1 --path
> pci-0000:00:08.0-nvme-1"
> This will result: "mdadm: set device faulty failed for nvme1n1:  Device
> or resource busy"
> Despite the error, md0 device is gone.
>=20
> 3) echo 1 > /sys/bus/pci/rescan [nvme1 device is back]
>=20
> 4) mdadm -A --scan [md0 is back, with both devices and 'clean' state]
>=20
> So, either if we "--stop" or if we incremental fail a member of the
> array, when it's back the state will be 'clean' and not 'broken'.
> Hence, I don't see a point in clearing the MD_BROKEN flag for
> raid0/linear arrays, nor I see where we could do it.

I think this makes sense. Please send the patch and we can discuss
further while looking at the code.=20

Thanks,
Song


