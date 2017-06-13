Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 0/11] Add support for write life time hints
Date: Tue, 13 Jun 2017 11:15:12 -0600
Message-Id: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

A new iteration of this patchset, previously known as write streams.
Instead of exposing numeric values for streams, I've previously
advocated for just doing a set of hints that makes sense instead. See
the coverage from the LSFMM summit this year:

https://lwn.net/Articles/717755/

This patchset attempts to do that. We define 4 flags for the pwritev2
system call:

RWF_WRITE_LIFE_SHORT	Data written with this flag is expected to have
			a high overwrite rate, or life time.

RWF_WRITE_LIFE_MEDIUM	Longer life time than SHORT

RWF_WRITE_LIFE_LONG	Longer life time than MEDIUM

RWF_WRITE_LIFE_EXTREME	Longer life time than LONG

The idea is that these are relative values, so an application can
use them as they see fit. The underlying device can then place
data appropriately, or be free to ignore the hint. It's just a hint.

Comments appreciated. A branch based on current master can be pulled
from here:

git://git.kernel.dk/linux-block write-stream.1

-- 
Jens Axboe
