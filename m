Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9A7C433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 22:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5132076A
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 22:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DL2KykiE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DJAl/WgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgFHV77 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:59:59 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:10988 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgFHV76 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 17:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591653605; x=1623189605;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PQDMpGojsABo3PC7WmR3L3iw6mLSqcspXD6HEmCFHHY=;
  b=DL2KykiEDTYM1SvPEkzV5AT/+4VbpNEA2+GV71kDu8HZnEOXc2wZKL3j
   1Gif/hNkdoBWO7C8U4HLfVWiDw/yGZuWfX9YYOZ784jK/R7rsp6td8IiP
   TzKsCHJgpyAhMedURZoK4IH30YYH7mT+tpsAXgVMh4vWazkPR0dpzby+E
   VNn+wPOFor0xPhE5JT7VGvifEeimEvmiljCr5nfrWf7OPwSjV1H9FaArU
   RDHtlaml+38lr9yoam96zHes/0aW3I0Gev3Mykm5ELX048LXwsS+Rg3hN
   BhSyDTnARgH0h75kle9TicP2heAIzjIVoxUoLXWUJ3yvQSO0LZ5jgjGNi
   g==;
IronPort-SDR: j0Dyr2AI5PBvVpZFrX8YaFZUDOBJsJjY0Mh+Kkqo4YQcw2ib3S8hFi93NYDraV6RiVxBPsWzT4
 69gL/NkCMOr/ziY6uZWzUPHamXELFRbH1chvcOZ6YC3ZW9M0eAxnEDRxxt2mTA2Gq1gzFWgBwO
 GoaYtuuAJcL6bhnkmpKgTDyFodINARETvaLQfHUQ4IUc2AKLZYJNo0JGGnzcomTSBh2S6YgaRu
 h/1bPvnjR/chXRaUjQIfFSc+mK8d5HDGVj8ChNz1uPinUBkSVzzuOEkQZrKMIskSjS86bCwtcI
 k8w=
X-IronPort-AV: E=Sophos;i="5.73,489,1583164800"; 
   d="scan'208";a="242390721"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2020 06:00:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR6m4tJLZZA+wV/cGBaNa9qzTKn9+y3NyDx5VWpXINSLK0Y2cHfQ/UJ9RkNMzi7rUWLgZgrkji/t4eVxJKZwi3mEEp/A45TCe4SOuiD9swXD/BZjkSs6eRUFzE7N89tOEqhvTXfyK93qNyBUT5hHb//pK6XO544/fdFHsKZvEWMoTBvTvi+TDR2Plc0yTzGDqTJ+3E5KhEx1Iy+ZfDS9AIkzDDU4a/5fN0PPG0/1AI4DV/lkbcLrUWbySjQ3tG6w6isKzcL7XmyMh+HPZs5arddwdP29wH6Rp20v6yMiM+lgVXfe4ZWkYwJk1S75y9koYSMw0mo/wgrVBR1Xtly6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQDMpGojsABo3PC7WmR3L3iw6mLSqcspXD6HEmCFHHY=;
 b=aZ5ZhC103dsRvvyLp8KFCVjK0jQBXRNEp15dA6RM8CjJYmCJ4d6zM7ARpLW3xqWh5yKc5IyPLs7/KCEjwIzeBqg2OnQAefDzjO8xSKWyWRZxfT8F46K4ggbPLBqqeyA6iD9g0yhaGVV4tLazsVjMNkkW38Jmz9ZM2CltEdBX7Tt7Sxw+++RGDPZWh2gqJM0iLgULUfT1lRJzgenaac+jIAqi3y1j/2YzYTg7EkMoNXN5Bwmzc3GGrOkdGR3AjxFCIwOiVI9OARntyu2yCjeAP45ZC9n3xGGKD3HNfvlwy+9DEHzny9IGhdzy8xDfnESXRWVxodnPqUTiOtF6kVCKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQDMpGojsABo3PC7WmR3L3iw6mLSqcspXD6HEmCFHHY=;
 b=DJAl/WgLHcKKH28XZOOIn9ZnRrvT2tX4S1YGCZP/GM8zhX2XU/WIbrKjisPnXbFVR+NCHyshbDKe27iVk46D5+Fvnph95SEngBxcAHa5C3yQhCABlqR9W1AvQ2jZF8jVDb5FqqW7N//FMcv8mwFGQer6RmOl8MlLkr+IAzLaE1s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4600.namprd04.prod.outlook.com (2603:10b6:a03:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 21:59:55 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 21:59:55 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
Thread-Topic: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Thread-Index: AQHWOjNJLSEx3mlm6Eunc+X8pDtzsQ==
Date:   Mon, 8 Jun 2020 21:59:55 +0000
Message-ID: <BYAPR04MB4965D2A36AE58C4519DBD77A86850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
 <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org>
 <CAD+ocbzdh0eq+wBQ-DqUUw_Gvwc0xv-FbBUNS0aZfpn+eToUEg@mail.gmail.com>
 <8787ab94-4573-56d4-2e59-0adbaa979c4f@acm.org>
 <BYAPR04MB496523AEF4C84B7BA2D2680486850@BYAPR04MB4965.namprd04.prod.outlook.com>
 <35a5f5a7-770e-1cbe-10a3-118591b64f29@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b7e624b-6ab1-4e40-806b-08d80bf7475e
x-ms-traffictypediagnostic: BYAPR04MB4600:
x-microsoft-antispam-prvs: <BYAPR04MB4600D043CB9E7BB27075A57D86850@BYAPR04MB4600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +JTA1Db6+KX+BR7VnW5/qfv7bRYtRKS+HIOPeZqaI8MqTMclR0HNP6L4oAGPOgCAB2LQ8X7aNS0U3BsYll6pY18XwwjwRjCmLTe4ox33CZcgLJfvRyykuUMWyX7OTiFOs4DlKW7jCspvop1nmxzHnUbsxCpR4U4ue6PE47TW/zMr4w1ze1eC/44uVPBspnlCNGK998XkvBeTZFT8yj1pCUnzscxjQEe/mR1vnJArJQK6gi+ceutfOpt4KMV+f61ARCiNsB/AKSEJTFOK/ost05Naahry4RePYiZj1onRFUsJC5T9zQvz39xaORyZ5Y/nrA+xysnhpVvRkqRAeWMvIE6ZzwUFn4clVJJxg13avcJ18/ZvSgmPTQIMIO3Ew+5zAcBPRLdoQwHylrg97pzLRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(33656002)(186003)(8936002)(55016002)(7696005)(86362001)(6916009)(9686003)(26005)(6506007)(478600001)(66446008)(83380400001)(53546011)(316002)(66946007)(54906003)(4326008)(8676002)(71200400001)(52536014)(66556008)(66476007)(64756008)(2906002)(76116006)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yoaHMgZnVW/OEl7rcqd+Vnjs5LSQlLSBiQwFC3KATkMtFO6WFDPct1iXSpmnrEn9E3/h44z9rrAp/yUNdbW/CKun4pKaj/ytLl0gQ6qrWrslmIM2+iWx0ySQtZdZR95xOy5sqWxNoKyYbwyZj/CpGBvAS/RbUy79Piv/oa3ly38GPxw3JLvbKxBGGXqWuC8ZC3S2OE0L8NSf01sDVlfgELy3EJoM5n4mVtJa6uB5WFuMBkip/GBM3CZLul+PtI1C3uooacTEo5bjyiN8F7yHu4r88vpUL1KH2RE1iqjSD5Gu2y00xuH8VzsGWOWQPmqy9hfhzc9bgQY23kbX5VCu3qHl05mgKFZ5etIPk1745q83uzCa5LkaGKShmMI2VGLZn/qZQdLYnNtsVpPNwf7vHVlaocidQvAinjHZCpmET9/+1OqjZ8tgw0KJ/wVdnt3PPDkbkRxviLolBp6nut67LNuEPYwLBaCiL34YoRSBsoEbXiDWUSzF0yrmVeDWAhr4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7e624b-6ab1-4e40-806b-08d80bf7475e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 21:59:55.3739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: um4neae5+onmACBFVgYnfD5ZgLxON5TN0DKQAT5CD+cM6YTtJz3qRLhHywYyNlWA6SEorHX3EnU0b3ICa7HIXX02k7lP/Oq6gsRKp0WhMc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4600
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart,=0A=
On 6/8/20 7:20 AM, Bart Van Assche wrote:=0A=
> On 2020-06-07 23:40, Chaitanya Kulkarni wrote:=0A=
>> Bart,=0A=
>> On 6/5/20 6:43 AM, Bart Van Assche wrote:=0A=
>>> We typically do not implement arbitrary limits in the kernel. So I'd=0A=
>>> prefer not to introduce any artificial limits.=0A=
>> That is what I mentioned in [1] that we can add a check suggested in=0A=
>> [1]. That way we will not enforce any limits in the kernel and keep=0A=
>> the backward compatibility.=0A=
>>=0A=
>> Do you see any problem with the approach suggested in [1].=0A=
>>=0A=
>> [1]https://www.spinics.net/lists/linux-block/msg54754.html=0A=
> Please take another look at Harshad's patch description. My=0A=
> understanding is that Harshad wants to protect the kernel against=0A=
> malicious user space software. Modifying the user space blktrace=0A=
> software as proposed in [1] doesn't help at all towards the goal of=0A=
> hardening the kernel.=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
Hmmm, I agree that we need fix for that. What I did't understand that =0A=
why we don't need userspace fix ?=0A=
=0A=
Also, what is a right way to impose these limits without having any =0A=
bounds in kernel ?=0A=
=0A=
Either I did not understand your comment(s) or I'm confuse.=0A=
=0A=
Can you please elaborate ?=0A=
