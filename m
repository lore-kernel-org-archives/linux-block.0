Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8449C678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 15:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCBPMy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 10:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCBPMx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 10:12:53 -0500
X-Greylist: delayed 292 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 07:12:51 PST
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881231FD0;
        Thu,  2 Mar 2023 07:12:51 -0800 (PST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 7690522170E;
        Thu,  2 Mar 2023 15:07:57 +0000 (UTC)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 6B5E522170A;
        Thu,  2 Mar 2023 15:07:57 +0000 (UTC)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx.dmz.swissbit.com [10.181.10.103])
        by mail6.swissbit.com (Postfix) with ESMTPS;
        Thu,  2 Mar 2023 15:07:57 +0000 (UTC)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Topic: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Index: AQHZTRVhGw7IamWdbkW+N3YLAv3UBK7nlDEQ
Date:   Thu, 2 Mar 2023 15:07:56 +0000
Message-ID: <5712c69ae37447c5b576d87b247f5756@hyperstone.com>
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
In-Reply-To: <20230302144330.274947-1-ulf.hansson@linaro.org>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27480.000
X-TMASE-Result: 10-2.075100-10.000000
X-TMASE-MatchedRID: w2TFuZOvAtfUL3YCMmnG4vHkpkyUphL9GbJMFqqIm9w2BwnN0UEfH5qW
        GFVQ7EMwz7v6zGLMvM1ndcUrht03hmULhS/RYteOBe3KRVyu+k1NLPQl0QAltHROxyHvZdJsiji
        J0PQAhX6yaJXoZYzXD1/B8CJnWufZCO9nmUqpU4TIpMSwJEh3JX0tCKdnhB58gUP+Fn6N6KZp7q
        EhmmPgy46HM5rqDwqtRXYDrsIw5v1KVaUBlILHuXLgWxZmXoUU0N1zH9zaTpmtAP2E8fvkOA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 6e13c5a6-1113-4a0a-a58c-5b804538be16-0-0-200-0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Subject: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an internal cache

Hey Uffe,
I may have the setup to play with this.
(Powerfailing eMMC devices)
> 
> REQ_FUA is in general supported for eMMC cards, which translates into so called "reliable writes". To support these write operations, the CMD23 (MMC_CAP_CMD23), needs to be supported by the mmc host too, which is common but not always the case.
> 
> For some eMMC devices, it has been reported that reliable writes are quite costly, leading to performance degradations.
> 
> In a way to improve the situation, let's avoid announcing REQ_FUA support if the eMMC supports an internal cache, as that allows us to rely solely on flush-requests (REQ_OP_FLUSH) instead, which seems to be a lot cheaper.
> Note that, those mmc hosts that lacks CMD23 support are already using this type of configuration, whatever that could mean.

Just note that reliable write is strictly weaker than turning cache off/flushing,
if card loses power during cache off/flush programming / busy, sector-wise atomicity is not mandated by the spec.
(And that is assuming cache off/flush is actually respected by the card as intended by the spec, should some cards be checked?)
Maybe some FS people can also chime in?

Regards,
Christian

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

