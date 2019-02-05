Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E394FC282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 14:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F8320811
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 14:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Lexmark.com header.i=@Lexmark.com header.b="I9w9lCTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfBEOlc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:41:32 -0500
Received: from mail-eopbgr720127.outbound.protection.outlook.com ([40.107.72.127]:63524
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728496AbfBEOlc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Feb 2019 09:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01jnhgIISDbIGvEPH/cs4Ns8gBEETejxJlV8Pioem5k=;
 b=I9w9lCTmtTDVGgl/qn0eW+5CNCCvEXAwbXL41chXMaZlY/TT0xRrWB77Ovf0MGi8CYKQcOxCPPNo2rbH6Te8qSqckQe6wmfEg3pEeJnY6qNtuo0yfWL1tLEWwfXhDvVdv4s1KjuhOCpzyhNKNghvoueOM9LIKZ/3OhXtyEISuRw=
Received: from DM5PR1001MB2412.namprd10.prod.outlook.com (10.174.184.33) by
 DM5PR1001MB2218.namprd10.prod.outlook.com (10.174.183.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 14:41:29 +0000
Received: from DM5PR1001MB2412.namprd10.prod.outlook.com
 ([fe80::3134:b76:2401:e3d0]) by DM5PR1001MB2412.namprd10.prod.outlook.com
 ([fe80::3134:b76:2401:e3d0%4]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 14:41:29 +0000
From:   Zak Hays <zak.hays@lexmark.com>
To:     Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: handle complete_work on the system_highpri
 workqueue
Thread-Topic: [PATCH] mmc: block: handle complete_work on the system_highpri
 workqueue
Thread-Index: AQHUuaHsNpCvr+x5YEu0x0mEJctlYKXPMV2AgAAhvICAAESAgIAAIQiAgABTykE=
Date:   Tue, 5 Feb 2019 14:41:29 +0000
Message-ID: <DM5PR1001MB24122ACC36FF5BBE563758A88C6D0@DM5PR1001MB2412.namprd10.prod.outlook.com>
References: <1548965800-3080-1-git-send-email-zhays@lexmark.com>
 <CAPDyKFpcmyKnF-QPBV1vbTfGdSYN30GayZSA5O9Gm_EbZjfdAw@mail.gmail.com>
 <20190204082527.GA5953@lst.de>
 <CAPDyKFoB+BV-ea4ctYixoJJvY=5f-NMm29iSTRTo5xbzKaPLgg@mail.gmail.com>,<20190204142851.GA12581@lst.de>
In-Reply-To: <20190204142851.GA12581@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zak.hays@lexmark.com; 
x-originating-ip: [192.146.101.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR1001MB2218;6:JGUD5G/Xl6BuwDtdg6Y+oc1oGKQ/mZts563QkOL7rVEw2XhOpElz1wTCzmQ6PoHkpzczR3KI5/oyEw8Kn590xkbOfAcFMdOqkHPR2s4pCs7sf8f0NoYpbWcvfZc0Vr1KemYA6xhpqZ/mLaLuN4ID0m0m3L4gace7z1H+xQAiW6XkkOGTQMJ4kR7NWVMbU353LoEYc7q7eYMao+1iY+i8++BDXeKhVfgulgAdVb4mLYxDMNAWXz4EkklEWosYXLqMbkNkuCEG/4onX/dTOukevP+ii1AIWEcxpt9Z+7gqxRkg36fyji9vFvbyISOFW4OLM4Mk+30P8G7S9m3F3MMjRS5hwGw03oEgzZQd66AdUIF2ZF5dOOlu05TkpeAYWcGL27ybWttFoQnP4KRUznWm6kn7Epy/ro6psRqYBIZgQEsp6O7u8wkbQ2E4JU2C2AZPaZeQmkXOkphgAW4iy8Pi9w==;5:OKcpiFGR+7UTNo7dzqa8wA9AJpWX4KSvoUXjuD5Hybk9qOq1fT8ug2vwBwtE/oWYVFN667QQhp58hndLXqLWZbsLOzn5nzMk3xB8YS4jUGNVf1DoyxUxA1jt3+x4e9chRttkvlv7BJ3qpp2uhbtHhyEmYF9sMSDELEVCDV8JVg2fy3VOfqCV5YAWZrVl0qM0PJ596CS2dxsnl0LyDco2bw==;7:/YlTCsaaUWopwN1rSuaplX7TTfa06YcFEQmVqhEmvpHaOKtdHyxv5GdAK/uUhkiQQgvWb93fMDl5AUkesZPncTXsv7PKbysyqx9bKdmeVty5dJzVgFajQgTQJb36sHtcBEFGwZyQU4CX/xblsoTscw==
x-ms-office365-filtering-correlation-id: 938d5052-c4f2-4d1d-30fa-08d68b78038a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:DM5PR1001MB2218;
x-ms-traffictypediagnostic: DM5PR1001MB2218:
x-microsoft-antispam-prvs: <DM5PR1001MB2218605F885E56682203447F8C6E0@DM5PR1001MB2218.namprd10.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(189003)(14454004)(93886005)(316002)(81166006)(54906003)(81156014)(53936002)(102836004)(33656002)(68736007)(76176011)(186003)(6506007)(97736004)(74316002)(7696005)(26005)(2906002)(44832011)(256004)(14444005)(9686003)(6436002)(55016002)(86362001)(105586002)(486006)(3846002)(6246003)(11346002)(446003)(4326008)(229853002)(66066001)(25786009)(71200400001)(99286004)(7736002)(305945005)(8936002)(476003)(106356001)(6116002)(110136005)(478600001)(8676002)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1001MB2218;H:DM5PR1001MB2412.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lexmark.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LubgCzqrYaF2zk2nv6EGlooLhvooKfCZuS4+xIEwtUN0RDIeWaNZp4gQpOaN3cuWCGXpdACnXu3uUu3hG7Cw4oqYDTCTjBCzvttqg+2Dna1FtPu3YTxmiT9B8F2KwPm2dV4v2NSLIPP42f0sBfa4CNf70D0K0cXVC+6tdsYJg4ADUqyLztw71kTsaf7vh5roq0jVLN1lyz2kdnCWe9FbzI37tNOMPy1WfcyPVBfL+4IU90Ky1NAn5RN4Ao0ZhwGVENz701Ja3pwZj8pZiXvsgX3cCnNumLhHvETcejaCt6Bj0Jrbt56M9u9nGRyXiMrvjGqJELf5LsnzbBsGNUY0M8zWSpWjmx+fZil3jIuyiEzK5Km3YOZCpYjSZ2PMh3pxrxYQHFz9nTtxz9ZYroKjKonWDOop331EouuRSUAHwWQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938d5052-c4f2-4d1d-30fa-08d68b78038a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 14:41:29.0247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2218
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Mon, Feb 04, 2019 at 01:30:37PM +0100, Ulf Hansson wrote:
> > Although, I am not sure why having our own mmc workqueue, would fix
> > this problem. Couldn't we hit the same kind of deadlock anyways you
> > think?
>
> Maybe I misunderstood the issue.=A0 I thought the problem was that
> the one rescuer kblockd thread is executing some block submission
> work item, which is blocking because it waits for something in
> completion handling.
>
> Now with another workqueue we have two rescuer threads, one that
> exectures all completions, which shouldn't depend on items in
> the submission queue, and another one executing the block layer
> submission, which might or might not depend on something happening
> to another request in the completion workqueue.

You understood the issue correctly. Having a second private workqueue shoul=
d also avoid the deadlock as it avoids having claim and release tasks on th=
e same queue.

I have generated a test build with a private workqueue and it appears to be=
 equivalent to my original patch. If this is the preferred solution, I will=
 clean up my changes and resubmit.=
