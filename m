Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65DCC433E1
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810872080D
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 08:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CQ/A4iH5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fajFwL1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgGTIQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:16:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12068 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTIQm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 04:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595233001; x=1626769001;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=CQ/A4iH5HnEKl4BHki2ObbEMOkulXvh33vfnYiwt8qC5rgvnRJBs/y0K
   EbBHrmyY0V/j8B2rD8YUDumMcsVBWMOaM1kufMtSJagqSz9tBuKXsfTUX
   MD3QFQn/00DEgQIxVDZs7UwH54gqfMPLiC5WYlYSgpRBvIluBXc5MVl/V
   aKNg2mMLkJflSnh8e2Kkt9GmLwtscdRjBiDRFcXc3dFKUsbxs7G5GRLW6
   cLrIAdepeQk5I9bUM/2UprCcerAQvHrIY4cIQGbTmerd6seFiSNAlprVz
   s645Wp22pvRQDvEToStoZ6GnoQKQopU5AaGb7H7OZUZNkJPxGO8uNQKWd
   A==;
IronPort-SDR: VlhWi3aiFsUs/j6pZwF7GG+2BrgWm0DQLhFswCdSF9lTeLD0+9/KhhqG9cGUJEt+uPfWYlZR9w
 95w5U4SmyCBKtsXefQiR7DGW0/+6ISEnqnhB+FT7QPBy92eqPKIqLdkJr14ndTv3WIyi0xuHWn
 Hp0rCcLXNzs7MQHtvJ+Okknkmhcmy/L6KEQY82MM2flPajBhq//7q4hte9oIE3BASbBimK2AoQ
 Phwd+2kkJK9qW4+9k92JWtyGJAZ3FwRJW9eV6qXMUbIytcGuCrC1uNl8zw/xRdqLOjd5eFadES
 230=
X-IronPort-AV: E=Sophos;i="5.75,374,1589212800"; 
   d="scan'208";a="252169507"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 16:16:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN6NpmwuVRpvKZyn89X/UVNzrNEX6BxtKxviyHbwMQX0HR9VwfU43KaLptQJMvIrLiB8VRWd90c/LQgRAxQ4Gps4eOy7164eLeqz7IERtAMfX+JGd7I0ErU7VjVWyV77DecCKzy8G0uA2lIlfUj87YvqjEHMinwsJpM7nmlxQnuW/ynhHd+aTEw9x8uznvs6iq6Z9qYPhKWDHVFGb8mn003XvfYSZ54AcMmSabi+JBc5AXETtvuQEy2jjWtYthy3jj5OZWKryCdHQ0RKT6Uxkn113nVqVGFeaIHgzjMYjFUnrYab/q4y9245fmS0R9HmPIB7JzZEZp1cOhPFyFNAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=T4gglniIAv6vo3YwEdd7i1hKexCvOt5q4pTqCd7xOc5PvwJRfoKHZvLDISD9ZKv3g0iEp0M0j0zvauGVbgcTZwUltGddrs9bTQZkam7dtzlz8jHUp0V5ub8OoC3ArdV6xXu+rZb0NVDZEsahfnOwRBsCTXB++LS/9X5KOrhMPBCElhbQSm9NjKziWC6pke91H0gt919Z20KJ+SNvYQ6nfq+dG/7gbT8J4fQWwCKQ7M0zsoh3bdbSk+Mwq0S1VM2LbBslSPnfsYXj+8Weo4naCuqoicyOz1vdjsUPRmlYzt51ae/RTK6Z/3zSq6hSxphQHvg4oMiDiSvfIKQmeYAHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fajFwL1tzeTsMATyGn8B3IlQJvFObkufdnnjmGXpQyq+pS4T84dUBD0cwUjOQh74LICo7FKvoIf1ACFOv3lU82gcCV8FgfoJYeWcDsyjQKRMw5qWK85InVZ/50NeAflpIBiI5q7V7bt6hBERwEo/+xLhQ50MwibrfDUU8ENEz2M=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5166.namprd04.prod.outlook.com
 (2603:10b6:805:94::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 08:16:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 08:16:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH 3/3] block: remove blk_queue_stack_limits
Thread-Topic: [PATCH 3/3] block: remove blk_queue_stack_limits
Thread-Index: AQHWXlzVtFHibgNBAkS5rHyvYOrpqw==
Date:   Mon, 20 Jul 2020 08:16:40 +0000
Message-ID: <SN4PR0401MB35980995216CB6C96F453E789B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200720061251.652457-1-hch@lst.de>
 <20200720061251.652457-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c8b438f-139a-41b7-a07f-08d82c853b13
x-ms-traffictypediagnostic: SN6PR04MB5166:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5166264A667E6B4DE4E1289C9B7B0@SN6PR04MB5166.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: klvX5iBovshWTyLAn6njobqB27vMOsMtIhdgeuYnEO9ss5Kxlbd2q39p4gDuKNwrauYAsW2n6Ap1WaDTLqiRD4eam/jbHYS/iJaySDWpf0ZgMtGGSseqYKCaMKV7HuMShQWrZTY8xFs6ikHeyl53cbSJqw6hJg2q0Pg/paM2YK6AGEbvKe6Wh+e4bZyuxOHD0YGx8dxLCrAJNL5g0Zz5xVqI0N2GwwMmH6eM8HLUlaYwzfnC9D0bg9HTV0n9lDbEYCBTY8F7OnuR0zUQSrTtyeWElojYMi82nmmKBCn8hc0+arSVtdAp6EXDJdmVZrR/BtF33O5cMXrYAGPZ2QyZsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(55016002)(52536014)(8936002)(186003)(316002)(5660300002)(110136005)(54906003)(9686003)(33656002)(86362001)(76116006)(7696005)(66446008)(66946007)(66556008)(64756008)(66476007)(19618925003)(478600001)(4270600006)(71200400001)(8676002)(91956017)(4326008)(6506007)(558084003)(26005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: c69WXCzgM0E0trOV6p9IY38lpNpVHYqg1ZiQG8D8s7AWW4Y1A7n3I/+Z7LoDa5uq6LU6Q0oS3is19QxoLLuiU4/0AygaHg7f5LRPbvHVaqvoLIzOI8tsidRySi2Wfpuh50+2l6/9LxnKTk4e511txLRqhPlfrZ4IM8Et4QRmoxGHw3EUDj0j016kldOnWJ/wlzeFYjlkAzhFhuk8t801Vd7bwMORGDZO+oLEKd9ETXFMiBfUGQsPB7ACqgKWyO/uDZUvyIbtshCN12b9XCiEsTi0dt1osg9BBcCUwMzkG9CiYjDHP73+dQmQ3R0REHXwk2EFSfEIsD7xPn7s61h/UOODThYBEr71rJsgLMM+YnYnUfGPCSsu4pfUORAbMoiMzp27Fk6w6AO9pQHrE+gGPUuFbA0owP7Tl+KyqBMLmOF1PV1EFnOEL14qJXAw0pkmzgPzolk1zEoHm0XbvD0xNbicLefyxyi5w1mUKJT+xfDAYxGUOUh+NSFPrUPIJhA8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8b438f-139a-41b7-a07f-08d82c853b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:16:40.4280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hFGeraW2QFjRljwJJH6L3nWVgndEVrjSAocYy6bSLLWOcDllMJXHXVhFLm156pPe3SLYB8PbePaaijCqZDDpXQoymhl2ui/bn/Icr4t1oaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5166
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
