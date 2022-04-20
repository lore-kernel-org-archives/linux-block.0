Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6949DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 05:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346615AbiDTF5T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 01:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242771AbiDTF5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 01:57:18 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EF6E00B
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 22:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650434071; x=1681970071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hpSfgAouVJZkmqplbCAvtst68JiWhSyxMjEm1UvqD04=;
  b=HKEztrmgJncVz7cBb0DR26qt2FmNmuyH+0cbpX8BMZgxaZRlO8jXxLMv
   ACtyJCtRxaQn1fmZPIupPmum2NJafXMhfsR6FaYF1dcIapcoNTzFm1h3R
   n/8d5Dg0z+Q6IyOOupTLCmCdriGnS0JnKtQ5bDNOn+i1GcBVKCi2ooSR2
   YGGyBB/FwYoKMr2aU7IQPrzFJCnfk5VNduJGXIIXa2ISWTcd61uaxQl1C
   kYaXASDw+cGu0DIyaZaBummJqSSsAnLQGtuYm5Zi7+p7kg1iuB0FZ4Y/L
   qjoWUgo98gaHFFIzABjmsmgidevRXDCq/O4F2Iids5wH+RJKf0zGAgaaV
   w==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="198331418"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 13:54:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNSc/C5CQp56gC4eHpVbJ6XH7iET7Bfkd1kzV9P9McN1iIC345UU3cIEEBz4eMcQ7NhdNWpt0vROxRcBJiW1xFlJZDOCXbQUtD/n2F1dkdBW4gB8/USbEpy9TOjciL3KzFAzs3RIe+P/LwIPL/5ueR/7jGtMAvK6VpcZgTFlXtww6EkoB1XZBzjpTGato5KvReOEw44anjsF8IwHSyflld7LkRkYMUPjlXXk/dPDxwjiIPTkxz5o9sGd/l7Ss9INRKtdRGXeqW0C86/lXl9oIDGE6Hs3C5jtmPiL2wXrPLT85vYwrH5GuvThDg/Vay7jYbIZp7UrZF+jAzZP4GAKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QnMinfvq1hYUCZzaihCsjacfMdxZu/seVA0pAXwhX8=;
 b=nnYY9FsvdaveOwb2sq8saQWGO/ahd+Zf6qDgTF8LMEfE+EZBqmajxNxggTKq++IFYxKVFkM8nOgeoJGk9TfWSLfga7LUWB9sTslHuHBvO6PcRnr6R7TaIT4DutuTzd1twhs+KPtbexY11qAnQvq7eMbzeoL2caHN0C+ukQBtKi8HWMI9LKmMb8tpL9pSx5N2BbV19MhD14LcSF4quJIyUPmkw71tSHFz2eJ80RP64RKNoEz8TX26v277smOlYF3+x4OoxWrbdBMA0fBw6+i6fbkQG+svfLoxpxAjRBMnd0ZUAHB/5SQnGnMsCotnin7cFgXDcA4SXBHaTkuZubtwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QnMinfvq1hYUCZzaihCsjacfMdxZu/seVA0pAXwhX8=;
 b=nHjnV27HE5fl/s9i/O8GxKQ8zwvyuapTYId9Cvk66PI+RNvuvca63frD1z3I6Yi2AzO0pcdJ9XArKsqYLcCSwwhEL28zzGwej3rOJ405WAna9T4UTQ2Qjh/B7kpw3fDnjnNstjCrrCESKkIdsDePtd3ijzCypc1365HZaZIqfls=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB5474.namprd04.prod.outlook.com (2603:10b6:408:5a::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.13; Wed, 20 Apr 2022 05:54:30 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 05:54:30 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Klaus Jensen <its@irrelevant.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Thread-Topic: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Thread-Index: AQHYUEtZsx+sXkXjFUmYoV9Oexcksaz4VZuA
Date:   Wed, 20 Apr 2022 05:54:29 +0000
Message-ID: <20220420055429.t5ni7yah4p4yxgsq@shindev>
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
In-Reply-To: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6eb2f4ea-0b51-4087-8dd2-08da22923c6e
x-ms-traffictypediagnostic: BN8PR04MB5474:EE_
x-microsoft-antispam-prvs: <BN8PR04MB5474BAEF155A173E594E1F59EDF59@BN8PR04MB5474.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JnuMeoRXQUBuChGYfe0RzPEeC35TEZB/iKQhuOAF8g86PgrpC9mSS2v0K2XZJvW29wnkpGL7HD6pIc2eeq5GJKTphCAhsfbc/Vqb1GOmKfBXkdCYhGPiVv8WXYbi92SOntuSMzy1XlTcZ/sYdCo5+Zz/0XCGGWOI70wrzdvFmYIZgRW2hi3ab2BWjZVxN1OWpaAGywVHDMEkuZ+xdiUcWJsTXEeOlgn6yymACCWIp9zc5/YNaCsNYM/OB0LWtpjxtpgRWqEO5QlzdvXasb69VNo2SRcscWmAJ45wTwK0Nt0FDYVXEhGztQQxiOo9faip2QotKsDIIjesj5HL37BWhjcKhnz9ulXiDSq9s+QnVxs00S0A4pnxP05fZD5/0TzkhRwF4oDhk/OYcBl1N/E1TzRdki6v97HtEDsHin8Qq8qIFKaSMRnOhfqeQIiR8lbyy4y2uY4vCLCqWOcUQF2r80wUTUN8PceF6dib8QHVE8lcarlG2HMHO8tJGa/RMwfxCA13I5/CIoK+YCiD6kVvvQP891iH2uyKe776FHCg3cVJces7kUDrIKkmb9mSaJSJH3NOF08wvTZQbDsmtbstmBA7ZOJT5ox8yxx8kyWiQ94DcVBVtPq6Ae2DPZKWXCSIDDCBM/WfZPCJwGTuQXhjICbXij+q8u9YxH3MXzRNkVkOEGwPfwEwz00Gp9ReqZaV8JXA/Orsl1lL3G2f6KfZAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(508600001)(38070700005)(38100700002)(5660300002)(82960400001)(44832011)(71200400001)(8936002)(33716001)(122000001)(1076003)(83380400001)(6486002)(186003)(86362001)(66556008)(66476007)(26005)(6512007)(9686003)(2906002)(6506007)(76116006)(316002)(66946007)(91956017)(8676002)(66446008)(64756008)(6916009)(4326008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NSdNK/ANPEomkm7PRyMAfJNY8dCfZA65bGVhgeKapWl4SxU89LO1wQ576Kvd?=
 =?us-ascii?Q?9D4nPpLySwrd310a0QPEhzDJcps+z45TayyYQvBJ6cX3t3TFUlDZYfuPGiym?=
 =?us-ascii?Q?KgyD7WTB/mALM1IbuUhUXGSltXuxRxvMtmburYJqudox4/IKeC51KmL1OXMi?=
 =?us-ascii?Q?mACE4NhKsjqT4FOZnEFQmb1eh2GFarBee0c5UmwaLu4K8xQbuqC9LSDOT/6U?=
 =?us-ascii?Q?tlYYgS5/TKoQpErzBg3dZtcVndwZzUwDjHoXdSmWUpRmd+P2aesVgghvnxyy?=
 =?us-ascii?Q?QfU9R03M4IAFqXtInw7u0IbjyKfICaZ4v+Rjk34EqFHOfrLbo3o0w/lWpjD5?=
 =?us-ascii?Q?XViXM+VmDPG2t4nppsGw5wGUqOV2nYNuZQ4bjzvSyDNWyHSTMO4R29x2szL/?=
 =?us-ascii?Q?EbaAO+zrvr61QNxwakW+QIdumRW2Nxesmvd714wAzvGcqsbh3ORmSafiKA4i?=
 =?us-ascii?Q?ewAZP7c/LFKYf5G3ufRO7pLC++QoXe9w2J0WE9BPttesD/ll4fUah336zP0c?=
 =?us-ascii?Q?h58NEKgzmSQvCURu/VDqDdganhRtsMwIWxNyiCZvPgZSSq0uIpdLFIp9GQIH?=
 =?us-ascii?Q?uem6Er6kJj9GiPUEBExeJaxvlaT/7EPoZcmGjcx2q14qMEXoXNRDpHPg88w2?=
 =?us-ascii?Q?sRzc2NYGweLz/thH+4oj4Iik5E4ukYdvOx2s2pDuZCWG1dPmnaKkCccO3z8w?=
 =?us-ascii?Q?efxQbIPKmYOLG1PezrvOFiaUCPr7glcNhCPq7cha/oCVj5VKkClGv3OkAlK5?=
 =?us-ascii?Q?wNaes6/i7CpY9EW2cMCFDuBJhWw6ywiwLlJ/QX2jnaz6e6yC+nW+SVsipXn3?=
 =?us-ascii?Q?DXNX9MBnvz7gYMWw8VjXxgzDm/SfB6/WXxQNtVldZ6n0pauzFUVRuK3HiQli?=
 =?us-ascii?Q?e22cjRkuNCR2aFM8z/zKdFPFj9QsIcJiA3TdMUYAra4FGygtSEBwRg94tJew?=
 =?us-ascii?Q?GVJ1oQEXluiVGIbCzoB0hTrh/LBAEwnroLXTFlwOWQGlYBXtccHdWXVs0kax?=
 =?us-ascii?Q?RfY7tQsbOKwNKL1l/MzE5tNXoHyYLkjmI4yoZvV1yjF2ekIS3oHAqeCM3Tuc?=
 =?us-ascii?Q?1A1pZmBbQpt5knmZdGBfMR0ohD3AAUUCAWCXjDErJ2NrbAtPBWVJyw8YUrZo?=
 =?us-ascii?Q?6+AFoJKPMeBnje95bW8aftN3CESifijCvKsm0cO2KPfUu+7oL53EzXG72Gxl?=
 =?us-ascii?Q?MDPvUkKAR19QSPo9A3k0buGvyQpagUSQH/Y1iXrtbaKxZHlsEPbNiIZTvf9V?=
 =?us-ascii?Q?itU9fna4Y28Qusg895KZ6vp0fzOuQJAO0jTGDk0V45mvacj/vMZLT24x6MFU?=
 =?us-ascii?Q?Hn2FYRXgWXEBSzBtSZ28bmiDbgndjFjeZTRGKUc9tLdG3jgDsQP8bHx47Al6?=
 =?us-ascii?Q?AeLWcBC62HrNZfVHm86i82WcmrpKLNdn41p8cUTJaLnOesjo9VIVSYzJjRiu?=
 =?us-ascii?Q?Az9xECyo4acvM2UHxpoIrgdKlXdYW0qVMvUked5pNcxzBNLsfJPfAsotLPyS?=
 =?us-ascii?Q?SVKhc0kar935etPp143xdp6z/nGYQM4X0+DPiEoZRVMQqqtZkNyDw2tI3yKt?=
 =?us-ascii?Q?WZLS72BpkU76fKYq+JI+dw04HkEieViQ88zSjcsEiTkmBKEJm/y06kJUZVbK?=
 =?us-ascii?Q?YkLUTXr/0SiPxvsBC5X5CXIl2uUDrbMRh37gzAfn51oWK+IuNvm0ZWcOZMqP?=
 =?us-ascii?Q?h+F+C5N3d3X53NagZKmUwLPYF0e4niFMo6Gw+ns3nCTdzS8feBtBotfiCt0y?=
 =?us-ascii?Q?L/dUn/qK+Hk0rXT0eWZv50xj4/nbgv/LH61JxFUH7vhres7SATea?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <910972916C86294789CD946BD8953482@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb2f4ea-0b51-4087-8dd2-08da22923c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 05:54:29.9857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNt5A/4YUp5iPOTcAHazx3oBs0jCy1aSC7rNTLPrqR6nTgkaatxLxvl59nv5Di9sp21zep/4u5Wi4QXYZ1sjoYbsU2Sxv+dc8fk0PGuJBDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5474
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 14, 2022 / 15:02, Luis Chamberlain wrote:
> Hey folks,
>=20
> While enhancing kdevops [0] to embrace automation of testing with
> blktests for ZNS I ended up spotting a possible false positive RCU stall
> when running zbd/006 after zbd/005. The curious thing though is that
> this possible RCU stall is only possible when using the qemu
> ZNS drive, not when using nbd. In so far as kdevops is concerned
> it creates ZNS drives for you when you enable the config option
> CONFIG_QEMU_ENABLE_NVME_ZNS=3Dy. So picking any of the ZNS drives
> suffices. When configuring blktests you can just enable the zbd
> guest, so only a pair of guests are reated the zbd guest and the
> respective development guest, zbd-dev guest. When using
> CONFIG_KDEVOPS_HOSTS_PREFIX=3D"linux517" this means you end up with
> just two guests:
>=20
>   * linux517-blktests-zbd
>   * linux517-blktests-zbd-dev
>=20
> The RCU stall can be triggered easily as follows:
>=20
> make menuconfig # make sure to enable CONFIG_QEMU_ENABLE_NVME_ZNS=3Dy and=
 blktests
> make
> make bringup # bring up guests
> make linux # build and boot into v5.17-rc7
> make blktests # build and install blktests
>=20
> Now let's ssh to the guest while leaving a console attached
> with `sudo virsh vagrant_linux517-blktests-zbd` in a window:
>=20
> ssh linux517-blktests-zbd
> sudo su -
> cd /usr/local/blktests
> export TEST_DEVS=3D/dev/nvme9n1
> i=3D0; while true; do ./check zbd/005 zbd/006; if [[ $? -ne 0 ]]; then ec=
ho "BAD at $i"; break; else echo GOOOD $i ; fi; let i=3D$i+1; done;
>=20
> The above should never fail, but you should eventually see an RCU
> stall candidate on the console. The full details can be observed on the
> gist [1] but for completeness I list some of it below. It may be a false
> positive at this point, not sure.
>=20
> [493272.711271] run blktests zbd/005 at 2022-04-14 20:03:22
> [493305.769531] run blktests zbd/006 at 2022-04-14 20:03:55
> [493336.979482] nvme nvme9: I/O 192 QID 5 timeout, aborting
> [493336.981666] nvme nvme9: Abort status: 0x0
> [493367.699440] nvme nvme9: I/O 192 QID 5 timeout, reset controller
> [493388.819341] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:

Hello Luis,

I run blktests zbd group on several QEMU ZNS emulation devices for every rc=
X
kernel releases. But, I have not ever observed the symptom above. Now I'm
repeating zbd/005 and zbd/006 using v5.18-rc3 and a QEMU ZNS device, and do
not observe the symptom so far, after 400 times repeat.

I would like to run the test using same ZNS set up as yours. Can you share =
how
your ZNS device is set up? I would like to know device size and QEMU -devic=
e
options, such as zoned.zone_size or zoned.max_active.

--=20
Best Regards,
Shin'ichiro Kawasaki=
