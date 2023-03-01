Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01858C64EC7
	for <linux-block@archiver.kernel.org>; Wed,  1 Mar 2023 08:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCAI1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Mar 2023 03:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCAI1Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2023 03:27:24 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE3B3800A
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 00:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677659238; x=1709195238;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tAVfadYBrlioXFYBmh3Hbi8J9bO6K1cXW3y4vbPcKfA=;
  b=J0nZ/bfD3UyBx9nZUVNg+QKY221hB1SGVxyokq4h8CeMm3aHdl3ugz2E
   Uw1kW7IrCewfV3VE6bvE2vDxOTG4NF9MYsn+Xir6FuXOQoeVp37R14FHe
   RsKxvQiLq8xPm/T4U/H23t8GmlV2FOVmy0lxAb1JL+TC2XzNK+jdgI6fo
   X261TvuzeyW8c9OlNzqjEWjTYcfmOTMAJOUBB5+rfBTLikdxTFfvPQsHK
   /ZYNYx9JcdRpJHuNYlWIKdcvP8GheefirVxbwwBIuBmwwxDsjhiUlQmLr
   p+ewytu1WGHqGJTIzjKlruoz8HXjQ1QqPzkbuyKm5lw26ThQGvIvKoeOC
   g==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673884800"; 
   d="scan'208";a="224290581"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2023 16:27:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAW9zI2FtoM35DlHz34iQzc45rYfgEMApaKABeYjIhSKGuEkEfDWgqnEKEnDj7y2R8KWPdXd0HgjSdkK/pwcCn5JVHSrYBIa0oa+vVpWYaXwTnZ0Wym/yS53/F2Ieir8WO4v8rIVF55eWFn3x3XYhSRRf2aCzRwHZES54JXWEKcSOPKF12HnP3+TOAr8ergDlZuIwnMzbVv0BpFzapW98RHiD0TvAIkhOc/cRw5tGmojVteWYLV9Mj17w7Hn5glifb7Y8jL6fXo8ys23TG3dCFtYOEDeDAOsMeDwv1NrhGHJ0Zyd1UUpwYuS3yApCsRrEXmspy707bYNxVeZ/BbyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm6JnNQHn5wFclrL7sUhyypWN+5CQcUER300eBQ+QIU=;
 b=WV2Pua3X0cz1kfqO789vR8iWcgTJ5Y0I3l8iMlbIXRfzPqaLGo1T089EJNfT8viDy8bA94C0zb/cFun4Cj370hunnmK/ro9CP/EBi96Xqvnj8ihOTpXxLVevVOwHRoy7t9iVxU/CPz2j/jZ7TTyXLdzcRG+vAat9AFLfOuO1ddbwkKqHbz8RVDXyh5v5iQOHqVT+8th8O0K/rSpclj0vScV5hKLeSCTBKJRIXZ9zQ3mTx8LAnS3SoFe7CETdtgg2+Ot8gGGYYGeUVTZRckSzh1+lw2GRxaqQNnrMRpcE53U7c/fMmqcMTIJG7WYbamVk5NmOfV2UaKZW/jkIjGTpRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm6JnNQHn5wFclrL7sUhyypWN+5CQcUER300eBQ+QIU=;
 b=u3tFDwCYhXiocimdI7b8CFwNkbQUYwTrAI/z96az7KJtzsl1AVROVgnNh3UMQ4TvMsiixWVMfP1uNOdQ97PuIPKnPlEOloz6J688fyGfcqxGi65VsWFNWk93JOAR6DAeNqRjtLkVpltwr70xqdqYS+wgeStbZMayLwVBIanGyyI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CY4PR0401MB3666.namprd04.prod.outlook.com (2603:10b6:910:8a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 08:27:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%8]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 08:27:15 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH blktests v4 0/2] blktests: add mini ublk source and
 blktests/033
Thread-Topic: [PATCH blktests v4 0/2] blktests: add mini ublk source and
 blktests/033
Thread-Index: AQHZSE3exEEzalLdzUWhdKDvbVsc467lnqQA
Date:   Wed, 1 Mar 2023 08:27:15 +0000
Message-ID: <20230301082714.xkaeqgifchyikwys@shindev>
References: <20230224124502.1720278-1-ming.lei@redhat.com>
In-Reply-To: <20230224124502.1720278-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CY4PR0401MB3666:EE_
x-ms-office365-filtering-correlation-id: f8329ece-2e90-4586-3839-08db1a2ec35d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QxluTxC+FVhVL/0kBuqhOGsv3W0gErD4v/37Dc6OTRNAyIPrLDSFSlvw4Y/SBR0rUubPqrooZycSmNan3UaR3ofDiCymcn7Xq4zbJym0sCJNyXjYcoLY9pCFwriTHgC8YK5WE9a084jolC6mc6ksUpZAAqr3uALU2GS/4w4aJCiZ80xHbkyEPCJE1mkl7GLHkGLase9ExHU20DokCtj6N2RJp24YiWPvMSnhuLPmtmLNjETkvFdtdvcN0obatHaGr3qlt7RzFKQF1TYkTfSZAL9wqjSb+X5gLnd7ekNQQhAr+zoCfPzBAgfJ3N9PQXy4B4Sd+ZyfkLGGB0LJVWGSThGj4P1R14Vq+lz50OiahXSW+F4ASWw9l/NAOKuqTObT0Or6ccOg7mUt1JQxHqCgjZkOgmPxLI/U0pu6KPcuIlOz/zktPs4YYtOPKnKXRnO46s9MbPzN5N5SqpzzlJzDckcrnCoPJlJ23X7jmQ2tIQ4uzhBc5tmvpqlXCii3+A7vOoaxFAjRQmQZtOVOgqnzZnk6kmDDKB6M3u0NqoaVyVWDeM2MI4AvjogZs1qEaAKC33DHX00g1tTuscSYPraY3ZSktiR4thsx3zrCzC94CZQxjHFC20kU3hXAc2nxYrnIcJ5Cf72hww1H0vj9TwhGpdu8ziUrJNQzevwshksTBJW9yeHpHJot8z7XcYzPQMkc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(83380400001)(3716004)(2906002)(33716001)(4744005)(44832011)(76116006)(91956017)(478600001)(4326008)(6916009)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(9686003)(186003)(8936002)(122000001)(41300700001)(26005)(1076003)(6512007)(6506007)(5660300002)(82960400001)(38100700002)(86362001)(6486002)(966005)(71200400001)(54906003)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DEtMFmtn152O97l+P050jxpEA5y6k9XDQIT6EMbQZ0xzXr+0zg3v5oI/HdTL?=
 =?us-ascii?Q?85E/ncgjyAOmpsWsYWQ4UqbNQlHEDjmZdL4bmVaw3N7jdyqDjuIxqYRsjVIa?=
 =?us-ascii?Q?Zav5DGdDxqJ0oHGHOPEiH9gnvX7bHELJOMBZIdUrU9R1gq6zozQHdxDpEPCV?=
 =?us-ascii?Q?4B3IfQWxsFWD+SckyByE/ZvY93L3GG3rd6o8lzijIxkPr3jckT104m45PTNt?=
 =?us-ascii?Q?dqecFCKRh+pEzkJ2d3a69cFgJ2OJULoEsT26TRY3qarO06teYVaO00jCB8ZW?=
 =?us-ascii?Q?Cm2FLGPkrooBzv7UUYOXjH/4C5tWfuGFAia/X9oLgpU/JHYmp5BHQXbVlIY1?=
 =?us-ascii?Q?uagcbvkIKCJ6I++unJSY0H8rfYSejpwh4kpLMIGlgO0bV4jXW3XzZPojbXKQ?=
 =?us-ascii?Q?mSSKboteGMuC5N0WHmkl0PFUpMWkYC/UqfIGIbRcWwS1vBMDVsF7Fq6HIdCp?=
 =?us-ascii?Q?tu2o3uZSXc6i+7YoqptFvhVrJu4+7hAENz9tsxnNppxa3ThdLqu0XXGNgocj?=
 =?us-ascii?Q?0GEIsGTlt3bu4OE8XXpyJTgBvUdJfjHFmMCeLmNc1b/lhpE7JafVIkROhCNj?=
 =?us-ascii?Q?j1UcQp4oj+gMT+dCpQz6RT8rBWezwa434XqL+TrR6TvlpphmxbvEcpalhb+n?=
 =?us-ascii?Q?rlgXPp07lM9GUJ264UOTPEan8OJwe/JqdToPn82dhWjoP3u+DiIfT75TuAAG?=
 =?us-ascii?Q?NVG6S9xK0WshUA5xk4f/571gDG1zsV0Lpflaqk7rybPik5IWRoMboM+a7j5X?=
 =?us-ascii?Q?cGn2bxM05q0UoPCGY6gscY1+1NRsVpE2CyVNBpCsRRxH0ASYFRFhTtxP+T31?=
 =?us-ascii?Q?/SSPws8UZscjPWe7RUJmwjAq1CTxMkMdeBxCha3E1icrMBtZ+wY4wQG/ZbLn?=
 =?us-ascii?Q?PAd8CCZYZrbLiut13mNr0TZxpM+/vDu2+SBR4qPr4lD6OfwwHelq73N85Q3S?=
 =?us-ascii?Q?zT3VXDywlrS8VglBplQBAdYCsSgWbs4bkaqiEdyNHa5NOtj+FprlBFj8hXYw?=
 =?us-ascii?Q?5D96Kd+4wpCSElpxEAx2MlHWmJDCX5eWDAvu39tR/Rbd1KOEvcohKU/NG0KY?=
 =?us-ascii?Q?FtjdeWk8nI0FNSEXjqOAwXJvDPADb+YejtdAv2VMCuBRt9io0JdQuwlF94b3?=
 =?us-ascii?Q?9jiJfUG+5+SCSKq6z6OA/CW++jElYwDa/b3fpkzz3V1t7Yo4b099CJ8V2usy?=
 =?us-ascii?Q?pxIEwH7k5Qx+rwlAo1o00/VEq9CsIhOSl7WN0mUmuITMZ3Xzhj4hEpU9Pdhw?=
 =?us-ascii?Q?tJZ3UAuZ+0ZyCcsQkyX7vb6mk5LT9urUwxB/+IZQ8RG+s6Wk3VObMEg7PPmL?=
 =?us-ascii?Q?witOvJPvDPzafooOIuOlp5dj1JahCkmDnafqWrytUxgp2G9HMsriSiEDcfHY?=
 =?us-ascii?Q?qF9MzPavOq0Y4WwdPNuYUeWTIoua4imtkyggdccjy2EKPwu8HV6rW4Ze61/B?=
 =?us-ascii?Q?1kx72ICqV5m4O0NQeY2MF1FfpkQr4zJjABMzxIxT3erxZoWJRjUugr8U5kCd?=
 =?us-ascii?Q?swDHcYfNL8EHhOBKA6y2Gl3mxq6Ji/3paxSWvJpXAWIjrI5Wf/0jJFIuE4GV?=
 =?us-ascii?Q?ljEdDdtOyIg8thgU7HtyebI/FdbELyQXNtaCeKfcQniLuGpiCC6MXJGMFJwT?=
 =?us-ascii?Q?iwiGBv05IO5EdjnLAeWOF9Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92C3BE6CB37A5844A26D08E2570A8E55@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u2+TTf+d1nGzGKFohFQ3XAlviL7Pj2eF3S93Jyo5bK05TzahZlisuHDEUBbo6MPkIvjgvS7FMttEJbJZIihhFzdOdi/8dUAybNiuAvd1JqjioKl9KEd840WVNDe9S5pgbAVHRf8B6a9go9wDlrtgTcHQAkD622s8FFwe7+ovXBvbts1Y/r7LEittJSmOlNNpFKL/HKGMkc/lmvL26I3GhRExNReYD8PV6o63+FxQki5eBiRotlf1j1uQkk4FESxOi95Exik9i07S5u0UPb0k4el0oQwu6MCOBbLdm3xwuLe2PZL3t3CjDtlBFi+NRBOkuS77zRX5WbyiVKcGMbdWxKkJXPkrfTUqDMjq/zC29LuZT/xt1b+HiUPVY/RHOf2ZeP3EZY0Q2jzbWPTYDOsk2MoAjL1DAblRFfpiTfr7Uyo80CzAVns6WeJ/22T31eUEYMBT4a4spM0aFt+ADaJFDxMXmhWpZRfArtskAjDzzOB6km3awQxF3SQGpmVrxiR7UMjDXQLGv8QzYZM3iLCAAx19MIljlMM8YZ+DO8w/Ppf1BFO5yDGeEU+8nYxxVfc9WhvsuYah2ZGsVeNdMFAbPvzkrHgTrMdmABtWj5I4XxWWwCdbCjC0sDKn3M6gDRFDgzb5iQb2w7OFB0R4Cqh4GEN3SqGlf4i3/nBDxpNz9MZ1uAsn68W3yPFMSEjAqDBSxaFfXDp/76nKbScCheHzOqIovoRM3KMCigJi7gnZdOqmi7a2HfT4obxIomoNtCYnB6hkxLP2KxUP1RlNrNkamkjd7XhzFWP1/ybJOYY7E/bKVmseg01qtUfGSIhAJb4OrvUpc0qs0x3DXsDoF48G7pDbEiWZPmkbxu6ZHs5oSV0qF80eXqcBlo+QHERoB/z7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8329ece-2e90-4586-3839-08db1a2ec35d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 08:27:15.1072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLvRfISegkAvcXGLRBwyFIsBqPhrCC8phc2xHGC34J61T32SccECZlZBzLBZe0kb1kkhF4Yz2Vd5SQQV8viNdG5hCCvSfWpXDXkt8HYdZUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3666
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 24, 2023 / 20:45, Ming Lei wrote:
> Hello,
>=20
> The 1st patch adds one mini ublk program, which only supports null &
> loop targets.
>=20
> The 2nd patch add blktests/033 for covering gendisk leak issue.
>=20
> v4:
> 	- fix one error handling bug in src/miniublk.c
> 	- patch style improvement on src/miniublk.c
> 	- both are suggested by Chaitanya Kulkarni

The changes for v4 looks good to me. I also did a trial run together with t=
he
follow-up patch [*] and observed good result.

[*] https://lore.kernel.org/linux-block/20230301080301.2410060-1-shinichiro=
.kawasaki@wdc.com/

Chaitanya, will you review v4 again?

--=20
Shin'ichiro Kawasaki=
