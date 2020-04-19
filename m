Return-Path: <SRS0=58UM=6D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF44C38A30
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 16:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C4E214D8
	for <linux-block@archiver.kernel.org>; Sun, 19 Apr 2020 16:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDSQG4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:06:56 -0400
Received: from verein.lst.de ([213.95.11.211]:36927 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgDSQGz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Apr 2020 12:06:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 21F0368BFE; Sun, 19 Apr 2020 18:06:52 +0200 (CEST)
Date:   Sun, 19 Apr 2020 18:06:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200419160651.GA18308@lst.de>
References: <20200416165453.1080463-1-hch@lst.de> <20200416165453.1080463-4-hch@lst.de> <20200417085909.GA12234@quack2.suse.cz> <70f001cd-eaec-874f-9742-c44e66368a2a@acm.org> <20200419075809.GA12222@lst.de> <a37e947d-c49a-837e-e97d-647ca9d378c3@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a37e947d-c49a-837e-e97d-647ca9d378c3@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 19, 2020 at 08:29:21AM -0700, Bart Van Assche wrote:
> On 4/19/20 12:58 AM, Christoph Hellwig wrote:
>> On Sat, Apr 18, 2020 at 08:40:20AM -0700, Bart Van Assche wrote:
>>>> This can have a sideeffect not only bdi->dev_name will be truncated to 64
>>>> chars (which generally doesn't matter) but possibly also kobject name will
>>>> be truncated in the same way.  Which may have user visible effects. E.g.
>>>> for fs/vboxsf 64 chars need not be enough. So shouldn't we rather do it the
>>>> other way around - i.e., let device_create_vargs() create the device name
>>>> and then copy to bdi->dev_name whatever fits?
>>>
>>> How about using kvasprintf() instead of vsnprintf()?
>>
>> That is what v1 did, see the thread in response to that on why it isn't
>> a good idea.
>
> Are you perhaps referring to patch "[PATCH 3/8] bdi: add a ->dev_name field 
> to struct backing_dev_info" 
> (https://lore.kernel.org/linux-block/20200416071519.807660-4-hch@lst.de/) 
> and also to the replies to that patch? This is what I found in the replies: 
> "When driver try to to re-register bdi but without release_bdi(), the old 
> dev_name will be cover directly by the newer in bdi_register_va(). So, I am 
> not sure whether it can cause memory leak for bdi->dev_name."
>
> Has it been considered to avoid that leak by freeing bdi->dev_name from 
> unregister_bdi(), e.g. as follows?

We'd need some protection against concurrent accesses as unregister_bdi
can race with them.  But with RCU that could be handled, so let me try
that.
