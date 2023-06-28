Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4BBEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 10:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjF1KhF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 06:37:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27042 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjF1KfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 06:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687948502; x=1719484502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ulRPa1xfTYGhDqhkh0aKNHIy+gxHgEYWyB2kmNIJ0pE=;
  b=qXt4zPCl1f7sUtmadN1TYt8e/HKhfp6rQehNRLg2C88GIBG84vrzdjUq
   1gelLuyAnlwuXy5SLFZXIBfljl7TpCI6bXp2YL6S4e7Q0DRFRThL+1UXO
   SCU0qXVUJnG8HFSUYeR0CQZG07EIvtORb2dFI8N8oN2BFiBsaEc8eoDHi
   1T/fYHsucbBHjFtfm+Mc8r+a/5c8948eIl7htbsd/MHrjanQPX0vdYAgA
   MEHnUWx7+w5qnGfY4XzaC0Lli8GAEOSHxBCyI5h4U1CWmwamJCtQZoeW8
   qMUkO+VK2lAiWyNMHpEMrD2ltIOl7G+jDCvJqNeLnn1oinB0YIFVF7YRS
   w==;
X-IronPort-AV: E=Sophos;i="6.01,165,1684771200"; 
   d="scan'208";a="241413763"
Received: from mail-bn1nam02lp2044.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.44])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2023 18:35:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrFYVn45jK5Hn9TTSTLOv9KtuHMMsVbs49HaLzjkJEthir3WEovm2Hbdr5CV000LD80ZiAD6WZArEJ/QkT3bY5bdnfA5YKb7Zv5THz2boDNQtvclLcJ8HUYmKLKVoNhWr0jg/5WDkSUsf/V8F8HZ/QF1qbTFg14cgHNoFsI1EVs7vxsWxVPEdSkHTNGFCihs4X33xcKv/1F2zVWl8iPi/mDFvAnOdFyuypckgnDVahwpCEWimuFeYzbVCuqi0pWGiVzLF9dBnWXkHV+jgQXCNvmDQMBPUXqSs8KoTa4R9K8MHTnOyVdnCQ00WDITwvewUliNsVvutcMhGhFgx2HW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcbySAd9BUggS/0wTnCnEAiurervCXDIorZTRlN4eZ8=;
 b=E3hYH7GtDZrCLXEP+IEF+eamI7v4G3/nri91eTeI42ouMglZKQsDyQ3O6Dzb+7tBF+YpR4dD6sSPSlQkGVhspQ62/dVDaB1bsxz8Z9kXp2QP/3+duSmfCtnaDQMjj6i50bbDKr6+4Lk2YTVrSjUxyw5n9zWOlP7spgZRror7ztK3zvPvbLqN00eK2wYCIjKATTbp72Pl2QbCntT6/L43VH1I2IDqpcBp/RSCnPgebs9iCzXKK9UhkFd1pKApYxq3kBjUN+WcyZRgR0eUbvIv3BNKdXsi+8Jh9QpMM4r8+BU1LvWxyQuUIlWX0oY2EUIJYLvJNOhuHGrz7f0LClFb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcbySAd9BUggS/0wTnCnEAiurervCXDIorZTRlN4eZ8=;
 b=o0XNNc7RrP1iGk343ndyQfauQ0AxaSqq92L4K/YbGof6RooaGOytCQ6R1rjfVz8LqGTJ5IWF4Tai4/6i8gQoNR4phf4ZTbVud+GLa0PrmKJa+E4LfIWxvzwQqS06mqI3ROuVElCurpIfr6CDw/8YyKxR3lkX1KyEPzYg/Hs+aSY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6916.namprd04.prod.outlook.com (2603:10b6:a03:229::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:34:57 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 10:34:57 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
CC:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Thread-Topic: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Thread-Index: AQHZqawtAREYOa2JLUG7L6op2T/M7A==
Date:   Wed, 28 Jun 2023 10:34:57 +0000
Message-ID: <7d6m3ha3rqc73q22d4bsxtc4u2cqb4ryp6f4q7ajvazdpek2ko@nh6a6biyryxd>
References: <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
 <000e3d0c-0022-c199-1f8d-97e191345197@grimberg.me>
 <d5d9bd87-1d5b-d66c-39c4-e35c0e5ddc48@nvidia.com>
 <94785130-4f40-aa29-9232-af8a8f1ca1c9@nvidia.com>
In-Reply-To: <94785130-4f40-aa29-9232-af8a8f1ca1c9@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6916:EE_
x-ms-office365-filtering-correlation-id: 9591db6d-a18a-49dc-7fde-08db77c351b3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0prOVRs0s+g9eXZB9w9Y3iQKP3S9m/0rGWz1uActVB2EHUzHTFrOAxaEnxWoHoQ2Ueu4WgADcibP2AgUaEHuEq5lYq0Get2ho/MSTy+ZsxZVSjN5tLqYDsHqux3TyYWwFKZFKtmbC0QU5dFtw1RTlmSL4V0sbIeblzat+1XrQBu4e36YvIiGWlDZWaV70H4/5k+OlXKhUdyJTbx0ieIEMHPafyHwLjVGbZvNofUSuUlTd+Q28xz1TKwwnkkcn2Q7yJS7qps33xEr/sLYddGjofIUx0t1k9xyHFyQKC5VQDAFFbH9QMkZVnqzTrwTXFUCMBThe4YmQ6+gwqiUdHzAaoK3aOWaoFSWrSzf6MgAYetbB2hwP9ma1hYXxk+Q/YWRS1j1NDRT20+IFJxYqFBMWG88sNSD3Uooje3pAW00fD8CDNz+EbkHkoXljlm4AEJujtbt0mFCGjatcoCUdKcQNsJbytctur9qBOdJIz1X3dhFJe3RgWUoUaiISxkWkqI101VrnHtThRhtpy20nijMSEsJH9CC5+RN2MOWfl9g9POGTuiQT+P0Iu4uBafc+oHETV4TzD0ghUzlQxjZZ/9YVjFTt0kI+I66gYm58gQhBDekvriWIenbkBIXrB6Q+YO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(66946007)(66476007)(6916009)(66446008)(76116006)(64756008)(44832011)(316002)(66556008)(478600001)(38070700005)(4326008)(8936002)(91956017)(8676002)(5660300002)(86362001)(2906002)(54906003)(41300700001)(6486002)(9686003)(53546011)(33716001)(186003)(6506007)(6512007)(38100700002)(26005)(71200400001)(83380400001)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z3EnsTN/Z5t80nV3h2sx5vWT240FY4Y7FIZIhFwOEhiAb7lIJDQxka7zqJhD?=
 =?us-ascii?Q?MDWSIuHfUqtOlxnBiQ8RIYf0Uz1+X8/vVJtxOit/pNqu8dKev/adRJ56LQlN?=
 =?us-ascii?Q?rKcGZg3kt6Sqc2FqGbxM6zwBzi5aLXdwalUi+D/UkcNSoYHb5Y/pJ25SSX4T?=
 =?us-ascii?Q?D1sm17wpn9Ya+r1zvBWSwaUVHveC/Kl0HmVW89FUukyxQO9AQNTinOtvetB/?=
 =?us-ascii?Q?fUEme5ib5T98J2Btlog4cAjRpjsN+9T2f2CyoucIV8H7dZw8kjUWUMHj3KAD?=
 =?us-ascii?Q?Sn8b3QcEsxCsxWV+syNp5u6vbFilO6xNvisitmpfulWV1dthUfMrCM4gTjpi?=
 =?us-ascii?Q?LdLmPCW0S6gN8dZkVroVSWwqNrIdcKVx19lGR4htMTWKtELkZ9W+83ffdvVZ?=
 =?us-ascii?Q?/5wk8WmkSn+9SDHac5FnWjqH1N4juVagFnkDFCIgtyf4cFJiRaJR4iacaEam?=
 =?us-ascii?Q?6dKx1GAd2sGT+LfFdNNTcNi6RzPuoziKYWzRExGa9+yFIOTfhWIjQb6Hv0Yx?=
 =?us-ascii?Q?TZEqtXvRP3+05x9sC89kv0I3RRWAZq9vMQhwM07uZ6cPTWYXQec0LMx+1GIL?=
 =?us-ascii?Q?mrETfnDB9KZ6wI7iB9ztJKirGKyklhlLml6EtwyO0rb9S2114KwNOrmOyhVC?=
 =?us-ascii?Q?oIxNPILfkbF8sZq4Naq6MY5MuEfzrIryWJ0IcaVDuKK+1OEjNNxw1ftbu7Nn?=
 =?us-ascii?Q?4bGDrB0C0YCjp01YdLzed4uLFnJcrk25rAZBaKn4HWFppwP/4Pc6rig/v4Kt?=
 =?us-ascii?Q?ZRofZcC/URgM/gnqD/s7E/CnqruzdGTLsOcmLChI/tJwyLfnWRvlYuQs+ysO?=
 =?us-ascii?Q?asqA+qyKPObvfAROY5i22KAYWdUu77BygodWPHXHpThp43QQ3gSCML8Ce1sI?=
 =?us-ascii?Q?RVq2zzCWlIfjtMFTQJxsdH63fLtz5vji7H37d5dmWGv0NfMD2w3dMVZCWob+?=
 =?us-ascii?Q?niOGlPHRVducK+noAQ1R1udHEZvTqkHW1Q/Jkzhfu/YLNw8UPGD2VSX3DTvi?=
 =?us-ascii?Q?J5g/N0ZTndv+in6qS4KPI4DHU6OJxAR2tZDTTy/yaO1YoJJV+ULr/i8WJATw?=
 =?us-ascii?Q?hqOOTg2+cvmsV/D3AYjEsOLtBibdxU3mRHSUitTdiT3ZqSLwJNBBWdV8t9zk?=
 =?us-ascii?Q?FxZ3x9YlvGVlS/f8BQVftzpEjXpenhnPBU0f71YwvOqzZLS6rFRNcrGPyB54?=
 =?us-ascii?Q?1LXD8G05efvsmwGUXJP341CPPNxzMXBLU5FnZnNbqNKej13Lay41MYqN1H5z?=
 =?us-ascii?Q?Txta/XpUZuqJf4mMIXxFo3nRnxhQu7aYMT+ttPNtlrL3R4FRwfTQSrgnQ1H8?=
 =?us-ascii?Q?jB3X3a8M8n+qOFsB4QlKwtITzdQh0rmorYYCC/3MaGxggUpO+r62Wd0XyYLR?=
 =?us-ascii?Q?ecy9+zAaEQfsp83uZPBTHKy2G5Xi6mjGxbPAQHJkuyq8iRMXKzgMCWk4eAhr?=
 =?us-ascii?Q?/D7T8zLzTKi9b4fjXcWpxw9ShBCULX6WDzf0T6mBXBNLwrdFAsVfdkZfGU6j?=
 =?us-ascii?Q?tqJvfuwUWJsZkx9TJKW60NuijQR4KeKErCv7aJJ4w9tu6gkLtBFNsLTbyI/H?=
 =?us-ascii?Q?eeZoA8w+pA5A8/yXH91DkUWWsB5LrazOiHF4p9ZD+97iTLoHJ240Fp9L+gBH?=
 =?us-ascii?Q?u9lZ4UllaEHwZXKkkgQ054Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3155BE5DA2C0044B9F953D2EED0A6DF3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9PKwsjchztceLvMmtNpgNE5MtfBwLcl6qtO927+O/m78A4wUaeO7UyZA/KFb+EU3V4StQ0uzt90oR+ERQ6UbmEZOaPNvqH9eu+VRPWc5j2M4YxCpTqc2IheQzNIQyCDgn2sxOCNfsqq/Y5jWmGb4rVoxcQSwTodaue9DYiHgMA4ckv58tkIT5daxIZsGUr+jhGkD9xOI9JSsrIeMRmhGCgm9fEYjA04KDwGtgeFzmvp6eG9WG4lMzhnAdSMjiWj+O1pk0vEWaf9AwaNidNRyT/Pywv8A5nevrGflfffXDAQ4tkX4mTDp5kRzXJJ79QDvcexr47YPcj9sKOiUsZUepeJLURRDcf58gokwfZsM+4ZtT4e+axhMKnBxqoYLVAY1n4yzxSUEHaG5AO3QDA2rrIeBMYFt/+rARjFCTuZkoc18QzpcLzcfcGpvINDXu/Ztwx53Yrx4YkpJEdiV7FBNTeJWKr/RTeWIEyhhxgFaIdab7yj3VJN8A/NCFadcCyx7G5QHCv8g+Xg/QGWGPHXLi0U2COs7R45AX47s1q5gWOStXO6s8QVTFOm1jU7om2c8Sk9okgrrvlR6RLg5zW4VH4lT5VnnJzFNkefn1KLfqOTwKU2sB9BZqYKraWhKkeHUQ1WIZSQ7zeTYDG7clNJCBDhqVoa2HnfGU7Wdzr2EWeaWveTLswGCFIZMwW+XAE0MM2YAMEb5o3QUIABrxtmxX+ivTAITEMnugPY29knNXdowkf4t+QpiChXuIHjCQHMGM+OT2UInESt1zaBzw/PGqmOtWbA7D0yjdvVCdkpd8bGYA9fZ7wmXZ1xbbXX1UVH6C7RtkqbvMRNvtf9sqdBa9qmSZeACWEndFIndpUpKuQzasVELE2XMDN0IIg4XAxXAlyg7S112ZR7EKShWNkSPYlu24FMkGSmHUS+OImiDVZg=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9591db6d-a18a-49dc-7fde-08db77c351b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 10:34:57.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Rpg3IlWMevrkHAKnqzGbJG75Vkry8H0avjKtTw45rpz5f5VvOaOb3XvuqsZbgKQg1TK/cZsct2Ydn/LwdE8L/tWXZJjW9thdkMFiSrM9LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6916
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 28, 2023 / 12:52, Max Gurtovoy wrote:
> Hi Yi,
>=20
> On 28/06/2023 12:21, Max Gurtovoy wrote:
> >=20
> >=20
> > On 28/06/2023 11:14, Sagi Grimberg wrote:
> > >=20
> > > > >=20
> > > > > > > Yi,
> > > > > > >=20
> > > > > > > Do you have hostnqn and hostid files in your /etc/nvme direct=
ory?
> > > > > > >=20
> > > > > >=20
> > > > > > No, only one discovery.conf there.
> > > > > >=20
> > > > > > # ls /etc/nvme/
> > > > > > discovery.conf
> > > > >=20
> > > > > So the hostid is generated every time if it is not passed.
> > > > > We should probably revert the patch and add it back when
> > > > > blktests are passing.
> > > >=20
> > > > Seems like the patch is doing exactly what it should do - fix
> > > > wrong behavior of users that override hostid.
> > > > Can we fix the tests instead ?
> > >=20
> > > Right, I got confused between a provided host and the default host...
> > >=20
> > > I think we need to add check that /etc/nvme/[hostnqn,hostid] exist
> > > in the test cases.
> >=20
> > Right.
> > And if one of the files doesn't exist, generate the value.
> >=20
> > Should it go to tests/nvme/rc ?
>=20
> Can you please try adding the bellow un-tested code to blktests and re-ru=
n:
>=20
> [root@r-arch-stor03 blktests]# git diff
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 191f3e2..88e6fa1 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -14,8 +14,23 @@ def_remote_wwnn=3D"0x10001100aa000001"
>  def_remote_wwpn=3D"0x20001100aa000001"
>  def_local_wwnn=3D"0x10001100aa000002"
>  def_local_wwpn=3D"0x20001100aa000002"
> -def_hostnqn=3D"$(cat /etc/nvme/hostnqn 2> /dev/null)"
> -def_hostid=3D"$(cat /etc/nvme/hostid 2> /dev/null)"
> +
> +if [ -f "/etc/nvme/hostid" ]; then
> +       def_hostid=3D"$(cat /etc/nvme/hostid 2> /dev/null)"
> +else
> +       def_hostid=3D"$(uuidgen)"
> +fi
> +if [ -z "$def_hostid" ] ; then
> +       def_hostid=3D"0f01fb42-9f7f-4856-b0b3-51e60b8de349"
> +fi
> +
> +if [ -f "/etc/nvme/hostnqn" ]; then
> +       def_hostnqn=3D"$(cat /etc/nvme/hostnqn 2> /dev/null)"
> +fi
> +if [ -z "$def_hostnqn" ] ; then
> +       def_hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
> +fi
> +
>  nvme_trtype=3D${nvme_trtype:-"loop"}
>  nvme_img_size=3D${nvme_img_size:-"1G"}
>  nvme_num_iter=3D${nvme_num_iter:-"1000"}
>=20

I tried the patch above, and still see the errors. def_hostnqn and def_host=
id
were not passed to 'nvme discover' and 'nvme connect'. I added some more ch=
ange
as below patch and confirmed the nvme test group failures were avoided
(nvme_trtype=3Dloop).

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 191f3e2..1c2c2fa 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -14,8 +14,23 @@ def_remote_wwnn=3D"0x10001100aa000001"
 def_remote_wwpn=3D"0x20001100aa000001"
 def_local_wwnn=3D"0x10001100aa000002"
 def_local_wwpn=3D"0x20001100aa000002"
-def_hostnqn=3D"$(cat /etc/nvme/hostnqn 2> /dev/null)"
-def_hostid=3D"$(cat /etc/nvme/hostid 2> /dev/null)"
+
+if [ -f "/etc/nvme/hostid" ]; then
+	def_hostid=3D"$(cat /etc/nvme/hostid 2> /dev/null)"
+else
+	def_hostid=3D"$(uuidgen)"
+fi
+if [ -z "$def_hostid" ] ; then
+	def_hostid=3D"0f01fb42-9f7f-4856-b0b3-51e60b8de349"
+fi
+
+if [ -f "/etc/nvme/hostnqn" ]; then
+	def_hostnqn=3D"$(cat /etc/nvme/hostnqn 2> /dev/null)"
+fi
+if [ -z "$def_hostnqn" ] ; then
+	def_hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
+fi
+
 nvme_trtype=3D${nvme_trtype:-"loop"}
 nvme_img_size=3D${nvme_img_size:-"1G"}
 nvme_num_iter=3D${nvme_num_iter:-"1000"}
@@ -442,12 +457,8 @@ _nvme_connect_subsys() {
 	elif [[ "${trtype}" !=3D "loop" ]]; then
 		ARGS+=3D(-a "${traddr}" -s "${trsvcid}")
 	fi
-	if [[ "${hostnqn}" !=3D "$def_hostnqn" ]]; then
-		ARGS+=3D(--hostnqn=3D"${hostnqn}")
-	fi
-	if [[ "${hostid}" !=3D "$def_hostid" ]]; then
-		ARGS+=3D(--hostid=3D"${hostid}")
-	fi
+	ARGS+=3D(--hostnqn=3D"${hostnqn}")
+	ARGS+=3D(--hostid=3D"${hostid}")
 	if [[ -n "${hostkey}" ]]; then
 		ARGS+=3D(--dhchap-secret=3D"${hostkey}")
 	fi
@@ -483,6 +494,8 @@ _nvme_discover() {
 	local trsvcid=3D"${3:-$def_trsvcid}"
=20
 	ARGS=3D(-t "${trtype}")
+	ARGS+=3D(--hostnqn=3D"${def_hostnqn}")
+	ARGS+=3D(--hostid=3D"${def_hostid}")
 	if [[ "${trtype}" =3D "fc" ]]; then
 		ARGS+=3D(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" !=3D "loop" ]]; then=
