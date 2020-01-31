Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AC1C33CB2
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE4A20CC7
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgAaJQd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:16:33 -0500
Received: from relay.sw.ru ([185.231.240.75]:39718 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgAaJQd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 04:16:33 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ixSOT-0007Vt-8L; Fri, 31 Jan 2020 12:15:17 +0300
Subject: Re: [PATCH block v2 2/3] block: Add support for REQ_NOZERO flag
To:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
References: <157917805422.88675.6477661554332322975.stgit@localhost.localdomain>
 <157917816325.88675.16481772163916741596.stgit@localhost.localdomain>
 <yq14kwpibf6.fsf@oracle.com> <20200131062343.GA6267@infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <683bb62a-9667-d2c7-0437-7a6343819382@virtuozzo.com>
Date:   Fri, 31 Jan 2020 12:15:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131062343.GA6267@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Christoph,

On 31.01.2020 09:23, Christoph Hellwig wrote:
> On Tue, Jan 21, 2020 at 01:14:05AM -0500, Martin K. Petersen wrote:
>> I find there is some dissonance between using BLKDEV_ZERO_ALLOCATE to
>> describe this operation in one case and REQ_NOZERO in the other.
>>
>> I understand why not zeroing is important in your case. However, I think
>> the allocation aspect is semantically more important. Also, in the case
>> of SCSI, the allocated blocks will typically appear zeroed. So from that
>> perspective REQ_NOZERO doesn't really make sense. I would really prefer
>> to use REQ_ALLOCATE to describe this operation. I agree that "do not
>> write every block" is important too. I just don't have a good suggestion
>> for how to express that as an additional qualifier to REQ_ALLOCATE_?.
> 
> Agreed.  Nevermind the problem of a REQ_OP_WRITE_ZEROES operations with
> a NOZERO flag causing a massive confusion to the reader.
> 
>> Also, adding to the confusion: In the context of SCSI, ANCHOR requires
>> UNMAP. So my head hurts a bit when I read REQ_NOZERO|REQ_NOUNMAP and
>> have to translate that into ANCHOR|UNMAP.
>>
>> Longer term, I think we should consider introducing REQ_OP_SINGLE_RANGE
>> or something like that as an umbrella operation that can be used to
>> describe zeroing, allocating, and other things that operate on a single
>> LBA range with no payload. Thus removing both the writiness and the
>> zeroness from the existing REQ_OP_WRITE_ZEROES conduit.
> 
> What is the benefit of a multipler there?  Given all this flags
> confusion I'm almost tempted to just split up REQ_OP_WRITE_ZEROES into
> REQ_OP_ALLOCATE ("cheap") and REQ_OP_WRITE_ZEROES ("potentially
> expensive") and just let the caller handle the difference.  Everytime
> we try to encode semantic differences into flags we're eventually
> running into trouble.  Sais the person that added REQ_UNMAP..

We started from separated REQ_OP_ASSIGN_RANGE in v1, but then we decided
to use a modifier because this looks better and scatters less over
I/O stack. See "[PATCH RFC 0/3] block,ext4: Introduce REQ_OP_ASSIGN_RANGE
to reflect extents allocation in block device internals" series for the details.
(https://lkml.org/lkml/2020/1/7/1616 and neighbouring messages).

Last version of the patchset is v5 and it's here: https://lkml.org/lkml/2020/1/22/643

Kirill
