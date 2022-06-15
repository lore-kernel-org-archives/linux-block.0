Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F4FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 11:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347935AbiFOLbI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347683AbiFOLbH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 07:31:07 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA2752E68
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 04:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655292661; x=1686828661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qqg9Bg8XnOlOtZrUf1gW4K4+0Eig2Msul4khBUvvIaw=;
  b=O+n+RwXU30dHARFTJ2QdG4Q+EC8QOLo2CzovL0Ct/28GdK8U41dr+hE5
   cc2vDNdFO2nSDD6TfxL//P04TGfiSuHW2bs5FOnLoVud5Jv7F5fzQK4aA
   jN33TfSw9Y1bD0IkbLDOKMVh6R7bXXwY0VbqN30JZUyfb2Dd9jin5aIci
   OsYh3XY30wpcNTlNkO7kwBK0OYNisUxryQl+3f+1NeI+dR+1FxrgARn7T
   sghIAB62I8+2TFsjW8ypffizpRzqUhb12LKQdIiOABn2h5cXb6+UEyAjl
   YLvSzRPak0qTauGX9vxFt05qKuTz5UcWZERGhATtlSycK4e9PoJ/HCkaw
   g==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="307512510"
Received: from mail-dm3nam02lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 19:31:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3aPcy/u3ItIp+7IPNGE4xbElTkmTka/iSRPNQ4ZZNZ7JDdNVwz570aLheHaqztQkdvR47VFVao5tQozZqVleZqq5pYDtaNKs+UQBCHLfRpDkPEZwkr5C5vTELIGgtsCFP1kR/IijUPL3WLa32XkZzWBKFCc1EspketfL+bl7VvYTEZTni+ykV+pp2ejsIgT0lvgHsuMz+1Cyt4FUMnCYtNyvByemFvk5RZIX/0CirIX19V+b5uLS7Ux81aktgn24sox9ZUbGEYix+KQQ8t5Tx71pHZ3QrcEw5DSz/MAJOQeu2Gr1n2bO94ne/wg4JGp2ln15i3A50grIjHdHx1AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqg9Bg8XnOlOtZrUf1gW4K4+0Eig2Msul4khBUvvIaw=;
 b=UitYJ4NSrlsbnrmtt48ZyGALDYbuJ7TWClXgJSwROz2n/QqIuRsdwdej8E3PmL0i+TNP5zaqfKhWZyo3bspK5/GVnW00qoXzWH7KGcePTsavo7vP8DV3s0hKfhFG5JrNnGBPKfJdIHaEMl1t0Il+XV2DDMNnGSx2LZJwuqAT+JrcpQBwCv2e3bvVzUF1cThWA8j3+T4gudUhVftg6e+bn6U8L0hKbZz8+OLRYdV6VDOUS2TTIxtzmRDLMk0BTsNDIopindXfcgj7zkSjdJ0txHsti7+v7+dhY3fvZkYA0tmG6TtY/XnvJjcOyb5X3FmxgvYK4WHEx+TRoKrmz1uT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqg9Bg8XnOlOtZrUf1gW4K4+0Eig2Msul4khBUvvIaw=;
 b=HZ5DL2fsyx6Htg3InnS36tp1RfzdVnPllrXR47mTdlN5yZ9ke+3ruGJX/ezBhFlRgFuFjB8CzS6jjaz1erUcb66MtBAwA/6niGf5ePzZ5boCMNN0f6ZWx0UpR5wB2TiDpD6G+pCi7yG6JcZ3M7+mi1hoCgQ0AvF8kEm/oAoGqzI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6883.namprd04.prod.outlook.com (2603:10b6:a03:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Wed, 15 Jun
 2022 11:30:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 11:30:57 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jan Kara <jack@suse.cz>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktests: Ignore errors from wait(1)
Thread-Topic: [PATCH] blktests: Ignore errors from wait(1)
Thread-Index: AQHYf1XAEAYM8410bECfhVCFN0sjpK1N8K8AgADyagCAAXT+gA==
Date:   Wed, 15 Jun 2022 11:30:57 +0000
Message-ID: <20220615113057.dii42z7smc6mwcep@shindev>
References: <20220613151721.18664-1-jack@suse.cz>
 <0b0ec2ce-9d96-2324-c10c-ad2b0c6d688e@nvidia.com>
 <20220614131558.nzxkqgqlwzjnksda@quack3.lan>
In-Reply-To: <20220614131558.nzxkqgqlwzjnksda@quack3.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18cce96e-ea3d-4c29-5767-08da4ec28464
x-ms-traffictypediagnostic: BY5PR04MB6883:EE_
x-microsoft-antispam-prvs: <BY5PR04MB68830E618668D7B31D9E09ACEDAD9@BY5PR04MB6883.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xV7gKZMameKrm1E4IFKJ1OjypMtVjgScrru6tQMqViCadi+x/X8QhwVwEZcpbeAwSAFOQHSHe5lq6tf59BOXLNf2FpzaUaXo5fihLQ3UOUaAflvQ0Sy2uJYtFx2n2xo8j63W3nbXrYT/PIRW9geCxIPb6d2FkTn/NzviTK4cXnxu7Z6Kk5EdgnFjHSMFsUTgmzKaoWZpOgVTJ4arHZ3JNrp3eSCW5Tw8XYi5qP+npbKm2krIEP8MV+Hg7kmVn+YYVTUylTCuYdAciv1El+8JZBj62+za6NIXPu6KLkCO3A93GWSbCEnSXNDbm4vTwFZW6DlMw244MsYueQUcKXzYfEOo6U9OlUPWALffvmWe/MHJJAwbWRUBdYxgCDQ70srBhKrV+Bp6istE07xF/2H6d6Zeet6pAAu1Tk5g655gCGp3cZ9E3xj2Yzt+5SLgoA7a4S2bru3Ct9Ipq0Ijbwm835hYQoBbqTbOAAtiuN8vPErt5hczWzpoB6obmT+CabYI3c6Fis+pMDiYexDmDMrDRSsXqy0tmM2uoxpb7FMK6u3zg57ktYLn3ZOwTJCVj81jNES5biE4cDs9f6zQgjFdRYhZcjzrs4DHxN83bR+QopdnNwI/XcQm+SbkA/JSBF/N7Hz2vKN+DJeM/X5Jg82ep4GBldbf8nDdeRAbiJLeYBkI8LirYff64SesTmnOcMXT7DlL3AZ5dazG/bxqThfRNfZCsDxGOq4jSySv0++kiKR9nCkUP9XHQyPNElyIggrnGka3K7xILfIYvRxaiudIU/js0yUsAkC8uGosUHsDFSY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(38070700005)(26005)(6512007)(9686003)(82960400001)(122000001)(66946007)(8936002)(5660300002)(64756008)(66556008)(66476007)(8676002)(4326008)(53546011)(76116006)(6506007)(66446008)(38100700002)(86362001)(33716001)(2906002)(44832011)(4744005)(83380400001)(186003)(966005)(6486002)(71200400001)(54906003)(6916009)(316002)(1076003)(508600001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i631c760mnPUYniYFqjgCKR/V5N9tYAAyXDjo70N1+zJVmk8ZrHlGbZbIDLy?=
 =?us-ascii?Q?dN2Q5Zu5pdflzYJqDWgoZ8wwOvE1uXnS/BN5mFnH5K+RU+5x4qlMqg0LcY99?=
 =?us-ascii?Q?CTNNzZFTRHGo2PJZnHnQKbOcXH7s2N9FDFgXHnv44e4RnaqTxxjLWEVVZlj2?=
 =?us-ascii?Q?n6kVUbQwsfRmz0jQtkdO/YNlvlUuUqvZj7cIqhWvsQTojSQb/O2qJl3pnwZH?=
 =?us-ascii?Q?+jeixuql7sbbBuqHBc2YGiaeU9teGuYrrfuh0dJVCyKaPa6mij3ZBE5WkoWB?=
 =?us-ascii?Q?/e0A6LUVWE3Fe/xWoZH+RjdnEZanN6PXkD3wVqnNGyWgQ6kL/kPuhhsjySlQ?=
 =?us-ascii?Q?xmfDaM+XCJNztsjSilQgoWjeJDDNPYP2wxHkPbQ5MRsH1HZExwrZIg5KW8BF?=
 =?us-ascii?Q?itNB9wKZr/v1JvZsRCw/qCN3MUORVbyuZx8Fzs+kshNqiFCGmE4eUu/L2KWv?=
 =?us-ascii?Q?2XYQOulZWCgomWcypmot9gQoBiJkmFh+SMF4h4djAM3gW/TI2LmD8lerpSle?=
 =?us-ascii?Q?bL/ty5wM2egPq5dzMiVJiVi/n6qn852I/TGORawDEByWs3EpUdLZSfoBu1DE?=
 =?us-ascii?Q?dnWe6QrWR128CJXW97/sko1zNZXsNDP346kPm9M9GiZBLg3fShOq9X85z0id?=
 =?us-ascii?Q?vBSEXj854AUDW84s9maoAMOC46z+Ot9LVZQwvxj0mPfqNmBeYaT16KAxFJhP?=
 =?us-ascii?Q?ZTM56MIEY/WBi2xmk+ld0SSQeO+nXkul5vbfBlHiDSg8Tp4BxXQzOBXls9wU?=
 =?us-ascii?Q?7c0roh4+TmaprhOH+EFonI0m+sJcWeyzbuL/4L0/n15wqOt+0U5YjZXEsjd8?=
 =?us-ascii?Q?++Tndsw5TyGBuNopKgR93HWuv8dKePPch1zjFkDoZ/Y2I+0aoDY0PLOjO5U3?=
 =?us-ascii?Q?F218ORjqdZEheoZEEitzR6IFuJwQgCistSBWfiClMvJYXjbTN5u6E1E9EuTU?=
 =?us-ascii?Q?GRvZ3lKQbEzTo0f20F/NTO4vFv6SrpAo4BAvUG8I5L/pJKfZd/NAo6LijudZ?=
 =?us-ascii?Q?d+YEMnNrlHCI6FzTz4wRvLO2Hfuob1mLIpF9q+uSP3hiU/dsh+dStAsbhrFB?=
 =?us-ascii?Q?o2IktRUqABjUEhiGBa+hLUIL/aAnaNy4kRW80YKK7ZIrJQoiT6a/5t1NcTtv?=
 =?us-ascii?Q?VmpvYhG64OK6g0rjiPQCyzeC74g0qdwVr6pXW0vIkoNsjES7VRWmQl1rEygC?=
 =?us-ascii?Q?K11dpF5f+K2P7Y3pb5/pQ6NyR342OlSHZDwVterWYVxY3KafCEXSplwMNVti?=
 =?us-ascii?Q?9bEVEjIvojLmaperzovfM8oDmZfVvn2tEKYT3bV/gOEm/JcTeAfr5WjdeA3b?=
 =?us-ascii?Q?6d6BJDn4SGQujgjybKKcZDmhoYTGMivelHOf7jZjJV9GkMj+w9zjP6WW16WJ?=
 =?us-ascii?Q?wpTPASyxsBj6Pmrwq31xT0tVKtntYkEGObeJNdRmqH3NfCDAQKhhsIxrvtil?=
 =?us-ascii?Q?Vqlam8QUr7NVs/YQ34qww80h0/lOGDsGdJkdsQoPNiD2pI7S8Xw1yTDuVHFd?=
 =?us-ascii?Q?JcSRXmmhK520K0lkvyZUpj+ychpG6UUiNMM8L8XKYJ4DDRwtyt8eLuBknlCU?=
 =?us-ascii?Q?KFTggk/qItArB/RPI8E47NN4bQwTMXBphpJq0qvXQbeJbH5gm5/qtPEsyctf?=
 =?us-ascii?Q?kXWukteb4RKlyGJlNZsknajE7q9h5/ae8MB67vbTlNhOTYX0ev8LF7DOButm?=
 =?us-ascii?Q?B5Tiw25wnNFo7yUpU8RWtO5QTI0u/rrFWy8LC1j33ev+rSHaXKa/Kb2jJFAN?=
 =?us-ascii?Q?rJ80VGj9eX1L4rerrQH6MxaZloBam5E9WUWvbIpmE3o7frlPcFEp?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3DA822206DCC0B44AADD5C8C17F48423@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cce96e-ea3d-4c29-5767-08da4ec28464
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 11:30:57.7980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Lp52t7tf8Z6wPCOfmybcd9vIarhQlJR5RX6hABjCm8bM4SR+dUkTpccPvIWcUksCNMokQTDdjPPOEceW3M1P85TJWLMftL4L2N4cJuILDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6883
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 14, 2022 / 15:15, Jan Kara wrote:
> On Mon 13-06-22 22:48:20, Chaitanya Kulkarni wrote:
> > On 6/13/22 08:17, Jan Kara wrote:
> > > Multiple blktests use wait(1) to wait for background tasks. However i=
n
> > > some cases tasks can exit before wait(1) is called and in that case
> > > wait(1) complains which breaks expected output. Make sure we ignore
> > > output from wait(1) to avoid this breakage.
> > >=20
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> >=20
> > Please note that Shinichiro (CC'd here) is a new blktests
> > maintainer and not Omar.
>=20
> Thanks for review and notifying me. Maybe CONTRIBUTING.md should be updat=
ed
> to speak about Shinichiro and not Omar?

Yes, it was done, just a few weeks ago :)

https://lore.kernel.org/linux-block/20220525020424.14131-1-shinichiro.kawas=
aki@wdc.com/

--=20
Shin'ichiro Kawasaki=
