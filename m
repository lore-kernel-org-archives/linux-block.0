Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF92C05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 10:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBFKBW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 05:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBFKAr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 05:00:47 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476C6868D
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 02:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675677627; x=1707213627;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=CHXdvXrGH0pNyx/JERJxBKknYkjoaGbtPLYZGrNuHTg=;
  b=Rof/vev4ImIme9arveShxKvyqgbWFtuM4jofE/ZhFPQJ2+AxBfGY5O0I
   H0xcmpDmTfq1j8ifWrX1cz0csDXKLSo6YtbXE9RtA4yifXiHXDMfN6dCL
   rxxY5L5oPG+lBD9dIC3Jc0W7WEEGZKs/IxI+je75E1TUyhcJ98+GcCJNe
   9eqluxOFXpT8twd9eBqUX7lxJxGaKyfhrE1yDMAWVhDyGrijKGR725a+W
   k8NovYMqneAjjmFdcwIkYFc8j7Lymt86qkZ6JcmATheYTL7uuADga+mHr
   YBtqgY5JMAuHhOOvxkL6rNnr1jG/5bSrUiGkz8XsY/2Xyob6blUXDs4CN
   w==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669046400"; 
   d="scan'208";a="220925379"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2023 18:00:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTVvhZZBO0gbb1e7uoixPyrUIUe56Ad1t5UC65qG5YPVMrkQfYECgIsoC6AcpiBY2QTJNFfaCJSZlXL9/fZ4RrxtZ1b0fc2M5lLipzh0sCCycg261h1sz73mHN24ePNJLqSkCzcbkG6UfNqSRcIIApDZIx4b0AsOzhVen5BbScxTB/DlOyqsGiSIs54EsSGzP0iGdy0ptpuyslDNDuXwkFIozqbE6lDwOvYzUfZ7BjMLmDcrELRlgCbK9glswqvFofMG7BFK81xE0x//sWfpK1gwGqcnka+HqHm8HlaAOCgyXGOTJQI1+NpIHS8pvJcU6cZUMl9XNE2ig141EjpTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO25R4fErMJRKimdPBAOtYkTPW+URg/UbEJ3ddEhky4=;
 b=RgtTlvg6UofDVoOihwRAhS+3wkfkKyujcD3SQghj3mQZj7lkNuw3Wmipda4nB6VAxjyxqNn8vQNAFAec+gOJUj/mSU5oTF+LHs83VvMlCWDj+M4ct4mje2Gq3sHg6/Eigh5rVgfnNt6RgZxxLdc479iW53/QdgjzCOcs9LRqp7W3JOt6+dqDXJOPT3I65h0+acXqb2OZ7fdA9IRhqB5No/mJpSLSUpkD2IrUKrHTU4Uqlmxu0Prsc6lkZOkrzn6lSaDDSxXU7hgi8OKG5tZDMvecHQp6btoqcb2yKazKH1eSsmwjRoAMMNeOtsCFHzfDcvEkXChf7VrOhrroi6mOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO25R4fErMJRKimdPBAOtYkTPW+URg/UbEJ3ddEhky4=;
 b=xzF4cTPj0v57UY7gGv+rfNa3LN4XSreoIrjARUmQb72+3hUHeQLcq0Bec7RmTuZdx5Ph3VVUCOAhsUesiwGBI52dj0mJqLf1eWVAv+j3fm4Fa9+uSrCOhjAZk+dPvySzcSuD4qpEk6NTVBqOcDuC0areLtOGPoYxdjuPvlgdsYM=
Received: from BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 by SJ0PR04MB7599.namprd04.prod.outlook.com (2603:10b6:a03:318::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 10:00:20 +0000
Received: from BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::382d:4aea:65a9:8051]) by BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::382d:4aea:65a9:8051%7]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 10:00:20 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        =?iso-8859-1?Q?J=F8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        "andreas@metaspace.dk" <andreas@metaspace.dk>,
        "javier@javigon.com" <javier@javigon.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "hch@lst.de" <hch@lst.de>
Subject: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
Thread-Topic: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
Thread-Index: AQHZOhHSKPSlOHoOkUKnFFq3rkeAbQ==
Date:   Mon, 6 Feb 2023 10:00:20 +0000
Message-ID: <20230206100019.GA6704@gsv>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB4296:EE_|SJ0PR04MB7599:EE_
x-ms-office365-filtering-correlation-id: 12b41217-5c25-4cad-ab29-08db0828f4eb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M+mZ3B7skw4+A5XXAmeJc52H8pzwJQSj/KPWBB/g3AlOa9alWvQwJI+qHv8T1PfWEj0UNsFRhKXleMRXygI8o7tcoH1JlITAYbaWeIGhuU2Tq+UdVV4iovj+e0ESRGgIzSgISfXuUZkvF25sw+agFmVavZeNCbQ8a5ivbTY2xm6HmpXktIJi0SELT3u9ashQlLL0LOOwfKZx5azntIQVZucFgs+YfI4BQjHJGAQZg1b8iiArlkiYXio3z9dQvtv9eXKu/InUWiZjFq6Cr3Ps73ACZp92ThGY8z/aGNR15faDD/XkLk3HC001/OpHklk6Nd4hvnM3ijg7BCzDJD7pf6yOTPUh5AwHlT6KmRg0mNgkkjzUrfJm0noVK3pEhJhKDI1PgtMPprBj+w/WOonOR6J+SRbeQawZcjkPGuzMVKPRCw0Lwz3BgkLTMV2r1IIEgI1Habgi8AXXX7irrNOXV3KsSD7ZCK1oCeALs6Bc9YgejU81DvcHY13aryMGHiwiMFeGU/emeKzl4AZTMl2H0gDj9W74R1YMgmGswtM8M9uoARg5I0juy/TwdPIhaGKjr5rJnFspn/fyPexytS3exiwG7rtASZNrU9pdxDC2vTkaCf6pdfaqHQV20h+koZPXcgp+gEEcV+YAp/+Hxuy1n0dWRQYMwun4KrWlIhg6JDss1yb7EdXWZBO2VSYw+MJNJMyReJvfvVdUiuQXoTm8ALB1EELTCKJkmBNWDzqWQOQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4296.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199018)(6512007)(966005)(1076003)(33656002)(186003)(6506007)(33716001)(26005)(9686003)(478600001)(38070700005)(82960400001)(38100700002)(122000001)(54906003)(316002)(41300700001)(8936002)(5660300002)(71200400001)(66446008)(2906002)(7416002)(66556008)(91956017)(66946007)(83380400001)(64756008)(8676002)(6916009)(66476007)(6486002)(86362001)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ncUlKRkehebhVXKjWZlF0WHgDEjmNNqU1MyXZz+Zia3eKiwsIDoM9m3hK7?=
 =?iso-8859-1?Q?VTdxJtW9oR1cE/pKoqBu+zT62BKSarACvhwn/4Q5Ls7DpU5AuHNSgZ12pz?=
 =?iso-8859-1?Q?nsCpp3N3nktCY0FEwPtmHaziFMBjvIyaLxEFaddoHtuQv86kl/en6OG2y3?=
 =?iso-8859-1?Q?3WEPDrSuiopKHbqmESQukx89k2KRYZkL7QatJCISuXSgLKO5DJYCYyc50Y?=
 =?iso-8859-1?Q?uuGfNAKEG85v0vOy4ywiC8BbyQLufQ+wO9GEz81pbNOLRcfdJg78hsWa4u?=
 =?iso-8859-1?Q?BiB/4WOcvi/CJZlR1NRQj/bzjNJBhILjS03chXzRq0GtMIgm+nzWcGU7Sy?=
 =?iso-8859-1?Q?BKzdTQixbu43dJ0mQWVvfXf3NUXpLQtBEr5Eu0oh2qScF5But4vLD9fScF?=
 =?iso-8859-1?Q?aK9tRJP/1e1T6WM4jPhTvbxErD8WdBRAM3FSyH6h3c0EfILGDc+TJvCskk?=
 =?iso-8859-1?Q?DZr7UOTcRTxHiHRFAsZFQx5MdvfSva2qXLAOKGtIbeWRISY+gCcBtT+21Q?=
 =?iso-8859-1?Q?TQvzWsHD9gM4CgZUmkhlNqfztfpAKAeXe5hYo+rEhNE6AwM3TITcQdqEdl?=
 =?iso-8859-1?Q?WoSwmEAoFCUqXr01zq6V3WN97OGu7F+0z+/x3+tvYDaxf0tEBN9KC7kakJ?=
 =?iso-8859-1?Q?i3t9K/QknyXbvdbih7Lx+4sARHFoM42zf/C1IQShGomR6e5TmZuD6SGBNH?=
 =?iso-8859-1?Q?URg61BnGd5NVibqRvNyTbooubhI2B7cRTu/QuTiWawzFr4ETv62GH7WNx+?=
 =?iso-8859-1?Q?6euOee1afQWP0PITaN26Sl1O+y7bZPi3cfiGeGT2+ApgEnO0CGWGzZvDrX?=
 =?iso-8859-1?Q?a4BLHe3uuNBSLar2jjLn4hv76widY+td7jPqIbwu4VrzQA4nXptz/BcnMr?=
 =?iso-8859-1?Q?bDlB3GXFAbUC3aATid39d2XK0dMZVcNnSrc1Nf1TyPft4Q5ybbH2bJ8YEp?=
 =?iso-8859-1?Q?5i8soScUQo/5K4KpthGkrNUsLE1nkgts7/ve05XmGxpZwi4QV0sQR23QkE?=
 =?iso-8859-1?Q?Zrz22hV/BeWuF8dwD7Z3rhuaRSJu0ksZO66gxcuj4kMStVjFZz3eVGLXz/?=
 =?iso-8859-1?Q?c/OgCoT4/1/T2etrVfBJgx1RS8HYn9WDl3WqQpYV0LEb8j70qK7uErIywe?=
 =?iso-8859-1?Q?9sLRzWm0g8kHP7MvJwk5Ci41UahWB5WjgDRecFX7mBwgVBqYlh5XAW+kfT?=
 =?iso-8859-1?Q?P2O2HGlHYxzeUOT0bz2qVcqUtcXxZziCT14tb5YXDQeuOCdZ/7k9PtVclE?=
 =?iso-8859-1?Q?aS5NKdtuqk1hmogd4reD2QHpBBMyuhz8CuCPoc7J5yeAkFXdftTuDmZWio?=
 =?iso-8859-1?Q?LRk3aT2qWcWfnCJTUAjRelozJko7lgWxYlzlTXdAELESjQm/rRAs0h80SK?=
 =?iso-8859-1?Q?bia01QNLY7da4cppHJgFwzgbKdekR1ubAXOipy2dL0Ho4Xc81zwVFVIIQZ?=
 =?iso-8859-1?Q?466/nzP/RsNv4qFQ5vvpl4vZtqE8PH3HSA7JO7xjPuTYqMXZofSWILYof4?=
 =?iso-8859-1?Q?goOtEd5560fNrTcX79eSQmTCoqe/YNMpGEV27HsMChi4+fg+4wtn5L+24G?=
 =?iso-8859-1?Q?UqauWHlwYnltjiOOmRPH5XN87RG7rQnglN7xVl/jikzOKLcfPgQdQT7ObH?=
 =?iso-8859-1?Q?ZWFbf3kwc8dEpgG93PFChzHy/M+jVuFx+DahKiVJgONy0pJbJB1bH+Qg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <601EF930BE0E4348B74065EA9C3DEF0B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?6Jgx1dJAW14CK1NL1SDGRwKcC1+28vvHaIHYaNCt31t2cSdC00r8LXNa9s?=
 =?iso-8859-1?Q?bL1/8BObWDr0/0HOmijwZKCbizAarSapcrwl6Zj+7w1Fvl4HaiGAsrO2Mp?=
 =?iso-8859-1?Q?ziPxWCUps/Cb8zoHI4B+EiOBQUJYi7nIc6RAXwNVynZXLhz2Y8Wqaa0AnE?=
 =?iso-8859-1?Q?x9OoNHasFLqAMDHybShj8vDddbu9gl5RhjrXJhy6UtZwfXXIFX+1REaG0a?=
 =?iso-8859-1?Q?TNqZRUaT+U9jQ9H7v7u2K7lSoiSAJDerKqKLnos4NK1PRr5mXm7I/lMRdx?=
 =?iso-8859-1?Q?fhwUnq9MFCL+MtJ1K3f91YdN823oP9LTEjimMMJepqrCs5k3QHatX4YA6e?=
 =?iso-8859-1?Q?0l7ziUFjRZhDbfCQX+mNYU2ZFiiAfXCAS5GMhHWa9G44onGrYH7p2mr4WT?=
 =?iso-8859-1?Q?d5PydtUaZxq2EO7lQccwFJMXa0Hprj98lJXk417fOAEiajgnQ10RXdF97r?=
 =?iso-8859-1?Q?4CmjxUwaB4bZXllUV/RRdHaBQPZhpEuhjTSEtt8AgtD7iwZjqBj3Jk5Pkb?=
 =?iso-8859-1?Q?K6soIfR7QPj9HyrtcwSL+VFUdrwIAjja3n8GyPIzlsoByD6IEs0+9a08kg?=
 =?iso-8859-1?Q?wNZHMKRIAvCYgVBSQP+PETpnMQbi9dsV2EGfBvwCVPDrq37htjboElxMd0?=
 =?iso-8859-1?Q?FEgWfM2qgX3tWuXo2P8e9kIyq/wRUYoBDjJgId5T9WhwLu8jVarR1OX7nv?=
 =?iso-8859-1?Q?AvT6yKNMcxTHkt6Zt/9BKAXR2UaEcgBupId0hRmW+zel/rc0Qom2no0fM4?=
 =?iso-8859-1?Q?jMyDUB7L9aRCGfMU1mISVp4X/mbYDIus3l4TJ/YO8+WnbHofudAKKCupHv?=
 =?iso-8859-1?Q?HPCj5phxVlvs9ytWg+6B3e/D/+YcQNi75laxq1dy1hO+C29YYzfx+h0Qjr?=
 =?iso-8859-1?Q?nzSrtj21wL3S5NrA2TRF4Ui56ww5rZCtsx8kXEto3QMIv+KCruj6UqLa7N?=
 =?iso-8859-1?Q?4JbbHJ6T9z+aq+VVJz2iwCFy23Xh8KwMspb1qNww6f4E5lqNwoBE+NJnX0?=
 =?iso-8859-1?Q?3RIpYpThnB9z6Fu6bCmtNqtMN9q7nM23SJhM0aKbfog6JtUwelU2hiN2wz?=
 =?iso-8859-1?Q?gg=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4296.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b41217-5c25-4cad-ab29-08db0828f4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 10:00:20.3700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPTCWXNNBLoyUXC3eEh5u7ibwVq2EYIrV9XffzzyL43EFgQOCQjJpjJT1luz3fsbcScRcAscVzgTs1DHMTyXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7599
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think we're missing a flexible way of routing random-ish
write workloads on to zoned storage devices. Implementing a UBLK
target for this would be a great way to provide zoned storage
benefits to a range of use cases. Creating UBLK target would
enable us experiment and move fast, and when we arrive
at a common, reasonably stable, solution we could move this into
the kernel.

We do have dm-zoned [3]in the kernel, but it requires a bounce
on conventional zones for non-sequential writes, resulting in a write
amplification of 2x (which is not optimal for flash).

Fully random workloads make little sense to store on ZBDs as a
host FTL could not be expected to do better than what conventional block
devices do today. Fully sequential writes are also well taken care of
by conventional block devices.

The interesting stuff is what lies in between those extremes.

I would like to discuss how we could use UBLK to implement a
common FTL with the right knobs to cater for a wide range of workloads
that utilize raw block devices. We had some knobs in  the now-dead pblk,
a FTL for open channel devices, but I think we could do way better than tha=
t.

Pblk did not require bouncing writes and had knobs for over-provisioning an=
d
workload isolation which could be implemented. We could also add options
for different garbage collection policies. In userspace it would also=20
be easy to support default block indirection sizes, reducing logical-physic=
al
translation table memory overhead.

Use cases for such an FTL includes SSD caching stores such as Apache
traffic server [1] and CacheLib[2]. CacheLib's block cache and the apache
traffic server storage workloads are *almost* zone block device compatible
and would need little translation overhead to perform very well on e.g.
ZNS SSDs.

There are probably more use cases that would benefit.

It would also be a great research vehicle for academia. We've used dm-zap
for this [4] purpose the last couple of years, but that is not production-r=
eady
and cumbersome to improve and maintain as it is implemented as a out-of-tre=
e
device mapper.

ublk adds a bit of latency overhead, but I think this is acceptable at leas=
t
until we have a great, proven solution, which could be turned into
an in-kernel FTL.

If there is interest in the community for a project like this, let's talk!

cc:ing the folks who participated in the discussions at ALPSS 2021 and last
years' plumbers on this subject.

Thanks,
Hans

[1] https://trafficserver.apache.org/
[2] https://cachelib.org/
[3] https://docs.kernel.org/admin-guide/device-mapper/dm-zoned.html
[4] https://github.com/westerndigitalcorporation/dm-zap
