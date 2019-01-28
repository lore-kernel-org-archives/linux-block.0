Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA11C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 12:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107212148E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 12:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BvDRjU8J";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oTtETXI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfA1MSH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:18:07 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:16380 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfA1MSH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 07:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548677921; x=1580213921;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ke0nL6xLEI5VGBflDmvWcJsFK7o5l7Vp0PMs50CB6wI=;
  b=BvDRjU8JvUs36zyD2Mkw/qi5QBMoisNNZBb/8vIyLx14sW5mAsjIJBxO
   z1hFyUqn6MudigNRmCGkobvyVC67Lp72zAgwE0nYmfKpclL5opTK18HOW
   0GQWtq7+x8U2gUg42pnhQShmW8ikcJorCN/D3RfRk0fV4TTn5Td0TL5dz
   /GGyDhhg5ZVrW9qczx8/cvJGg2tC4Kts/lD+RqdvIWKx8iWZmeXK39mLr
   ZBtsNc4avTECoENSZbMYdFhoPqSJZMv4Ntoz44AgGbhTtP5bASBsrcbho
   u8+24aLvCDlZzgGGFXBVxGv6nvEO9UoU9YszQ5aCS/Mzgsdkc7luRGuoe
   A==;
X-IronPort-AV: E=Sophos;i="5.56,534,1539619200"; 
   d="scan'208";a="198044497"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 20:18:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUV1gr+gIJZLXiXHdu447oNC54bP0vn2uaZeLls/fUw=;
 b=oTtETXI1nQHNCrWJYOuUj6u16dXGHcjXN3YI8oCJCcBDiSWdI9NfWEerl80piYSthDs9P6oPCyIvmdMDD7dHCFuWJ8VmYT5nbPPwHCxWgpLiOjsdZ3RAGL2WbNMoeWOVnriJpcKdkb4bsdUn1EfNwd7Q9D1StEERzzPzWDfUTxA=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.9.7) by
 CY1PR04MB2011.namprd04.prod.outlook.com (10.166.191.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Mon, 28 Jan 2019 12:18:03 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67%6]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 12:18:03 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH blktests v3 06/13] common: Introduce _dd() helper function
Thread-Topic: [PATCH blktests v3 06/13] common: Introduce _dd() helper
 function
Thread-Index: AQHUrxKLm34VokWSrEKGRiEXEDFdzA==
Date:   Mon, 28 Jan 2019 12:18:03 +0000
Message-ID: <CY1PR04MB22687FCA775E40FA427F73FCED960@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
 <20190118094453.13773-7-shinichiro.kawasaki@wdc.com>
 <20190125211716.GE26739@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR04MB2011;6:kcL39yDsioBo4xGzjUOc9LMSVRKUQNtKvoJB2nf7rUZT/8CXyesUvhq1qTzkB1JNY0hL1dbkEh9zeIHdfJEb8sBzh2H2sBLYyu8GmiMFg9vhHXmUUULsARkb60Px96QOG7Uuj36NSJjsikAgjNJhdHI8Dolw7fSYHqL6B92YvN9SjYTRnf1W4miwMp9ti5ZhJCJB/OHUebO2GkfqtughKWaPfImU8iDdLKz+XADO6XOgnGwap37eNuAFHbTN+e+oRo0W7oYvuK3lr2hH0paPPgVrh7FfGPndGncx7ip5tjUgz3px9Js5Ao7jDAZFJvhlODCf3P8KWaspMVhcaMyP2WlbhsvAIvf4HT2++K1WoejUlYvAoKEqb4h+XlTAPcqP39RAQQzAp5Xs/t62XVPbfMuOf14oqneiQ8mMntmp5Eky9Vd2Q5TvAPDwNbEaCo+rspk/IHf0HOVrDVJncnN1DA==;5:s2Of4orzAhTXZhfiI769x501qbx+Nvs8+lD0iCV12avBLCjIzbl2w+PFCDbF/UKdtrL+LpJ2jwdSaAFuWwsUVjTRWGDHm/Mu3YK72KyhABO6sIMu+t3GFWxXw5toJzrQ34tDZhGuGZPz0E/TnPF/NKxCV60+y+P9KKbj/69kfiAUKXJsOw7Pt92FWy0sez1H7rc67bcFlwq1o4TfX6Z/yw==;7:KCclV7GExXPSyr0XvqY8cO3hFYPMkuC1rRiDrwrSHAj3m2bNvy8dSRyKI+IqYqkQ7/6HoPUtz//LPZJ+fG1OKpcfbBmnb6v27zab8L9wAkHJ9dV+i2oHG7g+fOnI28d+Z+RwC1wZWQPCQzYLQSa5yA==
x-ms-office365-filtering-correlation-id: 69d7bd0b-3028-40fb-41d2-08d6851aa6d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR04MB2011;
x-ms-traffictypediagnostic: CY1PR04MB2011:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB201119E08EDAC16F1D974423ED960@CY1PR04MB2011.namprd04.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(76176011)(81166006)(81156014)(54906003)(476003)(25786009)(66066001)(446003)(8676002)(53936002)(26005)(305945005)(7736002)(6916009)(6246003)(186003)(74316002)(4326008)(14444005)(2906002)(7696005)(86362001)(97736004)(8936002)(316002)(99286004)(256004)(44832011)(486006)(68736007)(71200400001)(105586002)(106356001)(33656002)(14454004)(229853002)(53546011)(9686003)(55016002)(71190400001)(6436002)(478600001)(6506007)(102836004)(3846002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2011;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 66N8tZpvfoPebblcvCPJSMkQmgTpgDPSC43Qfy8IZXkGlaaddY90+Gusac86pthn/5jtjAacnuhxA9vvp41Ck0HVE/Q5CZDDt5wY7t/Llql1L+XzlsHgYeceQRMwMF8YaOBLv0+O5PpigRLq2mHBNFaE/4LEAUjHBJwr1Okkt7A+937ZDitoxhFxJSMK0ayW0nElMb7jenKMpaGijYjkoCCO79MXFXHm/blzAARrL+ewvleAnigOHxn+H8+DDDTKmsHX/1JoLq68neO+9PhWFwHYTmGh+PSlQyU+NCNEkkhNmD1FtX3LrCfeUQ6243g5ZfEqAX+oNUYFHYzCtq8DuU72wI8XqwLy7ffJjcGwacFX0TWStB9kZubSju4HlTLJPeQ63t8lr7BIAvnB4BXuRNYVDLV3ZZca6MOcHEWbrkI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d7bd0b-3028-40fb-41d2-08d6851aa6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 12:18:03.2132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2011
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/19 6:17 AM, Omar Sandoval wrote:=0A=
> On Fri, Jan 18, 2019 at 06:44:46PM +0900, Shin'ichiro Kawasaki wrote:=0A=
>> To analyze dd command failures found by blktests, need to confirm dd=0A=
>> command options. Introduce the helper function which executes dd and=0A=
>> records dd command options in FULL file for quick analysis.=0A=
>>=0A=
>> Reviewed-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>=0A=
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
>> ---=0A=
>>   common/rc | 31 +++++++++++++++++++++++++++++++=0A=
>>   1 file changed, 31 insertions(+)=0A=
>>=0A=
>> diff --git a/common/rc b/common/rc=0A=
>> index 153a323..fe0e5d8 100644=0A=
>> --- a/common/rc=0A=
>> +++ b/common/rc=0A=
>> @@ -214,3 +214,34 @@ _test_dev_in_hotplug_slot() {=0A=
>>   _filter_xfs_io_error() {=0A=
>>   	sed -e 's/^\(.*\)64\(: .*$\)/\1\2/'=0A=
>>   }=0A=
>> +=0A=
>> +# Issue dd command with five arguments and record command line in FULL =
file.=0A=
>> +# args: target device, r/w, start sector, sector len, block size in byt=
es=0A=
>> +_dd() {=0A=
>> +	local target_dev=3D${1}=0A=
>> +	local rw=3D${2}=0A=
>> +	local -i start_sector=3D${3}=0A=
>> +	local -i start_byte=3D$(( start_sector * 512 ))=0A=
>> +	local -i sector_count=3D${4}=0A=
>> +	local -i bs=3D${5}=0A=
>> +	local -i block_count=3D$(( sector_count * 512 / bs ))=0A=
>> +=0A=
>> +	local _cmd=3D"dd bs=3D${bs} count=3D${block_count}"=0A=
>> +=0A=
>> +	if [[ ${rw} =3D "read" ]]; then=0A=
>> +		_cmd=3D"${_cmd} if=3D${target_dev} of=3D/dev/null"=0A=
>> +		_cmd=3D"${_cmd} iflag=3Dskip_bytes skip=3D${start_byte}"=0A=
>> +	elif [[ ${rw} =3D "write" ]]; then=0A=
>> +		_cmd=3D"${_cmd} if=3D/dev/zero of=3D${target_dev}"=0A=
>> +		_cmd=3D"${_cmd} oflag=3Dseek_bytes,direct seek=3D${start_byte}"=0A=
>> +	fi=0A=
> =0A=
> This doesn't seem to be abstracting away anything too complicated. I'd=0A=
> rather you remove the layer of indirection and open-code calls to dd.=0A=
=0A=
OK. Will replace _dd function call with dd command call.=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
