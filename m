Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0889FC4360F
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 07:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1874222B6
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 07:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T9b5++ra";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hmEPrat7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437251AbfBNH0h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:26:37 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63305 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391612AbfBNH0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 02:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550129219; x=1581665219;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1aE1En+hJObDCJrzWzaIsSRZ1YWSOD0gYiP1eGmSyXs=;
  b=T9b5++raGR3TRlgc0tycJFl3mGLerslDS7d8/pdn9fSWHfTVX8wToUoR
   LMhMFFd03eWvetsY9+E5WmwgSDjKIoUFQYF0Q+Z4YCfiRSAtKQUIFPbF4
   pY2LA/B1f4N8PCqlyxe78WxDHeFUSA+WhASOxMs4J4cfncwVZzDPUfy0q
   td0s7DF6OR/xH1Oi+qv7/aBxuWOS3g6sSIfXhprRybJw/7ydYbCo3fpSY
   FTLwn/zG1SdPv0riIrPqWKIVGUTktiteQboPNatQXZ2hA4AcVHBIwkb3i
   /AHhXNIivlHN/3xBfDydoj83Baql1sQ4uZuvFy8CdgyaCfvsJirDpqMnR
   w==;
X-IronPort-AV: E=Sophos;i="5.58,367,1544457600"; 
   d="scan'208";a="199456483"
Received: from mail-by2nam03lp2053.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.53])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2019 15:26:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD53XgJqALEjh4nMfRMcLUxSos0jaXCaNNJJcw2McnU=;
 b=hmEPrat749eFDPzewWbCqahgBOpOXb1OmJbhNQmL+lgWxhxFPcHFjL0hyEJOoc2o1lcbX9Nkg5023quHtFbWFSC2JrdN27l4gzmIAJ24tHOb8MZWzfLHo8U4BZLwKAcS27SE67oU5GgcUE51QJZ5fitsrGr4I7Hh05+jeFFlyRk=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB5941.namprd04.prod.outlook.com (20.179.59.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 07:26:33 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::f827:c296:5af6:c2f7]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::f827:c296:5af6:c2f7%5]) with mapi id 15.20.1622.018; Thu, 14 Feb 2019
 07:26:33 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>, "hare@suse.de" <hare@suse.de>,
        "hch@infradead.org" <hch@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>, "tytso@mit.edu" <tytso@mit.edu>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
Thread-Topic: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
Thread-Index: AQHUvdXi8uW0z5RC40K0A2uBHEuuMg==
Date:   Thu, 14 Feb 2019 07:26:33 +0000
Message-ID: <BYAPR04MB45027D66C9CB3B8606C891F686670@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
 <1550081474.19311.62.camel@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eb3c245-9b4e-4102-1543-08d6924dbf2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5941;
x-ms-traffictypediagnostic: BYAPR04MB5941:
x-ms-exchange-purlcount: 2
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR04MB5941;23:rpYJY9fxsMiL3IA7/dzlTiCcoMlgbf+KSxTB8Vjt0?=
 =?us-ascii?Q?mEYMaYeS9RFriTF9HMAgNwsht8Hrb91ta1dehzyYIV3zHedbYJndUXOaHQ5n?=
 =?us-ascii?Q?/7deKhIxmxbROlzc4GOlGdaiCREQJGOr8UURwvbl+LYngpDyJYaG9raWBCtK?=
 =?us-ascii?Q?I6ygztO73ZpJpF4GemL4ZJMJQy8y3V71kGKErDW+hQecWoIDOG+wmljhsGoi?=
 =?us-ascii?Q?liTH9G1SKP+6RR80gLopFiHU46KBjWj+90MRPzxV7811TIb0znI9l36T9S+6?=
 =?us-ascii?Q?rjQpOBuVHiQFUNtd9ZNTOqvw6sbTbo9mv/KsdzPUf4Sar4KqHJU8zQNHRFFH?=
 =?us-ascii?Q?Iv3WbxNKDHtTHIfV6fiRQcrP0EGvDPdH9CyGavLB0ZcldSbkRtxhmEHUWOyw?=
 =?us-ascii?Q?TcqsB1L8buoc5Z08H5/b9AqaMQlLU2If73lCKT48m420NIPCPKcNzc1t2T00?=
 =?us-ascii?Q?jlSR/I4s67nq7/VuLk7m19f3t7W6NzeJesu59l+cyOpsUMxrYMKIxUNawEjg?=
 =?us-ascii?Q?sI6Ulvq0ayHvj6smThhN7SMG3mPJr914ixm5zJ43n0sP4ZIBmnee+kET+IOr?=
 =?us-ascii?Q?xF4L0GVhNa8m67/EkON57adzK5/NwFSEUakQGMwRn95E209s0qH60jmpBuOU?=
 =?us-ascii?Q?Ffsfgvbelfosw0B0VdysSzBN3kL3yJliINmzGkpTr3PHRa8WjY463yNJYswE?=
 =?us-ascii?Q?OYTXv9J748zP+KWipionPZEE9VnJVkk7wrpf+jhkKDJIKj8KT+D/Ycoynq0f?=
 =?us-ascii?Q?wE34SLnrztCciqLzp5MTBY+4O5C8rfqYt60Y7P0duaD2nPNS61uerRYhGJEy?=
 =?us-ascii?Q?F9A/VWtq9xXmj16cmtIkK3P9jsibDMCIXVR04OqOrMvBA6mEW4s9OZfLjEb/?=
 =?us-ascii?Q?pJ/aG57FyE2mAObtZ0Y0TJmFIohDtLdVgwgae8yLEykUc0hTAYlyR5cUz3YW?=
 =?us-ascii?Q?ULV3QrSE32QnxTn069EuOVidF6nLpSAOO2p1kfUkfoD9dbjaavNg0gSytkgQ?=
 =?us-ascii?Q?HS9F8sFuWjR1QFC3Zi5896a6EPAK18ylXuPLNvbR+NOw/ldOafN3sRAcVaEW?=
 =?us-ascii?Q?K+uMnftJmFV+5rqdtc0wgjrYmKluluNu+FhSwdTRZ+Lw9/g/LNfKPTZbA/Nn?=
 =?us-ascii?Q?/cECm2xKhTfEpPLu//LABicR1xXT1Guth32oZ1c3VzJSNuBs4tPpK71pKsD0?=
 =?us-ascii?Q?ZHw7O6X6IK+NQPqG+deH4QAcOGfjcxsCwD+PfHtavIRAKS0fswq123C9Y2H7?=
 =?us-ascii?Q?saWVVBn6aB1rGdgLBL6eI4Hd8e9qi7v09Heyj0alr9iA26Jvq2cJT/sWZhq0?=
 =?us-ascii?Q?StsI+SEWb+PCdBKluLoFN6Q6lo6chRaam+33aqDMtnC?=
x-microsoft-antispam-prvs: <BYAPR04MB594159D5E18D8CF8E977DAC786670@BYAPR04MB5941.namprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(396003)(39860400002)(199004)(45074003)(189003)(305945005)(76176011)(3846002)(6436002)(81166006)(6116002)(4326008)(53936002)(8936002)(55016002)(6306002)(9686003)(478600001)(81156014)(316002)(8676002)(486006)(7696005)(14454004)(966005)(7416002)(6246003)(7736002)(476003)(229853002)(54906003)(99286004)(110136005)(33656002)(68736007)(97736004)(74316002)(72206003)(6506007)(53546011)(25786009)(106356001)(86362001)(102836004)(105586002)(186003)(256004)(66066001)(446003)(14444005)(71190400001)(2501003)(71200400001)(2906002)(26005)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5941;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M/weZLA//Y3M8Lzx8YuRZCfJobEQZYb5gOrx+EGR3EoNmn/UGc6h2nNFi9NEPeTdYuUb1ajZR6Fxi5xX4GR8Bj/0gVWIl9GWKa9yIGaRsHl1ne1MvCjqugKs/OBEbmY6IQUFAJFc8aTsJTErj31E83r9M04HOEERGisbz8EOnEylgRtSnlJgLKarJFvhAySGNX3cQGqozNGp65Q0gl4a2Ve3tx9ZvgPky4nrs3jmVqrlGnrMIN0QEsdTkHkmr072IscP/ihL/BJhmcPTVjzUBnWyLTXDpMjHUDmksCj7cw1lg7g9UA13YA9B4tZRdf7d5E02giu5klCMRay7NJIA0Hz8aTEehXTT6Pt17u8FLEAt6iXt1wjYlHbtSgwm+C0ZmyZj6xPoUtM+vtruccoEOsi+XA3v/b4WCm0mlMv5ODU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb3c245-9b4e-4102-1543-08d6924dbf2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 07:26:33.5125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5941
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/13/19 10:11 AM, Bart Van Assche wrote:=0A=
> On Wed, 2019-02-06 at 05:21 +0000, Chaitanya Kulkarni wrote:=0A=
>> For storage track, we would like to propose a session dedicated to blkte=
sts. It is a great=0A=
>> opportunity for the storage developers to gather and have a discussion a=
bout:-=0A=
>>=0A=
>> 1. Current status of the blktests framework.=0A=
>> 2. Any new/missing features that we want to add in the blktests.=0A=
>> 3. Any new kernel features that could be used to make testing easier?=0A=
>> E.g. Implementing new features in the null_blk.c in order to have device=
=0A=
>> independent complete test coverage. (e.g. adding discard command for nul=
l_blk or any=0A=
>> other specific REQ_OP). Discussion about having any new tracepoint event=
s in the block layer.=0A=
>> 4. Any new test cases/categories which are lacking in the blktests frame=
work.=0A=
> =0A=
> Hi Chaitanya,=0A=
> =0A=
> Thanks for having proposed this topic. I'd like to add a fifth item to th=
e=0A=
> agenda, namely blktests maintainership. The following could e.g. be discu=
ssed:=0A=
> - How many maintainers should the blktests project have? A single maintai=
ner=0A=
>    or also one or more co-maintainers?=0A=
> - Is it acceptable that patches get accepted in the blktests repository t=
hat=0A=
>    break the continuous integration tests? If so, why do we even have con=
tinuous=0A=
>    integration tests? See also "[PATCH] Unbreak the continuous integratio=
n build"=0A=
>    (https://marc.info/?l=3Dlinux-block&m=3D154990323618159).=0A=
> - How long should it take before a blktests maintainer provides feedback =
on=0A=
>    blktests patches and pull requests? Is it considered acceptable that i=
t takes=0A=
>    more than four weeks to process a pull request that is in perfect shap=
e? See=0A=
>    e.g. https://github.com/osandov/blktests/pull/44.=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
Thanks Bart for the suggestions, it will be great to have these topics =0A=
for the overall discussion, it can help us to have a concrete plan =0A=
moving forward.=0A=
=0A=
