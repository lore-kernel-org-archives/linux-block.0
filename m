Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A305CC433E6
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 07:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A39020C56
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 07:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RDdJ6lCm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GssdlPXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgH1Hyp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:54:45 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40579 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgH1Hyp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 03:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598601284; x=1630137284;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FOBPKjvv8cDfBvnKAYEvDi6Adk+gSdsPzXsZ/m/SCrs=;
  b=RDdJ6lCmUz2qNYEVg9S5pB8IvEY6d5E9LMRuIwq5RlbpXu4NKB3d/6pG
   NhDvYKNVBlc4SF5rOPr43l/dhFVeM+Jz6bdSS5GWUh7ywTJGlqKRxYQ6w
   p38BWqTh5SzEg8yvLm8hhjJUllzKBenWiKqs2/Fvdg0GDKQ8tz5LFme/G
   gBkJGlc9fUP6NT0ON6LjsDe1Qe2T8w9hBIA9qgzhYPYB/UyNK7y6GDjr0
   R+wa5Z2LETpG+hcomlpnhTiMtD2tmDYp7ypKNQ3ygpqOdPEr6uUYcq9Q9
   jLlZEH9VbonFdw8w/LE6eGDPO4rGPC56rc8P/OC5W5gzWqFXSRCKZMITR
   w==;
IronPort-SDR: Wtr0Cxx25HBg7a9+lh73Lz3e79+MO1O6xG7IVaMHau8poNwxsHHbAhhig0k7mUqjOwgpprPbt3
 PiuFu3CkRNhrnAzdmZ0EA59aFIl1sHavoNFyjlYOVM7c7XJ+EJ81Pph0yqUwXjOEB5o8rmpSPs
 CEAhgacUc8kVPY0NHQftC0c/sdVM3p2GfPCS7AF+KFcllzF+czL/MNnbkry8r9Jp18Toz7wFLR
 wzkf/wUqIumdcLXnqDuglmeNzMFn6+E/yC7LN/LZaNHkTG4ztBMgvyKyA8gMcSXo5ygxUrqGzh
 sxA=
X-IronPort-AV: E=Sophos;i="5.76,362,1592841600"; 
   d="scan'208";a="255552635"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2020 15:54:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZTEVhBq7wfEjrtdQDqipKZk0Dw3MjOs5rQE+P4f75b3A3Y2m03Lk9MzQ+rPYTREdk9jZGWANjTnWJKAotkb2bXGJmCJqXH2I+KCZDRgng8t8Q/h9+flua10VHU98YhQoXqaKiMX/xyz3rKKMDYdMjZLuK2qtasyeG8syhxWg47qyu1g+CtiLBVagz9aP0d5CDNJs6pD0nsGQfuqA9VQpPHM75/aY/xfhmGlihGqdAALowpQBK++gmF5roTcKABaTi9C2J1voY6BNPy4hrH2ZZEhfdvuEckFJLwc+QB7Yrd7Y3gEQl9gD+yyM1KXCMNmI8mh0ydYMws0Di9yDu7lJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STf2vCE9k1qiLrUX7mKMByZTpBA2hGX7fa/9LPFz0/c=;
 b=NXstAxsvJCshJjTy4hb8Ekq7PKAF5IrkAdhOzWIZp8hS4bKh4cdb5VT0nex9KiFqQlK4mXGsyuguqy3Hi8o8WLSJqA30irO7UG2IuQWQWiBKE0iyw7FJJPcMHFPhsa1MIbNBV5HX83G2ZhNilb3yVNEKsJNdfigpza7mx45fkzZwoStuwcB+7YYhtS3x+eh+TN3tjE0SIy0xJhnnU9FH1mi/k6WgDdAigx4hEYIFKLjiIh9FvtAn9GTXCjL84qiDfdbSadiYL4BQu9iMsqsCXT1OibSzcJmKx2KBWMUZ6GAumN2IRzeSeisSQ7W2PdO6kMcHN93UKP21+poXBCNnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STf2vCE9k1qiLrUX7mKMByZTpBA2hGX7fa/9LPFz0/c=;
 b=GssdlPXKfqy/CI+IESp6USX88/S17tpX9S3s4LAYRrPJ1m1sNXfFiq9B/6HLhPggDIxfmPPJcWIwo0cA7Jmrkq/Forsc9Lbcah0SzEU/mPRPjzOIepnE/wNClLm5MPzIj9wmUNt4cHn85JyHJLDQWeK0g5YOkSvEaCecM6G1SDM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB3749.namprd04.prod.outlook.com (2603:10b6:903:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 07:54:41 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3305.032; Fri, 28 Aug
 2020 07:54:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Klaus Jensen <its@irrelevant.dk>
CC:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Topic: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Index: AQHWfHkH+20N/yg19E+BQ9ptEBewKg==
Date:   Fri, 28 Aug 2020 07:54:41 +0000
Message-ID: <CY4PR04MB375132F43CE14994D0B0773AE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200827135018.63644-1-niklas.cassel@wdc.com>
 <CY4PR04MB3751526DC5833902749EBE48E7520@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200828072253.GA1331347@apples.localdomain>
 <CY4PR04MB37514386D6A94A04F66EFF1DE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200828074728.GA1343822@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1cf:fa0c:32f2:7362]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 010e60d2-855b-4021-1a83-08d84b279f1d
x-ms-traffictypediagnostic: CY4PR04MB3749:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB37491237878239FF42120B20E7520@CY4PR04MB3749.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RX+rAyx1BjAncJDgqnzHXZ2BJXGzMc6Ornf1jPGvsodH0FAm3PIAByMX07GrsL45eaO59LZNoP6G5+NmBEou7bxo236P/cNtXt5QzTqWXhtURq9wzEtLMYXyP6n2ybbOeWdk/dzl7M3wDc6eKzPhtxMxjipk9MyqYYdfWwAvOqPsrFanKvM3Be8NoM0GCZpze8T62OcojZqfgdx7Xi0crhhbQd4EP7fGcwc82KwM5xBFwrejmTS70OGWnATXS1jlj8qzfjXlw6bUvjWmh16PyyFqLih5YscyObzPs+CvnkWbEhSWA+mEKq1xJ2nGyclAytF2CjLDEA5oJkTavJC0yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(52536014)(9686003)(2906002)(55016002)(5660300002)(76116006)(66946007)(66476007)(64756008)(4326008)(66446008)(478600001)(91956017)(66556008)(83380400001)(8676002)(6506007)(8936002)(71200400001)(6916009)(7696005)(186003)(316002)(33656002)(53546011)(54906003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Wov5g8ga0U11LFcLdH+EmjwAw9iKoH3H4pYnBaKxqCKK3gsNP7o/dMyq11zcwP354ToEKbI2XGFsJ0b8BNx+CpdhZUzLtGIaqbzQpFo7rYqcgvCH88v2mkqsX3ZJNoyw5NzbmFqs7CWp3jrs9ZRCixdc47P+0F9Kl8GkX+o23mhVgwWTWa5Xyn1yL/l8JibAn0L2YrUBsWt2N3FlcjtSq/iZr+jMlqV1YD1d39LX3vTGeC6rolZAgM2j3semWaeXvvAK5BRcaOrg6hk18QN5TSUsZmRQr6JSTg9LM7mqHlEiMmeWnx2tArRD1YGBZKvOYMIf7vaa8vbzgN6IY2XNH+JVRRE1d4sITUy4o7o0K25bDe8BnPY2qDdznNByqH87ddREoZBR6BxKPbMbhsiBb2WtkCq+ahZYvl2nZlx+MNBEB6IHhGZ7udHMaUR5q9pNiIRVjzOQtRkhWjktjLvwwlsMDi9Bvy85FjTJMEg4TnAyEtF7bstMan1Og9nrVybrlTzrI3lH8ori1ygcCFSifex13ohPR2W8FsVyIDPx4qh9XhvdpB53EvuxZMHd4bAdjqEEYMd03OT8ZWWGqHsB9drvHg66JkSRzPPUll8rOMRaqXs2Pv00sKVV8GtdLHslOGNnUjILHKWdB+Tp9TL+69Ib84kqeA5h0Oz9MDOzhz09lXQUbyHfJWgRsKJXJIqnwwFyNnbLJf6SxNN93NfGPA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010e60d2-855b-4021-1a83-08d84b279f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 07:54:41.6988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TxuTx1JB9cI2zr+4XssSuTOsxn9UAuDKzxCirJybO9fBx80llPG+2bk/EBh7/iE4I/NyhS5mf/wXw45CrqMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB3749
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/08/28 16:47, Klaus Jensen wrote:=0A=
> On Aug 28 07:36, Damien Le Moal wrote:=0A=
>> On 2020/08/28 16:23, Klaus Jensen wrote:=0A=
>>> On Aug 28 07:06, Damien Le Moal wrote:=0A=
>>>> On 2020/08/27 22:50, Niklas Cassel wrote:=0A=
>>>>> +static blk_status_t null_finish_zone(struct nullb_device *dev, struc=
t blk_zone *zone)=0A=
>>>>> +{=0A=
>>>>> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>>>>> +		return BLK_STS_IOERR;=0A=
>>>>> +=0A=
>>>>> +	switch (zone->cond) {=0A=
>>>>> +	case BLK_ZONE_COND_FULL:=0A=
>>>>> +		/* finish operation on full is not an error */=0A=
>>>>> +		return BLK_STS_OK;=0A=
>>>>> +	case BLK_ZONE_COND_EMPTY:=0A=
>>>>> +		if (!null_manage_zone_resources(dev, zone))=0A=
>>>>=0A=
>>>> OK. So you are hitting a fuzzy case here that is not actually well des=
cribed in=0A=
>>>> the standards. That is, does finishing an empty zone necessarilly impl=
y a=0A=
>>>> temporary transition through imp open ? Which you are assuming is a ye=
s here.=0A=
>>>> Personally, I would say that is not necessary, but no strong feeling e=
ither way.=0A=
>>>>=0A=
>>>=0A=
>>> For ZNS, the spec is pretty clear that ZSE to ZSF is a legal direct=0A=
>>> transition. So I don't think the transition should be allowed to fail=
=0A=
>>> due to a lack of resources.=0A=
>>=0A=
>> I had a doubt and checked again ZBC & ZAC. I section 4.4.3.2.4 it says:=
=0A=
>>=0A=
>> The Zone Condition state machine (see 4.4.3.5) requires the specified zo=
ne to=0A=
>> have a Zone Condition of EXPLICITLY OPENED or IMPLICITLY OPENED before a=
 finish=0A=
>> zone operation is performed. If a zone with a Zone Condition of EMPTY or=
 CLOSED=0A=
>> is specified for a finish zone operation, prior to processing the finish=
 zone=0A=
>> operation, then the Zone Condition state machine requires that:=0A=
>> a) a manage open zone resources operation (see 4.4.3.2.6) be performed; =
and=0A=
>> b) the Zone Condition becomes IMPLICITLY OPENED.=0A=
>>=0A=
>> And section 5.3 describing the zone finish command points to this sectio=
n.=0A=
>> So this is not the same as ZNS.=0A=
>>=0A=
>> As Niklas mentioned, nullblk tends to follow more ZBC than ZNS, so the c=
ode is=0A=
>> correct in this respect. We could also lean toward ZNS on this one. I pe=
rsonally=0A=
>>  have no strong opinion either way since there is not real good reasons =
for=0A=
>> finishing an empty zone that I can think of.=0A=
>>=0A=
>>=0A=
> =0A=
> Alrighty then; thanks for looking it up! I won't fight for the ZNS=0A=
> behavior then :)=0A=
=0A=
If it becomes a problem, we could add another option to force one way or th=
e=0A=
other, something like "zone_specs=3Dzbc" or "zone_specs=3Dzns". That actual=
ly may=0A=
prove useful for testing file systems etc.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
