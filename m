Return-Path: <SRS0=7JbN=AR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA449C433DF
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 02:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7135B20747
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 02:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dLinP3Fa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nN1cPJcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgGFCIP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Jul 2020 22:08:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20649 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgGFCIP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Jul 2020 22:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594001292; x=1625537292;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VIKfMgAa88Mv1GPYKa7kPcPMMEgsf2K1ePToiTUKjDg=;
  b=dLinP3FafEwaNinE5hmrskoL/HVcSJesCAR9SV6TFmfJqOk1AyM8BvWl
   mv97R4g8AgPUZ7YRkKa2skyQcVo/Z49kWm1jfArQk16WQHTkL4zX6GD4R
   Ln3lkqo/38yzTPUCRJByropMFkdifhyJyae36U0qnNWPGwR+zrhsxVEs/
   VY4Yw9F45PM29tU9hrBDfmLhcGpq+/SlhEli9fj9MEwbgx4jB6irSrOLI
   F8UGjnWgAfdLcDOfrroFtATWSRq4lNw9seSPflkJ30xIaOnsNq4kLos47
   MyVMW2V+haOWzGSt0F7M1nLge+D/ZQBqVlCn5rBRQZG57IBwRWL4QDMhH
   A==;
IronPort-SDR: CUyVZ9fMuEioEXyWL1RLbEK4cLYGbwYh8oxonn3ktjUWIPNA7qVkh95J4oMcgVjslOHuov8wh0
 I9eqaxzAp3QS0kmCMVlx1iv7cxAxadtTqEW2bFoDJRvAWoccvKIrtamFRqqs/uwGbRoBkjn/GH
 2DvMwgPcioE3HFw0UmUeEj6AcoRLMhTODBunwhR+Zy2ZpyAvmv10Xb5gqOXc+TT1kQ4afGl1yy
 eOEiF17qX8bGuCGEQHyMvKvbSX8ijy0kqfhW7O07WBHddV8ojwFJq7oJajI3msKaN4XZZP1vOK
 6hE=
X-IronPort-AV: E=Sophos;i="5.75,318,1589212800"; 
   d="scan'208";a="141698650"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2020 10:08:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbuSK6KF8i3xjkWvFYckTxvsuINs6x25To+k4034IAgWnVukwCTC8wVhf9+AAmoIF8WYGeTz9DJb8znOwQhSiR6/g8HgkB37pQZNuam5bVNT7AfB2q9e1C2uSD1LHhZCcWdKc2oK/RsQNNkuOr4E3m/RWIQdd0FC8gjGcNlFWIZ/xJJCBKaiPCZu9caRUff83xpgScyTnrJytfxNHWh2L2WcMZe1qN+JIb4rQufd2/oWc3mefIPRtQ2iC/2c/LcPgUMR86gzhY9h/VdsfrIQw9uBMPSHci72s4hxG9exbqrDcCCQHyL0xcLQrjGMREdofF3W3Ja0PTNOu8jxCW3Sbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCyj7ipAlrlmEScbHeRl/dvhdxsOZumI9jQeLdo0J1k=;
 b=OsRPAIZwbInOJI3TlBaD9WWOdOtp+77cZabHTPXc5xHPYOyhHXUnlyAjfo3KyIipIEXhXCbUTELdgHQmIgMOVHJuFOY7jiK+gkPmfWXm62WmuoxcLNfl63Dx9EF1YZ6V4OS0pe/IDShpDriUHefADuAys2rKjb1Wh/GVC2442UvY309cwKxrvfHvXa9tB1wdAh8+YVt2IzLyuBPofV6c2hsGrO0bfHF+S36qgsSnmry2OadJhycu68o/kRNPlVbi0D5257KRCJxE4x/lxB63+82KtUDUpzH6SxNZCgy6wExReZux928YNpOh1dgYdwwfwp9aiGMPSdyc9nRGorT66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCyj7ipAlrlmEScbHeRl/dvhdxsOZumI9jQeLdo0J1k=;
 b=nN1cPJcUDLj/3eXFZNyff+IeIXJRHOBGCpZakJpmYX1xOvT6pvuokxRIrnIdY7nfZV26TflmS2wsdzro40s7m2rZF5sMyFSHw1fUHJsQSCdMvojN9Y6pdDVIJrxcNgdiIO+XCttrUyn+BIq3LrmeaEGPyRxpJdCK5Xn1YHnhwmk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4664.namprd04.prod.outlook.com (2603:10b6:a03:11::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Mon, 6 Jul
 2020 02:08:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 02:08:07 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Rachel Sibley <rasibley@redhat.com>
Subject: Re: regression with commit "null_blk: add helper for deleting the
 nullb_list"
Thread-Topic: regression with commit "null_blk: add helper for deleting the
 nullb_list"
Thread-Index: AQ4NTAI/SHQ08aY7SUabbvu68snI8A==
Date:   Mon, 6 Jul 2020 02:08:07 +0000
Message-ID: <BYAPR04MB49652F7A69293256B555D22C86690@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cki.3B19A2362B.9VSYF9B2I1@redhat.com>
 <44170938.33551884.1593862676831.JavaMail.zimbra@redhat.com>
 <1b60cae2-c135-5aa1-1127-2ef89c320f43@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca442041-bfea-4f71-7169-08d821516ce7
x-ms-traffictypediagnostic: BYAPR04MB4664:
x-microsoft-antispam-prvs: <BYAPR04MB4664A9BB337204EC81A0FE6086690@BYAPR04MB4664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:113;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ce73NHqmj/OWiHYgErtqd+AkYAS3zCZwW3LC9GORWMb+Xj1YP3pPz/KhNhgHMSt7xqxoKfopAQQeBuA/Ae6mf8ffjdyPBle7UxT1jIOu8maMADd/VkUq2bWT/cwzhEI4MvJPN14TLcNBNxcO888AOZTgVcvGBFCDkxia7KSeYHhxs/Qu4PyPeXNaKY5etc8rdf5RwE7snQug6N9nbWcLahxV84Nt/p8xIyCVl47ozI8IZ46Cc0yLnzhTwOLhLWMJVeiIQrx1rr8g6RK58hqZLkI5t859jJ8H9DjLXLGCne8XOFjfBbesLdoGVkPAgPb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(83380400001)(6916009)(478600001)(8676002)(86362001)(6506007)(2906002)(30864003)(53546011)(5660300002)(54906003)(9686003)(316002)(71200400001)(55016002)(8936002)(52536014)(33656002)(76116006)(186003)(7696005)(66556008)(64756008)(66476007)(66946007)(66446008)(4326008)(26005)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Pr1KfYL4qyR6rKbzJfMT8YwlHt7psd1P9TBojT2cDoM33vg02/MCBjeoDP49Jjt0904evmR7mKByhcxyeJkqcHoQGNX1iDvdMjFEfZidwQB2xJJId8nSkSUYmS7PpU6c0zEt456HmSxaGyUGX9w2C5YSHOu5zEJsSdznvti5Sbmdaixs4555MhJ+8ufnYuZfN6YG2mHY279s4fHGWetgzPDB6jOVM2gNyDErUnwvVXyq1vrz+ZfU9eaLTbikMdGjmUP+sqmlqTxB+mIICoXLizVT29KB5npewwwwEf3b3F7/Fsk+FvZUgJNeB4pXsqgTDr/hCwZ+nv9chEaet5CZSG26TBnqx07M3j7oJYPdJCK2ZonhuUsiS+2dws+jk7v59aQLWN2zfvGvCV3EHIfRYn+Fg7jRbfxp4FlBmkyqWQ7rO7STr5H4iQWjfHkoTQbby5YXAenpM9tQnLtojmbnRcCtqmfJQZTz7hbYjw76b0w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca442041-bfea-4f71-7169-08d821516ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 02:08:07.4440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQoN7hsmc9kkHtSK/T5axIZdF8dS0aUEXIMDxmKw/GU+97f3/Qsnb13hIqkHnAaQiLj/5443VDR31SDJQ5ugjmS1ib0eMTkLJu8naUGD9GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4664
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,=0A=
=0A=
On 7/4/20 7:25 AM, Jens Axboe wrote:=0A=
> Chaitanya, did you even test your patch?=0A=
> =0A=
> + nullb =3D list_first_entry(nullb_list.next, struct nullb, list);=0A=
> =0A=
> I'm guessing no... Dropped it.=0A=
> =0A=
=0A=
I've made a complete blunder out of sending V2 with replacing =0A=
list_first_entry(), there was a manual mistake I found in history=0A=
while testing which never tested V2 even though it was compiled.=0A=
=0A=
However testing of the patch V1 was done and no panic or=0A=
any other issue was observed [1].=0A=
=0A=
Again sorry the trouble, I'm documenting V3 (with test log) at=0A=
the end of the email which is tested [2][2.1][2.2], if and when we=0A=
decide to get in I'll rebase and resend.=0A=
=0A=
Going forward I'll make sure to add a test log for every patch.=0A=
=0A=
Regards,=0A=
Chaitanya=0A=
=0A=
[1] Results with and without V1 :-=0A=
=0A=
1. No kernel panic.=0A=
2. Same tests (block/009, /block/017 and block/018 failed) with and=0A=
    without patch V1.=0A=
3. The new blktest which is yet to submit upstream :-=0A=
    a. Loads the null_blk nr_devices=3D1024 in the background and runs=0A=
       the modprobe -r null_blk in the while loop is successful with=0A=
       and without V1 the cases.=0A=
    b. Creates 100 memory backed null_blk devices with 500M size sleep=0A=
       0.50 in the creation loop, deletes and runs the rmmod null_blk in=0A=
       the foreground. No panic was observed with and without patch V1.=0A=
=0A=
[1.1] Test without V1:-=0A=
=0A=
(for-next) # git log -1  drivers/block/null_blk_main.c=0A=
commit c62b37d96b6eb3ec5ae4cbe00db107bf15aebc93=0A=
Author: Christoph Hellwig <hch@lst.de>=0A=
Date:   Wed Jul 1 10:59:43 2020 +0200=0A=
=0A=
     block: move ->make_request_fn to struct block_device_operations=0A=
=0A=
     The make_request_fn is a little weird in that it sits directly in=0A=
     struct request_queue instead of an operation vector.  Replace it with=
=0A=
     a block_device_operations method called submit_bio (which describes =
=0A=
much=0A=
     better what it does).  Also remove the request_queue argument to it, a=
s=0A=
     the queue can be derived pretty trivially from the bio.=0A=
=0A=
     Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
     Signed-off-by: Jens Axboe <axboe@kernel.dk>=0A=
(for-next) #=0A=
=0A=
blktests: -=0A=
------------=0A=
block/001 (stress device hotplugging)=0A=
block/001 (stress device hotplugging)                        [passed]=0A=
     runtime  30.515s  ...  30.580s=0A=
block/002 (remove a device while running blktrace)=0A=
block/002 (remove a device while running blktrace)           [passed]=0A=
     runtime  1.010s  ...  1.070s=0A=
block/006 (run null-blk in blocking mode)=0A=
     read iops  5972239  ...=0A=
block/006 (run null-blk in blocking mode)                    [passed]=0A=
     read iops  5972239  ...  5912466=0A=
     runtime    19.125s  ...  19.637s=0A=
block/009 (check page-cache coherency after BLKDISCARD)=0A=
block/009 (check page-cache coherency after BLKDISCARD)      [failed]=0A=
     runtime  0.502s  ...  0.503s=0A=
     --- tests/block/009.out	2019-09-13 21:45:10.342000000 -0700=0A=
     +++ /root/blktests/results/nodev/block/009.out.bad	2020-07-05 =0A=
17:16:20.575000000 -0700=0A=
     @@ -1,6 +1,10 @@=0A=
      Running block/009=0A=
      0000000 0000 0000 0000 0000 0000 0000 0000 0000=0A=
      *=0A=
     +1fa4000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa=0A=
     +*=0A=
     +1fa5000 0000 0000 0000 0000 0000 0000 0000 0000=0A=
     +*=0A=
     ...=0A=
     (Run 'diff -u tests/block/009.out =0A=
/root/blktests/results/nodev/block/009.out.bad' to see the entire diff)=0A=
block/010 (run I/O on null_blk with shared and non-shared tags)=0A=
     runtime                34.827s  ...=0A=
block/010 (run I/O on null_blk with shared and non-shared tags) [passed]=0A=
     runtime                    34.827s  ...  34.327s=0A=
     Shared tags read iops      6647074  ...  6677498=0A=
     Individual tags read iops           ...  6774567=0A=
block/014 (run null-blk with blk-mq and timeout injection configured) =0A=
[not run]=0A=
     null_blk module does not have parameter timeout=0A=
block/015 (run null-blk on different schedulers with requeue injection =0A=
configured) [not run]=0A=
     null_blk module does not have parameter requeue=0A=
block/016 (send a signal to a process waiting on a frozen queue)=0A=
block/016 (send a signal to a process waiting on a frozen queue) [passed]=
=0A=
     runtime  0.003s  ...  68.088s=0A=
block/017 (do I/O and check the inflight counter)=0A=
block/017 (do I/O and check the inflight counter)            [failed]=0A=
     runtime  32.694s  ...  32.694s=0A=
     --- tests/block/017.out	2019-09-13 21:45:10.344000000 -0700=0A=
     +++ /root/blktests/results/nodev/block/017.out.bad	2020-07-05 =0A=
17:18:36.021000000 -0700=0A=
     @@ -7,8 +7,8 @@=0A=
      sysfs inflight writes 1=0A=
      sysfs stat 2=0A=
      diskstats 2=0A=
     -sysfs inflight reads 0=0A=
     +sysfs inflight reads 8=0A=
      sysfs inflight writes 0=0A=
     -sysfs stat 0=0A=
     ...=0A=
     (Run 'diff -u tests/block/017.out =0A=
/root/blktests/results/nodev/block/017.out.bad' to see the entire diff)=0A=
block/018 (do I/O and check iostats times)=0A=
block/018 (do I/O and check iostats times)                   [failed]=0A=
     runtime  66.096s  ...  66.099s=0A=
     --- tests/block/018.out	2019-09-13 21:45:10.344000000 -0700=0A=
     +++ /root/blktests/results/nodev/block/018.out.bad	2020-07-05 =0A=
17:19:42.154000000 -0700=0A=
     @@ -5,6 +5,6 @@=0A=
      write 0 s=0A=
      read 1 s=0A=
      write 1 s=0A=
     -read 2 s=0A=
     +read 11 s=0A=
      write 3 s=0A=
      Test complete=0A=
block/020 (run null-blk on different schedulers with only one hardware tag)=
=0A=
block/020 (run null-blk on different schedulers with only one hardware =0A=
tag) [passed]=0A=
     runtime  33.318s  ...  33.295s=0A=
block/021 (read/write nr_requests on null-blk with different schedulers)=0A=
block/021 (read/write nr_requests on null-blk with different schedulers) =
=0A=
[passed]=0A=
     runtime  5.114s  ...  5.245s=0A=
block/022 (Test hang caused by freeze/unfreeze sequence)=0A=
block/022 (Test hang caused by freeze/unfreeze sequence)     [passed]=0A=
     runtime  30.119s  ...  30.140s=0A=
block/023 (do I/O on all null_blk queue modes)=0A=
block/023 (do I/O on all null_blk queue modes)               [passed]=0A=
     runtime  0.308s  ...  0.317s=0A=
block/024 (do I/O faster than a jiffy and check iostats times)=0A=
block/024 (do I/O faster than a jiffy and check iostats times) [passed]=0A=
     runtime  2.604s  ...  2.621s=0A=
block/025 (do a huge discard with 4k sector size)=0A=
block/025 (do a huge discard with 4k sector size)            [passed]=0A=
     runtime  4.066s  ...  4.102s=0A=
block/027 (stress device hotplugging with running fio jobs and different =
=0A=
schedulers) [not run]=0A=
     cgroup2 is not mounted=0A=
block/028 (do I/O on scsi_debug with DIF/DIX enabled)=0A=
block/028 (do I/O on scsi_debug with DIF/DIX enabled)        [passed]=0A=
     runtime  25.682s  ...  25.240s=0A=
block/029 (trigger blk_mq_update_nr_hw_queues())=0A=
block/029 (trigger blk_mq_update_nr_hw_queues())             [passed]=0A=
     runtime  31.639s  ...  31.585s=0A=
block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [not run]=0A=
     null_blk module does not have parameter init_hctx=0A=
=0A=
[1.2] Testing With V1:-=0A=
=0A=
# git log drivers/block/null_blk_main.c=0A=
commit 3ded4bf8c904205ab8d8c223d926b90434048789 (HEAD -> for-next)=0A=
=0A=
Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
Date:   Sun Jul 5 16:31:14 2020 -0700=0A=
=0A=
     null_blk: add helper for deleting the nullb_list=0A=
=0A=
     The nullb_list is destroyed when error occurs in the null_init() and=
=0A=
     when removing the module in null_exit(). The identical code is repeate=
d=0A=
     in those functions which can be a part of helper function. This also=
=0A=
     removes the extra variable struct nullb *nullb in the both functions.=
=0A=
=0A=
     Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
     Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
blktests (master) # ./check tests/block/=0A=
block/001 (stress device hotplugging)=0A=
block/001 (stress device hotplugging)                        [passed]=0A=
     runtime  30.580s  ...  30.565s=0A=
block/002 (remove a device while running blktrace)=0A=
block/002 (remove a device while running blktrace)           [passed]=0A=
     runtime  1.070s  ...  1.011s=0A=
block/006 (run null-blk in blocking mode)=0A=
     read iops  5912466  ...=0A=
block/006 (run null-blk in blocking mode)                    [passed]=0A=
     read iops  5912466  ...  5975217=0A=
     runtime    19.637s  ...  19.131s=0A=
block/009 (check page-cache coherency after BLKDISCARD)=0A=
block/009 (check page-cache coherency after BLKDISCARD)      [failed]=0A=
     runtime  0.504s  ...  0.510s=0A=
     --- tests/block/009.out	2019-09-13 21:45:10.342000000 -0700=0A=
     +++ /root/blktests/results/nodev/block/009.out.bad	2020-07-05 =0A=
17:26:18.164000000 -0700=0A=
     @@ -1,6 +1,10 @@=0A=
      Running block/009=0A=
      0000000 0000 0000 0000 0000 0000 0000 0000 0000=0A=
      *=0A=
     +1fab000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa=0A=
     +*=0A=
     +1fac000 0000 0000 0000 0000 0000 0000 0000 0000=0A=
     +*=0A=
     ...=0A=
     (Run 'diff -u tests/block/009.out =0A=
/root/blktests/results/nodev/block/009.out.bad' to see the entire diff)=0A=
block/010 (run I/O on null_blk with shared and non-shared tags)=0A=
     Individual tags read iops  6774567  ...=0A=
     runtime                    34.327s  ...=0A=
block/010 (run I/O on null_blk with shared and non-shared tags) [passed]=0A=
     Individual tags read iops  6774567  ...  6768417=0A=
     runtime                    34.327s  ...  34.392s=0A=
     Shared tags read iops      6677498  ...  6585757=0A=
block/014 (run null-blk with blk-mq and timeout injection configured) =0A=
[not run]=0A=
     null_blk module does not have parameter timeout=0A=
block/015 (run null-blk on different schedulers with requeue injection =0A=
configured) [not run]=0A=
     null_blk module does not have parameter requeue=0A=
block/016 (send a signal to a process waiting on a frozen queue)=0A=
block/016 (send a signal to a process waiting on a frozen queue) [passed]=
=0A=
     runtime  68.088s  ...  68.103s=0A=
block/017 (do I/O and check the inflight counter)=0A=
block/017 (do I/O and check the inflight counter)            [failed]=0A=
     runtime  32.694s  ...  32.698s=0A=
     --- tests/block/017.out	2019-09-13 21:45:10.344000000 -0700=0A=
     +++ /root/blktests/results/nodev/block/017.out.bad	2020-07-05 =0A=
17:28:33.672000000 -0700=0A=
     @@ -7,8 +7,8 @@=0A=
      sysfs inflight writes 1=0A=
      sysfs stat 2=0A=
      diskstats 2=0A=
     -sysfs inflight reads 0=0A=
     +sysfs inflight reads 3=0A=
      sysfs inflight writes 0=0A=
     -sysfs stat 0=0A=
     ...=0A=
     (Run 'diff -u tests/block/017.out =0A=
/root/blktests/results/nodev/block/017.out.bad' to see the entire diff)=0A=
block/018 (do I/O and check iostats times)=0A=
block/018 (do I/O and check iostats times)                   [failed]=0A=
     runtime  66.099s  ...  66.102s=0A=
     --- tests/block/018.out	2019-09-13 21:45:10.344000000 -0700=0A=
     +++ /root/blktests/results/nodev/block/018.out.bad	2020-07-05 =0A=
17:29:39.807000000 -0700=0A=
     @@ -5,6 +5,6 @@=0A=
      write 0 s=0A=
      read 1 s=0A=
      write 1 s=0A=
     -read 2 s=0A=
     +read 18 s=0A=
      write 3 s=0A=
      Test complete=0A=
block/020 (run null-blk on different schedulers with only one hardware tag)=
=0A=
block/020 (run null-blk on different schedulers with only one hardware =0A=
tag) [passed]=0A=
     runtime  33.295s  ...  33.910s=0A=
block/021 (read/write nr_requests on null-blk with different schedulers)=0A=
block/021 (read/write nr_requests on null-blk with different schedulers) =
=0A=
[passed]=0A=
     runtime  5.245s  ...  5.216s=0A=
block/022 (Test hang caused by freeze/unfreeze sequence)=0A=
block/022 (Test hang caused by freeze/unfreeze sequence)     [passed]=0A=
     runtime  30.140s  ...  30.099s=0A=
block/023 (do I/O on all null_blk queue modes)=0A=
block/023 (do I/O on all null_blk queue modes)               [passed]=0A=
     runtime  0.317s  ...  0.313s=0A=
block/024 (do I/O faster than a jiffy and check iostats times)=0A=
block/024 (do I/O faster than a jiffy and check iostats times) [passed]=0A=
     runtime  2.621s  ...  2.633s=0A=
block/025 (do a huge discard with 4k sector size)=0A=
block/025 (do a huge discard with 4k sector size)            [passed]=0A=
     runtime  4.102s  ...  4.405s=0A=
block/027 (stress device hotplugging with running fio jobs and different =
=0A=
schedulers) [not run]=0A=
     cgroup2 is not mounted=0A=
block/028 (do I/O on scsi_debug with DIF/DIX enabled)=0A=
block/028 (do I/O on scsi_debug with DIF/DIX enabled)        [passed]=0A=
     runtime  25.240s  ...  25.293s=0A=
block/029 (trigger blk_mq_update_nr_hw_queues())=0A=
block/029 (trigger blk_mq_update_nr_hw_queues())             [passed]=0A=
     runtime  31.585s  ...  31.574s=0A=
block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [not run]=0A=
     null_blk module does not have parameter init_hctx=0A=
=0A=
=0A=
[2] V3 :-=0A=
=0A=
[2.1] Patch :-=0A=
=0A=
 From 06ec96c98367e516bc47f317629385967f128039 Mon Sep 17 00:00:00 2001=0A=
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
Date: Sun, 5 Jul 2020 16:31:14 -0700=0A=
Subject: [PATCH V3] null_blk: add helper for deleting the nullb_list=0A=
=0A=
The nullb_list is destroyed when error occurs in the null_init() and=0A=
when removing the module in null_exit(). The identical code is repeated=0A=
in those functions which can be a part of helper function. This also=0A=
removes the extra variable struct nullb *nullb in the both functions.=0A=
=0A=
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
---=0A=
=0A=
* Changes from V1: -=0A=
--------------------=0A=
=0A=
1. Add missing sign-off and reviewed-by tag.=0A=
2. Use list_entry_first() instead of list_entry().=0A=
=0A=
* Changes from V2 : -=0A=
---------------------=0A=
=0A=
1. Fix the wrong first parameter for list_first_entry();.=0A=
2. Update Reviewed-by tag.=0A=
=0A=
---=0A=
  drivers/block/null_blk_main.c | 32 +++++++++++++++-----------------=0A=
  1 file changed, 15 insertions(+), 17 deletions(-)=0A=
=0A=
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c=
=0A=
index 907c6858aec0..f1216e7218e4 100644=0A=
--- a/drivers/block/null_blk_main.c=0A=
+++ b/drivers/block/null_blk_main.c=0A=
@@ -1868,11 +1868,23 @@ static int null_add_dev(struct nullb_device *dev)=
=0A=
  	return rv;=0A=
  }=0A=
=0A=
+static void null_delete_nullb_list(void)=0A=
+{=0A=
+	struct nullb_device *dev;=0A=
+	struct nullb *nullb;=0A=
+=0A=
+	while (!list_empty(&nullb_list)) {=0A=
+		nullb =3D list_first_entry(&nullb_list, struct nullb, list);=0A=
+		dev =3D nullb->dev;=0A=
+		null_del_dev(nullb);=0A=
+		null_free_dev(dev);=0A=
+	}=0A=
+}=0A=
+=0A=
  static int __init null_init(void)=0A=
  {=0A=
  	int ret =3D 0;=0A=
  	unsigned int i;=0A=
-	struct nullb *nullb;=0A=
  	struct nullb_device *dev;=0A=
=0A=
  	if (g_bs > PAGE_SIZE) {=0A=
@@ -1939,12 +1951,7 @@ static int __init null_init(void)=0A=
  	return 0;=0A=
=0A=
  err_dev:=0A=
-	while (!list_empty(&nullb_list)) {=0A=
-		nullb =3D list_entry(nullb_list.next, struct nullb, list);=0A=
-		dev =3D nullb->dev;=0A=
-		null_del_dev(nullb);=0A=
-		null_free_dev(dev);=0A=
-	}=0A=
+	null_delete_nullb_list();=0A=
  	unregister_blkdev(null_major, "nullb");=0A=
  err_conf:=0A=
  	configfs_unregister_subsystem(&nullb_subsys);=0A=
@@ -1956,21 +1963,12 @@ static int __init null_init(void)=0A=
=0A=
  static void __exit null_exit(void)=0A=
  {=0A=
-	struct nullb *nullb;=0A=
-=0A=
  	configfs_unregister_subsystem(&nullb_subsys);=0A=
=0A=
  	unregister_blkdev(null_major, "nullb");=0A=
=0A=
  	mutex_lock(&lock);=0A=
-	while (!list_empty(&nullb_list)) {=0A=
-		struct nullb_device *dev;=0A=
-=0A=
-		nullb =3D list_entry(nullb_list.next, struct nullb, list);=0A=
-		dev =3D nullb->dev;=0A=
-		null_del_dev(nullb);=0A=
-		null_free_dev(dev);=0A=
-	}=0A=
+	null_delete_nullb_list();=0A=
  	mutex_unlock(&lock);=0A=
=0A=
  	if (g_queue_mode =3D=3D NULL_Q_MQ && shared_tags)=0A=
-- =0A=
2.26.0=0A=
=0A=
=0A=
[2.2] blktest test report V3:-=0A=
=0A=
  # ./check tests/block/=0A=
block/001 (stress device hotplugging)=0A=
block/001 (stress device hotplugging)                        [passed]=0A=
     runtime  30.549s  ...  30.520s=0A=
block/002 (remove a device while running blktrace)=0A=
block/002 (remove a device while running blktrace)           [passed]=0A=
     runtime  1.035s  ...  1.108s=0A=
block/006 (run null-blk in blocking mode)=0A=
     read iops  5999576  ...=0A=
block/006 (run null-blk in blocking mode)                    [passed]=0A=
     read iops  5999576  ...  5987158=0A=
     runtime    19.319s  ...  19.398s=0A=
block/009 (check page-cache coherency after BLKDISCARD)=0A=
block/009 (check page-cache coherency after BLKDISCARD)      [failed]=0A=
     runtime  0.505s  ...  0.515s=0A=
     --- tests/block/009.out	2019-09-13 21:45:10.342000000 -0700=0A=
     +++ /root/blktests/results/nodev/block/009.out.bad	2020-07-05 =0A=
18:21:34.958000000 -0700=0A=
     @@ -1,6 +1,10 @@=0A=
      Running block/009=0A=
      0000000 0000 0000 0000 0000 0000 0000 0000 0000=0A=
      *=0A=
     +1fab000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa=0A=
     +*=0A=
     +1fac000 0000 0000 0000 0000 0000 0000 0000 0000=0A=
     +*=0A=
     ...=0A=
     (Run 'diff -u tests/block/009.out =0A=
/root/blktests/results/nodev/block/009.out.bad' to see the entire diff)=0A=
block/010 (run I/O on null_blk with shared and non-shared tags)=0A=
     Individual tags read iops  6706192  ...=0A=
     runtime                    34.675s  ...=0A=
block/010 (run I/O on null_blk with shared and non-shared tags) [passed]=0A=
     Individual tags read iops  6706192  ...  6649050=0A=
     runtime                    34.675s  ...  34.645s=0A=
     Shared tags read iops      6390103  ...  6613013=0A=
block/014 (run null-blk with blk-mq and timeout injection configured) =0A=
[not run]=0A=
     null_blk module does not have parameter timeout=0A=
block/015 (run null-blk on different schedulers with requeue injection =0A=
configured) [not run]=0A=
     null_blk module does not have parameter requeue=0A=
block/016 (send a signal to a process waiting on a frozen queue)=0A=
block/016 (send a signal to a process waiting on a frozen queue) [passed]=
=0A=
     runtime  68.093s  ...  68.094s=0A=
block/017 (do I/O and check the inflight counter)=0A=
block/017 (do I/O and check the inflight counter)            [failed]=0A=
     runtime  32.695s  ...  32.696s=0A=
     --- tests/block/017.out	2019-09-13 21:45:10.344000000 -0700=0A=
     +++ /root/blktests/results/nodev/block/017.out.bad	2020-07-05 =0A=
18:23:50.686000000 -0700=0A=
     @@ -7,8 +7,8 @@=0A=
      sysfs inflight writes 1=0A=
      sysfs stat 2=0A=
      diskstats 2=0A=
     -sysfs inflight reads 0=0A=
     +sysfs inflight reads 8=0A=
      sysfs inflight writes 0=0A=
     -sysfs stat 0=0A=
     ...=0A=
     (Run 'diff -u tests/block/017.out =0A=
/root/blktests/results/nodev/block/017.out.bad' to see the entire diff)=0A=
block/018 (do I/O and check iostats times)=0A=
block/018 (do I/O and check iostats times)                   [failed]=0A=
     runtime  66.090s  ...  66.097s=0A=
     --- tests/block/018.out	2019-09-13 21:45:10.344000000 -0700=0A=
     +++ /root/blktests/results/nodev/block/018.out.bad	2020-07-05 =0A=
18:24:56.816000000 -0700=0A=
     @@ -5,6 +5,6 @@=0A=
      write 0 s=0A=
      read 1 s=0A=
      write 1 s=0A=
     -read 2 s=0A=
     +read 18 s=0A=
      write 3 s=0A=
      Test complete=0A=
block/020 (run null-blk on different schedulers with only one hardware tag)=
=0A=
block/020 (run null-blk on different schedulers with only one hardware =0A=
tag) [passed]=0A=
     runtime  33.370s  ...  33.657s=0A=
block/021 (read/write nr_requests on null-blk with different schedulers)=0A=
block/021 (read/write nr_requests on null-blk with different schedulers) =
=0A=
[passed]=0A=
     runtime  5.162s  ...  5.271s=0A=
block/022 (Test hang caused by freeze/unfreeze sequence)=0A=
block/022 (Test hang caused by freeze/unfreeze sequence)     [passed]=0A=
     runtime  30.117s  ...  30.089s=0A=
block/023 (do I/O on all null_blk queue modes)=0A=
block/023 (do I/O on all null_blk queue modes)               [passed]=0A=
     runtime  0.318s  ...  0.310s=0A=
block/024 (do I/O faster than a jiffy and check iostats times)=0A=
block/024 (do I/O faster than a jiffy and check iostats times) [passed]=0A=
     runtime  2.629s  ...  2.626s=0A=
block/025 (do a huge discard with 4k sector size)=0A=
block/025 (do a huge discard with 4k sector size)            [passed]=0A=
     runtime  4.208s  ...  4.124s=0A=
block/027 (stress device hotplugging with running fio jobs and different =
=0A=
schedulers) [not run]=0A=
     cgroup2 is not mounted=0A=
block/028 (do I/O on scsi_debug with DIF/DIX enabled)=0A=
block/028 (do I/O on scsi_debug with DIF/DIX enabled)        [passed]=0A=
     runtime  25.274s  ...  25.423s=0A=
block/029 (trigger blk_mq_update_nr_hw_queues())=0A=
block/029 (trigger blk_mq_update_nr_hw_queues())             [passed]=0A=
     runtime  31.585s  ...  31.547s=0A=
block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [not run]=0A=
     null_blk module does not have parameter init_hctx=0A=
=0A=
[2.2] modprobe test with on-membacked test :-=0A=
=0A=
Terminal 1:-=0A=
(for-next) # modprobe null_blk nr_devices=3D1024=0A=
(for-next) # modprobe  -r null_blk=0A=
=0A=
Terminal 2:-=0A=
=0A=
blktests (master) # while [ 1 ] ; do modprobe -r null_blk; =0A=
                                                 if [ $? -eq 0 ]; then =0A=
break; fi; sleep 1; done=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
=0A=
=0A=
[2.3] Mixed mondprobe test Membacked and non-membacked :-=0A=
=0A=
# ./tests.sh=0A=
+ NN=3D100=0A=
+ modprobe -r null_blk=0A=
+ modprobe null_blk nr_devices=3D10 gb=3D1=0A=
+ echo loading devices=0A=
loading devices=0A=
+ declare -a arr=0A=
++ seq 0 100=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb0=0A=
+ mkdir config/nullb/nullb0=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb0/index=0A=
+ IDX=3D10=0A=
+ echo -n ' 0 '=0A=
  0 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb1=0A=
+ mkdir config/nullb/nullb1=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb1/index=0A=
+ IDX=3D11=0A=
+ echo -n ' 1 '=0A=
  1 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb2=0A=
+ mkdir config/nullb/nullb2=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb2/index=0A=
+ IDX=3D12=0A=
+ echo -n ' 2 '=0A=
  2 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb3=0A=
+ mkdir config/nullb/nullb3=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb3/index=0A=
+ IDX=3D13=0A=
+ echo -n ' 3 '=0A=
  3 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb4=0A=
+ mkdir config/nullb/nullb4=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb4/index=0A=
+ IDX=3D14=0A=
+ echo -n ' 4 '=0A=
  4 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb5=0A=
+ mkdir config/nullb/nullb5=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb5/index=0A=
+ IDX=3D15=0A=
+ echo -n ' 5 '=0A=
  5 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb6=0A=
+ mkdir config/nullb/nullb6=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb6/index=0A=
+ IDX=3D16=0A=
+ echo -n ' 6 '=0A=
  6 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb7=0A=
+ mkdir config/nullb/nullb7=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb7/index=0A=
+ IDX=3D17=0A=
+ echo -n ' 7 '=0A=
  7 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb8=0A=
+ mkdir config/nullb/nullb8=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb8/index=0A=
+ IDX=3D18=0A=
+ echo -n ' 8 '=0A=
  8 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb9=0A=
+ mkdir config/nullb/nullb9=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb9/index=0A=
+ IDX=3D19=0A=
+ echo -n ' 9 '=0A=
  9 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb10=0A=
+ mkdir config/nullb/nullb10=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb10/index=0A=
+ IDX=3D20=0A=
+ echo -n ' 10 '=0A=
  10 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb11=0A=
+ mkdir config/nullb/nullb11=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb11/index=0A=
+ IDX=3D21=0A=
+ echo -n ' 11 '=0A=
  11 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb12=0A=
+ mkdir config/nullb/nullb12=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb12/index=0A=
+ IDX=3D22=0A=
+ echo -n ' 12 '=0A=
  12 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb13=0A=
+ mkdir config/nullb/nullb13=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb13/index=0A=
+ IDX=3D23=0A=
+ echo -n ' 13 '=0A=
  13 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb14=0A=
+ mkdir config/nullb/nullb14=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb14/index=0A=
+ IDX=3D24=0A=
+ echo -n ' 14 '=0A=
  14 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb15=0A=
+ mkdir config/nullb/nullb15=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb15/index=0A=
+ IDX=3D25=0A=
+ echo -n ' 15 '=0A=
  15 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb16=0A=
+ mkdir config/nullb/nullb16=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb16/index=0A=
+ IDX=3D26=0A=
+ echo -n ' 16 '=0A=
  16 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb17=0A=
+ mkdir config/nullb/nullb17=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb17/index=0A=
+ IDX=3D27=0A=
+ echo -n ' 17 '=0A=
  17 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb18=0A=
+ mkdir config/nullb/nullb18=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb18/index=0A=
+ IDX=3D28=0A=
+ echo -n ' 18 '=0A=
  18 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb19=0A=
+ mkdir config/nullb/nullb19=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb19/index=0A=
+ IDX=3D29=0A=
+ echo -n ' 19 '=0A=
  19 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb20=0A=
+ mkdir config/nullb/nullb20=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb20/index=0A=
+ IDX=3D30=0A=
+ echo -n ' 20 '=0A=
  20 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb21=0A=
+ mkdir config/nullb/nullb21=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb21/index=0A=
+ IDX=3D31=0A=
+ echo -n ' 21 '=0A=
  21 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb22=0A=
+ mkdir config/nullb/nullb22=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb22/index=0A=
+ IDX=3D32=0A=
+ echo -n ' 22 '=0A=
  22 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb23=0A=
+ mkdir config/nullb/nullb23=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb23/index=0A=
+ IDX=3D33=0A=
+ echo -n ' 23 '=0A=
  23 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb24=0A=
+ mkdir config/nullb/nullb24=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb24/index=0A=
+ IDX=3D34=0A=
+ echo -n ' 24 '=0A=
  24 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb25=0A=
+ mkdir config/nullb/nullb25=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb25/index=0A=
+ IDX=3D35=0A=
+ echo -n ' 25 '=0A=
  25 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb26=0A=
+ mkdir config/nullb/nullb26=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb26/index=0A=
+ IDX=3D36=0A=
+ echo -n ' 26 '=0A=
  26 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb27=0A=
+ mkdir config/nullb/nullb27=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb27/index=0A=
+ IDX=3D37=0A=
+ echo -n ' 27 '=0A=
  27 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb28=0A=
+ mkdir config/nullb/nullb28=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb28/index=0A=
+ IDX=3D38=0A=
+ echo -n ' 28 '=0A=
  28 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb29=0A=
+ mkdir config/nullb/nullb29=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb29/index=0A=
+ IDX=3D39=0A=
+ echo -n ' 29 '=0A=
  29 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb30=0A=
+ mkdir config/nullb/nullb30=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb30/index=0A=
+ IDX=3D40=0A=
+ echo -n ' 30 '=0A=
  30 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb31=0A=
+ mkdir config/nullb/nullb31=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb31/index=0A=
+ IDX=3D41=0A=
+ echo -n ' 31 '=0A=
  31 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb32=0A=
+ mkdir config/nullb/nullb32=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb32/index=0A=
+ IDX=3D42=0A=
+ echo -n ' 32 '=0A=
  32 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb33=0A=
+ mkdir config/nullb/nullb33=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb33/index=0A=
+ IDX=3D43=0A=
+ echo -n ' 33 '=0A=
  33 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb34=0A=
+ mkdir config/nullb/nullb34=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb34/index=0A=
+ IDX=3D44=0A=
+ echo -n ' 34 '=0A=
  34 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb35=0A=
+ mkdir config/nullb/nullb35=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb35/index=0A=
+ IDX=3D45=0A=
+ echo -n ' 35 '=0A=
  35 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb36=0A=
+ mkdir config/nullb/nullb36=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb36/index=0A=
+ IDX=3D46=0A=
+ echo -n ' 36 '=0A=
  36 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb37=0A=
+ mkdir config/nullb/nullb37=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb37/index=0A=
+ IDX=3D47=0A=
+ echo -n ' 37 '=0A=
  37 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb38=0A=
+ mkdir config/nullb/nullb38=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb38/index=0A=
+ IDX=3D48=0A=
+ echo -n ' 38 '=0A=
  38 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb39=0A=
+ mkdir config/nullb/nullb39=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb39/index=0A=
+ IDX=3D49=0A=
+ echo -n ' 39 '=0A=
  39 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb40=0A=
+ mkdir config/nullb/nullb40=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb40/index=0A=
+ IDX=3D50=0A=
+ echo -n ' 40 '=0A=
  40 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb41=0A=
+ mkdir config/nullb/nullb41=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb41/index=0A=
+ IDX=3D51=0A=
+ echo -n ' 41 '=0A=
  41 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb42=0A=
+ mkdir config/nullb/nullb42=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb42/index=0A=
+ IDX=3D52=0A=
+ echo -n ' 42 '=0A=
  42 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb43=0A=
+ mkdir config/nullb/nullb43=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb43/index=0A=
+ IDX=3D53=0A=
+ echo -n ' 43 '=0A=
  43 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb44=0A=
+ mkdir config/nullb/nullb44=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb44/index=0A=
+ IDX=3D54=0A=
+ echo -n ' 44 '=0A=
  44 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb45=0A=
+ mkdir config/nullb/nullb45=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb45/index=0A=
+ IDX=3D55=0A=
+ echo -n ' 45 '=0A=
  45 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb46=0A=
+ mkdir config/nullb/nullb46=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb46/index=0A=
+ IDX=3D56=0A=
+ echo -n ' 46 '=0A=
  46 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb47=0A=
+ mkdir config/nullb/nullb47=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb47/index=0A=
+ IDX=3D57=0A=
+ echo -n ' 47 '=0A=
  47 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb48=0A=
+ mkdir config/nullb/nullb48=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb48/index=0A=
+ IDX=3D58=0A=
+ echo -n ' 48 '=0A=
  48 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb49=0A=
+ mkdir config/nullb/nullb49=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb49/index=0A=
+ IDX=3D59=0A=
+ echo -n ' 49 '=0A=
  49 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb50=0A=
+ mkdir config/nullb/nullb50=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb50/index=0A=
+ IDX=3D60=0A=
+ echo -n ' 50 '=0A=
  50 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb51=0A=
+ mkdir config/nullb/nullb51=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb51/index=0A=
+ IDX=3D61=0A=
+ echo -n ' 51 '=0A=
  51 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb52=0A=
+ mkdir config/nullb/nullb52=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb52/index=0A=
+ IDX=3D62=0A=
+ echo -n ' 52 '=0A=
  52 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb53=0A=
+ mkdir config/nullb/nullb53=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb53/index=0A=
+ IDX=3D63=0A=
+ echo -n ' 53 '=0A=
  53 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb54=0A=
+ mkdir config/nullb/nullb54=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb54/index=0A=
+ IDX=3D64=0A=
+ echo -n ' 54 '=0A=
  54 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb55=0A=
+ mkdir config/nullb/nullb55=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb55/index=0A=
+ IDX=3D65=0A=
+ echo -n ' 55 '=0A=
  55 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb56=0A=
+ mkdir config/nullb/nullb56=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb56/index=0A=
+ IDX=3D66=0A=
+ echo -n ' 56 '=0A=
  56 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb57=0A=
+ mkdir config/nullb/nullb57=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb57/index=0A=
+ IDX=3D67=0A=
+ echo -n ' 57 '=0A=
  57 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb58=0A=
+ mkdir config/nullb/nullb58=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb58/index=0A=
+ IDX=3D68=0A=
+ echo -n ' 58 '=0A=
  58 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb59=0A=
+ mkdir config/nullb/nullb59=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb59/index=0A=
+ IDX=3D69=0A=
+ echo -n ' 59 '=0A=
  59 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb60=0A=
+ mkdir config/nullb/nullb60=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb60/index=0A=
+ IDX=3D70=0A=
+ echo -n ' 60 '=0A=
  60 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb61=0A=
+ mkdir config/nullb/nullb61=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb61/index=0A=
+ IDX=3D71=0A=
+ echo -n ' 61 '=0A=
  61 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb62=0A=
+ mkdir config/nullb/nullb62=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb62/index=0A=
+ IDX=3D72=0A=
+ echo -n ' 62 '=0A=
  62 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb63=0A=
+ mkdir config/nullb/nullb63=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb63/index=0A=
+ IDX=3D73=0A=
+ echo -n ' 63 '=0A=
  63 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb64=0A=
+ mkdir config/nullb/nullb64=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb64/index=0A=
+ IDX=3D74=0A=
+ echo -n ' 64 '=0A=
  64 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb65=0A=
+ mkdir config/nullb/nullb65=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb65/index=0A=
+ IDX=3D75=0A=
+ echo -n ' 65 '=0A=
  65 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb66=0A=
+ mkdir config/nullb/nullb66=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb66/index=0A=
+ IDX=3D76=0A=
+ echo -n ' 66 '=0A=
  66 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb67=0A=
+ mkdir config/nullb/nullb67=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb67/index=0A=
+ IDX=3D77=0A=
+ echo -n ' 67 '=0A=
  67 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb68=0A=
+ mkdir config/nullb/nullb68=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb68/index=0A=
+ IDX=3D78=0A=
+ echo -n ' 68 '=0A=
  68 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb69=0A=
+ mkdir config/nullb/nullb69=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb69/index=0A=
+ IDX=3D79=0A=
+ echo -n ' 69 '=0A=
  69 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb70=0A=
+ mkdir config/nullb/nullb70=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb70/index=0A=
+ IDX=3D80=0A=
+ echo -n ' 70 '=0A=
  70 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb71=0A=
+ mkdir config/nullb/nullb71=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb71/index=0A=
+ IDX=3D81=0A=
+ echo -n ' 71 '=0A=
  71 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb72=0A=
+ mkdir config/nullb/nullb72=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb72/index=0A=
+ IDX=3D82=0A=
+ echo -n ' 72 '=0A=
  72 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb73=0A=
+ mkdir config/nullb/nullb73=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb73/index=0A=
+ IDX=3D83=0A=
+ echo -n ' 73 '=0A=
  73 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb74=0A=
+ mkdir config/nullb/nullb74=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb74/index=0A=
+ IDX=3D84=0A=
+ echo -n ' 74 '=0A=
  74 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb75=0A=
+ mkdir config/nullb/nullb75=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb75/index=0A=
+ IDX=3D85=0A=
+ echo -n ' 75 '=0A=
  75 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb76=0A=
+ mkdir config/nullb/nullb76=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb76/index=0A=
+ IDX=3D86=0A=
+ echo -n ' 76 '=0A=
  76 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb77=0A=
+ mkdir config/nullb/nullb77=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb77/index=0A=
+ IDX=3D87=0A=
+ echo -n ' 77 '=0A=
  77 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb78=0A=
+ mkdir config/nullb/nullb78=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb78/index=0A=
+ IDX=3D88=0A=
+ echo -n ' 78 '=0A=
  78 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb79=0A=
+ mkdir config/nullb/nullb79=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb79/index=0A=
+ IDX=3D89=0A=
+ echo -n ' 79 '=0A=
  79 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb80=0A=
+ mkdir config/nullb/nullb80=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb80/index=0A=
+ IDX=3D90=0A=
+ echo -n ' 80 '=0A=
  80 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb81=0A=
+ mkdir config/nullb/nullb81=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb81/index=0A=
+ IDX=3D91=0A=
+ echo -n ' 81 '=0A=
  81 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb82=0A=
+ mkdir config/nullb/nullb82=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb82/index=0A=
+ IDX=3D92=0A=
+ echo -n ' 82 '=0A=
  82 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb83=0A=
+ mkdir config/nullb/nullb83=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb83/index=0A=
+ IDX=3D93=0A=
+ echo -n ' 83 '=0A=
  83 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb84=0A=
+ mkdir config/nullb/nullb84=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb84/index=0A=
+ IDX=3D94=0A=
+ echo -n ' 84 '=0A=
  84 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb85=0A=
+ mkdir config/nullb/nullb85=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb85/index=0A=
+ IDX=3D95=0A=
+ echo -n ' 85 '=0A=
  85 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb86=0A=
+ mkdir config/nullb/nullb86=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb86/index=0A=
+ IDX=3D96=0A=
+ echo -n ' 86 '=0A=
  86 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb87=0A=
+ mkdir config/nullb/nullb87=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb87/index=0A=
+ IDX=3D97=0A=
+ echo -n ' 87 '=0A=
  87 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb88=0A=
+ mkdir config/nullb/nullb88=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb88/index=0A=
+ IDX=3D98=0A=
+ echo -n ' 88 '=0A=
  88 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb89=0A=
+ mkdir config/nullb/nullb89=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb89/index=0A=
+ IDX=3D99=0A=
+ echo -n ' 89 '=0A=
  89 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb90=0A=
+ mkdir config/nullb/nullb90=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb90/index=0A=
+ IDX=3D100=0A=
+ echo -n ' 90 '=0A=
  90 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb91=0A=
+ mkdir config/nullb/nullb91=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb91/index=0A=
+ IDX=3D101=0A=
+ echo -n ' 91 '=0A=
  91 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb92=0A=
+ mkdir config/nullb/nullb92=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb92/index=0A=
+ IDX=3D102=0A=
+ echo -n ' 92 '=0A=
  92 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb93=0A=
+ mkdir config/nullb/nullb93=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb93/index=0A=
+ IDX=3D103=0A=
+ echo -n ' 93 '=0A=
  93 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb94=0A=
+ mkdir config/nullb/nullb94=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb94/index=0A=
+ IDX=3D104=0A=
+ echo -n ' 94 '=0A=
  94 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb95=0A=
+ mkdir config/nullb/nullb95=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb95/index=0A=
+ IDX=3D105=0A=
+ echo -n ' 95 '=0A=
  95 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb96=0A=
+ mkdir config/nullb/nullb96=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb96/index=0A=
+ IDX=3D106=0A=
+ echo -n ' 96 '=0A=
  96 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb97=0A=
+ mkdir config/nullb/nullb97=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb97/index=0A=
+ IDX=3D107=0A=
+ echo -n ' 97 '=0A=
  97 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb98=0A=
+ mkdir config/nullb/nullb98=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb98/index=0A=
+ IDX=3D108=0A=
+ echo -n ' 98 '=0A=
  98 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb99=0A=
+ mkdir config/nullb/nullb99=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb99/index=0A=
+ IDX=3D109=0A=
+ echo -n ' 99 '=0A=
  99 + sleep .50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ NULLB_DIR=3Dconfig/nullb/nullb100=0A=
+ mkdir config/nullb/nullb100=0A=
+ echo 1=0A=
+ echo 512=0A=
+ echo 500=0A=
+ echo 1=0A=
++ cat config/nullb/nullb100/index=0A=
+ IDX=3D110=0A=
+ echo -n ' 100 '=0A=
  100 + sleep .50=0A=
+ lsblk=0A=
+ grep null=0A=
+ sort=0A=
nullb0            252:0    0    1G  0 disk=0A=
nullb100          252:100  0  500M  0 disk=0A=
nullb101          252:101  0  500M  0 disk=0A=
nullb102          252:102  0  500M  0 disk=0A=
nullb10           252:10   0  500M  0 disk=0A=
nullb103          252:103  0  500M  0 disk=0A=
nullb104          252:104  0  500M  0 disk=0A=
nullb105          252:105  0  500M  0 disk=0A=
nullb106          252:106  0  500M  0 disk=0A=
nullb107          252:107  0  500M  0 disk=0A=
nullb108          252:108  0  500M  0 disk=0A=
nullb109          252:109  0  500M  0 disk=0A=
nullb110          252:110  0  500M  0 disk=0A=
nullb11           252:11   0  500M  0 disk=0A=
nullb12           252:12   0  500M  0 disk=0A=
nullb1            252:1    0    1G  0 disk=0A=
nullb13           252:13   0  500M  0 disk=0A=
nullb14           252:14   0  500M  0 disk=0A=
nullb15           252:15   0  500M  0 disk=0A=
nullb16           252:16   0  500M  0 disk=0A=
nullb17           252:17   0  500M  0 disk=0A=
nullb18           252:18   0  500M  0 disk=0A=
nullb19           252:19   0  500M  0 disk=0A=
nullb20           252:20   0  500M  0 disk=0A=
nullb21           252:21   0  500M  0 disk=0A=
nullb22           252:22   0  500M  0 disk=0A=
nullb2            252:2    0    1G  0 disk=0A=
nullb23           252:23   0  500M  0 disk=0A=
nullb24           252:24   0  500M  0 disk=0A=
nullb25           252:25   0  500M  0 disk=0A=
nullb26           252:26   0  500M  0 disk=0A=
nullb27           252:27   0  500M  0 disk=0A=
nullb28           252:28   0  500M  0 disk=0A=
nullb29           252:29   0  500M  0 disk=0A=
nullb30           252:30   0  500M  0 disk=0A=
nullb31           252:31   0  500M  0 disk=0A=
nullb32           252:32   0  500M  0 disk=0A=
nullb3            252:3    0    1G  0 disk=0A=
nullb33           252:33   0  500M  0 disk=0A=
nullb34           252:34   0  500M  0 disk=0A=
nullb35           252:35   0  500M  0 disk=0A=
nullb36           252:36   0  500M  0 disk=0A=
nullb37           252:37   0  500M  0 disk=0A=
nullb38           252:38   0  500M  0 disk=0A=
nullb39           252:39   0  500M  0 disk=0A=
nullb40           252:40   0  500M  0 disk=0A=
nullb41           252:41   0  500M  0 disk=0A=
nullb42           252:42   0  500M  0 disk=0A=
nullb4            252:4    0    1G  0 disk=0A=
nullb43           252:43   0  500M  0 disk=0A=
nullb44           252:44   0  500M  0 disk=0A=
nullb45           252:45   0  500M  0 disk=0A=
nullb46           252:46   0  500M  0 disk=0A=
nullb47           252:47   0  500M  0 disk=0A=
nullb48           252:48   0  500M  0 disk=0A=
nullb49           252:49   0  500M  0 disk=0A=
nullb50           252:50   0  500M  0 disk=0A=
nullb51           252:51   0  500M  0 disk=0A=
nullb52           252:52   0  500M  0 disk=0A=
nullb5            252:5    0    1G  0 disk=0A=
nullb53           252:53   0  500M  0 disk=0A=
nullb54           252:54   0  500M  0 disk=0A=
nullb55           252:55   0  500M  0 disk=0A=
nullb56           252:56   0  500M  0 disk=0A=
nullb57           252:57   0  500M  0 disk=0A=
nullb58           252:58   0  500M  0 disk=0A=
nullb59           252:59   0  500M  0 disk=0A=
nullb60           252:60   0  500M  0 disk=0A=
nullb61           252:61   0  500M  0 disk=0A=
nullb62           252:62   0  500M  0 disk=0A=
nullb6            252:6    0    1G  0 disk=0A=
nullb63           252:63   0  500M  0 disk=0A=
nullb64           252:64   0  500M  0 disk=0A=
nullb65           252:65   0  500M  0 disk=0A=
nullb66           252:66   0  500M  0 disk=0A=
nullb67           252:67   0  500M  0 disk=0A=
nullb68           252:68   0  500M  0 disk=0A=
nullb69           252:69   0  500M  0 disk=0A=
nullb70           252:70   0  500M  0 disk=0A=
nullb71           252:71   0  500M  0 disk=0A=
nullb72           252:72   0  500M  0 disk=0A=
nullb7            252:7    0    1G  0 disk=0A=
nullb73           252:73   0  500M  0 disk=0A=
nullb74           252:74   0  500M  0 disk=0A=
nullb75           252:75   0  500M  0 disk=0A=
nullb76           252:76   0  500M  0 disk=0A=
nullb77           252:77   0  500M  0 disk=0A=
nullb78           252:78   0  500M  0 disk=0A=
nullb79           252:79   0  500M  0 disk=0A=
nullb80           252:80   0  500M  0 disk=0A=
nullb81           252:81   0  500M  0 disk=0A=
nullb82           252:82   0  500M  0 disk=0A=
nullb8            252:8    0    1G  0 disk=0A=
nullb83           252:83   0  500M  0 disk=0A=
nullb84           252:84   0  500M  0 disk=0A=
nullb85           252:85   0  500M  0 disk=0A=
nullb86           252:86   0  500M  0 disk=0A=
nullb87           252:87   0  500M  0 disk=0A=
nullb88           252:88   0  500M  0 disk=0A=
nullb89           252:89   0  500M  0 disk=0A=
nullb90           252:90   0  500M  0 disk=0A=
nullb91           252:91   0  500M  0 disk=0A=
nullb92           252:92   0  500M  0 disk=0A=
nullb9            252:9    0    1G  0 disk=0A=
nullb93           252:93   0  500M  0 disk=0A=
nullb94           252:94   0  500M  0 disk=0A=
nullb95           252:95   0  500M  0 disk=0A=
nullb96           252:96   0  500M  0 disk=0A=
nullb97           252:97   0  500M  0 disk=0A=
nullb98           252:98   0  500M  0 disk=0A=
nullb99           252:99   0  500M  0 disk=0A=
+ sleep 1=0A=
+ dmesg -c=0A=
[ 5690.756095] null_blk: module loaded=0A=
+ lsblk=0A=
+ grep null=0A=
nullb23           252:23   0  500M  0 disk=0A=
nullb51           252:51   0  500M  0 disk=0A=
nullb108          252:108  0  500M  0 disk=0A=
nullb13           252:13   0  500M  0 disk=0A=
nullb41           252:41   0  500M  0 disk=0A=
nullb1            252:1    0    1G  0 disk=0A=
nullb98           252:98   0  500M  0 disk=0A=
nullb31           252:31   0  500M  0 disk=0A=
nullb88           252:88   0  500M  0 disk=0A=
nullb21           252:21   0  500M  0 disk=0A=
nullb106          252:106  0  500M  0 disk=0A=
nullb78           252:78   0  500M  0 disk=0A=
nullb11           252:11   0  500M  0 disk=0A=
nullb68           252:68   0  500M  0 disk=0A=
nullb96           252:96   0  500M  0 disk=0A=
nullb58           252:58   0  500M  0 disk=0A=
nullb86           252:86   0  500M  0 disk=0A=
nullb48           252:48   0  500M  0 disk=0A=
nullb104          252:104  0  500M  0 disk=0A=
nullb76           252:76   0  500M  0 disk=0A=
nullb8            252:8    0    1G  0 disk=0A=
nullb38           252:38   0  500M  0 disk=0A=
nullb66           252:66   0  500M  0 disk=0A=
nullb94           252:94   0  500M  0 disk=0A=
nullb28           252:28   0  500M  0 disk=0A=
nullb56           252:56   0  500M  0 disk=0A=
nullb84           252:84   0  500M  0 disk=0A=
nullb18           252:18   0  500M  0 disk=0A=
nullb46           252:46   0  500M  0 disk=0A=
nullb102          252:102  0  500M  0 disk=0A=
nullb74           252:74   0  500M  0 disk=0A=
nullb6            252:6    0    1G  0 disk=0A=
nullb36           252:36   0  500M  0 disk=0A=
nullb64           252:64   0  500M  0 disk=0A=
nullb92           252:92   0  500M  0 disk=0A=
nullb26           252:26   0  500M  0 disk=0A=
nullb54           252:54   0  500M  0 disk=0A=
nullb110          252:110  0  500M  0 disk=0A=
nullb82           252:82   0  500M  0 disk=0A=
nullb16           252:16   0  500M  0 disk=0A=
nullb44           252:44   0  500M  0 disk=0A=
nullb100          252:100  0  500M  0 disk=0A=
nullb72           252:72   0  500M  0 disk=0A=
nullb4            252:4    0    1G  0 disk=0A=
nullb34           252:34   0  500M  0 disk=0A=
nullb62           252:62   0  500M  0 disk=0A=
nullb90           252:90   0  500M  0 disk=0A=
nullb24           252:24   0  500M  0 disk=0A=
nullb52           252:52   0  500M  0 disk=0A=
nullb109          252:109  0  500M  0 disk=0A=
nullb80           252:80   0  500M  0 disk=0A=
nullb14           252:14   0  500M  0 disk=0A=
nullb42           252:42   0  500M  0 disk=0A=
nullb70           252:70   0  500M  0 disk=0A=
nullb2            252:2    0    1G  0 disk=0A=
nullb99           252:99   0  500M  0 disk=0A=
nullb32           252:32   0  500M  0 disk=0A=
nullb60           252:60   0  500M  0 disk=0A=
nullb89           252:89   0  500M  0 disk=0A=
nullb22           252:22   0  500M  0 disk=0A=
nullb50           252:50   0  500M  0 disk=0A=
nullb107          252:107  0  500M  0 disk=0A=
nullb79           252:79   0  500M  0 disk=0A=
nullb12           252:12   0  500M  0 disk=0A=
nullb40           252:40   0  500M  0 disk=0A=
nullb69           252:69   0  500M  0 disk=0A=
nullb0            252:0    0    1G  0 disk=0A=
nullb97           252:97   0  500M  0 disk=0A=
nullb30           252:30   0  500M  0 disk=0A=
nullb59           252:59   0  500M  0 disk=0A=
nullb87           252:87   0  500M  0 disk=0A=
nullb20           252:20   0  500M  0 disk=0A=
nullb49           252:49   0  500M  0 disk=0A=
nullb105          252:105  0  500M  0 disk=0A=
nullb77           252:77   0  500M  0 disk=0A=
nullb10           252:10   0  500M  0 disk=0A=
nullb9            252:9    0    1G  0 disk=0A=
nullb39           252:39   0  500M  0 disk=0A=
nullb67           252:67   0  500M  0 disk=0A=
nullb95           252:95   0  500M  0 disk=0A=
nullb29           252:29   0  500M  0 disk=0A=
nullb57           252:57   0  500M  0 disk=0A=
nullb85           252:85   0  500M  0 disk=0A=
nullb19           252:19   0  500M  0 disk=0A=
nullb47           252:47   0  500M  0 disk=0A=
nullb103          252:103  0  500M  0 disk=0A=
nullb75           252:75   0  500M  0 disk=0A=
nullb7            252:7    0    1G  0 disk=0A=
nullb37           252:37   0  500M  0 disk=0A=
nullb65           252:65   0  500M  0 disk=0A=
nullb93           252:93   0  500M  0 disk=0A=
nullb27           252:27   0  500M  0 disk=0A=
nullb55           252:55   0  500M  0 disk=0A=
nullb83           252:83   0  500M  0 disk=0A=
nullb17           252:17   0  500M  0 disk=0A=
nullb45           252:45   0  500M  0 disk=0A=
nullb101          252:101  0  500M  0 disk=0A=
nullb73           252:73   0  500M  0 disk=0A=
nullb5            252:5    0    1G  0 disk=0A=
nullb35           252:35   0  500M  0 disk=0A=
nullb63           252:63   0  500M  0 disk=0A=
nullb91           252:91   0  500M  0 disk=0A=
nullb25           252:25   0  500M  0 disk=0A=
nullb53           252:53   0  500M  0 disk=0A=
nullb81           252:81   0  500M  0 disk=0A=
nullb15           252:15   0  500M  0 disk=0A=
nullb43           252:43   0  500M  0 disk=0A=
nullb71           252:71   0  500M  0 disk=0A=
nullb3            252:3    0    1G  0 disk=0A=
nullb33           252:33   0  500M  0 disk=0A=
nullb61           252:61   0  500M  0 disk=0A=
+ echo 'waiting '=0A=
waiting=0A=
+ echo deleteing devices=0A=
deleteing devices=0A=
++ seq 0 100=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb0=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb1=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb2=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb3=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb4=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb5=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb6=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb7=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb8=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb9=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb10=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb11=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb12=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb13=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb14=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb15=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb16=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb17=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb18=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb19=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb20=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb21=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb22=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb23=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb24=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb25=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb26=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb27=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb28=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb29=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb30=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb31=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb32=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb33=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb34=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb35=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb36=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb37=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb38=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb39=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb40=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb41=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb42=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb43=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb44=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb45=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb46=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb47=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb48=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb49=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb50=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb51=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb52=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb53=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb54=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb55=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb56=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb57=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb58=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb59=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb60=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb61=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb62=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb63=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb64=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb65=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb66=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb67=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb68=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb69=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb70=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb71=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb72=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb73=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb74=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb75=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb76=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb77=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb78=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb79=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb80=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb81=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb82=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb83=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb84=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb85=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb86=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb87=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb88=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb89=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb90=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb91=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb92=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb93=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb94=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb95=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb96=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb97=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb98=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb99=0A=
+ for i in '`seq 0 $NN`'=0A=
+ rmdir config/nullb/nullb100=0A=
+ modprobe -r null_blk=0A=
=0A=
Terminal 2 :-=0A=
=0A=
  # while [ 1 ] ; do modprobe -r null_blk; =0A=
                                 if [ $? -eq 0 ]; then break; fi; sleep =0A=
1; done=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
modprobe: FATAL: Module null_blk is in use.=0A=
