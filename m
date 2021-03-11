Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6E3C433E6
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 08:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2BB64FC4
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 08:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhCKI0u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 03:26:50 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7693 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhCKI0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 03:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615451205; x=1646987205;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=JsZtzAG1fyLZPiWpu3tUp9g8DwUYAPGbAlLRl/1teSgRpImt0dCONSzY
   re5WE9MU2RStnwENiwBDZiH6URNPcXgQKHNTrl4rItn9/Z27+SH8Hbdkl
   0FdzA6eOvWJYNxcz01fvzgrf5Y0U8fDgeKHyV/OjiuVGTVOY/QHZtABlu
   eIb7JQ2P0xbZFFn0KYjDcZ6FWmbC3pYbPvXW1FM67vzlSrt2bXhXCSZPd
   ULD885lIeaCResEJX88+wiYFod0DN/Ld4XgVURd4/NUBJTajBNpcPvkPq
   b5dSkEpqsswe5x3fnj9pdqkTfTBUA0b7sNzktcLVD5ASjhR2p/gu8EZPk
   w==;
IronPort-SDR: DHiqwGOF5KxCLUFw9+PbHi/hYjiK07+h/OBjgb4TIKREsUr7awLh0BcHlaISKhZEpovmvKTEjk
 8IN7wMRJodnWSIR4w8gg71QITm2hXqN1k4Z+rj7repHvIa26qR3fJa48Pyuys7D3OqO/hxHcD6
 WpcgX5yqEPULm6kx6jyiv3JqjiQUKnWbgMXWm+1GME6V1fXiEx7e6VqKUhTR+INFtfG/Dnzg3T
 adBhmOmQyHVWS/sD6xfcYVGVO7YfReW/CaLTAUd01AKdt+COVrh9ZrbiHnxSGc+BggEz/o6j2d
 UYU=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; 
   d="scan'208";a="163057874"
Received: from mail-mw2nam08lp2173.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 16:26:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5EqmJ4yuH6adpa8zmEq1TZODLp3mtijqpG2Zz8CPuMyArJ/rKWeUkeOBtMPyWtNnCkfJGTODiFAPOqU/YxomJvV5fBO64MooEenixNqWeaNzaaEDXaH8PWP0pa1KImkVqU0lbeFXIKknObK2VyzL3cvZaAc1ckhyp+OFICDYSeKDQ7PRl4zNjfj+cfLukrL6UMqS9m6ERVKwB50QJRZqcL/pv0O8BknYKDoCLesvOIAJOm2zxMB56eXuN4VSzd8RWzw88UprsFJK0aeROIC2GldhxPSRUdjrdlxqyp+GLfKm/joqNrB2s9z5WORPikUwmsJMO5shI5q1e2Evp1+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=V0sItmGWYf4zaNh7jlpOahXTpeLqyQNWXdUCNwksXJWcqaI2UmOLLQ30XmsAJ2cQ7CTaM/hQuiiwqqaJimXxPW2M1eeBuNDOqoammFhKIVloSeZhccQB+7QLWfD9YDDglG0fhZMAABld24wwtqEIqmtxqpS83V3rEkUah5DTVRRWS19LYXFJqyKHfQIFoHXdiW72aVgMA2bnBX8B5j9fGFXnMarwvuVd4dzTpjd4C/O7S5zvmShx4ppz805XC8BV6NpLHaxV01jex11aysn+7+vUNjVg1sK939Rjc81XmVlTQpSZTquWooLF5VjOSak13Xn32h6R0JxdnB8Svq1n/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BQaKZmIltfJYbiVXX2LgWuZcjdzY6vryZzMMHbJkmIfezf0xgdZLxQZamkqO1/uxbulFhvcNxO1ecD81VwvaQeTeboo2fuRqYeebF9HqTrOobi1m2h04yNsaOqGVmvESUbYQcqrcvzWLp7y+CWlRHL6gI+yB7YBMeJ3F77OlIuI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7160.namprd04.prod.outlook.com (2603:10b6:510:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.21; Thu, 11 Mar
 2021 08:26:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 08:26:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH v3] block: Discard page cache of zone reset target range
Thread-Topic: [PATCH v3] block: Discard page cache of zone reset target range
Thread-Index: AQHXFkfeY5oqygOfKkSfuRqNKyLZMQ==
Date:   Thu, 11 Mar 2021 08:26:42 +0000
Message-ID: <PH0PR04MB741646E5895C63A05B1F6C069B909@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210311072546.678999-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:d87b:bccb:ca15:1ed8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bcf322b-aa63-4872-2c3a-08d8e46766a2
x-ms-traffictypediagnostic: PH0PR04MB7160:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB71604E06FAD4512CDC123D2E9B909@PH0PR04MB7160.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pbet3DKJLl4Ko+OFTCi19CASyQ1xn/1kcTUwkrJd6aoj4OEdIAwRbp6fyYoMRg0uIixIMzSaO3v+rerKvy0jYSYzpxgm+XdFevP1BeK1iIFmp++I4VMZQDaLn9DCBgp7WLjoI4cNXhf2Lel3b8xJ44CjFN9TlYhSuz+G449dqMWiRCrglwvVu6yAn5Ch9HBTA4ZP5w71ATiTRqVdKK9hSgPxkav2fuIJKHzUxvH0gZPMSuN4vLnZp6QZm/6J/keuYfsNysdUuTeGhIbAcV2ACsI8KQ9jYj/YLS8pKqD9ijT0qvepGB8b7uZ6mwpvau6cqFMS41ZigDsi5p4svhBO9HMvWUUjlu794I9wc9ZoTuRyCE4PBjZwbNyQYRORLUOJcqOtUXc/ModQmmii/3Y11VxmsShRBL6IlTcXuPrvIVxBeRAiVtfow5jaY+07rBtmOlobfDUh/+4yb7Rwa51+yXPa8GGJ8ViJ1nLjoaVvildtDc6megtL2LnqrNhjFwFFiyTun6zUJbgaTkejkn+lQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(5660300002)(9686003)(2906002)(558084003)(19618925003)(54906003)(110136005)(4326008)(71200400001)(66476007)(186003)(6506007)(66446008)(8936002)(76116006)(52536014)(7696005)(66556008)(8676002)(64756008)(4270600006)(91956017)(478600001)(66946007)(86362001)(316002)(55016002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: o49vm4fWU5XyCswR78NasudXRMZ0Vy6QHSAyoCsMTB5PiTZ7WsHK4HJxG04puyPxJzS6yCTQmjv1LlePGz93SnJKpUH1vr+o6Jud7k0DIx4j6pvLhW9IQUFx52FFG2o14xiveCsmoDTV0IWHRU0sSSPymXv8sg05OulFuo/f4rUOMXeL3t6Zl3b1I1VNhyQaGkp0CY1Ey8oD1kxdlQ36SSWNuGFu37DdF3q0jXv2jgZieza1rlPE77EBY5rmk7+1aax7DFF8nHdu3WQ/Gjb06mqOdxi2X4i56xg8iiM07b1dkPC0xLlimGWFDcrkb0Praffbj44Lf1ClhQYRd1m2WT4zo6hrioLTWSzDqOmhczw+oCe8d5bObk9GCP74kT//CkYaUXk2wAQGK9L8n4P8qQmmE8pbLhU1Ayvycibu+aB++8o7FgopTji8IVmYHT3HqZOfcQQSjp11qOLLJ198xe/u4dwt7bOVRSIDU78EgV2ajAawt6PHmk74QOSDVhNJklcshmxq4Kcsd5iAzCwuy3t/sUgAYoNmeY0azZ5xhppjNZEr70r9Nwv3OTM3uyJeqeaG/bnBjT4bcPoaTslra5Jwxl/vPLbIDbpzw3PwMwQEIDjHiNNMWkMeCZVbn4SAifvLBOVUCTPG26EFlMkMqJZapbccotgttN+IPy3W2y5i5hTRrgJxnvqHt1du3f3Efgo71gl5RFGfUjqGFATXo4CJwNQbGTPV8Zp1cfblJS/6sU4n8bOOWJJFCRT8BRk6pv3+vek05Rz4b8M950+NGjzljPcGKHqWOmX95RHDBjfCfAtVxxaGpoRINSRcsKgE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcf322b-aa63-4872-2c3a-08d8e46766a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 08:26:42.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9Zw72HIQHWJ6xd3Fmt7n1ykff4gdEOBW6jBOXdNlNfeLbq894KrGMk6wmg+2Z+98be42By8I5VcFP9gu9PTVOZPyhpcUf9dHhBCE+oc6Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7160
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
