Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65A8C433DB
	for <linux-block@archiver.kernel.org>; Thu, 18 Feb 2021 22:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E0064DA1
	for <linux-block@archiver.kernel.org>; Thu, 18 Feb 2021 22:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhBRWgz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:36:55 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:42312 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhBRWgy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Feb 2021 17:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613687813; x=1645223813;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sHqlfhEXSo/LU8qpQveqBfrLFqE95wupx2GRlLhcG/g=;
  b=UEGdtt2aRDsw/3mNhkJ6CXxO9eaKhDg4Cl60Y0HgInMOUfm0zQ6t5nV5
   iODKyiB5UcH6YFLMKG//IAIETKaQnajRdZwyGNhQRIHKMyEsB6selGQzf
   KvkOeL3tswd8q3xpPf0q6Je+a9Dz+nh1t+lAutoyJfEK9BjfsrOv0KF4z
   kd8ocJ4us4ytQq5pYK7FjNh0+dyQvcg8QfnAJqU3JkaEAzHAEkD2AvuP5
   d0NrlGqcoryvF7+TKGbRMVDhvPHJPncQ50p8dVklVQ47oF0Zxvg431KIG
   FrZ7IP7IJ7CYgvuuhvbmFl77FyhK2WXjOs0lkq7qZuHFWX3FhB4d5FOUy
   g==;
IronPort-SDR: lUXGeHytAucXUqaJBkFuKPXVWPeWesgTliieTxaGfAHYtVrIDJTmeTflvslOlMPb3wbTeIZrwr
 CY8kp/yVk/sWt4FvwSgdPfZheuhIYjl//JP+Jodv89JSmKLOvKqS3BRQLaNuFo3rTDoB82L1we
 3LepjMFHDejMGO+LrFv9bBLwlMZDfYS0CeCeKWk92ZcUZ65f0vQmjmQmznGh5OBBxA/Hvi4fp2
 faqg7sQVd70H0RAxrE1tQ/pmt4Ma7k0hRnS5QHW5rvk0XWpezUDfHy1TxBfAG4fUB1w05DDQ5i
 yM4=
X-IronPort-AV: E=Sophos;i="5.81,187,1610380800"; 
   d="scan'208";a="164788748"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2021 06:35:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILBcg7OteaKgsTwdS21IeaDRp0cL9cvssCztjlEzqcKUe8epX+TVgfuwtEQ20isuAWUtiVq48c+EVYWfyBid5BLoMrbjRZfszAqcOrnWZMzlzm2484YMXs4Mg6XVY+3Tk005ZJeb9rzlLYV8pHfhBFTg+7+z3M9BnM+QkZJKPbNAf2rug0cdDwLP30W87WsF1eNgRQXbCM9xmp78lt4lyQ1c6L98MQPlKhF6JE5SOkgj5j6pge+011PTWnTYu4UxY5KUdYPbTxgjZhFuNsLs4h/CQuZ+64Zvx3hBxETrQLr2EJ0AxFVom1hPHG8Evt00D2Xqek5Q4Wu/3o7B3Lsksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uy3PuDeU1u/uALvy32I6wJfHsIdFDJC1apvy40rAX0=;
 b=d3gsy21iNeCGR+YVdJmxI9/hTqPnFankSrI2eFkNP+kwC2B870JE8xPSEgLi51RDWDkw2IqyzX/wV4ggO3WpQQfXK2AAbVyH0ePAQztu27gNyV/eZdLk/40ZfZSyXVdCJq6TXdY9KeFNAjb5J4nPRE1rOk5HR2inVfIKcb8HxuWVroigH02epUJN83wChotbcfCu5Ncz9HVQSMU/bsbm6IgyES/w25p+XgRDNY8AfPNRA0PMG3XgMQE4lVFXMkn/bbeqiQF8ydN4YwNaHBSWGqUaZat6v/l0/MVfJ5imNkio6O0G+7J+dopa5uK9jmbPAJxWoVxVbJv3HZQY8rFCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uy3PuDeU1u/uALvy32I6wJfHsIdFDJC1apvy40rAX0=;
 b=f7DU8nFAprJsD+iazoqhYghNYD9el8OIf9QiAisJG21m1OazA25+dB9rHfS4IVUt+mCTYR9ppaQJnNHULZMYuYHbMpF8CbvWF3zYomyQbpuB7YW9nbUtDvUZZdN0eo0W2h4p9839dSavLCxRr2AY9I3AcJM3mskCS5ZD02OqBJM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6701.namprd04.prod.outlook.com (2603:10b6:208:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 22:35:41 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3846.042; Thu, 18 Feb 2021
 22:35:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jan Kara <jack@suse.cz>
CC:     Keith Busch <kbusch@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] Revert "block: Do not discard buffers under a mounted
 filesystem"
Thread-Topic: [PATCH] Revert "block: Do not discard buffers under a mounted
 filesystem"
Thread-Index: AQHXBGmJovC6+TUaiEeXj6FaL10VqQ==
Date:   Thu, 18 Feb 2021 22:35:41 +0000
Message-ID: <BL0PR04MB651418C1C31967E5AF7743A2E7859@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210216133849.8244-1-jack@suse.cz>
 <20210216163606.GA4063489@infradead.org>
 <20210216174941.GA2708768@dhcp-10-100-145-180.wdc.com>
 <BL0PR04MB651447424E3A3EFD5BE7A987E7879@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210218140703.GD16953@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5483:c7e9:dbac:91d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9449205-47b3-44fa-c997-08d8d45d85c6
x-ms-traffictypediagnostic: MN2PR04MB6701:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <MN2PR04MB6701931AFE929522332E3BA1E7859@MN2PR04MB6701.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q7PwR6yvEVb2EsVyA0vqzQRQ26emFPBaH3uhP3QMn6/olE9fHtBudWhLU++0mjwsIMnpX0JbM3vKVNXexwafOejvDzZxNRC/COB32JtFaNisTRMkv6HHOnI614jl0HlJwGKw7R8v6tOy3RWtsuNjHUT3KtZCzcBW9y01JbKV7fen0eetnOGalaxXyJhsp2ZlI5SDkLThHZ5ZhgItEeQUHJbZQEwlfotkwRYdLKzAsFoxon5Y1oLa0qjZySG9FD9vzynW8MfqKdYuCmIvsOYz+ke/oow6pEI+2lceCgarLylReV56qNxXwdsDr+8tvZpo8nsegJdpB3ZxQ2yHEds9vXXS2zBePMAMsCrCse4DSeWZx5SxQxzkibU2Cwv/M/mAoB1+ZvFdO1zB52q8Ny3v2JMAsPMTdXql9/3yHBCMGwVa9CcRArbL+zAFYdsIH2EW7jABeca1DuzJ9RUqQUwKt4LxzsoExAcOql+mbJQY94pwbyRhY8XUuxA6RPX1+th4N6jYLWyyKne8BbovYxZlbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(86362001)(71200400001)(6916009)(186003)(83380400001)(64756008)(2906002)(54906003)(66556008)(66476007)(478600001)(7696005)(55016002)(66946007)(4326008)(8936002)(91956017)(76116006)(66446008)(9686003)(53546011)(5660300002)(8676002)(316002)(33656002)(6506007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?t2NDBI1a/8IgAmjcOrX2prrN6APRlQh9lb/KyVSwUW1An5mThdGOC/bTerYh?=
 =?us-ascii?Q?gB7iOIc5TeC1MSv4YcDjKU41BjxMETiWIxU4qkJNZUDSrb7hB3sNFbg4y6vT?=
 =?us-ascii?Q?+z4cWNEYD+L/Rx6+Tnq/X3gtsFyKQPXCi0JJS+S3w8aL9q7WlLgjUcGaIhg3?=
 =?us-ascii?Q?QM8ve5DA0uqNIOkLpp4z/bHBywhffwmmnKrBW6uetRZjwx7xyjALFR1drkjj?=
 =?us-ascii?Q?ik0Frm/34XPwfjm0Q0K622k3bNtWgx1n73jjxqW0cPOKKFuRpfl7Susr5+Ee?=
 =?us-ascii?Q?OF5o4/XX+0DBXf7tm49HssqfmV3extN0iDNi0CxAHg09moqtEIZvngddULYJ?=
 =?us-ascii?Q?GSePZR3jxiZQEA1enlFNuVcCdGqT8wQ9n13AnFlnzzQHFvKCdCULepL8IVPV?=
 =?us-ascii?Q?IkSmusfTeeJ2aEtRwAabYN2k8+/gwsqn5MZTdVKQh7bSAbCRG5vm59GtAhPW?=
 =?us-ascii?Q?qpUrH58f/Eq6t/rvehhiOJHS4y47HAE511WDYuP/CnFI6DMlVjF+FD4kF5EY?=
 =?us-ascii?Q?JTLeek7EOYqQ4EygVS23S0zNtYpoiQ3MiYYgtxW+LLWgn4dfmrcsXtLaEDCI?=
 =?us-ascii?Q?qpkU5SK3a0T/vNOZQI0zKiiiJ17mpGiRbksVfgW+V6nFlP6ZKtMEylmx6mS7?=
 =?us-ascii?Q?VEX3P56nKDHTU/IOBkVmo4nCctLngW34tVlbi6f5MFuqTL+mlqVeaplL13Yh?=
 =?us-ascii?Q?IQeYevmJOPD1v/3VmyXGdagqeFRY3CHSDbld2egPR70mrwt5ByTN79/aTAve?=
 =?us-ascii?Q?Tl/hSJtWIwp1SM0CfqatKKKvprz7f2zLYnEY5KcZ27uWcbQjdTOKThox474B?=
 =?us-ascii?Q?KGdK6d+i8S/gELDZys4ieddEvFmDjUfpnD5C4lY57O7Px2vsdqW8+nMWfsdg?=
 =?us-ascii?Q?4sdufHkozeOWAgY5jZMeXMIzwGd7Hf98FbZFxVgw+cJMu3n8znNs30GBC6zk?=
 =?us-ascii?Q?nCrkF0QHvfKAOikn1Oy73ZfGHBewBg90Rz+ms0vG0ms/Auy/i/+6Av8wD6wr?=
 =?us-ascii?Q?DQkbH+THLjs+mwB7+BTa7/4Jznf1S5ezWJwd8PoAkkIbhHT8iw7qpS9HCUY3?=
 =?us-ascii?Q?QDlN+U22WxEP1So7uQEM37AlaOM9PQJ7lDEeQ0iJ4z3JHjrVizKuvWL9WzGR?=
 =?us-ascii?Q?Y+PmJ/QKRJ3dn5Gy/X8g7PQe13rAM0OKhGmC0e77pJwRmKCoJPl1dcw19iin?=
 =?us-ascii?Q?Cn46NY+/76NoCdGoQKf886hKvvHDjSsxpwhU7T6FuHC7742rlzGQSPt+Nm7o?=
 =?us-ascii?Q?/8kU4Y1PEMSibjs3tW6QDO5wlU2+S0UOFU142atJ1oqO41j/mwprtezsaG56?=
 =?us-ascii?Q?k6svxvVJQ/JYUFreDGKioIqDJjSvCAFI+TrGeqMAgdrZTgasN0Ff4fVeURe8?=
 =?us-ascii?Q?sf+FXJka6cgT4mbBuemqnEYiWU3MEgXZFgvDTNDq7LxE1Rv7bA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9449205-47b3-44fa-c997-08d8d45d85c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 22:35:41.3224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JiRe3mlObU35uQkXF+8Hv/orYsnChHjk7FhPpgGncv3/XTrd4mMoMXUIk1Zdwsl1j3C+gK13vIiro+K92Hr0sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6701
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/18 23:07, Jan Kara wrote:=0A=
> On Tue 16-02-21 23:05:57, Damien Le Moal wrote:=0A=
>> On 2021/02/17 2:51, Keith Busch wrote:=0A=
>>> On Tue, Feb 16, 2021 at 04:36:06PM +0000, Christoph Hellwig wrote:=0A=
>>>> On Tue, Feb 16, 2021 at 02:38:49PM +0100, Jan Kara wrote:=0A=
>>>>> Apparently there are several userspace programs that depend on being=
=0A=
>>>>> able to call BLKDISCARD ioctl without the ability to grab bdev=0A=
>>>>> exclusively - namely FUSE filesystems have the device open without=0A=
>>>>> O_EXCL (the kernel has the bdev open with O_EXCL) so the commit break=
s=0A=
>>>>> fstrim(8) for such filesystems. Also LVM when shrinking LV opens PV a=
nd=0A=
>>>>> discards ranges released from LV but that PV may be already open=0A=
>>>>> exclusively by someone else (see bugzilla link below for more details=
).=0A=
>>>>>=0A=
>>>>> This reverts commit 384d87ef2c954fc58e6c5fd8253e4a1984f5fe02.=0A=
>>>>=0A=
>>>> I think that is a bad idea. We fixed the problem for a reason.=0A=
>>>> I think the right fix is to just do nothing if the device hasn't been=
=0A=
>>>> opened with O_EXCL and can't be reopened with it, just don't do anythi=
ng=0A=
>>>> but also don't return an error.  After all discard and thus=0A=
>>>> BLKDISCARD is purely advisory.=0A=
>>>=0A=
>>> A discard is advisory, but BLKZEROOUT is not, so something different=0A=
>>> should happen there. We were also planning to send a patch using this=
=0A=
>>> same pattern for Zone Reset to fix stale page cache issues after the=0A=
>>> reset, but we'll wait to see how this settles before sending that.=0A=
>>=0A=
>> There is also another problem: the truncate_bdev & operation following i=
t=0A=
>> (discard, zeroout or zone reset) are not atomic vs read/write operations=
 to the=0A=
>> bdev. Without mutual exclusion, that page invalidation is best effort on=
ly since=0A=
>> reads can snick in between the truncate and discard (or zeroout or zone =
reset).=0A=
>> With our zone reset stale page problem case, it is reads from udevd that=
 we see=0A=
>> snicking in between the truncate bdev and zone reset and so we still get=
 stale=0A=
>> pages after the zone reset is finished. No solution to propose for solvi=
ng that,=0A=
>> yet...=0A=
> =0A=
> Well, at least blkdev_fallocate() does:=0A=
> =0A=
> 	truncate_bdev_range();=0A=
> 	blkdev_issue_zeroout();=0A=
> 	invalidate_inode_pages2_range();=0A=
> =0A=
> so racing reads should not result in stale page cache contents AFAICT.=0A=
=0A=
Yes, but concurrent writes can then get in between the blkdev_issue_zeroout=
()=0A=
and invalidate_inode_pages2_range() and data discarded before hitting the=
=0A=
drive... Not very nice either. Granted, that would mean that userland has 2=
=0A=
concurrent writers that are not synchronized. So weird results are to be=0A=
expected. I guess it is probably safe to ignore that case ?=0A=
=0A=
I guess the same pattern as above for zeroout would work for reset zone too=
.=0A=
Will try to see if that solves our test problem.=0A=
=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
