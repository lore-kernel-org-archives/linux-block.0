Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: osandov@fb.com,
	bart.vanassche@wdc.com
Subject: [PATCHSET v2 0/4] struct request optimizations
Date: Tue,  9 Jan 2018 17:29:23 -0700
Message-Id: <1515544167-10751-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

With the latest patchset from Tejun, we grew the request structure
a little bit. It's been quite a while since I've taken a look at
the layout of the structure, this patchset is a first attempt at
doing that.

One advantage of Tejun's patchset is that we no longer rely on
the atomic complete flag on blk-mq. We can use that to shuffle
some bits, and reclaim the full atomic_flags field.

Cache optimize the layout of struct request a bit, to group
things a little more logically. Not a huge shuffle, just a few
select members.

We end up doing better in synthetic testing after this, details
in the last patch.

Testing with timeouts on blk-mq and the legacy path work fine,
no regressions introduced.

Changes since v1:
- Add comment on blk_rq_set_deadline() clearing COMPLETE bit.
  Decided to keep it like that after discussing with Omar,
  as it doesn't false convey safety wrt completions atomicity.
- Rearrange a tiny bit more, and move CGROUP stuff to the end
  so that enabling that doesn't screw everything up. Also
  move hole near INTEGRITY, so that if that does get enabled,
  we simply fill the hole.
- Improve layout in mq rq filling.
