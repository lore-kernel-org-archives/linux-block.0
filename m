Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF5C433DF
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 00:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD592531B
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 00:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="okIm5Uof";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pB5AU4I0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgFVA1i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Jun 2020 20:27:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44436 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgFVA1h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jun 2020 20:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592785658; x=1624321658;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IURKrbYqZXTSPQNw3WHe77rd8aK0zZblCy8yGPOSQQY=;
  b=okIm5Uofci48ZfbXYrY5gp6G+TMvxEc+aeDmu48oiLyNVpXApfc6kKrZ
   jm1VBaxznEngFHH2YiWOMlCEhAmT5NBIKay+OZu7BuwOajzHQ2uVKxA7m
   a0yec6cxHyj7Dn7Z3yNe0MayO6nvLEf3fVnzlnqlfFxc68Xf9uPBSSIwV
   Q8PyvwoqJdbZ1/aFeMG6ZHA0WBQI5JXDIXr/8afCCA3I9+ovc5Jp+iFfh
   kdumhM0Jo7YbPqupZGWmC8wjJmR3KzQ231EeD9NxhhFhdhIYjOI5WWqJ/
   InE85JaH4/uhhxBUqBav2nEcE72YPPVG1Cs3Mxm57CcH8akNYmI7jSC4w
   A==;
IronPort-SDR: QFQbcL856eiXFW46ZHZ7EOoqxvAwJrrs35mx0BuamqDvwClBe7bjjpDI7fg79l92q1HvNGTBYA
 1jf2Vpg/HFTr1D9pvVSmoFHt/mn8SS29BlIoXM+XYbIWBqoStScyd4YkfDIR4ZIIKrDd5ULy+1
 V8pZVA1HA+s8TDe66rKmWMSW/mZg8ee8GJAD2MOtQIQUDtHUZ8WyucEAesTKrxMaxUVwrrpLkO
 DqzjTj1XgkMR1MnWhO0Lto9Y3j/vhT3+MFIX2dC2GTbKnAxiVVo+GvIL/JBqTn1AEyslY2gHNc
 Egg=
X-IronPort-AV: E=Sophos;i="5.75,264,1589212800"; 
   d="scan'208";a="144883644"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 08:27:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaMStaYD6eq4fwnsJRURPJ42Y5WK0/rRl6JZ5k4nEejDgS92Q77sZP/yqsgvKFe5wMynM0Ntqk9A2K+R7xSz3NBLPpJ787KF0/iLh5r0pNhhqB7YmvBqeF4fs4OE1jEbE3DygcUqGWjDT1miA3te8z/rOLjYkTjq99m4JqpJGWENLNSyz3LM8PMfJmiPY4qsoQukvGCTb5yFc05Bo3rXseRDymCoEvQcj2DqBTLpt9LtaHeKr8UP6NvvqvRxU6IYdq8QT/oDuOTXE0B70UnaAdXtg3BCmAsybDUnI/8ha+Ha3b59UO5vbrV2Kw6bUSxGCS4vrPkQDoTzsvXN03v8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za05aIq51lN+JrobyPW+kLUoz+blvEnfy5FGDldLQ/Q=;
 b=A9HjiOhZGqfs0fXWJw36UecWZk3+rjCOnuEb7+uF6FgZh+HGM0iRC25EjHla0yk0Cf2SSWiXTo+9U+ZhO6/+DNyaNPXjrAINw2HO6C3jbVkg3GQtfu3zWF3se2dyzmBp5Dnn3tsSYr3OsXpRKx1pZ+B95sTqwdaZoo3N2JzFJeFkLgz5h0Ap+9GFexyY0uUMo66xXUyo49bjIhgcpI+E2B93F3t7eGcu3h6cn0qyZ9vbpQvYfHM4HfaRPcv35yv+KIDx+U4Tbwrt4AGjLL9IxBImfUpmrbwMUxVyxES4QG7dmDfdKWsjyQEbF8zw7HZ7QB+kTcCXYngoXU1Y4fkxNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za05aIq51lN+JrobyPW+kLUoz+blvEnfy5FGDldLQ/Q=;
 b=pB5AU4I06ERcqb2IIELqPMRFUYc9TZ2mgX2sCzrKL7zpWnW/rnKAXsgvqKa4Uli8n065coiiA9FMOyAxixnL2A1shRsdWPq0ZZg7Gc98CgOcukpu3YlZrGWUmdLcQfs0lhKdnMFJ+1fdi9uxSluiBcNLH22TVv2P/Hsc1eg0HTY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0376.namprd04.prod.outlook.com (2603:10b6:903:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 00:27:34 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Mon, 22 Jun 2020
 00:27:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [RFC PATCH 2/2] dm: don't try to split REQ_OP_ZONE_APPEND bios
Thread-Topic: [RFC PATCH 2/2] dm: don't try to split REQ_OP_ZONE_APPEND bios
Thread-Index: AQHWRgczjPsIYl+9xUe/paWaQEGH6A==
Date:   Mon, 22 Jun 2020 00:27:34 +0000
Message-ID: <CY4PR04MB37514F8CCE7918A7C13FCA82E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200619065905.22228-1-johannes.thumshirn@wdc.com>
 <20200619065905.22228-3-johannes.thumshirn@wdc.com>
 <CY4PR04MB37514CDC42E7F545244D66C6E7980@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200619162658.GB24642@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ddce9943-bdbe-4c26-9db7-08d816430f3c
x-ms-traffictypediagnostic: CY4PR04MB0376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0376685C8E0A499409F847B5E7970@CY4PR04MB0376.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ullllfG5DxpL3besiRSAgP7aeekmn3uXxB6A4KReZt9/9v0Grc1lmGh/5J30xhX6CV50m/J5UBzW7sMFM8Pi5ZjJWDIuiyd4Y7dYF0VIuyh3JFtTBheKU+2I66BL4EfrtbXQd8gxTRjx3cAhXLthwSbLHI9m1keiZyx9xEkpnv0UOKzByed5ugieL9YiEMJp2PU/GwA4ZfHcXqfa1f/SHpCFagPhOaoLHK6dWSnNxt1CMsri28Ku9Su5cECA5suEb//DRjKsvKXZGlsvqEPxj4L9gaisndMKtEy3DzeRNJcWU52kVVIOwwICqKHHE2uc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39850400004)(366004)(396003)(86362001)(6916009)(8936002)(52536014)(5660300002)(8676002)(64756008)(66446008)(66476007)(91956017)(66556008)(33656002)(76116006)(83380400001)(71200400001)(66946007)(4326008)(26005)(53546011)(6506007)(9686003)(55016002)(2906002)(186003)(478600001)(316002)(7696005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LGcBToxxP3D8JB3AOwYBq1HlGYscqUUdg0Q+4AtlX11xaH42cVwqdhHf9RDs1Hu8vPmEU5Wm5w3L+/riqeyEzxXgrja1//yUmnusORohs/v+h4uZ4BgvkYhib9hp0SVJCGWMyKFlFKE7SvHYUOU29deTykwkAhsqqmvzvYisULT0Evt6x6lvZgu/ls2ngAJ9W+EO3XMg4DVsSfW6JYvMak4OTrj/JfHlP6+fRiwSxCot6j82F6+AYhadxlFZYckkgL4+46Bwr+uoJYWNfBUDijXCFwpDJhCUy2NEuGWVnOJzocDxWsMfhHaRCxRe65CXN0dtrVufONW3VHMTpoWx+S7p6G4U7BMnNn3QvcLL7obicaG3bvshBvutcMS1YrA5P32XbbrZbmL4rzER25x9lq6emGE8FRhFCFQthmtdWb6GQYTYHM2decr0KJQVSVx8owU9YCztROGKI40jwRmiVArPqBQYs7GvtSuuEsR4O5wZrSOVvU+tclFz1+ldFQ36
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddce9943-bdbe-4c26-9db7-08d816430f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 00:27:34.5886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1ga1qwKST8gr+uT+KoJYBHkWQDKepOCIgYvuuCShsefinXIkkui2ddSvLCg7S22gSKn5vg40MK1CTki5kbnOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0376
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/20 1:27, Mike Snitzer wrote:=0A=
> On Fri, Jun 19 2020 at  3:54am -0400,=0A=
> Damien Le Moal <Damien.LeMoal@wdc.com> wrote:=0A=
> =0A=
>> On 2020/06/19 15:59, Johannes Thumshirn wrote:=0A=
>>> REQ_OP_ZONE_APPEND bios cannot be split so return EIO if we can't fit i=
t=0A=
>>> into one IO.=0A=
>>>=0A=
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>> ---=0A=
>>>  drivers/md/dm.c | 3 +++=0A=
>>>  1 file changed, 3 insertions(+)=0A=
>>>=0A=
>>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c=0A=
>>> index 058c34abe9d1..c720a7e3269a 100644=0A=
>>> --- a/drivers/md/dm.c=0A=
>>> +++ b/drivers/md/dm.c=0A=
>>> @@ -1609,6 +1609,9 @@ static int __split_and_process_non_flush(struct c=
lone_info *ci)=0A=
>>>  =0A=
>>>  	len =3D min_t(sector_t, max_io_len(ci->sector, ti), ci->sector_count)=
;=0A=
>>>  =0A=
>>> +	if (bio_op(ci->bio) =3D=3D REQ_OP_ZONE_APPEND && len < ci->sector_cou=
nt)=0A=
>>> +		return -EIO;=0A=
>>> +=0A=
>>>  	r =3D __clone_and_map_data_bio(ci, ti, ci->sector, &len);=0A=
>>>  	if (r < 0)=0A=
>>>  		return r;=0A=
>>>=0A=
>>=0A=
>> I think this is OK. The stacked max_zone_append_sectors limit should hav=
e=0A=
>> prevented that to happen  in the first place I think, but better safe th=
an sorry.=0A=
>>=0A=
>> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> =0A=
> If stacked max_zone_append_sectors limit should prevent it then I'd=0A=
> rather not sprinkle more zoned specific checks in DM core.=0A=
=0A=
Mike,=0A=
=0A=
Just to be extra sure, I checked this again. Since for zoned block devices =
the=0A=
mapping of a target must be zoned aligned and a zone append command is alwa=
ys=0A=
fully contained within a zone, we do not need this check. The stacked limit=
s and=0A=
submit_bio() code will fail a zone append command that is too large or that=
=0A=
spans zones before we get here.=0A=
=0A=
That is of course assuming that the target does not expose zones that are m=
apped=0A=
using multiple chunks from different devices. There is currently no target =
doing=0A=
that, so this is OK. We can safely drop this patch.=0A=
=0A=
Thanks.=0A=
=0A=
> =0A=
> Thanks,=0A=
> Mike=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
