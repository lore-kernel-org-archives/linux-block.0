Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21670C10F14
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 02:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06B120850
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 02:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VjqfRVJK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S7Khxdny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfDOCVa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 22:21:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7246 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOCVa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 22:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555294889; x=1586830889;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9FRBxCuHtxuqKq958Hcwxkm3iGiYtgK4SNy7qGPMepI=;
  b=VjqfRVJKL8PJ1GG2W3toMXMt4f3s7SN//JEEj7wBS7hk3PRL9232qwHC
   fBB5/NRHuGiE0qKI1h4xBx29b0V4OhZk+iEsRwuvu9ZvOlshPyGew4S7x
   ddUyR/8h2OoD5bHA8fCmXNLptAdgudfz8WcGARkZy87dx1MOCePwyxKb7
   4N0TMpbXGDEfhQ2BJ84PI8OKwz7qXhSHeXNy/Vf8NYMGoTY6F+nzKpKrF
   Z+951c6kPT4fEagJqXhIoc6dhlQkQ9LTra5Qbj5DRUoY2oki/Q0Rzv98E
   cD8E0k2vwTCcK2lC2thssOBEZTDjYD0HDTRnfVBFMFydaal7qYfNHXE+G
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,351,1549900800"; 
   d="scan'208";a="107700968"
Received: from mail-cys01nam02lp2058.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.58])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2019 10:21:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOKyU9TQoZ6eueJl2EY3SUn4hlYoSY0kpRWPJuQoMIg=;
 b=S7KhxdnyiVlScNgfewVRB3Mi446tXyUPhyFRHhziTElz8CCKLzzwsGwcMXnroHt1MqrwDuU36BFoe9j2iyP/aS25IlTEgPyVFCaBjURBRxLRCdz21+jtpGWT/AXgZnk4isvKCvdAOxE+rQbvJkkZAJaRsDZPlWM8YvlOqbBQOo8=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4045.namprd04.prod.outlook.com (52.135.82.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 02:21:27 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 02:21:27 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ming Lei <tom.leiming@gmail.com>
CC:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] nvme/012 & 013: avoid extremely slow xfs IO
Thread-Topic: [PATCH] nvme/012 & 013: avoid extremely slow xfs IO
Thread-Index: AQHU8ym7CGbvmSfpy06Znyo5zdBPfw==
Date:   Mon, 15 Apr 2019 02:21:27 +0000
Message-ID: <SN6PR04MB45271891C853B09EFEB0E2A6862B0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190415012229.20689-1-ming.lei@redhat.com>
 <SN6PR04MB4527DD7C84A15184AE5F7947862B0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <CACVXFVMa1Zvqm=GYf=4_oB+wTuoKMGaStfsKSTGBbVKACGvGQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12d74cf1-0c78-41da-ad09-08d6c149108e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB4045;
x-ms-traffictypediagnostic: SN6PR04MB4045:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4045C76C7519C14C130530AF862B0@SN6PR04MB4045.namprd04.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(51914003)(189003)(199004)(74316002)(316002)(14454004)(256004)(86362001)(478600001)(71200400001)(33656002)(72206003)(486006)(3846002)(6916009)(476003)(446003)(186003)(102836004)(26005)(97736004)(229853002)(71190400001)(2906002)(6116002)(6506007)(53546011)(76176011)(105586002)(106356001)(55016002)(52536014)(305945005)(7736002)(6436002)(9686003)(4326008)(5660300002)(53936002)(6246003)(99286004)(8676002)(54906003)(81156014)(81166006)(8936002)(68736007)(66066001)(25786009)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4045;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +YGhjoRjOdcYYTPsq93h5nbCLhf1OzgrcMiVWhBRv24UkUWtVMWyJYhqA5COyHXeEL2SUh3RQfDChh7A14B4mGq330ZcWNC4z6wpKIxPmnXVs5K43ZKOrIeQ/d1swh0svOWjgBDeGraser6elUniI5nFN6QwcO2McwE0e2AqlLX/lRqAaU2didfdv+nFwMKfHokpWB7g8pisa6jP7SAq7mTcypI6EAVX2x1K5B9HWu1LlF77kKq399kYiE4PBj2Q9kvzXDCJ21auq69NreqAtNriVXnOwI0BsjY0nySPVJ4HX7Jqvmo1c0HF1BkZ6e6hKVgJcVVcpjeM9QDtvtDHLgGEAB1t3OWvx5WjQcATrNiO6RKgvzydGIf1jApfQpX8wI5ZV4A3rhdZ93ARL6DJRr6RGkpI5791mI+SW3pZMLM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d74cf1-0c78-41da-ad09-08d6c149108e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 02:21:27.3022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/19 7:11 PM, Ming Lei wrote:=0A=
> On Mon, Apr 15, 2019 at 10:02 AM Chaitanya Kulkarni=0A=
> <Chaitanya.Kulkarni@wdc.com> wrote:=0A=
>>=0A=
>> Thanks for the patch Ming. Couple of comments below.=0A=
>> On 4/14/19 6:22 PM, Ming Lei wrote:=0A=
>>> It is observed that nvme/012 may take ~17 minutes to complete on aarch6=
4,=0A=
>>> even worse it may trigger IO timeout on nvme-loop.=0A=
>>>=0A=
>>> Eric and Dave replied that it is because of too small log size on small=
=0A=
>>> disk.=0A=
>>>=0A=
>>> So pass '-l size=3D32m' to avoid the issue.=0A=
>>>=0A=
>>> With this patch, nvme/012 can be completed in one minute.=0A=
>>>=0A=
>> Then we should set the QUICK=3D1 if its taking shorter time.=0A=
> =0A=
> That should have been a QUICK test, it is fine to set it, but it shouldn'=
t=0A=
> belong to this patch.=0A=
> =0A=
>>=0A=
>>> Cc: Eric Sandeen <esandeen@redhat.com>=0A=
>>> Cc: Dave Chinner <dchinner@redhat.com>=0A=
>>> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>=0A=
>>> Cc: linux-xfs@vger.kernel.org=0A=
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
>>> ---=0A=
>>>    tests/nvme/012 | 2 +-=0A=
>>>    tests/nvme/013 | 2 +-=0A=
>>>    2 files changed, 2 insertions(+), 2 deletions(-)=0A=
>>>=0A=
>>> diff --git a/tests/nvme/012 b/tests/nvme/012=0A=
>>> index 9a6801511df7..d7a8751ec752 100755=0A=
>>> --- a/tests/nvme/012=0A=
>>> +++ b/tests/nvme/012=0A=
>>> @@ -46,7 +46,7 @@ test() {=0A=
>>>=0A=
>>>        umount ${mount_dir} > /dev/null 2>&1=0A=
>>>=0A=
>>> -     mkfs.xfs -f /dev/"${nvmedev}n1" > /dev/null 2>&1=0A=
>>> +     mkfs.xfs -l size=3D32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1=0A=
>>>=0A=
>> As a part of this series lets move this to the helper mkfs in the=0A=
>> nvme/rc and use that call in all the file-backed ns related testcases.=
=0A=
>> Let me know if you want me to do that or you would like to do that as a=
=0A=
>> part of this series. I'm okay with anything.=0A=
> =0A=
> I am fine with either way.=0A=
> =0A=
Okay, let's get this in, will send out the refactoring.=0A=
> Thanks,=0A=
> Ming Lei=0A=
> =0A=
=0A=
