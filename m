Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991B7C04A95
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 06:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiI2GgA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 02:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiI2Gf6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 02:35:58 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B2EEB4A
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 23:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664433356; x=1695969356;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=N8hi4whCeCzdBwpfmp+oX+v3jDoqe+L78wN+qT0KUe4J0OA1DYPcivic
   iSp2wTcbmnc8P0iabXRFQb9dzVZpIynziHlD7OW2pacoTGBiHfe05ZwJS
   LZ8f6cY3C0mChK0LXsw1sWt0uewX6uOfRWBL86gj14wa1hEA7ejMG17kT
   JehiJx0yJepyImGeDGxSio+fYM8EguYSuqF/9gttPdDLM/aKZGPO99B77
   fksixy0ayBm6SuQTOvmCALIkU+4FavG/WDtmenbXeRomAyse8fDHIOn9G
   vH5gWhHr8Z7Y0x9yO+xIlvdD+CcLJ39CXQg83QspqT16OnYNqjRWqgCkm
   A==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654531200"; 
   d="scan'208";a="217731068"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 14:35:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/CMF6LNni6MaVmzx5LUc+gLsIvVpdga22UAeBtodTzI/1XV0R4h1+h/7alDG+sQxS3dKSm9/7pYVRDyjwTVizQP22naXPNx9VdSsLFUHAdlCP8hZWEx2ujmTB/ixsMfwMatk0SUs3t1PVgB+Z0bffg7tTPV2Jt6XCw/iq35s6I5Yiphjpmt0agLXFIv2C2cLdMufhGNr+HKsgpAlA07xmBq2gZ34WzDY4sLlLcdD4SDJa9DbbvOCLzpwCUrxThKwsEaxc1Lp1eATc4Pw0v1r2vRVlNn4IK9RFsR36DnWXW4y+oKBkwX9pDrWivPiGXZEqyUToc0K8x1q5thVX9OlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HctSeMlqRHM13n+/ij6PcHCSgCqLD3vzXhLikVTQOTn6q5bLQlxpnFzcNm5hOilT1xKXGyBQUcsGPtfsBszB12n1Dh2oiWMt+Kt3F4w3LgByCpg9avnmGCmrNZil2V2qfNpuk0tUXtcWBSSM4CT9cBERPm31GMqz20iz5naQyO6oQp+bCJY9YuYrghHyzhPGTPertRl3cNY7MbJdRhpVUpEB4Jv0TbbMh+VeK3kuiubSSPhwHLzxGReUBvXylsGRCFCRQZxXnEI4lVYzfFlESNNxuQuTa/LCzFZhIqsSKD6XhpPzZ6hzV5xo5pYejUI9InuJt0pZlm93RZ8aWBauBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=x099LCcE9yvep5YAPqMX81gRqSULmRhfq8HWM+dxgbsCS4+3zsmD2MrSUMu/CXlvKdmneR0xktWQ2MOSfLzYQc+95hg7m7XZwf18e4oZxKTNLhD3YCxQIyWfMAcYocmOEcPiPcYvOscY5OxsQSODcYw8Jtzje6khEFHEH3dHcXU=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BYAPR04MB5285.namprd04.prod.outlook.com (2603:10b6:a03:c9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Thu, 29 Sep
 2022 06:35:53 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::6107:ce8b:9a1c:c69b]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::6107:ce8b:9a1c:c69b%2]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 06:35:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
Thread-Topic: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
Thread-Index: AQHY05O9bQ8JeyEfsku/Ge3GMaNhWg==
Date:   Thu, 29 Sep 2022 06:35:52 +0000
Message-ID: <SA0PR04MB74184CE8F5AAD6055A040D739B579@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <20220928234008.30302-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BYAPR04MB5285:EE_
x-ms-office365-filtering-correlation-id: e15a4b3e-9a88-4e66-6a86-08daa1e4db00
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H1bXYNLzLanODThcvzayYP9T0DyU+pQu5EOswmbZ9iB/8GzphHPY0N1s9vCMNhcuJai1jfAUM4md1mrCNW2fIEl3kL0ilAU+Cm3OVtBwWlrUdFDcv6dVtKC8I0Z4Z2Jo91HGx+xQqDbRDIfrwg4Q/Ci+ZkqsrazWsuil/RywZPzQdm5nnjH5kEcis53HaOIk4L4OwX+xfg2rAsJjjLmrj7vfbfoNSuRodtK+gBKl/3nHfynhSf92oOVTRH94oLIEcjea0CPw7nR10JiXjbMFRVPMXv7ROsBZwGGewER9obDLgV4h7C/DhIGZfGxlxhw2jmuwdbdX7jpCy5/65ZVdH/yY/2KYsmM/EoduVN9ldaGdj2rcxmRSFCV2/+I84l4Z8XVCR2QFurAxO6JMaacYncszJsdmN46Lc34B6MBqhOcRJN2/3wBCAdfperh9GptKr2sVC8Pui8Dw4GAxequnX9lVXOS6OuWJy2VUYo0V6cB4VGaT1alNcAiyk2rW6OMD4DHeErCRjHKPsvgCG/qqviejPmWGdY3VRkGFhwHhkKodqY+p8Afxb7PCmkXsgpxQH92dHrxRBZQ9S8uNaTsN0wOxWdPyIoEoAep03rmrh43+TZl0sfptAjFK0hQler4tlRFAEpQqOR2oL5ASfzPhzuNO2H3HTVvX9ULL5IGXejJC7F6L3tQEzZFQDV4Cmx7HW8hWAxO4xWxl4JB2d2pZ8mp0AfvnBlnkWrFH6xQGggzplYc0Zxw6ZPKFyMF6MHz1Y5FwXGE+sfXi1bpwcsqumg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(7696005)(9686003)(6506007)(2906002)(4270600006)(558084003)(71200400001)(33656002)(186003)(8936002)(52536014)(38100700002)(5660300002)(19618925003)(86362001)(478600001)(4326008)(316002)(41300700001)(38070700005)(122000001)(8676002)(110136005)(82960400001)(76116006)(66946007)(66556008)(66476007)(66446008)(55016003)(91956017)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cVj8W9hbzzspmpxMLFUE87Ug9WxsBcSlg50OCFZ9dX0On2d8f8GI5XtsHxF9?=
 =?us-ascii?Q?YgFBeZwiJZQRepEVMhPnvNa1pZOdfS1p1XfYzaQG4C9KqqScqP2NZramhW2p?=
 =?us-ascii?Q?DogLT5nJ5AiHzTCUhqy2jueMGfopInirBvosDsciZNmBAlqdoCipdknelnAT?=
 =?us-ascii?Q?k9Pbjp6djxpzIWlGZ3PY5LTji7ka7n1CnW9+9FCwpgh4pjTF+F3+jBAWijuJ?=
 =?us-ascii?Q?VXDi0Kx8aHFVYeRq0VZjRRJ3u6x30j0FhkpIKs1a+6gKAEVC/W0pO5yzXyFx?=
 =?us-ascii?Q?deowBG7UZPiw2OYoCwdpQdieJZE6d8K/iwn21eS3eYatQgd1bn8ZDr0QMxai?=
 =?us-ascii?Q?EzdFPYneAVgDZigjIj11mr0pUGcYptoEa47jIOH8sifWnJCRBwoa/EjADXTe?=
 =?us-ascii?Q?pqJPZR9/HNkXTaBX53GA5cXEnsxZ+g7KuVdNlLClFOLVKa2OfaG2sN5nvIr0?=
 =?us-ascii?Q?5pFNW935Ds15LJxaUlQeGWyPnv/JtJAE9N4L3oNgCM6vsnkirn7mblT4J+Ji?=
 =?us-ascii?Q?a9UooEYAYp6+eTteTr4Qog2eKahFreyg4uq4mGbBm9egTRsHXB08K4A5MKvb?=
 =?us-ascii?Q?rEGOgoitLyd9N6+telZdB4boB7WlN1u0nJLWn24drEd4Vi1fz1MtwLiLtb7z?=
 =?us-ascii?Q?Ljy6miNcKKHUXBxO0ZWA0TUiQ1p6uwu7HQhohDXZbWeKGIIUfKk2Ujj1HeDl?=
 =?us-ascii?Q?gRnVg/zLu4hxWSXG4WXwoQZQbQL1vo/hEMihPgDQQwUTOjis9mjxpYEJ4Cyx?=
 =?us-ascii?Q?ngA6mNO/c9QDU0areGf7g2Qbi/LC8Cn5sagfYJDjrKyR2vcRIUl7uSpaeORN?=
 =?us-ascii?Q?lkuUAWX03/VNHO19IGo3zqCAVeKgnLm/oXf1LUIwiowmabg6W9cAZ9qP+jct?=
 =?us-ascii?Q?Y4DcdiCzJi/pLEMI2HCMK8LlKDV3eoryy7SyRlglo5CpSC0HK8P5YMV9VuYJ?=
 =?us-ascii?Q?geZKzUes2xUphQLSEyuZS7aJETefa9yaP+/CVO9jhUh9/VlBR9MTp9+ML+dK?=
 =?us-ascii?Q?ZJ0Cqe1VHo6ze1CCM4oe/wwBFP4m8l6nn4F0qtHux2DcI+cFRNnoQnWsGcaE?=
 =?us-ascii?Q?I3gOQOmktPFjmUDmdY3Oxuhf3wUzLzN9Tk/VtogULHguaAaVMxzEQ2HMarxQ?=
 =?us-ascii?Q?WOvCIq6NupxfkmTvn4QFC6OnRWHdUc7ba0U3HA4CFJkTB/IeRSUA86rk4lKV?=
 =?us-ascii?Q?WlKktGUupUaz/P6Y6n+6PAeaZeHmXDZFEM472UIoliFPUi6siCl2eW3j/3qN?=
 =?us-ascii?Q?8fdt1LmHqKbeFBgeCIQsDzZVC190BkVf5bQVkq0M8pvIN3ig8dbzDZ91QTCL?=
 =?us-ascii?Q?kwtV30AJszztkHtBR/YFPYa475382TncwvHv4/ng25dOWRl4+xS1ZU2iwlmc?=
 =?us-ascii?Q?YamK7QV6Jvbzy1ng7cz5Zoi8vqGPjPc3ERCDiHKj1cLPuJTR10p5FEVO5VSQ?=
 =?us-ascii?Q?Qxd8+BWoMzzjwY5/NME6lGRRdEUayO27SRBRaWRQ7L5y/W9s5FBkwQNWaCVC?=
 =?us-ascii?Q?FpBY6j9+hHXeNCTfN/GIa+sjgea/+ipKiJ2I8l/wbbUbpxfxUNz2tXFV3wrM?=
 =?us-ascii?Q?mwZGPkS6onpB3ypiDQFavkgaJqEDKySEufxUNkRs6dwxSrzxBfSoUFlZzSd0?=
 =?us-ascii?Q?X26JMJbYT424gNxQN5dL7I56cZ5dg0/apJanj5PrUh7r+wVkCcAea/r8DvvX?=
 =?us-ascii?Q?htD60xPlG7xaNjBhHsK02yygVBo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15a4b3e-9a88-4e66-6a86-08daa1e4db00
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 06:35:52.5043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +B4Pqq616v48my444RYWZYzsQPOZqYMP9FRMXNoVxpwzvoxXL78idWJAGXC/9nwtFzLvfTQZNeZOrRsZjnGcs9lnNcpzYNnLfMZSmol+OBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5285
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
