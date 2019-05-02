Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833ADC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 03:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F62D2081C
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 03:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZPxLWVQN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="W93rxw1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfEBDtz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 23:49:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30010 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfEBDtz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 23:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556768995; x=1588304995;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZMHDQCOpxOsMV2yWF/D0PgLhArRn9gaDQuz8shUXnac=;
  b=ZPxLWVQNYmuIS4/tbjNrVtuPza+EH9+8UsSsCYabO0nPHj3XQxBdWEd5
   6qwc+I5HGdrKvfBwixECg99XKxtOAV/kPQHemGcivYSqZcG08K981Y21C
   1q062s8jKQVj1qFvSU3B7CoM+0V/bb00U9bGMQHxwC5Lq5HhVoRNUfXc1
   Gz4/+9gD1PIvGRiTT5MNxIgdjy+6UI6F1QKgBAWWvnA4P2+AqWR1mEjK2
   vhgZMaJOZzW51YGffny2w1XLvOF3SYlVANO9dF3DlP6Skb4PsE7EjG9NC
   L/0GrajxdTQrGc39afAJbiLQdsdsGTbhxnKW0V7jmO/tjNP5ySFQw9EPs
   w==;
X-IronPort-AV: E=Sophos;i="5.60,420,1549900800"; 
   d="scan'208";a="107317554"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2019 11:49:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arU1FwxTx3/FaDASJRyg1EwXmom5TcToDrJArlnkCUA=;
 b=W93rxw1IH/Rjmhf7d/U6+pDg4xcID2LSoouBf2iIFIS8hnfEiuAxkyT329vop64epOY1B189DB3y8fkxCcOSuRQczr5j6ladR39hl1UQjf5gaJ0mduplZ92YakgDw/Wg795Oh+kZPb3CFqhm9yq2VIGOaVbTEvmaJdNIRXqNbt4=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3824.namprd04.prod.outlook.com (52.135.81.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Thu, 2 May 2019 03:49:53 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1835.018; Thu, 2 May 2019
 03:49:53 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC PATCH 02/18] blktrace: add more definitions for BLK_TC_ACT
Thread-Topic: [RFC PATCH 02/18] blktrace: add more definitions for BLK_TC_ACT
Thread-Index: AQHU/9ZflYOKr2HcfEmIiXJzp7+3Bg==
Date:   Thu, 2 May 2019 03:49:53 +0000
Message-ID: <SN6PR04MB45274C5A0187537F4DAEDAE086340@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
 <20190501042831.5313-3-chaitanya.kulkarni@wdc.com>
 <20190501123104.GA17987@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 252aecfc-1786-4b1d-4422-08d6ceb13c6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3824;
x-ms-traffictypediagnostic: SN6PR04MB3824:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB38248F0C3B8D2E73846FC67186340@SN6PR04MB3824.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(78114003)(199004)(189003)(6246003)(81166006)(53936002)(8676002)(91956017)(81156014)(55016002)(71190400001)(229853002)(478600001)(71200400001)(6436002)(25786009)(9686003)(5660300002)(66066001)(66946007)(73956011)(4326008)(52536014)(76116006)(8936002)(68736007)(66476007)(4744005)(186003)(66556008)(2906002)(6916009)(86362001)(102836004)(99286004)(316002)(26005)(33656002)(7696005)(72206003)(7736002)(53546011)(74316002)(76176011)(305945005)(6506007)(256004)(66446008)(64756008)(14454004)(6116002)(3846002)(486006)(476003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3824;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9eqaTpCtFgtMSLWl4Qj9oo2Nbth5U+v6PJg99ygniV9yCcMg8HeLH1PRa70OuLdU8rpWRHi7ddORw2rLs+23N327B+HP2w/0T8txqfloWhcP/8KGEb5sd/M8zQxihylQDddy3KkJwP6xOWOzh6RRQZqfO4q1RvA6be+CGtofIIbygdOvQIGWbf33Cv4H1STkTbRfgx4ZFOL8PrYMHRKlTQa1/cJYtN5j8iXFiQ1As9SsnAuSblH8nskhC5u/0u3UttbHtT5FLi9/6oIxH4ReM7Deakgvrgs0aI9RWXOXVsUZ2FiW9UwM803HJKzPPbcYx/Out9/vp6UmTwjedgfSbYlbsuOw6MX13Ci2z4NIpCHx7AZfpdg2XTtobSFpb+bR4i51x83FlGe3W3ThXL3LI2hdtmRkfCaF+omCxq7lYe0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252aecfc-1786-4b1d-4422-08d6ceb13c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 03:49:53.7071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3824
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for looking into this.=0A=
=0A=
On 5/1/19 5:31 AM, Christoph Hellwig wrote:=0A=
> On Tue, Apr 30, 2019 at 09:28:15PM -0700, Chaitanya Kulkarni wrote:=0A=
>> @@ -104,7 +120,12 @@ struct blk_io_trace {=0A=
>>   	__u64 time;		/* in nanoseconds */=0A=
>>   	__u64 sector;		/* disk offset */=0A=
>>   	__u32 bytes;		/* transfer length */=0A=
>> +=0A=
>> +#ifdef CONFIG_BLKTRACE_EXT=0A=
>> +	__u64 action;		/* what happened */=0A=
>> +#else=0A=
>>   	__u32 action;		/* what happened */=0A=
>> +#endif /* CONFIG_BLKTRACE_EXT */=0A=
> =0A=
> You can't use CONFIG_ symbols in UAPI headers, as userspace=0A=
> applications won't set it.  You also can't ever change the layout of an=
=0A=
> existing structure in UAPI headers in not backward compatible way.=0A=
> =0A=
Jeff has suggested another approach, if everyone is okay with that =0A=
approach will send out the series with that change.=0A=
=0A=
Please let me know if you have more comments.=0A=
