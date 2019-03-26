Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478FCC43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 01:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216ED20848
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 01:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfCZBbD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:31:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:27619 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfCZBbC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 21:31:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 18:31:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="137252173"
Received: from zliu7-mobl2.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.116])
  by orsmga003.jf.intel.com with ESMTP; 25 Mar 2019 18:30:59 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1h8ava-0007nx-GU; Tue, 26 Mar 2019 09:30:58 +0800
Date:   Tue, 26 Mar 2019 09:30:58 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     Martin Liu <liumartin@google.com>, akpm@linux-foundation.org,
        axboe@kernel.dk, dchinner@redhat.com, jenhaochen@google.com,
        salyzyn@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] mm: readahead: add readahead_shift into backing
 device
Message-ID: <20190326013058.ykdwxbfkk3x3pvtu@wfg-t540p.sh.intel.com>
References: <20190322154610.164564-1-liumartin@google.com>
 <20190325121628.zxlogz52go6k36on@wfg-t540p.sh.intel.com>
 <9b194e61-f2d0-82cb-30ac-95afb493b894@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9b194e61-f2d0-82cb-30ac-95afb493b894@android.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 25, 2019 at 09:59:31AM -0700, Mark Salyzyn wrote:
>On 03/25/2019 05:16 AM, Fengguang Wu wrote:
>> Martin,
>>
>> On Fri, Mar 22, 2019 at 11:46:11PM +0800, Martin Liu wrote:
>>> As the discussion https://lore.kernel.org/patchwork/patch/334982/
>>> We know an open file's ra_pages might run out of sync from
>>> bdi.ra_pages since sequential, random or error read. Current design
>>> is we have to ask users to reopen the file or use fdavise system
>>> call to get it sync. However, we might have some cases to change
>>> system wide file ra_pages to enhance system performance such as
>>> enhance the boot time by increasing the ra_pages or decrease it to
>>
>> Do you have examples that some distro making use of larger ra_pages
>> for boot time optimization?
>
>Android (if you are willing to squint and look at android-common AOSP
>kernels as a Distro).

OK. I wonder how exactly Android makes use of it. Since phones are not
using hard disks, so should benefit less from large ra_pages.  Would
you kindly point me to the code?

>> Suppose N read streams with equal read speed. The thrash-free memory
>> requirement would be (N * 2 * ra_pages).
>>
>> If N=1000 and ra_pages=1MB, it'd require 2GB memory. Which looks
>> affordable in mainstream servers.
>That is 50% of the memory on a high end Android device ...

Yeah but I'm obviously not talking Android device here. Will a phone
serve 1000 concurrent read streams?

>> Sorry but it sounds like introducing an unnecessarily twisted new
>> interface. I'm afraid it fixes the pain for 0.001% users while
>> bringing more puzzle to the majority others.
> >2B Android devices on the planet is 0.001%?

Nope. Sorry I didn't know about the Android usage.
Actually nobody mentioned it in the past discussions.

>I am not defending the proposed interface though, if there is something
>better that can be used, then looking into:
>>
>> Then let fadvise() and shrink_readahead_size_eio() adjust that
>> per-file ra_pages_shift.
>Sounds like this would require a lot from init to globally audit and
>reduce the read-ahead for all open files?

It depends. In theory it should be possible to create a standalone
kernel module to dump the page cache and get the current snapshot of
all cached file pages. It'd be a one-shot action and don't require
continuous auditing.

[RFC] kernel facilities for cache prefetching
https://lwn.net/Articles/182128

This tool may also work. It's quick to get the list of opened files by
walking /proc/*/fd/, however not as easy to get the list of cached
file names.

https://github.com/tobert/pcstat

Perhaps we can do a simplified /proc/filecache that only dumps the
list of cached file names. Then let mincore() based tools take care
of the rest work.

Regards,
Fengguang
