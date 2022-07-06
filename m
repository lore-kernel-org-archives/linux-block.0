Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFF4C43334
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 18:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiGFSla (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiGFSla (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 14:41:30 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F7014006
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 11:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koiDZSLbLTDfanmRAy3g6avGsmt2JGz19pYe6ZN6XqjRlLwfT2HDEBFOxaZ/yBz3QdkXySQZRTkycgrABo40RbY50P49g6oFqJqhJD7SCirC7s/lrVVp6qL66P4W0OGdf6Hc+KL/ztAHJzomKSPEdOa8gwSrz+DfVVRaF1SO59uJyXtNHxIp7Xlwuxqa9pHquR+b9TtIIZH1xSywA4KMaI0wBu/AL3iNwaPX6jwfcZIMNCZ701X3CuXYtHG9K11+vcGYC95NMHDc4bzN/WluvSWohiPYq59prBkQgkMqBo81pY/pe8EPSUbkyqH1/NVL5k0j3nAQKJWsVgTmyOsejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSl0HF9jiCfbWN/l6ALoN7igrgMddlA6kKgWWhl3kII=;
 b=ofGBcOgtE5MqIdcW/v2cs3fjvBsfYODWcr2TsOSf1qWwaM7qxge03qrp5ZMMecTI03W1sdqWN9jm8P9iMCA5eQderHqiP1waX1Ys5YXgi0wdGsyy1wBWecGFy9Wr9IrcOvNl9TQaXxaTgFZHeXKW9G860zioxn5lOz7UuIw/qEToFGNpp5qCWgdMPOhYNBX8ccUTCEEb2yFogW/UAWf9xKHEyTFDM1yrhEYpcBjUCzVbvzHEVuhGuvo3iFvoHWrx++fw8zBcyCrxGamCyarzyr/Dj9RbIk6cMNlh9D1qdoAlA6f911tFXBrMaA7fxlKggk5zjNFdRUzwg+21huPACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSl0HF9jiCfbWN/l6ALoN7igrgMddlA6kKgWWhl3kII=;
 b=ifu23Cyp4fserAH6iKIrd3jlwqP/Y20hDdF0Pq4s+wP21Y0EzeaXUQKmgdLUObp8h+giyWLUZyxfIEVxXPN50EuNMOUzfAjAYCXGi8Ge/0O7iyGeC95FL9F8yqobBX31vedwWXPoxvDNZSYrEZqFp3+2tpWbMvoWlc3FD6x4Hyk=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH7PR21MB3260.namprd21.prod.outlook.com (2603:10b6:510:1d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.2; Wed, 6 Jul
 2022 18:41:27 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992%5]) with mapi id 15.20.5438.000; Wed, 6 Jul 2022
 18:41:26 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: Question about merging raw block device writes
Thread-Topic: Question about merging raw block device writes
Thread-Index: AdiHFR/O/apBVKitTXairniuc6HJ9QKUqi1w
Date:   Wed, 6 Jul 2022 18:41:26 +0000
Message-ID: <PH0PR21MB3025A24A3B27D21465E4C932D7809@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <PH0PR21MB3025A7D1326A92A4B8BDB5FED7B59@PH0PR21MB3025.namprd21.prod.outlook.com>
In-Reply-To: <PH0PR21MB3025A7D1326A92A4B8BDB5FED7B59@PH0PR21MB3025.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9eefed94-8cb9-419f-8b6a-54707b07e910;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-23T15:22:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4667ed80-bfcf-4a01-725f-08da5f7f223e
x-ms-traffictypediagnostic: PH7PR21MB3260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a5cq64D+3GNCu6MQuQ5RyIED3qC7La4h3psnNjVJw1IQ071nimKbk0DLtZ8wtGdMkJKl45vdn44WSGALdu7srbIv5qNuXS86XMVA429DiiJI8ibHeylqZ9npWw6hoaP9qXng/jdRhFXOgloNVwzKgVeCC3K/HGIlba+xrPy3W5L132JjC2ztfUgS/rHw8F1mvTEqtVKAz7/g72EnnEQmkQ8QEIfBQ7MJb1KLM3jjWRhLIsblvrx+lI08Y6//9O6z22JEizdYfqxA7P+p7SyvR0mDwhOChy4GI9Vt8OKg4JtD2WkpQFC5zAT4VyG60uy/dM3VEFJmNBlysfRKUYSXoNm/JsQJM/o3RhVcmBSwQ175iMM5+oxK33/msEkVK4oE5UfzFrzO6ei4vXSgWu8oT0W4GQDazRAfkF4qWoOokNQPZxnroBtUFZdiwTRzOWsHuqkq+9TgTAHTFpG2OGoS9BTJ/++cv2fC8dxCwNva9ptoskuXjrCK0dyxrUy9w7ofkDFyanw5C2ylb0pIQL2yG1W32WtpkFNRnOuEDa1wCFDGEsliOThZ8rLWauIa1VMDdVQ5UeSgu8TsQZ5Pfh3TeYGCHY4btt/+m6jmFDB/qJu6Q1F+iY/yrzgKLmyyJirgq3TXYTJ1itXh89VaLge1l12Mlt31rm862+NdxtJOfAJQ8K63RMvD90Koy3FsfQh78rYlDq+sjt7n2FPzUOFUIgoF4bbOtsOUEt2qtLtUASVXShinpn5rsK14+zZph3q1J4jMZsu1CzeXMq4Zay5dgkXGU7EzSNhGuP9kisRq6Ux2Bsez+P24AdIISwymi4h3uJWDzPeKKE3Dd1AJ/KTAx/2Yuc3KLTc/jse6LyRp2O+OfEkn/T6ekpUR1P9ekIOP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199009)(6506007)(26005)(86362001)(7696005)(41300700001)(122000001)(38100700002)(38070700005)(9686003)(82960400001)(186003)(82950400001)(8936002)(52536014)(5660300002)(10290500003)(76116006)(66446008)(66476007)(66946007)(66556008)(33656002)(8676002)(64756008)(8990500004)(6916009)(55016003)(2906002)(83380400001)(316002)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c0SBH160h3EtYTcGbAGE+89Wq9zY17Gm5xzHukedqiK4X4OzqVPWYe6Gn0mJ?=
 =?us-ascii?Q?gC6wTnF851ZRStrK/dHTbOPFMgNQzQa959IqkEfusaOoJ70Zlua6l6KuqWtK?=
 =?us-ascii?Q?xkXbeTFkqppFYeU7epI/9AD8pTwUR0wZb1q9NljTCnbU/3YyUMzp/rXw4FBA?=
 =?us-ascii?Q?bUYwd21Bc09m0u7MXv+e4gsSBB9T/+g4VOik4sj8cI839DM3Nx9egzpvWKrd?=
 =?us-ascii?Q?aezORRQKd7qUKIB/29BFk496DJ8b7E++uhjkk5JF6G0Zevxf3yKkkdWwsRBc?=
 =?us-ascii?Q?gDVZQrhR+bTq/LfcLTAEWdtuSfdm/GlXDfawLI0dzIGUsyNxLnhXyc3KYwF6?=
 =?us-ascii?Q?kxhY+76NUH44DXz/0MfE4/HZ52q9zmB9x4zjP1b8k1l5cNwTV8y9xmQM6pzr?=
 =?us-ascii?Q?23sJ2MOQaJ7Zyt41IWWwLOBUaHwlwsT1F2Lnf5OlX8uaF+WUn726ATOnaSE1?=
 =?us-ascii?Q?eRAfemAEbHr+wWZjPiu/Maf3LHvGnfG+dfJFlxJsG5gYiqIbeQ3Ul5PDlEI8?=
 =?us-ascii?Q?Q1LCHLX7Ksn/vq6n+BGxZYnyQArnfAytGQ317M8qPHSyiGsyiJJM+HxKBOpU?=
 =?us-ascii?Q?OaPw2hEdY0RD5HZyR3pFKipwYjNwKarBOWHPnht4mrVzeaamKbR8kbz9ZF0b?=
 =?us-ascii?Q?r127BKhAJ5udrZO6xYTTqgoQAiu1FyqL+aOf2Edb9ttdshKLcWq+zo4GZZca?=
 =?us-ascii?Q?QrOe561PNnEwG+nfM4m8PBE+EwoicGlLQxWgQ9V0v69xEBSMwoQM2wgNM4z5?=
 =?us-ascii?Q?qUErbfzzbBHd9K3rN5E8FB7xuTNY3SnV62MfFXtd8cK2eqP/iukas4DUfflB?=
 =?us-ascii?Q?4mHbqqie3YYaQbQVPJny/KMGvWABcN2gSbO5NmFfCCrVa7V9EbvSnecS6d+H?=
 =?us-ascii?Q?X8f8/fZj1bYyckAQjbesnXhd2Du5avpAo62snJvqLe1p4oTRjzNfH9UyeaGp?=
 =?us-ascii?Q?I2vOWmjJ62AmC4Wbr5RfJCW4oDN62hHeFjLPEAHeM15qrAWvFkDS8zKwj9Ur?=
 =?us-ascii?Q?AMCtSXt3MlbIrGJa4FOt8LnBEeW9o0sZj4bbuko5gYlDPk5+117Wmtfc06nX?=
 =?us-ascii?Q?2sdMofsEwzt0tQYu9DuXlzPddqLvwfqbx5vJCRB2LFcsE1E5Xfyuf9Z5PTX+?=
 =?us-ascii?Q?B8EVwLFLHXw61vWOdocaOYJ46+wh6ZAlfzRX+6BhtwhxF3pPVjideApMsLVm?=
 =?us-ascii?Q?VCv0qmaq2GwUg8CYWjkgt+gLYIqx89kYEX73D9y6XlFTt9Kyq/4LkCAM1XcF?=
 =?us-ascii?Q?8Pw1MZIVcZbqnZ0PppK4Jhw74uVJ/zkBzanS5GWSsLXya2Zj1YTZsh2zc6Sz?=
 =?us-ascii?Q?Z/2APxvfO85vAmwu0iY1Ph78akq7V7GFFXOniwJah3myg53IBEiliTO0iXfc?=
 =?us-ascii?Q?f0wiCOfUg49E056/tK3K1vtqZnYFlItpl8v8yoN7MQUh+T9W7h5Li6cZ9f3S?=
 =?us-ascii?Q?rIqj6brfl/Cfhl8vPhC/y9ymeywa/uP1EHoERrEnQvdl0g83gPpqax9VcC9H?=
 =?us-ascii?Q?292eFHGDtk/xYq9MQJVTelxIRy0vfRKbgonFJ5PzPEqIsa7/D2zivXGI1PsZ?=
 =?us-ascii?Q?wFDhKNqzLD2ocHuFQlx1rXnN5maJB7FSE5A7335U734tJB0zQA7TGmLqIzKm?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4667ed80-bfcf-4a01-725f-08da5f7f223e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 18:41:26.5724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Y2FkiMkPDV9rsw43S/CTWdR64lfChOSHtSNQ41G2KVnK87OGD5GqrlaJiLcBSLRXTyUKmxCwuQEI2hN5We4Ppc63+3nfEIgWmzfLHhYGd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3260
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Michael Kelley (LINUX) Sent: Thursday, June 23, 2022 8:28 AM
>=20
> In using fio for performance measurements of sequential I/O against a
> SCSI disk, I see a big difference in reads vs. writes.  Reads get good
> merging, but writes get no merging.  Here are the fio command lines:
>=20
> fio --bs=3D4k --ioengine=3Dlibaio --iodepth=3D64 --filename=3D/dev/sdc --=
direct=3D1 --numjobs=3D8
> --rw=3Dread --name=3Dreadmerge
>=20
> fio --bs=3D4k --ioengine=3Dlibaio --iodepth=3D64 --filename=3D/dev/sdc --=
direct=3D1 --numjobs=3D8
> --rw=3Dwrite --name=3Dwritemerge
>=20
> /sys/block/sdc/queue/scheduler is set to [none].  Linux kernel is 5.18.5.
>=20
> The code difference appears to be in blkdev_read_iter() vs.
> blkdev_write_iter().  The latter has blk_start_plug()/blk_finish_plug()
> while the former does not.  As a result, blk_mq_submit_bio() puts
> write requests on the pluglist, which is flushed almost immediately.
> blk_mq_submit_bio() sends the read requests through
> blk_mq_try_issue_directly(), and they are later merged in a blk-mq
> software queue.
>=20
> For writes, the pluglist flush path is as follows:
>=20
> blk_finish_plug()
> __blk_flush_plug()
> blk_mq_flush_plug_list()
> blk_mq_plug_issue_direct()
> blk_mq_request_issue_directly()
> __blk_mq_try_issue_directly()
>=20
> The last function is called with "bypass_insert" set to true, so if the
> request must wait for budget, the request doesn't go on a blk-mq
> software queue like reads do, and no merging happens.
>=20
> I don't know the blk-mq layer well enough to know what's
> supposed to be happening.  Is it intentional to not do write merges
> in this case? Or did something get broken, and it wasn't noticed?
>=20

Gentle ping.  Anyone have knowledge of whether write merging
*should* be happening in this case?

Michael
