Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF85C05027
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 04:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBNE1Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 23:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBNE1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 23:27:15 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CE5EC42
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 20:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676348834; x=1707884834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2rgECXJaGxvynoQ3lhZYj3Fg3vXMs/O6hcwz0zeoF3E=;
  b=CQzyMRuG7PyUkuopMmRz7IvfLgHlPRKL8n1zcRZ6Jry/tK68MWSQuRqy
   E2uAfbS74ct9Im2dFjGGTDQyokogFWnGKdNBpGeWh7kHr02mSPAR+6mwR
   YSmMsjiWahV5SO1223nqVdWeIixO/+pxTZfXFy6SzVXxir/OFhi7iUUMw
   Bkd1SByD1ZqzKJqSmHzrrEEnp/kOc+NTpTVDSKUppWhmb8CnPstMpR316
   FMAc2HMii2g/GpQrQFBLf1ivv9N+C42tV0zYkBvf41MPbBxNirhXiSFkK
   TIdAgpVxYu89KzIT54t8h00kovzmVV3xU16Lz2k/XYCA7QVbxSo2X2NNN
   g==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="223260669"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 12:27:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cInJ1M1GjVQfjCh/m1f94gZXTsNXVoJ2zacUI3sMKJ1bopRaVn8zFznMilFI9lIbpupziMBbcr/9PISSRzbiTaqFmzS6XalQTlws85OqnZmL0qiZ7I116Do4LyZ9087pcHj8fSKblxRkXQgpg++Dkkc9Anb5hr3x9BHWS1X0sUqSUhIZ+YqBfYYnG4YHQTXW26QMKNB2cgsvV3vv2OKLtrna/2qRSOML/6j7R7VwMGYOGkTdTvltukFDJeosgE/JBHY55ZXEH4Ito5ywAQgpE4fANC8Afq7IGcIOZsRjjJfpWt3WduaTYiuOB1YTsKAQ43avSD/x3V2/ulqw9wqJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rgECXJaGxvynoQ3lhZYj3Fg3vXMs/O6hcwz0zeoF3E=;
 b=GyE47go4wLMmGDYwqWaxW5SiUPA2RUtyoEq1FRGj9CIhXCzrIn9opflmpm1LP7pIgrTtGERoXGGDkZIsJRLM4KSVcFBJz0DMsXQwlIf+3Z7Kdbi/z28gLZKm+RN6DRcBHG98XHm9Nurh25IY75dKiOWp50SvCluhu6DDciXeSMrQZLTilm9yN5XH0VWAq6VWPaKyccbN5xXU7mNCsJNSEP+aGVsVSSl3b9yLa1orNREYQYXoKaavH0I+roFyPGbrqUzQyJOlb8LpaAjsefyOIafz+i7BwjHYcOVW2orwymVUvoFPh34Vn96VDiBN7ELH00DniN/abtaW7V1U0jWyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rgECXJaGxvynoQ3lhZYj3Fg3vXMs/O6hcwz0zeoF3E=;
 b=rFE2abYHFU+kL01ftRpnF8ByOWvfu5R3UfHkegVVPUoCEqGNC25yEnXn8avf9OYhIlhzmu2SXm6v223Hxntl7Y6XhD0h+CrGh8Zqk9pgemtjzmCO1aug9jUqIIBDtoXq9DBQWWRPIJn+K3w/c6d0PQ31/muiZvpRr1+EFtsfNlE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5960.namprd04.prod.outlook.com (2603:10b6:a03:ed::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 04:27:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 04:27:08 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2] blktests: add test to cover umount one deleted disk
Thread-Topic: [PATCH V2] blktests: add test to cover umount one deleted disk
Thread-Index: AQHZO1kRlvP9hv38mkyk7oBm1VzUhK7EqiyAgAAA5gCAAEN9gIAI8/CA
Date:   Tue, 14 Feb 2023 04:27:08 +0000
Message-ID: <20230214042707.4utlpmecsyfagkhr@shindev>
References: <20230208010235.553252-1-ming.lei@redhat.com>
 <20230208073911.x4iwd4iq5i34xnrr@shindev> <Y+NSYGJBoM8Oixa5@T590>
 <20230208114357.nzoocdy4uzolcfij@shindev>
In-Reply-To: <20230208114357.nzoocdy4uzolcfij@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BYAPR04MB5960:EE_
x-ms-office365-filtering-correlation-id: ee73bcf4-0edf-46d2-7dd9-08db0e43bc2c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zIVdVhY1hJDgYx0tcn7yFpYqjQJHoTYdGR5QU8MlGiXnr1Wv92/t9b7U/vy2QGCGzta16260F+1zsgSuttVzDbAc7/y6lKHMv6JV+mcagBOD6Wtb9ToF3QPy9plTU0LU6yCpdwdhDRsDYW21fA8CUg13YMvYx4LB+bZkQDyxdJEkYQkl2rQUaZd/SanvHWRsUrMr/IAhpVhpewoXuLkAdXzbQx15U902U9qV3pCtKS6j7yVODkSzvH0JrUjQdUOhICFdWp/tG2CF04rw9Hb8dUIQqGO5OjrCahVJlc7/pnDAE3eR8tAKFo+lc5Cs6E/pAXMDgdf9jSVQO2ow/+w8Tcyg0EuLHp3Bi+ixYRwXl3GPtEvIDUSvg737CFhKwcp8SFuar2F+55oysOIPTIpVAjyyNcmyjdMo7ndJceHxWUbMmosgHsS4KMgpEG6sjo/6uyQPbLS6i0s6QFHfgXamaBT8CQV9NYY+FRqZBnkOvw8XR94cwZZLzGxKK0hR7wc79KAuhIUbtKrk3VN8oS4c9YswT0giFntqqsjKNBCfdapBZWaZh/NZU+LzwjRM/1cbAMotQujLGME5HUfkLRCkWnmAgy2HXcGqFfVUp8rXwLSm6bLaSmybIDAQRIK98CIcRsE/Artgwft4vOjEqbXOWaX4L3G0cFX85Lbom0d27DRTP5MPP/89erRxoNScV8RLhi/LuYQjsVdfrgQUR+ewHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199018)(91956017)(66556008)(66946007)(8676002)(64756008)(66446008)(66476007)(6916009)(4326008)(76116006)(38100700002)(5660300002)(71200400001)(82960400001)(186003)(26005)(9686003)(8936002)(6512007)(38070700005)(33716001)(122000001)(44832011)(1076003)(558084003)(86362001)(6506007)(2906002)(316002)(41300700001)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oWkgWE8+68fPa6lh+Cc5FTQEpafel9Kj5apHw6Hh9WoeVGurobCO23bZPvqi?=
 =?us-ascii?Q?S9+YSMbONAB6ut7uGpu95AeJ37AK3Wbnj7QRT/l3az/2LXXo1UFblcYjI8dN?=
 =?us-ascii?Q?HBjrZusSFBYIsTguzOlnbSOiAXU7H/4RnZawz5Borpn0hQkWQW4STTvW4lyo?=
 =?us-ascii?Q?aYj/IeN6r8O8A8FSv4+qwkayD6kD8wQNHbW6XSghM/93Smp6as1YpORRmSvT?=
 =?us-ascii?Q?8rx8Hv1nY/bmXFbCj7k/F4tf+D9/yOWFD3QO19NVVizy+rZOTZ54WXLrDQIR?=
 =?us-ascii?Q?2ub8uYQcx4VGm/PcYV9CWrQFnLIfZOaLAqeqIPKBzCD6ejiQjvyzIO2UOE2E?=
 =?us-ascii?Q?tmQe86RiUuJB/rp88ixCJ72j7KIRBuv/lbe4GdHmq6J3pYHbblve6ZCgsbnQ?=
 =?us-ascii?Q?R8Qk+6BHx3tAKcC5SygVOH07LBx4BN4p6KuubXgjBE7u+McQ7Hkcrkk9fMeZ?=
 =?us-ascii?Q?uyak5xnqL8QiCBF31HSbMJ6snrEVyDYTp+O4mwpUUOpKxxm2h6KpEZt6WL76?=
 =?us-ascii?Q?hIXyucTPvNo3ASTgZcIQIjCIomGoDhUpQdrF2jD8SlIuVLKIVzq39vGgoVjm?=
 =?us-ascii?Q?N1qBywHxaKZfRY0wORtJXlonxC56gFlYeZCKHhP7iFeJfRn+MXQgM+0mmXOG?=
 =?us-ascii?Q?lHwf+i9vuH71uRcIYPTTgYrtNiJ8vGC+zteZNJ7Wy0BNUoZKS9HFPXiv+zyQ?=
 =?us-ascii?Q?cU2ey1iTzQregIa+tAdsxTOXo3r/L4lPBYrR9PVhLPQK+x4OBXl5wb6m7GRv?=
 =?us-ascii?Q?v19XQ/x8HdRkyxky6dfYW1u+d+FNTypGAlmSWWCWcjF38TQlTK2nW5Lmj4tY?=
 =?us-ascii?Q?dgtt0N+OVvjXY7xEe2qJtegTZfUqBjlrwfswTSv4+1uxbtC+ChrQzh7sj7Vy?=
 =?us-ascii?Q?CnrA49Qk3Nik1M9FiXisN8gPi1m8Pa1N7lQpwlmdGwx+rfWC71zCFAQa10Wn?=
 =?us-ascii?Q?huJi8vUK+vXDomhgK63Q8X56cCrd1iBKQG88q7s2uyJP3WgISd6TMl3doMM+?=
 =?us-ascii?Q?gu7qtxFA6bcqspLjz7o8RuyhpyPClp9Ec60Mqj3iZv9xLkh5G/blfKrBBo7N?=
 =?us-ascii?Q?Iu8L3f1nXgGNDQdW8WFX+UOMqqaIEmW2xGjnNfg274PU8D/i1nGm/ie6YSFh?=
 =?us-ascii?Q?RYFXwesCAQzH0Ync6lt9e+NOR3dS6a148ZYgfU5vHxOSAdAesH/QqtkTvxmN?=
 =?us-ascii?Q?QFWCbdgLHRBrfhJ50g3JiHbuBGe8ZJfSO6tWpnv4PTI5Ccjcn5Gdkv2NA30L?=
 =?us-ascii?Q?rtCa+MenOgYPia1sSoydGbVRkxfiezpMkCVWSIlktx7xGAcahxMa3sriaxpn?=
 =?us-ascii?Q?vSxM00EgcwCl3n70+d+exV2/ZyWFW6N2OplOJowD8NjPTA4FKx3tQ5BBATsN?=
 =?us-ascii?Q?0OI7SWzg6dpqjSpTR5Dut6sD17/XpOAYDEFpVTSVS9VTRGDMld15szK+ZOaQ?=
 =?us-ascii?Q?Kom5rPAvQdaWshC+kIlWodZQWZ/6REppfJUkFRGFC46HjJdj6UfphBNhJE9g?=
 =?us-ascii?Q?+ijqd8Cospwn2jIzhaVpHiWt2b/IcKTzMjS0KcfTegygBo/OISVJEncT2zEi?=
 =?us-ascii?Q?2EGTY9ZwcmeTUnrlSWoLR7UmMGod3VYF6PGMEFsR6PlMYiVq/T9ZDh7M+6iE?=
 =?us-ascii?Q?gY9qsWZfzKTYXlFb+5xFHOw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <83E57D732CE12841AD41A537D6F08AE9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: njbNYEchqkmmTsI0NpOGqaHWjFPqiHhiSq3b6QDnDvLy5ZM6erYstVPi6IZu1kFIwSUnpVh3cuoSjhTOp0C8l8rM9P8nOqJuhLb3yAWhbK0dCl18OiDxsIJ5k9ef+rhWHnXWMtQSg7t+b5f1ImUs0TLCIFtih7uPXdND9nXyDGEXBicJjKGFiqRRTZHsXA7UoG6CWnpI3BU7scjCuzbBTKahV/njt70vnGvl+3ztRvlIOGryoaOeWAJE5UqIbJTqokYAILbZV2pDKQy2/318WOSEz2Ta/MiTjvg72o1grM8TqSi4hxfARS7Eq3iaNtPl92nFACP5IobH/4/TYQ1uAfnk6tnf2TX0vLdeZa6UGHJYncyUzpJZ5oxiUXvhoTjvPISgLkgpdveR+b4cEzqOk+as8XOJfcQKzzP4+R07TzLgJpULqD2jAAtFZO6D2FB5ZsWLBcF5S9brpPpXY4KAzqobEDq1pnMyux8gI9jKeqo7mq+18R60moxMrVVVrFAsW/ptZxKpi0LYk3llOfsbzXIPSuC65BcxHQpsMB4cl6Ck4MblmV7Jp+EKKkdXAUo1HbpMy3r9hZ22Xj12uarbxycrVW9048xlfgyUACzKEdVm5noU69Uu2vFT0Cv1tyqNOqvZBjsfe3Tb3IOCKR00Cb3jGhSPL/dkTBorkLW89FmUwVCONUDUQStEA06y0Wn8yN1+KHxWNABdoWjuNw2yNhZInHComLbmnpyaR4CeRWKC5dR3pRAT6yDZDm5Kn1gI4FVsWF45bSI3IZsODd3SAvlOwcbJMOY/3n7zbmYaud/xOavjgawGxdP1nQQ1eP+M
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee73bcf4-0edf-46d2-7dd9-08db0e43bc2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 04:27:08.5062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtCE8BRamSIG3PQyUKEB141zJt7z8L35ilitoE7+TFLIWJ9KSKpklPqAmI6xgdcAWTC8P0p/GRpc5gI9NMlfaGhENRkEFmrvbcRXJGPUh7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5960
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've applied the patch with some edits. Thanks!

--=20
Shin'ichiro Kawasaki=
