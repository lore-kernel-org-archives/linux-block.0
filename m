Return-Path: <SRS0=Dkg2=TO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13847C04AB4
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 13:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C2B2147A
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 13:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfENN5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 09:57:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:53408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbfENN5t (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 09:57:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BC79AECB;
        Tue, 14 May 2019 13:57:48 +0000 (UTC)
Subject: Re: [PATCH 01/10] block: don't decrement nr_phys_segments for
 physically contigous segments
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     axboe@fb.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
References: <20190513063754.1520-1-hch@lst.de>
 <20190513063754.1520-2-hch@lst.de> <20190513094544.GA30381@ming.t460p>
 <20190513120344.GA22993@lst.de> <20190514043642.GB10824@ming.t460p>
 <20190514051441.GA6294@lst.de> <20190514090544.GC20468@ming.t460p>
 <20190514135141.GA13683@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <dd92aaec-f217-ec4f-a51c-8bccaea4c8fb@suse.de>
Date:   Tue, 14 May 2019 15:57:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514135141.GA13683@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/14/19 3:51 PM, Christoph Hellwig wrote:
> On Tue, May 14, 2019 at 05:05:45PM +0800, Ming Lei wrote:
>> However we still may make it better, for example, the attached patch can
>> save 10~20% time when running 'mkfs.ntfs -s 512 /dev/vda', lots of small
>> request(63KB) can be merged to big IO(1MB).
> 
> And we could save even more time by making the block dev buffered I/O
> path not do stupid things to start with.
> 
>>> With the gap devices we have unlimited segment size, see my next patch
>>> to actually enforce that.  Which is much more efficient than using
>>
>> But this patch does effect on non-gap device, and actually most of
>> device are non-gap type.
> 
> Yes, but only for request merges, and only if merging the requests
> goes over max_requests.  The upside is that we actually get a
> nr_phys_segments that mirrors what is in the request, fixing bugs
> in a few drivers, and allowing for follow on patches that significantly
> simplify our I/O path.
> 
And we've seen several of these crashes in real life; signature is 
'Kernel oops at drivers/scsi/scsi_lib.c:1003'.
So I'm really glad that this one is finally being addressed.

Thanks Christoph!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
