Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ABDC63777
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 09:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7174120C56
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 09:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgLCJNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:13:48 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52730 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgLCJNs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 04:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606986826; x=1638522826;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xfnK+R+cqNrOt00G417noVJmkAqShYJXrnCjiL+uZK4=;
  b=fnmsl/JWy8EtzLvCj17I0lrUh4kr59R1VsmoFL56wxCQFstUaN12ZGeS
   EL+nn4QLiWOjymC1Tdbrr0i3jBA1SNm/y75RjWHmqqVNd2Ujn6jSa9Aof
   kwiHizJodLJWudeEeUqWEHCHEn1AFFcuzOAkyGYPyhBfyHT91ka4Z2ylR
   G9TI7BaTr2OPGjw7Umb2bfLDE+V/dvI1LRdaEp6Ktfh4APHmjPVz+CQx+
   p+838ql8+5TOSmr40AFQgz3JvatpGFs9Kg4n0ZZzcpQkIceD3ryY/5ple
   n6+tKLNv3fLDUO8KKA74JmpTg7VNwMo/395GzsJ3Hi1ZRKnU4RDpvofYh
   A==;
IronPort-SDR: oSrZ2lM0Ufl681h8iUvT6BQemsA1dFvJVJrOsdqAdgM7gs8goyU+tacyfcojXzjO+LsbVFpH9X
 G6KOxHKMTAg85siwj/B0sGHmkPLxBaQEtMGfGeOAFCPWIwSgZLyTfjtvC9azOFfpZel7IM7769
 g8vcXxPTMJYzQ+67ZrM1VLumPt9dXKty59Ejo+HkqRPSCMu6i6I5ac3VFPa6ScL4zATQKusKiG
 jlK+7+nKCcS5ZqHBx1YOxN3SmuymePdHS+3yME4Ck+QZlSxTs2W8fHyOQ9dXY9X+8AwynpIlvZ
 05Y=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="154310262"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 17:12:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7nsJfK3yf/tHIl6KGl69N8geZyzuXeYLUhTDTg/CZGh2kBGCtTKMvQefvBcp+mFE7NzbyVHMGXOZKxE6prJRcC7YBfK/2M+lL5pGsZjQgMLnB8Ca9zMRR05CgsZW6m/cwSqz6KiOq0UFuWK7eknkGMj8O3bytUMXQTUqcGMdI3jb01M9Xx3tK3At4RECy5y95sLJ2erqmpKDJb2glHgHIxMZnPv/6CCiW99OCPAI8L9eTo5NWmP6q61fyOJlP/Pzgees87CYW16AKzkmTIu9/sB4eBRQSDYcOnsDtM+D4SR+3RzPq7cFf8tZW0qf5WngpQj251lB/qb/h7x2u/ScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEKy79A/yPENOHDNJXQG0Kl3FTjTsB48tWNlv9TZMsI=;
 b=AvSVsOks6tXRk0DFJEnj53V8h45r1dVbV4e8GR5+hkQGR9HafPB8OkVLeaarGy/4avzAOGoYnDvQQj8TpTN7chGcg+bJOEVYD/F5DMi46+3WHK0pIxk+UTk/gENqn7Fu3eRtjkEEbNVk2PEW53dZROXb6H2AuIZ/ISAzapioFUa4rSYICoEPuu1apIGETwusmKJS7/LfvoAxax9eI87FBwI8uJmfqoY38xZ6KwkS3TauO8zRu/WjAFO5dif4DK31lmq2pnCeMibSWGfk8CPG5zR4812oJ7coZh6PkzWU/kidczXvqd45J7SrabfaRTYDHf/zhHC9l/SLEQY5hN95KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEKy79A/yPENOHDNJXQG0Kl3FTjTsB48tWNlv9TZMsI=;
 b=lZEWGk++Ya3Fe8VcAw4g3jGxnJc9bSxiVvVcsU6b+K8H+znxXcAWIkfO2QONsDDCNqauMpKPKWsN2FNGr5IkdpskuYSe+OPzYGIT7lmWakDW7XPwh1t8r1hO7G0l6Ib9xQpd1ZiXo32YrFPlPvzg2SPTg1J9ZRtIByBX8x5aOIA=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6744.namprd04.prod.outlook.com (2603:10b6:610:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 09:12:39 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 3 Dec 2020
 09:12:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] block: fix two kerneldoc comment
Thread-Topic: [PATCH] block: fix two kerneldoc comment
Thread-Index: AQHWyU/xbemYiYquFkaU9/w1naoqag==
Date:   Thu, 3 Dec 2020 09:12:39 +0000
Message-ID: <CH2PR04MB65225F436E7E2FDCF46F094FE7F20@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201203083405.2097558-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44d0f1af-5380-4298-0d84-08d8976b9575
x-ms-traffictypediagnostic: CH2PR04MB6744:
x-microsoft-antispam-prvs: <CH2PR04MB6744C8AAE1B2264B4AD41D7FE7F20@CH2PR04MB6744.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOIjwbckoxD6GALhVpUDESTRsFi/W1aV/X22nU2RO13YrqUrrv0gbf5Qd90UqFnPWRXRGTuEx26zFGTxgPJCxHOCpqAmWieALVjI5benlPbCYfhLzqQoaNtHbU4GVvIeOCJ5ZaJp9mCBydqaYb97NV4N1yUKef7Wen2wVLc85nJHaSSjVYSuIkrk36kcDGWc1cK+ajW9zcIwChpwV7vxQj0ESLlS4QO5pfbSkXH7CyWgrjMUVcaFrkxxBRD225/bmQa0h5W23UMFTY6BEy+9k1eO10suWlXR8le0gVr32/uly+ex/qcfivh2xe68SEgf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(53546011)(4326008)(7696005)(54906003)(8676002)(2906002)(316002)(33656002)(110136005)(26005)(8936002)(9686003)(55016002)(186003)(6506007)(66946007)(86362001)(5660300002)(64756008)(91956017)(66446008)(66476007)(52536014)(76116006)(478600001)(83380400001)(66556008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EEdZjKNg2F/gzaHZAJOCHQJ2k2KnZbMwZzKhYqGQnVC578EVq0Z9yBHuJsZA?=
 =?us-ascii?Q?a7AzEZyHUY30q2hKuWFm0LaST5S3aCVLGFDuYc1HBhTEA30S+iqsk6Cye96I?=
 =?us-ascii?Q?InBm+c7NBa3sJ9nNgsTMpoJjczEUOqPQVaRaA4Ls5heBAyd7nQLWKxgU4DWW?=
 =?us-ascii?Q?06NkUTlAjOca7GZwitc6uYbjgX27sUmyNYp3w6qy+ZPbhbkiZXv105RB+KPd?=
 =?us-ascii?Q?tgs+n8OC9CKTuYhKPxRjJop2WH5tedv9BzOzdzXdfKzssH1UBQXU40xrF7Cx?=
 =?us-ascii?Q?A45s3RwvrRGndgOJJ0h7p/u/DYuUJAliZYOxteZ0JCgVnrn5TMP79OiJU2T7?=
 =?us-ascii?Q?RlbQq/sclqQEnpe9vTHLwoT9VFO6ESFtxGTYlUl9JRuZr/KotA8RIXo1vnOj?=
 =?us-ascii?Q?LPPT5msmHOuNztjFWnUMEQdC77M8Ot+Q2ScH6woyof2Obr8gP2VbdHtsSTqe?=
 =?us-ascii?Q?c3zrNFVhUNRZl2hYDNjRllZOPXBbxyV0hEyxKENeEg1CWQJ6nv7RBkykNYNM?=
 =?us-ascii?Q?BRoDaxxB0CWHWi8HtYgL3A/5G5IYUJg0brB6JkyEhtOy9lNTjpfwUFPkcz52?=
 =?us-ascii?Q?e+rwQlQxyY2KmZnqfuw0knvZ3DvzRc7VnJp2FvDKRmS0m7Wsh3JG06uwNe54?=
 =?us-ascii?Q?wYwPJ0WGHgZhTJIOOACuHQyKdMKNizxAJc7UUylc4slkuYC8jeW4HUgKuxnZ?=
 =?us-ascii?Q?Xp4rDwGogiuFHgiLXVlDlGnXaUrP1QUgumwdrGtDmjN85YztA0HISutPwwhz?=
 =?us-ascii?Q?hzRby6Cyei8fs8j3Ea4ffG9VEa/aAevZc8Zzg3pqGUmnJ6SzEL18qvbgOBfW?=
 =?us-ascii?Q?YbcFcrnWlxzFsOYMhjYIrWtyQm+M4V0FSTqoLRLNe+6pIygRSc9dIVCU/7AN?=
 =?us-ascii?Q?Uk7beMcQY8KINrzBJd35aMv6M9HzwRbh8AHSgcF9XQUietdJwECczIKV+NTl?=
 =?us-ascii?Q?tN36n4kje4t9hCgu6c3S5umdUzX8pwjVRGb+6erBGT9ZU+Qwy67Gd9/XS+3i?=
 =?us-ascii?Q?Hw78?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d0f1af-5380-4298-0d84-08d8976b9575
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 09:12:39.6382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPNWzHVlV8WWXi0tt7XV6mYvNSKOCl5+gjhOsvpZ/bGV6i65cVS7+HzzHO4iSaz6uWeM//YBi1mfb8Oe0lBYLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6744
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/12/03 17:40, Christoph Hellwig wrote:=0A=
> Fix up two comments for the recent merge of hd_struct into=0A=
> structc block_device.=0A=
> =0A=
> Fixes: 37c3fc9abb25 ("block: simplify the block device claiming interface=
")=0A=
> Fixes: 4e7b5671c6a8 ("block: remove i_bdev")=0A=
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  fs/block_dev.c | 6 +++---=0A=
>  1 file changed, 3 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index 9e56ee1f265230..9ab18364d96172 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -1056,7 +1056,6 @@ static void bd_finish_claiming(struct block_device =
*bdev, void *holder)=0A=
>  /**=0A=
>   * bd_abort_claiming - abort claiming of a block device=0A=
>   * @bdev: block device of interest=0A=
> - * @whole: whole block device=0A=
>   * @holder: holder that has claimed @bdev=0A=
>   *=0A=
>   * Abort claiming of a block device when the exclusive open failed. This=
 can be=0A=
> @@ -1829,9 +1828,10 @@ const struct file_operations def_blk_fops =3D {=0A=
>  /**=0A=
>   * lookup_bdev  - lookup a struct block_device by name=0A=
>   * @pathname:	special file representing the block device=0A=
> + * @dev:	returned device=0A=
>   *=0A=
> - * Get a reference to the blockdevice at @pathname in the current=0A=
> - * namespace if possible and return it.  Return ERR_PTR(error)=0A=
> + * Look up the inode at @pathname, and if it is a block device node retu=
rn the=0A=
> + * dev_t for it in @dev.  Returns 0 if successful, or a negative error c=
ode=0A=
>   * otherwise.=0A=
>   */=0A=
>  int lookup_bdev(const char *pathname, dev_t *dev)=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
