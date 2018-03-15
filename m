Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55765 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752812AbeCOPqS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:46:18 -0400
Subject: Re: [RFC PATCH] bcache: enable big endian support for IBM s390x
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20180315111500.24865-1-colyli@suse.de>
 <20180315134720.GA14209@infradead.org>
From: Coly Li <colyli@suse.de>
Message-ID: <214a2456-a499-72f5-d5a0-e9f6b7ef9b2e@suse.de>
Date: Thu, 15 Mar 2018 23:45:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180315134720.GA14209@infradead.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 15/03/2018 9:47 PM, Christoph Hellwig wrote:
>> +static void swap_cache_sb_from_cpu(struct cache_sb *sb,
>> +				   struct cache_sb *out)
>> +{
>> +	int i;
>> +
>> +	out->offset		= cpu_to_le64(sb->offset);
>> +	out->flags		= cpu_to_le64(sb->flags);
>> +	out->seq		= cpu_to_le64(sb->seq);
> 
> This looks completely bogus and sparse will complain loudly about it.
> Please make sure you have proper endianess annotations in place.
> 
Hi Christoph,

Oh, you notice me, I realize currently bcache does not have an on-disk
super block format, struct cache_sb is used for both on-disk and in-memory.

Thanks for the hint, I need to separate on-disk data structures from
in-memory ones.

Coly Li
