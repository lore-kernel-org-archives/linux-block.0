Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F91C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 01:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889DD2133F
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 01:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjwc2mi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeLSBbn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 20:31:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34202 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeLSBbm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 20:31:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so17862467wrw.1;
        Tue, 18 Dec 2018 17:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKypxN50SBDAq4A4mDKiUHEX02ab8Ut8GkQtEood9Sg=;
        b=kjwc2mi3gWy42nsQqVGKQXjnj4kAWJqSJzt/l88Dj3yJLZkA8/oEsE7tGORBwzYDeL
         70ZOpORvHd+ioCfO3CovDApjGffDFCrcg1SlLeOQOCgRvZP9v3Qm6SepdgwKVxMJ/3zl
         I209635BAonw+2Adl44fPQKEyjP2cdtAvkp+3hDZBUrZEpQj24Mc9wzJkD1M5xIodAk1
         oK6YDej/2kzZ9qDK+4mAmOzmuU2NCM53eFJAAvJRfsZDyzT09OBBYZTr7L+Zv6aYkc+l
         bWNTeMJiPBQtYw97F95Pc1plCh7Q5gZK6Fwg10I0ZhA51oC+VxOaV7P5o2KKs1RhP7d8
         iIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKypxN50SBDAq4A4mDKiUHEX02ab8Ut8GkQtEood9Sg=;
        b=TNQJ80U9XJ3FlSM6lnFi+yanJrOLccuFfBf38cc5L+S1JcEStwfIDYVZk3dbH3VU34
         CD92AEHTZWh4HG/PsebxKXbz/fdO1EQEgQWy/zhdHhyTZL83BCJE+bCHuXCh6cAaLLXT
         jDQjuzRmBfbCVmatwKmOt4OYsgoyIttEkJRtYTFRIy4l5VvnTSzPvYF6m9LMNAWLO0zQ
         fPTDV84KU+oLYoso99fBN8y4M/DhXyP2xER1GezRtgmhLc4I4V3NjUlDYJkSRsGmER5w
         H/T7OmCmDiVcVDVoUBdzoEZLz1QQNr6b40rhekgr5cXDKLsv1ImzN1RtpINg8fWhiDhc
         pD9w==
X-Gm-Message-State: AA+aEWY7lUU4z314WguyiuW59cXlUphbvsu0O5t+ImtGFO6SvTSUM/oS
        DgQvzPkDr84OlasDZFsbPn3om75UjzJjqmg5R5UDywL9
X-Google-Smtp-Source: AFSGD/XLWfZ9yEMiSA+0kqUMT4g0vFTSSnUMjHQKn6sc+Rv+qVe80aU0YoTh9gCnnqQn2U1mT6LoRnhNxsXGZYtDn1E=
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr17802554wrn.109.1545183100404;
 Tue, 18 Dec 2018 17:31:40 -0800 (PST)
MIME-Version: 1.0
References: <CA+NNRhE8438XuoZ25kdCRjYvZv6nHJU+Yoyg6hacWuptjWWDfA@mail.gmail.com>
 <20181218140157.GB7144@kmo-pixel>
In-Reply-To: <20181218140157.GB7144@kmo-pixel>
From:   Junhui Tang <tang.junhui.linux@gmail.com>
Date:   Wed, 19 Dec 2018 09:32:55 +0800
Message-ID: <CA+NNRhFgAqHSxYP2TqDx_bLNGYOEe8paHU9dz7Nos=dhMDK9gQ@mail.gmail.com>
Subject: Re: [PATCH] bcache: treat stale && dirty keys as bad keys
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     colyli@suse.de, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hello Kent

Long long no see, glad to hear you again.

>> Then two steps:
>> A) update k1 to k2 in btree node memory;
>>    bch_btree_insert_keys(b, op, insert_keys, replace_key)
>> B) Write the bset(contains k2) to cache disk by a 30s delay work
>>    bch_btree_leaf_dirty(b, journal_ref).
>> But before the 30s delay work write the bset to cache device,
>> these things happend:
>> A) GC works, and reclaim the bucket k2 point to;
>> B) Allocator works, and invalidate the bucket k2 point to,
>>    and increase the gen of the bucket, and place it into free_inc
>>    fifo;
>> C) Until now, the 30s delay work still does not finish work,
>>    so in the disk, the key still is k1, it is dirty and stale
>>    (its gen is smaller than the gen of the bucket). and then the
>>    machine power off suddenly happens;
>> D) When the machine power on again, after the btree reconstruction,
>>    the stale dirty key appear.

> Only prior to journal replay, right? Or did you uncover something more severe?
No, it's after the journal replay, and in write_dirty_finish(), when
replace a dirty key with a clean key by calling bch_btree_insert(),
no journal will write.

>> In bch_extent_bad(), when expensive_debug_checks is off, it would
>> treat the dirty key as good even it is stale keys, and it would
>> cause bellow probelms:
>> A) In read_dirty() it would cause machine crash:
>>    BUG_ON(ptr_stale(dc->disk.c, &w->key, 0));
>> B) It could be worse when reads hits stale dirty keys, it would
>>    read old incorrect data.

>Neither of these can happen until after journal replay is finished. Prior to
>journal replay we expect to find stale dirty keys - if we find any after journal
>replay then it's indicative of a real bug.
As I said previous, since no journal writes after inserting a replace key in
writeback, so this issue has nothing to do with journal.

This is a real problem in my environment, after running IO sometimes, I turn off
the power suddenly,  then turn on the power, and the machine crash in
read_dirty() due to the stale && dirty keys.
