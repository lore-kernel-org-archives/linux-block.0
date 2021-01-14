Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20A5C43331
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 01:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978722343E
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 01:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbhANBre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 20:47:34 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3733 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbhANAnc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 19:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610585012; x=1642121012;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cKhND9DZTDa+SSPqub/cbLrUf7sjsGrRZpusE0KMlno=;
  b=oLJCDx7fnc51OGBMMxBtpUunF/BgX0M8FeLanvdphwl7JouHE0U03VAk
   gx7m6x3IHuvjbtUW4KCnEgh6V1LE3Q9RPsyFZIDBAsHmroDsVLXLMd2aA
   QidUDDPoTPO6fR2YMVNBsUzCTN45wonYDJ4OkWN+geix7GEkSjEUVDfia
   slk2cEgdGxj+oWvvyPQgmegyaw4iiwY5/XyDxFDhz25/KTXfWtk3dcZ+3
   Jlvo2E7iOAhowyIsJNyn6Dcc1a1mTenPnzD/dz4OuNaLXnWUyb38+fh9U
   P7sfw6GfEvyux9VZPedLwYhUYzb/1gcjczkQZUvMo2AMF27pk1eBlWnqg
   w==;
IronPort-SDR: 9QJgL13vra3iRqrT7LHThn174LuBYgvcXJZ5HhlhAmL0dqeSq9Dd+NuENBdSwdnmF8Kx0MmUdH
 C6VDpPqYlJd/x3JqFKv6AKCsUysUa4u7FPSIeVH+Y6bcyZa01kWWwIoYIQ7zuBr34XMt9/5RKV
 0FTn3mvS+51mleR5zwUuHTdspKsVMI/7DqZInBkNBTu1epD0nVAEE2eMnxLy8uo7b+wnwjOsKL
 HdlwohA44/8rTfE9E5e/i2ITMeb8QH97XZCkvx/sWRtMW17RIltFiZTi/CcrQQPPWaTPEeYnzm
 nGI=
X-IronPort-AV: E=Sophos;i="5.79,345,1602518400"; 
   d="scan'208";a="161814795"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 08:41:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9GOFEdjFz9CMwabjRtGqpuGgND+hNAcVftvQe6ph9qZlEyoiN6Vox54G9D7UIgUmmpy2u7lYaI2LeU7tt4xiDo3VPWPKgsN//8OfBxPK7B4qce0EQwnIPYAuYupgtT/xRcaURFVmMhSkUVA1/q8Vohi6ZtE6jaydsKIDQXC9vZy/28+eMLBRAtfbQbVQ7TbCl/EJ96jmcrKsrn+ECyrTaiNEQA1dwXWAVpXIrrTa2nU18A1RORkW8tQ5STPurzOD+9o+XshDBod0b9r16wklvzFeh7rRfwy+w/bl9zErrxthIjlYIvoeNr58kVKG81U2sNgj7w5hU6wj3yEwkDjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKhND9DZTDa+SSPqub/cbLrUf7sjsGrRZpusE0KMlno=;
 b=LY/ls/5AoAa5oaNCEybPa5A4F65Ic2F1bDdAZ9cW09l5/OBp2Iic42YuI0VXx8EYG6IS6iiApJ8fIijiZNTGECAxxYvfJ43tQkLWlUTABTmxo1nsIaXnQ+fJbMgJO9Bsd19J7FBdKEeMp4GmolsnseaGORjti8p0clNf2FXSQ6q7gByuTjupKxVKiQ/o+bszAa7GfY7sx4zZ1gp3P2fgNTWKXZnuYAdcMvoMWgc585NlWFwmbUrfKEOzCWc9lJNxE3UkKMXtST1NIKWcCoBSzzJN8m/MpurOWV1D/VMXrEG2+DbCNy0xSTZ/QjN8RNp3VppbH6hhICRxsmYu6O/MmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKhND9DZTDa+SSPqub/cbLrUf7sjsGrRZpusE0KMlno=;
 b=E1wYlKcQ4vCDuk9pU07wC1HeRPtZRCfba1O+stToO9RnUBY6PWQfjxbHCh7PwP10Kr++kCV67RWnl0eXT8dKDOJ4fia0++o/V4nY+u3sht093xJ1nLfANEbOdaGzaMqZkfBmkZaienEkxSXiiRe3vOoOFiHuI88fIq2OOTT9b9c=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BYAPR04MB4869.namprd04.prod.outlook.com (52.135.236.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.11; Thu, 14 Jan 2021 00:41:52 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 00:41:52 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blkparse: Print time when trace was started
Thread-Topic: [PATCH] blkparse: Print time when trace was started
Thread-Index: AQHW6Z9Zew4mkTblY0e00liPQPN2jQ==
Date:   Thu, 14 Jan 2021 00:41:52 +0000
Message-ID: <BYAPR04MB496593E9A067218A38462AAF86A80@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210113112643.12893-1-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1cffe42-ca1c-4338-0c00-08d8b8252f80
x-ms-traffictypediagnostic: BYAPR04MB4869:
x-microsoft-antispam-prvs: <BYAPR04MB486955477E6C038BADC1A89586A80@BYAPR04MB4869.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u+Q/Xc6OaYDGQDOt7mEEWiRnf+yFrgXoWT5q2zL2Avo6EUnzrM9RiPucBv34FJwVudI53Vwk3tWVwe0BkK404U4kjNfQ7sYNqKxw/JiH3Esfm3jNcbeOCBuQChfk08eFugF/LKUv71vAt1eNGFvHrfdBtrFJK3/iHE8T80OMK+6FN5FbpZtUiUHQXauyxHf7UzbcxKYBjQDhxGepYXkXfx1nFnrlqjHLMu6uUsVrzAAuorCv6cVC/fzRCzNEt15B7FBNHfOO3KTvlFd5nR94dtPxTQxKpSQZnpIsEaYrlrfk3z9yCKtMi3WWhz2L+RbcEqhpIiFjv8sR4l6fqT5AxOUm0/CyP5spnE+/7EjOdKh5g7W3AIiNc7nygmrNpm7PN2WDA8oieZoWQ5ULtVJ4Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(71200400001)(66946007)(66556008)(66446008)(9686003)(55016002)(2906002)(52536014)(53546011)(66476007)(478600001)(5660300002)(86362001)(76116006)(8676002)(26005)(4326008)(64756008)(316002)(110136005)(8936002)(6506007)(558084003)(7696005)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LCZ/FYcv5bQ34yyoLwvDD4nQtAL8He5vztgBlwx7gczV+VBMhh6RGvPCIRHl?=
 =?us-ascii?Q?KXw8Wovh++UHKzbnkGhl4azrEUezTpER0fhFyrkt9ifwSuYZdyang1LzyHIW?=
 =?us-ascii?Q?m6QdXL7RH0PUoDsboBxG1Q5to89duW4/iQOVLeXCCcxAfs2YBMqzAgL9sMyT?=
 =?us-ascii?Q?QoTamc9a3Oi0yMd0+86XHedJ3WpsuxaJjVYPoxgE+KKOB0Cek9jL06k2st1i?=
 =?us-ascii?Q?/RFnddT0z1p032u8LI2rLFPVybejsDWxD7U/KsBXaAxovm8QahXoBZh0AL5N?=
 =?us-ascii?Q?1Sb4L8ot65yb/kjd+dNmvmeE9wM4uQkA9xM31Tn2A7FmeACCSJoC7KSa1yds?=
 =?us-ascii?Q?6pSogTgxC+mSCWGqJ8BN0uRk2F3QYniUyHB9q6nd6t6R7i2/113DhYAb23QT?=
 =?us-ascii?Q?WyXAe+YXK9Itcp+NDPhYPdR3PS9LxKobWyCilmISlIF5igHZDxtTXUPpE2eW?=
 =?us-ascii?Q?5bn9WgJLdZDPnuMb3diI9gmfxY0BL9k/Pp3r+pU+Y8dLf2m28JZHzzikdiZG?=
 =?us-ascii?Q?hsgjk6xVFd936wNpLREzctjZ+G2hxEOrIULcbYqk3IWr5JTn+Mw756P2ouHL?=
 =?us-ascii?Q?gvf0X/bvbVpYsOmqt1XHb2n8l8NJj75XnVJbRMcL+Nao4pMvagTXZA9A0epr?=
 =?us-ascii?Q?lvXFpI+iOoADNDGaarux/kIKKxpB/tQu06MFAw21cp5B/2jrK5n6zyN9uhDn?=
 =?us-ascii?Q?YTTOEQPi0fUyPm4Tmbve/8QLygDj+oJBKrMs8jKBvBYC8oW2mUmyHSutP7bz?=
 =?us-ascii?Q?RqixwW80R1BBqmzXCP8OCojMUea3jHAq0+YpjfxXNanhmcw9M7WN7JflE+CI?=
 =?us-ascii?Q?MYkzPqdvU4LUpwDETRtNjd/K4s1IlXd8+UDqJgxYfoSoewyE3hGwb6RDeMqP?=
 =?us-ascii?Q?LRiP2MdxCGdb2vWzhuUvgkIPCb9pqkWTAN5Aw/KWZOG8xC20RV1E9EOg0D9u?=
 =?us-ascii?Q?AWFnhNoBKvfHRAubHoMlrd7+X/Y/9To7yc3uQUl7lslnBWU2Jv86v3TVbKCO?=
 =?us-ascii?Q?E9+i?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cffe42-ca1c-4338-0c00-08d8b8252f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 00:41:52.1759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqoQXfIKZFZvxdr6JGmpAy28tyQI6ZrSrviNS+DGZ5za+tIFtvY3IPH4eA1WQ7/2MW5lSTsEM9aBXCYgbXgRsQxUGUoTAuzYdYcBFG60eEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4869
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/13/21 03:29, Jan Kara wrote:=0A=
> For correlating blktrace data with other information, it is useful to=0A=
> know when the trace has been captured. Since the absolute timestamp=0A=
> is contained in the blktrace file, just output it.=0A=
>=0A=
> Signed-off-by: Jan Kara <jack@suse.cz>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
