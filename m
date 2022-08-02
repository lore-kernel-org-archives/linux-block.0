Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00885C00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 04:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiHBEWy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 00:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiHBEWx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 00:22:53 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B620727160
        for <linux-block@vger.kernel.org>; Mon,  1 Aug 2022 21:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659414173; x=1690950173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fq52MrHTm7+swkM3ti8bIq7l/qU+aPMvDoBHWeUNJrY=;
  b=LAVouvEvhusY8krVEoESFFN9TpkQvuDYZTD7oA6E+Cu97O9rUJGsMDEN
   cBgkpDNlnKPivQ6OSINukibWqHWkDcXpJyr7bA7hpfSur9r1A354fqXxE
   tjoTnzBbibQmvjwa0cSQ27+t+OpNHyfFQlU62z9etz/CbpFyBhglGmjPV
   +wR4HRQZ/ephUbQN0xbonvkb6UV5YWJ7PTLUmdQ+qagFVdC0TQIQuSg2W
   kntRVHd0sNEx6Yvk2wDIiWVE9peCSEcpoWM84/QhSQx990Vf8yi/DhHNW
   ItIkWRLbam+wIGYJ+UywfIQX4z/+JIfpFXRu/9zkKowqPS+uD3w+IULvj
   w==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654531200"; 
   d="scan'208";a="319630487"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2022 12:22:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUZUvYuttLNQlWxCBUD/o/ruxkOOc4a/LsUN3H1G0zGxcE3xdQqNCSLbjRY9uOKyQCrGkEXpv503eXzcJrsAPLFxpExx513o35lI2f+6qeKqcsV6CkrHjn1Z9LeAWiUxn3HPAsYmqdjqWmJppljIiBNQLa+5tNkIhK+lhV8uxZEu58VxGs6Dqt6Qq5GLSQK0tmOl0fBl/EHSGbWYwoBhFrdUDvbT8Uyb+EgK1KpGFToOCULG5xUeypGgHh47fzKVOsrsJStO2Nkvtr88144WzkIGodrd2L9O/IbIvhR0opwneRCoad43lR2F0RuNiPBh1OOE1O+04OT99ikAy+MOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyuNuMeAbLHjCh7pdB9TgtYRkTLT1yqoZzyL8DAz/Ck=;
 b=F9ZG1eDy2MeZTE9uWK7Xsxvq/NHInFXVQfDjUdGOKwGx4i9BSCS+gTiLal6fZcJnSuPdaJ4sx9NQj+AUHslJmVOdNFOZA+xxlqvI4hcW7jcc4d3E+3jq4dUVvp58tWWLpioYCpC62/ZFqNgVlBfzMx6JKosyoO7oENztDmycyzt0TVaCTERKK41vBS1vyYsTVG9RIe16J48lEEvMc981FxfXq7Mi6jOL7S3oZKQamariYEqVLj8ZMKTQIBoKCdD4Y79Wu3uzNfrukJ7JZtu2Ls3TuKVglk2bXR8EouGHAcBLZ6l/lGICl15BX1jdycq+NaVlWI9qWutAatHFK0aegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyuNuMeAbLHjCh7pdB9TgtYRkTLT1yqoZzyL8DAz/Ck=;
 b=nlAIZHeChQNcQYR9mkCKLDkxDi9b1a6wDoqQWpJOrBZaH98dcDgxwSTd4gI5IPSVb44WG6og3hRrzDNRqngmB+ykNqgWH1OpJNtYgs2qpPYUsj+kYqKWYVdfkl6Q1vylvihFiwpd5bwbZNOudv4imxratWwE44sQmO+70Q31UyM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5334.namprd04.prod.outlook.com (2603:10b6:a03:c8::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Tue, 2 Aug 2022 04:22:49 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 04:22:49 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v2 blktests] block/002: remove debugfs check while
 blktests is running
Thread-Topic: [PATCH v2 blktests] block/002: remove debugfs check while
 blktests is running
Thread-Index: AQHYo+o0sdmhJfeRdEa47cP+ZmaIU62ZRMcAgAABeQCAAcD2AA==
Date:   Tue, 2 Aug 2022 04:22:48 +0000
Message-ID: <20220802042248.zcxuod5jw464fq7b@shindev>
References: <20220730075828.218063-1-yi.zhang@redhat.com>
 <20220801013038.y6napkax4w7ua7jp@shindev>
 <CAHj4cs-paSYG+Tb5sLYweSMJ855+Obr91WLzvfOR84pSiQgCEw@mail.gmail.com>
In-Reply-To: <CAHj4cs-paSYG+Tb5sLYweSMJ855+Obr91WLzvfOR84pSiQgCEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5271674a-dc42-4bc8-ca60-08da743ea87f
x-ms-traffictypediagnostic: BYAPR04MB5334:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UEvvJPBKl+rfRQLU9yzPBFBesnqLXv5dYaCJxecudKfYGyhFGbzwk3MinYC4NPe60iu6BZE+80vRrwtJnX1o5i8gagOUnoAGRzo6pG2eZ/GL/rKwuIbZbHGr+W+vbA7vxRGEo4h43AbryW46vJF0hUa7ms9voGpFj/ZKfCfbcNqlvZd16beu578LDU2R6zhtTDvMPnJeh5KPvXCARkzXoM3BND6/gXaYJVCwl37AxDiFXOrZL+WlS+Juov6oMIJYayHRugWYHhn0RAyGfJIqIMS58w3mJTTFSm+B7qggVzLxlYizQ/JwmU1xbteFtXjUld0nBKAABWw2N9XAinsfq7H1lkQKdEn9QafOLACEBKVaL5m8Ym+enG+CVSiHZPt93SlisDJivAtOG5atyF85SzdfURQmeHleQID/+taBvavkEfjh4ZJ3oiP1zmAVEQO3dD0rKU5gKqn7PO+6U5V+2I3wBRBIgAXklzspeL10P0XORBiJ7S/swolrb3ek86+HtVuHI4noOOtP9iWIyKVCxVRBAly8trt2aiWe8MlzqhT6g+oAf3K5cMNrUGe0FVDj6m2nINw/NYkcbK01oIKv4p7PfmppeSg0haG10RK5RDTGk5Svbfjqm6BIHiwu+3wFZkyoFjn4+S//aFwCOdLkz1UI5VOtbegNQ/v9kc+Veu7SEyQUGAC0ukRkaRRQqCiMiiCZJN67by7I8/PBYMoGKo2T6xiEX97cAaBGGQfACix3H+t2S3HmkHXWufcoeECxRCklbcfzup5acp5D+Tq7IBb8EpAGvllvoiIGvTlp0jUDFZDlXKkDL6xHXzhlSou6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(136003)(376002)(366004)(39860400002)(396003)(346002)(2906002)(44832011)(83380400001)(82960400001)(186003)(4326008)(8676002)(76116006)(64756008)(66476007)(66556008)(66446008)(66946007)(91956017)(8936002)(5660300002)(54906003)(6916009)(316002)(71200400001)(478600001)(6486002)(33716001)(38100700002)(9686003)(26005)(86362001)(6512007)(53546011)(6506007)(41300700001)(38070700005)(122000001)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L1KSJUI5bZcs7KUB/7D9B4COJBoh6r+iGzezQO0iFCunbonD+G0AHsYb4DhC?=
 =?us-ascii?Q?KCeQCZwUKWIgjnaL19xdFavUctCoYLrRiFEdH1V5a/JF+P86i+O4/JUny6h7?=
 =?us-ascii?Q?wsWSEhXMZt3yX3iDoJyoPUrvq5fFzckbD5onJaEcV+vxigGgI83uzcvIRyFC?=
 =?us-ascii?Q?GtYk7vNON73Kn2d/yVRnw5OMtGI9F/tnIPecH8tIFiGo2yjU5O0uLPlu+dUy?=
 =?us-ascii?Q?rZzi6MGVhKk+zEQw8koZo99c0hio3+h613VTO0AJiamHVV97UoGRaonBxUVg?=
 =?us-ascii?Q?ND4kkhnSptfouBboEIKqExi5iO9QW6A73vH7AxmO8UEcAnU9w3vnPthu8P3J?=
 =?us-ascii?Q?ZaI1HL0M7A35Q+tfnOasc56M1u398X8rIy+HTM3PSem5VXdqNErqaDKw0OJt?=
 =?us-ascii?Q?CoUR/VEr8pO+QDNuq7Oe5Y+TN5QFuTR7k6BfJ0ILHDUoW0KcUu6tYgBtliKc?=
 =?us-ascii?Q?tnVprAUnKmp9LtAThr0uG+6D5cl3Lmx9EzFeIVlN1O1thrJFfTGmMrE2ILnw?=
 =?us-ascii?Q?hxKdPgs76Bnou7Wb3NpNK0w+dZpnONGpL5cUIuN11bCX4gFno5mK81Uy8PfY?=
 =?us-ascii?Q?M9TWLsX/LHSlObvMw+9H8DudrnUUO+V5tMfSIcQLPQVBrJSooltk5M9s3iCh?=
 =?us-ascii?Q?Hv5GCKhBUAVH1YSW6Ez6WukvcVVd85raCQ7pZD3JXEoEnfbp4RFWe7VxyC4Q?=
 =?us-ascii?Q?eZAjFO++k6RzNvKzQZhBu8arMR6bhJbELBHysj7OShn+AAHEudsA15JY7K7G?=
 =?us-ascii?Q?YDOwIdxAWVFxLmfdjMdSri1+GMK9fnyfeTdA/C7kM3QWKhmtFP3sdEAA2uv6?=
 =?us-ascii?Q?S3wJVqlmiME/lJd0CBfuSwokjZZINYCi7F4Dn4POY327yPad69Rz7Un9NPi8?=
 =?us-ascii?Q?e1G5bB5/bZURktuFoGMGzFJVWab+BQ+CP9HNb5YRxikCSDHcMKEOxhzD3Sal?=
 =?us-ascii?Q?ZddxCrzlrYpGqE/FC4qCdA/xzSGzK1V7u6BemPxHi6GUywxAHRaTnPpipbd4?=
 =?us-ascii?Q?gfk6BFmoutXO1jAIHrHZTRRa46oO+jxgaipjf1ZUNcxn5gnvAIHlWO5Apgk/?=
 =?us-ascii?Q?3w6xcmJU5Sg1RgR3abcYoYNN8CKdwb31rfu3sZ05XDu8gWw8Jgor2D1dgiTY?=
 =?us-ascii?Q?LEL3Og6XcrE+rhZ3NM5Yrs3l9P67cY6vCaVGLwpfacJ/YLTnKTsmtuC4rBvy?=
 =?us-ascii?Q?SU/TRJhHjoChbRro7FyTm8YWc/oRgPHEyLwiaANpgXp8GYaZYKDQvZ2GS0WE?=
 =?us-ascii?Q?IM2tLZvfN8XhIxD47oFSjwpbq274UIs9WAh4ErCCzg1BTKHB4cB26U6SozAn?=
 =?us-ascii?Q?TV8/rbPjC0kzzFRCM2HaQtqRPqaf9CqLhPS7WMgaNUXFd+9+htTSM/6frWdB?=
 =?us-ascii?Q?buzaPGNVVWYYro5SCp6WxaCNStDTosPk/pAlUU8ifweSPg8RUaEv0qPUPHkn?=
 =?us-ascii?Q?0GJPxaUzwi9dhNPTzhI8KslzX2Ov42SJd8TTDukX7IiVMiYM3FCyByhEfwTp?=
 =?us-ascii?Q?W4HHpQ8fRWAGWLe/JJkKNoXIMo1edXzB4gBQCUaE4iRVfuc0uC/IkS8DMQ6A?=
 =?us-ascii?Q?+t75GfuqyHvzaMKPFkCkd+XwuKiTCmax4UhJqSiK9IOXabxwujzIqd7dZX2U?=
 =?us-ascii?Q?pNbj2hfXfldTbAprqCSXZA0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B35514499B956B49BBF5B110A312D6E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5271674a-dc42-4bc8-ca60-08da743ea87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 04:22:48.9931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmJgVYsR2OATnQ+d1n0na9kxkXThDR7QPj9uIJnIkAouUFKiFFLX75guXDYezKpCBTgDsJcvfQACKizmjUHVg6v+8upknwCgBoWDEFhc3U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 01, 2022 / 09:35, Yi Zhang wrote:
> On Mon, Aug 1, 2022 at 9:30 AM Shinichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
> >
> > Hi Yi, thanks for this patch. I've been seeing the block/002 failure fo=
r a
> > while. Happy to see it resolved.
> >
> > On Jul 30, 2022 / 15:58, Yi Zhang wrote:
> > > See commit: 99d055b4fd4b ("block: remove per-disk debugfs files in bl=
k_unregister_queue")
> > >
> > > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> > > ---
> > >  tests/block/002 | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/tests/block/002 b/tests/block/002
> > > index 9b183e7..15b47a6 100755
> > > --- a/tests/block/002
> > > +++ b/tests/block/002
> > > @@ -25,9 +25,6 @@ test() {
> > >       blktrace -D "$TMP_DIR" "/dev/${SCSI_DEBUG_DEVICES[0]}" >"$FULL"=
 2>&1 &
> > >       sleep 0.5
> > >       echo 1 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/device/delete"
> > > -     if [[ ! -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]];=
 then
> > > -             echo "debugfs directory deleted with blktrace active"
> > > -     fi
> >
> > Regarding the commit subject, I think the word "blktests" is to be repl=
aced with
> > "blktrace". As the removed echo command above shows, this patch removes=
 the
> > check while blktrace is running.
>=20
> Agree, thanks.
>=20
> >
> > Also, I suggest to add one more sentence in the commit message for reco=
rding
> > purpose:
> >
> >   This fix avoids the test case failure observed since the kernel commi=
t
> >   0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt").
> >
> > If you don't mind, I will do the edits above when I apply this v2 patch=
.
>=20
> Sure, feel free to help update the commit message when you apply it, than=
ks. :)

Thanks! Applied with some edits in the commit message.

--=20
Shin'ichiro Kawasaki=
