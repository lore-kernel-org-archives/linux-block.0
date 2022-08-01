Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E83C00140
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 01:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiHABao (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 21:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiHABan (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 21:30:43 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBD42717
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 18:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659317442; x=1690853442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p5q/nQjOiCr+pnRLsNvMVZcba9qj318KoTQ+BcBQGRM=;
  b=m7QBBUqbf6rx9sDD8vXoJGZeySHOTh16kmgjA+MxzZp6uBM+6HLJLkno
   clf/7As0TcTkS4DDpeThlq2ClkgBpfh/uhySYRsV6BX+Ma+OgIDGjImaQ
   iFC+Qf2BjFApu5NRR41TGTZzz8NceBO0Vq9R+WJkT8Fva60rhgLyOPSZS
   GukrDwQHqZDmAcMp2HFLVc3IzUbCBC+A4wFvIa6B54+liF5YyZDceQiNR
   oNdTFuABMvCahjKGFFoNRXefTDLFIJhtXNTHrWM1x3dUNt705oaR2+Oh5
   D2Pgq7ySrx9Q9b02U5/3loQa0UMudt47SRLRD3CRxt9vh+TvRWwHjv69C
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,206,1654531200"; 
   d="scan'208";a="208016428"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2022 09:30:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdSc4zxoAuRjDxvfPaJk0maLG3mfn8YJTEv+BXIXpxlsgnLv7SmUwSJ0lpGeyZQUHLjYeoJxTJUnjRxk4gpWy1KdQoP50bVW62XqTBHGKDEe+PbVEWq5ShA3JJQjkR3/MzAvQLIoH6w1KJHWj4ThXxc9MMxgeLaTA/kpEGd6JkpCZjUzWBpLFCcOTG3XTTR6XmRrFkahN+hqlZOJ08n9/paovLvltlq4jmWdmAgstj2lw0Hd9CqiF6aYD0Y7E2ivqvyF74Kkcc4J1E90PdrM6oaIpxK2is8LRNfysuZxZB4uyreB2QNmsrxRkSdlsmoWr3TmI+C5jE+M7cPzE193Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHdq3xZ9D5eHdz4MrrmKRnPBlwMNu78IyJXqTTPw2HM=;
 b=Jtv5m182ffEC6hchLrrk6VqlolYticcJbazFSjr3Q32cFll9sK+YbD4oY/BfF1JfsvcjjJEAyFQYcTkUQbaZ1sLGQVcFhcxG4JyBRho/WqY6XexvSar/Qrht49m9cG+DktCisDNE+ctgqW+UmMzNFA3HjxOSiaNRZ3jqPAQlEHGOxHbpf2prK9eYlQN8l4Q27VBzbCWQnWks18QTRVDUr/EIMaU2UAsJzyYD5lfm5UN5Sm0A3ZodLCFR/g2HivtzgVxallg+twzyo+pJm74Tnyr8S+hrG6CczNqFioNM6ynRpx3QdCyjP+uPRGuBn8gl2Ek07ynVnSUg7rk0TRl9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHdq3xZ9D5eHdz4MrrmKRnPBlwMNu78IyJXqTTPw2HM=;
 b=YQxwm7dZU6doxf/U0B/ZhWFJdkj0yL2x/qO7M2q83gictV0rTN5CGN7/TFuzWy7M7GBTUg3Yn9ytrYNAUFrKMfqL8axABPNciQ514zpy+ZCcv7+rg+3pP0L5dIAn9oveDyElYvS/f9FacOyYoAubo3O06hqtFvaZRF6Yq2FNL3Q=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB5922.namprd04.prod.outlook.com (2603:10b6:408:a1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Mon, 1 Aug 2022 01:30:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 01:30:39 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v2 blktests] block/002: remove debugfs check while
 blktests is running
Thread-Topic: [PATCH v2 blktests] block/002: remove debugfs check while
 blktests is running
Thread-Index: AQHYo+o0sdmhJfeRdEa47cP+ZmaIU62ZRMcA
Date:   Mon, 1 Aug 2022 01:30:39 +0000
Message-ID: <20220801013038.y6napkax4w7ua7jp@shindev>
References: <20220730075828.218063-1-yi.zhang@redhat.com>
In-Reply-To: <20220730075828.218063-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc4869dd-0eab-4975-7efb-08da735d7100
x-ms-traffictypediagnostic: BN8PR04MB5922:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ausSmorSjmtO1HvxdlXM0YjRyoPAv9d5iRNG8EqqcyK4BSEZMGfcGOJteEyQdhUJrNPbMhCpiy5E1Sy1tT3SYjWTK2mUdP0hGXGtBX1GyIJjQL/keCARW1BsLddOB1rxWsBKee4c4TL73ljjrWpAuWxheoCoe4ny+fX1DqhOIRJgXjTV/Fdu/APc4thZO/qi6n3QdZK1OWmcvEoH+PXVi+nMaKlbsftgECDAPOzjY/WbBMcJ8FndLAGpY6FMJAHs2KVg3HCmzBRcAINO1FbYstYDu4Ve5SdW3DJAw7ZA53x9KVibLNwm1pmZhtcnla79t+VXPNoEitwsgMiIh8Fi5yp0xr6Z1qxHEygIkpkvXMA6TQC6mo23oy9ETQZoxFzZsdZQw6fWJ8VWHlqDoNfi7AKocR4yHTGXwKQVa0SKI3aN9t57lO9gWyZZ5EoX10EO6KQQq+TbbeHXXmPtFJy1ar1kmcoRZovDXkyNeRdpC4MDYJMMn8A6sXxNPwZKAGI636moFjS0PxNUyZfW+ws0Hw1EItOJQoHP4CM/kAqHBgr+yUGKEFmjNA03k1737doxolBzmWzhFLoS1Y8YGkAFyW1mjX5jpDAAHmbKvTyiZ8VIKufA+LSaFUupTgzvzTcXTEpDuOLU9vOCqJAgH3xSHDacEeg4pnuwYJXlmMp00DjUVuq1AJbLMtAMLGd8uumcek0Iy3LBfetWKcJiwohRcWjbI3WogEzQzrIODt4NU1LGmJl7H6iZ22DcxaroJelntShBhIcBDt7WvvCQkRdW5lDY2dIx2c/ZE6F3hlJ/FH+3k/jrNzNHMpEBL3n8bS7K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(83380400001)(186003)(1076003)(122000001)(38100700002)(64756008)(8936002)(44832011)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(9686003)(5660300002)(86362001)(2906002)(91956017)(6486002)(33716001)(38070700005)(26005)(6506007)(6512007)(71200400001)(478600001)(41300700001)(82960400001)(316002)(6916009)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Td4ZrQ3nx5gqwc+w3+3+8beUK14EOl3dgxf5e0fDU4HKnR1aMQYRgdHxRgcu?=
 =?us-ascii?Q?eDL/XF9ci6efD3g/LmC9pm7qwvN5f8fy/jmaEzB6Ahm13+DCyoO1NVbwhl+f?=
 =?us-ascii?Q?Cv5WEFuU7nYs1NncINmxDXbtTFfNdOeWsR1VFP3mh9wBUEeCXUDNrLaok8G5?=
 =?us-ascii?Q?ybrGKNy4Ebfy1kQByiF7u+QY7aBbkrMq5OFzzZMoCm1XW8Y2EbUyIcrjyG10?=
 =?us-ascii?Q?/FrLZQIOGvjbMG8qu/68xTIRmPFw48J9WYUHUxSjdAh4ntR5PVTPq9s7H+zp?=
 =?us-ascii?Q?/6RFUb7TTtzr+u3A8EEA7pK5S5EoBevi+g2JiCu9Uj/R9RDJkXSMS0835NBs?=
 =?us-ascii?Q?U3jMzHY8iu0fwYlH6wL+5TTwNkoW4PzPwjaDlzh8AUpgiCL62TUzHDU8G3PX?=
 =?us-ascii?Q?PdkvLFii3nHMqKQzYmlyfqot+KwXduO2R3Ttmscq4hhf7q34OarNFZrS2NDO?=
 =?us-ascii?Q?BW0+iTUV2nAL3T0S0ZbTPolagasdzVKo0RycyCiXQ8ksl4yTksYh2fQM7ZoE?=
 =?us-ascii?Q?bMhbZYH/q7i28XtALY3Vsi8bgLBPW3eQDdFlYGCUlpR6KoebkHPRtRmXdTA2?=
 =?us-ascii?Q?zBxkNh+8drey5u8uYS2+mZHI1kwyrvNqWQvlB5YaCykU5InGPOc3BbZnUDu+?=
 =?us-ascii?Q?BkRnYQv9c169ldhaEqxDT4G3CH12+uRTxY6MMkxbVckvAf2IVmxW12qEIsxg?=
 =?us-ascii?Q?MXirt2R8fB9gTsRN4RaQP+UidJOVl/i1oDVwm90MSqkR8RPrJcDalq9QaQ1G?=
 =?us-ascii?Q?mjIp88/R8pFqbekfVILP9WuB7hEeo/1AUhbtkdrQuvdUpkPxCPNWTgeE8hS/?=
 =?us-ascii?Q?Ua9O0cuAoXdAj6ZitB0DEKifsMHccswpLraXCCCkomG9kal8bDHYijxwGHP9?=
 =?us-ascii?Q?xMY0n4SIJtzrDDZDLwpZXA4pmIoHktymSuh0YTAjjUHZvwj1LbrFVApc8jks?=
 =?us-ascii?Q?pouEDF3SoF8AE9likLHeOwkAm7JYDExsapWAByYHTBg3Bc/mk9zDOK8SpFK4?=
 =?us-ascii?Q?TuahbxM2Cw8Y9O9aXzs5JZ6gBivMV87aAgO2Mo37cF84WST2dF4m3827Fd89?=
 =?us-ascii?Q?5uxLpLRfx0vnilasZhC8hxL4vuZQWYvrS9lLzpeGjM9wZgye/fjbgLPg39UW?=
 =?us-ascii?Q?BwjW6zpnmagN039pAm1WCncKUSLygusUrggBSgb8paSDbS8lnNE9HgbCATJt?=
 =?us-ascii?Q?cPTOUS0PNRcYsLVgUPtzejeT1Ayqmotdz2AWYm2+EWqqyH9rb+gsZCSFOgNT?=
 =?us-ascii?Q?UnQo9wFppcOIwJUYKKA75vntY2+BdnYknNegYZ8P07ManU9P3fhjyzkvNMq7?=
 =?us-ascii?Q?+IWx25vvebarMDSjtnZG7NgVViUZb5bpNdcCCGkuhbUoafMfCGXSSii7a+po?=
 =?us-ascii?Q?2KUiHvQuU2xSpLnaRUNgKOrLcgeJKWeiwORxaqzWA6tYN+51VCljx4QVq3SY?=
 =?us-ascii?Q?/F7Wi3yi5YW0KTkyQ49fW/QaCkmxYubO0tqybqW1k2Nbev/IkUCfUfJGB0oj?=
 =?us-ascii?Q?dSZEFLV/Ma+h2FgZXD5x05gBu6tkhSZM9ldsHsYn4SU4ttMUFF0wlX+gP1+Z?=
 =?us-ascii?Q?6OF/qyyj+eEjAqUmc0Ih/JPP5r1ezOKBDqGSCrcAD1s3+wIDYaEcOcyDnj9T?=
 =?us-ascii?Q?Y6zZjlm1au+GdRfLiKd8i5w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B93060D99132234C912DFB2F0160B953@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4869dd-0eab-4975-7efb-08da735d7100
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 01:30:39.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODlh9RpT173/ONKEkdwaoGat3hKrkgrPoQDXdnFZp7cQnl6H7hrfxsp79qyLgPUG1NJsqxXd8Ln5lIh5m3uy3EzQ+lJc3C3cyAkbZxVNCzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5922
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Yi, thanks for this patch. I've been seeing the block/002 failure for a
while. Happy to see it resolved.

On Jul 30, 2022 / 15:58, Yi Zhang wrote:
> See commit: 99d055b4fd4b ("block: remove per-disk debugfs files in blk_un=
register_queue")
>=20
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/block/002 | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/tests/block/002 b/tests/block/002
> index 9b183e7..15b47a6 100755
> --- a/tests/block/002
> +++ b/tests/block/002
> @@ -25,9 +25,6 @@ test() {
>  	blktrace -D "$TMP_DIR" "/dev/${SCSI_DEBUG_DEVICES[0]}" >"$FULL" 2>&1 &
>  	sleep 0.5
>  	echo 1 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/device/delete"
> -	if [[ ! -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]]; then
> -		echo "debugfs directory deleted with blktrace active"
> -	fi

Regarding the commit subject, I think the word "blktests" is to be replaced=
 with
"blktrace". As the removed echo command above shows, this patch removes the
check while blktrace is running.

Also, I suggest to add one more sentence in the commit message for recordin=
g
purpose:

  This fix avoids the test case failure observed since the kernel commit
  0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt").

If you don't mind, I will do the edits above when I apply this v2 patch.

--=20
Shin'ichiro Kawasaki=
