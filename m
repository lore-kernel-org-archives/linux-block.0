Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3079C388F9
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 00:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DA42464E
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 00:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="YLMs3prg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Juol58RS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbgKQADI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:03:08 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26663 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbgKQADI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 19:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605572477; x=1637108477;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mKVYA5QUqJaKQ4t2FC/e7uX2kowoQJXbDfWfsEtsJCI=;
  b=YLMs3prgfjdEdrPckFyeFPjaGDIkgT1uDdQspOimJZXRnVHAyTbOxvId
   DLihtsqkOUf94bPq+w6Veh1Bx12tYp6SONrQ56wNkscMx7T0iBGrEP0OX
   pdOnEsvyCdCtKK1/wtM+MXrWXtasasNtgepHBuyF7co8v4u325m3SoX/9
   LsxoIw6sxjJVJU9qOCtKRS5P/R1hoxzVMBWjNDM2nIOwt25Z1X7fCYhli
   zZeAFBcP1DEFi1hfdNmQvA9hH+D3nGCQd2ls9IGUYoJsGV47L69463IfI
   Y6hSU5Dkrk4LoTPifzaKzZpCOH301D+5lPT/Z9f13n1lo5nlfNiACaipV
   A==;
IronPort-SDR: gfnSsuM6/31wuq8KOpXa4ukt3LUByxDWTTFyZjKrg/lMf2JFnRRTvhsLfs/RXQuVzf5dUwexCK
 +pH9jjVcQ7V/jIn9GUnXs+iSyGs39XTB9kKmuohAqW3HN5Jr6MynnkCdz32qsVuECMRS3S0H9q
 qzk4VuxgZHzphYl7oBFjjCUOy/+BHeyshB34/HZtZH+Ck8m7qVny+tBajWwLqFMU1kaUpkib6H
 imcTnfg+tusxFDFbV+Nn9rMpuiDTqSv3FOwlpwqXplBsPDNnlFwGcqHyFaxTH6Qe/QxiERDwAC
 uLQ=
X-IronPort-AV: E=Sophos;i="5.77,483,1596470400"; 
   d="scan'208";a="256327121"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2020 08:21:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amJrSd/LZ8aqctQ19e1Ajid+IudRQlLelrcGa/fWSEHYzEF20m4B+PuIA0uPLv1PVb47wt7miHSEF0T2KilkgST7AKPVChbuog11XM/ekcfXhkYQFOz7bQntBIxzLfXGT8TSMPtR0GxhkbNZjHxza2Vcm+nJLsuLeVPiRk87W33OvLu/baQZLMRgg0amPLgY3X0rFG38RqLF7qPgXteydEbHTxkT0rnauSXpIylY73X/PE3F2xjNmpi3hEfpSR8emXcAZMnG6YdE0GdYHrjX/Y2YHnHt3erIGCU9xTw5kAW52bLh7feZ/rJ7EOmqnDI/zhK6Rw7Fe0NmbSL0nq7LSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFOaS6fosd8R5P0rKt1aPmS5unC0msZhTJ9SszPpT1o=;
 b=Wckt7z2oIc5fUllQ2j3IT4cV1fiq+CG5ioE3P0VSRu9soMqM/SI/9B7qMq68sflK2jeF6F4ltmlnxJxgBQ1i7cDc+dd+0oNAN2JQkXq+faINtD3NZ+ZhWV0KE0kAtyKo79XnVob0EuLCb9vBvkDbLH7Jl086UxAVc4kPQXQX23cMdzrFvYz9QKBJ2njAeZgL/XZoLF6HT+aRl8+yYz2ITd8WZHiGyhxwWVbA2X+3FCk7u5MFpVb7kpfdH53K7DcUYtEk9Kyzo/QpLH7SDXQZdZ7NmWWk7pX6a6vlf6Fw9brIhzYMyd4UI1Mw0C6zcOGt4hNcQAqgnP0m9dEZ+oiPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFOaS6fosd8R5P0rKt1aPmS5unC0msZhTJ9SszPpT1o=;
 b=Juol58RSm1jMb12/P4PHLdA970Yq5ko5LXE/CXIrbI2AuNo+JLjsl0jZqX9ubov5yikh9de7sk+s5NxZUoQShx1wdXZwz7ZGA2IN8BXuGIv7X8I2aLst9+SPfgcSCfDyk3I0GZh/hGPECmwPmcjNETcAepahy61qtBuBnZWfreE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6671.namprd04.prod.outlook.com (2603:10b6:208:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 00:03:05 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.034; Tue, 17 Nov 2020
 00:03:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 4/9] null_blk: improve zone locking
Thread-Topic: [PATCH v3 4/9] null_blk: improve zone locking
Thread-Index: AQHWuCq2+LYCKLSr8Emz6ePgq2mYag==
Date:   Tue, 17 Nov 2020 00:03:05 +0000
Message-ID: <BL0PR04MB6514DB4325B8A31CBF1D3F80E7E20@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
 <20201111130049.967902-5-damien.lemoal@wdc.com>
 <20201116170024.GB24227@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b96a:a84f:2aa:fc65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5eacf1cd-f233-4c88-d7cf-08d88a8c28d9
x-ms-traffictypediagnostic: MN2PR04MB6671:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <MN2PR04MB66711EABC54AC2BA4C8182E8E7E20@MN2PR04MB6671.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a7/UqDN6qyzhCEoDlrPmz6cHl5Gywh0nn4JPKzsAC1a4q4UaXnL0z5vRloB+RCsIv+F+bznkMKTiIzJ8ATEsUtD6Em+KRmiX9KcvhrIo7brbI49FCXE0HpnpDx14V74rZcZjltTPy4dIhki9RyiDhW3tMgvAAVqaGJLI5pWjSStyQaPA/1Hw56kdb4SvtkcjHxd1ImB2oFhg6gwvl+UcDAMmCJV98PXuq0fup4C6f5LRGarw5RUWOy0hg0+0xRu9fYxbRwWqAS3eLlOJTRW5khaphZjOBnTmtqJTmk/TLR4m7HgyBH9VuCi4nyxvDln+CmwneZRPGfZzj74HHYPFVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(8676002)(2906002)(316002)(33656002)(53546011)(54906003)(86362001)(8936002)(6506007)(52536014)(71200400001)(4326008)(5660300002)(4744005)(9686003)(55016002)(186003)(66446008)(64756008)(91956017)(66476007)(66556008)(66946007)(478600001)(7696005)(76116006)(6916009)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fsAwVqb9I1wAbj3ujqrQh3O2EWinoaWNJg9Gyje44BSxK4yff1yDo1HRhNHAiKfabd30GdT73tS0xiNC3gp3zl0VSahhN+KrSlAsWEqPyOyyzitOI/R+gmPkql2NgH0OOjdN4/sAJnetWp94lZQVh726WhiqKRPzfjtO/TJRMq4xWwpAffqXq4u9uvpqUv5QffnRRkiVUInq2YadQp5KwYEmIxmzqVrLbFwLr+/lup4cJ8GXzTCdwgBUdskq9hlRcA7xEsacBgeniZsuVl2NJlelEMByCXOMBLIiWYD1VX+4Ra5hpP1t6ouod7E61W/l7KFmDvOeV6rdkx17FvO0VKwy1j3eDj/MVr25U74YZQrisHWtMPEIxWlusZBdRP3h/+/qYKu/UbctDsFxusmPWjn7STCo2Qd70boaOEQYrQcEAgt6nKfCMwBPh6AAxThHyaNXXap3o6R1FReF8kHcPSGbGu7QP1StqtZ3CKU8DGnZtt9kUF2VLgHXu8st0JC6RXcJRGZEElNQOxVItAeFS1e6qaodI+Y9b/Zc8BEoyerILPK3HeDDTJRhXC16SpSuHovY+Ecvk5pwUJH09d6yUzltueKQMjOUy2fazFmU7GMA1neRsgIN661XUoCXPZBYmebwlpmOb3rc7rLFMzycnBUPrLsTtMvK8SpEOStGp77TrSvOaHAS7vqGd9neBbFjxGisH/AMRXKH9uHnN+TL2w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eacf1cd-f233-4c88-d7cf-08d88a8c28d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 00:03:05.7468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ya2eBy00Wkyun1Z9KjQhiX1VUzTSiZnyVLo4XjhT1Ng4STwKE/bzQfoCruMgGmItWyN98mH3NyfRNfQZ3jWQ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6671
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/17 2:00, Christoph Hellwig wrote:=0A=
> On Wed, Nov 11, 2020 at 10:00:44PM +0900, Damien Le Moal wrote:=0A=
>> +#define null_unlock_zone_res(dev, flags)				\=0A=
>> +	do {								\=0A=
>> +		if ((dev)->need_zone_res_mgmt)				\=0A=
>> +			spin_unlock_irqrestore(&(dev)->zone_res_lock,	\=0A=
>> +					       (flags));		\=0A=
>> +	} while (0)=0A=
> =0A=
> Can you use inline functions here?=0A=
=0A=
The macro make it easier to handle the save/restore flags compared to inlin=
e=0A=
function. I guess I could replace spin_lock_irqsave() with spin_lock_irq() =
and=0A=
spin_unlock_irqrestore() with spin_unlock_irq() since there is no nesting. =
But I=0A=
do not like these functions as they are error prone (if one misses their us=
e and=0A=
starts nesting locks with the same functions). But no strong feeling agains=
t it=0A=
either. I can do the switch.=0A=
=0A=
> =0A=
> Otherwise this looks good to me:=0A=
> =0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
