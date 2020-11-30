Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BE1C71156
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 00:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83BD2076C
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 00:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c1rYGIIe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S7JZszY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgK3AWq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 19:22:46 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24946 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgK3AWp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 19:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606695765; x=1638231765;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PLn8cC2oY3zdN1O43nlgqFlZ0cIfMTTHn28Aa5405DE=;
  b=c1rYGIIe66O/a33h5HIg2cRoIGKDulC91KBFf/v7YJWPvgiDCOfvYSFq
   f1j1lKeoXYvyC0p+GTSOBTB/ATrte5ykPw0XXlCKLVVCNUEveGhgfb/Ys
   KHqdjiYajQn1f1QlPnHjrukfKCbWt7wnxtnXhDYsMHWGxJA1kJYKebnSU
   JXCYHmd+JdeUTqOS5w6mXl5YMYWSyMBT5fEWut9IdDMAnbhuKE4QAIimn
   AAju5oGUB48sByBdhGICXra+LN5Dgva3fAnnxRtzKQMYarBDt63zEJxoW
   xXUcEZxdlebB87UI6fWHaeHXSziAIw3QcTQafr5rhUtCI8dAbwb1HX8/e
   Q==;
IronPort-SDR: 8G2VUwK8lS3ZHvhIUILUi1mBNpMjlXqlYDfVtGXeIeZpBz9XfEpE4UdNrb+OQf7s/p7s1Un/V/
 O1zAtmWIxoStg5FDv6VboVlUC6cdh3THcQNRPUmyvCni0iu8J9Ri4l1A5UekUBS241PC/juf3E
 ZoIsZIeX8fBqcL2cXAqFc1Dyqs4gYdD9IGpWBOiJLJY7vMErRMQIr8K0yB4OmdfaxPJB3U4CuX
 UN7rUhXp+XsezWOXMT65t/QFAlJavkENwOdOL70LjP+Q6ulAek9q6gNPxzQaRl8XWPuKuXy5PW
 BEc=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="158231950"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 08:21:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZBM8D9Eo1mIArGDwfl92ddABU0Vo49a0vMtZ4PsOdGCjkoMcxlQdI97bSkUUvNUDVWWfjxABph3FQ9qdihA4VGvs9+oovZDKbuhP4zKYNsK7qLkehkKvTpHpnkDxbiyZX170ZwcBL+vXZSvsq/a36akuS1GTBYGCY25Ih0WHdkDGWFzoog/74mne7kcTbNjLVm/Hs6Ga31WRyMkXRNj/MAo3WScq9AKGWyZQX2cIyPwqd8TCDuo6bY+pwq+1i5IYahIUBBTLnbYcpWyKyWo8z9IBpUxSf8jtPO2Og4Xo2wtgZF1OpppPuEsWw4S8+yoEZvMVZtsto5NawqC317pnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/VayGhf1Je1N+usPYkq81Pr3b6VilwpjphRuucp4n4=;
 b=Egtr66IMucXCKJbTQ7GOkeUHHmzIrZ62pfp0eOAmZ+vRcXIqFopuJodyBlMLZTTcI28Emi0X3zPGuQYy8j4dq/P+xVNG9+jBxSnRl82VyJMDA5kORmrJzUwzsT6S/e6P1j1YrsdfYKlEToIE35K9mWLyQ+E3wLrEd48k5j6sCvywHskJD7U8bg08ybcQHAbE5N2cgelMGnkjIXXICL56X/4NV76UwUFsDIPKPMn/LohQqqRxIH1udZaA3M4c2GfyaKIO/KTQ0/9zYYTEI51s0s/BTpObfcb665ZhOg26aJPBW1cJLU1hkvJ+UaWT1pJE9TmGcLN8GL5nLTboHntVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/VayGhf1Je1N+usPYkq81Pr3b6VilwpjphRuucp4n4=;
 b=S7JZszY9N01faYLkVB4fmEAqADf4U3xdvzicPpkbkv7Sl/zFvuj7u1zzh0BVycUE6PxlfPoxpf1hRo0onG/WsDCjNsueUWUf/gQB2bfZoRjZsbyG4U2kZiO78rgghHEi6Tp905VbNyPpeJc/xq/YI99sDxgB17wZMMjF1hLbdMI=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7094.namprd04.prod.outlook.com (2603:10b6:610:98::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Mon, 30 Nov
 2020 00:21:38 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Mon, 30 Nov 2020
 00:21:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Thread-Topic: [PATCH 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Thread-Index: AQHWw53EyVrFDensPEahWhqZAwj70w==
Date:   Mon, 30 Nov 2020 00:21:38 +0000
Message-ID: <CH2PR04MB6522CA91B2A8AFE2BA376BA7E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-7-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522CAB48E0507730407D012E7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB4965E885FFD93A530AF315B886F70@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3811:272:f33b:9d56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd8b5000-268d-4e39-2640-08d894c5e766
x-ms-traffictypediagnostic: CH2PR04MB7094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB70945C3E56BB3DC54EB0B97EE7F50@CH2PR04MB7094.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WNnKpkAjpVnZXomvsV+KpybDPSWOzph07yycPlxawLWFhY7N+BZIbZU/5Xncn+pttzoxd2XRJBW/23RqvTCOIRGoTLTdybuZZFatwcxoc8RwHM1qhRiRgX5sDG2Qk2JeJyIoQd3druWdNgwznyCyvfTdHK2YHv0CvLhLRNe+3G5UTAKC3pxWXgLR2ZjSe53CFoUqHHFIofjfKJG7X6lTGNsP0DuRAyvGfu+PKJN4B+sWKP5qrV4rg24V6yhRBdefH2TZr14DHWeuICX3jXaba8c1Av7AkHAjLb1aghr1YBtdoLxDlupf6ABoo7Ez2wjm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(4326008)(71200400001)(2906002)(316002)(52536014)(8936002)(83380400001)(8676002)(91956017)(66556008)(33656002)(66946007)(66476007)(110136005)(54906003)(64756008)(76116006)(7696005)(55016002)(53546011)(186003)(6506007)(9686003)(66446008)(478600001)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xlWmKLfeALHzACm7Un6TMoa/mrDqeAsmPceHMAisMFefyTSxX/PwDT8Ur/0K?=
 =?us-ascii?Q?S2CrLLO07bIyspbPY+DtKp/lMbjkpnOYXJxB0g8SpLZ7k1uj07wpvNRrbEcl?=
 =?us-ascii?Q?nshk3pudfgBDWPxNM5iLDZ2goTl0cUMB6cn0pOleHDjAMuaElvuOOh8c0PRf?=
 =?us-ascii?Q?+vfwyzpChnfsvpCCwJzNAA0Wgnpjo7RsBgpJ46ioT5SKbWlNiNm9JBmh1bAm?=
 =?us-ascii?Q?U3b1HE8DM9np2SwUOpZwcQQbHb9p3MUCkG00S3MtLM5/aIHykd6cdXOvbhov?=
 =?us-ascii?Q?Zd066Ri+ip697G6KMAOEdRR7XQOSLSuZu2UvEjJv+Wz9xv7jqXU3pLErjV5K?=
 =?us-ascii?Q?Aabr8VMqySj8JRr+ZXpiRREw4675lqrCtRJ009rqjkOggqRYymOsA7nyIlci?=
 =?us-ascii?Q?/ywFMYZ9rUrss5MIa1U9FhuFEwt2N+akYzD/Ttc5epTTLD2nDzUSdSe6ndjK?=
 =?us-ascii?Q?4P5499f9wYHUEvj4XjnNLx97zrnbHr2muyx8pwbgAeF7XmphF6az5aRcCMTt?=
 =?us-ascii?Q?LdtStzxNYQ8EL0qroMSkfqmOEE7c1332yBKn53rozTPgHYTK0ie37+KnQrWq?=
 =?us-ascii?Q?Cu+pyuSUUl5zxPdXxBL+ic9whM4/9HWHAdv21lRrH5+cclYpQepFN7ZpoJy6?=
 =?us-ascii?Q?VNN3zdgjNtk/qHWcPeusxlO11ToDtYYVzJ3QpgxnP9/QWcgQKpuwgwwwLRwe?=
 =?us-ascii?Q?eJfXhajfk2AA1vX19Cb8LONHyyoRKdDXTZhuLt1g81UvKRXLIc+4gFz6zSVJ?=
 =?us-ascii?Q?fm4LI6jwAsvU+8qO8qDO9ujRp8qvhdnY6Xoa3p/QsFpZMgzYhil495klQVRT?=
 =?us-ascii?Q?mI9ChJKxIqHEFBLRCibqGPHNhnqvOeSmTzSnmdbaNSUBYhGfJ41+HOBG9dlR?=
 =?us-ascii?Q?jNDhq5THxEs+Nw0SJ4wZwvNyoR8NaShTlc25BLaGlF2NCInxi3+x3IVVzvQG?=
 =?us-ascii?Q?JhuMbQ3SvAmp/CRTgPRCDVKaDtw8SH3bj7504Lw9RrXPypRSffstVfixi66m?=
 =?us-ascii?Q?aTwqMnKg3liZWVmhrcApET8/bszg91VAWGG6xjpqdBcYvWkgpb8pSIiZEs80?=
 =?us-ascii?Q?DraKX1Er?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8b5000-268d-4e39-2640-08d894c5e766
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 00:21:38.4166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eF+wu5DmrPj0kgprYw/dFeDtAHhSlcugZCrTAI9Y4CXdMYCgU2AuNNEkDgh0CLEH1nn2v7rX1hfyQl9/yg+0eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7094
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/28 9:13, Chaitanya Kulkarni wrote:=0A=
> On 11/26/20 00:40, Damien Le Moal wrote:=0A=
>>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admi=
n-cmd.c=0A=
>>> index e7d2b96cda6b..cd368cbe3855 100644=0A=
>>> --- a/drivers/nvme/target/admin-cmd.c=0A=
>>> +++ b/drivers/nvme/target/admin-cmd.c=0A=
>>> @@ -648,6 +648,10 @@ static void nvmet_execute_identify(struct nvmet_re=
q *req)=0A=
>>>  	switch (req->cmd->identify.cns) {=0A=
>>>  	case NVME_ID_CNS_NS:=0A=
>>>  		return nvmet_execute_identify_ns(req);=0A=
>>> +	case NVME_ID_CNS_CS_NS:=0A=
>>> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)=0A=
>>> +			return nvmet_execute_identify_cns_cs_ns(req);=0A=
>>> +		break;=0A=
>>>  	case NVME_ID_CNS_CTRL:=0A=
>>>  		return nvmet_execute_identify_ctrl(req);=0A=
>>>  	case NVME_ID_CNS_CS_CTRL:=0A=
>>>=0A=
>> Same patch as patch 5 ? Bug ?=0A=
> =0A=
> Yes, but right now there are no ns-type than ZNS that we support.=0A=
> Can you please explain I think I didn't understand what bug you are=0A=
> referring to.=0A=
=0A=
Patch 5 and 6 in the series you posted look identical to me. It looks like =
the=0A=
same patch was sent twice with a different number. Unless I missed some sub=
tle=0A=
difference between them ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
