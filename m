Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC44DC38145
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 00:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIHACe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIHACd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 20:02:33 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0E8A7FA
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 17:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662595351; x=1694131351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0Y2l3NV33UyPz3AAeVqtEP3aq9NRoCjypNGZ6UZBaL0=;
  b=Wktyy7Ny5p6Vt4ZQesHOEn7Lb84JBg5rkVvhqnJr5+R7xHdb+Clo38/H
   eTY0ffX2AaKO+E6NhSd2seihuS8ACIil6KkTRlC3LSSxAAc1m2VfwS72w
   kDbAd/Q4NTGcOOuLX3sgX8KbvaEHVdi8Tayw/YxkfjUNlAQF6Ox4UeSGO
   rNNrCXwIT+6D4FKkuxvX3CT27aEuzG6BXnO2ZBqV7F0cTNF7EbEzxj7Pz
   9Tr3XU1A9HiI5uqNAkkcDq5OYKONBZqG7T4rPEmFHHphVSdujuvsnIJD6
   e8VqjTrqoC35tmvJl5p/4LZTH8WJuLWSCrpJ8nbUPEGKhMzWKTk/D5USt
   w==;
X-IronPort-AV: E=Sophos;i="5.93,298,1654531200"; 
   d="scan'208";a="315075095"
Received: from mail-bn1nam07lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2022 08:02:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1D6+ZzFzx1tdllTKoamxNf7BX7G5Pw8vxb2SX7K2TcRvo0zSwKEOFigeMAS1bbnJ3R/IArf5MJyHomvP2uNxLV0mhpb7hPBCxT3gPt8zcdXGwwVVC0R0QvVfNI/xwOsZovanvTiF6hAN8cIMbnOc4jgpJ8km/u+YD2QhVL1uZootL8VhRdf8dNW1oD6SMW+jkOswCbqlSlnEsElAooq3jQrDhEk1srT6Zu5gHDyPMS0pmJdx4srLdSg7dmlASgTSolQ/2Agy5EVt+GSjvVRhrJDrzVZfvdcWWo/IzjI+IZQfamR2ivDdBapGgSNMjiJ/lqMVojCSJVsmaErDgsEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuMsEqRlMIHOVrgKFLK6ZhrHdmzqyRLh7hkqucJOD2Y=;
 b=iYRM28yYNS6CYKV8oMrIJzMt8NqQmB3xxAmbPE3YJgxioJSYNvP5bW3NVmF02ZyvAiFmK/zPDPGrTe2ako0M8jpW5rvhRigO7rxJci0AITHGCaf9K0ahFK55lAqP4GgNoyCyR2blNywM4buW9UCQ8uWvZ9rTOWq1t1C2RpAERzU1Wsn2EJV1vliQSuLOiRSnqjjNe9n8F621rlm+DdFLUuk5EgiGSMJAe3PD8TmhyO9zF2SOt3QLpbDtVUAnj5T67jF5wAPqQj9Rp5xOU+PbO4mssGD+mswnDVS9f2oJu3Z18OiU6w2jSz7OH1G2+rwdGH99fO3YXU0/fzElpfTT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuMsEqRlMIHOVrgKFLK6ZhrHdmzqyRLh7hkqucJOD2Y=;
 b=cLpPt/Ue29mjmMAt/M0Q7ecfi119P77elfmg3DxfovNkFhIY5fY5P9bQFB3AYypqiLup+oZ6TOcqx3c/AFtIHwYezYVjZHv9Iv7GxbLfA6+U0S6s8ajHtKLJAf2wa3rHxEGcVwipmJov93fHSjagoCWneX2qmUPZ4T2ojqfxlMU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB0318.namprd04.prod.outlook.com (2603:10b6:300:c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.17; Thu, 8 Sep 2022 00:02:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 00:02:24 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2] nvme/045: test queue count changes on
 reconnect
Thread-Topic: [PATCH blktests v2] nvme/045: test queue count changes on
 reconnect
Thread-Index: AQHYwxZGuIRgMC2d+kmIeoroKWMCFw==
Date:   Thu, 8 Sep 2022 00:02:24 +0000
Message-ID: <20220908000222.elkaqaz4l3a2x66k@shindev>
References: <20220831153506.28234-1-dwagner@suse.de>
In-Reply-To: <20220831153506.28234-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4887df8e-9349-4a60-a31d-08da912d68e7
x-ms-traffictypediagnostic: MWHPR04MB0318:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p4FFZaQWXDl3hga7Nq7LCn3mKZrQNcDnaJUIf0dunLYk31GdImUIMQfjBkMZp9p3K4m/VkYU0L5gmawtgld5qSTEA9Riw6TTVtTdKm/zjQYWcGqmfG1XkVH7w4pKiSRlA2ea7W/xRBCGnaM0OAh/Q2TNRXI8kF0CJ6WbUw5hDdiag5aqK7GCKN+aIszw9VxN0Hg9j7EvM4ey4tlKEYbNj/45B/ePtDplHzwvB+UgkvqiuRYWmTx8lMHEcesGXKV9l2P56elQ7hFvtmihhMqb7SSZDhJuFl72vhOp2fvNKDOWvlyrW3JN4wP7dOisskC1PZzwGgQixMChpsjGZliFmB49VSzoywc/7lWwygL/6Z9p1BPCqkRRAHsQp50ZgFIHyCtbg8kZgHBHtZUirQdffEfhvxOSUunIrM3Bowm/3dRX0nVvfpVHSCAOn5QjmBQnZOhMWvEg6y5a2WisqBSVZM/xp6i5wHfvuwkZR5/zSsOcYPAtTbqBDAU+k4AKwwyuvjoPPlEVQjMySKHaqpp92g9MWo51KMpV/1LoFmF10UKGDrcBf8JWrfUL9QWoUSBoe+6crQjKuFUWmAQ9lKRlDamK6fPWhA1sLhnqe1cJgzf+fMBKoRb4ZlyJGqPCGd32PJhF/XLbA4Ypp/UTWsz+OMPNRrg5Q/2hyV2iRb4i22HkTyroTcS/XbGvk7iPmtYWdMwSdXbbG8qYoaZXFV1n9JIZOXBlOrKAir+8sxT39Xol/xqPWm6EHTulUY1tuM9mqhzU2AUQjkBsdkcj56/VAJaO/zW15N2XNzu4wImp3F0B1kdcpfXNpkBrEsOTtjK69pRaJLGcYo5jPPf7IdYQ29Vb/7c8FuAAg6+6H5S5yeY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(91956017)(76116006)(66556008)(66446008)(54906003)(6486002)(966005)(478600001)(6916009)(82960400001)(2906002)(66476007)(38070700005)(122000001)(86362001)(38100700002)(316002)(66946007)(6506007)(41300700001)(1076003)(71200400001)(6512007)(26005)(9686003)(186003)(4326008)(8676002)(64756008)(33716001)(5660300002)(83380400001)(30864003)(44832011)(8936002)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H9ikEa752EqNi1tvGhs0ufFk9kt9vgi4sDFl16wwb/h3Eih092G0PqB98NVU?=
 =?us-ascii?Q?4i7Du/4csV6RlJdFMHm1TItfHhPg2Qm/A/TqcED12XrN/u+wi4UsD1e7ibii?=
 =?us-ascii?Q?mEJeuHWAUI+pB/PiXnPgc/1s6G4KqmbRyvZT2XD373TncoxayV29HXgN2SEz?=
 =?us-ascii?Q?k4GQWAik1PVH+zybw/6GQe6Zpg3Et9GotrZqAsid/x63zk/Wp7b+mSFWurZ0?=
 =?us-ascii?Q?TOgC964rWusrRKAwbY2yq4t2gFks/17ey6sQWcZhmRJnPh7FpM0ZY/Gm4ZyL?=
 =?us-ascii?Q?hDPaSluRzpUzd56kgoPuB3lZrykyOZtHFPkURp6fTI9irxXjmT90yyiUkZYV?=
 =?us-ascii?Q?bwTQ0ljW5zKsGekq8FaRnGEMHx8nCtsihIlVwFkUP9enX0CLuhYRESTaMQto?=
 =?us-ascii?Q?iURwrRCcDdVqVBHvYRoMMd/y/TXkyeAlnaB+P/tJX/W7M1aPLBz/nxOVCLNc?=
 =?us-ascii?Q?ty//wzlhAAfTP/VnzUzgbiLg/Zi6sb2zwlERshQOuVgHnqd3eossNceME7Uq?=
 =?us-ascii?Q?XrkcByaOdBIhXya22fdChORjO5WQk1R5xDz5HW5Uo7rweV99jY+jvvZ6chhB?=
 =?us-ascii?Q?PDWknh4c4Lc5q3jBTokS07lPT2U796eWnFfWtN7KOHE5E6rbNPPAevFLa8hd?=
 =?us-ascii?Q?RcTe28uf8gPMurwX7Q8sNMUpjcqiMDWQ1U0e4A+NkdVJViqlHDJVf4OYU2rW?=
 =?us-ascii?Q?aetD+Rf1DvhYXVlQ+agXK0yRHgTsdVqQ5EA/vpz6EJaLJFb8VgJnXwgUWPRU?=
 =?us-ascii?Q?fnTR55tz7IF0EriO9WEj3mER3ss/iinVhaCcNZ/V4JmXucYn7yPNeTQ1vcaK?=
 =?us-ascii?Q?KDwBhJLIDMY6jpkCLNxxI2S5Am1FYX8ejzebsHkfK418BCeWpAbvbxlvw66u?=
 =?us-ascii?Q?JsobP4oZsT07mBTGL4Yr1LLXzGg4u8opwJVilqNBHAi1GpgAd2tFUiM/Ss2J?=
 =?us-ascii?Q?pc9b33791w2p/8MRg3E48mwILzHrKTdGA2I+7PW3QGjAtkxN292AdJ+9GkrM?=
 =?us-ascii?Q?w7gm5h/NvkhSA9x0eJw52c0bYvvGvUrbHEtH6/OY6AkFbLou9kIms3WZOHzW?=
 =?us-ascii?Q?+1Pd+kXx0xrzjE4+f8xuU8K6I6zJGqJ+brCcok4I1GaKStX7HC43LN4s0pEu?=
 =?us-ascii?Q?R99kR859VP68KjE6Ltlva06DUuldgraAUvjfKPnYL06Cwqk161j1K5F9SIOj?=
 =?us-ascii?Q?RONElSyznoZ76268VXr0ePZsPW2u2rU3Bh8rZP4VcmNYmyR97NOXjh/2RVdK?=
 =?us-ascii?Q?M8bVgXjFAC6IcMKFwIl0soTv5GGs22v9KUy3HN2tWsjV4nIgMaYeg+PiFIG+?=
 =?us-ascii?Q?6o/I0YFvHtm6luu/KTTbuAVfXak6kqYoQFXuBBz20xbdWzcN4DXPDohsZhUu?=
 =?us-ascii?Q?/k8QAJ5HWM2f13aaQiPoxbl4VaamcPVwmgyfQUFuxai4ZCzpixIzjHz9LddQ?=
 =?us-ascii?Q?R6vrwjhOqEOjI4fo5a5jvWhJzALJ3Jh9nCF90CyOWejtoXuz4ayBN2XBbTaS?=
 =?us-ascii?Q?lCD5phyWwb0gZnYEt0dARf4PtIoIhHAB9SHnOaGguKsUHyA+rTzHdOhHAfLL?=
 =?us-ascii?Q?1h9lmVLJKzKNOLgJJDfeYCpLLL8l6qkWrrWuMSsm7GNGCZuNg47b5q8/USpZ?=
 =?us-ascii?Q?Qprn2kTsrYyGuym8WwW0SjA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD1300477DB8FF4B96715CAB6B69C481@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4887df8e-9349-4a60-a31d-08da912d68e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 00:02:24.5757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqrHoJVDlbCPWFqVtkcRpfEW6yzY1x+zFrYHXCIOSdREVRjRD8T7I0UrvJfPmgsYK8L5uzdwnbz3SPPexHdZQQDwaJf9ak0OkYRKygJhqWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0318
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the patch. First of all, the commit title says nvme/045, but it =
adds
nvme/046. Also I made a couple of comments on this patch in line.

I ran the added test case and observed test case failure [1] and KASAN
slab-out-of-bounds [2]. To run this test case, I applied this patch on top =
of
the PR #100 [3] and used kernel at nvme-6.1 branch tip 500e781dc0b0 at
"git://git.infradead.org/nvme.git". Is this failure expected? Or do I miss
any required set up to pass the test case?

On Aug 31, 2022 / 17:35, Daniel Wagner wrote:
> The target is allowed to change the number of I/O queues. Test if the
> host is able to reconnect in this scenario.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>=20
> changes
> v2:
>  - detect if attr_qid_max is available
> v1:
>  - https://lore.kernel.org/linux-block/20220831120900.13129-1-dwagner@sus=
e.de/
>=20
>  tests/nvme/046     | 133 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/046.out |   3 +
>  tests/nvme/rc      |  10 ++++
>  3 files changed, 146 insertions(+)
>  create mode 100755 tests/nvme/046
>  create mode 100644 tests/nvme/046.out
>=20
> diff --git a/tests/nvme/046 b/tests/nvme/046
> new file mode 100755
> index 000000000000..428d596c93b9
> --- /dev/null
> +++ b/tests/nvme/046
> @@ -0,0 +1,133 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2022 Daniel Wagner, SUSE Labs
> +#
> +# Test queue count changes on reconnect
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"Test queue count changes on reconnect"
> +QUICK=3D1
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_require_nvme_trtype_is_fabrics
> +	_require_min_cpus 2

From my curiosity, what's the reason to require 2 cpus?

> +}
> +
> +_detect_subsys_attr() {
> +	local attr=3D"$1"
> +	local file_path=3D"${TMPDIR}/img"
> +	local subsys_name=3D"blktests-feature-detect"
> +	local cfs_path=3D"${NVMET_CFS}/subsystems/${subsys_name}"
> +	local port
> +
> +	truncate -s 1M "${file_path}"
> +
> +	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
> +		"b92842df-a394-44b1-84a4-92ae7d112332"
> +	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> +
> +	local val=3D1
> +	[[ -f "${cfs_path}/${attr}" ]] && val=3D0
> +
> +	_remove_nvmet_subsystem "${subsys_name}"
> +
> +	_remove_nvmet_port "${port}"
> +
> +	rm "${file_path}"
> +
> +	return "${val}"
> +}
> +
> +def_state_timeout=3D20
> +
> +nvmf_wait_for_state() {
> +	local subsys_name=3D"$1"
> +	local state=3D"$2"
> +	local timeout=3D"${3:-$def_state_timeout}"
> +
> +	local nvmedev=3D$(_find_nvme_dev "${subsys_name}")
> +	local state_file=3D"/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
> +
> +	local start_time=3D$(date +%s)
> +	local end_time
> +
> +	while ! grep -q "${state}" "${state_file}"; do
> +		sleep 1
> +		end_time=3D$(date +%s)
> +                if (( end_time - start_time > timeout )); then
> +                        echo "expected state \"${state}\" not " \
> +			     "reached within ${timeout} seconds"
> +                        break
> +                fi
> +	done
> +}
> +
> +nvmet_set_max_qid() {
> +	local port=3D"$1"
> +	local subsys_name=3D"$2"
> +	local max_qid=3D"$3"
> +
> +	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> +	nvmf_wait_for_state "${subsys_name}" "connecting"
> +
> +	_set_nvmet_attr_qid_max "${subsys_name}" "${max_qid}"
> +
> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +	nvmf_wait_for_state "${subsys_name}" "live"
> +}
> +
> +test() {
> +	local port
> +	local subsys_name=3D"blktests-subsystem-1"
> +	local hostid
> +	local hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	local file_path=3D"${TMPDIR}/img"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	hostid=3D"$(uuidgen)"
> +	if [ -z "$hostid" ] ; then
> +		echo "uuidgen failed"
> +		return 1
> +	fi
> +
> +	_setup_nvmet
> +
> +	if ! _detect_subsys_attr "attr_qid_max"; then
> +		SKIP_REASONS+=3D("missing attr_qid_max feature")
> +		return 1
> +	fi
> +
> +	truncate -s 512M "${file_path}"
> +
> +	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
> +		"b92842df-a394-44b1-84a4-92ae7d112861"
> +	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +	_create_nvmet_host "${subsys_name}" "${hostnqn}"
> +
> +	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> +			     "" "" \
> +			     "${hostnqn}" "${hostid}"
> +
> +	nvmf_wait_for_state "${subsys_name}" "live"
> +
> +	nvmet_set_max_qid "${port}" "${subsys_name}" 1
> +	nvmet_set_max_qid "${port}" "${subsys_name}" 128
> +
> +	_nvme_disconnect_subsys "${subsys_name}"
> +
> +	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> +	_remove_nvmet_subsystem "${subsys_name}"
> +
> +	_remove_nvmet_port "${port}"
> +
> +	_remove_nvmet_host "${hostnqn}"
> +
> +	rm "${file_path}"
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/046.out b/tests/nvme/046.out
> new file mode 100644
> index 000000000000..f1a967d540b7
> --- /dev/null
> +++ b/tests/nvme/046.out
> @@ -0,0 +1,3 @@
> +Running nvme/046
> +NQN:blktests-subsystem-1 disconnected 1 controller(s)
> +Test complete
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 6d4397a7f043..9e4fe9c8ba6c 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -544,6 +544,16 @@ _set_nvmet_dhgroup() {
>  	     "${cfs_path}/dhchap_dhgroup"
>  }
> =20
> +_set_nvmet_attr_qid_max() {
> +	local nvmet_subsystem=3D"$1"
> +	local qid_max=3D"$2"
> +	local cfs_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +
> +	if [[ -f "${cfs_path}/attr_qid_max" ]]; then
> +		echo $qid_max > "${cfs_path}/attr_qid_max"

I ran 'make check' and noticed the line above triggers a shellcheck warning=
:

    tests/nvme/rc:553:8: note: Double quote to prevent globbing and word sp=
litting. [SC2086]

> +	fi
> +}
> +
>  _find_nvme_dev() {
>  	local subsys=3D$1
>  	local subsysnqn
> --=20
> 2.37.2
>=20

[1] test case failure messages

$ sudo ./check nvme/046
nvme/046 (Test queue count changes on reconnect)             [failed]
    runtime  88.104s  ...  87.687s
    --- tests/nvme/046.out      2022-09-08 08:35:02.063595059 +0900
    +++ /home/shin/kts/kernel-test-suite/src/blktests/results/nodev/nvme/04=
6.out.bad    2022-09-08 08:43:54.524174409 +0900
    @@ -1,3 +1,86 @@
     Running nvme/046
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
    +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
    +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
    +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
    +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
    ...
    (Run 'diff -u tests/nvme/046.out /home/shin/kts/kernel-test-suite/src/b=
lktests/results/nodev/nvme/046.out.bad' to see the entire diff)

[2] KASAN: slab-out-of-bounds

[  151.315742] run blktests nvme/046 at 2022-09-08 08:42:26
[  151.834816] nvmet: adding nsid 1 to subsystem blktests-feature-detect
[  152.170966] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  152.514592] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:.
[  152.522907] nvme nvme6: Please enable CONFIG_NVME_MULTIPATH for full sup=
port of multi-port devices.
[  152.527164] nvme nvme6: creating 4 I/O queues.
[  152.533543] nvme nvme6: new ctrl: "blktests-subsystem-1"
[  154.339129] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
[  175.599995] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  175.601755] BUG: KASAN: slab-out-of-bounds in nvmet_subsys_attr_qid_max_=
store+0x13d/0x160 [nvmet]
[  175.603816] Read of size 1 at addr ffff8881138dc450 by task check/946

[  175.605801] CPU: 1 PID: 946 Comm: check Not tainted 6.0.0-rc2+ #3
[  175.607232] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  175.609735] Call Trace:
[  175.610412]  <TASK>
[  175.611039]  dump_stack_lvl+0x5b/0x77
[  175.612016]  print_report.cold+0x5e/0x602
[  175.612999]  ? nvmet_subsys_attr_qid_max_store+0x13d/0x160 [nvmet]
[  175.614465]  kasan_report+0xb1/0xf0
[  175.615392]  ? lock_downgrade+0x5c0/0x6b0
[  175.616414]  ? nvmet_subsys_attr_qid_max_store+0x13d/0x160 [nvmet]
[  175.617845]  nvmet_subsys_attr_qid_max_store+0x13d/0x160 [nvmet]
[  175.619154]  ? nvmet_addr_adrfam_store+0x140/0x140 [nvmet]
[  175.620382]  configfs_write_iter+0x2a5/0x460
[  175.621273]  vfs_write+0x519/0xc50
[  175.622021]  ? __ia32_sys_pread64+0x1c0/0x1c0
[  175.622897]  ? find_held_lock+0x2d/0x110
[  175.623747]  ? __fget_light+0x51/0x230
[  175.624579]  ksys_write+0xe7/0x1b0
[  175.625286]  ? __ia32_sys_read+0xa0/0xa0
[  175.626121]  ? lockdep_hardirqs_on_prepare+0x17b/0x410
[  175.627091]  ? syscall_enter_from_user_mode+0x22/0xc0
[  175.628015]  ? lockdep_hardirqs_on+0x7d/0x100
[  175.628844]  do_syscall_64+0x37/0x90
[  175.629480]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  175.630374] RIP: 0033:0x7f072b5018f7
[  175.631005] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f =
00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  175.633806] RSP: 002b:00007ffc4143b2e8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[  175.634954] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f072b5=
018f7
[  175.636041] RDX: 0000000000000002 RSI: 0000556f9fd4d5b0 RDI: 00000000000=
00001
[  175.637130] RBP: 0000556f9fd4d5b0 R08: 0000000000000000 R09: 00000000000=
00073
[  175.638142] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00002
[  175.639178] R13: 00007f072b5f9780 R14: 0000000000000002 R15: 00007f072b5=
f49e0
[  175.640214]  </TASK>

[  175.640893] Allocated by task 986:
[  175.641480]  kasan_save_stack+0x1c/0x40
[  175.642030]  __kasan_kmalloc+0xa7/0xe0
[  175.642627]  nvmet_subsys_alloc+0x90/0x540 [nvmet]
[  175.643296]  nvmet_subsys_make+0x36/0x400 [nvmet]
[  175.643995]  configfs_mkdir+0x3f4/0xa60
[  175.644546]  vfs_mkdir+0x1cf/0x400
[  175.645045]  do_mkdirat+0x1fb/0x260
[  175.645699]  __x64_sys_mkdir+0xd3/0x120
[  175.646232]  do_syscall_64+0x37/0x90
[  175.646765]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

[  175.647682] The buggy address belongs to the object at ffff8881138dc000
                which belongs to the cache kmalloc-1k of size 1024
[  175.649252] The buggy address is located 80 bytes to the right of
                1024-byte region [ffff8881138dc000, ffff8881138dc400)

[  175.651101] The buggy address belongs to the physical page:
[  175.651811] page:00000000ab656d52 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x0 pfn:0x1138d8
[  175.653008] head:00000000ab656d52 order:3 compound_mapcount:0 compound_p=
incount:0
[  175.653958] flags: 0x17ffffc0010200(slab|head|node=3D0|zone=3D2|lastcpup=
id=3D0x1fffff)
[  175.654911] raw: 0017ffffc0010200 ffffea0004627200 dead000000000002 ffff=
888100042dc0
[  175.655851] raw: 0000000000000000 0000000000100010 00000001ffffffff 0000=
000000000000
[  175.656830] page dumped because: kasan: bad access detected

[  175.657845] Memory state around the buggy address:
[  175.658470]  ffff8881138dc300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[  175.659391]  ffff8881138dc380: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  175.660271] >ffff8881138dc400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  175.661203]                                                  ^
[  175.661977]  ffff8881138dc480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  175.662853]  ffff8881138dc500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  175.807152] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  175.996544] Disabling lock debugging due to kernel taint


[3] https://github.com/osandov/blktests/pull/100

--=20
Shin'ichiro Kawasaki=
