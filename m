Return-Path: <SRS0=E+wN=EK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2871C2D0A3
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 21:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C9020825
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 21:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k0howDDd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Jnukxk9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbgKDVD6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:03:58 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46473 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgKDVD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Nov 2020 16:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604523837; x=1636059837;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=szs3B0fQxDlVZHuiRSPuJe9haSRGot8v964mrpPdi3Q=;
  b=k0howDDdpV/6jwJ8VZnNWWmIp57kmW+pJ8l5pDNc8XhBVT4BwlUgcUlI
   zNfG8pKSUqaVZB6xGOH3EBpOPD9+uAg/mPtkD5TfN9x8wnFFAlvNnceq9
   tY0XnGqyv1RkxmGueA6goaqvsvm8ENnQ668lpio0+AVb9D7lxCpdcWnYY
   FWk8oj8L2mPnPqe7R6y/vgrIRlrgWGnAmnr2Fb4+EzQwI7Pp7t+wqOq5l
   B08atFPjnYNFofrtIY9J0Kitrpb1KAuHzW2VKwWBvbugxPU6dhjvf60Cz
   dS26kwuItfcJtEc+cS2rSYR5qHTN1E0WhXRx6hqn8xcgt/amgWIHeM/7k
   w==;
IronPort-SDR: eqAtDctKpjfNXqGl80A39w5jav9CrC6fbW2qfSOIyymo8qaXZ3R+laHfqzV8FfUQ+WFoBZlOS4
 TSVL5H+qfIjfWNR3BLNYi18T20D6ZueUTvM6zpurXqOC3gsD4s2cSH+ZTBlq0BA3k2WLYiz42g
 IzAUReK2/zVi2fHCSs48gIuzrph1j/+7KL9YqMZuU5HYwMuGk50o3Aq1XP6PTPUHwQrBCgdMi7
 pPZD2ykjGQkc9z0p0h3WYTvCmQyOUjK2zMa2f0m/az38S1S1/J+nYOpv+Mo2ok2k0OhvSx1yIN
 lOQ=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; 
   d="scan'208";a="156309341"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 05:03:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT/GcOaO7JDArIe6HCVdf12uvMj/qKuHWGlSkil+wAf66ERb3LxM3odtxwp7oQpXROMpjXo7euR/+pBSK/Xx8QnkOO6Q+Sx4a0R4wBx2DqtYwOBnKAIFQr1MwSI/aL7AjL8B3QFgqnKCYL4zW48yJjaKY72dT72GOY2vpyzexSNFLds43JXryplPUgrbbvdEWTqFTXF6XAhDqIRhywgBArG12JozPwsS7i07WS825Ks0YDCL+1DIBCRgyYGxNOhsmVcBlcTVkfEqV2qMWV/xJJ30rWQm8xjcd/vcRR+SA7L0Mf+yieMAt/RqeIH/eGNOlFFIsH5dP/TBLyYj1HbNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KsOHjllHEsJQXZauW64KEsQFjyM2mvB+G2kMrElh60=;
 b=ObJ3nAJlgvxWy7WcVXWz0xEV4Byd4qWhg3OEyMAebhDWvNzsRrlIaO+44tBHHgPKGgCRIDpB0+sYh00EFuC7RFTZcSAoPqvpppSOdgsk1TND1Xnxpi9ASRJqFBv09ag8si5jyEyrJejt5QfZ2B87T6uIwIN/OKXvaAtpRYu7puGLbsQ3ahhelMZ8XucIuPAKn15gBNFjorIlO9D2XAf+bbaeksTlo9p5O/VGHHVLmKxLkipr2KLhOA9aaIoKaJYxHNzyTat/JDhZM8OV9cq1yc2p5VDBwGHfZPMrZfQAfvJebtlw3dWX7ij9uswglJO0k6qut8s5oyidguD0MRwImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KsOHjllHEsJQXZauW64KEsQFjyM2mvB+G2kMrElh60=;
 b=Jnukxk9gCscmTZqXcpCyvdfL8yG/zAdQKUCyHTBSQDrwi7r5vKVVtgkcyDbphRBMQLD4KpES/bOZxbrFugqYHSVwpv4YNJWmv43olVw9x4oeS5eg9hImarkCXQV+cxZYMLQoJl3NLRSIIHCES5xgS7K/iB736XxWh+VHy2owYag=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7423.namprd04.prod.outlook.com (2603:10b6:a03:29c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 21:03:54 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 21:03:54 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH V3 2/6] nvme-core: split nvme_alloc_request()
Thread-Topic: [PATCH V3 2/6] nvme-core: split nvme_alloc_request()
Thread-Index: AQHWqA8VaYaH9u2hX0ax0hNP3CFlqQ==
Date:   Wed, 4 Nov 2020 21:03:54 +0000
Message-ID: <BYAPR04MB49652A52CA9D130C4D2ECE8986EF0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
 <20201022010234.8304-3-chaitanya.kulkarni@wdc.com>
 <20201103182444.GA23300@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 645b1cad-27b0-478b-e0c5-08d8810523b2
x-ms-traffictypediagnostic: SJ0PR04MB7423:
x-microsoft-antispam-prvs: <SJ0PR04MB74231C3D2FC76BD4B6915E5286EF0@SJ0PR04MB7423.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i9b6ep+kKZBgEXZmsmg3tVw45ckjUQeUZg/zctyLT32duQboRnN3NrwESeUMM0+i6SOLO0Kf3I75DrbRtY0rl/yenRU6YyEdeHqYAnpenXNG5rABpdwjc8Zdy3e3PxiYExI5otZ5NrYdGCHfZ+hgka7WMNljeEQQd9eHJ81EiCO2omxAKa7d4xNYjj3fKG6Ytj4E1CC24Sa3pMIp5aJrpp4OCHf97K6Niw8v8SNY3QIInFuS0SVZLc9yeJopAW65fQH6/Qmsozz1x3c2C3218+S/NN1FlhiSdArFxMUbHGMfrIdlWYjHmjGE7uRW9e7ZOfC+RfIr4Vs1Exrsv8qAGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(66446008)(66476007)(66556008)(64756008)(86362001)(2906002)(478600001)(76116006)(52536014)(316002)(66946007)(33656002)(54906003)(9686003)(55016002)(6506007)(186003)(6916009)(83380400001)(5660300002)(53546011)(26005)(7696005)(4326008)(8676002)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xr+ibcnmXc6jdkxrYKkN/4iCRXgfQrvHmHflErOLMCjb8ec95YbhKLCh+idqTVukXM00a/elkAiMXRkPrsO+Thk/7quEfrRyVugJfxa+bNU3t8Q5MQzPkTw0lI1XWd4OCT/Rb6FTqU2fHCzNj0LxybVEDSwRQsKJNQpu9O5dRq/PMHUTOyn8QtnuJScWjm5BsLzS6uWsBqtZ7mVIRGF9/lyK2P4n/LxDv3vyuL8fG6p4pLXgtgWq9mm6aM/hHoSUkkVKgmoFJqCq2DIN+9RhoZVKHelz/r0trufJ8AJCdJoEyTR8Ar+q6XO3divtP+K/6nTUFF0u5guAPvDKh1TAo8MnHiqYMGMcOpr9tuKN4tXK+3tS9pSf30DsUHELd8/KpYM3qz07s++tf5Ee++A2eguuUNqtffYR+6XpO1Nz7UU49+n1KSNmmrQ8VbrmjTp9DivtZjE3l9SU7s9YQZNM9sM1C5fUuXp+sZkULRuWpH9g8fMTGjQHPhAiSfJfwjyQhLZErvb6WV72FdFofyyUuHrQZq6DYxmyIH5CFpPsxxQCEFUYvh7tx9zFXHw/JsB7gJTszq/y1TG3gC70p9NNtDyyydLvoDJiIxDGPQXczu08TuPvYKc0FWTjbkZIQRFn948RV6dC6IR3FOjs113yxg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645b1cad-27b0-478b-e0c5-08d8810523b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 21:03:54.5321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pct70/ywVSo1EpiaFX6Mtzk4K1yAqcqKhvZM1TVc5vM9ZgH/unCI6cG7JD6SO/EZX3k+YfTDCGVJumrJGs4G8Y6G/Nyw3Bo28CU5mkoLHdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7423
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/3/20 10:24, Christoph Hellwig wrote:=0A=
> On Wed, Oct 21, 2020 at 06:02:30PM -0700, Chaitanya Kulkarni wrote:=0A=
>> +static inline unsigned int nvme_req_op(struct nvme_command *cmd)=0A=
>> +{=0A=
>> +	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;=0A=
>> +}=0A=
> Why is this added here while nvme_init_req_from_cmd is added in a prep=0A=
> patch?  I'm actually fine either way, but doing it differnetly for the=0A=
> different helpers is a little inconsistent.=0A=
=0A=
I'll move this into the first prep patch.=0A=
=0A=
>> +=0A=
>> +struct request *nvme_alloc_request_qid_any(struct request_queue *q,=0A=
>> +		struct nvme_command *cmd, blk_mq_req_flags_t flags)=0A=
> I'd call this just nvme_alloc_request to keep the short name for the=0A=
> normal use case.=0A=
Okay.=0A=
>=0A=
>> +	struct request *req;=0A=
>> +=0A=
>> +	req =3D blk_mq_alloc_request(q, nvme_req_op(cmd), flags);=0A=
>> +	if (unlikely(IS_ERR(req)))=0A=
>> +		return req;=0A=
>> +=0A=
>> +	nvme_init_req_from_cmd(req, cmd);=0A=
>> +	return req;=0A=
> Could be simplified to:=0A=
>=0A=
> 	req =3D blk_mq_alloc_request(q, nvme_req_op(cmd), flags);=0A=
> 	if (!IS_ERR(req))=0A=
> 		nvme_init_req_from_cmd(req, cmd);=0A=
> 	return req;=0A=
>=0A=
> Note that IS_ERR already contains an embedded unlikely().=0A=
Sure.=0A=
>> +static struct request *nvme_alloc_request_qid(struct request_queue *q,=
=0A=
>>  		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)=0A=
>>  {=0A=
>>  	struct request *req;=0A=
>>  =0A=
>> +	req =3D blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,=0A=
>> +			qid ? qid - 1 : 0);=0A=
>>  	if (IS_ERR(req))=0A=
>>  		return req;=0A=
>>  =0A=
>>  	nvme_init_req_from_cmd(req, cmd);=0A=
>>  	return req;=0A=
> Same here.=0A=
Will do.=0A=
>>  }=0A=
>> -EXPORT_SYMBOL_GPL(nvme_alloc_request);=0A=
> I think nvme_alloc_request_qid needs to be exported as well.=0A=
>=0A=
> FYI, this also doesn't apply to the current nvme-5.10 tree any more.=0A=
>=0A=
Since it conflicts with the timeout series will rebase and resend once=0A=
we get=0A=
=0A=
the timeout series in, otherwise it makes reviews confusing and stale at=0A=
times.=0A=
=0A=
