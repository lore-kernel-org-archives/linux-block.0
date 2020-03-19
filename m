Return-Path: <SRS0=6FHI=5E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085DBC4332D
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF33A20740
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 10:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCSKnG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:43:06 -0400
Received: from relay.sw.ru ([185.231.240.75]:43536 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgCSKnG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Mar 2020 06:43:06 -0400
Received: from [192.168.15.99]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1jEscu-0005aV-EY; Thu, 19 Mar 2020 13:42:12 +0300
Subject: Re: [PATCH v7 0/6] block: Introduce REQ_ALLOCATE flag for
 REQ_OP_WRITE_ZEROES
To:     Christoph Hellwig <hch@infradead.org>, martin.petersen@oracle.com
Cc:     axboe@kernel.dk, bob.liu@oracle.com, darrick.wong@oracle.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <158157930219.111879.12072477040351921368.stgit@localhost.localdomain>
 <e2b7cbab-d91f-fd7b-de6f-a671caa6f5eb@virtuozzo.com>
 <69c0b8a4-656f-98c4-eb55-2fd1184f5fc9@virtuozzo.com>
 <67d63190-c16f-cd26-6b67-641c8943dc3d@virtuozzo.com>
 <20200319102819.GA26418@infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <dda7926e-7f2c-61b7-9173-845377cf1229@virtuozzo.com>
Date:   Thu, 19 Mar 2020 13:42:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319102819.GA26418@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19.03.2020 13:28, Christoph Hellwig wrote:
> On Fri, Mar 13, 2020 at 04:08:58PM +0300, Kirill Tkhai wrote:
>> I just don't understand the reason nothing happens :(
>> I see newly-sent patches comes fast into block tree.
>> But there is only silence... I grepped over Documentation,
>> and there is no special rules about block tree. So,
>> it looks like standard rules should be applyable.
>>
>> Some comments? Some requests for reworking? Some personal reasons to ignore my patches?
> 
> I'm still completely opposed to the magic overloading using a flag.
> That is just a bad design waiting for trouble to happen.

This flag is suggested by Martin Petersen, while the first version of the patchset was based
on a separate operation.

Since I see only Jens in MAINTAINERS:

BLOCK LAYER
M:      Jens Axboe <axboe@kernel.dk>
L:      linux-block@vger.kernel.org
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
S:      Maintained
F:      block/
F:      drivers/block/
F:      kernel/trace/blktrace.c
F:      lib/sbitmap.c

I expect his comments about final design of this, because both you and Martin are maintainers
of another subsystems. I don't want rework this many times until Jens says he wants some third
design.

I think I'm pretty polite and patient in my waiting, while Jens completely ignores me by some
reasons, which are completely unclear for me. I don't think this is completely polite in relation
to me.

Kirill
