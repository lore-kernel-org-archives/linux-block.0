Return-Path: <axboe@kernel.dk>
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 202sm8885084ioz.84.2018.01.09.10.27.05
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 10:27:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET 0/4] struct request optimizations
Date: Tue,  9 Jan 2018 11:26:58 -0700
Message-Id: <1515522422-21596-1-git-send-email-axboe@kernel.dk>
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

-- 
Jens Axboe
