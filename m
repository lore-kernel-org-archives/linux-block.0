Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16B3C433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 07:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09C920707
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 07:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgHZHzQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:55:16 -0400
Received: from smtp.h3c.com ([60.191.123.56]:38647 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgHZHzP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 03:55:15 -0400
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 07Q63jcv060453;
        Wed, 26 Aug 2020 14:03:45 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX08-IDC.srv.huawei-3com.com ([10.8.0.71])
        by h3cspam01-ex.h3c.com with ESMTPS id 07Q62tCU058786
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 14:02:56 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Aug 2020 14:02:58 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Wed, 26 Aug 2020 14:02:58 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [v2] blk-mq: use BLK_MQ_NO_TAG for no tag
Thread-Topic: [PATCH] [v2] blk-mq: use BLK_MQ_NO_TAG for no tag
Thread-Index: AQHWe06EoNdwEm3z5kubymyHs5tnf6lJRjMAgACeIyA=
Date:   Wed, 26 Aug 2020 06:02:57 +0000
Message-ID: <3321aa16ad214cb1a0a5cda1309f0e45@h3c.com>
References: <20200826020651.9856-1-tian.xianting@h3c.com>
 <20200826042918.GA116347@T590>
In-Reply-To: <20200826042918.GA116347@T590>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 07Q62tCU058786
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming Lei
Thanks for your quick comment.
As the function request_to_qc_t() in 'include/linux/blk-mq.h ' used the magic '-1',
Seems it is hard to replace it with BLK_MQ_NO_TAG :(

-----Original Message-----
From: Ming Lei [mailto:ming.lei@redhat.com] 
Sent: Wednesday, August 26, 2020 12:29 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: axboe@kernel.dk; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] blk-mq: use BLK_MQ_NO_TAG for no tag

On Wed, Aug 26, 2020 at 10:06:51AM +0800, Xianting Tian wrote:
> Replace various magic -1 constants for tags with BLK_MQ_NO_TAG.
> And move the definition of BLK_MQ_NO_TAG from 'block/blk-mq-tag.h'
> to 'include/linux/blk-mq.h'

All three symbols are supposed for block core internal code only, so looks you shouldn't move them to public header.


Thanks,
Ming

