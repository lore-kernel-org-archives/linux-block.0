Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] block: Convert hd_struct in_flight from atomic to
 percpu
To: Brian King <brking@linux.vnet.ibm.com>, linux-block@vger.kernel.org
Cc: dm-devel@redhat.com, snitzer@redhat.com, agk@redhat.com
References: <20170628211010.4C8C9124035@b01ledav002.gho.pok.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c91629be-26db-96bb-9a55-18a6861888b2@kernel.dk>
Date: Wed, 28 Jun 2017 15:49:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170628211010.4C8C9124035@b01ledav002.gho.pok.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/28/2017 03:12 PM, Brian King wrote:
> This patch converts the in_flight counter in struct hd_struct from a
> pair of atomics to a pair of percpu counters. This eliminates a couple
> of atomics from the hot path. When running this on a Power system, to
> a single null_blk device with 80 submission queues, irq mode 0, with
> 80 fio jobs, I saw IOPs go from 1.5M IO/s to 11.4 IO/s.

This has been done before, but I've never really liked it. The reason is
that it means that reading the part stat inflight count now has to
iterate over every possible CPU. Did you use partitions in your testing?
How many CPUs were configured? When I last tested this a few years ago
on even a quad core nehalem (which is notoriously shitty for cross-node
latencies), it was a net loss.

I do agree that we should do something about it, and it's one of those
items I've highlighted in talks about blk-mq on pending issues to fix
up. It's just not great as it currently stands, but I don't think per
CPU counters is the right way to fix it, at least not for the inflight
counter.

-- 
Jens Axboe
