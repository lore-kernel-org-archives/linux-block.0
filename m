Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB0BC2BA1B
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 16:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAD120787
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 16:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r3JtpCGN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iQ4jgd2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgDHQ2E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:28:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:9866 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgDHQ2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 12:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586363283; x=1617899283;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3wcQkVBHxVSu32wozfR4mZtpTfJkODupT8fIom+4qUs=;
  b=r3JtpCGNROemFTPgrh6SRyqg/cl39Vkooif47F49sjP3rIairC/Ki3d0
   kt0zItGr3nM9eyQFYSXol3ps2XP/wMDPMTog6Cq4K8DGdGnlSCmx54XQT
   UP6GC5RG3SpNEfypxgSN3KaZT2DFRBIx0G35uQ2biIurKuX+lhMv6vX+W
   YB24qfauyed62z9mgmjHBwQd772EOYDk2+JBqSCeUSOhKHrg8Icn0VlLC
   44FjhRZCowwBEaVHsUS3WCB8mBPiHAn5EeKjR8tPjcW5GqLpmiKFQm5Ip
   cg6sr+sshpCn7+MpU0At5kQ3VVHk6rwhs9dzQxfAibebme0saMQQGLPf5
   g==;
IronPort-SDR: OjTld+3Z8dl9gRyaLkffLG+JIuLS/363oVvL48jGfkL3oHCE0jGnE0P72nBhGiITItXp+WS9ZD
 BD1fc9oLrnxRaV//1ar8XwMpy/piIaai3woifPc12o1L4M4yWUCYeIwz2UKyXZfcp6DZtwGEAx
 JYNTMUCbgb4fmil1GShFn6bWyIuYVvN15CTuS1eBZep4xwi9zxAAr2ydZk7YiGa5gXNyPVvFXw
 OEluNW9mslWaWlp4SSgWD22Wp/RELjQJK9yob2P/+typ/+r0QccV8B2suba7S7Dxls946Fh88U
 xIA=
X-IronPort-AV: E=Sophos;i="5.72,359,1580745600"; 
   d="scan'208";a="136334383"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 00:28:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9Vk4W6ZdnqwuPmgEk7U6uR2t70oTHrhzrWkcV/IJ/HKNDhtrXzHh/dMBy45ytv4ZbuMgaijX6mlkhTF0Tx2aAv79kkd+0b/kW0rhbYk/kbZCPd1hnhjK23dUeQQvd8i2m996UTWNAQdrI7EcfCdQOtNOFEdQ3BXcIYT+YZjfRiyZ/4JIJb5U7getqXVI/zKlBPucaEAebdsFFgoy+PcDHCQLlcBkDwagqW5bt+SsrmPf1rc/ssyF5iHBK7j+Ncyog2aNHMlud5QJ70O0NpUzvMz+PITecdF5L6icWFjRpU48Q4eRGGOONgXsxaTb514uqTwhis3rzTRHDx1F2eTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/XwvBuBEupjS9EbFFxq0V6ChpUNl2TmxI2TRGjelCQ=;
 b=iQRvDC0/f2NcHhdn2o1mJVbGtRnd7feCfwk7BAY7m1/JOnxYOoPC8U/f91NtfQKXMEOb71N4jhGpdVju9f9qRKRUSvwDzWJvvvvWg1+cvssF/IBYKThCGUO+LraUwI1iGel042SmoC16vyWguX4kz46suWfldQP2jqoQPqNfEIU1FTSgMsFuC5tp4BXZDsRCNRo8GC6i6+NYOC1ol445Cy8Z3qQdZsc9gFBzokMTUG+u5dYALU6X76sZkNyUB/2QSMpkt8SsDW+pRqKtLLxi2QX9piUst8RAGFtUwYosYQAGG4sADnzQKAJ6/kqya5Ye26ln6wXONwP+YOg9f+uwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/XwvBuBEupjS9EbFFxq0V6ChpUNl2TmxI2TRGjelCQ=;
 b=iQ4jgd2GdwuqmdikDHcw/91tCw6qRE6FeXeNeba6nu9JKa/S0cex3a7HPhVNe7QRN9Y6U4RFF2RCeLWLbIQVZM3dRQmH7fspIJCP/ZlyPMQJi+hGBcyBrM1QwuKTWVhw0mrOhrdYbnht2H+wm800HhoolGGF7t48L0LFg+CI8fQ=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SN6PR04MB5135.namprd04.prod.outlook.com (2603:10b6:805:94::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Wed, 8 Apr
 2020 16:27:59 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e%5]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 16:27:59 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Weiping Zhang <zwp10758@gmail.com>,
        "osandov@osandov.com" <osandov@osandov.com>
CC:     Weiping Zhang <zhangweiping@didiglobal.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktest] nvme/033: add test case for nvme update hardware
 queue count
Thread-Topic: [PATCH blktest] nvme/033: add test case for nvme update hardware
 queue count
Thread-Index: AQHWDOc5x5zQf7eZvUOWxJVMAwNxBA==
Date:   Wed, 8 Apr 2020 16:27:58 +0000
Message-ID: <SN6PR04MB49739887B3BFD2227648B5B186C00@SN6PR04MB4973.namprd04.prod.outlook.com>
References: <20200407141621.GA29060@192.168.3.9>
 <BYAPR04MB49657AC1B762EA5450AA178986C30@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CAA70yB7Z8bkQAaPy+u8FPme4Y34O6CTw=YCXEJ+_W57M1CxzFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70ff0800-ea5c-4c7d-edca-08d7dbd9cd0c
x-ms-traffictypediagnostic: SN6PR04MB5135:
x-microsoft-antispam-prvs: <SN6PR04MB51352A3ADEAFF3D2FB769CDD86C00@SN6PR04MB5135.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(478600001)(55016002)(33656002)(91956017)(76116006)(66556008)(52536014)(53546011)(66446008)(2906002)(64756008)(5660300002)(66476007)(81166007)(7696005)(6506007)(966005)(15650500001)(71200400001)(8936002)(66946007)(9686003)(54906003)(186003)(316002)(4326008)(26005)(86362001)(81156014)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4M5voWT2rDzW1KOEjGKtophluH3LR1xn2wL5ZngeWUVxNSkALjOdrD8qOleFSb4BNogjqUXHsDu7B2oJXKLiXVRRbS5ogVa3QEXN1dARAYB6p4rKjoxiOa+A7cpg+xEQOgJnra5sexS4Q6u3+pT+zuKFWiS39Co3IODo8EaaEzUtpLa38DHE60xuzHqDEFPru4VI48ntqlFTlbiBXE/7Oys7PRakje99exkbwXZuZrmOfCszVEq0N7NbCBrlZE3safiASxFYIBwPAVTdvgyvSAu/E5LkMoIoXiFvopBk6FA8P/hnqIHoZyzseW3lxx9xdc8MbI9BDUtazogSfmuczsq9fUKMCUwusE7MwhqD6Ehm9qySNGus/xCEG2Og57nUJjYqyfvL/2FoSuKSyQpvoantq3fkFcPXOvKdVCih+qK5N3w7YsW0EnRTByzcPOzubMszhKfumPk5gYBiV8HBkxsVVN6c8IJVI2xDsPtLpxEJvP+RLukx4/OgvJ2Fj4Fdb9dxnImVqIbTRkgS93Ixg==
x-ms-exchange-antispam-messagedata: izUG/rHWYj9oj5Q3FFZwFThux7mhcOQR88ceQk5wfW+iqL/1zAw8cpk+R9iDOSS0kE+I/c6stv1vdI2B0oDAr2sT7CtR0VD+EYr2eTzwpMCYeVy9wtJY92MNyAoQngSZWS8PIb4Uf2dFUbfjPuWGPQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ff0800-ea5c-4c7d-edca-08d7dbd9cd0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 16:27:58.8608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRe4Qhk/8MXFsREdtU3reYOESEvjTMcxDI3CtAu9+o7rxlGNRDFUTvwHqCTjWufDdmVyHXUYWosCmAfFJEl/W7m297o0tOlTwkg7qsFIX2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5135
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/08/2020 05:19 AM, Weiping Zhang wrote:=0A=
> Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> =1B$BP2=1B(B2020=1B$BG/=
=1B(B4=1B$B7n=1B(B7=1B$BF|<~Fs=1B(B =1B$B2<8a=1B(B11:32=1B$B<LF;!'=1B(B=0A=
>>=0A=
> Hi Chaitanya,=0A=
> Thanks your review=0A=
>=0A=
>>> +     # backup old module parameter: write_queues=0A=
>>> +     file=3D/sys/module/nvme/parameters/write_queues=0A=
>>> +     if [[ ! -e "$file" ]]; then=0A=
>>> +             echo "$file does not exist"=0A=
>>> +             return 1=0A=
>>> +     fi=0A=
>> can we skip the test ? I think Omar added a feature to skip the test.=0A=
>=0A=
Please have a look this discussion :-=0A=
https://www.spinics.net/lists/linux-block/msg50491.html=0A=
> What feature can be used here, I don't see any rc file "set -e".=0A=
>>> +     old_write_queues=3D"$(cat $file)"=0A=
>>> +=0A=
>>> +     # get current hardware queue count=0A=
>>> +     file=3D"$sys_dev/queue_count"=0A=
>>> +     if [[ ! -e "$file" ]]; then=0A=
>>> +             echo "$file does not exist"=0A=
>>> +             return 1=0A=
>>> +     fi=0A=
>> Same here.=0A=
>>> +     cur_hw_io_queues=3D"$(cat "$file")"=0A=
>>> +     # minus admin queue=0A=
>>> +     cur_hw_io_queues=3D$((cur_hw_io_queues - 1))=0A=
>>> +=0A=
>>> +     # set write queues count to increase more hardware queues=0A=
>>> +     file=3D/sys/module/nvme/parameters/write_queues=0A=
>>> +     echo "$cur_hw_io_queues" > "$file"=0A=
>>> +=0A=
>> Shouldn't we check if new queue count is set here by reading=0A=
>> write_queues ?=0A=
> Most of time, this parameter will not equal to io queue_count,=0A=
> if really so, it will makes this test case be more complicated.=0A=
>=0A=
>>> +     # reset controller, make it effective=0A=
>>> +     file=3D"$sys_dev/reset_controller"=0A=
>>> +     if [[ ! -e "$file" ]]; then=0A=
>>> +             echo "$file does not exist"=0A=
>>> +             return 1=0A=
>>> +     fi=0A=
>> I think we need to add a helper to verify all the files and skip the=0A=
>> test required file doesn't exists. Also, please use different variables=
=0A=
>> representing different files.=0A=
> The reason why use same variable name $file, is that copy and paste=0A=
> code(check file exist or not).=0A=
>=0A=
> If common/rc include "set -e", all these checks can be removed.=0A=
>=0A=
>>> +     echo 1 > "$file"=0A=
>>> +=0A=
>>> +     # wait nvme reinitialized=0A=
>>> +     for ((m =3D 0; m < 10; m++)); do=0A=
>>> +             if [[ -b "${TEST_DEV}" ]]; then=0A=
>>> +                     break=0A=
>>> +             fi=0A=
>>> +             sleep 0.5=0A=
>>> +     done=0A=
>>> +     if (( m > 9 )); then=0A=
>>> +             echo "nvme still not reinitialized after 5 seconds!"=0A=
>>> +             return 1=0A=
>>> +     fi=0A=
>>> +=0A=
>>> +     # read data from device (may kernel panic)=0A=
>>> +     dd if=3D"${TEST_DEV}" of=3D/dev/null bs=3D4096 count=3D1 status=
=3Dnone=0A=
>>> +=0A=
>> This should not lead to the kernel panic. Do you have a patch to fix=0A=
>> the panic ? If not can you please provide information so that we can=0A=
>> fix the panic and make test a test which will not result in panic ?=0A=
>>=0A=
> The patch is under the review, for more detail please visit:=0A=
> https://patchwork.kernel.org/patch/11476409/=0A=
=0A=
We need to wait for the patch to get in first before we add test with =0A=
fixes tag. I'm not sure is it a good idea to have a test which results=0A=
in panic when patch in discussion is not in the tree, in that case are =0A=
testing the known failure.=0A=
=0A=
We need to add a test to validate and pass the fix and make sure as=0A=
development goes on fixed code is stable.=0A=
=0A=
Tests in blktests should always pass based on the feature or a fix,=0A=
unless further development adds a regression or has an indirect effect.=0A=
=0A=
Omar any thoughts ?=0A=
=0A=
>>> +     # If all work well restore hardware queue to default=0A=
>>> +     file=3D/sys/module/nvme/parameters/write_queues=0A=
>>> +     echo "$old_write_queues" > "$file"=0A=
>>> +=0A=
>>> +     # reset controller=0A=
>>> +     file=3D"$sys_dev/reset_controller"=0A=
>>> +     echo 1 > "$file"=0A=
>>> +=0A=
>>> +     # read data from device (may kernel panic)=0A=
>>> +     dd if=3D"${TEST_DEV}" of=3D/dev/null bs=3D4096 count=3D1 iflag=3D=
direct status=3Dnone=0A=
>>> +     dd if=3D/dev/zero of=3D"${TEST_DEV}" bs=3D4096 count=3D1 oflag=3D=
direct status=3Dnone=0A=
>> Just a write a helper for dd command instead of hard-coding it.=0A=
> I think dd is simple enough.=0A=
Fine.=0A=
>>> +=0A=
>>> +     echo "Test complete"=0A=
>>> +}=0A=
>>> diff --git a/tests/nvme/033.out b/tests/nvme/033.out=0A=
>>> new file mode 100644=0A=
>>> index 0000000..9648c73=0A=
>>> --- /dev/null=0A=
>>> +++ b/tests/nvme/033.out=0A=
>>> @@ -0,0 +1,2 @@=0A=
>>> +Running nvme/033=0A=
>>> +Test complete=0A=
>>>=0A=
>>=0A=
> Thanks=0A=
>=0A=
=0A=
