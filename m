Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F91C433F5
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 03:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A3C613A9
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 03:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhJVDO5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhJVDO5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 23:14:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E17FC061764;
        Thu, 21 Oct 2021 20:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=W0LD9iPvxxhEJ3MC2BpmyEY64d7qaINAGgTsXYSy428=; b=cYDUUwCiDlFw5AzyRMN9tlggeH
        9bieqFxqnVXkwZshKFtrCWiWTRj42Do3v3duec5Oh2NeBr/KtY2JFs19YrFYe0pjKgkjitbcJVU74
        3L08/bDkVn1tUvxtnfojRZTI4YQuqf0qGPiYnvURf63sODp5N4b02/KHuPw9GCLRd3M6EmVk8Ojgu
        oBS83rFU7lxFzpRkPtkVGxQiFpQdqzIyU3p0je/yXb3QsaRNe4eexfYRYdsHlsX8Pbp3yHsoQjWpz
        Wurr52oXnhVFBC7Wm/ZyMZRdkLB1Q5ijXqsDPwyM11+aSkVj9GJTqnh7As2hIZpDy+Zf5omesnM5z
        tH6JZAqw==;
Received: from [2602:306:c5a2:a380:b27b:25ff:fe2c:51a8]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdkxM-00DffH-LH; Fri, 22 Oct 2021 03:11:19 +0000
Subject: Re: [PATCH 00/13] block: add_disk() error handling stragglers
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, jim@jtan.com, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
        nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <a31970d6-8631-9d9d-a36f-8f4fcebfb1e6@infradead.org>
 <YW2duaTqf3qUbTIm@bombadil.infradead.org>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <24bc86d0-9d8d-8c8a-7f74-a87f9089342b@infradead.org>
Date:   Thu, 21 Oct 2021 20:10:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW2duaTqf3qUbTIm@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Luis,

On 10/18/21 9:15 AM, Luis Chamberlain wrote:
> On Sun, Oct 17, 2021 at 08:26:33AM -0700, Geoff Levand wrote:
>> Hi Luis,
>>
>> On 10/15/21 4:52 PM, Luis Chamberlain wrote:
>>> This patch set consists of al the straggler drivers for which we have
>>> have no patch reviews done for yet. I'd like to ask for folks to please
>>> consider chiming in, specially if you're the maintainer for the driver.
>>> Additionally if you can specify if you'll take the patch in yourself or
>>> if you want Jens to take it, that'd be great too.
>>
>> Do you have a git repo with the patch set applied that I can use to test with?
> 
> Sure, although the second to last patch is in a state of flux given
> the ataflop driver currently is broken and so we're seeing how to fix
> that first:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20211011-for-axboe-add-disk-error-handling

That branch has so many changes applied on top of the base v5.15-rc4
that the patches I need to apply to test on PS3 with don't apply.

Do you have something closer to say v5.15-rc5?  Preferred would be
just your add_disk() error handling patches plus what they depend
on.

Thanks.

-Geoff
