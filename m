Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94F1C54EBD
	for <linux-block@archiver.kernel.org>; Thu, 12 Jan 2023 11:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjALLuS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjALLtY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2023 06:49:24 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D46413F08
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 03:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673523520; x=1705059520;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=UiO6EuZqPxnvXfQALquw3TZQuzvqmPo1yheNQVQqufQ=;
  b=rFenrRlSJY9uYiLFvQ7l+TFK1rpZwnFF19aX1xNfT+pjg8UzjeQUtI/h
   pU68LO/RbegfR6LtxFM9kytJZs7OjLhcJvxi/PddCwaI4xfykvlDBWvZY
   e5CEBCK/FuIEvFRFPL7M1j5ELezu0gwdfhlyIqNzOgQ+ACRMTInwtTkx1
   lUfTxg7gNfMWi8fOXjcE56uLWdKDGW5kTn6vVP6Fq5aRKmwDZT6BCKBNW
   e6UJ8Y7b+vh1EBcSYMqMjfusS7TJmfVdnKwqJw6fiKNi9eiI+MOrnIV9Q
   6Ni9uxGwL1kxhxfGgkqfRAjoFc2mjqhPjuEcTXyoAIo7a2ulSIZL8gte7
   w==;
X-IronPort-AV: E=Sophos;i="5.97,319,1669046400"; 
   d="scan'208";a="218948618"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 19:38:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8j7YeliCRoBTui3gyi6vhQEEFnpw/VH8cdB+cAZgMVx5Q+3QftV4ZkThbTrqw4u1uj3OyHqei/zKSsFKyyCFPVU5Rolz2ng8EkZs+OUVs6DdAmPvMQYcToos/FD0bA/e7bLPEdy2VodTDgadwgwivDAk3d6FXQbmzsZyl5vxDvN1YEARazVg+GreW8XsrpGkwyfC/Aq0ClWIPhThHHptskqzdcGzkFXI+WUCUOGt6dC5LJEOnZ7VGwhr8MGk7FuhpfIrd/RsfIfzcKSKn+wssJT7g1gcuYv3M+Dm1zvPMxxcXq6I5MpEIGyuQSk5CPLkuIQsMUPPTbnCMISR/ErfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiO6EuZqPxnvXfQALquw3TZQuzvqmPo1yheNQVQqufQ=;
 b=Nk5QpoPYH+14UD6szxe1uVFSLXBBYISKKPxMrw0NOziBNa9SZfCRZ+0AAYiCl6EnwBWYcsEGXTjMyQ6D5F7vwKe49/u9vRtP/zKK4v2M44JEUqAdCQqhZ1XWjbP17fUgzZFWjAZ39QqxgR96y3WEzlVpc+ajVuqjabegQqy5pbVd0jY42CibT/8pkrJsFTEzbvsl7tHEravDg2+KQSLYnahJAB9V3/6+pL/JOxG5TRqT5GFAr6EJasT8HTGPQMaWh0YtnPT5iEuLsjEulvMeO1vS6gpeRJNd1mRAtTZ+tHPojRPe9XgjL4XHTpGrv6KfyF049IfROg1Kg2bybJRC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiO6EuZqPxnvXfQALquw3TZQuzvqmPo1yheNQVQqufQ=;
 b=Y/8UtJZS9y8FPgmjxCXZt9drBry2K67bqU76GmRsRWEya5APqUVy2/aG2HPojCCZmm3RFSZa5XBNtmxa0n6jod4zYCokBzM9ZqmGO9VXfzpzo4aBbj4kLqNvW5w2HdlwrQENUhN347ltH2hAxrQA3m2w0r4tQ/EspKdYhWW4l5Q=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB5682.namprd04.prod.outlook.com (2603:10b6:408:a5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Thu, 12 Jan 2023 11:38:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%9]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 11:38:34 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Yu Kuai <yukuai3@huawei.com>
Subject: [bug report] BUG: KASAN: use-after-free in bic_set_bfqq
Thread-Topic: [bug report] BUG: KASAN: use-after-free in bic_set_bfqq
Thread-Index: AQHZJnpnPtmIPiOF+0WDV5g4YvQlog==
Date:   Thu, 12 Jan 2023 11:38:34 +0000
Message-ID: <20230112113833.6zkuoxshdcuctlnw@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB5682:EE_
x-ms-office365-filtering-correlation-id: 862742f1-e16f-448d-de32-08daf49189db
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0CkzU1ahg4ulEQyuGZ6+PXaOdNJsgmuSt/ZpAYyxvkOCicV3SlxI6NqScPzKVMGuUxy2AMrx6Q73FhGc+uL2TMO9/AhqHWfV8+cOF/nxrrHXwBfW2sPHx1mkCsN3SOfQqNG6xsaD0Ln5QRtsqs4aKAOLZytaiDgc+AZ/P+YBq8gpG3NE4yvhVWQ16i9idb0WZykoWyyTz0drOqo+G90hHesPdEvAokcUNQb0sIiTq6IWh1sTVKuhA4Hi6UAlIbcDnKnycCsquQ8zLReCXR5WBopFiVnutZl2x1ghN3ILS+B4MRFGvWUlx0fx8w8SeajJc0uNhrkWIYZW+/w4OHY3Q/LkraKD0l1NBItsRjYG1r9JuEEVMgAfsweQtV9/7gWvPu7YuolBe17tdFgcQUfhA2N4EgR3ML+aFBhM9N185lhJUHdOxKpd0aUItmj+lqc/UgH8XYR2FwwdNEiuxtOL3jV1k91vKk+b9a5ZTeXDkCFHssyH2CA1Wi6lHLUqtszZJjgCUydwMWJvM4bMZLywvwR/FzpMw1IEAOxsq4p2OTCd6YR8/wBsOHaC+3nYVHgtSAD7RLPBSOyuCilU4xcGsk9UPmI1sT/gIJBxGkKznet7Oo2WiqfrI1iJT6I/O42BmcchTfzcoJkLEt9Zt2basm48S6ZdgvaB+dl59wofUJO1eZjqezkW1oEc8ptLk16DIw4SjHz1zzhr/cRXR2fH2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(2906002)(83380400001)(44832011)(478600001)(9686003)(1076003)(66446008)(66476007)(64756008)(33716001)(66556008)(5660300002)(66946007)(8936002)(122000001)(26005)(186003)(6916009)(6506007)(6512007)(6486002)(82960400001)(41300700001)(38100700002)(8676002)(54906003)(76116006)(86362001)(38070700005)(316002)(71200400001)(4326008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AVLkX5q5ffwolWrfLyWRJutkYSbrRlbiDoKEiIvJM7Gszp/od42ibTpXM7To?=
 =?us-ascii?Q?LV4EWdgyAmy+Xlf7NfaCyywqtVIGKpEjdHKrInRfq1ln0giP9iXq0TR2KUck?=
 =?us-ascii?Q?92BVXVNCjCXHtzwVXJF52XhIt5mpqaznfjo7JdUmCLigwvJ5VEkx3t3S0fOb?=
 =?us-ascii?Q?UpA/bskMmpAF315DG7xBQky4oUxr7sma7Ckf0yfbG8+LQ5u2tRH0idlQdClT?=
 =?us-ascii?Q?vTTewgRWNRrCvJ2qz2nF+uVc/+EIQHR+GCfCmx5UZwnzxpjeoTgUEFJcRNad?=
 =?us-ascii?Q?fofqwvnXj/q/wD4vpEr1gRWFKGJBtYDfGcSe1hgzkUcGz+2VEJKx59bdP5fX?=
 =?us-ascii?Q?xZ7hIuLdSNPM2kiqGMDrD8PJCMmpT44Jxe87DEMBHacc33rNgDy09q6GZ0oo?=
 =?us-ascii?Q?tsQrVEAMOf2yoe1LncLKYI8Ocg08xmNlhvw49iBsJnPHxcia2DJhiqfewpQd?=
 =?us-ascii?Q?EyBzp/pgLnRM+0OOw++VmcQKmRqAREWcV9jGIWA95T9om7FjhjxfCTItkc+t?=
 =?us-ascii?Q?FkDyTcd/bAhn7t6QdgRfMDElC0rlt4rJcPVdxeIagsvDSO2AesmQ5O8o+91U?=
 =?us-ascii?Q?eBfytK0qiUHlWQfA+tFZ093py6HpvMsYm7xdE8Vj3XbUu1TZcrPXAaKFP02a?=
 =?us-ascii?Q?Mg2ClIgRO60Uab5s2dRT7hc8ctvrS9ufXSkc9YR6Trb9TLqUbxoIEuzE2pER?=
 =?us-ascii?Q?jpWgavkgpeAQfOIci2UUR2VK4HMgkV+7/gfGIK9zdNs7M8d/7dvYcyuoHuWx?=
 =?us-ascii?Q?t767gpIZqbRlscEq0O+szP6uHZmAZ+fLePv2KLXmyMOGpb2cI/vsvur6Hgvf?=
 =?us-ascii?Q?IElslxf9N4oAai2eThD1zCNgCDe6G69Jg4k3ShTsbs03eZWzhU1MF0Z/hB6N?=
 =?us-ascii?Q?g/Ud7AxhdjeXO6eenuDkY1LrqXsTnckbhGmmbqddUJduV9wXMI4oTxoi3C+/?=
 =?us-ascii?Q?5Psi4Z1TlHB8J+yqIO31QQqqO8Q0iMnn+3TETl+CIkRBIrUmVeNEJtD74fJs?=
 =?us-ascii?Q?PfKGf2/5RwwubfwEtP6VMBKHKRTJkpGK/Use85vBzPkKCnJ/2gRKTzXJ7kZ3?=
 =?us-ascii?Q?qx1YqhpgrrhaqD3AMfVOentVkqKPwC0J5oIXWnDIXKdpf3q2KRDlv4/aVMty?=
 =?us-ascii?Q?Lv7cdXKStNiz5ffk9blIoBIIiZhFZrtapEeG6LyDdVeqGwDEgo5XIHVX9/7n?=
 =?us-ascii?Q?i79iPBkNM8S+3Xk2gvulRC6w8LwNKhN6DYoJEzTsLLDvZIWWSgfGlnBDSIik?=
 =?us-ascii?Q?uugsfodkKUELLEiiE8wsgDJj3wwNnfpkYa/3y/hgBKEfS3kXiCAss3aNCzvE?=
 =?us-ascii?Q?h2gZRJtMlil1wVMqqg7xMISBG7ygOxyvGyD4VSZRpiVPzVYwIw4wFu5kZ62h?=
 =?us-ascii?Q?o08f6its3sWDZzGejGiqlaL+a/U6NeexrhNGpvnRFgnYMiGi57d9CQlIuw2P?=
 =?us-ascii?Q?8pRT6wROJWdlDLi+Pg5ulQp6MWCdlaVNEoySXfY0hy6XQ71V5i1rckguxeWC?=
 =?us-ascii?Q?JZRMOUSv2Gqf8+BlKQwNuWFFF6KdYdRd0SZ6yHtBJzGXzOyZ1uZBaOd/IHcA?=
 =?us-ascii?Q?iiVov9OQH3PawZn7NWWq9MKKBXvsA0Bt5Qc3T/4YwdnToMfXm13c97Km/OYS?=
 =?us-ascii?Q?R0UaMz4VqWmUlarjucfmRY8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3107E8361E170D458B0939BF8F8F0EA3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D/Nw5YfNIBs8+vR0gMXQyvSr7AYc3yILx6nML8nJ3alb9Je9nBxa0kTxWjfwTfPARVrX6osYjsefFwa8CPW++Hpjc1b7ug453u6/2mGqdDxs+VRqRL9PdsTbOqFHTpdT+NV5UolEyo9HRPoOc+i40gPf1NIuObLy6RadE0h72EM//uNhmZD5ES3Q3L+VezyLul7CT7pKH2YvVQGmejBzNp3/FksxylmHdKikAOXwcAVTe9XHjZTLC8o/aFZfRlsXhfN0hxlwD99U9bvxw1SVK9sdz28KxgDzJHCe8TjzPG+CRI3tr2Td4+RKZdkFNdLX6FKDkfZfcei9KPZWepGcqx7e5zitUhTIpzSmlKq7xk4SZ5xQkK8RPhWLp6FWgwH4dUa6gzdGy6zjnAbDEdfjtWUJCunW7WUcuXwJ0NDKKD/PVg3ileQfRRF9CZmQLE6nmU5w2KQZhcAh0picIPVPF9w91lEi8G7V6J3SgefycozzpmK9+uDMXRUTZ1Rpz6mzDDBbATyjlVadaT7dUr6RN/+kkabtpvup06L5klWK113DLSfjVX7ZLE/Kztdm9vW2KJdNkFV+TWjBPEjbuHoCx8yXgvm5Wfq5OGoqEqb9ks70VyXJMGTILfUo0qLgX1OorWLq48SimOECH34M/X3gWNQFUVM/XFkPISDa1HvOeEQn6dE4WQqHYqWddVLHjEEcSIBPAQBYpnDMvklYt7ajC8zIZr6c/bJ7b273q7MZXLRpd0hkdkM5UtaJsNU2XjF0tFXuwDVPmejJhWJ2Q+SDstA1slOoRDoruAmYaIZ54GUjs/u/QoyD/3vmaQ9kLEQUFhmX52BTtSOZfsaawl44u/5l6oSbjaDLTDJ0PUGOHPg=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862742f1-e16f-448d-de32-08daf49189db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 11:38:34.6044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qiKjBmjO9e+oe82cjfjl0twts4JeQcGDpVYDFmioeBTP72woRsFGHc7nPoFGpnVCiznNUsJyP6sUg2oBQa/OysEHfS1AkdLgN437GRHwvHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5682
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I observed another KASAN uaf related to bfq. I would like to ask bfq expert=
s
to take a look in it. Whole KASAN message is attached below. It looks diffe=
rent
from another uaf fixed with 246cf66e300b ("block, bfq: fix uaf for bfqq in
bfq_exit_icq_bfqq").

It was observed first time during blktests test case block/027 run on kerne=
l
v6.2-rc3. Depending on test machines, it was recreated during system boot o=
r ssh
login occasionally. When I repeat system reboot and ssh-login twice, the ua=
f is
recreated.

I guess 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'") could=
 be
the trigger commit. I cherry-picked the two commits 64dc8c732f5c and
246cf66e300b on top of v6.1. With this kernel, I observed the KASAN uaf in
bic_set_bfqq.


BUG: KASAN: use-after-free in bic_set_bfqq+0x15f/0x190
device offline error, dev sdr, sector 245352968 op 0x0:(READ) flags 0x0 phy=
s_seg 1 prio class 2
Read of size 8 at addr ffff88811de85f88 by task in:imjournal/815

CPU: 5 PID: 815 Comm: in:imjournal Not tainted 6.2.0-rc3-kts+ #1
Hardware name: Supermicro Super Server/X10SRL-F, BIOS 3.2 11/22/2019
Call Trace:
 <TASK>
 dump_stack_lvl+0x5b/0x77
 print_report+0x182/0x47e
 ? bic_set_bfqq+0x15f/0x190
 ? bic_set_bfqq+0x15f/0x190
 kasan_report+0xbb/0xf0
 ? bic_set_bfqq+0x15f/0x190
 bic_set_bfqq+0x15f/0x190
 bfq_bic_update_cgroup+0x386/0x950
 bfq_bio_merge+0x132/0x2c0
 ? __pfx_bfq_bio_merge+0x10/0x10
 blk_mq_submit_bio+0xc5c/0x1b40
 ? __pfx_blk_mq_submit_bio+0x10/0x10
 ? find_held_lock+0x2d/0x110
 __submit_bio+0x24d/0x2c0
 ? __pfx___submit_bio+0x10/0x10
 submit_bio_noacct_nocheck+0x5b1/0x820
 ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
 ? rcu_read_lock_sched_held+0x3f/0x80
 ext4_io_submit+0x86/0x110
 ext4_do_writepages+0xb97/0x2f70
 ? __pfx_ext4_do_writepages+0x10/0x10
 ? lock_is_held_type+0xe3/0x140
 ext4_writepages+0x21c/0x4b0
 ? __pfx_ext4_writepages+0x10/0x10
 ? __lock_acquire+0xc75/0x5520
 do_writepages+0x166/0x630
 ? __pfx_do_writepages+0x10/0x10
 ? lock_release+0x365/0x730
 ? wbc_attach_and_unlock_inode+0x3a3/0x780
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_lock_acquire+0x10/0x10
 ? do_raw_spin_unlock+0x54/0x1f0
 ? _raw_spin_unlock+0x29/0x50
 ? wbc_attach_and_unlock_inode+0x3a3/0x780
 filemap_fdatawrite_wbc+0x111/0x170
 ? kfree+0x115/0x190
 __filemap_fdatawrite_range+0x9a/0xc0
 ? __pfx___filemap_fdatawrite_range+0x10/0x10
 ? __pfx_ext4_find_entry+0x10/0x10
 ? __pfx___dquot_initialize+0x10/0x10
 ? rcu_read_lock_sched_held+0x3f/0x80
 ? ext4_alloc_da_blocks+0x177/0x210
 ext4_rename+0x1123/0x23d0
 ? __pfx_ext4_rename+0x10/0x10
 ? __pfx___lock_acquire+0x10/0x10
 ? lock_acquire+0x1a4/0x4f0
 ? down_write_nested+0x141/0x200
 ? ext4_rename2+0x88/0x200
 vfs_rename+0xa6e/0x14f0
 ? __pfx_lock_release+0x10/0x10
 ? hook_file_open+0x780/0x790
 ? __pfx_vfs_rename+0x10/0x10
 ? __d_lookup+0x1fd/0x330
 ? d_lookup+0x37/0x50
 ? security_path_rename+0x111/0x1e0
 do_renameat2+0x81c/0xa00
 ? __pfx_do_renameat2+0x10/0x10
 ? lock_release+0x365/0x730
 ? __might_fault+0xbc/0x160
 ? __pfx_lock_release+0x10/0x10
 ? getname_flags.part.0+0x8d/0x430
 ? lockdep_hardirqs_on_prepare+0x17b/0x410
 __x64_sys_rename+0x7d/0xa0
 do_syscall_64+0x5b/0x80
 ? lockdep_hardirqs_on+0x7d/0x100
 ? do_syscall_64+0x67/0x80
 ? do_syscall_64+0x67/0x80
 ? lockdep_hardirqs_on+0x7d/0x100
 ? do_syscall_64+0x67/0x80
 ? do_syscall_64+0x67/0x80
 ? lockdep_hardirqs_on+0x7d/0x100
 ? do_syscall_64+0x67/0x80
 ? do_syscall_64+0x67/0x80
 ? do_syscall_64+0x67/0x80
 ? lockdep_hardirqs_on+0x7d/0x100
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f8a2a5e3eab
Code: e8 ba 2a 0a 00 f7 d8 19 c0 5b c3 0f 1f 40 00 b8 ff ff ff ff 5b c3 66 =
0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 52 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 05
+c3 0f 1f 40 00 48 8b 15 51 8f 17 00 f7 d8
RSP: 002b:00007f8a213fcc28 EFLAGS: 00000206 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f8a1c00c640 RCX: 00007f8a2a5e3eab
RDX: 0000000000000001 RSI: 000055d94c238820 RDI: 00007f8a213fcc30
RBP: 00007f8a213fcc30 R08: 0000000000000000 R09: 00007f8a1c000130
R10: 0000000000000000 R11: 0000000000000206 R12: 00007f8a1c00b480
R13: 0000000000000067 R14: 00007f8a213fdce0 R15: 00007f8a1c00b180
 </TASK>

Allocated by task 815:
 kasan_save_stack+0x1c/0x40
 kasan_set_track+0x21/0x30
 __kasan_slab_alloc+0x88/0x90
 kmem_cache_alloc_node+0x175/0x420

--=20
Shin'ichiro Kawasaki=
