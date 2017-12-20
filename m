Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Subject: random call_single_data alignment
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Huang Ying <ying.huang@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <a9beb452-7344-9e2d-fc80-094d8f5a0394@kernel.dk>
Date: Wed, 20 Dec 2017 12:10:32 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

For some reason, commit 966a967116e6 was added to the tree without
CC'ing relevant maintainers, even though it's touching random subsystems.
One example is struct request, a core structure in the block layer.
After this change, struct request grows from 296 to 320 bytes on my
setup.

Why are we blindly aligning to 32 bytes? The comment says to avoid
it spanning two cache lines - but if that's the case, look at the
actual use case and see if that's actually a problem. For struct
request, it is not.

Seems to me, this should have been applied in the specific area
where it was needed. Keep struct call_single_data (instead of some
__ version), and just manually align it where it matters.

-- 
Jens Axboe
