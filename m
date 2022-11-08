Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7859AC433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 07:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiKHHrH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiKHHrG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 02:47:06 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C1C69
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 23:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667893625; x=1699429625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=pzvjaMasHpil4gdLyv3fWrtGbtpexTiRIfQ4oARC5ItXZadZLVoeY/F5
   xhjcDA/eb8wgrBbXSpsoSkpLDPcCbMx1seqBXj5q9iWgvPJ3DAM5FM+SD
   Zao2P9lWrNwhFBZZUOaK5eZ0OnwXEwwvK8ia+2CiRAqN7QNWX+8JPXrGg
   TSYLYCfbx8btzkLeTTGXy51IJ/T4GFtsuLg+V7co+dh536DRDCaFWfVIT
   wkYLzyaNdQ1AREMQatJg6rQHKbI+LH/tdjCT4aVnY+BPTE0gCEKkois5i
   Y0ZB2JC6kXrSrLhMTqACEFgZVIubPScYDQB/c50EUQWnHY9/+gJ1Yillu
   w==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="216076092"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 15:47:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNCP5aeUXVcrqocFxemp2n3y+20AIdN+EXzTX/4SI9yTfuAsY93a3zTq8lsq2l+HBkjQSjZIwPHdlNVLDEif0N/NBLjdW3e3dx8K2MW8n1IwkIqVQ5uftM+TNokXkCYrgFsEmHdpxmvn235AohmWoqlqMgsw2IcJeh8KQaAtZP/IUiC3tRSXs+Eat67IraDzMWvRZrL/63NwVGaila7+z63dsMfOnaqSPYP1bdZ5CjViWu3tm5/GDnFRLU0uFsIjpW1Y64s7qeIO4k9tiSpofnE/jpip1LULKxHL3OMM+1sNnHJyfFSBC+3qP+Rywpx6OIctxmlk/CMy7As7G/P7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=JvXjFY+eiEaIa81woZtEzRoZfMfJR6ky8wyDPQ9O9mwqoaGWvsGsYqFjfgKTaTzb8jmQmgKCVixsi4vJYxkWQZNnssTVQC17uFm+cTgrhvXdVATwmot7rqWQedMV8cojnMFFOCH4ECHq+q15P9gPFb1k5vV3bRf7lfK24gDcl+gwMx3bDVcW2t09VkE9cecFisj6owPLrnVpxCsbbVI62K18iC8zatuvB4IZlwVRjrU+wC4aPsabpi0YRbFVyw8DecOKXClestNvcEAZgv3bcP1dykgqT6uvEbXAn2S5xRP/Segl0Pcwu16W/jNucgGD5AhSM4JdEMzWhnoN/VLnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=mauOUAJuLsTyWCGGldnK4RWUm0eW7bbBgH7Zjgvxe9OGuf4lpoNZn54RX/KYAjS99lZDQej/AwmKEivb3Zxs38gvHGLMqnU+2iFLZ9arSGNiXz1MuIoxll+PXxsdLaJmber8B/3Nmv0JFjrHlBi5pfto1xIs7iybMPZ+JU6L0Vc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0277.namprd04.prod.outlook.com (2603:10b6:404:1a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 07:47:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 07:47:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Subject: Re: [PATCH v5 1/2] virtio-blk: use a helper to handle request queuing
 errors
Thread-Topic: [PATCH v5 1/2] virtio-blk: use a helper to handle request
 queuing errors
Thread-Index: AQHY8yejLTfGgqt/ikuprmGgkh2sl640pkIA
Date:   Tue, 8 Nov 2022 07:47:01 +0000
Message-ID: <6a4fa5e3-c071-dc15-eb43-59b9ffb21704@wdc.com>
References: <20221108040718.2785649-1-dmitry.fomichev@wdc.com>
 <20221108040718.2785649-2-dmitry.fomichev@wdc.com>
In-Reply-To: <20221108040718.2785649-2-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0277:EE_
x-ms-office365-filtering-correlation-id: 786db6ba-4b73-426e-fb81-08dac15d6c08
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LvFsdUq5iQ1wLBVCgir+XurbCMXUMCHKiBhduo2NITKo2SKGAP5kU1ZaQXajYKElVT6YVOthpE8sJ1uYy1t3vmqe5Uv9vE6fB/QV+AM3rhjnrMsHNLP4hSxEBGvXIEAFkC/tmAcZYtSInpkJ7qWHper7Pm6aqDpORA1R5NzKZTXgbG56WmMw2vtsAiXygSRFr3r9eR3p9Uu/GwJUuxp9+96QRYklOZH9JMSXTukbWdbj7Yl7EmRJ73d5Th2Fq/+EZcKkP+zZLGEBxXIBfVlYNvYUZExCbnSWlDJCvPVIVgoxrU1pnLhUkEmCR21PwBHW9sFjZ2JP2z00Tij15czwdG9vfo7XrmexarYHq+U/KsWTtxrFGbXHNHUNNrKG0qNfn875WKaCsjGZBNDKhd6Z6JA09vtn+Wl5vSafqVvhkTlbLBf/8/WYxapwJOFUlF29tVxEgvfCF4D6cSAbbJWhuDuQIDyCvP+LiHtTRGw6OpvDo0PQiaQk3pua/yqKVhipDyv5+NIXfS5/cmoKKjaU2DJHk/gsTlrWPL4/Rbu6FHV0tSzoARoUc18u9ccA7pWrDYiNFfJXHcGY6gYNqQCd3JAjKHlfKRm2CQfH4G0p8lR/+slC/+a/G6rtYVDoxqKfaJESS+VyLViOhwanXdy3za12CskMW+eNlof4Xf03V0B5x8EoPS2lMRO+ZW96Ave+ZtOimthnuAZUuIZbYPOyjBkegjGfwwN/TVxppKEnlzri3emdYgLmoOj7lj3Hb38LS+oi6wtdKOXqRiz5sgx9xoP0lIxVZwrHJ6vKIccsHdQSOjpVBYw/w7456qQqwiB2xAm7mj1pNXBTmN1BAE0ebw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(558084003)(110136005)(316002)(2616005)(4326008)(4270600006)(8936002)(5660300002)(41300700001)(91956017)(6506007)(66556008)(186003)(66946007)(36756003)(8676002)(64756008)(66476007)(76116006)(66446008)(122000001)(82960400001)(38070700005)(38100700002)(2906002)(19618925003)(6512007)(86362001)(31696002)(6486002)(31686004)(478600001)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alBPRjNLRUFSRkxpKzJrQVJhMGtoYXZHeW1MMUt1Z1pycU12T0NyRUhIOWhv?=
 =?utf-8?B?ZTZ6YmRFTjV4MmQzK250d3g0MjQzdlhsemtQWXlKTzNlWDdwU1pibXZpdDl3?=
 =?utf-8?B?bGdEMVpsdkVncnRZZzIyUG1GdWtFWUlLUU1mMDM3MUxzNllkU2xHalBjeXJ1?=
 =?utf-8?B?c0M1UGQzTnh6N25YbjVmbzVaYTVpb3E2RGtTaXA2MTVIRERBVVdWMk1DSG1F?=
 =?utf-8?B?NnQzbjFWRlJ6ZVNOd1ZIY21tNGwzTXU2Z2RkdHNTYkRKamtDaUU5WVo0ZVlQ?=
 =?utf-8?B?V0Z5YkJlcWJHbk1FZ0k1NSt2SGdaOXJSS1l6UUMrSm9hRTVabHFIV24wYVZG?=
 =?utf-8?B?Z2JkOGFtcFRZbFBtcFVhWkVZSkJTOTRXZk1rSzJIRG40UkJ6WEpPMEJlNzhW?=
 =?utf-8?B?cVpFQWhNS1BHbFdSbzhXNUljaFpMYWRIZ1lacmQyYUl4eUJybDRlNXZkdU1j?=
 =?utf-8?B?bGVXNjdIRXhUWTNuVHRuZEQxNW5IbzBZNUJVb3N4MXlMREMxMTlxUDVTNDNv?=
 =?utf-8?B?Yk4xYjNuVGlJZWp5U2pCMW9TRmEvd3lFanRPLzRFMXlxYlZGUzMxNmhVdWpZ?=
 =?utf-8?B?bjd5VFJoazBCQkd6Yy8xZHQ4R3pQdWxRa1YyVDQ3MmNDTFJaZ2gzNUVJSVFH?=
 =?utf-8?B?RFh6dXBPdzd0RGNEejVLNisxT3pLNWtJQmdmaVVrditOODJGdTVRL0FkbURi?=
 =?utf-8?B?NVgvUDNUd250SWxQWDgreE95Y3k0UGI5OTdwQ2FDNHhQQ2pnMWtEMjgzZTBN?=
 =?utf-8?B?UlphaUlGRkxzWDl5L1hlTUk0RHYrb2lldGpVRDJHdFVNMG9qU0RyRkNFUUhG?=
 =?utf-8?B?RDZQWFFwcDZ1OXhkZVltU25tUUlxSXo5SkZOVHNuVmw1OW9iOXR3ZElOZnN1?=
 =?utf-8?B?d3lHS2tkdjI2S0IrYjRGRTNZN00yRk1Fb1gyTDM4Kzl4b3oveUJzeWtPdldL?=
 =?utf-8?B?QjcvYUJoSmx2ZXNkSjYxTElpem43NVR3N2dBcWd0SmpuTzIxOXNMbXVEeFhG?=
 =?utf-8?B?RUR5dmwwQ21YNnFxUWc0L0M2R01zd3N6Slg0ck9pV3B4K0RzK1JTUE1xa0Ft?=
 =?utf-8?B?a0c4clpMYjgwMHE1SEJPRXZ5cy9RczJOcUxRMndEZ2pQbTJMMkpZYW8xTHdl?=
 =?utf-8?B?L3JlL3hRYVNiRmJrZUxJZWo3Wk15RzBSbDdKc3JmQnZxc0VxRVdLZ2p4Mit6?=
 =?utf-8?B?RUdyaGZjbHdQZ1h3aENBWmhHUlZQUitPS1IwUHdVTW9wdnVFb04zaHhmY2RR?=
 =?utf-8?B?MDZFOXV4ZkJSeWdkemFrQVA4VjNtaXRGT1VXL01IMXhVYTNGMmx1ejJ5aS9q?=
 =?utf-8?B?Y2JIcGR0TUp1eXppZTNPZUZPNVZXSnBmKzJiSUhUUTRGMHJoWWVrUzNvaG1S?=
 =?utf-8?B?VzdnMzdnNXVkcDNVY1MxVEsvdkFZWmVzNzd6YTZoaGZaNHZCRjEwTjBqWC83?=
 =?utf-8?B?WjBobEJXemRkY2pMci9QTEZhb1l3TWx5U1VJWVVuZm9jT1JyTlpackxPOWtH?=
 =?utf-8?B?MzlRc09NYmIvSmhFMXNvb0Q4RGhFY0RMRVVUL3BoTXF6Q3dFcFlLTmVHVHdC?=
 =?utf-8?B?OFJ3cElrR1QrQ012VWVqY1djSWhGQmN6eERvNGpGNUNWNTZrYVZka2hRdEh6?=
 =?utf-8?B?a1luMDh3SGxlTGNzRDF2UVNEZ2pRZWNxcTBqa2RjdUNpOHRXNFZZeVlaTlJ1?=
 =?utf-8?B?d3RFQXhMNTlxandleFJYd3k1M0w1UjZjanVwaWNoVW9oQkpoRUh5d0RTRkg3?=
 =?utf-8?B?Z1hjb2dLejhvbW9ucnBnU3VqNXBsaVBraGZzU0Y5YU93TkRzMWJFVE40RlBw?=
 =?utf-8?B?ZFFjV1pDZnp3VS9Edis2Y2pwZmlCNGxCd3UxbFYwSkVudFNvM1RIcTcvQlE0?=
 =?utf-8?B?SndoaTVSR3NjcUZtWXkrNzVmNUp5NHBtby9EREVVdVA2Y0cyeTBFUHZYYzRZ?=
 =?utf-8?B?aDN1RkVHZ0JzVlI4eURycExiMHlSN2p3TUFjeklKck0zS2ptc3BrSDFheVpE?=
 =?utf-8?B?MFdpVGk1VUFrcnQ0b2h5R3dRTGUrOEJUVXBRdTRmdEF4OVRWVnFCUHBkaDZj?=
 =?utf-8?B?R2IvMXpoTmRpNkhURFRWRGtGbThMem1BVkdLMVFoVktLWkRBRUJvSU5VSVdH?=
 =?utf-8?B?RlVRd1VIVi93RCtqUkIrUnRwdjQrdXl3QW9yT2IyMS9EVVpWbWFBditGL0xa?=
 =?utf-8?B?U2NpK3BLZTlpMVB1STFuOVVyMHdIUDZLcm81R2RMVXpVUEQ4Ty9RaHFrOW52?=
 =?utf-8?B?TGpSZmhLZkczVlJKU3N2Q0dUUkhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11269D8BC048694CA9DA7C1F87B9E361@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786db6ba-4b73-426e-fb81-08dac15d6c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 07:47:01.4368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSnoDI27Vnbnb/V1YP0dq1SwqAZhqKAdA1Hs2rzOvA7SD6LaWud3ZtBrImwsndaIEQ4IdtXWXq9e+2zo/OCMz4XALmq5Eru/LnOsA6NmzNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0277
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
