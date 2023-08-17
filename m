Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B78C41513
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 07:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348419AbjHQHSY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 03:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244777AbjHQHR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 03:17:58 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF6AB9
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 00:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692256677; x=1723792677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zVbWMnRY5f8CT+INSTXc3R3S723xJuC4GdbbDW39kRA=;
  b=MEg2uqZkqoMuMF9LOgk7kgqy0Uj3NBasyUefteAnW7x+1slF1Ychs8sW
   NLXDn4bHpTH+aY/XwjszTKIs/ImZwhxBEqfny9mNcskMcoWcT8opTJyln
   Fkk8ADmOWr/9Y/tVlv+OHikm/HYsmMwuIQFvzsq1Peqj33v9fhZLOVrVd
   +rl8L/b4VIXmMYTSqIsk9Ds+kUKtr2dtIbi/lSFwLUG5QacG7rR/wsDEf
   dTct9+pFKomKQi0XHtJMud6MNllMqFKkNK1w+mzx75DyxAlOde4zDOk/2
   6ejQxYK7uOYxu83JJq2yAHmvty9nBkNZJqFv+iaqbNsrF+J3RwheuB0sy
   w==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684771200"; 
   d="scan'208";a="245966625"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2023 15:17:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxREgt1x/7WYbhCPLtxNAfNmoUuawBkzEHAUgh/eAJMkMBwiv9S2WfRHOdrfEcv8EVNLsDLZ3F/fBW5kWL/xkNqpoCYMDfJzRaDTkxtlI4nta0sfKV66Tthz0ZPd6D8TrWFmtOkbGS7qQT1m+/FdvAgvKzfTHrlX3cOAJyv07Cbi61G47HyopWIZFOJ4x2d+5vA64qnqSCOB67GR3njsL584PiymU6R/m/HGQm/UL0DKCQXqthpaGnSsFuI4uXL6uJhXtxk9drl997V+ZRCRFDtdNwHiQWVOMNUgsINrMMi8dNOJ9t5mzkqH5ZLyBio8EL7unGaRd8gv7Mbvh5XRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPFtmnmCWJqeUm6iz83IqxT+C/j6tm6ZkHHXSo4/FT8=;
 b=HW4Z7R7a93bhuB9rpQWtEcBiN8JGHk0BthrVadr4crG3hG9/jGEtpr4Mj7uVY77S0bPw2KT6J5TYQUHvOODLNclTeMluPYzao5gMOBbjBwrRQ95IOxHGE/nHvWcRKdbQ5C8uQWtGQ6OlyGzF0gLzCBYwJI8kBVsc5JgrLtM7f4M0XP8tSH24zBA7vVcNJKPICykY3NrNP2ytx8nGj22PLRjJZKzfWuK/INJ538j/kWY5Q2mBB25RjjWcubl9YswFWtiGpicNj8dWTKoUCTmlCkh/Mj4mmGmte57BPWDnOzstVDPbccGwx4OGjfNk1rnTxzODamabbedlHATLmEDZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPFtmnmCWJqeUm6iz83IqxT+C/j6tm6ZkHHXSo4/FT8=;
 b=UE7tJcxdPbv/t3PYYzhH4SsqidtFNreBL7SWh3ex7FVCqSAOtIC9i7FOHU+/nKfmxCuQp9PzNR6BHQBiFCaoKD97RGPzGIuEwleNcJEypji8FxZ6A9HuCKs4Z73j8KzQOXOURQJ2Ju/8UM9MVGVWwpyRvkQ6gjypf9NrDsv4sDI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH3PR04MB8862.namprd04.prod.outlook.com (2603:10b6:610:175::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 07:17:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 07:17:54 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Thread-Topic: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Thread-Index: AQHZy/J3Glbz+YK/PUq03CAsK7LAl6/kpM8AgAg244CAACRdAIABHeuA
Date:   Thu, 17 Aug 2023 07:17:54 +0000
Message-ID: <s6rrqbuako7hzd6ihii5s2qlaom7zvaumrcgafi2ibilepvlcj@vfzwblayqcal>
References: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
 <6x55ggt7k2kjgd6lr6ykubwmo2qfilz3k32ywfuun2zhat2p5v@7aohs7kgb23x>
 <dsb7kr6wzpebiruz3uqrl2mfhahsv4pgmvojeaeshn4to6csrj@iape74ngcwg2>
 <bwprzz5jxwrsnfycw5hh3wvyke3rnpzt3cozeddmfabbv2eubj@uk25btx723lb>
In-Reply-To: <bwprzz5jxwrsnfycw5hh3wvyke3rnpzt3cozeddmfabbv2eubj@uk25btx723lb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH3PR04MB8862:EE_
x-ms-office365-filtering-correlation-id: 9c310f3d-b410-44c4-ba80-08db9ef2137a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBC1j1q/zHkPxdw7nMZnC29aqH9Sxms1UMnlGc8GRFqt3fb/rYckdG0Pf5YN332E16OYYx9MlrIprxqGUlgFmQo8QMSaN55jrisllP4qiB307hlLTXefOwn73F/V/GD36H+3wNsnoEGgRR9v0+QjZkMEyS5qVjYPIVLyt+e6p8cgktatdidr98YIIze0o+/jEIhTtW3fec1LSIMUiEdaGOIDKRIyd5B01mUMoWfxO5K2MXJDt5nbmRLlmxlRb9ii64k2/egbgGG29/edm0sjFk5UQBbR0EAcPxeJdrQTS14OiT1NOIimCSjQW59fm3J5GulrH7brm4JSNsv0RrNfxpy80bm/tcpjEqkKcj+IWYaRpZjzEHdmTFxPGMMTKSbBmj0qAUqZC7OLmCHbIrNL97uXN1VRu+QK6D+y/OlpzV0d0JWblYUNqbON9i073TYz6dU+ohMYn7TW3mCpg42ulpXDFokruyks7zlvKzcqG3p40cnO/IW6CCzw6hWdyoyuzp9O5uKblaWwZV8w2HTOnxxiNmyUawGmYEueWUMm8aYslDaJRO85fu4Jp+WP+MhQZdqnSyug3IzJqXMCqvD3VCDM7WgxDQug7hYiWJzOiYI3eP1kKXlbSGcSzqFlY9WqOns4960sEFl7cJUXujyrBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6486002)(71200400001)(6512007)(9686003)(44832011)(5660300002)(41300700001)(66446008)(122000001)(54906003)(316002)(66476007)(91956017)(66556008)(66946007)(76116006)(64756008)(6916009)(4326008)(8676002)(8936002)(82960400001)(33716001)(38100700002)(38070700005)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M2TjSRDC1TlE9KaUSsojo1DLS9DzBGKviH8mlkwitcRBrZvZqw04OLuRoXUG?=
 =?us-ascii?Q?llxMoQOlXSD6oXRwq05AVyqWX6w/K56evX7lYQid9hu0I1aMRxD8pam4GdTQ?=
 =?us-ascii?Q?SJExlThboJtul5D1ZcPw6C+dr3+1UJtdJsU1EoikOqC9rrGVt7ZT/2ZWgma3?=
 =?us-ascii?Q?Ufr3q7E3x94AeveDzIVPMjkxhl86QEn5a28B3Yhja3C0rk/X7976TChFTV6k?=
 =?us-ascii?Q?4IHuqLw0tGyCqleGT9l/bqPtoJydBF5tnSxemv3mcfcRY/Wu7ZPV916ugvOh?=
 =?us-ascii?Q?a6huSFILTx7KbX3upA5yCN/wKugQ/qFsbySnGnp3493Y76lxQ9qerlfBLQhb?=
 =?us-ascii?Q?nWabSS2SdHNk87CVm/FuNxDhdwTG7ZISgaEchglUQqNAJbgrmIFcnRnapbG0?=
 =?us-ascii?Q?PQcVxScAlS612DV6ZfJKLTi9w1aWV/FKz4v0lf73kmLSKE9zxUWK5BeJla6o?=
 =?us-ascii?Q?ZhSv+LusE2i3LpQCfomU5qw61Wz3i28Xdd6Vh86JziIkBccKiuOclXvdG22Y?=
 =?us-ascii?Q?wZw6MBzFYae6mhdowpDC0nMhDXxCW38XbXvd/ttBh8E6WJdaOgPkg2K3+bh5?=
 =?us-ascii?Q?yo1XZmdirBiiU5L1qjwSeNTJuCSMQ8DuVbcwnLZ4FD4XTCtX6oNZwvLS2g8S?=
 =?us-ascii?Q?djZAZ1S91jQVaXWAbYVxeeDADeVl+H7BmM7j3E/HKApOBK4voWQ0ziyJb9y3?=
 =?us-ascii?Q?JQbP9FWk3MGLCfwyiea23EbLLXKMm0pDnVHtUW9I42kyLdZdqIeKZt8r6S2H?=
 =?us-ascii?Q?izO1Wc8upr/FXtPCFM8wt/IwKK+wVNBjoPlN5QL5+/3i8GE4O31Jv4+WwSYm?=
 =?us-ascii?Q?UWatKjfH5nqrBd6onydGiuuoYippmrnUz4/HQY31xEpWOru0BC1yqqk0kZIy?=
 =?us-ascii?Q?r4rFtJhDuyqg8xEvyHOXMjdok/DfWi7iOGvRokUlfzNKPzL5n7xcS0gKYCn3?=
 =?us-ascii?Q?LgvZ9sOJfoepFPR/EyG4RisR01wuNyiivGJxG9n2E2W/zHsrVq0wtP6lA1FD?=
 =?us-ascii?Q?CpHGF5qLZplatiH6y+YCgN4LOS4TvwNmJnJiY3TKvq5H1t+ZGVO+fSjYTCZR?=
 =?us-ascii?Q?hhrqy3TZs8AW5enK9L7Psd1mpHOWJavstG4Sup4mHNag1wRwvSn/3kCc41OJ?=
 =?us-ascii?Q?6sRVP4Sntpzkqhv/sN8qMTGtsTmtgYJFAomjMAIVQDe9FgpimxERSZGrdD1N?=
 =?us-ascii?Q?LemGJELI61dm/urlsOzGEmZiWKjCjNOw6zg3LAMtjUXyZrv9OS1WTbuql1sL?=
 =?us-ascii?Q?M8wdv/TfkEZHkO1yOJjQzQUMWqas3U8NP+QJ2Z1jJGPfJZdp9pi+vJB8ChOr?=
 =?us-ascii?Q?QwrM1tSxsZJtl6Lo47rrKkGFZ2V3jm2LcF0/QN/tSS4Qf2vKjM1XagiYkg7j?=
 =?us-ascii?Q?U2O30kfTP+u0JGNAettDMkqCbIqAxLZW/D0nSfZTmwOmjZdALHQY9UOI7v5a?=
 =?us-ascii?Q?H0pIKXqIiQrj21CUQAny9XMPcTv/NzaklO4ywn4uPVkvRHALU20bI8nI+m+R?=
 =?us-ascii?Q?nsL6u7aqU+4KRH1NeQJuZIvKxJph47BLcO/ygyKe+vXPoUOhKGdW2WuxfCkC?=
 =?us-ascii?Q?79kSoLUVILibOyePKtG/XySJ0U3P3wa6VXpsxKlBYTMb9eFqefhqc8JKJkQ/?=
 =?us-ascii?Q?nkGXWtJeb7jkPUdGsGQgf9k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7CDACF355E91674B842AB02E77576679@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wb1hW45pUN08dUT/NjjjiaGebFMTEhAMZUOB3VmGlEpdPA7BsIgXNVNlccFYDSFwe/1j9kSb8VsiM9TwNOI/Ns6GH03newYTar6nhvjJe8X5F+I+nI62+f4dMNwpWr8juQC9VAoT1Ygfcj5/0skaxTbUFdxRHxXtnL8FMf9Zwpmt8PsHIhwzjwMohAQLFjGhjpQFcYrtoWRI/OrmXiUJUVW7rzb6fJp5lHZ/VRUqsqc33XdQPI2FRqGMM19XrWTFDBZLyEozlRViJqHXi8d/X7rV3deFqEgB2Wkya2MCwAqpdAb5Z6iRCgMXTYpIcE6RO/sTVJcQFRK/0367/afUl7aJB8/roKIecesuRi3rTHJEgpW+q8VCNbuJ+iUteaeH2oHYT30/uUGw/0wBzSUQkizta5PRkpx9tabsS6MC79dPoJgglX7X6LR4KK0xRURM3bLmmhVNTV/Xqj4aqKx8DjCjqrWZ20JhVx2rOulv8XH1MXCOAL2K054zzhDZZ56ggz4tirxbWQMCgiZ95fEEz0zSZVDseUUdNOqvPJiHpc7KU3J0T8Dw0r1AM7qfBjGGobQslq0Lx1Swn1VUOkLwSOEPysgREM5HTpCEtKrSxe68yObtLL1VgIHtjUKBNCsWYuIjc5r9cSdKhb0dkT9jtwAbS08voBe3uIMMow3KCMLybyldHFecfAAipeB3zSAzzvmtbpb5Ws9eEbPUPjzy937m84Tkl/yNE32bNFKOXZtWL8365aDEmcqyjkIeiVUy2ZQDC90N+evBvQbj6JZPcP7cWCpdMOnEUlvwNKEBL8lc3utuQDhcvf9Ljs3z5GrE72jdbmabHskOHld4JnvKf+guuxqPFODphpTbsdYIht6tZykL7cIQtYm/g3ArxeRGSVeJzqHEBV7vd0yzt4vXKQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c310f3d-b410-44c4-ba80-08db9ef2137a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 07:17:54.8961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvlprcM3QwCJjqqA8GGkl6u5rP4Mk1sgUEQun4kr9S1wWbNZOnmdIsCly8C1RrUyfc4t3hM55+wePjdyAUVCFXq25JJvYZoZ6D9vagyY3qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8862
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 16, 2023 / 16:14, Daniel Wagner wrote:
> On Wed, Aug 16, 2023 at 12:04:24PM +0000, Shinichiro Kawasaki wrote:
[...]
> > 2) Rework _find_nvme_dev into two new functions _find_nvme_ctrl_dev and
> >    _find_nvme_ns_dev, and do the readiness check in _find_nvme_ns_dev.
> >    IMO, this confusion comes from the fact that _find_nvme_dev returns =
control
> >    device, but some test cases use it to operate namespaces by adding "=
n1" to
> >    the control device name. If a test case uses namespace device, it's =
the
> >    better to call _find_nvme_ns_dev. But I worry this approach may be t=
oo much.
>=20
> As we already have an argument parser in _nvme_connect_subsys, we could
> also introduce a new option which allows to select the wait type. With
> this _nvmet_passtrhu_target_connect could be something like
>=20
> _nvmet_passthru_target_connect() {
>         [...]
>=20
>         _nvme_connect_subsys "${trtype}" "${subsys_name}" \
>                 --wait-for=3Ddevice || return
>=20
>         [...]
> }
>=20
> and for the rest of the test cases we just set the default for
> --wait-for to ns.

Thanks. This idea sounds good. It will fix the failure and avoid the 1 seco=
nd
wait. Will implement this and send out as v2.
