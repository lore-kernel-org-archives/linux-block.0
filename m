Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D69EC433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 23:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C909364DED
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 23:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhA1XAm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 18:00:42 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32474 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhA1XAe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 18:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611874833; x=1643410833;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fhVicsyNRrZP+i/+yfhR9XkypvwXkvAslovJe2z2gek=;
  b=Z5Hq7UcPgNDFT7odo6Tq71Hfs1h5yEWE9heVGxMfRkkpSYpiXUOBC8dk
   by/e/2w/fMLr7RorQZBWAOubmII0JCwCN2qROXoVBi7TTfvRvsga5jk/h
   +XvQ+iqCDrWHCB//iqBwLElWpmV/2NVMdIDMC5hsbig1H/MxGTFlOfLpb
   ormssSz6l23MLtiB+/vy8RARcvPm1T8mrBZKuMaFRyhQ40hkx7lWiTpfl
   SoavYWmtnCST9TCFUYlF0KiTInhw2ipr+PlUVgQS0pkr3zVGYrXLznOsp
   mTLOuWjsm/bleaewbPCzVhndRd7Rg2/+r7ndkVv0qc/N+opTGgaNwQwDB
   Q==;
IronPort-SDR: VHvtEzmOKj0n7KsjItQwIh8Odu+Ll+gYQx+HBs7rBWUUgXZVg0nsAJCMEN8mEvr92K86M6pEIE
 I0AiJpDpjvHosq7KKmrbNb/jN85K8u5PXDElIsmaa0kqmg2wOSBaF6PwYGFph901j4atmP2Lwz
 YoALhx1GqQNb3qFAn6tbggE9DyX4B8AiPBclQVAbEUHbb3tpzyt1s9wEBpg2+ttQFzSh8hbTcd
 2eVgnJsToMdG4m0lr4uo1yxr9kYhC852u3uzrP/QRzBVT4cShvf1jpoW9Es/Z1iZh7gMx5NzaI
 Tqo=
X-IronPort-AV: E=Sophos;i="5.79,383,1602518400"; 
   d="scan'208";a="158583313"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2021 06:59:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV+WK3uYXNNeCTyxP6E6W+CHViR0LuUFX/HRlFf+QW+lkdNKVp+HFPLOZO/qw3ArncUnw98P2VOnNnoauVXZuUcmlVK1Q9Bw8szrsXOnQ64C+XePRWl7+gS5yBxXevROIinuT8O9RgPeKoP6xCfkLnBtFecnM404SbOnIt+niewYxMQAVViO5IlYBqTJFHQl9KWDwAXV6Hs2+tz85P8Oyxza32eAKfX6g2Vuxzz4uxfiJwql7bsdKcavxCe7R6SJXk8Lhl3oPvI5p/J1+8GqkBHSdXo6wtvDEuqrpwrVgnXlBmzL6TSVDDSAN1oZxblV3XMz2MuS0it2D9m04aRsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhVicsyNRrZP+i/+yfhR9XkypvwXkvAslovJe2z2gek=;
 b=ECnxUVJNtguhC8rdJOT9ab6snwUdvwRpFgJgvp65GHDPK/W9Wk/RKUH9whK0sOBk43vgW1vzDn09RRgLqFU8eTR6hZ4ht8T7y6WD1ekuc5O2nBcXMTi2gE02qVHkGxXZ6B9efoB+LAfYasPpTMrSjRFalJihBbA9Nl0VA5rqx0yrHJfJH/Dcf7exJDNxXXfiTbKxJb5B+iYlfI1lyNOE8JgwDKmmhcaAPvyMOHtPlsULXmZfoMK4ZsZ76q0DVdt3ZfOUl/1t7vP7E+Kjt1XhDjDPC3RXPF7LXVzjNPWix8vXhEbWRSgjOJhKKeTrpLwRB6UMVTK0zMwLSN06KNuR9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhVicsyNRrZP+i/+yfhR9XkypvwXkvAslovJe2z2gek=;
 b=GoSI0r2/72q8GORQmafC0K4PNit7ZTL1mIbMA4E+9caonBWzuVSA6IbXiMhlty4PzB1A+JhNf1dIVz1WyRHpq6FCxalbMw5k2AIXUpERQOnIY94WRQAbmY8PE+QDtVCS2Wn8sgKcNJ+cMh5FTT6C6L4AMdkwBz14kmIUjGyxP2o=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6976.namprd04.prod.outlook.com (2603:10b6:208:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 22:59:26 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 22:59:26 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix bd_size_lock use
Thread-Topic: [PATCH] block: fix bd_size_lock use
Thread-Index: AQHW9UBfVaDPRxUVuEqdmFRT7T7Tig==
Date:   Thu, 28 Jan 2021 22:59:26 +0000
Message-ID: <BL0PR04MB65146EE4D00D37ED04F3F3B4E7BA9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210128063619.570177-1-damien.lemoal@wdc.com>
 <20210128143723.GB2043450@infradead.org>
 <9fbbeb94-64ee-6a80-05ce-c919de390376@kernel.dk>
 <20210128144321.GA2045081@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:47a:7b5a:7dfa:1b1e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 181aa928-3e33-41b3-c2b0-08d8c3e05cac
x-ms-traffictypediagnostic: MN2PR04MB6976:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <MN2PR04MB69769836545E0997E3D71726E7BA9@MN2PR04MB6976.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLhEetVia3aN0+uWSY/L/+dLkIxrNTn0HiGlSlVldKsFXhCSUAmmgrWFvxUjgvKkf/wDnW5KC3TlC83brNCz2UWNgTiFtNUgbc/XFID0gLwczSP/fovqKpXlr30BmDo3m7fUU5+dRt/tVSXjgsXjRnMV+xwCv3v+wP/GfRc2qyW8iZ8XY2zBcBQKmkloZLhzx4i45OdKr+b4ygFsuBKLrsdgTJzXR/E7BfmQvgWOeBJkcP3GFLoq1X9E80cpWO9EcFTEMng/m3c7dmYixA1RBlSCmidMyftLutSd1kbeaE0olfGH+yv2DOt/sPtjDfKaIE0+TnQl+JzvU/6AENQOjKbIiVbGLfZJsKtg0O/7dG30AFjwXXBdLwphFoc0tGBYVTn5d/7iySzIGBgwFo9NKN1axR1opiL6FNomyV4oqIhZdY1VUn572moYMgHoNSuY4tX1WnpywT0U2Lce04BMJSLhNg21+YaQbNrCCu/Bv5iTJdRcAaFqdCu4HPvpKLsxTtgRR5d4HeTU0jtb5/KB0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(86362001)(7696005)(66556008)(66476007)(66446008)(64756008)(6506007)(66946007)(53546011)(52536014)(91956017)(71200400001)(478600001)(110136005)(186003)(316002)(76116006)(5660300002)(4326008)(83380400001)(9686003)(33656002)(8676002)(55016002)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eMnmYzduojVf71i4w+xtFyT7I4ryCT3iUqSUYhZR+g/1HZFAeykPVUyXy4L2?=
 =?us-ascii?Q?JIcwW/2ffa5Bx+NrifrweGlS2cliUyW1rzNX+7ND8E5UqAx55RGC+kFDSHB5?=
 =?us-ascii?Q?H8jfeR9SXOgY4QpULVUMlqUj2PNspsQSweqDW5mpnNWEh/pEXKPGyK8a7yom?=
 =?us-ascii?Q?YoROWsxC0FacTlX7oZ9vJW04xp3mGZfIsO2ZSLRbMO0PndcWBOWTtJ3PcVKl?=
 =?us-ascii?Q?5j379fDPaIz7OMZs7DtAmGewIKkUeji+VKKJ4IL7zXDA5uUoiiUUAff7GNWO?=
 =?us-ascii?Q?/DCspiyN7V/wbiJHGBMsk/VzZ8QubaynKMuuLeddOnqrpQJ9YT72gnml7wts?=
 =?us-ascii?Q?RIf11KN+BfU2x2b98tp3z7D8e+CkMBlHxKhPNuCMjiyiVXFNZ6ZMWK+B5xdB?=
 =?us-ascii?Q?2SYTYo4M506ETHtGTlGsjEtk9JOFzepLkrrs6Lpeovv/tCOO0eiKdeevHQ51?=
 =?us-ascii?Q?aRKsv47NsQ6ym+rsSlSTwlIeXuO3g8EzczyzCj4K3/wZGfKpRyGyCziC8lpw?=
 =?us-ascii?Q?ka8yGi46HD3f1z5DWxsGBpRm65oW9zzvoaUDbPYsdVj8mvyyffPYkliH/utR?=
 =?us-ascii?Q?eCXPDKS74U6dMdSg/+ZaHSNUP1xYetgEFkPJHCx6LlzE0X50wzzYHY5Q2px1?=
 =?us-ascii?Q?PP8wWS8EDYsBrPKlAXW/heB0Qc64BzibabQDXHev4HL9XdTU61K6gdpmkGLi?=
 =?us-ascii?Q?qF9AZORMZky0ODpmMmS7vReD2ibhm/aL7CcmT97f5ei/3xkmOokhqUi54D2k?=
 =?us-ascii?Q?QM7idFbpB2s9yeglNcDQJqZwb8XxK7oyUuB0w/qbvvT+YKCa2wVWfH2OjZVy?=
 =?us-ascii?Q?G1vzXhm40odYOp4B0u6ZRjDGbmwXKfoGPvyE6qAC0mVDDxUMQrVbiLV57UQh?=
 =?us-ascii?Q?3s0rTE9dcO6R7tVI9jVqVFTutXUdInKU9NYHoVaMfwuswv9zOmz8qvz6Kx2f?=
 =?us-ascii?Q?esMmyl6X55o8gEh1D68GHmQJjL7Bu6iPECLOYzEMxzB2HIvon5HMd/wOHpEj?=
 =?us-ascii?Q?n/I1bRpuPVVAomHIGvwqKTYWBw7Z411hvKhE5xr7BFVgNgIRqrTsFPcxpl3I?=
 =?us-ascii?Q?fSgFya8x4hIFshCpCBaU9obXAXCesSXytQ/ktO93+B18nNqMb4JMmUStkUEA?=
 =?us-ascii?Q?wfGZ5AurytyES0jg5mS+UpR2ucZJUd8r3g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181aa928-3e33-41b3-c2b0-08d8c3e05cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 22:59:26.6671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYsaoFwY8y5kJ1B4Nzme1Ox8/0GUlc+l0h560eKxISByLKF3pt6qfbGT90KCReGo0w7HC8cEVFWINAC1CWogaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6976
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/28 23:43, Christoph Hellwig wrote:=0A=
> On Thu, Jan 28, 2021 at 07:39:21AM -0700, Jens Axboe wrote:=0A=
>> On 1/28/21 7:37 AM, Christoph Hellwig wrote:=0A=
>>> On Thu, Jan 28, 2021 at 03:36:19PM +0900, Damien Le Moal wrote:=0A=
>>>> Some block device drivers, e.g. the skd driver, call set_capacity() wi=
th=0A=
>>>> IRQ disabled. This results in lockdep ito complain about inconsistent=
=0A=
>>>> lock states ("inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage")=0A=
>>>> because set_capacity takes a block device bd_size_lock using the=0A=
>>>> functions spin_lock() and spin_unlock(). Ensure a consistent locking=
=0A=
>>>> state by replacing these calls with spin_lock_irqsave() and=0A=
>>>> spin_lock_irqrestore(). The same applies to bdev_set_nr_sectors().=0A=
>>>> With this fix, all lockdep complaints are resolved.=0A=
>>>=0A=
>>> I'd much rather fix the driver to not call set_capacity with irqs=0A=
>>> disabled..=0A=
>>=0A=
>> Agree, but that might be a bit beyond 5.10 at this point..=0A=
> =0A=
> True.=0A=
> =0A=
=0A=
Agree, it was my initial intent to fix the driver itself to fix this proble=
m.=0A=
However, the entire completion path code, where the set_capacity() call is,=
 is=0A=
executed under a single spin_lock with IRQ disabled. That is pretty horribl=
e and=0A=
will need major surgery to fix.=0A=
=0A=
I can work on that for 5.12 if required, but I would rather leave it like t=
his=0A=
and deprecate this driver so that we can remove it in a couple of releases =
or=0A=
so. The STEC cards are not sold anymore since many years ago and are not ev=
en=0A=
supported by the vendor anymore.=0A=
=0A=
Should I start fixing this driver or go with deprecating it ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
