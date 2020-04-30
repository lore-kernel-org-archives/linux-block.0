Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A601BC8300A
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 13:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A4A2074A
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 13:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bXGnGaOW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pnQVQ0GM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgD3N30 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:29:26 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26262 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgD3N3Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 09:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588253369; x=1619789369;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dRUuNdmTm24gM6YXyFy2geNxpbrWbtDBdqTELJbrnMM=;
  b=bXGnGaOWOEDpTNDbXgLOyJ3fNTsiR58qSykP3L74ckHvl6pIpOVhPQoA
   PKpvpNf2zWpMNGjFD2sv2UC3Kys3+i1KspVNH77GHYvvbFgTKi/cA+YPr
   wjQKMDNsxnl52xJ45bbsVm1HxDfzal0pYr0jLbUkQKg/2D0pgtOcDwzPB
   w6UTbZFMW1jYKQW6xZF2Ib6NNSE76vjkkTMNlDYxSoGSrJDmNB8bihmUZ
   aQnz1dWWQ0WVfVcYU/kuqOC7RAqyvt8rdsfmISykuz3pi0Y+uPRIS8ghG
   0qC91WrHocqjFs4UtzJXEieLHbE4mtmAxcp3KZTVgcLwA6lfLgmsGL+oY
   g==;
IronPort-SDR: Fpaa9RcDu2Ik+fN88eWUlL2vsA9lVAciOHj9YJLhJwXQFOYejeAdrjk5L078d84Mrnv0ky3klE
 XhbvM0xCmuhZGg9uF5W+TS2t2PBwcNHBNwRN14xi756b47Exp1Ggvf+tRVr9w8vy/K2+379ulr
 EA6vnXIfrgvSr9s4e76kom4VWOWttSmAOdr3gkSV761pt0sSowan8ILEM2L8qhrbImN7HdJNAY
 zf3itGKbMs8uvzZ3eB0ZgQstkuw7YxwRgi0iGoblwrAbvJ6vQ7Kcl48jNOIe+3QCLGrVYAj4K9
 iCA=
X-IronPort-AV: E=Sophos;i="5.73,336,1583164800"; 
   d="scan'208";a="239138918"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 21:29:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdlcWGqcexpvmFARtnfyhBNaBVXzLTbds8b9eyJBPrZMc2mpVGjs5JDNbGXYimfZMzB1lP8v32yBG5JllARLU8QeIR80UubBvbetiJ/VhLe8sHf0OTZJ8KuomtgsGx45QvwKAHqKXJE1yAYquAt6Cw9A+6MogjnNYpd6kIp7cnk+bdKZRkrGS97iAJytmVJWo1x8o2tsi1dZcXSAcW3QyfIAbKCPHh4Sr6nz6JW+L2sigYbNNYEzjI1w6OUIlA5HjWcNx8vteEnU5qxgvgLR7SbD+wJhpdJLYkbknZODcRUBgcAVgfETBQau7/9gOQ0JIUwA00w9+3QCW/GhaWs6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5ayAL64FiwBTMs9iohpw8ZrfM64ooTrTJOrwkuBCNs=;
 b=M5K2PXLF80J7yKrsUb6o7OQ5jUiM0zLrrWxZRsxEbXjU/6Ej1bytYXGHUI7Vf3Zf5qv80GnlTX9dZhcEcfvFDVSneindb6U42vYUoVDy8UVghjMmmupwqtEwzjicRPc0fMUuSt/A/ZyHS2flZHrZOuLnRImuyKXRok8bsx2uASbSDcucblRHGC7nMjtNFJPk0b09xBDINZguyQXciGlqKF3rhw5pJ1Fqi701NMGURqjTB7qC2lWv5zPpjyJA6P9C3jHqYQo8IgHh7Lhj9NNPTV5u4n/Uafed+E9DFhGhznnm02/Gg4CMZxIN5A8A2fMv9yMBqwJgfCkACO1th6FAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5ayAL64FiwBTMs9iohpw8ZrfM64ooTrTJOrwkuBCNs=;
 b=pnQVQ0GMQ2l0C09olePXF6OSEcW4aVy82gMa46Hhbb9Qao2m7iT/JDbh/yS8I9XfRZynfoLbrnjhJWREI3BfSlOkdqfBc/8A+WieJ7aQKrHRrwB5CsR1VCc/YIWUWEfCIyFSY51YlVYbpoJb9um0cwWinXqJyn2/ZqbgTk4833Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3616.namprd04.prod.outlook.com
 (2603:10b6:803:49::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 13:29:05 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 13:29:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/3] block: move blkcg_bio_issue_check out of line
Thread-Topic: [PATCH 2/3] block: move blkcg_bio_issue_check out of line
Thread-Index: AQHWHXxRKT7Ntgf71kurctAEAUiQqg==
Date:   Thu, 30 Apr 2020 13:29:05 +0000
Message-ID: <SN4PR0401MB35985ED625A6C1AF77A8F5669BAA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
 <20200428164434.1517-3-johannes.thumshirn@wdc.com>
 <20200429072526.GB11410@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e95cdc4-afe5-47a2-7560-08d7ed0a744b
x-ms-traffictypediagnostic: SN4PR0401MB3616:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SN4PR0401MB3616F13780C774E0C07B6D0D9BAA0@SN4PR0401MB3616.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dOuVYjPKudKL9Os1rfA5pYizQikRf65JOrEasgc4nd3v11kHvAGlv7PjBDia8gjivlVj2GtQWbykUMH6Xe140w6YKII96lxLJYSxm/s0oYMVPAzDW1wP8HGpmD1QubSB1SzM0cnmaBv7gMQ4HOlQcLZ2OEFnpDdVHmYs4O+k5StTcmTee9Z08yopQpSCk0N8HJ1kbvern3nNHuEevJVLr5Nv5pIRgKATncOkLpvY9cBYFXeV8j8LV7kP9KItLKNQJPBipKblyYxXIJD0ttmeEFEv69nDV0JsD7aKEEGbmzIsrptLqVEFr0NTf6IRPIxWQJgbjvfqUmZROZ0s61Gd7cImjheBeCCE6cIj1RbObvE5msh7qLYKX6aWkXjFNDefjtxVMMshCmnA6LHuDqQoHO6JzgISyaMwJTC9N2nh/phS9TRpq/6WveXdILdUo4+N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(5660300002)(33656002)(7696005)(2906002)(66556008)(64756008)(55016002)(71200400001)(66946007)(66446008)(66476007)(478600001)(4326008)(6916009)(54906003)(91956017)(186003)(26005)(76116006)(6506007)(53546011)(9686003)(316002)(52536014)(8936002)(8676002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: i3crGRasS1yfmSVMqsq7+JJ+4h/eL+lQeQHfuH1ULtzHt2auHvfoLb9YZIbbpniYYLxjbQHAaUWPxL5jlWqnzU98XIoLHLzNJtpqD40vC0wOs7IAV/GuVaLlwVKlOKnju3C8cdO2RI7iWC9QkKz0KNh4lrWBgVz97iqN9tH6QDpfdU2UlpCnPPBUciy8BpoQB98PGeyVj5to17/Y6JwRIJHjF0XPKgNRcF5GcAREhHoEWH2j2BDST78F5WEMZHehQIghu9bffjGSXhxGl7GMS8pAa8ju6Z1IlYtlA+z++xc1k29hN6G82S+s62kXAA7gty+LRR+Fx+fwlN5xG9UqPk5C/qcSCgbmeYTiMFK7pktmRauf5ToB5761G2vj4VX5Oj2TvAd4/9hildxDRwchMFZqZUHv6tCSfh7Ldyt35qH7rUphEJWbx0TCtbMWCK5yA9DcRYqkoxyEMpgeZZ7w3lmTur+VT1CKjLkhIX3Xc6awpclxPY02nsh7cvgbwcF6n5Rqj+l1xilNvP5kgUsn+k6O7p2TdEo/AA6sXWIkdQBRzDkUfkeqrmlDaCux7nBykmX4ULYThPRRtuda3FnfWy9C5iXy0lYrXrh5PjNCHNd16u5Uf+IKhuCXgDC2shslsK3BMaFZ1zmDW4p+XA4ltY3HvnihgCFipdzpEjbJ1ybJM5o49YtZchmOoH40EeC3WXprBQEAaCD7QdfWh1jGhLrGekkrqZKwyqNqMI8NncyqIYBQcNKuMwqbKNvTb9NXHqA4VDXlCgvkX779q1Z3kwCrik0RikDxJmqRQ/eVNBM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e95cdc4-afe5-47a2-7560-08d7ed0a744b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 13:29:05.1183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bi6hqYhuv08/zFxOeWm7X4Pv+vmcZcWJnaw/fQa1awM+HVDhS2susoZB0vu/I0tTg4epyKB7wmnXtSqqbv04bznxHeO1WAmw46ZAY58hOsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3616
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29/04/2020 09:25, Christoph Hellwig wrote:=0A=
> Looks good:=0A=
> =0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> =0A=
> Follow up comments below:=0A=
> =0A=
>> +	rcu_read_lock();=0A=
>> +=0A=
>> +	if (!bio->bi_blkg) {=0A=
>> +		char b[BDEVNAME_SIZE];=0A=
>> +=0A=
>> +		WARN_ONCE(1,=0A=
>> +			  "no blkg associated for bio on block-device: %s\n",=0A=
>> +			  bio_devname(bio, b));=0A=
>> +		bio_associate_blkg(bio);=0A=
>> +	}=0A=
>> +=0A=
>> +	blkg =3D bio->bi_blkg;=0A=
> =0A=
> We now always assign a bi_blkg, so as a follow on patch we should=0A=
> probab;y remove this check and assign blkg at the time of declaration.=0A=
=0A=
But then blkcg_bio_issue_check() can still be called with a bio->bi_blkg =
=0A=
being NULL.=0A=
=0A=
What am I missing?=0A=
=0A=
=0A=
>> +=0A=
>> +	throtl =3D blk_throtl_bio(q, blkg, bio);=0A=
>> +=0A=
>> +	if (!throtl) {=0A=
> =0A=
> The empty line hurts my feelings :)=0A=
=0A=
Hehe, fixed.=0A=
> =0A=
>> +		struct blkg_iostat_set *bis;=0A=
>> +		int rwd, cpu;=0A=
>> +=0A=
>> +		if (op_is_discard(bio->bi_opf))=0A=
>> +			rwd =3D BLKG_IOSTAT_DISCARD;=0A=
>> +		else if (op_is_write(bio->bi_opf))=0A=
>> +			rwd =3D BLKG_IOSTAT_WRITE;=0A=
>> +		else=0A=
>> +			rwd =3D BLKG_IOSTAT_READ;=0A=
>> +=0A=
>> +		cpu =3D get_cpu();=0A=
>> +		bis =3D per_cpu_ptr(blkg->iostat_cpu, cpu);=0A=
>> +		u64_stats_update_begin(&bis->sync);=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this=0A=
>> +		 * is a split bio and we would have already accounted for the=0A=
>> +		 * size of the bio.=0A=
>> +		 */=0A=
>> +		if (!bio_flagged(bio, BIO_QUEUE_ENTERED))=0A=
>> +			bis->cur.bytes[rwd] +=3D bio->bi_iter.bi_size;=0A=
>> +		bis->cur.ios[rwd]++;=0A=
>> +=0A=
>> +		u64_stats_update_end(&bis->sync);=0A=
>> +		if (cgroup_subsys_on_dfl(io_cgrp_subsys))=0A=
>> +			cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);=0A=
>> +		put_cpu();=0A=
> =0A=
> As-is this will clash with my BIO_QUEUE_ENTERED cleanup.=0A=
> =0A=
>> @@ -666,6 +609,7 @@ static inline void blkcg_clear_delay(struct blkcg_gq=
 *blkg)=0A=
>>   	}=0A=
>>   }=0A=
>>   =0A=
>> +bool blkcg_bio_issue_check(struct request_queue *q, struct bio *bio);=
=0A=
> =0A=
> It might be worth to just throw a IS_ENABLED(CONFIG_BLK_CGROUP) into=0A=
> the caller and avoid the need for a stub in the header.=0A=
> =0A=
=0A=
Aparently constant propagation doesn't work the why I thought it does:=0A=
=0A=
diff --git a/block/blk-core.c b/block/blk-core.c=0A=
index 7f11560bfddb..4111fd759e37 100644=0A=
--- a/block/blk-core.c=0A=
+++ b/block/blk-core.c=0A=
@@ -988,7 +988,7 @@ generic_make_request_checks(struct bio *bio)=0A=
         if (unlikely(!current->io_context))=0A=
                 create_task_io_context(current, GFP_ATOMIC, q->node);=0A=
=0A=
-       if (!blkcg_bio_issue_check(q, bio))=0A=
+       if (IS_ENABLED(CONFIG_BLK_CGROUP) && !blkcg_bio_issue_check(q, bio)=
)=0A=
                 return false;=0A=
=0A=
         if (!bio_flagged(bio, BIO_TRACE_COMPLETION)) {=0A=
=0A=
=0A=
=0A=
block/blk-core.c: In function =91generic_make_request_checks=92:=0A=
block/blk-core.c:991:40: error: implicit declaration of function =0A=
=91blkcg_bio_issue_check=92; did you mean =91blkcg_bio_issue_init=92? =0A=
[-Werror=3Dimplicit-function-declaration]=0A=
   991 |  if (IS_ENABLED(CONFIG_BLK_CGROUP) && !blkcg_bio_issue_check(q, =
=0A=
bio))=0A=
       |                                        ^~~~~~~~~~~~~~~~~~~~~=0A=
       |                                        blkcg_bio_issue_init=0A=
cc1: some warnings being treated as errors=0A=
=0A=
