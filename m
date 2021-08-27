Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE7AC432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 04:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5079E608FB
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 04:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhH0Euc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 00:50:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28794 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhH0Euc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 00:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630039783; x=1661575783;
  h=from:to:subject:date:message-id:references:mime-version;
  bh=F3EQrwCC+SMtajRty/02JjLV12F1R/9k1+lIJTL2TTk=;
  b=pYzDye1o87mP6neqqhquRUrUD22MXIuX+7FU4xmZ9igwd5Wf6qsAhtIp
   KSCQ2e569hvvDezVSTFaONkymefEVQym2eBicAm64R33rEgcPC2n+pjOU
   UzaK44RROdUaQzqG2S4WVdytkFNXxcbYlW9HJNtO8HChJiBFOY/l+4Byd
   d0sRPxAbnTSjMjEcVFdN6Z59rRhRf8kQX+V/HSD+kT5bQGxQoI2Uas+uJ
   Dy8aB4hbiPrmwHwQzKgUq5nEy1nLSRkdtrgfJrJXz5YzdnmkH93F1pVlg
   RFkA77dgvxtSb1357kvvpKkjqjVOdZ+Yf8lPch2byoVxiraDXOe8tKOwx
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,355,1620662400"; 
   d="scan'208,223";a="183330392"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2021 12:49:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nty3OVk8yvbU9Qmyj3DP7+uw7KG5nJlEuMlmfZyUgcdZf0+95SbjH59RgKntpTr/tz73hVsEpI43wGCQBOBMbR7g/iEo5SJEUIAe0RUc4XonvLCQs3Ez7gUF7v9S+MunwQDqdQ4rd2Pqi60AiInGN+Z2bnFy3In9d8A+j1xhxxdF56ABOLdebh+xfno/743sZV9LZB/PzrOtOmSPE+qAvYLLoCQWVQS1rT1ArlcKkXnECfsqyHXuXVSTi4CXVSegWHIGFLHFdy7t6Qt8TMjwJPwI5UsyWOpOfrs/NSuFlyt0OR5Lr/px9JiVZY5plwoV6wywusaw7qFMM/bAm/55FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYEofNUhCqr/t2fjlncbLCFvPKZyhnoSdrZRD3jlq/o=;
 b=MHrJibXsL3wUDFkppHvGJdHOE7w0JPf4ScKaiRjAG1LYgXqhUM4oIz52emhbeosCs2ZxTS2/yD/EpCBXnPsYffj0WzfuZPgt1+BXiQ1BiA9eNaLkaYWfFkjLcQEU2kkSNFfIJnROwCePKuaib7pDN80axU9MFP9Ig1V5NWrnvl6+KOwe9QE9SbE9vxGN/k2JdOF2k+P3OvIHqQFpMkDquRYYricOtpoxQh2Z3gc9ruYGhZKDFLrMQz1DsveP09cSNFHFbtY+FQfZz0kHbSsd90rFwJPUYNp6lZmPXtosK5t5enW3RKb/2V0yf/6JAK1tvHv3vnvYHXFYVEp2fFlQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYEofNUhCqr/t2fjlncbLCFvPKZyhnoSdrZRD3jlq/o=;
 b=sHbFh0YeAvNB2F2ZytB9LL3qZ9ADfm5/+itcw6lBnM9P/5uKYIiDU/XvkEivTrItAm6sTWQ3peXw7SkpohhNwgrbM2ooXCGFJVWbYZAcg6GPMIz1La6PE/DcDU8rZPx9s+/ULqjB3LEhaZycAnwgbbl3uuipnuDyyq2+FoesLwA=
Received: from CH2PR04MB7078.namprd04.prod.outlook.com (2603:10b6:610:98::9)
 by CH2PR04MB6743.namprd04.prod.outlook.com (2603:10b6:610:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 04:49:41 +0000
Received: from CH2PR04MB7078.namprd04.prod.outlook.com
 ([fe80::db:f463:b03c:b3d5]) by CH2PR04MB7078.namprd04.prod.outlook.com
 ([fe80::db:f463:b03c:b3d5%7]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 04:49:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
Thread-Topic: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
Thread-Index: AQHXmohup054y2Fbq0CVF3wAgGvrJg==
Date:   Fri, 27 Aug 2021 04:49:41 +0000
Message-ID: <CH2PR04MB7078A227EF9087A45CF4535EE7C89@CH2PR04MB7078.namprd04.prod.outlook.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
 <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
 <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
 <dd1f2b01-abe5-4e6f-14cf-c3bef90eb6f9@kernel.dk>
 <fdd60ef5-285c-964b-818a-6e0ee0481751@acm.org>
 <6ad27546-d61f-a98a-1633-9a4808a829ba@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdc82c59-db3c-4e9c-9558-08d969161534
x-ms-traffictypediagnostic: CH2PR04MB6743:
x-microsoft-antispam-prvs: <CH2PR04MB674326F53783971EE577279CE7C89@CH2PR04MB6743.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Vb4EQkwvF+US1Y7T1aGs8SDRW5up95mCOmEqAeISFtXYQp1wvSn3FZwU9lswh7uZCkiKvNJ869Ci6tN6G5+mP0O5alAEW4j9wdUHKF4woYEOGJSdvp9BZ1Bi0O66Zv/+FlGgbQm4Dfi2j0YNhTX8pOa7+7XbGdKzSV3X0GR0poLxgPS+p3aj7MNqMghyzmj1FjOPtJbGsqZ+QTmNqA/YNVWRvvLpN9FynDzztoUN81fnXJC/zEBinLAhPtkieAN5L9F60VcfZ8efJ24oz9Z2owNZC30phE3MUriSIAlsDazjKQBArVFxG48mTDCnt+QJcSj8cY/EIhMm5roO9HSlBFcteKbv7wasX/88/cRPZM9+av+hMdfAXC/JGCEvGwma4iucqk94rJgCoRNX1rqmMUP7GdHoFigqmI8QXMHMnNnYBDd2sDIdFPxCAWeYmarLKNECF+LfWLhi22xxjfDM4Gkgi2FwtuN3xnNkqpLZk2vi1soy5BeRZCwoIPNQ3nnC0CpGap5tm49Vmms0/a6ABPTofT1/J+XjabGEhOOQFICyoqjgik0p4ujM7m6hC5b/u0kLgAO2Lk3CAAiEyJTaZlfg34pl+CKcWWs4tZ4yPrvuSPISpKSU9qoZn0+QJ3UrLUVNl2y4Qk+RQIoUdSvHj2D7MOhsWxSCy+aYuk2kQMRaKqG8PRitfPhs4qSZNLqUIHrnIlcZ9YwFy9ZWe0tFi7Q5g5forJbb8vWyWyRHi5DYqEApRvi7AKcH20DJLnxwBGIbXU66twM66PtaAi1vW1Kz7G03+Jz/QakD1dg338=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB7078.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(45080400002)(7696005)(966005)(2906002)(478600001)(76116006)(91956017)(66946007)(99936003)(5660300002)(9686003)(86362001)(66476007)(66616009)(66556008)(64756008)(66446008)(71200400001)(83380400001)(186003)(55016002)(33656002)(8676002)(53546011)(6506007)(122000001)(8936002)(38070700005)(52536014)(316002)(38100700002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NAGcN+R6jgmwRKJalklw0DCcCAlCkB6+BwRY1bn0UtDRlEzgBzBIWdAfgmNO?=
 =?us-ascii?Q?P8otETVrbT6catnBg9hi50FpC2oAg65HoEQAo4uKWhf7ZDMZ7997d0efhFpD?=
 =?us-ascii?Q?0TuO3YBstYyKMajJ67CHf7un393t3BKtoh2R0oPjkUdaxLz0dhyFwRpYJsxs?=
 =?us-ascii?Q?0YM5mHVVevOv/C1PY0L3Vm1RHeVE23K17RWnHzW4DAXg5A5OIlgv5kro2PdD?=
 =?us-ascii?Q?c4A8efeVd2xMAn2Y5NSe1lhYaT16E6kcOECwJaRu4Cg/UBFZL5df/uUWxTLp?=
 =?us-ascii?Q?wtSJypXvkioVZgcaAqjO/En9FmGVziBgIJlFbu+jXtH7HVf5YTt3cQPVdGbe?=
 =?us-ascii?Q?PEMlVg9SORsI23K2OKfPW2qFZvmmNIcxoelT1JHKVhBiXHoKHBo77C6s4C+u?=
 =?us-ascii?Q?kFRaVexD1OCjQrbWTZpYSxHutafOHsRGm+VRGnfBsiCJB5ohL4fuTOMbmWQm?=
 =?us-ascii?Q?eXnWNVJb7U5upWzYVT5iT1KgS3oyDwkwXTM86qmjB70paf9TvD43WYbOCPlR?=
 =?us-ascii?Q?3YZyfEN7JX0xqKB5h+ZSUenMn5mbcHMJVVZSkZfDQZrtyNdfIeH2kVW5v2jg?=
 =?us-ascii?Q?RowCI/2jbk7BHZwsvwpZFG4VLe9s2nMjzEXcmXQ9gE06neuiUZEI+nnmoxbo?=
 =?us-ascii?Q?4nZjdmJQcKmuHSDNwpiSzPPWQAibAs+NBkTf/ieQdHZCrFTF42S7+4XbJMfR?=
 =?us-ascii?Q?QwnNUtPz6tGWS5rtg2dmNTdva0sU5fzl22hWwm03loPDcyhLTgc2dm78CPm+?=
 =?us-ascii?Q?D4w6IKIJWSa0fkf0IPALYCKRkzpwIIc4FsK1453wyNbgp6jcT+97Qa8guiHp?=
 =?us-ascii?Q?NSPQJUkuT3xkMSq7TlDG3EJUyjEoQgaXHFRu/GrdrvXIFHEYhQY6VnWl84OD?=
 =?us-ascii?Q?1ip618cGyXnzugp6rphBG27naJaKacgC6aSQks+4JA9M3CDMd3d3PgkUJqJL?=
 =?us-ascii?Q?DmOn+K91ORCE/6bF/W0J/Clhr/NVLRPWMc1dQOf4PpEUn/O2A2zQFTyX+I4M?=
 =?us-ascii?Q?vgqConSLvh9Pr1RmAoAk32Tx5b/oP0RKoot8mjLsqCeDNn+Jg32pboz/Hmis?=
 =?us-ascii?Q?E6vfR17u/wnn3SV715uz7y8lVln6cgBXYpJT/qTWqW28OB4P3+mxh6aIADoB?=
 =?us-ascii?Q?2A7eNG07EkSaMYy9+ocZhwqaam6A4O3t0LYUX8zbgS78bumeqyZggzYR9bFu?=
 =?us-ascii?Q?rGHQ7nsZoFf5+sVW+cUVesTe8AlGsOaybdo+Zf5sOOUWQqZR2EWszeMLHYYB?=
 =?us-ascii?Q?x3i9yYNv7oEvyxHyGI3AUB+oAIJ41S+77rhhUZ3M7WqPBjEosHTTZulEY3Cc?=
 =?us-ascii?Q?EcmszeeeyxjSN2E538yrs5EzN4azSsfQ9Zk88Dl+5ORQLG0+qxK/qzkdwofp?=
 =?us-ascii?Q?3l0XFQktRFUQqxWs+eSF1ZMdcuhdkCk5v1vJFUHafLt+ZZjV6A=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_CH2PR04MB7078A227EF9087A45CF4535EE7C89CH2PR04MB7078namp_"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB7078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc82c59-db3c-4e9c-9558-08d969161534
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 04:49:41.4853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amEZjNCk/+JyBiUMj2ucU3puZeV+UUupddAK4n6s1EGKIBVgKktbFQyd2k9uVdq5/eHQkA4TzbTeKe7EHIaVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6743
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--_002_CH2PR04MB7078A227EF9087A45CF4535EE7C89CH2PR04MB7078namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On 2021/08/27 12:13, Jens Axboe wrote:=0A=
> On 8/26/21 8:48 PM, Bart Van Assche wrote:=0A=
>> On 8/26/21 5:05 PM, Jens Axboe wrote:=0A=
>>> On 8/26/21 6:03 PM, Bart Van Assche wrote:=0A=
>>>> Here is an overview of the tests I ran so far, all on the same test=0A=
>>>> setup:=0A=
>>>> * No I/O scheduler:               about 5630 K IOPS.=0A=
>>>> * Kernel v5.11 + mq-deadline:     about 1100 K IOPS.=0A=
>>>> * block-for-next + mq-deadline:   about  760 K IOPS.=0A=
>>>> * block-for-next with improved mq-deadline performance: about 970 K IO=
PS.=0A=
>>>=0A=
>>> So we're still off by about 12%, I don't think that is good enough.=0A=
>>> That's assuming that v5.11 + mq-deadline is the same as for-next with=
=0A=
>>> the mq-deadline change reverted? Because that would be the key number t=
o=0A=
>>> compare it with.=0A=
>>=0A=
>> With the patch series that is available at=0A=
>> https://github.com/bvanassche/linux/tree/block-for-next the same test re=
ports=0A=
>> 1090 K IOPS or only 1% below the v5.11 result. I will post that series o=
n the=0A=
>> linux-block mailing list after I have finished testing that series.=0A=
> =0A=
> OK sounds good. I do think we should just do the revert at this point,=0A=
> any real fix is going to end up being bigger than I'd like at this=0A=
> point. Then we can re-introduce the feature once we're happy with the=0A=
> results.=0A=
=0A=
FYI, here is what I get with Bart's test script running on a dual socket=0A=
8-cores/16-threads Xeon machine (32 CPUs total):=0A=
=0A=
* 5.14.0-rc7, with fb926032b320 reverted:=0A=
-----------------------------------------=0A=
=0A=
QD 1: IOPS=3D305k (*)=0A=
QD 2: IOPS=3D411k=0A=
QD 4: IOPS=3D408k=0A=
QD 8: IOPS=3D414k=0A=
=0A=
* 5.14.0-rc7, current (no modification):=0A=
----------------------------------------=0A=
=0A=
QD 1: IOPS=3D296k (*)=0A=
QD 2: IOPS=3D207k=0A=
QD 4: IOPS=3D208k=0A=
QD 8: IOPS=3D210k=0A=
=0A=
* 5.14.0-rc7, with modified patch (attached to this email):=0A=
-----------------------------------------------------------=0A=
=0A=
QD 1: IOPS=3D287k (*)=0A=
QD 2: IOPS=3D334k=0A=
QD 4: IOPS=3D330k=0A=
QD 8: IOPS=3D334k=0A=
=0A=
For reference, with the same test script using the none scheduler:=0A=
=0A=
QD 1: IOPS=3D2172K=0A=
QD 2: IOPS=3D1075K=0A=
QD 4: IOPS=3D1075k=0A=
QD 8: IOPS=3D1077k=0A=
=0A=
So the mq-deadline priority patch reduces performance by nearly half at hig=
h QD.=0A=
With the modified patch, we are back to better numbers, but still a signifi=
cant=0A=
20% drop at high QD.=0A=
=0A=
(*) Note: in all cases using the mq-deadline scheduler, for the first run a=
t=0A=
QD=3D1, I get this splat 100% of the time.=0A=
=0A=
[   95.173889] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kworker/0=
:1H:757]=0A=
[   95.181351] Modules linked in: null_blk rpcsec_gss_krb5 auth_rpcgss nfsv=
4=0A=
dns_resolver nfs lockd grace fscache netfs nft_fib_inet nft_fib_ipv4=0A=
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reje=
ct=0A=
nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_s=
et=0A=
nf_tables libcrc32c nfnetlink sunrpc vfat fat iTCO_wdt iTCO_vendor_support=
=0A=
ipmi_ssif x86_pkg_temp_thermal coretemp i2c_i801 acpi_ipmi bfq i2c_smbus io=
atdma=0A=
lpc_ich ipmi_si intel_pch_thermal dca ipmi_devintf ipmi_msghandler=0A=
acpi_power_meter fuse ip_tables sd_mod ast i2c_algo_bit drm_vram_helper=0A=
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper=
 ttm=0A=
drm i40e crct10dif_pclmul mpt3sas crc32_pclmul ahci ghash_clmulni_intel lib=
ahci=0A=
raid_class scsi_transport_sas libata pkcs8_key_parser=0A=
[   95.252173] irq event stamp: 30500990=0A=
[   95.255860] hardirqs last  enabled at (30500989): [<ffffffff81910e2d>]=
=0A=
_raw_spin_unlock_irqrestore+0x2d/0x40=0A=
[   95.265735] hardirqs last disabled at (30500990): [<ffffffff819050cb>]=
=0A=
sysvec_apic_timer_interrupt+0xb/0x90=0A=
[   95.275520] softirqs last  enabled at (30496338): [<ffffffff810b331f>]=
=0A=
__irq_exit_rcu+0xbf/0xe0=0A=
[   95.284259] softirqs last disabled at (30496333): [<ffffffff810b331f>]=
=0A=
__irq_exit_rcu+0xbf/0xe0=0A=
[   95.292994] CPU: 0 PID: 757 Comm: kworker/0:1H Not tainted 5.14.0-rc7+ #=
1334=0A=
[   95.300076] Hardware name: Supermicro Super Server/X11DPL-i, BIOS 3.3 02=
/21/2020=0A=
[   95.307504] Workqueue: kblockd blk_mq_run_work_fn=0A=
[   95.312243] RIP: 0010:_raw_spin_unlock_irqrestore+0x35/0x40=0A=
[   95.317844] Code: c7 18 53 48 89 f3 48 8b 74 24 10 e8 35 82 80 ff 48 89 =
ef e8=0A=
9d ac 80 ff 80 e7 02 74 06 e8 23 33 8b ff fb 65 ff 0d 8b 5f 70 7e <5b> 5d c=
3 0f=0A=
1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 fd 65 ff=0A=
[   95.336680] RSP: 0018:ffff888448cefbb0 EFLAGS: 00000202=0A=
[   95.341934] RAX: 0000000001d1687d RBX: 0000000000000287 RCX: 00000000000=
00006=0A=
[   95.349103] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff819=
10e2d=0A=
[   95.356270] RBP: ffff888192649218 R08: 0000000000000001 R09: 00000000000=
00001=0A=
[   95.363437] R10: 0000000000000000 R11: 000000000000005c R12: 00000000000=
00000=0A=
[   95.370604] R13: 0000000000000287 R14: ffff888192649218 R15: ffff88885fe=
68e80=0A=
[   95.377771] FS:  0000000000000000(0000) GS:ffff88885fe00000(0000)=0A=
knlGS:0000000000000000=0A=
[   95.385901] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[   95.391675] CR2: 00007f59bfe71f80 CR3: 000000074a91e005 CR4: 00000000007=
706f0=0A=
[   95.398842] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000=0A=
[   95.406009] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400=0A=
[   95.413176] PKRU: 55555554=0A=
[   95.415904] Call Trace:=0A=
[   95.418373]  try_to_wake_up+0x268/0x7c0=0A=
[   95.422238]  blk_update_request+0x25b/0x420=0A=
[   95.426452]  blk_mq_end_request+0x1c/0x120=0A=
[   95.430576]  null_handle_cmd+0x12d/0x270 [null_blk]=0A=
[   95.435485]  blk_mq_dispatch_rq_list+0x13c/0x7f0=0A=
[   95.440130]  ? sbitmap_get+0x86/0x190=0A=
[   95.443826]  __blk_mq_do_dispatch_sched+0xb5/0x2f0=0A=
[   95.448653]  __blk_mq_sched_dispatch_requests+0xf4/0x140=0A=
[   95.453998]  blk_mq_sched_dispatch_requests+0x30/0x60=0A=
[   95.459083]  __blk_mq_run_hw_queue+0x49/0x90=0A=
[   95.463377]  process_one_work+0x26c/0x570=0A=
[   95.467421]  worker_thread+0x55/0x3c0=0A=
[   95.471103]  ? process_one_work+0x570/0x570=0A=
[   95.475313]  kthread+0x140/0x160=0A=
[   95.478567]  ? set_kthread_struct+0x40/0x40=0A=
[   95.482774]  ret_from_fork+0x1f/0x30=0A=
=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

--_002_CH2PR04MB7078A227EF9087A45CF4535EE7C89CH2PR04MB7078namp_
Content-Type: text/plain;
	name="0001-block-mq-deadline-Speed-up-the-dispatch-of-low-prior.patch"
Content-Description:
 0001-block-mq-deadline-Speed-up-the-dispatch-of-low-prior.patch
Content-Disposition: attachment;
	filename="0001-block-mq-deadline-Speed-up-the-dispatch-of-low-prior.patch";
	size=9575; creation-date="Fri, 27 Aug 2021 04:49:40 GMT";
	modification-date="Fri, 27 Aug 2021 04:49:40 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyYWMyYWYyYjEzMTZhZGM5MzRkMGU2OTk5ODU1NjdkZWQ1OTVmZTI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGVuIExlaSA8dGh1bmRlci5sZWl6aGVuQGh1YXdlaS5jb20+
CkRhdGU6IFRodSwgMjYgQXVnIDIwMjEgMjI6NDA6MzkgKzA4MDAKU3ViamVjdDogW1BBVENIXSBi
bG9jay9tcS1kZWFkbGluZTogU3BlZWQgdXAgdGhlIGRpc3BhdGNoIG9mIGxvdy1wcmlvcml0eQog
cmVxdWVzdHMKCmRkX3F1ZXVlZCgpIHRyYXZlcnNlcyB0aGUgcGVyY3B1IHZhcmlhYmxlIGZvciBz
dW1tYXRpb24uIFRoZSBtb3JlIGNvcmVzLAp0aGUgaGlnaGVyIHRoZSBwZXJmb3JtYW5jZSBvdmVy
aGVhZC4gSSBjdXJyZW50bHkgaGF2ZSBhIDEyOC1jb3JlIGJvYXJkIGFuZAp0aGlzIGZ1bmN0aW9u
IHRha2VzIDIuNSB1cy4gSWYgdGhlIG51bWJlciBvZiBoaWdoLXByaW9yaXR5IHJlcXVlc3RzIGlz
CnNtYWxsIGFuZCB0aGUgbnVtYmVyIG9mIGxvdy0gYW5kIG1lZGl1bS1wcmlvcml0eSByZXF1ZXN0
cyBpcyBsYXJnZSwgdGhlCnBlcmZvcm1hbmNlIGltcGFjdCBpcyBzaWduaWZpY2FudC4KCkxldCdz
IG1haW50YWluIGEgbm9uLXBlcmNwdSBtZW1iZXIgdmFyaWFibGUgJ25yX3F1ZXVlZCcsIHdoaWNo
IGlzCmluY3JlbWVudGVkIGJ5IDEgaW1tZWRpYXRlbHkgZm9sbG93aW5nICJpbnNlcnRlZCsrIiBh
bmQgZGVjcmVtZW50ZWQgYnkgMQppbW1lZGlhdGVseSBmb2xsb3dpbmcgImNvbXBsZXRlZCsrIi4g
QmVjYXVzZSBib3RoIHRoZSBqdWRnbWVudCBkZF9xdWV1ZWQoKQppbiBkZF9kaXNwYXRjaF9yZXF1
ZXN0KCkgYW5kIG9wZXJhdGlvbiAiaW5zZXJ0ZWQrKyIgaW4gZGRfaW5zZXJ0X3JlcXVlc3QoKQph
cmUgcHJvdGVjdGVkIGJ5IGRkLT5sb2NrLCBsb2NrIHByb3RlY3Rpb24gbmVlZHMgdG8gYmUgYWRk
ZWQgb25seSBpbgpkZF9maW5pc2hfcmVxdWVzdCgpLCB3aGljaCBpcyB1bmxpa2VseSB0byBjYXVz
ZSBzaWduaWZpY2FudCBwZXJmb3JtYW5jZQpzaWRlIGVmZmVjdHMuCgpUZXN0ZWQgb24gbXkgMTI4
LWNvcmUgYm9hcmQgd2l0aCB0d28gc3NkIGRpc2tzLgpmaW8gYnM9NGsgcnc9cmVhZCBpb2RlcHRo
PTEyOCBjcHVzX2FsbG93ZWQ9MC05NSA8b3RoZXJzPgpCZWZvcmU6ClsxODNLLzAvMCBpb3BzXQpb
MTcySy8wLzAgaW9wc10KCkFmdGVyOgpbMjU4Sy8wLzAgaW9wc10KWzI1OEsvMC8wIGlvcHNdCgpG
aXhlczogZmI5MjYwMzJiMzIwICgiYmxvY2svbXEtZGVhZGxpbmU6IFByaW9yaXRpemUgaGlnaC1w
cmlvcml0eSByZXF1ZXN0cyIpClNpZ25lZC1vZmYtYnk6IFpoZW4gTGVpIDx0aHVuZGVyLmxlaXpo
ZW5AaHVhd2VpLmNvbT4KU2lnbmVkLW9mZi1ieTogRGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1v
YWxAd2RjLmNvbT4KLS0tCiBibG9jay9tcS1kZWFkbGluZS5jIHwgODEgKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDMgaW5zZXJ0
aW9ucygrKSwgMzggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svbXEtZGVhZGxpbmUu
YyBiL2Jsb2NrL21xLWRlYWRsaW5lLmMKaW5kZXggYTA5NzYxY2JkZjEyLi4wZDg3OWYzZmYzNDAg
MTAwNjQ0Ci0tLSBhL2Jsb2NrL21xLWRlYWRsaW5lLmMKKysrIGIvYmxvY2svbXEtZGVhZGxpbmUu
YwpAQCAtNzksNiArNzksNyBAQCBzdHJ1Y3QgZGRfcGVyX3ByaW8gewogCXN0cnVjdCBsaXN0X2hl
YWQgZmlmb19saXN0W0REX0RJUl9DT1VOVF07CiAJLyogTmV4dCByZXF1ZXN0IGluIEZJRk8gb3Jk
ZXIuIFJlYWQsIHdyaXRlIG9yIGJvdGggYXJlIE5VTEwuICovCiAJc3RydWN0IHJlcXVlc3QgKm5l
eHRfcnFbRERfRElSX0NPVU5UXTsKKwl1bnNpZ25lZCBpbnQgbnJfcXVldWVkOwogfTsKIAogc3Ry
dWN0IGRlYWRsaW5lX2RhdGEgewpAQCAtMTA2LDcgKzEwNyw2IEBAIHN0cnVjdCBkZWFkbGluZV9k
YXRhIHsKIAlpbnQgYWdpbmdfZXhwaXJlOwogCiAJc3BpbmxvY2tfdCBsb2NrOwotCXNwaW5sb2Nr
X3Qgem9uZV9sb2NrOwogfTsKIAogLyogQ291bnQgb25lIGV2ZW50IG9mIHR5cGUgJ2V2ZW50X3R5
cGUnIGFuZCB3aXRoIEkvTyBwcmlvcml0eSAncHJpbycgKi8KQEAgLTI3NiwxMCArMjc2LDEyIEBA
IGRlYWRsaW5lX21vdmVfcmVxdWVzdChzdHJ1Y3QgZGVhZGxpbmVfZGF0YSAqZGQsIHN0cnVjdCBk
ZF9wZXJfcHJpbyAqcGVyX3ByaW8sCiAJZGVhZGxpbmVfcmVtb3ZlX3JlcXVlc3QocnEtPnEsIHBl
cl9wcmlvLCBycSk7CiB9CiAKLS8qIE51bWJlciBvZiByZXF1ZXN0cyBxdWV1ZWQgZm9yIGEgZ2l2
ZW4gcHJpb3JpdHkgbGV2ZWwuICovCi1zdGF0aWMgdTMyIGRkX3F1ZXVlZChzdHJ1Y3QgZGVhZGxp
bmVfZGF0YSAqZGQsIGVudW0gZGRfcHJpbyBwcmlvKQorLyoKKyAqIE51bWJlciBvZiByZXF1ZXN0
cyBxdWV1ZWQgZm9yIGEgZ2l2ZW4gcHJpb3JpdHkgbGV2ZWwuCisgKi8KK3N0YXRpYyBpbmxpbmUg
dTMyIGRkX3F1ZXVlZChzdHJ1Y3QgZGVhZGxpbmVfZGF0YSAqZGQsIGVudW0gZGRfcHJpbyBwcmlv
KQogewotCXJldHVybiBkZF9zdW0oZGQsIGluc2VydGVkLCBwcmlvKSAtIGRkX3N1bShkZCwgY29t
cGxldGVkLCBwcmlvKTsKKwlyZXR1cm4gZGQtPnBlcl9wcmlvW3ByaW9dLm5yX3F1ZXVlZDsKIH0K
IAogLyoKQEAgLTMwOSw3ICszMTEsNiBAQCBkZWFkbGluZV9maWZvX3JlcXVlc3Qoc3RydWN0IGRl
YWRsaW5lX2RhdGEgKmRkLCBzdHJ1Y3QgZGRfcGVyX3ByaW8gKnBlcl9wcmlvLAogCQkgICAgICBl
bnVtIGRkX2RhdGFfZGlyIGRhdGFfZGlyKQogewogCXN0cnVjdCByZXF1ZXN0ICpycTsKLQl1bnNp
Z25lZCBsb25nIGZsYWdzOwogCiAJaWYgKGxpc3RfZW1wdHkoJnBlcl9wcmlvLT5maWZvX2xpc3Rb
ZGF0YV9kaXJdKSkKIAkJcmV0dXJuIE5VTEw7CkBAIC0zMjIsMTYgKzMyMywxMiBAQCBkZWFkbGlu
ZV9maWZvX3JlcXVlc3Qoc3RydWN0IGRlYWRsaW5lX2RhdGEgKmRkLCBzdHJ1Y3QgZGRfcGVyX3By
aW8gKnBlcl9wcmlvLAogCSAqIExvb2sgZm9yIGEgd3JpdGUgcmVxdWVzdCB0aGF0IGNhbiBiZSBk
aXNwYXRjaGVkLCB0aGF0IGlzIG9uZSB3aXRoCiAJICogYW4gdW5sb2NrZWQgdGFyZ2V0IHpvbmUu
CiAJICovCi0Jc3Bpbl9sb2NrX2lycXNhdmUoJmRkLT56b25lX2xvY2ssIGZsYWdzKTsKIAlsaXN0
X2Zvcl9lYWNoX2VudHJ5KHJxLCAmcGVyX3ByaW8tPmZpZm9fbGlzdFtERF9XUklURV0sIHF1ZXVl
bGlzdCkgewogCQlpZiAoYmxrX3JlcV9jYW5fZGlzcGF0Y2hfdG9fem9uZShycSkpCi0JCQlnb3Rv
IG91dDsKKwkJCXJldHVybiBycTsKIAl9Ci0JcnEgPSBOVUxMOwotb3V0OgotCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJmRkLT56b25lX2xvY2ssIGZsYWdzKTsKIAotCXJldHVybiBycTsKKwlyZXR1
cm4gTlVMTDsKIH0KIAogLyoKQEAgLTM0Myw3ICszNDAsNiBAQCBkZWFkbGluZV9uZXh0X3JlcXVl
c3Qoc3RydWN0IGRlYWRsaW5lX2RhdGEgKmRkLCBzdHJ1Y3QgZGRfcGVyX3ByaW8gKnBlcl9wcmlv
LAogCQkgICAgICBlbnVtIGRkX2RhdGFfZGlyIGRhdGFfZGlyKQogewogCXN0cnVjdCByZXF1ZXN0
ICpycTsKLQl1bnNpZ25lZCBsb25nIGZsYWdzOwogCiAJcnEgPSBwZXJfcHJpby0+bmV4dF9ycVtk
YXRhX2Rpcl07CiAJaWYgKCFycSkKQEAgLTM1NiwxNSArMzUyLDEzIEBAIGRlYWRsaW5lX25leHRf
cmVxdWVzdChzdHJ1Y3QgZGVhZGxpbmVfZGF0YSAqZGQsIHN0cnVjdCBkZF9wZXJfcHJpbyAqcGVy
X3ByaW8sCiAJICogTG9vayBmb3IgYSB3cml0ZSByZXF1ZXN0IHRoYXQgY2FuIGJlIGRpc3BhdGNo
ZWQsIHRoYXQgaXMgb25lIHdpdGgKIAkgKiBhbiB1bmxvY2tlZCB0YXJnZXQgem9uZS4KIAkgKi8K
LQlzcGluX2xvY2tfaXJxc2F2ZSgmZGQtPnpvbmVfbG9jaywgZmxhZ3MpOwogCXdoaWxlIChycSkg
ewogCQlpZiAoYmxrX3JlcV9jYW5fZGlzcGF0Y2hfdG9fem9uZShycSkpCi0JCQlicmVhazsKKwkJ
CXJldHVybiBycTsKIAkJcnEgPSBkZWFkbGluZV9sYXR0ZXJfcmVxdWVzdChycSk7CiAJfQotCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmRkLT56b25lX2xvY2ssIGZsYWdzKTsKIAotCXJldHVybiBy
cTsKKwlyZXR1cm4gTlVMTDsKIH0KIAogLyoKQEAgLTQ5Nyw4ICs0OTEsMTAgQEAgc3RhdGljIHN0
cnVjdCByZXF1ZXN0ICpkZF9kaXNwYXRjaF9yZXF1ZXN0KHN0cnVjdCBibGtfbXFfaHdfY3R4ICpo
Y3R4KQogCWNvbnN0IHU2NCBub3dfbnMgPSBrdGltZV9nZXRfbnMoKTsKIAlzdHJ1Y3QgcmVxdWVz
dCAqcnEgPSBOVUxMOwogCWVudW0gZGRfcHJpbyBwcmlvOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
CisKKwlzcGluX2xvY2tfaXJxc2F2ZSgmZGQtPmxvY2ssIGZsYWdzKTsKIAotCXNwaW5fbG9jaygm
ZGQtPmxvY2spOwogCS8qCiAJICogU3RhcnQgd2l0aCBkaXNwYXRjaGluZyByZXF1ZXN0cyB3aG9z
ZSBkZWFkbGluZSBleHBpcmVkIG1vcmUgdGhhbgogCSAqIGFnaW5nX2V4cGlyZSBqaWZmaWVzIGFn
by4KQEAgLTUyMCw3ICs1MTYsNyBAQCBzdGF0aWMgc3RydWN0IHJlcXVlc3QgKmRkX2Rpc3BhdGNo
X3JlcXVlc3Qoc3RydWN0IGJsa19tcV9od19jdHggKmhjdHgpCiAJfQogCiB1bmxvY2s6Ci0Jc3Bp
bl91bmxvY2soJmRkLT5sb2NrKTsKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZC0+bG9jaywg
ZmxhZ3MpOwogCiAJcmV0dXJuIHJxOwogfQpAQCAtNjIyLDcgKzYxOCw2IEBAIHN0YXRpYyBpbnQg
ZGRfaW5pdF9zY2hlZChzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgc3RydWN0IGVsZXZhdG9yX3R5
cGUgKmUpCiAJZGQtPmZpZm9fYmF0Y2ggPSBmaWZvX2JhdGNoOwogCWRkLT5hZ2luZ19leHBpcmUg
PSBhZ2luZ19leHBpcmU7CiAJc3Bpbl9sb2NrX2luaXQoJmRkLT5sb2NrKTsKLQlzcGluX2xvY2tf
aW5pdCgmZGQtPnpvbmVfbG9jayk7CiAKIAlxLT5lbGV2YXRvciA9IGVxOwogCXJldHVybiAwOwpA
QCAtNjc1LDEwICs2NzAsMTEgQEAgc3RhdGljIGJvb2wgZGRfYmlvX21lcmdlKHN0cnVjdCByZXF1
ZXN0X3F1ZXVlICpxLCBzdHJ1Y3QgYmlvICpiaW8sCiAJc3RydWN0IGRlYWRsaW5lX2RhdGEgKmRk
ID0gcS0+ZWxldmF0b3ItPmVsZXZhdG9yX2RhdGE7CiAJc3RydWN0IHJlcXVlc3QgKmZyZWUgPSBO
VUxMOwogCWJvb2wgcmV0OworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKLQlzcGluX2xvY2soJmRk
LT5sb2NrKTsKKwlzcGluX2xvY2tfaXJxc2F2ZSgmZGQtPmxvY2ssIGZsYWdzKTsKIAlyZXQgPSBi
bGtfbXFfc2NoZWRfdHJ5X21lcmdlKHEsIGJpbywgbnJfc2VncywgJmZyZWUpOwotCXNwaW5fdW5s
b2NrKCZkZC0+bG9jayk7CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGQtPmxvY2ssIGZsYWdz
KTsKIAogCWlmIChmcmVlKQogCQlibGtfbXFfZnJlZV9yZXF1ZXN0KGZyZWUpOwpAQCAtNjkwLDcg
KzY4Niw3IEBAIHN0YXRpYyBib29sIGRkX2Jpb19tZXJnZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAq
cSwgc3RydWN0IGJpbyAqYmlvLAogICogYWRkIHJxIHRvIHJidHJlZSBhbmQgZmlmbwogICovCiBz
dGF0aWMgdm9pZCBkZF9pbnNlcnRfcmVxdWVzdChzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCwg
c3RydWN0IHJlcXVlc3QgKnJxLAotCQkJICAgICAgYm9vbCBhdF9oZWFkKQorCQkJICAgICAgYm9v
bCBhdF9oZWFkLCBzdHJ1Y3QgbGlzdF9oZWFkICpmcmVlKQogewogCXN0cnVjdCByZXF1ZXN0X3F1
ZXVlICpxID0gaGN0eC0+cXVldWU7CiAJc3RydWN0IGRlYWRsaW5lX2RhdGEgKmRkID0gcS0+ZWxl
dmF0b3ItPmVsZXZhdG9yX2RhdGE7CkBAIC02OTksNyArNjk1LDYgQEAgc3RhdGljIHZvaWQgZGRf
aW5zZXJ0X3JlcXVlc3Qoc3RydWN0IGJsa19tcV9od19jdHggKmhjdHgsIHN0cnVjdCByZXF1ZXN0
ICpycSwKIAl1OCBpb3ByaW9fY2xhc3MgPSBJT1BSSU9fUFJJT19DTEFTUyhpb3ByaW8pOwogCXN0
cnVjdCBkZF9wZXJfcHJpbyAqcGVyX3ByaW87CiAJZW51bSBkZF9wcmlvIHByaW87Ci0JTElTVF9I
RUFEKGZyZWUpOwogCiAJbG9ja2RlcF9hc3NlcnRfaGVsZCgmZGQtPmxvY2spOwogCkBAIC03MTIs
MTQgKzcwNywxNCBAQCBzdGF0aWMgdm9pZCBkZF9pbnNlcnRfcmVxdWVzdChzdHJ1Y3QgYmxrX21x
X2h3X2N0eCAqaGN0eCwgc3RydWN0IHJlcXVlc3QgKnJxLAogCXByaW8gPSBpb3ByaW9fY2xhc3Nf
dG9fcHJpb1tpb3ByaW9fY2xhc3NdOwogCWRkX2NvdW50KGRkLCBpbnNlcnRlZCwgcHJpbyk7CiAK
LQlpZiAoYmxrX21xX3NjaGVkX3RyeV9pbnNlcnRfbWVyZ2UocSwgcnEsICZmcmVlKSkgewotCQli
bGtfbXFfZnJlZV9yZXF1ZXN0cygmZnJlZSk7CisJaWYgKGJsa19tcV9zY2hlZF90cnlfaW5zZXJ0
X21lcmdlKHEsIHJxLCBmcmVlKSkKIAkJcmV0dXJuOwotCX0KKworCXBlcl9wcmlvID0gJmRkLT5w
ZXJfcHJpb1twcmlvXTsKKwlwZXJfcHJpby0+bnJfcXVldWVkKys7CiAKIAl0cmFjZV9ibG9ja19y
cV9pbnNlcnQocnEpOwogCi0JcGVyX3ByaW8gPSAmZGQtPnBlcl9wcmlvW3ByaW9dOwogCWlmIChh
dF9oZWFkKSB7CiAJCWxpc3RfYWRkKCZycS0+cXVldWVsaXN0LCAmcGVyX3ByaW8tPmRpc3BhdGNo
KTsKIAl9IGVsc2UgewpAQCAtNzQ3LDE2ICs3NDIsMjMgQEAgc3RhdGljIHZvaWQgZGRfaW5zZXJ0
X3JlcXVlc3RzKHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4LAogewogCXN0cnVjdCByZXF1ZXN0
X3F1ZXVlICpxID0gaGN0eC0+cXVldWU7CiAJc3RydWN0IGRlYWRsaW5lX2RhdGEgKmRkID0gcS0+
ZWxldmF0b3ItPmVsZXZhdG9yX2RhdGE7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKKwlMSVNUX0hF
QUQoZnJlZSk7CiAKLQlzcGluX2xvY2soJmRkLT5sb2NrKTsKKwlzcGluX2xvY2tfaXJxc2F2ZSgm
ZGQtPmxvY2ssIGZsYWdzKTsKIAl3aGlsZSAoIWxpc3RfZW1wdHkobGlzdCkpIHsKIAkJc3RydWN0
IHJlcXVlc3QgKnJxOwogCiAJCXJxID0gbGlzdF9maXJzdF9lbnRyeShsaXN0LCBzdHJ1Y3QgcmVx
dWVzdCwgcXVldWVsaXN0KTsKIAkJbGlzdF9kZWxfaW5pdCgmcnEtPnF1ZXVlbGlzdCk7Ci0JCWRk
X2luc2VydF9yZXF1ZXN0KGhjdHgsIHJxLCBhdF9oZWFkKTsKKwkJZGRfaW5zZXJ0X3JlcXVlc3Qo
aGN0eCwgcnEsIGF0X2hlYWQsICZmcmVlKTsKKwkJaWYgKCFsaXN0X2VtcHR5KCZmcmVlKSkgewor
CQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGQtPmxvY2ssIGZsYWdzKTsKKwkJCWJsa19tcV9m
cmVlX3JlcXVlc3RzKCZmcmVlKTsKKwkJCXNwaW5fbG9ja19pcnFzYXZlKCZkZC0+bG9jaywgZmxh
Z3MpOworCQl9CiAJfQotCXNwaW5fdW5sb2NrKCZkZC0+bG9jayk7CisJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmZGQtPmxvY2ssIGZsYWdzKTsKIH0KIAogLyoKQEAgLTc5MCwxOCArNzkyLDIxIEBA
IHN0YXRpYyB2b2lkIGRkX2ZpbmlzaF9yZXF1ZXN0KHN0cnVjdCByZXF1ZXN0ICpycSkKIAljb25z
dCB1OCBpb3ByaW9fY2xhc3MgPSBkZF9ycV9pb2NsYXNzKHJxKTsKIAljb25zdCBlbnVtIGRkX3By
aW8gcHJpbyA9IGlvcHJpb19jbGFzc190b19wcmlvW2lvcHJpb19jbGFzc107CiAJc3RydWN0IGRk
X3Blcl9wcmlvICpwZXJfcHJpbyA9ICZkZC0+cGVyX3ByaW9bcHJpb107CisJdW5zaWduZWQgbG9u
ZyBmbGFnczsKIAogCWRkX2NvdW50KGRkLCBjb21wbGV0ZWQsIHByaW8pOwogCi0JaWYgKGJsa19x
dWV1ZV9pc196b25lZChxKSkgewotCQl1bnNpZ25lZCBsb25nIGZsYWdzOworCXNwaW5fbG9ja19p
cnFzYXZlKCZkZC0+bG9jaywgZmxhZ3MpOwogCi0JCXNwaW5fbG9ja19pcnFzYXZlKCZkZC0+em9u
ZV9sb2NrLCBmbGFncyk7CisJcGVyX3ByaW8tPm5yX3F1ZXVlZC0tOworCisJaWYgKGJsa19xdWV1
ZV9pc196b25lZChxKSkgewogCQlibGtfcmVxX3pvbmVfd3JpdGVfdW5sb2NrKHJxKTsKIAkJaWYg
KCFsaXN0X2VtcHR5KCZwZXJfcHJpby0+Zmlmb19saXN0W0REX1dSSVRFXSkpCiAJCQlibGtfbXFf
c2NoZWRfbWFya19yZXN0YXJ0X2hjdHgocnEtPm1xX2hjdHgpOwotCQlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZkZC0+em9uZV9sb2NrLCBmbGFncyk7CiAJfQorCisJc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmZGQtPmxvY2ssIGZsYWdzKTsKIH0KIAogc3RhdGljIGJvb2wgZGRfaGFzX3dvcmtfZm9y
X3ByaW8oc3RydWN0IGRkX3Blcl9wcmlvICpwZXJfcHJpbykKQEAgLTg5OSw3ICs5MDQsNyBAQCBz
dGF0aWMgdm9pZCAqZGVhZGxpbmVfIyNuYW1lIyNfZmlmb19zdGFydChzdHJ1Y3Qgc2VxX2ZpbGUg
Km0sCQlcCiAJc3RydWN0IGRlYWRsaW5lX2RhdGEgKmRkID0gcS0+ZWxldmF0b3ItPmVsZXZhdG9y
X2RhdGE7CQlcCiAJc3RydWN0IGRkX3Blcl9wcmlvICpwZXJfcHJpbyA9ICZkZC0+cGVyX3ByaW9b
cHJpb107CQlcCiAJCQkJCQkJCQlcCi0Jc3Bpbl9sb2NrKCZkZC0+bG9jayk7CQkJCQkJXAorCXNw
aW5fbG9ja19pcnEoJmRkLT5sb2NrKTsJCQkJCVwKIAlyZXR1cm4gc2VxX2xpc3Rfc3RhcnQoJnBl
cl9wcmlvLT5maWZvX2xpc3RbZGF0YV9kaXJdLCAqcG9zKTsJXAogfQkJCQkJCQkJCVwKIAkJCQkJ
CQkJCVwKQEAgLTkxOSw3ICs5MjQsNyBAQCBzdGF0aWMgdm9pZCBkZWFkbGluZV8jI25hbWUjI19m
aWZvX3N0b3Aoc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KQlcCiAJc3RydWN0IHJlcXVlc3Rf
cXVldWUgKnEgPSBtLT5wcml2YXRlOwkJCQlcCiAJc3RydWN0IGRlYWRsaW5lX2RhdGEgKmRkID0g
cS0+ZWxldmF0b3ItPmVsZXZhdG9yX2RhdGE7CQlcCiAJCQkJCQkJCQlcCi0Jc3Bpbl91bmxvY2so
JmRkLT5sb2NrKTsJCQkJCQlcCisJc3Bpbl91bmxvY2tfaXJxKCZkZC0+bG9jayk7CQkJCQlcCiB9
CQkJCQkJCQkJXAogCQkJCQkJCQkJXAogc3RhdGljIGNvbnN0IHN0cnVjdCBzZXFfb3BlcmF0aW9u
cyBkZWFkbGluZV8jI25hbWUjI19maWZvX3NlcV9vcHMgPSB7CVwKQEAgLTEwMTUsNyArMTAyMCw3
IEBAIHN0YXRpYyB2b2lkICpkZWFkbGluZV9kaXNwYXRjaCMjcHJpbyMjX3N0YXJ0KHN0cnVjdCBz
ZXFfZmlsZSAqbSwJXAogCXN0cnVjdCBkZWFkbGluZV9kYXRhICpkZCA9IHEtPmVsZXZhdG9yLT5l
bGV2YXRvcl9kYXRhOwkJXAogCXN0cnVjdCBkZF9wZXJfcHJpbyAqcGVyX3ByaW8gPSAmZGQtPnBl
cl9wcmlvW3ByaW9dOwkJXAogCQkJCQkJCQkJXAotCXNwaW5fbG9jaygmZGQtPmxvY2spOwkJCQkJ
CVwKKwlzcGluX2xvY2tfaXJxKCZkZC0+bG9jayk7CQkJCQlcCiAJcmV0dXJuIHNlcV9saXN0X3N0
YXJ0KCZwZXJfcHJpby0+ZGlzcGF0Y2gsICpwb3MpOwkJXAogfQkJCQkJCQkJCVwKIAkJCQkJCQkJ
CVwKQEAgLTEwMzUsNyArMTA0MCw3IEBAIHN0YXRpYyB2b2lkIGRlYWRsaW5lX2Rpc3BhdGNoIyNw
cmlvIyNfc3RvcChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpCVwKIAlzdHJ1Y3QgcmVxdWVz
dF9xdWV1ZSAqcSA9IG0tPnByaXZhdGU7CQkJCVwKIAlzdHJ1Y3QgZGVhZGxpbmVfZGF0YSAqZGQg
PSBxLT5lbGV2YXRvci0+ZWxldmF0b3JfZGF0YTsJCVwKIAkJCQkJCQkJCVwKLQlzcGluX3VubG9j
aygmZGQtPmxvY2spOwkJCQkJCVwKKwlzcGluX3VubG9ja19pcnEoJmRkLT5sb2NrKTsJCQkJCVwK
IH0JCQkJCQkJCQlcCiAJCQkJCQkJCQlcCiBzdGF0aWMgY29uc3Qgc3RydWN0IHNlcV9vcGVyYXRp
b25zIGRlYWRsaW5lX2Rpc3BhdGNoIyNwcmlvIyNfc2VxX29wcyA9IHsgXAotLSAKMi4zMS4xCgo=

--_002_CH2PR04MB7078A227EF9087A45CF4535EE7C89CH2PR04MB7078namp_--
