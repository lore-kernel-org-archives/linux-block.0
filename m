Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634DAC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310BC2054F
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfEAM4q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 08:56:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfEAM4q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 May 2019 08:56:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 563333088B84;
        Wed,  1 May 2019 12:56:46 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC176721D3;
        Wed,  1 May 2019 12:56:45 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
Subject: Re: [RFC PATCH 02/18] blktrace: add more definitions for BLK_TC_ACT
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
        <20190501042831.5313-3-chaitanya.kulkarni@wdc.com>
        <20190501123104.GA17987@infradead.org>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 01 May 2019 08:56:44 -0400
In-Reply-To: <20190501123104.GA17987@infradead.org> (Christoph Hellwig's
        message of "Wed, 1 May 2019 05:31:04 -0700")
Message-ID: <x49sgtyxrhv.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 01 May 2019 12:56:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Apr 30, 2019 at 09:28:15PM -0700, Chaitanya Kulkarni wrote:
>> @@ -104,7 +120,12 @@ struct blk_io_trace {
>>  	__u64 time;		/* in nanoseconds */
>>  	__u64 sector;		/* disk offset */
>>  	__u32 bytes;		/* transfer length */
>> +
>> +#ifdef CONFIG_BLKTRACE_EXT
>> +	__u64 action;		/* what happened */
>> +#else
>>  	__u32 action;		/* what happened */
>> +#endif /* CONFIG_BLKTRACE_EXT */
>
> You can't use CONFIG_ symbols in UAPI headers, as userspace
> applications won't set it.  You also can't ever change the layout of an
> existing structure in UAPI headers in not backward compatible way.

Right.  The blk_io_trace->magic has the lower 8 bits reserved for a
version number which is checked by userspace.  There's no way to
negotiate a supported version between userspace and the kernel,
unfortunately.  The version number is checked for each trace event.

What you *could* do is to add another trace event with a higher version
number that includes only the extra data.  So each event would be split
into two: the original event with original content and the new event
that only contains the new fields.  That way the old userspace would
continue to work, as it would discard the trace events it doesn't
recognize.  Newer userspace could handle both types of events, and merge
them back together.

There would be a ton of warnings spewed on stderr, unfortunately, but it
would at least work.  I don't see a lot of value in the kernel config
option, no matter which way we go with this.

-Jeff
