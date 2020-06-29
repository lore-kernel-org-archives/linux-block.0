Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E28C433E2
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7872821D81
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dkARbvVG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YVFSgIO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgF2Sgm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:36:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31224 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgF2SgH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 14:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593455766; x=1624991766;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IZpp5SvBxjixfkqcxgtpfz3adyziXKNwktTFRUBNZCo=;
  b=dkARbvVGI285PGmpt0iwQ5a0wsGAiIiy+nr5aahmBTIWljC+OKcIoYDi
   YN++q9kwGmo8gS7yH1ji19OZTnU/ZVcFjFh34C0XlU9x8iPrbsHwUhiWU
   P4C9gICkax1baSJiqTRR7y62+QtD98dXR8UrRZIab9NKfXRPPaTKmOQz+
   dkVPXtBRTjISEaACBV3wZxCEZ+xHMfKMu9IHgjkrw6nhdqNlB2bHO4vsw
   MTRm/XXsIE9JeDbMddisHjOD1EwgVgZNLPm57HuNCknyuczVg3IhA6I/o
   NX8ATSB/igbh0hwwJjZQojrooJN1LBg0VF2X94UtRD2F4VCF0zYCYeGnk
   w==;
IronPort-SDR: V31vVx+PxZOun4BdBqtANHXyE3W/ZR5sCh3obq6Mo7QKqjLwgRc07mxDbTf7qmVqr0KzUJkEXy
 +VKigpUSekqd/RK5KMHwAN7q68xBxMQNfgWD6LNyI/v4EPT/2gNB63NYlHDWYMrPTAKf/4gD4B
 oRC0ts+rWodNtdYfWm6GLE/4ONMGksUTlpD3wUCE86LkfQizAYhuixY5mPe4qV5KhgGElR8RlX
 DPNEepJTxkPb+U1IPrxKxTHMJ4x3eqW45BZt8TxIqDS94oVYDTje+S+J2AFQGUX+7T1+lc7y3b
 bqo=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="250415607"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 21:53:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7W5r4yvCVMLHqvyx0wDJrH6eqjQBt2id+erS87KVuBZJes+Rwoos3h1nLJH/KceKh2OxwmVZoh52RJq/abeBy3u0MD5IoOFYDaN2pbhiie3XHd1CmkQxPPZ09lXkzMiroUruYFak5zrZzZOWDbJfp2XBfWkdgyV1Mo87rr8HaK7GUqGR903Ats6AcdAFNqyCtrdDJdp0P563xK1oINoJ7Cq3z+ErQazlg7Pf2AR0OGkPnFEkkjeQHZKv0Opvg/uJMgmPgMn6grPjFNEr+GSt0kMTT06V8kkzw+STNYsgL/e0mnxS5gn8GQeJ3Vcv9SLsZcvgs5AYkKtaDZiSsyutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7erN7Uiqh60fF9za3HCuyaiDfcCoeDkuPpqMMjw9Mo0=;
 b=c9ilmHHqzwD16TfhAEpPyTkr+x31ZaNZAwS+wjbbpAfUP69SrfT+4agdWE5SfGEfrd1L+sJboZX6QhjyLtuvK5QrWLH1TCZS7lNjwic66a+dsI6KAXRN1hJg9+TPAqwBj8oxpfbG6Co/fbyjIvhoCNKyvGptdMgvsWhzgGXOXISeFd0mvVyw0Qodch2+6rhP4DUayP4QbxeygkJzggLYeSkwqt4VgBtvTpjwel6+WwBH67GJAW6QPGEp4FV3Z/Kn7Eq4BhCvUGFgipGo1ly4B0Vz6VdiclVbFrkCzjgwpHpim57aoa48vvdOFJRoMZs3d9dW27whMOmAX237BYHnfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7erN7Uiqh60fF9za3HCuyaiDfcCoeDkuPpqMMjw9Mo0=;
 b=YVFSgIO/pFUSbx8nyazObQpoO94xPYr2JZtlj/7sy1XErOGkExouh/kKFW93jo0sMRZxuFvByOJB+uC8KXSmDmI38WOp8i8lPXVf6xoszw0TwqcCZG1QzViBFuM8u2EBKO3rd622reHz1AC3n3JYmd9x1oG/iEvb29tJd4sS+JY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5117.namprd04.prod.outlook.com
 (2603:10b6:805:93::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 13:53:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 13:53:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     Keith Busch <Keith.Busch@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCHv3 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCHv3 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWSLHIJgF9UbkqjUq8YxPc9nylHA==
Date:   Mon, 29 Jun 2020 13:53:21 +0000
Message-ID: <SN4PR0401MB3598D1D59478B8AEE270653F9B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-6-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b40c9cf1-c610-4a47-3d09-08d81c33c908
x-ms-traffictypediagnostic: SN6PR04MB5117:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB511774EBDAE2318F3D90452C9B6E0@SN6PR04MB5117.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1CllscQujVl+lkiuhUYyU5jV/Gw9J5c5v2o0rWhVHtC+tPTK/VXZ3JPXYShzwVoXqTV4JtMdMn3x0GG+E8rGqz2oDtfosxzmAkAcUVAz+Ft0oX4ORYEG+Qep2/sH7nKwI98q8SkEEiTjAOU9JN5mFo1l9cthBvd8lfqoJ7iwRAug4G0+UEw53Sk4qcJqnETAl7aqjGzXe/fEZh+eYCKUrZS7+JYBdWpqXYe045uJc4aRP820dqucoPROko/MKv7+s2bz/zwNcdSUe4l5wU+xTATOfU9YtB46ivBhRIiARHHzVAI32o7rNx+lnKiuD8Oz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(66556008)(5660300002)(91956017)(558084003)(86362001)(71200400001)(55016002)(9686003)(186003)(4326008)(64756008)(2906002)(8676002)(316002)(478600001)(7696005)(52536014)(6506007)(66446008)(33656002)(66476007)(54906003)(8936002)(76116006)(53546011)(110136005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VLmVEpX/h6qz4bUhbdkSmUgRWg2APZPc2quzBCskWAgyGg1DSuh+wAZtlyCx1iBlewL/xRAWyF72NIp/uNWvu7vHjxQ0uTKfU4HFxEypGUcp8A0YmM5vA/gcsLBa2br8dwF6q99BS1mA2CWZec/00BQg91LsX/RV5yTp0JLTWOcjZzZ8mx99f1D1JMVnXK0O9o7Z+uVRJ4hctfi/PncwxA9+U0CqwW2NocUaF/V0gN0xG+WofNIR79f/lrVRhxJmy57TXi+AkHHBtZm4uQhbTzI6zNUn1/+TFYnrq57xLWfx25oVD+9Cxw8o36U06vzhmGGMdRvdW1PBxbU7AM3JxtyhjIzO141VkhXzyiy8dowQG1YI9BNFpg7u1fyjpYMT8WNvO2SWacshvWRFjtWPUn4+7YTlfeMI4vfPnsH8z7ZZr6G9fW7udtRLrSYjySaxk98yueJeqHVRM79Wcwz/QcHCghs7Rq7jjKM4Out9DWJmR0NsAUhXn9yE+eowgv7Qrt8kazuXXyjpCuX8rPimzqwcvftKQLtODxTPqty5GmOuw2I+/6p7wljvZAER9rcJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40c9cf1-c610-4a47-3d09-08d81c33c908
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 13:53:21.3765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1Y0HbfzW5xyBZf3npdk17+XYFuuSyeq0+z7VuLLmUc3KMImZfKmu5llY4tID34uk0DQzAuqiRf/vAc1SZu75U0rL+6JpQKmbVQ2Ij5SCXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5117
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/06/2020 18:25, Keith Busch wrote:=0A=
> +			le_to_cpu16(id->zoc), ns->head->ns_id);=0A=
=0A=
That should probably be le16_to_cpu()=0A=
