Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF9C433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 11:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiEaLMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 07:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiEaLMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 07:12:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66F4F9C9
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653995569; x=1685531569;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1k4xbJuwBGZWf6s71ipwLt35IlvDIjdFQPaF5AhuqxQ=;
  b=ezGp1b0sN5HlLVYJb8BYjvvPEIcCEfugGX6TvBkM0fwAvUXDtKjgg6wh
   Nh0p8w93CjQUDdtS7je4u1bxN2/rPaGwCY1t8abEPenGzkVRLZCg4m64R
   r7qPUh6Eic0FsDqzYa9ZdTWVTcJHWFxGBkNN5I4sVsthrNe7jlVpdGLrS
   GXnXMRGhNnnS7LtaewnXQemeFGKA/2dS4Un9Ehy564Pbh1uohxYXIxnaO
   0QLeZwCicclRKw1GCFtLgmnz4FJw4Gn0M+Zlrb9QAiARwH/gxAatdBGtm
   b5o64VNinHLzBuiM5pIY4baKrFyUMEOfHy0yM+gsM4UzAIxs3UI4JgT5P
   w==;
X-IronPort-AV: E=Sophos;i="5.91,265,1647273600"; 
   d="scan'208";a="313898969"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2022 19:12:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVhMgk2GRSl1NncuNz6gAkmyD1qapNMkkn4UyHKWxIwfSIvXL77VaH4ykQ57Itg1nSOUkaLGJWO4dewEIjgPWqkUU30ROsLdQloNaj+iC1ehyY0gtu1mte5xiN3EZ/wR9n5jAlRsPzppLaLYtlNlkOd/Xt2KpWBR/yh1VvOjKzn5QDVUw05I00jdg/oCRR906LW1gVVbalLE1rn/vWwH+P098rjf5TpnHenn3rSuyQjQRxhEheSJv3i6qJzPdN/hb1N19UwHrbc62Ai5BfbQapb2OzdvsgowlXlUFwCx+rcHKuB7CIWnbfmf6O4Jx+7pHeHP8kHj5inGhqP/GukQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJZOw3vKy2PgErC30ttKX6sqHc3Flo6EDOxks/1MBA4=;
 b=fCLVpmMWcRDbIWyGPsrKQrynJ4I4zpQd2aeZOVfo1IO9RadkFP0rYS01BSyXZQCURKhwIHEqXfvNXGFGY42pbot6vzaCIFXkwGBQMsEnItbXkW4apPzeJu5URwMCIvZzjOn9FEBUJuYlPQI/WdEOtYm6drXVzhUQGkarCj4UHxfCJyIHyds3LYV1EDFpPPBcdW/aiH75QUjPxFsGJkLJSk0OBRaDHQqpCAR2VR+ewNhe5NlKt603nOhxqK5JF8lX+/1iJgZzLoToN3gKlRD03pjC3n75lPECS/Z6CGrBEahQPOzfo2w/FTz3Uuh5mOCkHK4K3m4MRBirSIlnJHOzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJZOw3vKy2PgErC30ttKX6sqHc3Flo6EDOxks/1MBA4=;
 b=i1HXDS50w/ZZPOh9zPKZxAQ8OsEcz07iwThhcd4D+frFPh4LNFZ9cVyL8SVY/BdNKwfjJtdTPzqnvZ2E/XFC8pIN2ACj+lOjRxH1wovpuO7LCcKBZwNzIyTh3cUWdpxh/cbJkgxxtlv9RZ/fnDSoWh1GtEXaLTK8AVaZnftvtIM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5478.namprd04.prod.outlook.com (2603:10b6:a03:ea::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Tue, 31 May 2022 11:12:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 11:12:46 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/9] common: add a helper if a driver is
 available
Thread-Topic: [PATCH blktests 2/9] common: add a helper if a driver is
 available
Thread-Index: AQHYdCZZopPCDis3KkSvD7JorbHDAK041miA
Date:   Tue, 31 May 2022 11:12:45 +0000
Message-ID: <20220531111245.h5fclixuoltcvea3@shindev>
References: <20220530130811.3006554-1-hch@lst.de>
 <20220530130811.3006554-3-hch@lst.de>
In-Reply-To: <20220530130811.3006554-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef8a140f-2f77-4508-f5df-08da42f67d6e
x-ms-traffictypediagnostic: BYAPR04MB5478:EE_
x-microsoft-antispam-prvs: <BYAPR04MB5478071D2F0149F52C33A1ABEDDC9@BYAPR04MB5478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tM1P3PEQENeOsZQvCBPp/Ol+fxxksNgVkVNcrLQugoPIc0B9hT/QnvjDGEG4UUSPnVYNAGesGAdBOpW99xmyBb/cOxWijPVWJ0w8YMa6A6EAHZep0mvflZFjjfz894wxzNjRg1eWvzOqfphr0SA6tVC2/QOvXX0VjXTEnrrUorsv1iUnlR86XTC4gm9SNpavKeH1/v4mV/SjYx9gkcIgae5K3Zv9v2XoNbf5YGIhwrSESfLybREX+KwjBiYxc3ynIRjsD45Pm7ZvW3k56YFkpNEwb7AAO0X2vPfAJQKtD6d0fr7VQR/xCXw/6AGTOsb0r6KE17AypVEsPRHgEbjgtK7kMORRcLZyDxR36k1WcdAeo5eHNoGVdQwmZsSaA4pBapBAdaNLApo91EafxwgjL+ipcXvsGqEDvhmW7p83/OyYtNdBUSE+vpZMxF9FDAq3JUVilT1h09hyFwZkqsB3jVuiJj2D3aApGm+suxGPmJcORpWdI6fzoZxl8oa8AYD5oMLd4k29ZU4mGfr9lLL8C9QgkzHpebMQftAw7ig6gkKGxiotnWUyf2I8e8KpLBMekqEjB/BEnLa0aRbvSSnoOoK6XZYfcYq52FJNOHTt6q/5y+JOvaC7Szi2hNrkfUQQdSxFHKLbB0sMC0jQGRCi8EpC5mKUC7NX4zXJ3KnWaVk8eOub+QAMwMHhmHJQ4r4SaUx1wunl0jXCWIct2AE6PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(38100700002)(86362001)(66946007)(66446008)(8676002)(91956017)(64756008)(66556008)(44832011)(76116006)(66476007)(4326008)(186003)(4744005)(1076003)(508600001)(71200400001)(6486002)(26005)(6916009)(6506007)(6512007)(9686003)(316002)(2906002)(33716001)(82960400001)(122000001)(8936002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BtN2uvTHXOXFLKblFcrQABCdAAsUh1Cb1fEtxceERIYfVFiXJUw+UNXPUEvu?=
 =?us-ascii?Q?OwBefC5mJmktX8btLCJbybZlSTE8B6BdSMFXEDu0gKr5MPy7NlEVY7t7tMkn?=
 =?us-ascii?Q?T2O1LfMZ92HPtZBI/RSo/FZ1S4VDbR19nNkdAxYCG7ZgKnRPH2q4V3g036Gn?=
 =?us-ascii?Q?h9TyUQH87qUU894227c0LvYIhT6srVX/iS3mjGdttPptB6OyLwhs0s6tw1ck?=
 =?us-ascii?Q?wPlVa5Gv5QZTOQ8RWwslLTezVn2UkOYgXRhVq+xDlFF9pYQYRntIky5Uq3us?=
 =?us-ascii?Q?L/RpYdyuu9481TkVTqxrV6NNhLom2znRP79NpU6LnuOkUka8s391WrrslRkX?=
 =?us-ascii?Q?KswSfkZTOdN/5IxUC2rM3xkWsZJWZPCrUY62Om28ni5fAZjFGHWPP1n+fL54?=
 =?us-ascii?Q?cgeRVTs71K528ICyn13txwQ7tdDEBWJ60WNeze/cOZR+NSMTvARcs20dfLCo?=
 =?us-ascii?Q?bfx/DXoqgNZE5C2B8d1sTtZEo9bWTu2D+aVvUfZXzWpwtW7mQzoihgaT1NEC?=
 =?us-ascii?Q?XfI7GDXk38lHHwGzZlTsa7qYutrpTr9M7CaRFBA4AFoDGJHY94JD+pu25rRG?=
 =?us-ascii?Q?uV+yjfGWGqFB9AvAE1wc+jwTv15Jnpy5H9/GrQrxRWfcy3Id2j0yWzuWCd25?=
 =?us-ascii?Q?IwDHZga2tX3qXnQEH7Mv31ml0j8YOgsNQ43LWV9/19E7Bbtn9xYCFu3wWwkP?=
 =?us-ascii?Q?QVXjm0P/g5GE5kRGKFxmlosczdxM0ItGffi9t2mGDs3SkxebSFxGIlv12GaW?=
 =?us-ascii?Q?OVLoFM//178DjbEAmMiAiRVILKneT29qekLGQ03tdPNpewgIaTLg4rD7DPL/?=
 =?us-ascii?Q?F37kpC7P5t3ckRJJCNFfgJnrolC/aubEKcj2w0F7QIGzeDnVlof0Gl3NX/Ws?=
 =?us-ascii?Q?iUjOTcMm4+Ttww0lnDkvMHLFSKW8obkgRj8doug7s4FtdNS4CDF/4KoZgtCa?=
 =?us-ascii?Q?/x6/9Kf0tIiwm6l9b0Iom5Bz4zITViJvp9hL8KrkEVGMGPDR/cJTvpYawThj?=
 =?us-ascii?Q?y6LB0yCUdfrO/Ne6MxUiE0TIkxUnzkU0aklJrIHa4v5WqJyIVEZXem1T4iqU?=
 =?us-ascii?Q?M5zuEqZoz3ipE6Gbwj9mLammOSf0qpuhAcAbA9Fp7oVp5PZXhT6/CI2rk5ge?=
 =?us-ascii?Q?/h33hEuSTIJ/sVu9Xfh92IhesNcK637HqHvnN7agcpHdud0cP8izJtfQ2CAI?=
 =?us-ascii?Q?fie8r2+vlIpklbMZuWBvH8Rm1KvpxGfvpTZCSIoBI9mrJTPtD2aIIAD4kKH3?=
 =?us-ascii?Q?sa7o5F5JR8Nt21wxncUcVPKpuc0yLEqyVQ+OFnijvYbUlPdD4wS+NE6bu3kS?=
 =?us-ascii?Q?FiqAczHF+reZXE+dd15/QlkmbRTy3ppeqZgudLwws7X7/T7eByDRUEKRD2CE?=
 =?us-ascii?Q?rrfQ50Qt0o9GsAftGi0DhEi5YIM8VWOjJM2LrFrPBRMcSt15DMbHqjiTwgoM?=
 =?us-ascii?Q?M3rMtRmX2WYyPUFSUnkc1+z0kBAvrwB7raRzck/COSD5T7huTbeM4TyrbqrF?=
 =?us-ascii?Q?C3w8GLVxAMSrwuGuJ1CC95eUeyFNU3++Gl/7wFJcOXadRgt82cE4GnSQSfxg?=
 =?us-ascii?Q?fV/KLys9jzXm2mypdSvzTZaNDAXUvcjmxRiwzbMcSH+8b8zjHZklJKfUcJFN?=
 =?us-ascii?Q?wyJm9H2S+MzGe79jCoGS45wYSw+K9BFDoI0UZfpXyoQODy2vaiU+dClajOKF?=
 =?us-ascii?Q?+CW1AoNHWoyRwTt3XfQCbtYvi8Sc9YQ96KtlCaTxhyR7hqroVTB4nvhemHHY?=
 =?us-ascii?Q?ou4XEoPes93ceUEf7HI4RXP98MxtPkyFM0U9qejc22vaj0tpqO9x?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C32FA1175B51AC44A57AF73F69612A75@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8a140f-2f77-4508-f5df-08da42f67d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 11:12:45.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Apy/naIAgsiZZrR/gG/870xhu7SwawGWv9VU6hhdFMLWlfY93exQctRLVzF6obxEyVPOg9P6zrnT/U4jjFDPOHqOhnpKgUbS9oMG9ltJJkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5478
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 30, 2022 / 15:08, Christoph Hellwig wrote:
> Unlike _have_modules this allows allows for a built-in driver.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  common/rc | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/common/rc b/common/rc
> index 5e35e21..a93b227 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -28,6 +28,18 @@ _have_root() {
>  	return 0
>  }
> =20
> +_have_driver()
> +{
> +	local modname=3D"${1/-/_}"
> +
> +	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q ${modname}; then

Nit: double quote is required for ${modname} to make shellcheck happy.

Other than that, looks good to me.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Shin'ichiro Kawasaki=
