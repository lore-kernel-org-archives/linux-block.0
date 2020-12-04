Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5EBC4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 06:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF452253D
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 06:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgLDGXQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:23:16 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12246 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLDGXP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 01:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607062994; x=1638598994;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WhOO3k44Ran9qVyHo9qECKKg78bRg2YhAgpOjsa5KKM=;
  b=L7SWx4PyJMVoPKntrINyBj8rmaSFdfpLVQ5DAf/UDR1lQhPbmCTnNn3h
   j6XMbNYWpDH1VjcfyuP0nLm56ltzi2SgWT8Rg4eljqpR43ND/ebAmEEVa
   usn/SKkScnEslTgq/K3DrvND/+WFD8HPDlu83bVJutDD1oV2WqHB+LRqn
   5dKrO2cXbcczLAL6vpwbBWd1ayRgs+KB/rRIzF2lPxYDxwZrcfPVY2p+P
   wLec+uFzkO5s/3rgMGKoduypXl0eNgJKPLC/4W7xsyoGiP3QFFodmrza5
   PTqzjXP+7rGmjNWM8ttNQXrLb+5UEhGBeXbb9xDySrp/HgOkG/ertt12Q
   Q==;
IronPort-SDR: /+vJRcbLvsnRAOv6IG4cxrL5HN4jCo8tB0pEOjYs5ni68PAnBDVhTHl1sVvTerJykLBvaGCEhj
 KYmkq3DKYkEEE7mHMO7T4w+SiS+SAoTu68IdYiEGkdmSZNQ05+uSFmWD9txnJlZf8RfbIa7S48
 5M2fgY7tFPl+w/6AEy/2BDKMN+inNMa66faHWdrSWBGsWYHUp0vBaLECIjfcHY9/0T4SrEx5BZ
 IoLtoyE3jZAbLxos8T0AhE9RLUsXNORbba3StaE2PzI36GVG8/2EsRfoWytXO3EPSpB5fcD4qm
 6Nw=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; 
   d="scan'208";a="154376306"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 14:22:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZuSi8qYSDw62J+ZDUC+lEB0KW7sjl09ul3UMOMgACT8F5yHWBMb2SGue6V53wMd9BIZXOa47lLowCJwFQ18ACyCX9tzBOkorIhDHZddFn32wzasPmDVOKu3cocvzWTagklCtCrXBzbkO6g5sEp51PYExKrUOxQtrPMwAoYYuAs+Lchh0ngZIYL+VmgW/F/o+Ce1ynEZqHBd51xctd1GdNz1VYDyVh+GwAxt4R1l969Or8I/vVL/+P2bkas+/AR+sTPftEIot+fK2RG8+uwtcMjNepDRpzr2UXcsalPQvbQ65uZ06NXji12Gr6htpiPsDGmVAZl8VVTnnO722RKBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/LSGVfB7X6VgfTWN8tHCi+SAJWpXLf9trlhlZ7S4cI=;
 b=WfSkazjIxyrPsodps46KgwguqNXFywLU6D3qDkTIL2zQ+hj7eYM7t7fOC+FpVJDrBV8GI+WF4QzglUeLyPCvLC1fD3wsGIPv0G3PRhQBOQqknTniHoTw2HT+RikzZl/aFYUMaiPMSI/gGSfdO3A7ytpoQoxUxR8Rn+Pk06rwkflkcYWrVN8m2ceZArSQv1x/W2CnsIBVBhG+jMZyYH/eP4Dm/JW3TuCPsJfkz8qQz+eyfr2HQ2euZlt7w472bI8FoNwjMxX5gGDjFAJqyEmj5KkwnOETPQakZFNwSJcVc1VvZYOZWrJ1eMVOCb58AjbZDtMWGGjm3C1G8iLV/XpiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/LSGVfB7X6VgfTWN8tHCi+SAJWpXLf9trlhlZ7S4cI=;
 b=LaxCQjkNpLsJtu9Dqj+CzLhmpoBiIbwAk4k0CgGON82fbrOSy/XwWG1ozbCc06jlEBjO4k+rIGQSH7FCKo1AqwBdELn9eI+tzqsyLsGI7qL4HaH4Xiyq0QoY6ddQkf3YAD2eeS/KWEcxILVWF+pHErHbB1YoGM1+IYAnpL2YF/I=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7128.namprd04.prod.outlook.com (2603:10b6:610:9a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Fri, 4 Dec
 2020 06:22:07 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Fri, 4 Dec 2020
 06:22:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jdorminy@redhat.com" <jdorminy@redhat.com>,
        "bjohnsto@redhat.com" <bjohnsto@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [dm-devel] [PATCH v2] block: use gcd() to fix chunk_sectors limit
 stacking
Thread-Topic: [dm-devel] [PATCH v2] block: use gcd() to fix chunk_sectors
 limit stacking
Thread-Index: AQHWygXKM2E833wJPEuohYVBv9PQMA==
Date:   Fri, 4 Dec 2020 06:22:06 +0000
Message-ID: <CH2PR04MB6522DFFD1EE89C45EF0C0BBBE7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130171805.77712-1-snitzer@redhat.com>
 <20201201160709.31748-1-snitzer@redhat.com> <20201203032608.GD540033@T590>
 <20201203143359.GA29261@redhat.com>
 <20201203162738.GA3404013@dhcp-10-100-145-180.wdc.com>
 <20201204014535.GC661914@T590> <20201204021108.GB32150@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5458:21bf:70ee:2847]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c61421d-29a0-4349-9d9c-08d8981cecb1
x-ms-traffictypediagnostic: CH2PR04MB7128:
x-microsoft-antispam-prvs: <CH2PR04MB71288991235F00C4552A35F0E7F10@CH2PR04MB7128.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQOKYBb1YzGx0zCPrYkWAGG6TMow1CDJRCBJz2NuKNg64/71/SxNAgoSB2xKK+CLCoog7cgAw9z167Gjp2nx5wlxLTfYYS7TnzUrvMMrwsMOw++yed4fDWKMs7me3sZWOlTiPfQ+4O+qx+yg1vQn8Q0VfBXWU2U4XBGpY+H+kaDSO5/hIrLDibGW8aWBmv5e58B+Jg2QiV27TSW9RSwxf8hGr+yjJpsQp/waY/sKSjcp1vwfUAONqTWu8EcbgLc4uwTo/a4rNvhulOrvCcoMgjY9CccdsI5XWI379/7nWM0Xd14TSE5ldFODA3ULpCdk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(66946007)(33656002)(8936002)(76116006)(52536014)(8676002)(5660300002)(71200400001)(83380400001)(91956017)(86362001)(66446008)(66556008)(4326008)(66476007)(478600001)(2906002)(316002)(110136005)(53546011)(7696005)(64756008)(54906003)(186003)(7416002)(9686003)(6506007)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GeYj0AM6B3v34KyNm4uDuJo1WzBKC3h5qrku9Eo6HRdBu6W3YmQT0ivTnxjk?=
 =?us-ascii?Q?y0rx4fBWA2KHircq+qBdgoV94hEgWzUmoiAEzY1+hojir5Q7SXWHM8zjYq31?=
 =?us-ascii?Q?MYi5KRecNwmYNnQ40Du+XbgvjjPXwDQOJfvim+DomWiMCYF9e/OzIxeGcC3u?=
 =?us-ascii?Q?K8rcSVrt3d/eyHAXuNKfv7CzbjR+QB4tL2pqqFz5NH/yCHcD1/tLCZIC4oU6?=
 =?us-ascii?Q?eaCYWi+oTaxgrP3Y0LTweDuq7pxKPcvzV3e6G6de2u+AbCou0Qr3PYjUHPEb?=
 =?us-ascii?Q?yM242yXrs3LUjfAraxUh9/OjFkyYg7HVZAWggpxHvEHFn/5Kr9lxpB67UM5R?=
 =?us-ascii?Q?/9bHwoTJ9ncbfzmiCiWtvNlLOguLZ65fBTvaXhhUwAnpVw8DRz3oHyvYZGYj?=
 =?us-ascii?Q?ZNzdfjowwOOhWl5y3NKTymliQ9CjR039FxZGomcen440/lHWZIrsy4ws9VUB?=
 =?us-ascii?Q?rFedCug+I5JPDtHYvjENbfPdN2GEUpxu/sm6R1JIE7bwwsn60jP4b37Uz73i?=
 =?us-ascii?Q?6HR3seufkDUB/xAzUPa93cwTtueVCgQRs+vl/oM4J4cXrocfFY3ADgUaR9E9?=
 =?us-ascii?Q?jp3w+kKYpWiaafLFBmOYwCAlmSP6ApdGXyd6E9bxF5ERj7dogDZI6eOo4rjw?=
 =?us-ascii?Q?oeGQIV1424yzHwCNX+DC88deoTyh8HSWfq0EJvTU2fJiqtVkB4RMnVByzDuS?=
 =?us-ascii?Q?W/CrzG2u9f+Kyyr+0bp7LFQSx1lZ1U5mENLCmiTaAq9tM9PytlF3j1av7kIS?=
 =?us-ascii?Q?F8Xp8I5FnsTXEqxr6+xGqqFKtZHf6aE45ohw0cNIBhq3c6/eNxOrfX4S/ziP?=
 =?us-ascii?Q?s65DJg3x01P97WDDeoSPHtu1NwRd34o6f7McviKRgLCFO+b+B490G36B8c/Y?=
 =?us-ascii?Q?t1X/Mr486Bx+qx7jqhV4suV04Ij6eRi692FEnu6z5VGOe03W3Opg+qLQ67gS?=
 =?us-ascii?Q?KlwKZpfh5K4rVz1/3EWVc0GUiR+FTz3OQpQyzgEw9D0Vc8E9eHARmqx7z3Tp?=
 =?us-ascii?Q?WczD/fm7/kXpLYWUbLx+YTYtlsaa5t7hj2xeMjWTzxcURENFCsbh9N1yYioi?=
 =?us-ascii?Q?6wwmTh8Z?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c61421d-29a0-4349-9d9c-08d8981cecb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 06:22:06.8941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phjGCEX7aVnr5uXnNwHTQEHnnrMggPPkJMaOgCb66MZtA1FRLjMr2Knwn66zbbRcZekObxbQQnT/lQSu39vyKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7128
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/12/04 11:11, Mike Snitzer wrote:=0A=
> On Thu, Dec 03 2020 at  8:45pm -0500,=0A=
> Ming Lei <ming.lei@redhat.com> wrote:=0A=
> =0A=
>> On Thu, Dec 03, 2020 at 08:27:38AM -0800, Keith Busch wrote:=0A=
>>> On Thu, Dec 03, 2020 at 09:33:59AM -0500, Mike Snitzer wrote:=0A=
>>>> On Wed, Dec 02 2020 at 10:26pm -0500,=0A=
>>>> Ming Lei <ming.lei@redhat.com> wrote:=0A=
>>>>=0A=
>>>>> I understand it isn't related with correctness, because the underlyin=
g=0A=
>>>>> queue can split by its own chunk_sectors limit further. So is the iss=
ue=0A=
>>>>> too many further-splitting on queue with chunk_sectors 8? then CPU=0A=
>>>>> utilization is increased? Or other issue?=0A=
>>>>=0A=
>>>> No, this is all about correctness.=0A=
>>>>=0A=
>>>> Seems you're confining the definition of the possible stacking so that=
=0A=
>>>> the top-level device isn't allowed to have its own hard requirements o=
n=0A=
>>>> IO sizes it sends to its internal implementation.  Just because the=0A=
>>>> underlying device can split further doesn't mean that the top-level=0A=
>>>> virtual driver can service larger IO sizes (not if the chunk_sectors=
=0A=
>>>> stacking throws away the hint the virtual driver provided because it=
=0A=
>>>> used lcm_not_zero).=0A=
>>>=0A=
>>> I may be missing something obvious here, but if the lower layers split=
=0A=
>>> to their desired boundary already, why does this limit need to stack?=
=0A=
>>> Won't it also work if each layer sets their desired chunk_sectors=0A=
>>> without considering their lower layers? The commit that initially=0A=
>>> stacked chunk_sectors doesn't provide any explanation.=0A=
>>=0A=
>> There could be several reasons:=0A=
>>=0A=
>> 1) some limits have to be stacking, such as logical block size, because=
=0A=
>> lower layering may not handle un-aligned IO=0A=
>>=0A=
>> 2) performance reason, if every limits are stacked on topmost layer, in=
=0A=
>> theory IO just needs to be splitted in top layer, and not need to be=0A=
>> splitted further from all lower layer at all. But there should be except=
ions=0A=
>> in unusual case, such as, lowering queue's limit changed after the stack=
ing=0A=
>> limits are setup.=0A=
>>=0A=
>> 3) history reason, bio splitting is much younger than stacking queue=0A=
>> limits.=0A=
>>=0A=
>> Maybe others?=0A=
> =0A=
> Hannes didn't actually justify why he added chunk_sectors to=0A=
> blk_stack_limits:=0A=
> =0A=
> commit 987b3b26eb7b19960160505faf9b2f50ae77e14d=0A=
> Author: Hannes Reinecke <hare@suse.de>=0A=
> Date:   Tue Oct 18 15:40:31 2016 +0900=0A=
> =0A=
>     block: update chunk_sectors in blk_stack_limits()=0A=
> =0A=
>     Signed-off-by: Hannes Reinecke <hare@suse.com>=0A=
>     Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>=0A=
>     Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
>     Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>=0A=
>     Reviewed-by: Shaun Tancheff <shaun.tancheff@seagate.com>=0A=
>     Tested-by: Shaun Tancheff <shaun.tancheff@seagate.com>=0A=
>     Signed-off-by: Jens Axboe <axboe@fb.com>=0A=
> =0A=
> Likely felt it needed for zoned or NVMe devices.. dunno.=0A=
=0A=
For zoned drives, chunk_sectors indicates the zone size so the stacking=0A=
propagates that value to the upper layer, if said layer is also zoned. If i=
t is=0A=
not zoned (e.g. dm-zoned device), chunk_sectors can actually be 0: it would=
 be=0A=
the responsibility of that layer to not issue BIO that cross zone boundarie=
s to=0A=
the lower zoned layer. Since all of this depends on the upper layer zoned m=
odel,=0A=
removing the stacking of chunk_sectors would be fine, as long as the target=
=0A=
initialization code sets it based on the drive model being exposed. E.g.:=
=0A=
* dm-linear on zoned dev will be zoned with the same zone size=0A=
* dm-zoned on zoned dev is not zoned, so chunk_sectors can be 0=0A=
* dm-linear on RAID volume can have chunk_sectors set to the underlying vol=
ume=0A=
chunk_sectors (stripe size), if dm-linear is aligned to stripes.=0A=
* etc.=0A=
=0A=
> But given how we now have a model where block core, or DM core, will=0A=
> split as needed I don't think normalizing chunk_sectors (to the degree=0A=
> full use of blk_stack_limits does) and than using it as basis for=0A=
> splitting makes a lot of sense.=0A=
=0A=
For zoned dev, I agree. DM-core can set chunk_sectors for the DM device bas=
ed on=0A=
its zone model for DM driver that supports zones (dm-linear, dm-flakey and=
=0A=
dm-zoned).=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
