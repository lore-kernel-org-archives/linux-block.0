Return-Path: <SRS0=ze0F=AY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BDBC433E1
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 23:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CD82065F
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 23:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WF9YNXaY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S0bILe/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGMXMG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:12:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:14965 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgGMXMF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 19:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594681924; x=1626217924;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=F28ArkVJM9bIMoAgODkcQ4ubrd+TvAOrrvUpPQLRygw=;
  b=WF9YNXaYw13zinJZZtgSxWKfHb36TlSYI5O0PnfPbnC4+Y76uXk+shQB
   q+fofWrTi4DZL2TMxAmP+VlVXP+yEeZLaUzKy35jq/tS7v+ry2gP3TpcJ
   0aAt0FlcfzUmF1zmI8l+jf/EDCL8VXAFrNHlAa5wnxXZclgXdCTT6fLDw
   1Y9zPt+dxCGPGUD0/wgQ9bnk5N+FhfpXudMoIQZOvwMbQ+Ti0stZHncQ9
   W85dz+Myg1H6F3WkGGukdC5goQOQ3ocSXduy4ijaDX0D9QFjvUvcvC+hB
   QLzlYI4nxbi3o0KmgqKMZhaD5UuqbIqJVCTEFut1Ws/jkEAkkbONRrk4+
   A==;
IronPort-SDR: 3tKW+z3aFNsF9k22qasr9siiWGNBv44fhNLCXTWxFNgL49XgfFYIAeFqgp8Cr+fQUAXo7MXZ7Z
 ysk2RusYht6jLyhNTIpW5L1jmBt7qpIQENM5CtEz8OSapRWulFlxMFzTNxRi8T3B5+Do6J/+q4
 g2Ra3EV+kyxOLYv2Xj/3nqrQv9U2MKJd9FUGiPGN3YOmYN/mxfbUTS9ttk2wrXyjKuAzgYXSVu
 fnnAy3IQzoxEhRXiWkoZ7by6yz31Fyd+8BFVgxhulVMixdKfnBpuYaJ6ZZHV/LZSwSQtbfsKaT
 Y0c=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; 
   d="scan'208";a="146668711"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 07:12:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzfYCMmH62OB9RO/WNpiA9wJ6xPnf3D+9YFr7TwmFXXJT7myDrCwyWPBRjY7eBoeoapXghO6djIXFtvlhCl53bnHjz5u1lvo7Dihr6RnUNqG5JeOykrl24iwRVcPz0a9F/YJt170G2zbHD5FMk5L+vbKdnv5bnnsaQ6xyoex5ybGOVrfPcSxBnQ24yDWknVYqFPiLZ2fd0hi7QmlmEgVqmOkEYd33vNmO8pHFEv7tXFAzkSNZ4Ipwkt3q5t0TebUiFA4BkgyA6i3nUFMIyUaQdceWn5jgZOZMrHh6LKLdmxeYW4jxFIuvqzlTJ4orcnjT5DMvPFkyw+Qfzin7VJ3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSUwRq5nz+cP+JwDr0JponY1HAZk6ATdPGRi0zYo3Mg=;
 b=ZysQ/t2tYWFvzJM2Ylh+X340/4UcGctrzWtZ04qBXX2AFSPoomcafpdlpPuHr+5Q8FiusykN8nRiGfXY9/YeMpq4xYFxYWDKiFMtj4KdQlBZvbbYUdveozVPt6HYgdrPNOBpHJQ8YPM6hTOJ1E3n+itZvOwNd/92JT5ilOjLycVS5PfEXixhgGgv407dCVivc9ofm/amsIK7nhXh/RCmO/ANMk1Floo4gZ1URS9QeBq/chvdVUG41b9aqrToK+8hGpcgXOn8AT64E2ChKwldaCv8ERFEjPe4xKl3vd1tttfZj68I2JD9ErSyRQQTWsCXhfEO3gJbEMf5biSNUECG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSUwRq5nz+cP+JwDr0JponY1HAZk6ATdPGRi0zYo3Mg=;
 b=S0bILe/x3iGdCQgc7gG/NL0VqtkNlaDrhSkvpnGpbc9xWp7IadV5HMU051F9Iyguta6c46KlMJQFvlQezkwYgygWKoUO+AXeZUVA0rgIF2xxltayJ/qwmnb2zGPlTwKvke3T6dQSn/2ThWJSsn3w9lbstasidUJM2tIHqXDbb+w=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0729.namprd04.prod.outlook.com (2603:10b6:903:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 23:12:02 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3174.022; Mon, 13 Jul 2020
 23:12:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Coly Li <colyli@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@fb.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH 1/2] block: change REQ_OP_ZONE_RESET and
 REQ_OP_ZONE_RESET_ALL to be odd numbers
Thread-Topic: [PATCH 1/2] block: change REQ_OP_ZONE_RESET and
 REQ_OP_ZONE_RESET_ALL to be odd numbers
Thread-Index: AQHWWRIVO2FYBZI8EkiHWlgrDTCn2w==
Date:   Mon, 13 Jul 2020 23:12:01 +0000
Message-ID: <CY4PR04MB375143BE47AAF4E210641152E7600@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200713123511.19441-1-colyli@suse.de>
 <20200713123511.19441-2-colyli@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d3bd6c6-62a5-43e5-1e44-08d8278226b2
x-ms-traffictypediagnostic: CY4PR04MB0729:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0729929FB843CF6B8ECD05D9E7600@CY4PR04MB0729.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fju11hBlR/kI+Las8QxkIdpbZTdUxFd34XjANNsb/E5B6bf4lk6BaRvJs3vbgokDJ/rV0mst3FIRC5nVem1IVKD1xQ+0R+zvPOUINCZhqxA6eogdrK6xVVSZqbj1TBI/4XUgK7WFdEUZ069CD/j8GZm33TkFD/t71y5oHmR9f4rjvmWHTrwxNG0neSlB7DhWa8i9NvJxCIj74kRPZsZ6EFb+iljLF1FWgcD6+WYHc07eGn4voEwXtNeDdqo3fFC/5Jt6PcbqLeWedTRkF6LwDuN7diwrKq5sH+zSqsEl7ZgEMV/3ds/fkviEgXZx+5ftXvA0emE+1XLnVcIMsDbgcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(9686003)(186003)(83380400001)(86362001)(66476007)(8676002)(76116006)(66556008)(64756008)(66946007)(91956017)(66446008)(26005)(54906003)(316002)(71200400001)(478600001)(55016002)(33656002)(2906002)(7696005)(52536014)(110136005)(53546011)(6506007)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NYPrerNdLX/H/5ecEIsmxOfMYwafNacUKlomrZuNrIef7gn+C+uyHpMVAUQUz88WCE7OcO47I8SYBHEh1ELPSG3QFHrodGdWxnp3QiOQMY0sgcC5XhLsRaLFelV9RyrpLPVoxxkYD0kazN7LgQLuBlvoXsvJoLLwFK9wzE6xVewfZTCwHui6OxvJv7T1o3i4BbaU+LKv+azzKICB4SXYWWYU4DeoRTHK7xIKbTgY+StdvIdllK8kLlFTB3f4wX4lVUPszJ1w3GW8H9LlV6RaQ9C6s8spZEp/2eNowjadln/YG50fCc4vPYw3lqasNELoE5eKQMIhRDnlwvQaVeHnZ5K/tEapcAx58QI9/2ExuAudWsLFrz6Z1KOn82oXE9uyZl/s0aIdLk2OQYMuvXuApmdf6KBZPohd7g4AegO2bHxKk0Xh8Tt2BvsNmNc87jtLuSXrs09f8dCiKAT3wRYwP7a6eYNJnfFrgKO1PVRA49pd9gMRzuusCUuaVsNKTC/B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3bd6c6-62a5-43e5-1e44-08d8278226b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 23:12:02.0014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZMSd9CRmrskdO6gtGb+MxpnQrCRhFEnhzfg8CCh04QqQRY00KJCeVc+kO5dZk7DBUgq1+NJcdd4y2mRR0ZBCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0729
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/13 21:35, Coly Li wrote:=0A=
> Currently REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL are defined as=0A=
> even numbers 6 and 8, such zone reset bios are treated as READ bios by=0A=
> bio_data_dir(), which is obviously misleading.=0A=
> =0A=
> The macro bio_data_dir() is defined in include/linux/bio.h as,=0A=
>  55 #define bio_data_dir(bio) \=0A=
>  56         (op_is_write(bio_op(bio)) ? WRITE : READ)=0A=
> =0A=
> And op_is_write() is defined in include/linux/blk_types.h as,=0A=
> 397 static inline bool op_is_write(unsigned int op)=0A=
> 398 {=0A=
> 399         return (op & 1);=0A=
> 400 }=0A=
> =0A=
> The convention of op_is_write() is when there is data transfer then the=
=0A=
> op code should be odd number, and treat as a write op. bio_data_dir()=0A=
> treats all bio direction as READ if op_is_write() reports false, and=0A=
> WRITE if op_is_write() reports true.=0A=
> =0A=
> Because REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL are even numbers,=0A=
> although they don't transfer data but reporting them as READ bio by=0A=
> bio_data_dir() is misleading and might be wrong. Because these two=0A=
> commands will reset the writer pointers of the resetting zones, and all=
=0A=
> content after the reset write pointer will be invalid and unaccessible,=
=0A=
> obviously they are not READ bios in any means.=0A=
> =0A=
> This patch changes REQ_OP_ZONE_RESET from 6 to 15, and changes=0A=
> REQ_OP_ZONE_RESET_ALL from 8 to 17. Now bios with these two op code=0A=
> can be treated as WRITE by bio_data_dir(). Although they don't transfer=
=0A=
> data, now we keep them consistent with REQ_OP_DISCARD and=0A=
> REQ_OP_WRITE_ZEROES with the ituition that they change on-media content=
=0A=
=0A=
s/ituition/assumption=0A=
=0A=
> and should be WRITE request.=0A=
> =0A=
> Signed-off-by: Coly Li <colyli@suse.de>=0A=
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Cc: Jens Axboe <axboe@fb.com>=0A=
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Cc: Keith Busch <kbusch@kernel.org>=0A=
> Cc: Shaun Tancheff <shaun.tancheff@seagate.com>=0A=
> ---=0A=
>  include/linux/blk_types.h | 8 ++++----=0A=
>  1 file changed, 4 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index ccb895f911b1..447b46a0accf 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -300,12 +300,8 @@ enum req_opf {=0A=
>  	REQ_OP_DISCARD		=3D 3,=0A=
>  	/* securely erase sectors */=0A=
>  	REQ_OP_SECURE_ERASE	=3D 5,=0A=
> -	/* reset a zone write pointer */=0A=
> -	REQ_OP_ZONE_RESET	=3D 6,=0A=
>  	/* write the same sector many times */=0A=
>  	REQ_OP_WRITE_SAME	=3D 7,=0A=
> -	/* reset all the zone present on the device */=0A=
> -	REQ_OP_ZONE_RESET_ALL	=3D 8,=0A=
>  	/* write the zero filled sector many times */=0A=
>  	REQ_OP_WRITE_ZEROES	=3D 9,=0A=
>  	/* Open a zone */=0A=
> @@ -316,6 +312,10 @@ enum req_opf {=0A=
>  	REQ_OP_ZONE_FINISH	=3D 12,=0A=
>  	/* write data at the current zone write pointer */=0A=
>  	REQ_OP_ZONE_APPEND	=3D 13,=0A=
> +	/* reset a zone write pointer */=0A=
> +	REQ_OP_ZONE_RESET	=3D 15,=0A=
> +	/* reset all the zone present on the device */=0A=
> +	REQ_OP_ZONE_RESET_ALL	=3D 17,=0A=
>  =0A=
>  	/* SCSI passthrough using struct scsi_request */=0A=
>  	REQ_OP_SCSI_IN		=3D 32,=0A=
> =0A=
=0A=
Looks good to me. Zone reset is very similar to a discard, albeit stronger =
(zone=0A=
reset is not a hint). So defining these ops as having the same data dir mak=
es sense.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
