Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708B1C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 06:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CB160F12
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 06:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbhIFG25 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 02:28:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:25558 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhIFG24 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Sep 2021 02:28:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10098"; a="218030409"
X-IronPort-AV: E=Sophos;i="5.85,271,1624345200"; 
   d="scan'208";a="218030409"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2021 23:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,271,1624345200"; 
   d="scan'208";a="502133933"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 05 Sep 2021 23:27:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 5 Sep 2021 23:27:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 5 Sep 2021 23:27:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 5 Sep 2021 23:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkG8h++p+mtYDkeAXTQuCBbrlwf542yOecYfmvsQ0DTQS93u0RxAWAVocSCPWq7arm6UgZpR994r1ywb7qvWahVTkaZxClfX06WWIK6At6NfPU22pW9Mpe5YFlBG50AvfgF2E/FQExY4MFcLdR7ESfxokQeZfBqnIbNV35ewAwzwLZssQFIjleXTfQZUv0y6Cj5CJVcbvH8pzLfTy5fLbqW4ycCOZtd2lN+XdvtPjBelF/+Lq2N2ut9gLzS82g6eTLW7+C8nuEoPR2elXO/GZTe6v6ZfxeeDj6ziHlyKg8CVolzIRnw/upCYl6645qPJPHw27Tix6ONusZ7ADj2EKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLCDkjAqtXVLwVvKUwxa2AOPvWJ5nQrolXa/uRyXKCE=;
 b=JPyrA0ycPSgfq9eJ+GlgMAp0yYct4JUnYAyU9vKi3/l4SK/J+w/ohLCUtvI0uQ07EctjL/wv3glwAn6pFfMl7uTKSm/vu7LL/uFB5C+DHATqhTaqdIfBVdVr1LJbYx0I0dm/Sx6/7UDdu9m6l+MjDs0HD1mTDpvfVMF74jteBMdRoMVUgQ9CruSxW3d01XihS6Ny5j56g2X71igelOnPQvqh7GByULX2mBwturPSLyuwbKata0PAYhL4uVfk76Uwpv/zDpeFJQxxMRQvHNDfX9HEcEYjxQvgGgKyLAmAjwMB3v1mjj7QwhtTwLlPO6xadtT5FzjOcwwO/EnNEl6lQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLCDkjAqtXVLwVvKUwxa2AOPvWJ5nQrolXa/uRyXKCE=;
 b=uIVhdItXCBL07lXU2zYj+QR56bWvEZF9f49HGgBSwE0661i2PK2vgMnIYvv7KjqewqhTlH5VMQpT2w+jNfGsTxhhe5kGysVwwxCMDUFY+eNZDid6phoZRqlGBarm4jPa4pncdmNKbcQCmjdbTq4KasijfjQJ95MjTUJor0KfawY=
Received: from DM6PR11MB3932.namprd11.prod.outlook.com (2603:10b6:5:194::17)
 by DM6PR11MB2586.namprd11.prod.outlook.com (2603:10b6:5:c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 6 Sep
 2021 06:27:08 +0000
Received: from DM6PR11MB3932.namprd11.prod.outlook.com
 ([fe80::b029:69b2:f711:b6e5]) by DM6PR11MB3932.namprd11.prod.outlook.com
 ([fe80::b029:69b2:f711:b6e5%4]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 06:27:08 +0000
From:   "Zhu, YifeiX" <yifeix.zhu@intel.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "Li, Philip" <philip.li@intel.com>,
        "Ma, XinjianX" <xinjianx.ma@intel.com>,
        "Zhu, YifeiX" <yifeix.zhu@intel.com>
Subject: blktests nvme testcase error
Thread-Topic: blktests nvme testcase error
Thread-Index: AQHXotDIQ1BReCa/Bkq4w9G+UpzGzA==
Date:   Mon, 6 Sep 2021 06:27:08 +0000
Message-ID: <DM6PR11MB39327C5E42F053888DA37BDB84D29@DM6PR11MB3932.namprd11.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d817dce3-8989-44e5-267a-08d970ff5a8a
x-ms-traffictypediagnostic: DM6PR11MB2586:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB25863296C922040A610A619C84D29@DM6PR11MB2586.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VGofSDkgZomcO3Vdfhv7uO5BxfYkAS+VxnGTjlv5wSvHOz+359yzfrL6Q9zqTq5WW3Fb12HgzFSz78Elu1IayGFtsTdbi3Sblw7IXz2AtCFC3g389k5KMvK47xeInb3MYY7ZxM6Z6Cj61nPfYj3C5GUxnQ4ybFi2lk+K00o45Fv5rRITNdXcFwDWoEnIGz9uYW7MzXZtJ/7A7q218TpkZxcn3jTBc0bqNABd/TDfIawxgc1IAxmO6UZ9a5u+qDwCYuKF5bzj/sVGXspahHKn9o75zVsT/fkCQnnYNu6w0Y8AsgJDGnOOxlazd49zvX7ecs/f/xRYIGZM2kjPejMlVNflpQ5A15D1eT+FmeBMuZS7PUoQAJrMrUva2et/F+lv9+M+wcTERP+AP/s58bETFzE7jibhbuzIpAHRpbHLCStqw3pwFJ5eMAR1g6yuvNu8+8OY+LqnCYxhNlOSJl1lDhmM2HGfT9gXTKZyxqgIFWVIVbsxTg+Hx0GiXh1v2nZQOaY5F9LXWs/HoCUyOOwpZTTUJ7OWJ4KqqHurvjFW1DywvDZ4Ex0q9t4JMz67d8XzSaQ+2o4RaCiCGIqi0jyFIxy8Z4GgJrlpshRMsADDikZOtyK6AJJEsSwEF7OEVFOXuityKxDRuGf6LSabFlEW9L9ARCCn5odrQNgK3amBGmPK7U+e254oKBkiAnPBSzQ2ctj9Gz9uSI/Mj6gygWuwgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3932.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(54906003)(71200400001)(186003)(6916009)(316002)(8936002)(66476007)(91956017)(52536014)(66946007)(107886003)(9686003)(7696005)(55016002)(38070700005)(64756008)(8676002)(66446008)(33656002)(478600001)(76116006)(38100700002)(6506007)(26005)(3480700007)(4326008)(86362001)(5660300002)(122000001)(66556008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dmNuek0xdnRVT0U3Z3p4dkFvUWxMZzUwWUsybWdRNG5aWGhUVU1pWDhi?=
 =?iso-2022-jp?B?SFJtVTB5YzFLVDRiVzY5UG1jMnRRRUkzNms3cHg1OVJvVTc5NmhjeHpW?=
 =?iso-2022-jp?B?UkxTWXp2TnY1STMyOW9SMTJTeEFOVFRuNFRtS0NEWGZoU3YxamxUbHJj?=
 =?iso-2022-jp?B?SWYxZk1tdW1DbU9sbzdCUHVVNDZxcmtXamlsZFhtdWhrTk82Z210SXJ1?=
 =?iso-2022-jp?B?QWlIb3l2Q1Z6T3E1TkQ2Q29FbWN3UUgwRWJuUG5mLzhQRUpBUGtsendn?=
 =?iso-2022-jp?B?ei90a01DeUZtTlpUV0FTQkNWZndpS2NvV1RQZWgxck1vRnFZSG0xbE41?=
 =?iso-2022-jp?B?TG1qZ2JlV2pmSWpsNmovN3I1WXA5SmQyeUxjZ0J3NTRnZVluWSs0OTBh?=
 =?iso-2022-jp?B?MlpIc2xVdEFyZ3d2SE9mUStmTnJWQzBPdWlyazdZWndWaytBUk42d0tX?=
 =?iso-2022-jp?B?NitxY2ZiQTVzZWhwSEViczE5UHByZ0xkdmFKN1FpZnZIakY4dUN5Zklq?=
 =?iso-2022-jp?B?MWVpdDArUXdhdnl3dG5NYjM3QjlZY0Z3QTEwaWUvK29DNGpXWWQ4UEhL?=
 =?iso-2022-jp?B?cGg1Q0VyeS9wS2xGclVrODVEOEdwNys1UGpuOVptQWlLL1BnV0tQRTZx?=
 =?iso-2022-jp?B?d2k0QnpHUTNWaW03cWIwbElRdXNkZ1A1bHNBUjRKNUV3QnZWNGVaVlVv?=
 =?iso-2022-jp?B?amtIMkV6ZkpwZ2d3akFZVFRBRm04aGNOTnh6c2E1eE5XemJzTzVDMy9a?=
 =?iso-2022-jp?B?ZTlsQWhYSHQvN05FN09wYjQ1UGJmYmdWcEV4MDZSenlVcWlvVDFPbW1s?=
 =?iso-2022-jp?B?alRDNTIwVnhNYzd6ZHlsL2VmWmh6YnNrRm40clJzaTVyTC9BdmxHaW1i?=
 =?iso-2022-jp?B?Zy9nWkt5b1pVYmlaK3g1amFaMkFKalVDcjdqZDRLejFEa2Z2Ly9iczFC?=
 =?iso-2022-jp?B?SVFPL2ZtQmFYL0lOUitRMUZjMDJPUEJkbHgwdk1EbjR2YmdBKzEwYXlJ?=
 =?iso-2022-jp?B?RDM3UVNmY0ZyWDVDQjFYclBZRm5TZG9iMkVMZnFmMFdqcm01S2oyU050?=
 =?iso-2022-jp?B?aFpjZ2MzTTd5L3d5UEdnbEVXcDM5aHBuVTBHQkdQUWJzKzFRYy8yTm5I?=
 =?iso-2022-jp?B?TDMwSHBjN200NXN2bnVSTWoyYm9qL0tWcWRxTC9BSXBrVVNTYlNSa3FX?=
 =?iso-2022-jp?B?RHpwRm16VzNqSkFMeWF2MnBxK0tuRURkMmZGNDFiRENpVW52YTRhYUlT?=
 =?iso-2022-jp?B?TUJTVU9kSzJ5M0RWSFJid21OQ2RxT3oxYVh2WVVQUXlaMWx5d1hXVEQ1?=
 =?iso-2022-jp?B?TlVHUXd2cVI2N044MFRySkhMUEJNUmpLZy9CTnZDYVo3YWZKUHIwY2tJ?=
 =?iso-2022-jp?B?L3hOL0lxSFVlQTZqLzJXR3NocHlYcnZqOGhhTVNYOFFvMmFabnZiUGxK?=
 =?iso-2022-jp?B?RXQ0ZHVJV09jMFd1UFVJdm5ZdHI4RHltTzJJZnIwbDBZQ21ocytzRUF3?=
 =?iso-2022-jp?B?OWJyby9tVDlNYVJPd2xkOVZaMU9LZFFyU1h4anZScmZSbUNFMkRpbVVX?=
 =?iso-2022-jp?B?WXJ1RDBEcFZrSk9OSGZpWkprNE9aaGM0b1YrUzZsdGNEWlI3eWxZMy8v?=
 =?iso-2022-jp?B?MUpzSTBQNUMwSld2ZDVVcVpxdG1WOTR3VTJWMzF1alFQYmNIY2dxQUIy?=
 =?iso-2022-jp?B?NWNiZVQ0NS9ZclNPWE95Q0hLVnp0UHFiUkN3aGF2dVM0eE5DbW81SUJs?=
 =?iso-2022-jp?B?UDdvbGdKbkJiU3pMeVhmRkRBVE9ZcjJtek9tR1JnSmxIMVo0T0RYWUxr?=
 =?iso-2022-jp?B?T1M2UjRKa1VsSFNlVDVYQVlVdEJoYkZtOFdDaHpkc0ptMS9TWDhnZTJR?=
 =?iso-2022-jp?B?Zm9wMmxWdW9Nc3NnZU5YM2E4bUpBPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3932.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d817dce3-8989-44e5-267a-08d970ff5a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2021 06:27:08.6051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQPmDGNv1kD31WD/r8UALdU+YY1U4C0N2zQSJBkmVjOeCE/svMl6nSIhL0kEGGv965WLlSsctqAIP8yswVm5cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2586
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi=0A=
=0A=
execute nvme testcase=1B$B!$=1B(B  some cases throw the same error info=1B$=
B!#=1B(B=0A=
=0A=
LOG=1B$B!'=1B(B=0A=
nvme/007 (create an NVMeOF target with a file-backed ns)     [failed]=0A=
    runtime  ...  0.160s=0A=
    --- tests/nvme/007.out      2021-09-04 22:32:09.000000000 +0000=0A=
    +++ /blktests/results/nodev/nvme/007.out.bad 2021-09-06 02:20:12.999726=
531 +0000=0A=
    @@ -1,2 +1,3 @@=0A=
     Running nvme/007=0A=
    +tests/nvme/rc: line 236: printf: write error: Invalid argument=0A=
     Test complete=0A=
=0A=
this line is enable namespace=1B$B!#=1B(B=0A=
=0A=
CODE=1B$B!'=1B(B=0A=
    221 _create_nvmet_ns() {=0A=
    222         local nvmet_subsystem=3D"$1"=0A=
    223         local nsid=3D"$2"=0A=
    224         local blkdev=3D"$3"=0A=
    225         local uuid=3D"00000000-0000-0000-0000-000000000000"=0A=
    226         local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsys=
tem}"=0A=
    227         local ns_path=3D"${subsys_path}/namespaces/${nsid}"=0A=
    228=0A=
    229         if [[ $# -eq 4 ]]; then=0A=
    230                 uuid=3D"$4"=0A=
    231         fi=0A=
    232=0A=
    233         mkdir "${ns_path}"=0A=
    234         printf "%s" "${blkdev}" > "${ns_path}/device_path"=0A=
    235         printf "%s" "${uuid}" > "${ns_path}/device_uuid"=0A=
    236         printf 1 > "${ns_path}/enable"=0A=
    237 }=0A=
=0A=
after check, enable the namespace should be with NVMe device.=0A=
=0A=
Test(change device_path and reset enable):=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1# cat device_path=0A=
/blktests/results/tmpdir.nvme.007.S8p/img=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1#=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1# cat enable=0A=
0=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1#=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1# printf 1 > enable=0A=
-bash: printf: write error: Invalid argument=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1#=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1#  echo "/dev/nvme0n1" > device_path=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1#=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1# cat device_path=0A=
/dev/nvme0n1=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1#=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1#  printf 1 > enable=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1#=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1# cat enable=0A=
1=0A=
root@lkp-knm01 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/nam=
espaces/1#=0A=
=0A=
=0A=
so  should remove L236  or change test device=1B$B!)=1B(B=0A=
=0A=
thanks  and look forward to advice.=0A=
