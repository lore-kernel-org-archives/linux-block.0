Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAF3C6783B
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 02:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B38120870
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 02:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B38120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLLC6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:58:16 -0500
Received: from sandeen.net ([63.231.237.45]:48652 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeLLC6P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 21:58:15 -0500
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 564B586D;
        Tue, 11 Dec 2018 20:58:07 -0600 (CST)
Subject: Re: xfstests generic/347 was never correct [was: Re: dm: fix inflight
 IO check]
To:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        sandeen@redhat.com, fstests@vger.kernel.org
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <4fec4b01-35f9-8008-22ec-2ac8af58b854@kernel.dk>
 <20181211003204.GA14673@redhat.com> <20181212023424.GA21119@redhat.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Openpgp: preference=signencrypt
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <c4d94e2b-883b-7b6c-ec08-54b10ba4c9ca@sandeen.net>
Date:   Tue, 11 Dec 2018 20:58:13 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181212023424.GA21119@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/18 8:34 PM, Mike Snitzer wrote:
> On Mon, Dec 10 2018 at  7:32pm -0500,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
>> On Mon, Dec 10 2018 at  5:45pm -0500,
>> Jens Axboe <axboe@kernel.dk> wrote:
>>
>>> After switching to percpu inflight counters, the inflight check
>>> is totally buggy. It's perfectly valid for some counters to be
>>> non-zero while having a total inflight IO count of 0, that's how
>>> these kinds of counters work (inc on one CPU, dec on another).
>>> Fix the md_in_flight() check to sum all counters before returning
>>> a false positive, potentially.
>>>
>>> While at it, remove the inflight read for IO completion. We don't
>>> need it, just wake anyone that's waiting for the IO count to drop
>>> to zero. The caller needs to re-check that value anyway when woken,
>>> which it does.
>>>
>>> Fixes: 6f75723190d8 ("dm: remove the pending IO accounting")
>>> Reported-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> I'm seeing that device-mapper-test-suite's "resize_io" test doesn't
>> pass.  Glad this resolves the xfstest issue but I think more work is
>> needed, so I'll build any additional changes on this fix.
> 
> Turns out the device-mapper-test-suite 'resize_io' issue I was seeing is
> just a long lingering race that just got much more likely on my newer
> testbed.  This fixes what I was seeing:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.20&id=f6c367585d0d851349d3a9e607c43e5bea993fa1
> 
> But pivoting back to xfstests generic/347: that test was broken from the
> start, if it ever _really_ worked it would've been a bug in dm-thinp.
> And even after Jens' fix (above) the test still just times out after 60
> secs while in out-of-data-space (OODS) mode and gives a false "Passed
> all 1 tests".
> 
> generic/347 exhausting the thin-pool's data space and then issuing
> "sync" will cause IO to hang for 60 secs unless, in parallel, another
> process comes along and grows the thin-pool to have more data space.
> But even if xfstests' _dmthin_grow function were to be issued in 
> parallel with another process it'll fail because it uses
> _dmthin_reload_table which "dmsetup suspend"s the thin device (that was
> just used by XFS to fill the thin-pool) _without_ using the --noflush
> flag for "dmsetup suspend".  So the thin device will wait forever for
> its  outstanding IO to finish before generic/347's _dmthin_grow will be
> able to resize the thin-pool.  Leading to deadlock.  Or until the 60
> secs (dm_thin_pool.ko "no_space_timeout" modparam default) causes the
> thin-pool to switch from OODS "queue IO" to OODS "error IO" mode:
> 
> # tail -f /var/log/messages &
> # ./check generic/347
> Dec 11 21:12:57 thegoat kernel: XFS (dm-1): Mounting V5 Filesystem
> Dec 11 21:12:57 thegoat kernel: XFS (dm-1): Ending clean mount
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 thegoat 4.20.0-rc6.snitm+
> MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/test-metadata
> MOUNT_OPTIONS -- /dev/mapper/test-metadata /scratch
> 
> Dec 11 21:12:58 thegoat kernel: device-mapper: thin: 253:4: reached low water mark for data device: sending event.
> Dec 11 21:12:58 thegoat kernel: device-mapper: thin: 253:4: switching pool to out-of-data-space (queue IO) mode
> Dec 11 21:14:01 thegoat kernel: device-mapper: thin: 253:4: switching pool to out-of-data-space (error IO) mode
> Dec 11 21:14:01 thegoat kernel: xfs_destroy_ioend: 136 callbacks suppressed
> Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1354752
> Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1358592
> Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1362432
> Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1366272
> Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1370112
> Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1373952
> Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1377792
> Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1381632
> Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1385472
> Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1389312
> Dec 11 21:14:02 thegoat kernel: device-mapper: thin: 253:4: switching pool to write mode
> Dec 11 21:14:02 thegoat kernel: device-mapper: thin: 253:4: growing the data device from 1000 to 1200 blocks
> Dec 11 21:14:02 thegoat kernel: device-mapper: thin: 253:4: reached low water mark for data device: sending event.
> Dec 11 21:14:02 thegoat kernel: XFS (dm-5): Unmounting Filesystem
>  65s
> Ran: generic/347
> Passed all 1 tests
> 
> Dec 11 21:14:02 thegoat kernel: XFS (dm-1): Unmounting Filesystem
> 
> SO generic/347 needs to account for 2 things:
> 1) issue $XFS_IO_PROG IO in the background with other process(es)
> 2) in parallel, in main generic/347 shell, run _dmthin_grow but the
> "thin" device must be suspended with dmsetup suspend --noflush
> 
> Eric Sandeen: can you or someone else xfstests inclined use this info to
> fix generic/347 please?

It's not at all clear to me what is wrong with the test.  "Do a bunch of IO
including a sync, completely filling the backing store, then grow the backing store"
is surely a real-world scenario that dm-thinp might encounter, no?  Things
do recover, subsequent writes succeed, and when all is said and done the filesystem
is checked and it's still consistent.  That sounds like some version of success to me.

Even if it's emulating a dumb user/administrator, that doesn't seem invalid.

What is wrong here?

-Eric
