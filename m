Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A9CC54E8D
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 03:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D414320769
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 03:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d1NjZ+T+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V7fIIPRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgELDXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 23:23:55 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26326 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgELDXy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 23:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589253866; x=1620789866;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9DcWWNX5MQlUrRQAnN0bWIkEwpvCyHOW9OT7wJoqp10=;
  b=d1NjZ+T+u7cUXsDrfFES2gkrMruU272AW8d52H2pgtJJMHc8ieTGPGgQ
   J+CQkUkgx5YnwLKye91DSDrmgY5Uv/uACKyi6pIsl0UTBsgokbcAuAR91
   BdH7K1T1nxkra92sefWjULqFZh6CSVtNCHFWZCZKu4MepWooYsVP0zaFj
   b/Zl8vgrsnJXZKyVg5VDRd8sFzN7Ps8klddiHKMZAYHxMz93GAlW201Yq
   73iB+83Bg5FpElWIs3kUy4Yofn+UrKB4L8iPYEz1dd57+t4+e8HZRe/CO
   r0kn2QN3VEbFKSWjpwE3p735fASL7KaeEGicakulbb01f1+nrPtWRmsqL
   A==;
IronPort-SDR: PHTJU5pm3MqzNZffsFaeXCS3/uDzTcyaMPHiDKy38SSW/rVa4USy+AbrNqOLx04Fm4ScbTnjL8
 xfeV2TTPQABn+kZcxRPRCHWK6JYefGJx8mk6y505LaMF73byWLAQuvZ4KRc++plTpSnP1IdhSB
 YeYokqUgIgAJVEZjitG9UPMZC+lKqQ6iAXQmzx4vliCkId+AMEhbv/Wx6NS+bEJPpDt2AKLrVz
 /onXwYtkvCcQ6jNf5fV0uZAjUaoYgp81OS+EW10iZSsFmFRzVc79S2/CNt/APJIXnuBPRzZTAA
 EKY=
X-IronPort-AV: E=Sophos;i="5.73,381,1583164800"; 
   d="scan'208";a="240148380"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 11:24:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmvXRjy9duUtO1vuc+U0UDMs1gc7Y3xBElL2qpe9pkpMUXR0EwwhCMN8sMF036MGkdjAcv9nLYlXN5rgRTkS1cMuyUHLnM4ZX3n4zhBwf6mcVYpXOyoefTLZ1NpxxxT/OccpSn4/yB/LmU5ozAGRy0BggP1IbmU5hECkCfQ3WJOb+w88GOzhLFf7vsPncKglAeK/cGzAZLriX9WiNM2TN833hkRIemviDifWsVMV+ekA2p06J59WQYjDeTFscmpoW5vXTAI/S46L3LsR2RQjQa3mtP2kGUHypwIZUjORuaA9bCQ3sFKt7N+rbzC/tXE3KJW5xCl8Xlaq9a+EUuI1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DcWWNX5MQlUrRQAnN0bWIkEwpvCyHOW9OT7wJoqp10=;
 b=CujAKDojKje2u5R5YFp2xBg8/ynGKj79nnQ2FyQYH2+qr2jjidMbNBvdHeHFDT5lVBxywz6zsSA9LfJH4wFldBSqKpJ5Fk/gHcWGOEJCEPcq93SqZSCOJley0ycABzAlcABd2BmvMkcD8GWwHSSj6qvTp6rxb0RKfq2wsutpK5wCcE8yh6QKeoDI23yDhk28/zAv+3OFbmZao5P3zX+E9VcDH+zyoVB3Oi9CONeTdNGXbq79eMFazk+RyE1aG1FK0dcGl9bERTECZxQNYpCYS7UFuztprSuAiHyBZjA1DzYkK5f4NG4w6CysA/TwQj+pRSvKBgM0W7VXu7Fs83cBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DcWWNX5MQlUrRQAnN0bWIkEwpvCyHOW9OT7wJoqp10=;
 b=V7fIIPRZkWHRC+ssBYrC5no+AhqJ6zV/UDhLtV2VWiWGIIh3FHwMzcIydAfYZqKZBTlF2uhuuMXq/GAD41maQR44LPN4nCVTQs2BguFjhrE6cy0R2loKEQIQtjS1Q4jhp6Lt4HNx7cnIRW25xGHnu7QMGNM99FQDvsf3Pudmld4=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6961.namprd04.prod.outlook.com (2603:10b6:a03:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 12 May
 2020 03:23:52 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 03:23:52 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Alexander Potapenko <glider@google.com>
CC:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
Subject: Re: null_handle_cmd() doesn't initialize data when reading
Thread-Topic: null_handle_cmd() doesn't initialize data when reading
Thread-Index: AQHVm53GT+JHqNkf70+buklNLC0a/A==
Date:   Tue, 12 May 2020 03:23:52 +0000
Message-ID: <BY5PR04MB690069B7D12C21985A7B9FE6E7BE0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
 <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk>
 <CAG_fn=XXsjDsA0_MoTF3XfjSuLCc+6wRaOCY_ZDt661P_rSmOg@mail.gmail.com>
 <BYAPR04MB57495B31CEA65B2B5D76203C864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CAG_fn=WVHpRQ19MK12pxiizTEvUFLiV7LJgF_LrX_G2SYd=ivQ@mail.gmail.com>
 <277579c9-9e33-89ea-bfcd-bc14a543726c@acm.org>
 <CAG_fn=WQXuTuGmC8oQ25f6DYJ4CiMSz7_S7Nkp+z6L1QL7Zokw@mail.gmail.com>
 <55674c05-37dc-0646-af78-db4c3b112683@acm.org>
 <1e455c9f-4908-f476-f674-c0c920c17f9c@acm.org>
 <BY5PR04MB690045ED7665BF98A2EA7ED3E7BE0@BY5PR04MB6900.namprd04.prod.outlook.com>
 <b90e0030-c0fa-7e7e-ea17-137d49293f54@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 032336ca-9cf7-443c-b10e-08d7f623e4fa
x-ms-traffictypediagnostic: BY5PR04MB6961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6961421B710F8BAC2CCE8098E7BE0@BY5PR04MB6961.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUtfoDes0EY3M7FBe/sx/LDSdDQEsTWst88Zws00Oc00EhcTYWgJ3wdK0ux/T/l8lb4qB9Pup/qNkTcBkwMpFMilneJ6yAX2K6lyQsyLdlnp3AlaKcIeGNF5NGNtbyKEvrc8fAggI85Ma9wlz/YCh2RQcOmQGk3vHFjN0ScdW/wh1ZlxMbSPJs3E4wxBRqQxEMvWH6TgeyyrC0U96ByeJLMLEG+y3S3NBOJHrmj9dYE1D3MoehhcXjXuPBjRsIBf9LhyN/0+Pa+sTsTqh/+Tu46gzWIBv08X1ln6sBT+2rylwwsCsU3NAJQllMvhHCnKEn+ysf0Rsjp0yx3G0bU30lJ9bXbIbK8CxeyLXjToZfUiGAPfYyulSRNla+k0T35LqzL5+7DtCc6cr29Nyrj4Kjps/5ddE5muCTE7lS+iNiNcjseY82mOUk/E4/oonRfMB6XxZkDR4X0FBYkQGco0UQtuTg/qZ71bpcv5ZDgT3hGnzpVfPuySrUYtYbzxfAXqzHCZ+8IUQ3LYe2hUN6bKQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(33430700001)(26005)(55016002)(9686003)(2906002)(4326008)(54906003)(8936002)(316002)(6506007)(110136005)(53546011)(52536014)(8676002)(478600001)(7696005)(66476007)(86362001)(186003)(66556008)(66946007)(66446008)(71200400001)(5660300002)(76116006)(33440700001)(64756008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bsb8s1UIDW35wIUt1MANbvy7jBJz+qcEosu5KUommgVE2AfgqYNOcNTQb1mbily2Bo5tFtPq5CMVOvaWdsoecaFDEueMxtDOS7Y+P3/6dTR8tlfElpFHC4uL7YKGMCFrjQCX/kmhyNrPJxQAzZDniyol4o3pvWspnKI7Lutorb46GxFdosz0bBeO15EH+QruJX63HtHvYH70Lq8Gc52LgPn9PiYM5BtGbBuVqMvgVIs0AOkfTIN8vyTv0N+mkcXbMIax1EPCFx5Y7PwE68qkvU0JK+QlRTiXN28LU6wc47SGAcgmoaH93DaABCKVyJpDdskeRXoukd2Ay+/xZ0+j0riWbTUAUlu+KKFozvHwgoHdo0P8SSYAK99hYhH1HmUHWUZPhe0oF3/CdPDo12Zi5OeU1ERwlPm2e1T4+DJjq1p9ZzuJ7ZOBCdjpDHP/Nh/2+6ts1BOmGsvfph73tprSiKXLTmCjk/kFz5OQ5deBvALTcWNJ+gjeOQdcuv1AX+ej
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032336ca-9cf7-443c-b10e-08d7f623e4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 03:23:52.1191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9y53soyVYs5O8KRSbcPwPQbql/MkTlDW1T8JXBdwRSotfKK1EfnwXX/Sc3GMARbWkREPDnK3wNyl9plKNVM5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6961
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/12 11:43, Bart Van Assche wrote:=0A=
> On 2020-05-11 18:42, Damien Le Moal wrote:=0A=
>> The patch looks good to me. However, I have one concern regarding the=0A=
>> performance impact of this. When nullblk is used to benchmark the block =
IO stack=0A=
>> overhead, doing this zeroing unconditionally will likely significantly i=
mpact=0A=
>> measured performance. So may be this zeroing feature should be driven by=
 a=0A=
>> modprobe/configfs option ? Doing so, we can keep it off by default, pres=
erving=0A=
>> performance, and turn it on when needed as in Alexander use case.=0A=
>>=0A=
>> Thoughts ?=0A=
> =0A=
> Hi Damien,=0A=
> =0A=
> Does the current implementation of null_blk allow one process to access=
=0A=
> data that was generated by another process? If so, does that behavior=0A=
> count as a security bug?=0A=
=0A=
null_blk not changing in any way the buffer pages for reads may have=0A=
implications in this area. I am not sure, I would need to go back read thro=
ugh=0A=
the page cache read path to see. There is page zeroing going on at that lev=
el=0A=
(e.g. reading a file hole, reading after eof) but not sure if that data lea=
k=0A=
protection applies to nullblk or raw block device file accesses in general.=
=0A=
Likely not. Raw block device file accesses are normally reserved to root us=
er=0A=
only for a reason...=0A=
=0A=
> I am aware of the performance impact of the patch attached to my=0A=
> previous email. I have not made the zeroing behavior optional because=0A=
> I'm concerned about the security implications of doing that.=0A=
=0A=
Understood. But since null_blk is essentially a test tool, I wonder if secu=
rity=0A=
should be a concern. Personally, I definitely would privilege performance=
=0A=
aspects over security for null_blk, but I am not running it in a sensitive=
=0A=
environment either...=0A=
=0A=
I think it may be good to involve Jens and ask him about his thoughts on th=
e=0A=
subject.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
